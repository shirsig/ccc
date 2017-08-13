# ccwatch (/ccwatch for options)
ccwatch is a new cc tracker for Vanilla WoW 1.12.

The tracking correctly takes into account diminishing returns (including sharing), special PvP durations, spell ranks, talent bonuses and combo points.

Green bars are active debuffs and yellow/orange/red bars are diminishing returns with reduction to 1/2, 1/4 and 0 respectively.

Due to limitations of the tracking mechanisms used only the player's own spells are tracked and only those that are applied on finishing a cast. There are three exceptions to this, Seduction, Freezing Trap, and Crippling Poison, because of their importance as CCs, which use different tracking methods. To track timers for other players I recommend this addon: https://github.com/Voidmenull/DebuffTimers.

In PvE off target and for reapplication of effects there is a small delay of 0.5 seconds to ensure the cast hasn't failed in some way. For initial applications in PvP this is avoided by using combat log events for confirmation.

![Alt text](http://i.imgur.com/DbC2V6d.png)
