# aurae (/aurae for options)
aurae is a new debuff tracker for WoW 1.12.

The focus of this addon is on debuffs which are useful to keep track of on units other than the current target. These are mostly CCs as well as some dots.
Other timers are excluded because there would be an impractically large amount of bars when tracking them not just on the current target. To still get timers for those I recommend this addon: https://github.com/Voidmenull/DebuffTimers.

Green bars are active debuffs and yellow/orange/red bars are diminishing returns with reduction to 1/2, 1/4 and 0 respectively.

Due to the tracking mechanisms used only the player's own spells are tracked and only those that are applied on finishing a cast. There are two exceptions to this, Seduction and Freezing Trap, because of their importance as CCs, which use different tracking methods.
In PvE and for reapplication of effects there is a small delay of 0.5 seconds to ensure the cast hasn't failed in some way. For initial applications in PvP this is avoided by using combat log events for confirmation.

The tracking correctly takes into account diminishing returns (including sharing), special PvP durations, spell ranks, talent bonuses and combo points.

![Alt text](http://i.imgur.com/DbC2V6d.png)
