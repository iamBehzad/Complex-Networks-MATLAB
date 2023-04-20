clc
clear
close all

G_csv=readmatrix('karate_G.csv');
s=G_csv(:,1)' + 1 ;
t=G_csv(:,2)' + 1;

G=graph(s,t);

colormap hsv

figure(1);
N= numnodes(G);
deg = degree(G);
nSizes = 2*sqrt(deg-min(deg)+0.2);
nColors = deg;
plot(G,'MarkerSize',nSizes,'NodeCData',nColors,'EdgeAlpha',0.1)
title(['Karate Club Graph with $N = ' num2str(N)])
colorbar


deg_ranks = centrality(G,'degree');
[deg_ranks, SortOrder]=sort(deg_ranks,'descend');
Degree_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(deg_ranks(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

closeness_ranks = centrality(G,'closeness');
[closeness_ranks, SortOrder]=sort(closeness_ranks,'descend');
Closeness_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(closeness_ranks(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

betweenness_ranks = centrality(G,'betweenness');
[betweenness_ranks, SortOrder]=sort(betweenness_ranks,'descend');
Betweenness_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(betweenness_ranks(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

eigenvector_ranks = centrality(G,'eigenvector');
[eigenvector_ranks, SortOrder]=sort(eigenvector_ranks,'descend');
Eigenvector_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(eigenvector_ranks(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

page_ranks = centrality(G,'pagerank');
[page_ranks, SortOrder]=sort(page_ranks,'descend');
PageRanks_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(page_ranks(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

[acc , CC_rank]=avgClusteringCoefficient(G.adjacency);
[CC_rank, SortOrder]=sort(CC_rank,'descend');
ClusteringCoef_Node = cellfun( @(x,y) [num2str(x),'->',num2str(y)], num2cell(CC_rank(1:5)), num2cell(SortOrder(1:5)), 'UniformOutput', false );

Centrality = table(Degree_Node,Closeness_Node,Betweenness_Node,Eigenvector_Node,PageRanks_Node,ClusteringCoef_Node)



