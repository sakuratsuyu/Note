# Hashing

**Hash table (散列表, 哈希表)**, or say **Symbol table (Dictionary)** is an ADT that supports *insertions*, *deletions* and *finds* in constant average time.

!!! list "ADT"
    **Objects:** A set of *key-value* pairs, where *keys* are **unique**.

    **Operations:**

    - Create a hash table.
    - Check whether a key is already in a hash table.
    - **Find** the corresponding value of a key in a hash table.
    - **Insert** a new key-value pair into a hash table.
    - **Delete** a key and its corresponding value in a hash table.

## Hash Function

A **hash function** $f$ is a function used for building hash table by

$$
    hash(key) = value.
$$

But sometimes we have $key_1 \ne key_2$, but $hash(key_1) = hash(key_2)$, we called this a **collision**. 

!!! theorem "Property"
    
    - $hash(x)$ is *easy* to compute and *minimize* collisions.
    - $hash(x)$ is supposed to be **unbiased**, or say *uniform*. That is for any $x$ and $i$, we want that

    $$
        P\{hash(x) = i\} = \frac1b,\ \ \text{ where $b$ is some number}.
    $$

    &nbsp;&nbsp;&nbsp;&nbsp; Such kind of a hash function is called a **uniform hash function**.

!!! example "Common Choice of Hash Function"
    - **Remainder**. $N$ is the size of hash table, often a **prime** number.

    $$
        hash(x) = x \text{ mod } N.
    $$

    - **Middle Square**. Take middle some digits of the square of the key as the address of hash function.

    - **Random**.


## Hash Table

<div align="center">
	<img src="../imgs/9.png" style="width:400px"/>
</div>

!!! definition
    - $T$ is the total number of distinct possible value for $x$.
    - $n$ is the total number of identifers in hash table.
    - **Identifier Density** $d = \dfrac{n}{T}$.
    - **Loading Density** $\lambda = \dfrac{n}{sb}$.

An **overflow** occur when a new identifier are hashed into a full bucket.

## Collision Resolution

Although we try many methods to make a hash function avoid collision. But it's unfortunately unavoidable. The most important issue of hash table is to deal with collision. We have some strategies for it.

Suppose the hash function we use below are all

$$
    hash(x) = x \text{ mod } N,\ \ N \in \mathbb{P}.
$$

### Separate Chaining 拉链法

Separate chaining keeps a **linked list** of all keys that hash to the same value.

```C title="Data Type"
typedef struct {
    int key;
    int value;
} Pair;
typedef Pair ElementType;
typedef struct _node {
    ElementType *element;
    struct _node *next;
} Node;
typedef struct {
    int size;
    Node *head;
} List;

typedef struct {
    int tableSize;
    List **list;
    int (*Hash)(const int key, const int N);
} HashTable;
```

??? code "Separate Chaining"
    
    ```C
    static bool IsPrime(const int x) {
        bool ret = true;
        for (int i = 2, temp = sqrt(x); i <= temp; i ++) {
            if (x % i == 0) {
                ret = false;
                break;
            }
        }
        return ret;
    }

    static int NextPrime(int x) {
        while (!IsPrime(x)) {
            x ++;
        }
        return x;
    }

    static int Hash(const int key, const int N) {
        return key % N;
    }

    HashTable *CreateHashTable(const int tableSize) {
        HashTable *H = (HashTable *)malloc(sizeof(HashTable));
        H->tableSize = NextPrime(tableSize); // (1)!
        H->list = (List **)malloc(H->tableSize * sizeof(List *));
        for (int i = 0; i < H->tableSize; i ++) {
            H->list[i] = (List *)malloc(sizeof(List));
            H->list[i]->head = (Node *)malloc(sizeof(Node)); // (2)!
            H->list[i]->head->next = NULL;
        }
        H->Hash = Hash;
        return H;
    }

    void FreeHashTable(HashTable *H) {
        for (int i = 0; i < H->tableSize; i ++) {
            for (Node *p = H->list[i]->head, *temp = NULL; p != NULL; ) {
                temp = p;
                p = p->next;
                free(temp);
            }
            free(H->list[i]);
        }
        free(H->list);
        free(H);
    } 

    Pair *Find(HashTable *H, const int key) {
        Pair *ret = NULL;
        List *L = H->list[H->Hash(key, H->tableSize)];
        for (Node *p = L->head->next; p!= NULL; p = p->next) {
            if (p->element->key == key) {
                ret = p->element;
                break;
            }
        }
        return ret;
    }

    void Insert(HashTable *H, const ElementType pair) {
        if (Find(H, pair.key) != NULL) {
            // WARNING("The key is already in the hash table");
            return;
        }
        List *L = H->list[H->Hash(pair.key, H->tableSize)];
        L->size ++;
        Node *p = (Node *)malloc(sizeof(Node));
        p->element = (Pair *)malloc(sizeof(Pair));
        p->element->key = pair.key;
        p->element->value = pair.value;
        p->next = L->head->next;
        L->head->next = p;
    }

    void Delete(HashTable *H, const int key) {
        bool flag = false;
        List *L = H->list[H->Hash(key, H->tableSize)];
        for (Node *p = L->head->next, *q = L->head; p != NULL; p = p->next, q = p) {
            if (p->element->key == key) {
                L->size --;
                q->next = p->next;
                free(p);
                flag = true;
                break;
            }
        }
        if (flag == false) {
            // WARNING("There is no key in the hash table");
            return;
        }
    }
    ```

    1. Ensure the `tableSize` is **prime**.
    2. Sentinel.

