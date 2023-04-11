program main
    use :: stdlib_system, only: sleep

    ! Variablen deklarieren und auf 0 setzen
    INTEGER IER, PGBEG, I
    INTEGER frame

    REAL F,a,m,v,t,delta,D,Fr,factor,mode

    F = 0
    a = 0
    m = 0
    v = 0
    t = 0
    s = 0
    D = 0
    Fr = 0
    mode = 0

    delta = 0.001

    ! PGPlot intialisieren und Plot Fenster erstellen
    IER = PGBEG(0,'/XSERVE',1,1)
    IF (IER/=1) STOP

    CALL PGENV(0.,5.,-1.5,1.5,0,1)
    CALL PGLAB('t in Sekunden', 's in Meter', 's(t)-Diagramm einer Schwingung')

    ! Eingabe der Daten (Federkonstante, Weg und Reibungskraft)
    print *, "D (in N/m)"
    read(*,*) D

    print *, "s (in m)"
    read(*,*) s

    print *, "Fr (in N)"
    read(*,*) Fr

    print *, "Modus auswählen"
    print *, "(0) Ohne Reibung"
    print *, "(1) Mit Gleitreibung"
    print *, "(2) Mit Luftreibung"
    read(*,*) mode

    ! Eingabenvalidierung
    IF (mode > 2 .or. mode < 0) THEN
        print *, "Fehler: Falscher Modus"
        STOP
    END IF

    ! Berechnung
    DO WHILE (t <= 5)
        factor = 1
        if(v > 0) factor = -1

        IF (mode == 0) THEN
            ! Schwingung ohne Reibung
            F = -D * s
        ELSE IF (mode == 1) THEN
            ! Schwingung Gleitreibung
            F = -D * s + factor * Fr
        ELSE
            ! Schwingung mit Luftreibung
            F = -D * s + factor * Fr * v * v
        END IF

        v = F * delta + v
        s = v * delta + s
        t = t + delta

        CALL PGPT1(t, s, -2)
        print *, "v=", v, "s=", s, "t=", t

        frame = frame + 1
        !CALL SLEEP(1)
    END DO

end program main
