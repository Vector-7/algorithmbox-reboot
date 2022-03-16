program main;
var
    G: longint;
    P: longint;
    A: array [1..100000] of longint;    // docking array
    D: array [1..100000] of longint;    // cursor
    T: array [1..100000] of longint;
    x: longint;
    i: longint;
    ans: longint;
    k: longint; // 갱신 위치
begin
    readln (G);
    readln (P);
    ans := 0;

    // init
    for i := 1 to G do begin D[i] := -1; end;
    for i := 1 to G do begin A[i] := 0; end;
    for i := 1 to P do begin read (T[i]); end;
    
    for i := 1 to P do begin

        x := T[i];

        // 자리 없음
        if D[x] = 1 then break
        else begin
            if D[x] = -1 then k := x
            else k := (D[x] - 1)
        end;

        while (k > 0) and (A[k] > 0) do k := (D[A[k]] - 1);

        if k = 0 then break
        else begin
            A[k] := x;
            D[x] := k;
            ans += 1;
        end;
    end;
    writeln (ans);
end.