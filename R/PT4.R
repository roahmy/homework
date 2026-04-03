# ------------------------------------------------- #
#  Programming Taskbook 4.25 module for R language  #
#                                                   #
#                 Copyright (C) M.E.Abramyan, 2025  #
# ------------------------------------------------- #
#  WARNING! Altering the contents of this file      #
#  may cause Programming Taskbook to malfunction.   #
# ------------------------------------------------- #

options(warn=-1)
pt4 <- new.env()

pt4$catln <- function(...) cat(..., '\n') 

pt4$precision = 2
pt4$width = 0
pt4$widthdf = rep(0, 100)
pt4$quote = FALSE
pt4$linebreak = FALSE
pt4$nodes = list()
pt4$a_wait = 0L
pt4$node_info = ""

NodeProperties = function() {
  if (pt4$node_info != "")
    stop(pt4$node_info)
}

print.Node = function(node) {
  if (!node[["disposed"]]) {
    cat("Node: $Data =", node$Data, "\n")
  } else {
    cat("Node: disposed\n")
  }
}

Node = function(Data = 0L, Next = NULL, Prev = NULL) {
  if (pt4$a_wait == 0L) {
  if (is.numeric(Data) && round(Data) == Data) {
    Data = as.integer(Data[1])
  } else
    stop("wrong Data parameter: ", Data)
  pNext = 0L
  if (length(class(Next)) == 1 && class(Next) == "Node") {  
    pNext = Next[["index"]] 
  } else if (!is.null(Next))
    stop("wrong Next parameter: ", Next) 
  pPrev = 0L
  if (length(class(Prev)) == 1 && class(Prev) == "Node") {  
    pPrev = Prev[["index"]] 
  } else if (!is.null(Prev))
    stop("wrong Prev parameter: ", Prev) 
  a = 0L
  out = .C('nodenew_r', x = as.integer(a), as.integer(Data),
           as.integer(pNext), as.integer(pPrev),
           as.integer(0), as.integer(0), as.integer(0))
  res = list(index = out$x, disposed = FALSE)
  } else {
    res = list(index = pt4$a_wait, disposed = FALSE) 
    pt4$a_wait = 0L
  }
  class(res) = "Node"
  pt4$nodes[[res[["index"]]]] = res 
  res
}

pt4$checknodes = function(ind) {
  ind > 0 && ind <= length(pt4$nodes) && 
    length(class(pt4$nodes[[ind]])) == 1 && 
    class(pt4$nodes[[ind]]) == "Node"
}

pt4$getDataProp = function(node) {
  if (pt4$nodes[[node[["index"]]]][["disposed"]]){
    pt4$node_info = "$Data: cannot access a disposed Node"
    NodeProperties()
  }
  val = 0L
  err = 0L
  out = .C('nodegetf_r', as.integer(node[["index"]]),
           0,
           xval = as.integer(val), 
           xerr = as.integer(err))
  if (out$xerr != 0L) {
    pt4$node_info = "cannot get the $Data property"
    NodeProperties()
  }
  out$xval
}

pt4$setDataProp = function(node, val) {
  if (pt4$nodes[[node[["index"]]]][["disposed"]]) {
    pt4$node_info = "$Data: cannot access a disposed Node"
    NodeProperties()
  }
  if (is.numeric(val) && round(val) == val) {
    val = as.integer(val[1])
  } else {
    pt4$node_info = "wrong value for the $Data property"
    NodeProperties()
  }
  err = 0L
  out = .C('nodesetf_r', as.integer(node[["index"]]),
           0, as.integer(val), xerr = as.integer(err))
  if (out$xerr != 0L) {
    pt4$node_info = "cannot set the $Data property"
    NodeProperties()
  }
}

pt4$getNodeProp = function(node, n, name) {
  if (pt4$nodes[[node[["index"]]]][["disposed"]]){
    pt4$node_info = paste0(name, ": cannot access a disposed Node")
    NodeProperties()
  }
  val = 0L
  err = 0L
  out = .C('nodegetf_r', as.integer(node[["index"]]),
           as.integer(n),
           xval = as.integer(val), 
           xerr = as.integer(err))
  if (out$xerr != 0L) {
    pt4$node_info = paste0("cannot get the ", 
                           name, " property")
    NodeProperties()
  }
  p = out$xval
  if (p == 0) {
    res = NULL
  } else if (pt4$checknodes(p)) {
    res = pt4$nodes[[p]]
  } else {
    pt4$a_wait = p
    res = Node()
  }
  res
}

