s = sim("task1model.slx");

figure;
title("Исходная система");
hold on;

plot(s.tout, s.x.Data, LineWidth=1.2, DisplayName='$x$');
plot(s.tout, s.y.Data, LineStyle='--', LineWidth=1.2, DisplayName='$y$');

legend("show", Interpreter="latex");
xlabel("$t$", Interpreter="latex");
ylabel("Переменная состояния");

saveas(gcf, 'task1_orig.png', 'png');


figure;
title("Линеризованная система");
hold on;

plot(s.tout, s.xlin.Data, LineWidth=1.2, DisplayName='$x$');
plot(s.tout, s.ylin.Data, LineStyle='--', LineWidth=1.2, DisplayName='$y$');

legend("show", Interpreter="latex");
xlabel("$t$", Interpreter="latex");
ylabel("Переменная состояния");

saveas(gcf, 'task1_lin.png', 'png');