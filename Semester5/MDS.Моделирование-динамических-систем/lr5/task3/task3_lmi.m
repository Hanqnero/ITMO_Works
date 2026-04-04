%% Task 3: Lyapunov–Krasovskii LMI test (delay-independent)
% Finds P>0, Q>0 such that
% [A'P+PA+Q,  P*A1;
%  A1'*P,    -Q] < 0
% If feasible, the system is asymptotically stable for any constant delay h>=0.

clear; clc;

A  = [-2  1;
       0 -3];
A1 = [ 1  2;
       1 -2];

n = 2;

% Numerical strictness margin (helps avoid tmin ~ 0 confusion)
epsPD  = 1e-6;   % for P,Q > epsPD*I
epsPsi = 1e-6;   % for Psi < -epsPsi*I

% Build LMIs in MATLAB LMI Lab format
setlmis([]);

P = lmivar(1, [n 1]); % symmetric
Q = lmivar(1, [n 1]); % symmetric

% LMI #1: Psi < 0
% Block (1,1): A'P + P A + Q
lmiterm([1 1 1 P], A', 1, 's');
lmiterm([1 1 1 Q], 1, 1);
% Enforce Psi < -epsPsi*I by adding +epsPsi*I to the left-hand side
lmiterm([1 1 1 0], epsPsi*eye(n));

% Block (1,2): P*A1
lmiterm([1 1 2 P], 1, A1);

% NOTE: LMI Lab treats LMIs as symmetric; specifying (1,2) is enough.
% Adding an explicit (2,1) term can double-count the off-diagonal block.

% Block (2,2): -Q
lmiterm([1 2 2 Q], -1, 1);
% Lower-right block constant term for -epsPsi*I in full Psi
lmiterm([1 2 2 0], epsPsi*eye(n));

% LMI #2: P > epsPD*I  (i.e. -P + epsPD*I < 0)
lmiterm([2 1 1 P], -1, 1);
lmiterm([2 1 1 0], epsPD*eye(n));

% LMI #3: Q > epsPD*I  (i.e. -Q + epsPD*I < 0)
lmiterm([3 1 1 Q], -1, 1);
lmiterm([3 1 1 0], epsPD*eye(n));

lmisys = getlmis;

% Solve feasibility problem
options = [1e-8, 300, 0, 0, 1]; % [tol, maxiter, 0, 0, 1] => trace print
[tmin, xfeas] = feasp(lmisys, options);

fprintf('tmin = %g\n', tmin);

% Only decode and check margins when feasp returns a candidate vector.
if ~isempty(xfeas)
    Pmat = dec2mat(lmisys, xfeas, P);
    Qmat = dec2mat(lmisys, xfeas, Q);

    Psi = [A'*Pmat + Pmat*A + Qmat, Pmat*A1;
           A1'*Pmat,               -Qmat];

    eigP   = eig((Pmat+Pmat')/2);
    eigQ   = eig((Qmat+Qmat')/2);
    eigPsi = eig((Psi+Psi')/2);

    fprintf('min eig(P)   = %.3e\n', min(eigP));
    fprintf('min eig(Q)   = %.3e\n', min(eigQ));
    fprintf('max eig(Psi) = %.3e\n', max(eigPsi));

    if (min(eigP) > epsPD/10) && (min(eigQ) > epsPD/10) && (max(eigPsi) < -epsPsi/10)
        fprintf('Feasible (with margin). System is asymptotically stable (delay-independent).\n');
        disp('P = '); disp(Pmat);
        disp('Q = '); disp(Qmat);
    elseif tmin < 1e-10
        fprintf(['Near-feasible (tmin ~ 0). This is usually numerical; ', ...
                 'check eigenvalue margins printed above.\n']);
        disp('P = '); disp(Pmat);
        disp('Q = '); disp(Qmat);
    else
        fprintf('No feasible solution found with these settings.\n');
    end
else
    fprintf('No feasible solution found with these settings (no candidate returned).\n');
end
