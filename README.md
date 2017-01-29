Garrychet
=========

A Ricochet gamemode clone on Garry's Mod 13. Experience the old Ricochet Gamemode in your hands!

### Resurection Update:
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
