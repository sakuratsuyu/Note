### Lists, Stacks and Queues

!!! definition
    **Data type** consists of *objects* and *operations*.

    An **Abstract Data Type (ADT)** is a data type that is organized in such a way that

    - the *specification* on the objects are separated from the *representation* of the objects.
    - the *specification* of the operations on the objects are separated from the *implementation* on the operations

## List (Linear List)

!!! list "ADT"
    **Objects**: (item~0~, item~1~, ..., item~N~~-~~1~)

    **Operations**
    
    - Make an empty list.
    - Check whether it's an empty list.
    - Print all the items in a list.
    - Get the length of a list.
    - **Find** the *k*-th item from a list.
    - **Insert** a new item at position *k* of a list.
    - **Delete** an item at position *k* from a list.
    - Find the next item of the current item from a list.
    - Find the previous item of the current item from a list.

Following are some implementations of list.

### Array / Sequential List

We say it a *sequential mapping* or *sequantial storage structure*.

```C title="Data Type"
typedef int ElementType;
typedef struct {
   ElementType *array;
   int capacity;
   int size; 
} List;
```

??? code "Array / Sequential List"

    ```C
    List *CreateList(const int capacity) {
        List *list = (List *)malloc(sizeof(List));
        list->capacity = capacity;
        list->size = 0;
        list->array = (ElementType *)malloc(list->capacity * sizeof(ElementType));
        return list;
    }

    void FreeList(List *list) {
        free(list->array);
        free(list);
    }

    void PrintList(const List *list) {
        for (int i = 0; i < list->size; i ++) {
            printf("%d ", list->array[i]);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        return list->array[position];
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));
        list->size ++;
        for (int i = list->size; i > position; i --) {
            list->array[i] = list->array[i - 1];
        }
        list->array[position] = element;
    }

    void Delete(List *list, const int position) {
        assert(0 <= position && postion < list->size && list->size > 0);
        list->size --;
        for (int i = position; i < size; i ++ ) {
            list->array[i] = list->array[i + 1];
        }
    }
    ```

#### Pros

- Finding takes $O(1)$ time.

#### Cons

- Maximum size is limited, or overestimated.
- Insertion and deletion take $O(N)$ time with plenty of data movements.

### Linked List

We say it a *linked storage structure*.

```C title="Data Type"
typedef int ElementType;
typedef struct _node {
    ElementType element;
    struct _node *next;
} Node;
typedef struct {
    Node *head;
    int capacity;
    int size;
} List;
```

??? code "Linked List without Sentinel"

    ```C
    List *CreateList(const int capacity) {
        List *list = (List *)malloc(sizeof(List));
        list->capacity = capacity;
        list->size = 0;
        list->head = NULL;
        return list;
    }

    void FreeList(List *list) {
        for (Node *p = list->head, *temp = NULL; p != NULL;) {
            temp = p;
            p = p->next;
            free(temp);
        }
        free(list);
    }

    void PrintList(const List *list) {
        for (Node *p = list->head; p != NULL; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        Node *p = list->head;
        for (int i = 0; i < position; i ++, p = p->next);
        return p->element;
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = NULL;

        list->size ++;
        if (position == 0) {
            p->next = list->head;
            list->head = p; 
        } else {
            Node *q = list->head;
            for (int i = 0; i < position - 1; i ++, q = q->next);
            p->next = q->next;
            q->next = p;
        }
    }

    void Delete(List *list, const int position) {
        assert(0 <= position && postion < list->size && list->size > 0);
        list->size --;
        Node *temp = NULL;
        if (position == 0) {
            temp = list->head;
            list->head = list->head->next;
            free(temp);
        } else {
            Node *q = list->head;
            for (int i = 0; i < position - 1; i ++, q = q->next);
            temp = q->next;
            q->next = temp->next;
            free(temp);
        }
    }
    ```

