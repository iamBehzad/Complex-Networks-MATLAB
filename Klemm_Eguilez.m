%Author By Behzad Abbasi - 1401-02-25 

clc
clear all
close all

n=200;
m=5;
mu=0.3;

nodes = (1:m);
edges = nchoosek(nodes, 2);
G=graph(edges(:,1),edges(:,2));

ActiveNodes=nodes;

for i = m+1:n
    G=G.addnode(1);
    if(rand<mu)
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
    else
        for k = ActiveNodes
            G=G.addedge(i,k);
        end
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
title(['Klemm_Eguilez Graph with $N = ' num2str(n)] )
colorbar

subplot(1,2,2)
histogram(degree(G),'BinMethod','integers','FaceAlpha',0.9);
title('Node degree distributions for Klemm_Eguilez Model Graphs')
xlabel('Degree of node')
ylabel('Number of nodes')

h=20;
d = [d ; mean(mean(distances(G))), nnz(degree(G)>=h)];
% cc=0;
cc=avgClusteringCoefficient(G.adjacency);

T = table(cc, d(:,1), d(:,2),...
    'VariableNames',{'Global Clustering Coefficient','AvgPathLength','NumberOfHubs'})