pt4$setNodeProp = function(node, n, val, name) {
  if (pt4$nodes[[node[["index"]]]][["disposed"]]){
    pt4$node_info = paste0(name, ": cannot access a disposed Node")
    NodeProperties()
  }
  if (!is.null(val) && 
      (length(class(val)) != 1 || class(val) != "Node")) {
    pt4$node_info = paste0("wrong value for the ", 
                           name, " property")
    NodeProperties()
  }
  err = 0L
  if (is.null(val)) {
    out = .C('nodesetf_r', as.integer(node[["index"]]),
             as.integer(n),
             as.integer(0L), 
             xerr = as.integer(err))
  } else {
    out = .C('nodesetf_r', as.integer(node[["index"]]),
             as.integer(n),
             as.integer(val[["index"]]), 
             xerr = as.integer(err))
  }
  if (out$xerr != 0L) {
    pt4$node_info = paste0("cannot set the ", 
                           name, " property")
    NodeProperties()
  }
  NULL
}

"$.Node" = function(node, prop) {
  if (prop == "Data") {
    res = pt4$getDataProp(node)
  } else if (prop == "Next") {
    res = pt4$getNodeProp(node, 1, "$Next")
  } else if (prop == "Prev") {
    res = pt4$getNodeProp(node, 2, "$Prev")
  } else if (prop == "Left") {
    res = pt4$getNodeProp(node, 3, "$Left")
  } else if (prop == "Right") {
    res = pt4$getNodeProp(node, 4, "$Right")
  } else if (prop == "Parent") {
    res = pt4$getNodeProp(node, 5, "$Parent")
  } else {
    stop("wrong poperty name: ", prop) 
  }
}  

"$<-.Node" = function(node, prop, value) {
  if (prop == "Data") {
    pt4$setDataProp(node, value)
  } else if (prop == "Next") {
    pt4$setNodeProp(node, 1, value, "$Next")
  } else if (prop == "Prev") {
    pt4$setNodeProp(node, 2, value, "$Prev")
  } else if (prop == "Left") {
    pt4$setNodeProp(node, 3, value, "$Left")
  } else if (prop == "Right") {
    pt4$setNodeProp(node, 4, value, "$Right")
  } else if (prop == "Parent") {
    pt4$setNodeProp(node, 5, value, "$Parent")
  } else {
    stop("wrong poperty name: ", prop) 
  }
  node
}  

Dispose = function(node) {
  if (length(class(node)) != 1 || class(node) != "Node")
    stop("parameter must be a Node instance")
  ind = node[["index"]]
  if (!pt4$nodes[[ind]][["disposed"]]) {
    err = 0L
    out <- .C('nodedispose_r', ind, 
              x = as.integer(err))
    if (out$x != 0L)
      stop("cannot dispose the Node instance")
    pt4$nodes[[ind]][["disposed"]] = TRUE
  }
}

Node.ForTree = function(Data = 0L, Left = NULL, Right = NULL, Parent = NULL) {
  res = Node(Data)
  res$Left = Left;
  res$Right = Right;
  res$Parent = Parent;
  res
}

Task <- function(name = "") {
  if (name == "" || !is.character(name)){
    return(NULL)
  }
  .C('task_r', as.character(name))
  NULL
}

pt4$getr <- function() {
  n = 0.0;
  out <- .C('getr_r', x = as.double(n))
  out$x
}

pt4$getb <- function() {
  n = 0;
  out <- .C('getb_r', x = as.integer(n))
  out$x != 0 
}

pt4$getn <- function() {
  n = 0;
  out <- .C('getn_r', x = as.integer(n))
  out$x
}

pt4$gets <- function() {
  s = format('', width = 200)
  out <- .C('gets_r', x = as.character(s))
  out$x 
}

