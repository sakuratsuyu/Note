### Graph

!!! definition

    A **Graph** consists of *vertices* and *edges*, it can be expressed by the mark **$G(V, E)$**, where  

    - **$G$ := graph**
    - **$V = V(G) :=$ finite nonempty set of vertices**
    - **$E = E(G) :=$ finite set of edges**

    > Owing to the restrictions of Fundamental Data Struct 

    > - *Self loop* is illegal
    > - *Multigraph* is not considered

## Some definition of Graph

- **Undirected graph**  
  $(v_i, v_j) = (v_j, v_i)$ := the same edge  

- **Directed graph (digraph)**  
  $<v_i, v_j> :=$ one edge from $v_i$ to $v_j$ $\ne$ $<v_j, v_i>$  

- **Complete graph**  
  A graph that has the maximum number of edges
    - For a undirected graph with $n$ vertices, it will be $\frac{n(n-1)}{2}$  
    - For a directed grach with $n$ vertices, it will be $n(n-1)$  

- **Adjacent**  
  If there is one edge from $v_i$ to $v_j$, then $v_i$ is adjacent *to* $v_j$, else $v_i$ is adjacent *from* $v_j$

- **Subgrach $G' \in G$**  
  $V(G')\subset V(G)$ && $E(G')\subset E(G)$

- **Path ($\in G$) from $v_p$ to $v_q$**  
  $\{v_p, v_{i1}, v_{i2}, \cdots, v_{in}, v_q \}$ such that $(v_p,v_{i1}), (v_{i1}, v_{i2}), \cdots, (v_{in}, v_q)$ or $<v_p,v_{i1}>, <v_{i1}, v_{i2}>, \cdots, <v_{in}, v_q>$

- **Length of a path**  
  Number of edges on the path

- **Simple path**  
  $v_{i1}, v_{i2}, \cdots, v_{in}$ are distinct

- **Cycle**  
  Simple path with $v_p=v_q$

- **Connected**  
    - **Undirected graph**  
        - vertices - there is a path from $v_i$ to $v_j$
        - graph - all pairs of distinct vertices are connected
        - **(Connected) Component**  
            The maximal connected subgraph
    - **Directed graph**  
        - **Strongly connectedd**  
          For every pair of $v_i$ and $v_j$ in $V(G)$, there exist directed paths from $v_i$ to $v_j$ and from $v_j$ to $v_i$
        - **Weakly connected**  
          The graph is connected without direction to the edges
        - **Strongly connected component**  
          The maximal subgraph that is strongly connected

- **A tree**  
    A graph that is connected and *acyclic*

- **A DAG**  
    A directed acyclic graph

- **Degree**  
  Number of edges incident to $v$  
  For a directed $G$, we have *in-degree* as the edges to $v$ and *out-degree* as the edges from $v$  
  Given $G$ with $n$ vertices and $e$ edges, $e=(\Sigma_{i=0}^{n-1}degree(v_i))/2$

## Representation of Graphs

