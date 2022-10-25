zsh=randn(66,1); % 8电极共有28个电测量值；randn：高斯分布；rand:均匀分布。
 zsh=zsh/std(zsh);  % std(A),用于求向量A的标准差，或者矩阵A中各列元素的标准差；
 zsh=zsh-mean(zsh);  %产生均值为0，标准差为1的噪声
 save zaosheng1.mat zsh