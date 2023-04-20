%Author By Behzad Abbasi - 1401-02-25 - IAU Shabestar 
%Supervisor Dr B.Zarei

clc
clear all
close all

N = 500;
K = 25;
G=graph;

Beta = [0 0.15,0.5,1];
for i = 1:numel(Beta)
    h(i).s = repelem((1:N)',1,K);
    h(i).t =  h(i).s + repmat(1:K,N,1);
    h(i).t = mod( h(i).t-1,N)+1;
    h(i).beta = Beta(i);
    % Rewire the target node of each edge with probability beta
    for source=1:N
        switchEdge = rand(K, 1) <  h(i).beta;
        
        newTargets = rand(N, 1);
        newTargets(source) = 0;
        newTargets(h(i).s(h(i).t==source)) = 0;
        newTargets(h(i).t(source, ~switchEdge)) = 0;
        
        [~, ind] = sort(newTargets, 'descend');
        h(i).t(source, switchEdge) = ind(1:nnz(switchEdge));
    end
end

n = 55;
d=[];
cc=[];
colormap hsv

for i=1:numel(Beta)
    
%     figure(1);
%     subplot(4,2,2*(i)-1)

    figure(i);
    subplot(1,2,1)
    
    G = graph(h(i).s,h(i).t);
    deg = degree(G);
    nSizes = 2*sqrt(deg-min(deg)+0.2);
    nColors = deg;
    plot(G,'MarkerSize',nSizes,'NodeCData',nColors,'EdgeAlpha',0.1)
    title(['Watts-Strogatz Graph with $N = ' num2str(N) '$ nodes, $K = ' num2str(K)...
        '$, and $\beta = ' num2str(h(i).beta) ' $'] , 'Interpreter','latex')
    colorbar
    
%     subplot(4,2,2*(i))
        
    subplot(1,2,2)
    histogram(degree(G),'BinMethod','integers','FaceAlpha',0.9);
    title('Node degree distributions for Watts-Strogatz Model Graphs')
    xlabel('Degree of node')
    ylabel('Number of nodes')
    legend(['\beta = ' num2str(Beta(i)) ],'Location','NorthWest')
    

    d = [d ; mean(mean(distances(G))), nnz(degree(G)>=n)];
    cc=[cc;avgClusteringCoefficient(G.adjacency)];
end

T = table(Beta', cc, d(:,1), d(:,2),...
    'VariableNames',{'Beta','Global Clustering Coefficient','AvgPathLength','NumberOfHubs'})
