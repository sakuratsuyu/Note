# Trees

!!! definition 
    A **tree** is a collection of nodes. The collection can be empty; otherwise, a tree consists of
        
    -  a distinguished node $r$, called the **root**.
    - zero or more nonempty **subtrees** $T_1, \dots, T_k$, each of whose roots are connected by a directed **edge** from$r$.

!!! definition
    - **Degree of a node:**	        number of subtrees of the node.
    - **Degree of a tree:**	        maximum among the degrees of all nodes.
    - **Parent:**	                a node that has subtrees.
    - **Children:**	                the roots of the subtrees of parent.
    - **Siblings:**	                children of the same parent.
    - **Leaf (terminal node):**	    a node with degree $0$ (no children).
    - **Path from $n_1$ to $n_k$:**	a unique sequence of nodes $n_1,n_2,\dots,n_k$ such that $n_i$ is the parent of $n_{i+1}$.
    - **Length of path:**	        number of edges on the path.
    - **Ancestor of a node:**       all the nodes along the path from the node up to the root.
    - **Descendants of a node:**    all the nodes in its subtrees.
    - **Depth of $n_k$:**	        length of the unique path from the root to $n_i$.
    - **Height of $n_k$:**	        length of the longest path from $n_i$ to a leaf.
    - **Height / Depth of a tree:** the height of the root or the maximum depth among all leaves.

## Implementation

Consider the following tree.

<div align="center">
	<img src="../Pic/1.png" style="width:300px"/>
</div>

### List Representation

- Array Representation

<div align="center">
	<img src="../Pic/2.png" style="width:400px"/>
</div>

- Linked List Representation

<div align="center">
	<img src="../Pic/3.png" style="width:300px"/>
</div>

### FirstChild-NextSibling Representation

This representation is not unique with different `FirstChild` chosen.

<div align="center" style="height:200px;">
   <img src="../Pic/4.png" style="width:200px; vertical-align:middle;" />
   <img src="../Pic/5.png" style="width:300px; vertical-align:middle;" />
</div>

## Binary Tree

!!! definition
    A **binary tree** is a tree in which no node can have more than two children.

<div align="center">
	<img src="../Pic/6.png" style="width:200px"/>
</div>

Since it has the same structure of FirstChild-NextSibling Representation, thus **all trees can be represented by binary trees**.

!!! theorem "Property"

    - In a binary tree, left child and right child are different.
    - The maximum number of nodes of level $i$ is $2^{i - 1}$. The maximum number of nodes in a binary tree of depth $k$ is $2^k - 1$.
    - $n_0 = n_2 + 1$, where $n_0$ is the number of leaf nodes and $n_2$ is the number of nodes of degreee 2.

```C title="Data Type"
typedef int ElementType;
typedef struct TreeNode {
    ElementType element;
    struct TreeNode *left;
    struct TreeNode *right;
} Tree;
```

### Traversals

The following three types of traversal are implemented by recursion, or alternatively by a stack with iteration.

=== "Preorder Traversal 前序遍历"

    ```C
    void Preorder(Tree *tree) {
        if (tree == NULL) {
            return;
        }

        printf("%d ", tree->element);
        Preorder(tree->left);
        Preorder(tree->right);
    }
    ```


=== "Inorder Traversal 中序遍历"

    ```C
    void Inorder(Tree *tree) {
        if (tree == NULL) {
            return;
        }

        Inorder(tree->left);
        printf("%d ", tree->element);
        Inorder(tree->right);
    }
    ```

=== "Postorder Traversal 后序遍历"

    ```C
    void Postorder(Tree *tree) {
        if (tree == NULL) {
            return;
        }

        Postorder(tree->left);
        Postorder(tree->right);
        printf("%d ", tree->element);
    }
    ```

**Levelorder Traversal 层序遍历 / 宽度优先遍历**

Levelorder traversal are implemented by a queue.

```C
void Levelorder(Tree *tree) {
    Enqueue(queue, tree);
    while (!IsEmptyQueue(queue)) {
        Tree *cur = Dequeue(queue);
        printf("%d ", cur->element);
        Enqueue(queue, cur->left);
        Enqueue(queue, cur->right);
    }
}
```

### Threaded Binary Trees