From the implementation, we find it complicated for the special judge of `position = 0`. Thus, we add a **dummy node**, or say **sentinel (哨兵)** to simplify the implementation.

??? code "Linked List with Sentinel"

    ```C hl_lines="5 6 7 50 51 52 53 60 61 62 63 64"
    List *CreateList(const int capacity) {
        List *list = (List *)malloc(sizeof(List));
        list->capacity = capacity;
        list->size = 0;
        list->head = (Node *)malloc(sizeof(Node)); // (1)!
        list->head->element = 0;
        list->head->next = NULL;
        return list;
    }

    void FreeList(List *list) {
        for (Node *p = list->head->next, *temp = NULL; p != NULL;) {
            temp = p;
            p = p->next;
            free(temp);
        }
        free(list->head);
        free(list);
    }

    void PrintList(const List *list) {
        for (Node *p = list->head->next; p != NULL; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        Node *p = list->head->next;
        for (int i = 0; i < position; i ++, p = p->next);
        return p->element;
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = NULL;

        list->size ++;
        Node *q = list->head;
        for (int i = 0; i < position; i ++, q = q->next);
        p->next = q->next;
        q->next = p;
    }

    void Delete(List *list, const int position) {
        assert(0 <= position && postion < list->size && list->size > 0);
        list->size --;
        Node *temp = NULL;
        Node *q = list->head;
        for (int i = 0; i < position; i ++, q = q->next);
        temp = q->next;
        q->next = temp->next;
        free(temp);
    }
    ```

    1. Dummy Node, or say Sentinel 哨兵

#### Pros

- No limited size (In the implementation above, `capacity = -1` means unlimited capacity).
- Insertion and deletion take $O(1)$ time.

#### Cons

- Finding takes $O(N)$ time.

### Doubly Linked List

```C title="Data Type"
typedef int ElementType;
typedef struct _node {
    ElementType element;
    struct _node *next;
    struct _node *prev;
} Node;
typedef struct {
    Node *head;
    int capacity;
    int size;
} List;
```

Also, it's reasonable to add a field `Node *tail` to `List` and maintain `tail` for some convenient usage.

??? code "Doubly Linked List with Sentinel"

    ```C hl_lines="8 55 56 67"
    List *CreateList(const int capacity) {
        List *list = (List *)malloc(sizeof(List));
        list->capacity = capacity;
        list->size = 0;
        list->head = (Node *)malloc(sizeof(Node));
        list->head->element = 0;
        list->head->next = NULL;
        list->head->prev = NULL;
        return list;
    }

    void FreeList(List *list) {
        for (Node *p = list->head->next, *temp = NULL; p != NULL;) {
            temp = p;
            p = p->next;
            free(temp);
        }
        free(list->head);
        free(list);
    }

    void PrintList(const List *list) {
        for (Node *p = list->head->next; p != NULL; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        Node *p = list->head->next;
        for (int i = 0; i < position; i ++, p = p->next);
        return p->element;
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = p->prev = NULL;

        list->size ++;
        Node *q = list->head;
        for (int i = 0; i < position; i ++, q = q->next);
        p->next = q->next;
        q->next = p;
        q->next->prev = q;
        p->next->prev = p;
    }

    void Delete(List *list, const int position) {
        assert(0 <= position && postion < list->size && list->size > 0);
        list->size --;
        Node *temp = NULL;
        Node *q = list->head;
        for (int i = 0; i < position; i ++, q = q->next);
        temp = q->next;
        q->next = temp->next;
        temp->next->prev = q;
        free(temp);
    }
    ```

### Circularly Linked List

If there is a sentinel, then the next node of the last node is the sentinel. And Since it's circular, we can define `position` iteratively and take the mod of `position` as its actual `pos`.

```C
int pos = ((position % list->size) + list->size) % list->size;
```