- **Adjacency Matrix**  
  Use a matrix to represent the edges of a graph  
  $adj\_ mat[i][j]=\left\{\begin{array}{l} 1 &if\ (v_i,v_j)\ or\ <v_i,v_j>\ \in E(G)\\ 0& otherwise \end{array} \right .$

- **Adjacency Lists**
  For each vertex in the graph, use a list to record all other vertices it links to

- **Adjcency Multilists**
  Use the edges as node, and connect each node with a same vertex

!!! example "Example: How Adjacency Multilists Build"

    for the left given graph, the corresponded adjancency multilists is

    <div style="display:flex; flex-direction:row; align-items:center; justify-content:center;">
        <img src="../Pic/graph_0.png">
        <div style="width:20px"></div>
        <img src="../Pic/graph_1.png">
    </div>

- **Weighted Edges**  
  $adj\_ mat[i][j]=weight$

## Topological Sort

**AOV Network**: digraph $G$ in which $V(G)$ represents activities(e.g. courses) and $E(G)$ represents precedence relations  

$i$ is a **predecessor** of  $j$ if there is a path from $i$ to $j$,  
$i$ is an **immediate predecessor** of j if $<i,j>\in E(G)$,  
then $j$ is called a **sucessor**(**immediate sucessor**) of $i$  
If we can finish all activities in AOV Network in any order without finishing one before its predecessor finished, the AOV Network is **feasible**, else it is **unfeasible**  

**Patial order**: a precedence relation which is both *transitive* ($i\rightarrow k, k\rightarrow j, \Rightarrow i\rightarrow j$) and *irrelative* ($i\rightarrow i$ is impossible)

> Feasible AOV network must be a **dag**

!!! definition
    A **topological order** is a linear ordering of the vertices of a graph such that, for any two vertices, $i,j$, if $i$ is a predecessor of $j$ in the network then $i$ precedes $j$ in the linear ordering

??? code "Topological Sort"

    ```C
    #include <stdio.h>
    #include <stdlib.h>
    #define  MAX_VERTEX_NUM 20//最大顶点个数
    #define  VertexType int//顶点数据的类型
    typedef enum{false,true} bool;
    typedef struct ArcNode{
        int adjvex;//邻接点在数组中的位置下标
        struct ArcNode * nextarc;//指向下一个邻接点的指针
    }ArcNode;
    typedef struct VNode{
        VertexType data;//顶点的数据域
        ArcNode * firstarc;//指向邻接点的指针
    }VNode,AdjList[MAX_VERTEX_NUM];//存储各链表头结点的数组
    typedef struct {
        AdjList vertices;//图中顶点及各邻接点数组
        int vexnum,arcnum;//记录图中顶点数和边或弧数
    }ALGraph;
    //找到顶点对应在邻接表数组中的位置下标
    int LocateVex(ALGraph G,VertexType u){
        for (int i=0; i<G.vexnum; i++) {
            if (G.vertices[i].data==u) {
                return i;
            }
        }
        return -1;
    }
    //创建AOV网，构建邻接表
    void CreateAOV(ALGraph **G){
        *G=(ALGraph*)malloc(sizeof(ALGraph));
    
        scanf("%d,%d",&((*G)->vexnum),&((*G)->arcnum));
        for (int i=0; i<(*G)->vexnum; i++) {
            scanf("%d",&((*G)->vertices[i].data));
            (*G)->vertices[i].firstarc=NULL;
        }
        VertexType initial,end;
        for (int i=0; i<(*G)->arcnum; i++) {
            scanf("%d,%d",&initial,&end);
        
            ArcNode *p=(ArcNode*)malloc(sizeof(ArcNode));
            p->adjvex=LocateVex(*(*G), end);
            p->nextarc=NULL;
        
            int locate=LocateVex(*(*G), initial);
            p->nextarc=(*G)->vertices[locate].firstarc;
            (*G)->vertices[locate].firstarc=p;
        }
    }
    //结构体定义栈结构
    typedef struct stack{
        VertexType data;
        struct stack * next;
    }stack;
    //初始化栈结构
    void initStack(stack* *S){
        (*S)=(stack*)malloc(sizeof(stack));
        (*S)->next=NULL;
    }
    //判断链表是否为空
    bool StackEmpty(stack S){
        if (S.next==NULL) {
            return true;
        }
        return false;
    }
    //进栈，以头插法将新结点插入到链表中
    void push(stack *S,VertexType u){
        stack *p=(stack*)malloc(sizeof(stack));
        p->data=u;
        p->next=NULL;
        p->next=S->next;
        S->next=p;
    }
    //弹栈函数，删除链表首元结点的同时，释放该空间，并将该结点中的数据域通过地址传值给变量i;
    void pop(stack *S,VertexType *i){
        stack *p=S->next;
        *i=p->data;
        S->next=S->next->next;
        free(p);
    }
    //统计各顶点的入度
    void FindInDegree(ALGraph G,int indegree[]){
        //初始化数组，默认初始值全部为0
        for (int i=0; i<G.vexnum; i++) {
            indegree[i]=0;
        }
        //遍历邻接表，根据各链表中结点的数据域存储的各顶点位置下标，在indegree数组相应位置+1
        for (int i=0; i<G.vexnum; i++) {
            ArcNode *p=G.vertices[i].firstarc;
            while (p) {
                indegree[p->adjvex]++;
                p=p->nextarc;
            }
        }
    }
    void TopologicalSort(ALGraph G){
        int indegree[G.vexnum];//创建记录各顶点入度的数组
        FindInDegree(G,indegree);//统计各顶点的入度
        //建立栈结构，程序中使用的是链表
        stack *S;
        initStack(&S);
        //查找度为0的顶点，作为起始点
        for (int i=0; i<G.vexnum; i++) {
            if (!indegree[i]) {
                push(S, i);
            }
        }
        int count=0;
        //当栈为空，说明排序完成
        while (!StackEmpty(*S)) {
            int index;
            //弹栈，并记录栈中保存的顶点所在邻接表数组中的位置
            pop(S,&index);
            printf("%d",G.vertices[index].data);
            ++count;
            //依次查找跟该顶点相链接的顶点，如果初始入度为1，当删除前一个顶点后，该顶点入度为0
            for (ArcNode *p=G.vertices[index].firstarc; p; p=p->nextarc) {
                VertexType k=p->adjvex;
                if (!(--indegree[k])) {
                    //顶点入度为0，入栈
                    push(S, k);
                }
            }
        }
        //如果count值小于顶点数量，表明该有向图有环
        if (count<G.vexnum) {
            printf("该图有回路");
            return;
        }
    }
    int main(){
        ALGraph *G;
        CreateAOV(&G);//创建AOV网
        TopologicalSort(*G);//进行拓扑排序
        return  0;
    }
    ```
