# Priority Queues

**Priority queue (PQ, pq)** is a **First-In-Largest-Out** queue. The elements must be **comparable**, which enables priority. Each element is added to the rear of the queue, and the prior element is deleted in the front of the queue. The implementation of priority queue is **Heap**.

!!! list "ADT"
    **Objects:** A finite ordered list with zero or more elements.

    **Operations:**

    - Initialize a priority queue with a set of elements.
    - **Find** the prior element of a priority queue.
    - **Insert** a new element into a priority queue.
    - **Delete** the prior element of a priority queue.


??? note "Comparison"
    Let's first consider some data structure to implement the operations we need above.

    - Array
        - Insertion (Add one element at the end) - $\Theta(1)$.
        - Deletion (Find the prior key, remove and shift array) - $\Theta(n) + O(n)$
    - Linked List
        - Insertion (Add to the front of the list) - $\Theta(1)$
        - Deletion (Find the prior key and remove it) - $\Theta(n) + \Theta(1)$.
    - Ordered Array
        - Insertion (Find the proper position, shift array and add the element) - $O(n) + O(n)$
        - Deletion (Remove the first element) - $\Theta(1)$
    - Ordered Linked List
        - Insertion (Find the proper position and add the element) - $O(n) + \Theta(1)$
        - Deletion (Remove the first element) - $\Theta(1)$
    - BST / AVL tree
        - Both Insertion and Deletion are $O(\log n)$
        - Many operations that we don't need
        - Thus we modify it to a **binary heap**


## Binary Heap 二叉堆

!!! definition
    A binary tree with $n$ nodes and height $h$ is called a **complete binary tree** iff its notes correspond to the nodes numbers from $1$ to $n$ (up to down and left to right) in a perfect binary tree of height $h$.

