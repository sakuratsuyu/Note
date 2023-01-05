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
            The maximum connected subgraph
    - **Directed graph**  
        - **Strongly connectedd**  
          For every pair of $v_i$ and $v_j$ in $V(G)$, there exist directed paths from $v_i$ to $v_j$ and from $v_j$ to $v_i$
        - **Weakly connected**  
          The graph is connected without direction to the edges
        - **Strongly connected component**  
          The maximum subgraph that is strongly connected

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

!!! note
    Feasible AOV network must be a **dag**

!!! definition
    A **topological order** is a linear ordering of the vertices of a graph such that, for any two vertices, $i,j$, if $i$ is a predecessor of $j$ in the network then $i$ precedes $j$ in the linear ordering

??? code "Topological Sort"

    ```C
    #include <stdio.h>
    #include <stdlib.h>
    #define  MAX_VERTEX_NUM 20
    #define  VertexType int
    typedef enum{false,true} bool;
    typedef struct ArcNode{
        int adjvex;
        struct ArcNode * nextarc
    }ArcNode;
    typedef struct VNode{
        VertexType data;
        ArcNode * firstarc;
    }VNode,AdjList[MAX_VERTEX_NUM];
    typedef struct {
        AdjList vertices;
        int vexnum,arcnum;
    }ALGraph;
    int LocateVex(ALGraph G,VertexType u){
        for (int i=0; i<G.vexnum; i++) {
            if (G.vertices[i].data==u) {
                return i;
            }
        }
        return -1;
    }
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
    typedef struct stack{
        VertexType data;
        struct stack * next;
    }stack;
    void initStack(stack* *S){
        (*S)=(stack*)malloc(sizeof(stack));
        (*S)->next=NULL;
    }
    bool StackEmpty(stack S){
        if (S.next==NULL) {
            return true;
        }
        return false;
    }
    void push(stack *S,VertexType u){
        stack *p=(stack*)malloc(sizeof(stack));
        p->data=u;
        p->next=NULL;
        p->next=S->next;
        S->next=p;
    }
    void pop(stack *S,VertexType *i){
        stack *p=S->next;
        *i=p->data;
        S->next=S->next->next;
        free(p);
    }
    void FindInDegree(ALGraph G,int indegree[]){
        for (int i=0; i<G.vexnum; i++) {
            indegree[i]=0;
        }
        for (int i=0; i<G.vexnum; i++) {
            ArcNode *p=G.vertices[i].firstarc;
            while (p) {
                indegree[p->adjvex]++;
                p=p->nextarc;
            }
        }
    }
    void TopologicalSort(ALGraph G){
        int indegree[G.vexnum];
        FindInDegree(G,indegree);
        stack *S;
        initStack(&S);
        for (int i=0; i<G.vexnum; i++) {
            if (!indegree[i]) {
                push(S, i);
            }
        }
        int count=0;
        while (!StackEmpty(*S)) {
            int index;
            pop(S,&index);
            printf("%d",G.vertices[index].data);
            ++count;
            for (ArcNode *p=G.vertices[index].firstarc; p; p=p->nextarc) {
                VertexType k=p->adjvex;
                if (!(--indegree[k])) {
                    push(S, k);
                }
            }
        }

        if (count<G.vexnum) {
            printf("There is cycle");
            return;
        }
    }
    int main(){
        ALGraph *G;
        CreateAOV(&G);
        TopologicalSort(*G);
        return  0;
    }
    ```

## Shortest Path Algorithms

!!! definition
    Given a digraph $G=(V,E)$, and a cost function $c(e)$ for $e\in E(G)$. The **length** of a path $P$ from *source* to *destination* is $\Sigma_{e_i\subset P}\ c(e_i)$ (also called *weighted path length*)

### Unweight Shortest Paths

It is a **breadth-first search (BFS)** algorithm, which used to find how many vertices from *source* to *destination*

??? code "Improved Unweighted Shortest Paths"

    ```C
    typedef struct {
        int Dist; // distance from s to v_i
        int Known; // 1 if v_i is checked or 0 if not
        int Path; // for tracking the path
    } Table[MAXN];

    void Unweighted(Table T)
    {
        Queue Q;
        Vertex V,W;
    
        Q = CreateQueue(NumVertex);
        MakeEmpty(Q);
        Enqueue(S,Q);//S is the start Vertex
    
        while(!IsEmpty(Q))
        {
            V = Dequeue(Q);
            T[V].Known=True;
            for each W adjacent to V
                if(T[W].Dist == Infinity)
                {
                    T[W].Dist = T[V].Dist+1;
                    T[W].Path = V;
                    Enqueue(W,Q);
                }
        }
        Free(Q);
    }
    ```

