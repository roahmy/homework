from pt4 import *
#An even integer N (> 0) and a sequence of N integers are given. 
# Create a tree with N nodes; 
# left child nodes of the tree should be leaves, right child nodes should be internal ones.
#  For each internal node create a left child at first, then create a right one (if it exists). 
# Assign values of the given sequence to tree nodes in order of their creation. Output the address of the tree root.
def solve():
    task("Tree28")
    n = get()
    p = Node()
    put(p)
    while n > 0:
        pl = Node()
        p.Data, pl.Data = get2()
        p.Left = pl
        if n != 2:
            pr = Node()
            p.Right = pr
            p = pr
        n -= 2




start(solve)