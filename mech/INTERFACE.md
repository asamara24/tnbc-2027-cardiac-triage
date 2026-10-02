# <board> <-> enclosure interface

<!-- Example layout; replace every value with ours. Any change to this table goes through a PR
     approved by both owners. After a release, a change needs an ECO. -->

Electrical owner: @____   Mechanical owner: @____
Units: mm. Origin: board bottom-left corner = KiCad drill/place file origin.
Board revision: <board>-revA   Enclosure revision: enc-1

| Item | Value | Tolerance | Who decides |
| --- | --- | --- | --- |
| Board outline | ___ x ___, 1.6 thick | +/-0.2 | electrical |
| Mounting holes | ___ x 3.2 dia at (__,__) ... | +/-0.1 | mechanical |
| Max part height, top / bottom | ___ / ___ | | mechanical |
| Display / LED window (triage output) | at (__,__); opening ___ x ___ | +/-0.3 | both |
| SpO₂ sensor / finger clip connector | ___ | | both |
| BP cuff pneumatic port (pump/valve tubing) | ___ | | both |
| Battery + charge port | ___ | | both |
| Buttons / switches | ___ | | both |
| Keep-out | 3.0 radius around each hole (screw heads) | | mechanical |
