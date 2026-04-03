source("PT4.R")

Solve <- function() {
  Task("TablExt9")
  
  K <- Get()
  src_file <- Get()
  data <- GetF(src_file, c("Code", "Len", "Month", "Year"))
  out_file <- Get()
  
  client <- data[data$Code == K, ]
  
  if (nrow(client) == 0) {
    # 直接写入字符串到文件
    writeLines("No data", out_file)
    return()
  }
  
  over15 <- client[client$Len > 15, ]
  all_years <- sort(unique(client$Year))
  
  if (nrow(over15) == 0) {
    result <- data.frame(Count = rep(0, length(all_years)), Year = all_years)
  } else {
    unique_months <- unique(over15[, c("Year", "Month")])
    tbl <- table(unique_months$Year)
    cnt <- integer(length(all_years))
    names(cnt) <- all_years
    cnt[names(tbl)] <- as.integer(tbl)
    result <- data.frame(Count = cnt, Year = all_years)
  }
  
  result <- result[order(-result$Count, result$Year), ]
  result$Count <- as.integer(result$Count)
  
  PutF(result, out_file)
}

Start(Solve)
