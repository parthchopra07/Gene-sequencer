function seq = read_fasta(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end

    seq = '';
    line = fgetl(fid); % Skip the first line (header)
    
    while ischar(line)
        line = fgetl(fid); % Read next line
        if ischar(line) % Check if it's still valid
            seq = [seq line]; % Append sequence (ignoring header)
        end
    end
    fclose(fid);
end