!!! theorem "Property"
    - A complete binary tree of height $h$ has between $2^h$ and $2^{h + 1} - 1$ nodes, and thus

    $$
        h = \lfloor \log n \rfloor.
    $$

    - A complete binary tree with $n$ nodes can be represented by an **array** with $n + 1$ items. (The zeroth is not used).
        - The array is built by the levelorder of the tree.
        - For any node with index $i$, we have

            $$
            \begin{aligned}
            \text{Parent}(i) &= \left\{
                \begin{aligned}
                    & \lfloor i / 2 \rfloor, & i \ne 1 \\
                    & \text{None}, & i = 1.
                \end{aligned}
            \right.
            \\
            \text{LeftChild}(i) &= \left\{
                \begin{aligned}
                    & 2i, & 2i \le n \\
                    & \text{None}, & 2i > n.
                \end{aligned}
            \right.
            \\
            \text{RightChild}(i) &= \left\{
                \begin{aligned}
                    & 2i + 1, & 2i + 1 \le n \\
                    & \text{None}, & 2i + 1 > n.
                \end{aligned}
            \right.
            \end{aligned}
            $$

    <div align="center">
    	<img src="../Pic/10.svg" style="width:500px"/>
    </div>

!!! Definition
    A **min tree** is a tree in which the key value in each node is *no larger* than the key values in its children (if any).  A **min heap** is a complete binary tree that is also a min tree.

    A **max tree** is a tree in which the key value in each node is *no smaller* than the key values in its children (if any).  A **max heap** is a complete binary tree that is also a max tree.

    Thus **Heap** consists of **max heap** and **min heap**. And a **heap** is a complete binary tree and a max / min tree.

## Implementation

```C title="Data Type"
#define MinData -1
typedef int ElementType;
typedef struct {
    ElementType *element;
    int capacity;
    int size;
} PriorityQueue;
```

**NOTE:** The heap is stored in an **array** since it's a complete binary tree. And `element[0]` is a **sentinel**. If it's a min heap, then `element[0]` must store the smallest value `MinData`.

```C title="Priority Queue"
static void SwapElement(ElementType *a, ElementType *b) {
    ElementType temp = *a;
    *a = *b;
    *b = temp;
}

PriorityQueue *CreateQueue(const int capacity) {
    PriorityQueue *Q = (PriorityQueue *)malloc(sizeof(PriorityQueue));
    Q->capacity = capacity;
    Q->size = 0;
    Q->element = (ElementType *)malloc((Q->capacity + 1) * sizeof(ElementType));
    Q->element[0] = MinData; // Sentinel
    return Q;
}

bool IsEmptyQueue(PriorityQueue *Q) {
    return Q->size == 0;
}

static void PercolateUp(PriorityQueue *Q, int p) {
    while (p >> 1 > 0) {
        int parent = p >> 1;
        if (Q->element[p] < Q->element[parent]) {
            SwapElement(Q->element + p, Q->element + parent);
        } else {
            break;
        }
        p = parent;
    }
}

static void PercolateDown(PriorityQueue *Q, int p) {
    while (p << 1 <= Q->size) {
        int child = p << 1;
        if (child != Q->size && Q->element[child + 1] < Q->element[child]) {
            child ++;
        }
        if (Q->element[p] > Q->element[child]) {
            SwapElement(Q->element + p, Q->element + child);
        } else {
            break;
        }
        p = child;
    }
}

void Insert(PriorityQueue *Q, ElementType x) {
    int p = ++ Q->size;
    Q->element[p] = x;
    PercolateUp(Q, p);
}

ElementType DeleteMin(PriorityQueue *Q) {
    ElementType minElement = Q->element[1];
    Q->element[1] = Q->element[Q->size --];
    PercolateDown(Q, 1);
    return minElement;
}
```

**Time Complexity**

Time complexities of both `Insert` and `DeleteMin` are $O(\log n)$.

## Other Heap Operations

### Build Heap

Suppose now there is an array of data and we want to build a heap based on the data. Instead of creating an empty heap and inserting one by one, we have the following faster implementation.

```C
PriorityQueue *BuildHeap(const int n, const ElementType a[]) {
    PriorityQueue *Q = (PriorityQueue *)malloc(sizeof(PriorityQueue));
    Q->size = Q->capacity = n;
    Q->element = (ElementType *)malloc((Q->size + 1) * sizeof(ElementType));
    memcpy(Q->element + 1, a, Q->size * sizeof(ElementType));

    int pos = 1;
    while (pos << 1 < Q->size) {
        pos << = 1;
    }
    for (int i = pos; i >= 1; i --) {
        PercolateDown(Q, i);
    }

    return Q;
}
```

**Time Complexity**

!!! theorem
    For the perfect binary tree of heigh $h$ containing $2^{h + 1} - 1$ nodes, the sum of the heights of the node is $2^{h + 1} - 1 - (h + 1)$.

Thus the time complexity of building a heap is $O(n)$, which is linear.

### Increase / Decrease Value

Increase or decrease some value `delta` (`delta > 0`) at position `pos` of a heap.

```C
void IncreaseValue(Priority Queue *Q, const int pos, const ElementType delta) {
    assert(delta > 0);
    Q->element[pos] += delta;
    PercolateUp(Q, pos);
}
```

```C
void DecreaseValue(Priority Queue *Q, const int pos, const ElementType delta) {
    assert(delta > 0);
    Q->element[pos] -= delta;
    PercolateDown(Q, pos);
}
```

### Delete

Delete the element at position `pos` of a heap. We just decrease it to the minimum and then delete it.

```C
#define inf 2147483647
void Delete(PriorityQueue *Q, const int pos) {
    DecreaseValue(Q, pos, inf);
    DeleteMin(Q);
}
```

## d-Heap

A d-Heap is a heap like binary heap except that all nodes have $d$ children.

<div align="center">
<figure>
	<img src="../Pic/11.png" style="width:400px"/>
    <figcaption> 3-Heap </figcaption>
</figure>
</div>

!!! note
    - `DeleteMin` will take $d - 1$ comparisons to find the smallest child and thus totally take $O(d \log_d n)$ time.
    - `Insert` will take $O(\log_d n)$ time.
    - If a d-heap is stored as an array, for an entry of index $i$,
        - the parent is at $\lfloor (i + d - 2) / d \rfloor$.
        - the first child is at $(i - 1)d + 2$.
        - the last child is at $id + 1$.

## Leftist Tree / Heap 左偏树

!!! question "Remains"

## Skew Heap 斜堆

!!! question "Remains"

## Binomial Queues 二项队列 / 二项堆

!!! question "Remains"