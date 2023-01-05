# Sort

Suppose there is an array of comparable elements $x_0, \dots x_{n - 1}$ and sort the array.

## Property

When discussing various sort algorithms, we concerns the following properties.

### Stability

Stability measures whether the algorithm change the **relative order** of the same elements.

### Time Complexity

We consider the **best time complexity**, **worst time complexity** and **average complexity**.

!!! definition
    An **inversion** in an array of numbers is any ordered pair $(i, j)$ with the property that

    $$
        i < j,\ \ A[i] > A[j].
    $$

!!! theorem
    The average number of inversions in an array of $N$ distinct number is $\dfrac{N(N - 1)}{4}$.

!!! theorem
    - Any algorithm that sorts by exchanging **adjacent** elements requires $\Omega(N^2)$ time on average.
    - Any algorithm that sorts by comparison requires $\Omega(N \log N)$ time on average.

Also, there are some sort algorithms not based on exchange.

### Space Complexity

Space complexity considers the extra space the algorithm need.

## Bubble Sort 冒泡排序

=== "Iteration"

    ```C
    void BubbleSort(const int n, int a[]) {
        for (int i = n - 1; i >= 0; i --) {
            for (int j = 0; j < i; j ++) {
                if (a[j] > a[j + 1]) {
                    Swap(a + j, a + j + 1);
                }
            }
        }
    }
    ```

=== "Iteration (Improved)"

    ```C
    void BubbleSort(const int n, int a[]) {
        for (int i = n - 1, end = 0; i > 0; i = end, end = 0) {
            for (int j = 0; j < i; j ++) {
                if (a[j] > a[j + 1]) {
                    Swap(a + j, a + j + 1);
                    end = j;
                }
            }
        }
    }
    ```

=== "Recursion"

    ```C
    void BubbleSort(const int n, int a[]) {
        if (n == 0) {
            return;
        }
        for (int i = 0; i < n - 1; i ++) {
            if (a[i] > a[i + 1]) {
                Swap(a + i, a + i + 1);
            }
        }
    	BubbleSort(n - 1, a);
    }
    ```

**Analysis**

- **Stable**.
- **Time complexity** $O(n^2)$.
- **Space complexity** $O(1)$.

## Insertion Sort 插入排序

=== "Iteration"

    ```C
    void InsertionSort(const int n, int a[]) {
        int j;
        for (int i = 1; i < n; i ++) {
            int x = a[i];
            for (j = i - 1; j >= 0 && a[j] > x; j --) {
                a[j + 1] = a[j];
            }
            a[j + 1] = x;
        }
    }
    ```

=== "Recursion"

    ```C
    void InsertionSort(const int n, int a[]) {
        if (n == 0) {
    		return;
    	}
        InsertionSort(n - 1, a);
        int x = a[n - 1], j;
        for (j = n - 2; j >= 0 && a[j] > x; j --) {
            a[j + 1] = a[j];
        }
        a[j + 1] = x;
    }
    ```

**Analysis**

