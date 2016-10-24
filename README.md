# aurae (/aurae for options)
aurae is a new aura tracker for WoW 1.12, combining features from several old addons.
aurae behaves differently for PvP and PvE targets. Its PvP behavior is inspired by CCWatch and Chronometer and the PvE behavior by DoTimer.
## PvP tracking
The PvP tracking is more complete and reliable than any of the above.
Timers are shown for units with recent activity which means recently targeted, moused over or casted spells on the player.
Every aura within combat log range is tracked even if not shown and diminishing returns are correctly taken into account, including shared ones.
Removing and refreshing of timers works with as little issues as possible given the API.
## PvE tracking
The API is much more limited with respect to PvE aura tracking, so different mechanics are required to make it usable.
Timers are only shown for the player's own spells.
A distinction is made between enemies with different level or sex even if they share the same name, but if all those are equal they will be treated as if a single unit.
## Timers
Timers have a look partially based on vanilla candybars and partially on retail candybars.
The layout is inspired by CCWatch.
There are separate groups of timers for buffs, debuffs and ccs, each containing 10 bars.
![Alt text](http://i.imgur.com/z04qTcI.png)
