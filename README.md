Garrychet
=========

A Ricochet gamemode clone on Garry's Mod 13. Experience the old Ricochet Gamemode in your hands!

### Resurection Update v1.3: Patches, Patches, and More Patches
This update fixes most issues with the unfinished mod. This is a Fanmade fix sanctioned by ptwon2

Update fixes the beta map to remove 'projectile_disc' upon hitting the skybox (End of map)
Update fixes most of the bounce code. (Bounces correct number of times, thanks Germanchocolate!)
Update adds all resources under the 'GM:AddResources()' function

###STILL Need Help from any Exprenced Mappers and/or GmodLua Programmers to Provide More Patches and Maps!!

### TODO
Fix all current bugs if possible
Add working powerups

### CURRENT BUGS (AFFECTS GAMEPLAY)
Projectile_disc looses velocity upon bouncing, I need help to fix this issue.

### CURRENT BUGS (DOESN'T IMPACT GAMEPLAY)
1 =================================

This error will happen upon loading this mod:
```lua
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedrt)`
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedlf)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedbk)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedft)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedup)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/painteddn)
```
Currently unsure how to fix that error. (Not going to fix as it doesn't affect gameplay)

2==================================

Upon shooting the disc this error will appear.
```lua
Bad pstudiohdr in GetSequenceLinearMotion()!
```
STILL Looking into fixing this error. Occures when firing disc (And maybe dying?)

==================================================================

ALL BUGS ABOVE DON'T SEEM TO HINDER GAMEPLAY, CURRENTLY JUST CONSOLE ERRORS.

### Resurection Update v1.2: Visual Overhaul (Kept here to see changes overtime)
This update fixes most issues with the unfinished mod. This is a Fanmade fix sanctioned by ptwon2

Added Beta Map's materials and models.
Added custom powerup and disc model.
Added background of new beta map.
Added source files of all planned maps (Including current beta map)
Fixed "Changing collision rules within a callback is likely to cause crashes!" error (Thanks facepunch!)

### Need Help from any Exprenced Mappers and/or GmodLua Programmers to Provide More Patches and Maps!!

### CURRENT BUGS
1 =================================

This error will happen upon loading this mod:
```lua
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedrt)`
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedlf)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedbk)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedft)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedup)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/painteddn)
```
Currently unsure how to fix that error. (Not going to fix as it doesn't affect gameplay)

2==================================

Upon shooting the disc this error will appear.
```lua
Bad pstudiohdr in GetSequenceLinearMotion()!
```
STILL Looking into fixing this error. Occures when firing disc (And maybe dying?)

==================================================================

ALL BUGS ABOVE DON'T SEEM TO HINDER GAMEPLAY, CURRENTLY JUST CONSOLE ERRORS.

### Resurection Update: (Kept here to see changes overtime)
This update fixes most issues with the unfinished mod. This was a fan made fix and not officaly endourced by ptown2 or Nightmare

Replaced the model to the sawblade (This github didn't contain the model file for ricochet)
Fixed errors upon death when falling
Fixed errors when grabbing powerups after extended play (Powerups themselves seem to not work as of now)
Fixed missing textures upon decapitation (Got the files from JetBoom's awesomestrike github)

Many thanks to Jetboom for his code on github as it helped me patch broken code, and get the missing textures for decapitation
All credit goes to ptown2 + Nightmare for creating the base of the gamemode.
All other assests used belong to their creator no copyright infrignement intended

### CURRENT BUGS
1 =================================

This error will happen upon loading this mod:
```lua
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedrt)`
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedlf)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedbk)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedft)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/paintedup)
Requesting texture value from var "$startexture" which is not a texture value (material: skybox/painteddn)
```
Currently unsure how to fix that error.

2==================================

Upon shooting the disc this error will appear.
```lua
Bad pstudiohdr in GetSequenceLinearMotion()!
```
Looking into fixing this error

3==================================

When the disc hits the end of the map this appears:
```lua
Changing collision rules within a callback is likely to cause crashes!
```
Unsure how to fix this one; It may be related to unfinished bounce code

==================================================================

ALL BUGS ABOVE DON'T SEEM TO HINDER GAMEPLAY, CURRENTLY JUST CONSOLE ERRORS.

### TODO
Fix all bugs
Make powerups actually work
Remove all gained powerups upon death
Finish up the bounce code (Unknown if I can achive this)

### HELP WANTED
Need a mapper to help make maps with actual bars for the ricocheting to happen.
ptown2 and/or Nightmare's assitance would help alot in finishing this gamemode.
Any gamemode developers to help fix any other errors and finish up features

### NOTE:
This gamemode is still in under-development, any changes are very crucial and demanding.

It would be better not to run this on a server... for now.
