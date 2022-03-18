program Main(Input, Output);
uses SysUtils, Classes, Math, StrUtils, Types;

function IsInRange(n: integer; m: integer; r: integer; c: integer): boolean;
begin
    if (0 <= r) and (r < n) and (0 <= c) and (c < m) then IsInRange := true
    else IsInRange := false;
end;

var
    
    // 왼쪽 회전 -> (x - 1) mod 4
    DR: array [0..3] of Integer = (-1, 0, 1, 0);
    DC: array [0..3] of Integer = (0, 1, 0, -1);

    M, N: Integer;
    r, c, d, tmp_r, tmp_c, tmp_d: integer;
    backed, checked: boolean;
    G: Array [0..49, 0..49] of Integer;
    x, i, j: LongInt;

begin

    Read (N); Read (M);
    Read (R); Read (C); Read (D);
    for i := 0 to (N-1) do begin for j := 0 to (M-1) do Read(G[i][j]) end;

    // start
    x := 0;
    backed := false;

    while true do begin

        //writeln(r, ' ', c, ' ', d);

        // 청소
        if (G[r][c] = 0) and (backed = false) then begin
            G[r][c] := -1;
            x += 1;
        end;
        backed := false;
        checked := false;

        // 방향 회전 및 탐색
        for i := 1 to 4 do begin

            tmp_d := (d - i) mod 4;
            if tmp_d < 0 then tmp_d := (4 + tmp_d);

            tmp_r := r + DR[tmp_d]; tmp_c := c + DC[tmp_d];

            // 범위
            if IsInRange(n, m, tmp_r, tmp_c) = false then continue;
            
            if G[tmp_r][tmp_c] = 0 then begin
                // 빈칸 + 청소하지 않은 부분
                d := tmp_d;
                r := tmp_r; c := tmp_c;
                checked := true;
                break;
            end;
        end;

        if checked = true then continue; // 찾은 경우

        // 못찾았으면 뒤로 감
        if (IsInRange(n, m, r-DR[d], c-DC[d]) = false) or (G[r-DR[d]][c-DC[d]] = 1) then break
        else begin
            backed := true;
            r -= DR[d]; c -= DC[d];
        end;

    end;

    WriteLn(x);
    
end.