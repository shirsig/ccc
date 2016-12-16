# aurae (/aurae for options)
aurae is a new debuff tracker for WoW 1.12.

Due to the tracking mechanisms used only the player's own spells are tracked and only those that are applied on finishing a cast.
In PvE and for reapplication of effects there is a small delay of 0.5 seconds to ensure the cast hasn't failed in some way. For initial applications in PvP this is avoided by using combat log events for confirmation.
Green bars are active debuffs and yellow/orange/red bars are diminishing returns with reduction to 1/2, 1/4 and 0 respectively.

![Alt text](http://i.imgur.com/DbC2V6d.png)
