### Lists, Stacks and Queues

!!! definition
    **Data type** consists of *objects* and *operations*.

    An **Abstract Data Type (ADT)** is a data type that is organized in such a way that

    - the *specification* on the objects are separated from the *representation* of the objects.
    - the *specification* of the operations on the objects are separated from the *implementation* on the operations

## Lists

!!! list "ADT"
    **Objects**: (item~0~, item~1~, ..., item~N~~-~~1~)

    **Operations**
    
    - Make an empty list.
    - Print all the items in a llist.
    - Get the length of a list.
    - **Find** the *k*-th item from a list.
    - **Insert** a new item after *k*-th item of a list.
    - **Delete** an item from a list.
    - Find the next item of the current item from a list.
    - Find the previous item of the current item from a list.

Following are some implementations of list.

### Array

```C title="Array Implementation"
typedef ElementType int;
typedef struct {
   ElementType *array;
   int capacity;
   int size; 
} List;

List *CreateList(const int capacity) {
    List *list = (List *)malloc(sizeof(List));
    list->capacity = capacity;
    list->size = 0;
    list->array = (ElementType *)malloc(list->capacity * sizeof(ElementType));
    return list;
}

void PrintList(const List *list) {
    for (int i = 0; i < list->size; i ++) {
        printf("%d\n", list->array[i]);
    }
}

void LenList(const List *list) {
    return list->size;
}

void Find(List *list, const int position) {
    return list->array[position];
}

void Insert(List *list, const int position, const ElementType element) {
    if (position < 0 || position > list->size || list->size == list->capacity) {
        // WARNING
        return;
    }
    list->size ++;
    for (int i = list->size; i > position; i --) {
        list->array[i] = list->array[i - 1];
    }
    list->array[position] = element;
}

void Delete(List *list, const int position) {
    if (position < 0 || position > list->size || list->size == 0) {
        // WARNING
        return;
    }
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

### Doubly Linked List

### Circularly Linked List