??? code "Circularly Doubly Linked List with Sentinel"

    ```C hl_lines="7 8 39 40 53 65"
    List *CreateList(const int capacity) {
        List *list = (List *)malloc(sizeof(List));
        list->capacity = capacity;
        list->size = 0;
        list->head = (Node *)malloc(sizeof(Node));
        list->head->element = 0;
        list->head->next = list->head;
        list->head->prev = list->head;
        return list;
    }

    void FreeList(List *list) {
        for (Node *p = list->head->next, *temp = NULL; p != list->head;) {
            temp = p;
            p = p->next;
            free(temp);
        }
        free(list->head);
        free(list);
    }

    void PrintList(const List *list) {
        for (Node *p = list->head->next; p != list->head; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        Node *p = list->head->next;
        int pos = ((position % list->size) + list->size) % list->size;
        for (int i = 0; i < pos; i ++, p = p->next);
        return p->element;
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));

        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = p->prev = NULL;

        list->size ++;
        int pos = ((position % list->size) + list->size) % list->size;

        Node *q = list->head;
        for (int i = 0; i < pos; i ++, q = q->next);
        p->next = q->next;
        q->next = p;
        q->next->prev = q;
        p->next->prev = p;
    }

    void Delete(List *list, const int position) {
        assert(list->size > 0);
        int pos = ((position % list->size) + list->size) % list->size;
        list->size --;

        Node *temp = NULL;
        Node *q = list->head;
        for (int i = 0; i < pos; i ++, q = q->next);
        temp = q->next;
        q->next = temp->next;
        temp->next->prev = q;
        free(temp);
    }
    ```

!!! note
    Considering
    
    - whether there is the field `tail`,
    - whether there is a **sentinel**, or two **sentinels** (one for `head` and one for `tail`),
    - whether it's **doubly** linked,
    - whether it's **circularly** linked,

    we have numerous implementations of various linked lists.

!!! example "Example: Polynomial ADT"

    - Objects: $P(x) = a_1x^{e_1} + \dots + a_nx^{e_n}$
    - Operations:
        - Find degree.
        - Addition, Subtraction, Multiplication, Differentiation.

!!! example "Example: Multilists / Sparse Matrix Representation"

    Suppose a university with 40000 students and 2500 courses. We want to print the students' name list for each course and the registered classes list for each student.

    <div align="center">
    	<img src="../imgs/0.png" style="width:500px"/>
    </div>

    If we want the students' name of course $C3$, we start from node $C3$ and move to the **right**. For each node, we sub-move another pointer circularly **up and down** to find $S1$, which is the student's name of this node.

### Static List

Or called **Cursor Implementation of Linked Lists without pointer**. It's an alternative method to implement linked list in the cases that some languages don't support *pointers*.

