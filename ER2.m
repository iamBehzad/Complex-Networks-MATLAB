%Author By Behzad Abbasi - 1401-02-25 
clc
clear all
close all

n=10;
m=50;
ER(n,m);

function g=ER(n,m)
g=graph();
g=g.addnode(n);
for i=1:m
    s=randi([1,n]);
    t=randi([1,n]);
    while (s==t)
        t=randi([1,n]);
    end
    g=g.addedge(s,t);
end
plt = plot (g);
plt.NodeCData = degree(g);
plt.MarkerSize = 2*degree(g);
plt.Marker= 'o';
plt.EdgeColor = [1 0 0];
plt.LineWidth = 1.5;
plt.LineStyle = '-';
colorbar
end