- **Stable**.
- **Time complexity**
    - Avearge case $O(n^2)$.
    - Best case $O(n)$ (**High Efficiency** when it's almost in order).
    - When $N \le 20$, insertion sort is the **fastest**.
- **Space complexity** $O(1)$.

## Selection Sort 选择排序

=== "Iteration"

    ```C
    void InsertionSort(const int n, int a[]) {
        for (int i = 0; i < n - 1; i ++) {
           int idx = i;
           for (int j = i + 1; j < n; j ++) {
		        idx = a[j] < a[idx] ? j : idx;
           }
           Swap(a + i, a + idx);
        }
    }
    ```

=== "Recursion"

    ```C
    int FindMin(int a[], const int begin, const int end) {
        int ret = begin;
        for (int i = begin + 1; i <= end; i++) {
    		ret = a[i] < a[ret] ? i : ret;
        }
        return ret;
    }

    void Sort(int a[], const int begin, const int end) {
        if (begin == end) {
            return;
        }
        Swap(a + begin, a + FindMin(a, begin, end));
    	Sort(a, begin + 1, end);
    }

    void SelectionSort(const int n, int a[]) {
        Sort(a, 0, n - 1);
    }
    ```

**Analysis**

- **Unstable**.
- **Time complexity** $O(n^2)$.
- **Space complexity** $O(1)$.

## Counting Sort 计数排序

```C
#define m 10010
void CountingSort(const int n, int a[]) {
    int cnt[m], b[n];
    memset(cnt, 0, sizeof(cnt));
    for (int i = 0; i < n; i ++) {
        cnt[a[i]] ++;
    }
    for (int i = 0; i < m; i ++) {
        cnt[i] += cnt[i - 1];
    }
    for (int i = n - 1; i >= 0; i --) {
        b[cnt[a[i] --] = a[i];
    }
    memcpy(a, b, sizeof(a));
}
```

**Analysis**

- **Stable**.
- **Time complexity** $O(n + m)$, where $m$ is the upper bound of $a[i]$.
- **Space complexity** $O(n + m)$.

## Radix Sort 基数排序

```C
typedef struct {
    int element;
    int key[K]; // `K` is the number of keys
} ElementType;

void CountingSort(const int n, ElementType a[], int p, int cnt[], ElementType b[]) {
    memset(cnt, 0, sizeof(cnt));
    for (int i = 0; i < n; i ++) {
        cnt[a[i].key[p]] ++;
    }
    for (int i = 0; i < m[p]; i ++) {
        cnt[i] += cnt[i - 1];
    }
    for (int i = n - 1; i >= 0; i --) {
        b[cnt[a[i].key[p] --] = a[i];
    }
    memcpy(a, b, sizeof(a));
} 

void RadixSort(const int n, ElementType a[]) {
    int cnt[M]; // `M` is the maximum of `m_i`, the upper bound of each key.
    ElementType b[n];
    for (int i = k - 1; i >= 0; i --) {
        CountingSort(n, a, i, cnt, b);
    }
}
```

The most common keys for sorting a series of integers are the number at digit $j$.

```C
for (int i = 0; i < n; i ++) {
    for (int j = 0; j < K; j ++) {
        a[i].key[j] = a[i].element / pow(10, j - 1) % 10;
    }
}
```

**Analysis**

- **Stable** unless the inner sort is unstable.
- **Time complexity**
    - If $\max\{m_i\}$ is small, we can use Counting Sort as the inner sort, then the time complexity is $O\left(nk + \sum\limits_{i = 1}^k m_i\right)$, where $k$ is the number of keys, $m_i$ is the upper bound of each key.
    - If $\max\{m_i\}$ is large, we use the sort based on comparison of $O(nk \log n)$ instead of Radix Sort.
- **Space complexity** $O(n + \max\{m_i\})$.

## Quick Sort 快速排序

```C
void Sort(int a[], const int L, const int R) {
    if (L >= R) {
            return;
    }

    int rnd = L + rand() % (R - L); // (1)!
    int pos = L, cnt = 0;
    Swap(&a[L], &a[rnd]);
    for (int i = L + 1; i <= R; i ++) { // (2)!
        if (a[i] < a[L]) {
            pos ++;
            if (pos + cnt < i) {
                Swap(&a[pos], &a[cnt + pos]);
            }
            Swap(&a[i], &a[pos]);
            continue;
        }
        if (a[i] == a[L]) {
            cnt ++;
            Swap(&a[i], &a[cnt + pos]);
        }
    }
    Swap(&a[L], &a[pos]);

    Sort(a, L, pos - 1);
    Sort(a, pos + 1 + cnt, R);
}

void QuickSort(const int n, int a[]) {
    srand(time(NULL));
    Sort(a, 0, n - 1);
}
```

1. Different pivot picking strategies are discussed below.
2. This is a 3-way radix quicksort.

**Analysis**

- **Unstable**.
- **Time complexity**
    - Best and average cases $O(n \log n)$.
    - Worst cases $O(n^2)$.
        - Each pivot `a[pos]` is the maxima / minima.
        - Degenerate to list.
- **Space complexity** $O(1)$.

??? note "Time Complexity"
    
    $$
        T(N) = T(i) + T(N - i - 1) + cN
    $$

    - Worst Case

    $$
        T(N) = T(N - 1) + cN \Rightarrow T(N) = O(N^2),
    $$

    - Best Case

    $$
        T(N) = 2T\left(\frac{N}{2}\right) + cN \Rightarrow T(N) = O(N\log N),
    $$

    - Average Case

    $$
        T(N) = \frac2N\sum\limits_{j = 0}^{N - 1}T(j) + cN \Rightarrow T(N) = O(N\log N).
    $$

??? note "Pivot Picking Strategy"
    - A simple way is `a[0]`.
    - A random way, which is used above, is `a[rnd]`, where `rnd` is a random number between `L` and `R`.
    - Median-of-Three Paritioning `a[mid]`,  where `mid = median(left, center, right)`.
    
        ??? code

            ```C
            int MediamThree(int a[], const int L, const int R) {
                int mid = L + ((R - L) >> 1);
                if (a[L] > a[mid]) {
                    Swap(a + L, a + mid);
                }
                if (a[L] > a[R]) {
                    Swap(a + L, a + R);
                }
                if (a[mid] > a[R]) {
                    Swap(a + mid, a + R);
                }
                assert(a[L] <= a[mid] && a[mid] <= a[R]);
                Swap(a[mid], a[R - 1]);
                return a[R - 1];
            }
            ```
??? note "Improvement"
    Suppose the value of pivot is `v`.

    **2-way Radix Quicksort**

    Scan from left and right respectively by two index `(i, j)`, make the elements `<= v` on the left of `i` and the elements `>= v` on the right of `j`.
    
    **3-way Radix Quicksort**

    Partition the series into **THREE** parts: `> m`, `< m` and `= m`. It's efficient to deal with the cases of multiple identical values.
## Merge Sort 归并排序

=== "Recursion"

    ```C
    void Merge(int a[], const int L, const int mid, const int R, int temp[]) {
        int i = L, j = mid + 1;
        for (int k = L; k <= R; k ++) {
            if (i <= mid && (j > R || a[i] <= a[j])) {
                temp[k] = a[i];
                i ++;
            } else {
                temp[k] = a[j];
                j ++;
            }
        }
        memcpy(a + L, temp + L, (R - L + 1) * sizeof(int));
    }

    void Sort(int a[], const int L, const int R, int temp[]) {
        if (L == R) {
            return;
        }

        int mid = L + ((R - L) >> 1);
        Sort(a, L, mid, temp);
        Sort(a, mid + 1, R, temp);
        Merge(a, L, mid, R, temp);
    }

    void MergeSort(const int n, int a[]) {
        int temp[n];
        Sort(a, 0, n - 1, temp);
    }
    ```

=== "Iteration"

    ```C
    #define min(a, b) ((a) < (b) ? (a) : (b))

    void Merge(int a[], const int L, const int mid, const int R, int temp[]) {
        int i = L, j = mid + 1;
            for (int k = L; k <= R; k ++) {
            if (i <= mid && (j > R || a[i] <= a[j])) {
                temp[k] = a[i];
                i ++;
            } else {
                temp[k] = a[j];
                j ++;
            }
        }
            memcpy(a + L, temp + L, (R - L + 1) * sizeof(int));
    }

    void MergeSort(const int n, int a[]) {
        int temp[n];
        for (int width = 1; width < n; width <<= 1) {
            for (int i = 0; i < n; i += width << 1) {
                Merge(a, i, min(n, i + width) - 1, min(n, i + (width << 1) - 1), temp);
            }
        }
    }
    ```

**Analysis**

- **Stable**.
- **Time complexity** $O(n \log n)$.
- **Space complexity** $O(n)$.

## Bucket Sort 桶排序

**Analysis**

- Improvement of **Radix Sort**.
- **Stable** unless the inner sort is unstable.
- **Time complexity**
    - Average case $O(n + n^2 / k + k)$.
    - Worst case $O(n^2)$.
- **Space complexity** $O(n)$.
## Heap Sort 堆排序

**Analysis**

- Improvement of **Selection Sort**.
- **Unstable**.
- **Time complexity** $O(n \log n)$.
- **Space complexity** $O(1)$.

## Shell Sort 希尔排序

**Analysis**

- Improvement of **Insertion Sort**.
- **Unstable**.
- **Time complexity**
    - Depend on the interval.
    - Best case $O(N)$.
    - Best worst case $O(n \log^2 n)$.
- **Space complexity** $O(1)$.