pt4$getnode <- function() {
  n = 0L
  out <- .C('nodegetp_r', x = as.integer(n))
  if (out$x == 0L) {
    res = NULL
  } else if (pt4$checknodes(out$x)) {
    res = pt4$nodes[[out$x]]
  } else {
    pt4$a_wait = out$x
    res = Node()
  }
  res
}

Get <- function() {
  n = 0
  out <- .C('nextdatatype_r', res = as.integer(n))
  if (out$res == 0) {
    pt4$getn()
  } else if (out$res == 1) {
    pt4$getr()
  } else if (out$res == 2) {
    pt4$getb()
  } else if (out$res == 5) {
    pt4$getnode()
  } else 
    pt4$gets()
} 

GetV <- function(len = 0) {
  if (len == 0)
    len = Get()
  if (is.numeric(len) && round(len) == len)
    len = as.integer(len)
  if (!is.integer(len) || len < 1) {
    stop("wrong vector size: ", len)
    return(NULL)
  }
  x = Get()
  res = NA
  if (is.logical(x)) {
    res = logical(len)
    res[1] = as.logical(x)
  } else if (is.integer(x)) {
    res = integer(len)
    res[1] = as.integer(x)
  } else if (is.double(x)) {
    res = double(len)
    res[1] = as.double(x)
  } else if (is.character(x)) {
    res = character(len)
    res[1] = as.character(x)
  }
  for (i in 2:len)
    res[i] = Get()
  res
}

GetM <- function(nrow = 0, ncol = 0) {
  if (nrow == 0 && ncol == 0) {
    nrow = Get()
    ncol = Get()
  } else if (ncol == 0) {
    ncol = nrow
  } else if (nrow == 0) {
    nrow = ncol
  }
  if (is.numeric(nrow) && round(nrow) == nrow)
    nrow = as.integer(nrow)
  if (is.numeric(ncol) && round(ncol) == ncol)
    ncol = as.integer(ncol)
  if (!is.integer(nrow) || nrow < 0) {
    stop("wrong matrix nrow size: ", nrow)
  }
  if (!is.integer(ncol) || ncol < 0) {
    stop("wrong matrix ncol size: ", ncol)
  }
  x = Get()
  res = matrix(x, nrow, ncol)
  for (i in 1:nrow)
    for (j in 1:ncol)
      if (i + j > 2)
       res[i,j] = Get()
  res
}

Put <- function(...) {
  for (x in list(...)) {
    if (is.null(x)) {
      .C('nodeputp_r', as.integer(0L))
    } else if (length(class(x)) == 1 && class(x) == "Node") {
      .C('nodeputp_r', as.integer(x[["index"]]))
    } else if (is.matrix(x)) {
      for (i in 1:dim(x)[1])
        Put(x[i,])
    } else if (is.vector(x)) {
      if (length(x) > 1) {
        for (i in 1:length(x))
          Put(x[i])
      } else if (length(x) == 1)
      {
        if (is.na(x[1])) 
          stop("attempt to output NA")
        if (is.numeric(x) && !is.finite(x[1])) 
          stop("attempt to output an infinite number")
        if (is.integer(x)) {
          .C('putn_r', as.integer(x))
        } else if (is.double(x)) {
          .C('putr_r', as.double(x))
        } else if (is.logical(x)) {
          n = if (as.logical(x)) 1 else 0
          .C('putb_r', as.integer(n))
        } else if (is.character(x))
          .C('puts_r', as.character(x))
      }
    } else if (is.array(x)) {
      Put(as.vector(x))
    } else if (is.factor(x)) {
      Put(as.vector(x))
    } else if (is.data.frame(x)) {
      x = as.data.frame(x)
      if (nrow(x) > 0 && ncol(x) > 0)
        for (i in 1:nrow(x))
          for (j in 1:ncol(x))
            Put(x[i,j])
    } else if (is.list(x)){
      if (length(x) > 0)
        for (i in 1:length(x))
          Put(x[i])
    }
  }
  NULL
}      
      
pt4$show_raw <- function(s) {
  .C('show_r', as.character(s))
}  

