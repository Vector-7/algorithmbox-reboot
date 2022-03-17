{$MODE OBJFPC}
PROGRAM MAIN(INPUT,OUTPUT);
USES SYSUTILS, CLASSES, MATH;
VAR
    LL, L, R, I, N: LONGINT;
BEGIN

    READ (N);

    IF N < 3 THEN BEGIN
        CASE (N) OF
            1: WRITELN(1);
            2, 3: WRITELN(2);
        END;
        EXIT;
    END;

    I := 1;
    LL := 0; L := 1; R := N;

    WHILE N > 3 DO BEGIN
        //WRITELN(N, ' ', LL, ' ', L, ' ', R);
        IF (N MOD 2) = 0 THEN BEGIN
            // 현재 짝수
            IF LL > 0 THEN LL := 0
            ELSE L += I;
            N := (N DIV 2);
        END
        ELSE BEGIN
            // 현재 홀수
            IF LL > 0 THEN BEGIN
                LL := R;
                R -= I;
            END
            ELSE BEGIN
                L += I;
                LL := R;
                R -= I;
            END;
            N := CEIL(N / 2);
        END;
        I *= 2;
    END;

    IF N = 3 THEN BEGIN
        IF LL > 0 THEN WRITELN(L)
        ELSE WRITELN(L+I);
    END
    ELSE WRITELN(R);
    
END.