There are $n + 1$ `NULL` children of the leaf nodes of a binarty tree with $n$ nodes. We want to make these `NULL` pointers more useful. And here comes the **Threaded Binary Trees**.

```C title="Data Type"
typedef int ElementType;
typedef struct ThreadedTreeNode {
    ElementType element;
    struct ThreadedTreeNode *left;
    struct ThreadedTreeNode *right;
    bool leftThread;    // `true` to indicate `left` is a thread instead of a child pointer.
    bool rightThread;   // `true` to indicate `right` is a thread instead of a child pointer.
} ThreadedTree;
```

!!! theorem "Rule for Threaded Binary Trees"
    **Rule 1:** If `tree->left == NULL`, then replace it with a pointer to its **inorder predecessor**.

    **Rule 2:** If `tree->right == NULL`, then replace it with a pointer to its **inorder sucessor**.

    **Rule 3:** A threaded binary tree must have a **head node** of which the left child points to the first node.

??? example
    The following is the infix syntax tree of 

    $$
        A + B * C / D.
    $$

    <div align="center" style="height:300px;">
       <img src="../Pic/7.png" style="height:200px; vertical-align:middle;" />
       <img src="../Pic/8.png" style="height:300px; vertical-align:middle;" />
    </div>

## Binary Search Tree (BST)

!!! definition
    A **binary search tree** is a *binary tree*. It may be empty. If it is not empty, it satisfies the following properties:
    
    - Every node has a key which is an integer, and the keys are **distinct**.
    - The keys in a nonempty **left** subtree must be **smaller** than the key in the root of the subtree.
    - The keys in a nonempty **right** subtree must be **larger** than the key in the root of the subtree.
    - The left and right subtrees are also binary search trees.


!!! list "ADT"
    **Objects:** A finite ordered list with zero or more elements.

    **Operations:**

    - Make an empty BST.
    - **Find** a key in a BST.
    - **Find** the **minimum** key in a BST.
    - **Find** the **maximum** key in a BST.
    - **Insert** a key to a BST.
    - **Delete** a key in a BST.

!!! code "BST"

    ```C
    Tree *Find(Tree *tree, const ElementType element) {
        if (tree == NULL) {
            return NULL;
        }
        if (element == tree->element) {
            return tree;
        }
        return Find(tree, elemet < tree->element ? tree->left : tree->right);
    }

    Tree *FindMin(Tree *tree) {
        if (tree == NULL) {
            return NULL;
        }
        return tree->left == NULL ? tree : FindMin(tree->left);
    }

    Tree *FindMax(Tree *tree) {
        if (tree == NULL) {
            return NULL;
        }
        return tree->right == NULL ? tree : FindMax(tree->right);
    }

    Tree *Insert(Tree *tree, const ElementType element) {
        if (tree == NULL) {
            tree = (TreeNode *)malloc(sizeof(TreeNode));
            tree->element = element;
            tree->left = tree->right = NULL;
        } else {
            if (element < tree->element) {
                tree->left = Insert(tree->left, element);
            } else {
                tree->right = Insert(tree->right, element);
            }
        }
        return tree;
    }

    Tree *Delete(Tree *tree, const ElementType element) {
        if (tree == NULL) {
            // Warning: Element not found.
            return NULL;
        }
        if (element == tree->element) {
            if (tree->left != NULL && tree->right != NULL) {
                TreeNode *temp = FindMin(tree->right); // (1)!
                tree->element = temp->element;
                tree->right = Delete(tree->right, temp->element);
            } else {
                TreeNode *temp = tree;
                tree = tree->left != NULL ? tree->left : tree->right;
                free(temp);
            }
        }
        if (element < tree->element) {
            tree->left = Delete(tree->left, element);
        } else {
            tree->right = Delete(tree->right, element);
        }
    }
    ```

    1. Here it's replaced with the **smallest** node in the right subtree. Or alternatively it can be replaced with the **largest** node in the left subtree.

### Time Complexity

The average complexities of all operations are $O(d)$, where $d$ is the depth of the target node. The average depth over all nodes in a tree is $O(\log N)$.

But for the worst cases, when building a tree by inserting a set of oredered elements, it will degenerate to linear list with $O(N)$ complexity of each operation.
    
## AVL Tree

!!! question "Remains"

## Splay Tree

!!! question "Remains"

## B-Tree

!!! question "Remains"