pt4$strlen <- function(s) {
  res = ""
  if (length(s) > 0 && !is.na(s)) {
    if (is.integer(s)) {
      res = format(s)
    } else if (is.double(s)) {
      if (pt4$precision >= 0) {
        res = format(round(s, digits = pt4$precision), 
                     scientific = FALSE, 
                     nsmall = pt4$precision)
      } else
        res = formatC(s, format = 'E', 
                     digits = -pt4$precision)
    } else if (is.character(s)) {
      res = format(paste0('"', gsub('\n', '\\\\n', s), '"'))
    } else
      res = format(as.character(s))
  } else if (is.na(s))
    res = 'NA'
  nchar(res)
}

pt4$maxstrlen <- function(v) 
  max(sapply(v, pt4$strlen))       

pt4$show_str <- function(s, w, q, j = "left") {
  if (length(s) > 0 && !is.na(s)) {
    if (is.integer(s)) {
      res = format(s, width = w)
    } else if (is.double(s)) {
      if (pt4$precision >= 0) {
        res = format(round(s, digits = pt4$precision), 
                     width = w, scientific = FALSE, 
                     nsmall = pt4$precision)
      } else
        res = formatC(s, width = w, format = 'E', 
                     digits = -pt4$precision)
    } else if (is.logical(s)) {
      res = format(s, width = w, justify = "right")
    } else if (is.character(s) && q) {
      res = format(paste0('"', gsub('\n', '\\\\n', s), '"'),
                   width = w, justify = j)
    } else
      res = format(as.character(s), width = w, justify = j)
    pt4$show_raw(res)
  } else if (is.na(s))
    pt4$show_raw(format('NA', width = w, justify = "left"))
  NULL
}

pt4$nchar1 <- function(s) {
  res = 0
  if (!is.na(s)) 
    res = nchar(s)
  res
}

