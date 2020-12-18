function createfigure(cdata1)
%CREATEFIGURE(cdata1)
%  CDATA1:  image cdata

%  Auto-generated by MATLAB on 08-Dec-2020 13:38:04

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create image
image(cdata1,'Parent',axes1,'CDataMapping','scaled');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0.5 128.5]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.5 401.5]);
box(axes1,'on');
grid(axes1,'on');
axis(axes1,'ij');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'GridAlpha',1,'Layer','top','MinorGridAlpha',1,'YMinorGrid','on');
set(figure1, 'position', [10, 10, 1210, 810]);
