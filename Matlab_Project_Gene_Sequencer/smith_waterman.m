function [score, aligned_seq1, aligned_seq2] = smith_waterman(seq1, seq2)
    % Define scoring parameters
    match_score = 1;        % Score for matching characters
    mismatch_penalty = -1;  % Penalty for mismatched characters
    gap_penalty = -2;       % Penalty for gaps

    % Initialize scoring matrix
    n = length(seq1);
    m = length(seq2);
    H = zeros(n+1, m+1);

    % Fill the scoring matrix
    for i = 2:n+1
        for j = 2:m+1
            % Calculate match/mismatch score
            if seq1(i-1) == seq2(j-1)
                score_diag = H(i-1, j-1) + match_score;
            else
                score_diag = H(i-1, j-1) + mismatch_penalty;
            end

            % Calculate gap scores
            score_up = H(i-1, j) + gap_penalty;
            score_left = H(i, j-1) + gap_penalty;

            % Assign the maximum score to the current cell
            H(i, j) = max([0, score_diag, score_up, score_left]);
        end
    end

    % Trace back to find the optimal alignment
    [score, idx] = max(H(:));
    [i, j] = ind2sub(size(H), idx);
    aligned_seq1 = '';
    aligned_seq2 = '';

    while i > 1 && j > 1 && H(i, j) > 0
        current_score = H(i, j);
        diagonal_score = H(i-1, j-1);
        up_score = H(i-1, j);
        left_score = H(i, j-1);

        if current_score == diagonal_score + (seq1(i-1) == seq2(j-1)) * match_score + (seq1(i-1) ~= seq2(j-1)) * mismatch_penalty
            aligned_seq1 = [seq1(i-1) aligned_seq1];
            aligned_seq2 = [seq2(j-1) aligned_seq2];
            i = i - 1;
            j = j - 1;
        elseif current_score == up_score + gap_penalty
            aligned_seq1 = [seq1(i-1) aligned_seq1];
            aligned_seq2 = ['-' aligned_seq2];
            i = i - 1;
        elseif current_score == left_score + gap_penalty
            aligned_seq1 = ['-' aligned_seq1];
            aligned_seq2 = [seq2(j-1) aligned_seq2];
            j = j - 1;
        end
    end
end
