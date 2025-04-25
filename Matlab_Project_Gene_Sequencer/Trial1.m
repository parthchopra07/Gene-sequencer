seq1 = read_fasta('g1.fasta');
seq2 = read_fasta('g2.fasta');

%
[score, nw_aligned_seq1, nw_aligned_seq2] = needleman_wunsch(seq1, seq2);

fprintf('Alignment Score: %d\n', score);
fprintf('Sequence 1: %s\n', nw_aligned_seq1);
fprintf('Sequence 2: %s\n', nw_aligned_seq2);



%
[score, sw_aligned_seq1, sw_aligned_seq2] = smith_waterman(seq1, seq2);

fprintf('Alignment Score: %d\n', score);
fprintf('Sequence 1: %s\n', sw_aligned_seq1);
fprintf('Sequence 2: %s\n', sw_aligned_seq2);


