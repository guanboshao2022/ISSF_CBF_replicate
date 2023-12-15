function system_of_odes
    % Define the time range for the solution
    t_span = [0 10];
    t_eval = linspace(0, 10, 1000); % Define the times at which the solution is output
    
    % Define the initial conditions
    initial_conditions = [4, 2/3; 4, 4/3; 4, 2; 4, 8/3; 4, 10/3; 4, 4; 4, 0; 4, -2/3; 4, -4/3];
    
    % Create a new figure
    figure;
    hold on;
    
    % Solve the ODEs for each set of initial conditions and plot the results
    for i = 1:size(initial_conditions, 1)
        ic = initial_conditions(i, :);
        
        % Solve the ODEs with refined time steps
        [t, y] = ode45(@(t, y) odes(t, y), t_span, ic, odeset('RelTol', 1e-6, 'AbsTol', 1e-6));
        
        % Plot the trajectories
        plot(y(:, 1), y(:, 2));
    end
    
    % Plot the line x1 = x2
    x = linspace(min(get(gca, 'XLim')), max(get(gca, 'XLim')), 100);
    plot(x, x, '--k');
    
    % Customize the plot
    xlabel('x_1');
    ylabel('x_2');
    title('Phase Space Trajectories');
    legend(arrayfun(@(i) sprintf('Initial: (%g, %g)', initial_conditions(i, :)), 1:size(initial_conditions, 1), 'UniformOutput', false));
    grid on;
    hold off;
end

function dydt = odes(t, y)
    % Define the system of ODEs with the modified equation
    dydt = [-y(2); y(1) - 2*y(2) - 1 + 3*sin(t)];
end