Show <- function(...) {
  res = NULL
  for (x in list(...))
  { 
    if (is.null(res))
      res = x
    if (is.null(x))
    {
      pt4$show_raw('NULL')
      pt4$linebreak = FALSE
    } else if (length(class(x)) == 1 && class(x) == "Node") {
      pt4$show_raw('{ Node')
      if (x[["disposed"]]) {
        pt4$show_raw("disposed")
      } else {
        pt4$show_raw(x$Data)
      }
      pt4$show_raw('}')
      pt4$linebreak = FALSE
    } else if (length(x) == 0) {
      pt4$show_raw('[ ]')
      pt4$linebreak = FALSE
    } else if (is.data.frame(x))
    {
      x = as.data.frame(x)
      ww = rep(1, ncol(x))
      rn = as.character(1:nrow(x))
      if (!is.null(rownames(x))) {
        rn = rownames(x)
      }
      wrn = max(max(sapply(rn, pt4$nchar1)), 3)
      if (!is.null(names(x)))
        ww = sapply(names(x), pt4$nchar1) + 1
      if (nrow(x) > 0) {
        ww2 = sapply(x, pt4$maxstrlen)
        ww = pmax(ww, ww2)
      }
      if (!pt4$linebreak)
        pt4$show_raw('\n')
      pt4$show_raw(paste('{', strrep(" ", wrn-2)))
      if (!is.null(names(x))) {
        for (j in 1:ncol(x)){
          pt4$show_str(ifelse(is.na(names(x)[j]), '$', paste0('$', names(x)[j])), 
                       max(ww[j], pt4$widthdf[j]), FALSE, 
                       ifelse(nrow(x)>0 && (is.numeric(x[1,j]) || is.logical(x[1,j])), 
                              "right", "left"))
        }
      }
      pt4$show_raw('\n')
      if (nrow(x) > 0)
      for (i in 1:nrow(x)){
        # pt4$show_raw(' "')
        pt4$show_str(rn[i], wrn, FALSE, "right")
        # pt4$show_raw('" ')
        for (j in 1:ncol(x))
          pt4$show_str(x[i,j], max(ww[j], pt4$widthdf[j]), TRUE)
        pt4$show_raw('\n')
      }  
      pt4$show_raw('}\n')
      pt4$linebreak = TRUE
    } else if (is.list(x) && is.null(dimnames(x))) {
      pt4$show_raw('{ list')
      for (i in 1:length(x)){
        pt4$linebreak = FALSE
        pt4$show_raw(paste0('$', ifelse(is.na(names(x)[i]), '', names(x)[i]), ':'))
        ShowS(x[[i]])
      }  
      pt4$show_raw('}')
      pt4$linebreak = FALSE
    } else if (is.list(x)) {
      if (!pt4$linebreak)
        pt4$show_raw('\n')
      pt4$show_raw('{ list ( dim:')
      Show(dim(x))
      pt4$show_raw(')')
      q = pt4$quote
      if (!is.null(attr(x, "dimnames")))
      {
        pt4$show_raw('\n')
        for (i in 1:length(dim(x))) {
          pt4$show_raw('dimnames[[')
          pt4$show_str(i, 0, FALSE)
          pt4$show_raw(']]:')
          Show(dimnames(x)[[i]])
          pt4$show_raw('\n')
        }
      }
      for (i in 1:length(x)){
        pt4$linebreak = FALSE
        pt4$show_raw(paste0('$', ifelse(is.na(names(x)[i]), '', names(x)[i]), ':'))
        ShowS(x[[i]])
      }  
      pt4$show_raw('}\n')
      pt4$linebreak = TRUE
    } else if (is.matrix(x) && is.null(dimnames(x))) {
      w1 = max(sapply(x, pt4$maxstrlen))
      w0 = pt4$width;
      pt4$width = max(w0, w1) 
      if (!pt4$linebreak)
        pt4$show_raw('\n')
      for (i in 1:dim(x)[1]){
        pt4$show_raw(if (i == 1) '[' else ' ')
        ShowLine(x[i,])
      }
      pt4$width = w0
      pt4$show_raw(']\n')
      pt4$linebreak = TRUE
    } else if (is.vector(x)) {
      len = length(x)
      if (len > 1) {
        pt4$show_raw('[')
        q = TRUE
      } else
        q = pt4$quote
      for (i in 1:length(x))
        pt4$show_str(x[i], pt4$width, q)
      if (len > 1) {
        pt4$show_raw(']')
      }
      pt4$linebreak = FALSE
    } else if (is.array(x)) {
      if (!pt4$linebreak)
        pt4$show_raw('\n')
      pt4$show_raw('[ array ( dim:')
      Show(dim(x))
      pt4$show_raw(')')
      if (!is.null(attr(x, "dimnames")))
      {
        pt4$show_raw('\n')
        for (i in 1:length(dim(x))) {
          pt4$show_raw('dimnames[[')
          pt4$show_str(i, 0, FALSE)
          pt4$show_raw(']]:')
          Show(dimnames(x)[[i]])
          pt4$show_raw('\n')
        }
      }
      for (i in 1:length(x))
        pt4$show_str(x[i], pt4$width, TRUE)
      pt4$show_raw(']\n')
      pt4$linebreak = TRUE
    } else if (is.factor(x)) {
      if (is.ordered(x)){
        pt4$show_raw('[ ordered factor ( levels:')
      } else {
        pt4$show_raw('[ factor ( levels:')
      }
      for (i in 1:length(levels(x)))
        pt4$show_str(levels(x)[i], 0, FALSE)
      pt4$show_raw(')')
      for (i in 1:length(x))
        pt4$show_str(x[i], pt4$width, q)
      pt4$show_raw(']')
      pt4$linebreak = FALSE
    }      
  }
  res
}

ShowS <- function(...) {
  pt4$quote = TRUE
  res = Show(...)
  pt4$quote = FALSE
  res
}


ShowLine <- function(...) {
  res = Show(...)
  if (!pt4$linebreak)
    pt4$show_raw('\n')
  pt4$linebreak = TRUE
  res
}

ShowLineS <- function(...) {
  pt4$quote = TRUE
  res = ShowLine(...)
  pt4$quote = FALSE
  res
}