Reference: [静态链表及实现（C语言）详解](http://data.biancheng.net/view/163.html).

Simply put, we need an array to maintain **TWO** linked lists, one for data, the other for the unused space. The head of the unused space list is commonly at position `0`.

```C title="Data Type"
#define MAXN 1000
typedef int ElementType;
typedef struct {
    ElementType element;
    int next;
} Node;
typedef struct {
    Node MEM_SPACE[MAXN];
    int head;
    int size;
} List;
```

Also, we can consider the sentinel, the tail, and the double and circular property with different data type defined. The following is an implementation of static list with sentinel.

??? code "Static List with Sentinel"
    First, we should define our own `malloc` and `free` function.

    ```C
    int MemAlloc(List *list) {
        int pos = list->MEM_SPACE[0].next;
        list->MEM_SPACE[0].next = list->MEM_SPACE[pos].next;
        return pos;
    }

    void MemFree(List *list, const int pos) {
        list->MEM_SPACE[pos].next = list->MEM_SPACE[0].next;
        list->MEM_SPACE[0].next = pos;
    }
    ```

    The rest are quite similar, we mainly make the following modification.

    - From `x->element` to `list->MEM_SPACE[x].element`;
    - From `x->next` to `list->MEM_SPACE[x].next`;

    ```C
    List *CreateList() {
        List *list = (List *)malloc(sizeof(List)); // (1)!
        for (int i = 0; i < MAXN - 1; i ++) {
            list->MEM_SPACE[i].next = i + 1;
        }
        list->MEM_SPACE[MAXN - 1].next = 0;
        list->size = 0;

        list->head = MemAlloc(list);
        list->MEM_SPACE[list->head].element = 0;
        list->MEM_SPACE[list->head].next = 0;
        return list;
    }

    void FreeList(List *list) {
        free(list);
    }

    void PrintList(const List *list) {
        for (int p = list->MEM_SPACE[list->head].next; p != 0; p = list->MEM_SPACE[p].next) {
            printf("%d ", list->MEM_SPACE[p].element);
        }
        putchar('\n');
    }

    int GetListLength(const List *list) {
        return list->size;
    }

    bool IsEmptyList(const List *list) {
        return list->size == 0;
    }

    ElementType Find(const List *list, const int position) {
        int p = list->MEM_SPACE[list->head].next;
        for (int i = 0; i < position; i ++, p = list->MEM_SPACE[p].next);
        return list->MEM_SPACE[p].element;
    }

    void Insert(List *list, const int position, const ElementType element) {
        assert(0 < position && position <= list->size &&
               (list->capacity == -1 || list->size < list->capacity));

        int p = MemAlloc(list);
        list->MEM_SPACE[p].element = element;
        list->MEM_SPACE[p].next = 0;

        list->size ++;
        int q = list->head;
        for (int i = 0; i < position; i ++, q = list->MEM_SPACE[q].next);
        list->MEM_SPACE[p].next = list->MEM_SPACE[q].next;
        list->MEM_SPACE[q].next = p;
    }

    void Delete(List *list, const int position) {
        assert(0 <= postion && position < list->size && list->size > 0);
        list->size --;
        int temp = 0;
        int q = list->head;
        for (int i = 0; i < position; i ++, q = list->MEM_SPACE[q].next);
        temp = list->MEM_SPACE[q].next;
        list->MEM_SPACE[q].next = list->MEM_SPACE[temp].next;
        MemFree(list, temp);
    }
    ```
    
    1. For tidiness and simplicty, I still use `malloc` here, but in actual cases, all fields of `list` are often used as a global variable and `list` will not be a pointer.

## Stack

A stack is a **Last-In-First-Out (LIFO)** list.

!!! list "ADT"
    **Objects**: (item~0~, item~1~, ..., item~N~~-~~1~)

    **Operations**
    
    - Make an empty stack.
    - Print all the items in a stack.
    - Get the depth of a stack.
    - **Find** the top item of a stack.
    - **Push** a new item onto a stack.
    - **Pop** an item from a stack.

```C title="Data Type"
typedef int ElementType;
typedef struct _node {
    ElementType element;
    struct _node *next;
} Node;
typedef struct {
    Node *top;
    int capacity;
    int size;
} Stack;
```

Similarly, we can use array and linked list to implement a stack. The following is the linked list implementation.

**NOTE:** There is convention of `Pop` function that `Pop` will not only delete the element on the top, but return the deleted element.

??? code "Stack"

    ```C
    Stack *CreateStack(const int capacity) {
        Stack *stack = (Stack *)malloc(sizeof(Stack));
        stack->capacity = capacity;
        stack->size = 0;
        stack->top = NULL;
        return stack;
    }

    void FreeStack(Stack *stack) {
        for (Node *p = stack->top, *temp = NULL; p != NULL;) {
            temp = p;
            p = p->next;
            free(p);
        }
        free(stack);
    }
    
    void PrintStack(const Stack *stack) {
        for (Node *p = stack->top; p != NULL; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetStackDepth(const Stack *stack) {
        return stack->size;
    }

    bool IsEmptyStack(const Stack *stack) {
        return stack->size == 0;
    }

    ElementType Top(const Stack *stack) {
        return stack->top->element;
    }

    void Push(Stack *stack, ElementType element) {
        if (stack->capacity != -1 && stack->size == stack->capacity) {
            // Warning
            return;
        }

        stack->size ++;
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = stack->top;
        stack->top = p;
    }

    ElementType Pop(Stack *stack) {
        if (stack->size == 0) {
            // Warning
            return -1;
        }

        stack->size --;
        Node *temp = stack->top;
        stack->top = temp->next;
        ElementType element = temp->element;
        free(temp);
        return element;
    }
    ```

## Queue

A queue is a **First-In-First-Out (FIFO)** list.

!!! list "ADT"
    **Objects**: (item~0~, item~1~, ..., item~N~~-~~1~)

    **Operations**
    
    - Make an empty queue.
    - Print all the items in a queue.
    - Get the length of a queue.
    - **Find** the front item of a queue.
    - **Enqueue** a new item to a queue.
    - **Dequeue** an item from a queue.

```C title="Data Type" 
typedef int ElementType;
typedef struct _node {
    ElementType element;
    struct _node *next;
} Node;
typedef struct {
    Node *front;
    Node *rear;
    int capacity;
    int size;
} Queue;
```

Similarly, we can use array and linked list to implement a queue. The following is the linked list implementation.

**NOTE:** There is convention of `Dequeue` function that `Dequeue` will not only delete the element in the front of the queue, but return the deleted element.

??? code "Queue"

    ```C
    Queue *CreateQueue(const int capacity) {
        Queue *queue = (Queue *)malloc(sizeof(Queue));
        queue->capacity = capacity;
        queue->size = 0;
        queue->front = (Node *)malloc(sizeof(Node));
        queue->front->element = 0;
        queue->front->next = NULL;
        queue->rear = queue->front;
        return queue;
    }

    void FreeQueue(Queue *queue) {
        for (Node *p = queue->front->next, *temp = NULL; p != NULL;) {
            temp = p;
            p = p->next;
            free(p);
        }
        free(queue);
    }
    
    void PrintQueue(const Queue *queue) {
        for (Node *p = queue->front->next; p != NULL; p = p->next) {
            printf("%d ", p->element);
        }
        putchar('\n');
    }

    int GetQueueLength(const Queue *queue) {
        return queue->size;
    }

    bool IsEmptyQueue(const Queue *queue) {
        return queue->size == 0;
    }

    ElementType Front(const Queue *queue) {
        return queue->front->next->element;
    }

    void Enqueue(Queue *queue, ElementType element) {
        if (queue->capacity != -1 && queue->size == queue->capacity) {
            // Warning
            return;
        }

        queue->size ++;
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = element;
        p->next = NULL;
        queue->rear->next = p;
        queue->rear = p;
    }

    ElementType Dequeue(Queue *queue) {
        if (queue->size == 0) {
            // Warning
            return -1;
        }

        queue->size --;
        if (queue->size == 0) {
            queue->rear = queue->front;
        }
        Node *temp = queue->front->next;
        queue->front->next = temp->next;
        ElementType element = temp->element;
        free(temp);
        return element;
    }
    ```

### Other Queues

#### Deque

A deque is a queue that we can enqueue and dequeue from both sides. The interfaces are like below.

```C
ElementType Front(const Deque dequue);
ElementType Back(const Deque dequue);
void PushFront(Deque dequue, const ElementType element);
void PushBack(Deque dequue, const ElementType element);
ElementType PopFront(Deque dequue);
ElementType PopBack(Deque dequue);
```

#### Circular Queue

A circular queue is a queue that store elements circularly. It can be seen in the array implementation of queue.

To distinguish whether is empty or full, we stipulate that when it's empty, it has $N - 1$ elements. Then

- If a queue is empty, then `front = rear`.
- If a queue is full, then `front = (rear + 1) % N`.