### Dijkstra's Algorithm

This is a algorithm for **weighted shortest paths**.  

!!! note
    Let $S=${$s$ and $v_i's$ whose shortest paths have been found}  
    For any $u\notin S$, define *distance[u]=minimal length of path $\{ s\rightarrow(v_i\in S)\rightarrow u \}$*. If the paths are generated in *non-decreasing* order, then  

    1. the shortest path must go through ==**ONLY**== $v_i\in S$
    2. $u$ is chosen so that distance[u] = min{$w\notin S$|distance[w]} (If $u$ is not unique, then we may select any of them) 
    > Greedy Method
    3. if distance$[u_1]$ < distance$[u_2]$ and we add $u_1$ into $S$, then distance$[u_2]$ may change. If so, a shorter path from $s$ to $u_2$ must go through $u_1$ and distance'$[u_2]$=distance$[u_1]$+length($<u_1,u_2>$)

??? code "Dijkstra's Algorithm"

    ```C
    #include <stdio.h>
    #define INF 10000000
    #define MaxSize 50
    int graph[MaxSize][MaxSize];
    int dis[MaxSize];
    int visit[MaxSize];
    int prevetrix[MaxSize];

    void dij(int n)
    {    
        int count = 0;          //the number of vertices that have been computed
        visit[0] = 1;    
        prevetrix[0] = 0;    
        count++;    
        for (int i = 1; i < n; i++)    //initialize
        {        
            dis[i] = graph[0][i];        
            prevetrix[i] = 0;    
        }    
        while (count < n)    
        {        
            int min = INF, target_index;        
            for (int i = 1; i < n; i++)        
            {            
                if (visit[i] == 0 && min > dis[i])         //找到距离源点最短的顶点target_index
                {                
                    min = dis[i];                
                    target_index = i;            
                }        
            }        
            visit[target_index] = 1;        
            count++;        
            for (int i = 1; i < n; i++)        
            {            
                if (visit[i] == 0 && dis[target_index] + 
                graph[target_index][i] < dis[i])            //更新
                {                
                    dis[i] = dis[target_index] + graph[target_index][i];
                    prevetrix[i] = target_index;            
                }        
            }    
        }
    }
    ```
    This implement's time complexity is $O(|V|^2+|E|)$. It can be optimized by using priority_queue to store the set $S$, whose time complexity is $O(|E|\log|V|)$. You can search it by yourself.

!!! warning

    By allowing the used vertices being pushed into the set $S$ again, we can get a algorithm that deals with negative edges well  
    However, it may leads to infinite loop

### Acyclic Graph

If the graph is acyclic, vertices may be selected in **topological order** since when a vertex is selected, its distance can no longer be lowered without any incoming edges from unknown nodes

$T=O(|E|+|V|)$ and no priority queue is needed

### All-Paiirs Shortest Path Problem

- Use **single-source algorithm** for $|V|$ times with $T=O(|V|^3)$ - works fast on sparse garph
- Another $O(|V|^3)$ algorithm in book's Chapter 10 - works faster on dense graphs

## Network Flow Problems

!!! definition

    Determine the maximum amount of flow that can pass from a node $s$ to another node $t$

    **Augmenting Path**: A path from $s$ to $t$, with each edge usinig the minimum weight of edges in the path

For each edge $(v,w)$ with flow $f_{v,w}$ in $G_f$ (*the flow graph*), add an edge $(w,v)$ with flow $f_{v,w}$ in $G_r$ (*the residual graph*)

!!! example

    <img src="../Pic/graph_2.png"></img>  
    For the graph above, the $G_r$ is initialized with flows like $G$ to represent the allowed flows.  

    We first find the blue augmenting path from $s$ to $t$ in $G_f$ and use it to draw reverse flow from $t$ to $s$ in $G_r$. At the procedure, we change the number of allowed flows according to the drawed flows.  
    
    Then we find the purples augmenting path (the path may be different if using different method) and draw the corresponded reverse flows. If their direction conflict with existed flows, compute the sum or the result of division and the new allowed number of flows.

If the edge capabilities are **rational numbers**, this algorithm always terminate wit a maxmum flow.

!!! note
    The algorithm works for $G$ with **cycles** as well

- An augmenting path can be found by an unweighted shortest path algorithm, $T=O(f\cdot|E|)$, where $f$ is the maximum flow
- Always choose the augmenting path that allows the largest increase in flow (*modify Dijkstra's algorithm*)
  $\begin{aligned}
    T&=T_{augmentation}*T_{find a path}\\
    &=O(|E|\log cap_{max})*O(|E|\log|V|)\\
    &=O(|E|^2\log|V|)
    \end{aligned}$, if $cap_{max}$ is a small integer
- Always choose the augmenting path that has the least number of edges (*unweighted shortest path algorithm*)
  $\begin{aligned}
    T&=T_{augmentation}*T_{find a path}\\
    &=O(|E|)*O(|E|\cdot|V|)\\
    &=O(|E|^2|V|)
  \end{aligned}$  
!!! note

    If every $v\notin {s,t}$ has either a single incoming edge of capacity 1 or a single outgoing edge of capacity 1, then time bound is reduced to $O(|E||V|^{1/2})$

!!! note

    The **min-cost flow** problem is to find, among all maximum flows, the one flow of minimum cost provided that each edge has a cost per unit of flow

## Minimum Spanning Tree

!!! definition

    A **spanning tree** of a graph $G$ is a **tree** which consists of $V(G)$ and a subset of $E(G)$

!!! note

    - The minimum spanning tree is a *tree* since it is acyclic -- the number of edges is $|V|-1$
    - It is *minimum* for the total cost of edges is minimized
    - It is *spanning* because it covers every vertex
    - A minimum spanning tree exists iff $G$ is *connected*
    - Adding a non-tree edge to a spanning tree, we obtain a *cycle*

### Prim's Algorithm

Very similar to Dijkstra's algorithm, it can be descriped as growing a tree  
$T=O(|E|\log|V|)$

??? code "Prim's Algorithm"

    ```C
    int G[MAX][MAX],spanning[MAX][MAX],n;
    
    int prims()
    {
        int cost[MAX][MAX];
        int u,v,min_distance,distance[MAX],from[MAX];
        int visited[MAX],no_of_edges,i,min_cost,j;
        
        //create cost[][] matrix,spanning[][]
        for(i=0;i<n;i++)
            for(j=0;j<n;j++)
            {
                if(G[i][j]==0)
                    cost[i][j]=infinity;
                else
                    cost[i][j]=G[i][j];
                    spanning[i][j]=0;
            }
            
        //initialise visited[],distance[] and from[]
        distance[0]=0;
        visited[0]=1;
        
        for(i=1;i<n;i++)
        {
            distance[i]=cost[0][i];
            from[i]=0;
            visited[i]=0;
        }
        
        min_cost=0; //cost of spanning tree
        no_of_edges=n-1; //no. of edges to be added
        
        while(no_of_edges>0)
        {
            //find the vertex at minimum distance from the tree
            min_distance=infinity;
            for(i=1;i<n;i++)
                if(visited[i]==0&&distance[i]<min_distance)
                {
                    v=i;
                    min_distance=distance[i];
                }
                
            u=from[v];
            
            //insert the edge in spanning tree
            spanning[u][v]=distance[v];
            spanning[v][u]=distance[v];
            no_of_edges--;
            visited[v]=1;
            
            //updated the distance[] array
            for(i=1;i<n;i++)
                if(visited[i]==0&&cost[i][v]<distance[i])
                {
                    distance[i]=cost[i][v];
                    from[i]=v;
                }
            
            min_cost=min_cost+cost[u][v];
        }
        
        return(min_cost);
    }
    ```

### Kruskal's Algorithm

It can be descriped as mantaining a forest  
$T=O(|E|\log|E|)$

??? code "Kruskal's Algorithm"

    ```C
    #include <stdio.h>
    #include <stdlib.h>
    #define VertexMax 20

    typedef char VertexType; 

    typedef struct
    {
        VertexType begin;
        VertexType end;
        int weight;
    }Edge;
    typedef struct
    {
        VertexType Vertex[VertexMax];//vertices
        Edge edge[VertexMax];//edges
        int vexnum;
        int edgenum;
    }EdgeGraph;

    void sort(EdgeGraph *E)
    {
        int i,j;
        Edge temp;
        
        for(i=0;i<E->edgenum-1;i++)
        {
            for(j=i+1;j<E->edgenum;j++)
            {
                if(E->edge[i].weight>E->edge[j].weight)
                {
                    temp=E->edge[i];
                    E->edge[i]=E->edge[j];
                    E->edge[j]=temp;
                }
            }
        }
    }

    int LocateVex(EdgeGraph *E,VertexType v)
    {
        int i;
        
        for(i=0;i<E->vexnum;i++)
        {
            if(v==E->Vertex[i])
            {
                return i; 
            } 
        } 
        
        printf("No Such Vertex!\n");
        return -1;
    }

    int FindRoot(int t,int parent[])//disjoint set
    {
        while(parent[t]>-1)
        {
            t=parent[t];
        }
        
        return t;
    }

    void MiniSpanTree_Kruskal(EdgeGraph *E)
    {
        int i;
        int num;//when num=vertices - 1, finish
        int root1,root2; 
        int LocVex1,LocVex2; 
        int parent[VertexMax];
        
        //1.
        sort(E);
        //2.
        for(i=0;i<E->vexnum;i++)
        {
            parent[i]=-1;
        }
        
        printf("\n 最小生成树(Kruskal):\n\n");
        //3.
        for(num=0,i=0;i<E->edgenum;i++)
        {
            LocVex1=LocateVex(E,E->edge[i].begin);
            LocVex2=LocateVex(E,E->edge[i].end);
            root1=FindRoot(LocVex1,parent);
            root2=FindRoot(LocVex2,parent);
        
            
            if(root1!=root2) 
            {
                printf("\t\t%c-%c w=%d\n",E->edge[i].begin,E->edge[i].end,E->edge[i].weight);//输出此边 
                parent[root2]=root1;
                num++;
                
                if(num==E->vexnum-1)
                {
                    return;
                }
            } 
        }
        
    }
    ```

## Application of Depth-First Search

!!! definition

    A generalization of preorder traversal

    ```C
    void DFSs(Vertex V)  /* this is only a template */
    {   
        visited[V] = true;  /* mark this vertex to avoid cycles */
        for (each W adjacent to V)
        {
            if (!visited[W])
            {
                DFS(W);
            }
        }
    } /* T=O(|E|+|V|) as long as adjacency lists are used */
    ```

    It should change with the purpose

- Undirected Graphs
- Biconnectivity
      - $v$ is an **articulation point** if $G'=DeleteVertex(G, v)$ has *at least 2* connected components
      - $G$ is a **biconnected graph** if $G$ is connected and has no articulation points
      - A **biconnected component** is a maximal biconnected subgraph  

    Record $Low(u)$=min{$Num(u)$, min{$Low(w)$ | $w$ is a child of $u$}, min{$Num(w)$ | $(u,w)$ is a back edge}}
    Therefore, $u$ is an *articulation point* iff

    1. $u$ is the root and has at least 2 children
    2. $u$ is not the root, and has at least 1 child such that $Low(child)\ge Num(u)$

!!! example

    <div style="display:flex; flex-direction:row; align-items:center; justify-content:center;">
        <image src="../Pic/graph_3.png"/ width="200px">
        <image src="../Pic/graph_4.png"/ width="300px" height="auto">
    </div>

??? code "Tarjan Algorithm: find the articulation points"

    ```C
    void tarjan(Mgraph G,int i)
    {
        dfn[i]=low[i]=++time;
        push(G.vexs[i]);
        ins[i]=1;
        vex v; 
        arc* p=G.vexs[i].firstarc;
        for(;p!=NULL;p=p->next)
        {
            if(dfn[p->index]==0)
            {
                tarjan(G,p->index);
                low[i]=(low[i]>low[p->index])?low[p->index]:low[i];
            }
            else if(dfn[p->index]&&ins[p->index])
            {
                low[i]=(low[i]>dfn[p->index])?dfn[p->index]:low[i];
            } 
        }
        if(dfn[i]==low[i])
        {
            printf("{ ");
            while(!is_empty())
            {
                v=pop();
                ins[v.xiabiao]=0;
                printf("%d ",v.data);
                if(v.xiabiao==i)
                    break;
            }
            printf("}\n");
        } 
    }
    ```

- Euler Circuits

**Euler tour**: A path go through all edges  
**Euler circuit**: A path go through all edges and finish at the starting point

An Euler circuit is possible only if the graph is connected and each vertex has an *even* degree  
An Euler tour is possible if there are exactly *two* vertices having odd degree. One must start at one of the odd-degree vertices

!!! note

    - The path should be maintained as a linked list
    - For each adjacency list, maintain a pointer to the last edge scanned
    - $T=O(|E|+|V|)$

!!! tip

    **Hamilton cycle**: Find a simple cycle in an undirected graph that visits every vertex 
