program main;
uses Math;
var
    N: longint; M: longint; i: longint;
    mem: array of longint; cost: array of longint;

function Nknapsack(
    N: longint; 
    M: longint; 
    mem: array of longint; 
    cost: array of longint):longint;
var
    i: longint; j: longint;
    dp: array of longint;
    bufSum: longint;
    start: longint;

    prevCost: longint; newCost: longint;
const
    MAX_VAL: longint = 1000000001;
begin
    setLength(dp, M+1); bufSum := 0;
    for i:=0 to M do begin dp[i] := MAX_VAL; end;
    dp[0] := 0;

    for i:=0 to N do begin
        if bufSum >= M then bufSum := M else bufSum += mem[i];

        // set start
        if bufSum > M then start := M else start := bufSum;

        for j:=start downto 0 do begin
            if mem[i] > j then begin if cost[i] < dp[j] then dp[j] := cost[i]; end
            else begin
                // mem[i] 만으로 할당불가할 경우
                prevCost := dp[j]; newCost := dp[j - mem[i]] + cost[i];
                if newCost < prevCost then dp[j] := newCost;
            end;
        end;
    end;
    Nknapsack := dp[M];
end;
begin

    read (N); read (M);
    setLength(mem, N+1); setLength(cost, N+1);

    // input
    mem[0] := 0; cost[0] := 0;
    for i:=1 to N do begin read (mem[i]); end;
    for i:=1 to N do begin read (cost[i]); end;

    writeln(Nknapsack(N, M, mem, cost));
end.