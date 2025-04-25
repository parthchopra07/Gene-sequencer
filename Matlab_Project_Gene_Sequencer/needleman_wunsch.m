function [score, aligned_seq1, aligned_seq2] = needleman_wunsch(seq1, seq2)
    % Define scoring scheme
    match = 1;
    mismatch = -1;
    gap = -2;

    % Initialize matrices
    len1 = length(seq1) + 1;
    len2 = length(seq2) + 1;
    score_matrix = zeros(len1, len2);
    trace_matrix = zeros(len1, len2);

    % Fill first row and column
    for i = 2:len1
        score_matrix(i, 1) = score_matrix(i-1, 1) + gap;
        trace_matrix(i, 1) = 1; % Up
    end
    for j = 2:len2
        score_matrix(1, j) = score_matrix(1, j-1) + gap;
        trace_matrix(1, j) = 2; % Left
    end

    % Fill the rest of the matrix
    for i = 2:len1
        for j = 2:len2
            if seq1(i-1) == seq2(j-1)
                score = match;
            else
                score = mismatch;
            end

            diag = score_matrix(i-1, j-1) + score;
            up = score_matrix(i-1, j) + gap;
            left = score_matrix(i, j-1) + gap;

            [score_matrix(i, j), trace_matrix(i, j)] = max([diag, up, left]);
        end
    end

    % Traceback to get alignment
    i = len1;
    j = len2;
    aligned_seq1 = '';
    aligned_seq2 = '';

    while i > 1 || j > 1
        if trace_matrix(i, j) == 1 % Up
            aligned_seq1 = [seq1(i-1) aligned_seq1];
            aligned_seq2 = ['-' aligned_seq2];
            i = i - 1;
        elseif trace_matrix(i, j) == 2 % Left
            aligned_seq1 = ['-' aligned_seq1];
            aligned_seq2 = [seq2(j-1) aligned_seq2];
            j = j - 1;
        else % Diagonal
            aligned_seq1 = [seq1(i-1) aligned_seq1];
            aligned_seq2 = [seq2(j-1) aligned_seq2];
            i = i - 1;
            j = j - 1;
        end
    end

    score = score_matrix(end, end);
end
