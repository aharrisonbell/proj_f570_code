function f570_cell_progression
global xldata monkeyname hmiconfig S_xldata W_xldata anterior posterior

figure; clf; cla; % grouped bar graph showing progression of selectivity in each subject
svnp(1)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'>=0.05));
svnp(2)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'>=0.05));
svnp(3)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'<0.05));
svnp(4)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'>=0.05));
svnp(5)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'<0.05));
svnp(6)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'<0.05));
svnp(7)=length(find(ismember(S_xldata.apindex(:,1),posterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'<0.05));

svna(1)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'>=0.05));
svna(2)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'>=0.05));
svna(3)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'<0.05));
svna(4)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'>=0.05));
svna(5)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'>=0.05 & S_xldata.anova_gd'<0.05));
svna(6)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'>=0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'<0.05));
svna(7)=length(find(ismember(S_xldata.apindex(:,1),anterior)==1 & S_xldata.validface<0.05 & strcmp(S_xldata.confneur,'Sensory')==1 & S_xldata.anova_fe'<0.05 & S_xldata.anova_id'<0.05 & S_xldata.anova_gd'<0.05));

wvnp(1)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'>=0.05));
wvnp(2)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'>=0.05));
wvnp(3)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'<0.05));
wvnp(4)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'>=0.05));
wvnp(5)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'<0.05));
wvnp(6)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'<0.05));
wvnp(7)=length(find(ismember(W_xldata.apindex(:,1),posterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'<0.05));

wvna(1)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'>=0.05));
wvna(2)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'>=0.05));
wvna(3)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'<0.05));
wvna(4)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'>=0.05));
wvna(5)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'>=0.05 & W_xldata.anova_gd'<0.05));
wvna(6)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'>=0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'<0.05));
wvna(7)=length(find(ismember(W_xldata.apindex(:,1),anterior)==1 & W_xldata.validface<0.05 & strcmp(W_xldata.confneur,'Sensory')==1 & W_xldata.anova_fe'<0.05 & W_xldata.anova_id'<0.05 & W_xldata.anova_gd'<0.05));


subplot(1,2,1)
grouped_dataset=zeros(3,3);
grouped_dataset(1,1)=vnp(1)/sum(vnp([1 4 5 7])); % fe
grouped_dataset(2,1)=vnp(2)/sum(vnp([2 4 6 7])); % id
grouped_dataset(3,1)=vnp(3)/sum(vnp([3 5 6 7])); % gd
grouped_dataset(1,2)=vna(1)/sum(vna([1 4 5 7])); % fe
grouped_dataset(2,2)=vna(2)/sum(vna([2 4 6 7])); % id
grouped_dataset(3,2)=vna(3)/sum(vna([3 5 6 7])); % gd
bar(grouped_dataset,'grouped');
set(gca,'XTickLabels',{'FE','ID','GD'});
legend('Post','Ant'); ylim([0 0.8])

subplot(1,2,2)
grouped_dataset2(1,1)=svnp(1)/sum(svnp([1 4 5 7])); % fe
grouped_dataset2(1,2)=svna(1)/sum(svna([1 4 5 7])); % fe
grouped_dataset2(2,1)=svnp(2)/sum(svnp([2 4 6 7])); % id
grouped_dataset2(2,2)=svna(2)/sum(svna([2 4 6 7])); % id
grouped_dataset2(3,1)=svnp(3)/sum(svnp([3 5 6 7])); % gd
grouped_dataset2(3,2)=svna(3)/sum(svna([3 5 6 7])); % gd

grouped_dataset2(4,1)=wvnp(1)/sum(wvnp([1 4 5 7])); % fe
grouped_dataset2(4,2)=wvna(1)/sum(wvna([1 4 5 7])); % fe
grouped_dataset2(5,1)=wvnp(2)/sum(wvnp([2 4 6 7])); % id
grouped_dataset2(5,2)=wvna(2)/sum(wvna([2 4 6 7])); % id
grouped_dataset2(6,1)=wvnp(3)/sum(wvnp([3 5 6 7])); % gd
grouped_dataset2(6,2)=wvna(3)/sum(wvna([3 5 6 7])); % gd


bar(grouped_dataset2,'grouped');
set(gca,'XTickLabels',{'FES','IDS','GDS','FEW','IDW','GDW'});
legend('post','ant'); ylim([0 0.8])


subplot(2,2,3)
bar([vnp vna])
set(gca,'XTickLabels',{'FE','ID','GD'});

subplot(2,2,4)
bar([svnp svna wvnp wvna])
set(gca,'XTickLabels',{'FES','IDS','GDS','FEW','IDW','GDW'});


jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig352_IntersectingPathways.jpg'];
print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
export_fig Faces570_Fig352_IntersectingPathways.eps -eps -transparent -rgb
    
    figure; clf; cla; % grouped bar graph showing progression of selectivity
    vn1p(1)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
    vn1p(2)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn1p(3)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn1p(4)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn1p(5)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn1p(6)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    vn1p(7)=length(find(ismember(xldata.apindex(:,1),[5 6 7])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    
    vn2p(1)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
    vn2p(2)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn2p(3)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn2p(4)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn2p(5)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn2p(6)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    vn2p(7)=length(find(ismember(xldata.apindex(:,1),[8 9 10])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    
    vn1a(1)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
    vn1a(2)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn1a(3)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn1a(4)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn1a(5)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn1a(6)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    vn1a(7)=length(find(ismember(xldata.apindex(:,1),[14 15 16])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    
    vn2a(1)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'>=0.05));
    vn2a(2)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn2a(3)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn2a(4)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'>=0.05));
    vn2a(5)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'>=0.05 & xldata.anova_gd'<0.05));
    vn2a(6)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'>=0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    vn2a(7)=length(find(ismember(xldata.apindex(:,1),[17 18 19])==1 & xldata.validface<0.05 & strcmp(xldata.confneur,'Sensory')==1 & xldata.anova_fe'<0.05 & xldata.anova_id'<0.05 & xldata.anova_gd'<0.05));
    
    subplot(1,2,1)
    grouped_dataset=zeros(3,3);
    grouped_dataset(1,1)=vn1p(1)/sum(vn1p([1 4 5 7])); % fe
    grouped_dataset(2,1)=vn1p(2)/sum(vn1p([2 4 6 7])); % id
    grouped_dataset(3,1)=vn1p(3)/sum(vn1p([3 5 6 7])); % gd
    grouped_dataset(1,2)=vn2p(1)/sum(vn2p([1 4 5 7])); % fe
    grouped_dataset(2,2)=vn2p(2)/sum(vn2p([2 4 6 7])); % id
    grouped_dataset(3,2)=vn2p(3)/sum(vn2p([3 5 6 7])); % gd
    grouped_dataset(1,3)=vn1a(1)/sum(vn1a([1 4 5 7])); % fe
    grouped_dataset(2,3)=vn1a(2)/sum(vn1a([2 4 6 7])); % id
    grouped_dataset(3,3)=vn1a(3)/sum(vn1a([3 5 6 7])); % gd
    grouped_dataset(1,4)=vn2a(1)/sum(vn2a([1 4 5 7])); % fe
    grouped_dataset(2,4)=vn2a(2)/sum(vn2a([2 4 6 7])); % id
    grouped_dataset(3,4)=vn2a(3)/sum(vn2a([3 5 6 7])); % gd
    bar(grouped_dataset,'grouped');
    set(gca,'XTickLabels',{'FE','ID','GD'});
    legend('Post(5-7)','Post(8-10)','Ant(14-16)','Ant(17-19)'); ylim([0 0.8])
    
    
    
    jpgfigname=[hmiconfig.figurepath,filesep,'Faces570_Fig352_IntersectingPathways.jpg'];
    print(gcf,jpgfigname,'-djpeg') % generates an JPEG file of the figure
    export_fig Faces570_Fig352_IntersectingPathways.eps -eps -transparent -rgb

return