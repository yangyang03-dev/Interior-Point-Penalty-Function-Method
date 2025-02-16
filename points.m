function maximize_L()
    % 定义要求得的最大值函数
    objFunc = @(xy) -((175^3)/((xy(1)-416)^2+(xy(2)-61)^2) + (200^3)/((xy(1)-496)^2+(xy(2)-866)^2) + (180^3)/((xy(1)-631)^2+(xy(2)-1212)^2));
    % 定义不等式约束关系
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    nonlcon = @(xy) constraints(xy);
    % 定义初始点
    x0 = [600; 600];
    % 设置内点法算法
    options = optimoptions('fmincon', 'Algorithm', 'interior-point', 'Display', 'iter','ConstraintTolerance',5);
    % 求解优化问题
    [xy_opt, L_opt] = fmincon(objFunc, x0, A, b, Aeq, beq, [], [], nonlcon, options);
    % 显示最优解
    disp("Optimal x, y values:");
    disp(xy_opt);
    disp("Optimal L value:");
    disp(-L_opt);
end
function [c, ceq] = constraints(xy)
    % Define the inequality constraints
    c = [point_line_distance(xy(1), xy(2), -3.19, 1676.54) - 175;
         point_line_distance(xy(1), xy(2), 0.586, -128.79) - 200;
         point_line_distance(xy(1), xy(2), -0.135, 1065.555) - 180];
    ceq = [];
end
function distance = point_line_distance(x, y, m, b)
    % 计算点的距离
    % 计算点到直线的距离
    distance = abs(m*x - y + b) / sqrt(m^2 + 1);
end