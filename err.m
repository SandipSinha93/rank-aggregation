function e = err(n,...Number of objects
                 w,...True score
                 wstar)...Proposed score
    %w_diff(i, j) = w(i) - w(j)
    w_diff = repmat(w, 1, n) - repmat(w', n, 1);
    wstar_diff = repmat(wstar, 1, n) - repmat(wstar', n, 1);
    error_matrix = w_diff.*w_diff.*(w_diff.*wstar_diff < 0);
    Dw = sqrt(sum(error_matrix(:))/(4*n));
    % Error2
    error2 = 1 - w'*wstar/(norm(wstar)*norm(w'));
    %DL1
    [~,sigmaGT]=sort(w);
    [~,sigma_sample]=sort(wstar);
    DL1=sum(abs(sigmaGT-sigma_sample))/n;
    e = [Dw; DL1; error2];
end