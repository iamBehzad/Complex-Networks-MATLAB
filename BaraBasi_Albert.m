%Author By Behzad Abbasi - 1401-02-25 - IAU Shabestar 
%Supervisor Dr B.Zarei

clc
clear all
close all

n=100;
m0=5;
m=4;

nodes = (1:m0);
edges = nchoosek(nodes, 2);
G=graph(edges(:,1),edges(:,2));

% p=zeros(n-1);
for i = m0+1:n
    G=G.addnode(1);
    for j=1:m
        %Calculate Possibilities of nodes
        deg = degree(G);
        p=deg(1:i-1)./(sum(deg(1:i-1)));
        
        %y=RouletteWheelSelection(P)
        c=cumsum(p);
        r=rand;
        y=find(r<=c,1,'first');
        
        while (findedge(G,i ,y))
            r=rand;
            y=find(r<=c,1,'first');
        end
        G=G.addedge(i,y);
    end
end

d=[];
colormap hsv
figure(1);
subplot(1,2,1)

deg = degree(G);
nSizes = 2*sqrt(deg-min(deg)+0.2);
nColors = deg;
plot(G,'MarkerSize',nSizes,'NodeCData',nColors,'EdgeAlpha',0.1)
title(['Barabasi Albert Graph with $N = ' num2str(n)] )
colorbar

%     subplot(4,2,2*(i))

subplot(1,2,2)
histogram(degree(G),'BinMethod','integers','FaceAlpha',0.9);
title('Node degree distributions for BaraBasi_Albert Model Graphs')
xlabel('Degree of node')
ylabel('Number of nodes')

h=20;
d = [d ; mean(mean(distances(G))), nnz(degree(G)>=h)];

cc=avgClusteringCoefficient(G.adjacency);

T = table(cc, d(:,1), d(:,2),...
    'VariableNames',{'Global Clustering Coefficient','AvgPathLength','NumberOfHubs'})

