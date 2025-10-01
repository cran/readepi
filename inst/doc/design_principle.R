## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>"
)

## ----login, fig.align='center', echo=FALSE------------------------------------
DiagrammeR::grViz("digraph{
 
      graph[rankdir = LR]
  
      node[shape = rectangle, style = filled, fontname = Courier,
      align = center]
  
      subgraph cluster_0 {
        graph[shape = rectangle]
        style = rounded
        bgcolor = LightBlue
    
        label = 'Arguments for login() function'
        node[shape = rectangle, fillcolor = LemonChiffon, margin = 0.25]
        A[label = 'type: the source name']
        B[label = 'from: the URL, or IP address, or hostname']
        C[label = 'user_name: the user name']
        D[label = 'password: the password or API token or key']
        E[label = 'db_name: the database name (RDBMS only)']
        F[label = 'port: the port id (RDBMS only)']
        G[label = 'driver_name: the driver name (RDBMS only)']
      }
      
}")

