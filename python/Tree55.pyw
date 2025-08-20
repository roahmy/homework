from pt4 import *
#给出一个指向双链接树的非根节点的指针P1。 
#如果节点P1具有兄弟节点，则从树中移除该兄弟节点及其所有后代，并释放为移除的节点分配的内存，
#如果节点P1没有兄弟节点，则将其及其所有后代创建为具有根p1的子树的副本。 
#将指针P0输出到p1的父级。
# Gives a pointer P1 to the non-root node of the double-linked tree. 
# If node P1 has a sibling node, the sibling node and all its descendants are removed from the tree, 
# and the memory allocated for the removed node is released. 
# If node P1 does not have a sibling node, 
# it and all its descendants are created as a copy of the subtree with root p1. 
# Outputs the pointer P0 to the parent of p1.

def rsister(p1,p2,right,prt):
    if p1!=None:
        p2=Node()
        p2.Data=p1.Data
        p2.Left=None
        p2.Right=None
        p2.Parent=prt
        if right:
            prt.Right=p2
        else:
            prt.Left=p2
        rsister(p1.Left,p2.Left,False,p2)
        rsister(p1.Right,p2.Right,True,p2)

def sister(p):
    if p!=None:
        sister(p.Left)
        sister(p.Right)
        p.dispose()

def solve():
    task("Tree55")
    p=get()
    par=p.Parent
    if par.Left!=None and par.Right!=None:
        if par.Right==p:
            sister(par.Left)
            par.Left=None
        else:
            sister(par.Right)
            par.Right=None
    else:
        if par.Right==p:
            rsister(p,par.Left,False,par)
        else:
            rsister(p,par.Right,True,par)
    put(par)




start(solve)