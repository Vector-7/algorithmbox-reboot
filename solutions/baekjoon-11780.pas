program main;
const
    INF = 1000000000;
var
    N, M: longint;
    G: array [1..100, 1..100] of longint;
    R: array [1..100, 1..100, 1..100] of longint;
    RC: array [1..100, 1..100] of longint;
    i, j, k, p, _p: longint;   // cursors

    u, v, w: longint;  // tmp vectors and weights
    _w: longint;
begin
    readln (N);
    readln (M);

    for i := 1 to N do begin
        for j := 1 to N do begin
            if i = j then G[i][j] := 0
            else G[i][j] := INF;
            RC[i][j] := 0;
        end;
    end;

    for i := 1 to M do begin
        read (u); read (v); read (w);
        if G[u][v] > w then begin
            G[u][v] := w;
        end;
    end;

    for k := 1 to N do begin
        for i := 1 to N do begin
            for j := 1 to N do begin
                _w := G[i][k] + G[k][j];
                if _w < G[i][j] then begin
                    
                    p := 1;

                    if RC[i][k] > 0 then begin
                        for p := 1 to RC[i][k] do begin R[i][j][p] := R[i][k][p]; end;
                        p += 1;
                    end;
                    
                    R[i][j][p] := k;
                    _p := p;

                    if RC[k][j] > 0 then begin
                        for p := 1 to RC[k][j] do begin R[i][j][p+_p] := R[k][j][p]; end;
                    end;
                    
                    RC[i][j] := RC[i][k] + RC[k][j] + 1;
                    G[i][j] := _w;
                end;
            end;
        end; 
    end;

    for i := 1 to N do begin
        for j := 1 to N do begin
            if G[i][j] = INF then write(0, ' ')
            else write(G[i][j], ' ');
        end;
        writeln();
    end;

    for i := 1 to N do begin
        for j := 1 to N do begin
            if (G[i][j] = 0) or (G[i][j] = INF) then begin
                writeln(0);
            end
            else begin
                write(RC[i][j] + 2, ' ');
                write(i, ' ');
                if RC[i][j] > 0 then begin
                    for k := 1 to RC[i][j] do begin
                        write(R[i][j][k], ' ');
                    end
                end;
                write(j, ' ');
                writeln();
            end;
        end;
    end;
end.