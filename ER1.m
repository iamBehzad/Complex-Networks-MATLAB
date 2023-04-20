%Author By Behzad Abbasi - 1401-02-25 - IAU Shabestar 
%Supervisor Dr B.Zarei

clc
clear all
close all

n=10;
p=0.3;
ER(n,p);

function g=ER(n,p)

g=graph();
g=g.addnode(n);

for i=1:n
    for j=1:n
        if i==j
            continue
        end
        r=rand;
        if(r<=p)
            g=g.addedge(i,j);
        end
    end
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
