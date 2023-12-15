function system_of_odes
    % Define the time range for the solution
    t_span = [0 10];
    
    % Define the initial conditions
    initial_conditions = [4, 2/3; 4, 4/3; 4, 2; 4, 8/3; 4, 10/3; 4, 4; 4, 0; 4, -2/3; 4, -4/3];
    
    % Create a new figure
    figure;
    hold on;
    
    % Solve the ODEs for each set of initial conditions with the first modification and plot the results
    for i = 1:size(initial_conditions, 1)
        ic = initial_conditions(i, :);
        [t, y] = ode45(@(t, y) odes_mod1(t, y), t_span, ic, odeset('RelTol', 1e-6, 'AbsTol', 1e-6));
        plot(y(:, 1), y(:, 2), 'b'); % Plot with blue color for the first modification
    end
    
    % Solve the ODEs for each set of initial conditions with the second modification and plot the results
    for i = 1:size(initial_conditions, 1)
        ic = initial_conditions(i, :);
        [t, y] = ode45(@(t, y) odes_mod2(t, y), t_span, ic, odeset('RelTol', 1e-6, 'AbsTol', 1e-6));
        plot(y(:, 1), y(:, 2), 'r'); % Plot with red color for the second modification
    end
    
    % Plot the line x1 = x2 from -10 to 10
    x = linspace(-1, 6, 100);
    plot(x, x, '--k');
 % Plot the line x2 = x1 + 0.9/4 in blue
plot(x, x + 0.9/4, 'b');

% Plot the line x2 = x1 + 9/4 in red
plot(x, x + 9/4, 'r');
    
    % Customize the plot
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Space Trajectories');
    legend('Mod1: \dot{x}_2 = x_1 - 2x_2 - 11 + 3sin(t)', 'Mod2: \dot{x}_2 = x_1 - 2x_2 - 2 + 3sin(t)', 'Line x_1 = x_2');
    grid on;
    hold off;
end

% First modification of the system of ODEs
function dydt = odes_mod1(t, y)
    dydt = [-y(2); y(1) - 2*y(2) - 1 + 3*sin(t) - 10];
end

% Second modification of the system of ODEs
function dydt = odes_mod2(t, y)
    dydt = [-y(2); y(1) - 2*y(2) - 1 + 3*sin(t) - 1];
end