### Open Addressing 开放寻址法 / Closed Hashing 闭散列法

Instead of using pointer and linked lists, if we do not want to expand the hash table, an alternative way is **Open Addressing**.

The basic idea is that if there is a collision where $hash(x)$ is already occupied, we make some **offset**, which means to take the following function as the address of hash function with $i$ increasing **until** the address is not occupied.

$$
    (hash(key) + f(i)) \text{ mod } N.
$$

#### Linear Probing 线性探测

Linear probing defines $f(i)$ by

$$
    f(i) = i.
$$

Analysis of linear probing show that the **expected number of probes** $p$ satisfies

$$
\begin{aligned}
p = &\left\{
\begin{aligned}
    & \frac12\left(1 + \frac{1}{(1 - \lambda)^2}\right), && \text{for insertions and unsuccessful searches,} \\
    & \frac12\left(1 + \frac{1}{(1 - \lambda)}\right), && \text{for successful searches,}
\end{aligned}
\right.
,\\ & \text{where $\lambda$ is the loading density}.
\end{aligned}
$$

#### Quadratic Probing 平方探测

Quadratic probing defines $f(i)$ by

$$
    f(i) = i^2.
$$

Different from linear probing, there may be the cases that all addresses of $hash(key) + f(i)$ are occupied even though the hash table is not full. To avoid this case, an important property for quadratic probing is described in the following theroem.

!!! theorem
    If quadratic probing is used, and the table size is **prime**, then a new element can *always* be inserted if the table is **at least half empty**.

!!! theorem
    If the table size is a **prime** of the form $4k + 3$, then the quadratic probing can probe the entire table.

!!! bug "Cluster 聚集 / 堆积"
    Cluster means the **ununiformity** occupation of the hash table, which forms clusters or blocks. For **linear probing**, there is **primary clustering** and for **quadratic probing**, there is **secondary clustering**.

    Since cluster will result in increased search time, we should make efforts to avoid it.

#### Double Hashing 双散列

Double hashing defines $f(i)$ by

$$
    f(i) = i \cdot hash_2(key),
$$

which means that the total hash address is

$$
    hash(key) = hash_1(key) + i \cdot hash_2(key).
$$

The second hash function $hash_2(x)$ must satisfy

- $hash_2(x) \ne 0$.
- Make sure that all addresses can be probed.

A choice of $hash_2(x)$ that relatively works well is

$$
    hash_2(x) = R - (x \text{ mod } R),\ \ \text{ where } R \in \mathbb{P} \text{ and } R < N.
$$

**NOTE** If double hashing is correctly implemented, simulations imply that the expected number of probes is almost the same as for a random collision resolution strategy.


```C title="Data Type"
typedef struct {
    int key;
    int value;
} Pair;
typedef Pair ElementType;

typedef struct {
    int tableSize;
    bool *occupied;
    ElementType **table;
    int (*Hash)(const int key, const int N);
    int (*f)(const int i);
} HashTable;
```

??? code "Open Addressing"

    ```C
    static bool IsPrime(const int x) {
        bool ret = true;
        for (int i = 2, temp = sqrt(x); i <= temp; i ++) {
            if (x % i == 0) {
                ret = false;
                break;
            }
        }
        return ret;
    }

    static int NextPrime(int x) {
        while (!IsPrime(x)) {
            x ++;
        }
        return x;
    }

    static int Hash(const int key, const int N) {
        return key % N;
    }

    static int f(const int i) {
        return i * i; // (1)!
    }

    HashTable *CreateHashTable(const int tableSize) {
        HashTable *H = (HashTable *)malloc(sizeof(HashTable));
        H->tableSize = NextPrime(tableSize);
        H->occupied = (bool *)malloc(H->tableSize * sizeof(bool));
        memset(H->occupied, false, H->tableSize * sizeof(bool));
        H->table = (ElementType **)malloc(H->tableSize * sizeof(ElementType *));
        for (int i = 0; i < H->tableSize; i ++) {
            H->table[i] = (ElementType *)malloc(sizeof(ElementType));
        }
        H->Hash = Hash;
        H->f = f;
        return H;
    }

    void FreeHashTable(HashTable *H) {
        free(H->occupied);
        for (int i = 0; i < H->tableSize; i ++) {
            free(H->table[i]);
        }
        free(H->table);
        free(H);
    }

    void PrintHashTable(const HashTable *H) {
        for (int i = 0; i < H->tableSize; i ++) {
            if (H->occupied[i] == false) {
                    printf("0 ");
            } else {
                    printf("%d ", H->table[i]->key);
            }
        }
        putchar('\n');
        for (int i = 0; i < H->tableSize; i ++) {
            if (H->occupied[i] == false) {
                printf("0 ");
            } else {
                printf("%d ", H->table[i]->value);
            }
        }
        putchar('\n');
    }

    Pair *Find(HashTable *H, const int key) {
        Pair *ret = NULL;
        int pos = H->Hash(key, H->tableSize);
        int pivot = pos, i = 1;
        while (H->occupied[pos] == true) {
            if (H->table[pos]->key == key) {
                ret = H->table[pos];
                break;
            }
            pos = (pivot + H->f(i)) % H->tableSize;
            i ++;
        }
        return ret;
    }

    void Insert(HashTable *H, const ElementType pair) {
        bool flag = false;
        int pos = H->Hash(pair.key, H->tableSize);
        int pivot = pos, i = 1;
        while (H->occupied[pos] == true) {
            if (H->table[pos]->key == pair.key) {
                flag = true;
                break;
            }
            pos = (pivot + H->f(i)) % H->tableSize;
            i ++;
        }
        if (flag == true) {
            // WARNING("The key is already in the hash table");
            return;
        }
        H->occupied[pos] = true;
        H->table[pos]->key = pair.key;
        H->table[pos]->value = pair.value;
    }

    void Delete(HashTable *H, const int key) {
        bool flag = false;
        int pos = H->Hash(key, H->tableSize);
        int pivot = pos, i = 1;
        while (H->occupied[pos] == true) {
            if (H->table[pos]->key == key) {
                H->occupied[pos] = false;
                flag = true;
                break;
            }
            pos = (pivot + H->f(i)) % H->tableSize;
            i ++;
        }
        if (flag == false) {
            // WARNING("There is no key in the hash table");
            return;
        }
    }
    ```

    1. Here is the **quadratic probing** function. We can replace it by `return i` for **linear probing**. Or we can use **double hashing** by the following snippet.
        ```C
        typedef struct {
            ...
            int R;
            int (*f)(const int i, const int key, const int R);
        } HashTable;

        HashTable *CreateHashTable(const int tableSize) {
            ...
            H->R = /* Some prime smaller than `tableSize` */;
            H->f = f;
            return H;
        }

        static int f(const int i, const int key, const int R) {
            int h = R - (key % R);
            return i * h;
        }
        ``` 
    
    !!! tip
        For the probing statement

        ```C
        pos = (pivot + H->f(i)) % H->tableSize;
        ```

        We can replace it by the following more efficient snippet.

        === "Linear Probing"

            ```C
            pos = (pos + 1) % H->tableSize;
            ```

        === "Quadratic Probing"

            ```C
            pos = (pos + 2 * i - 1) % H->tableSize;
            ```

        === "Double Hashing"

            ```C
            int h = H->R - (key % H->R);
            while (...) {
                ...
                pos = (pos + h) % H->tableSize;
                ...
            }
            ```

#### Rehashing 再散列

Quadratic probing does not require the use of a second hash function and is thus likely to be **simpler and faster** in practice.

But when the hash table gets too full, quadratic probing may fail. Thus we need **rehashing**.

!!! question "When to Rehash?"
    - The hash table is half full.
    - An insertion fails.
    - The hash table reaches a certain load factor.

!!! success "Process of Rehashing"
    **Step.1** Build another table that is about *twice* as big (Remember it had better be **prime**).

    **Step.2** Scan down the entire original hash table for non-deleted elements.
    
    **Step.3** Use a new function to hash those elements into the new table.

??? code "Rehashing"

    ```C
    HashTable *Rehash(HashTable *H) {
        HashTable newH = CreateHashTable(2 * H->tableSize);
        for (int i = 0; i < H->tableSize; i ++) {
            if (H->flag[i] == false) {
                Insert(newH, H->table[i]);
            }
        }
        free(H->flag);
        free(H->table);
        return newH;
    }
    ```