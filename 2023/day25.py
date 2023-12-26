import networkx as nx

G = nx.Graph()

# lines = open('test25.txt').readlines()
lines = open('input25.txt').readlines()

for line in lines:
    src, *to = line.strip().replace(":", "").split(" ")
    for dst in to:
        G.add_edge(src, dst)


edges = nx.minimum_edge_cut(G)

G.remove_edges_from(edges)


result = 1
for cmp in nx.connected_components(G):
    result *= len(cmp)
print(result)