pt4$check <- function() {
  s = format('', width = 600);
  n1 = 0
  n2 = 0
  out1 <- .C('checkpt_r', arg1 = as.character(s), arg2 = as.integer(n1))
  out2 <- .C('finishpt_r', res = as.integer(n2))
  if (out2$res == 1)
    pt4$catln(out1$arg1)
  .C('freept')
  out2$res
}

 
Start <- function(Solve) {
  dllname = paste0(Sys.getenv("WINDIR"), "\\xpt4.dll")
  dyn.load(dllname)
  for (i in 1:10) {
    .C('startpt_r', as.integer(134217728))
    errors = TRUE
    pt4$precision = 2
    pt4$width = 0
    pt4$quote = FALSE
    errmes = try({ 
      Solve()
      errors = FALSE
      }, silent = TRUE)
    if (errors) {
      err = ""
      errmes = gsub('\n', '', errmes)
      .C('raisept_r', as.character(err), as.character(errmes))      
    }  
    if (pt4$check() == 1) break
  }
  dyn.unload(dllname) 
  NULL
}

SetPrecision <- function(d) {
  if (is.numeric(d) && round(d) == d) {
    if (d < -16 || d > 16) {
      stop("wrong precision value: ", d, ' (not in range -16..16)')
    } else
      pt4$precision = as.integer(d)
  } else
    stop("wrong precision value: ", d, " of type ", typeof(d))
  NULL
}

SetP <- function(x, d) { # manipulator for %>%
  SetPrecision(d)
  x
}

SetWidth <- function(w) {
  if (is.numeric(w) && round(w) == w) {
    if (w < 0 || w > 100) {
      stop("wrong width value: ", w, ' (not in range 0..100)')
    } else    
      pt4$width = as.integer(w)
  } else
    stop("wrong width value: ", w, " of type ", typeof(w))
  NULL
}

SetW <- function(x, w){ # manipulator for %>%
  SetWidth(w)
  x
}

SetWidthDF <- function(...) {
  vecw = list(...)
  cnt = 0
  if (length(vecw) > 0) 
    for (i in 1:length(vecw)) {
      ww = vecw[[i]]
      if (length(ww) > 0) 
        for (j in 1:length(ww)) {
          w = ww[j]
          if (is.numeric(w) && round(w) == w) {
            if (w < 0 || w > 100) {
              stop("wrong width value: ", w, ' (not in range 0..100)')
            } else {    
              cnt = cnt + 1
              pt4$widthdf[cnt] = as.integer(w)
            }
          } else
           stop("wrong width value: ", w, " of type ", typeof(w))
      }
    }
  NULL
}

SetWDF <- function(x, ...) { # manipulator for %>%
  SetWidthDF(...)
  x
}

HideTask <- function() {
  .C('hidetask')      
  NULL
}

GetF <- function(filename, colnames, combine = 0) {
  d = read.table(filename, sep = ' ', header = FALSE)
  if (combine > 0) {
    d[[combine]] = paste(d[[combine]], d[[combine + 1]], sep = ' ')
    d[[combine + 1]] = NULL
  }
  names(d) = colnames
  d
}

PutF <- function(dataframe, filename) {
  if (is.null(dataframe)) {
    stop("attempt to output NULL")
  } else if (is.data.frame(dataframe)) {
    dataframe = as.data.frame(dataframe)
    for (j in 1:ncol(dataframe))
    if (is.double(dataframe[1,j]))
      dataframe[[j]] = format(round(dataframe[[j]], digits = 2), 
        scientific = FALSE, nsmall = 2, trim = TRUE)
  write.table(dataframe, file = filename, sep = ' ', 
    quote = FALSE, col.names = FALSE, row.names = FALSE)
  } else
    stop("parameter is not a data.frame")
  NULL
}

GetCountries <- function() {
  N = vector()
  C = vector()
  W = vector()
  P = vector()
  for (i in 1:196) {
    N[i] = Get()
    C[i] = Get()
    W[i] = Get()
    P[i] = Get()
  }
  data.frame(Name = N, Capital = C, WorldPart = W, Population = P)
}

GetStudents <- function() {
  N = vector()
  G = vector()
  H = vector()
  C = vector()
  D = vector()
  for (i in 1:53) {
    N[i] = Get()
    G[i] = Get()
    H[i] = Get()
    C[i] = Get()
    D[i] = Get()
  }
  G = factor(G)
  data.frame(Name = N, Gender = G, Height = H, Class = C, DevClub = D)
}

PutN <- function(dataframe) {
  Put(nrow(dataframe), dataframe)
}