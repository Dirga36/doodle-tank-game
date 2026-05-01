# bool
A built-in boolean type.

## Description
The bool is a built-in Variant type that may only store one of two values: true or false. You can imagine it as a switch that can be either turned on or off, or as a binary digit that can either be 1 or 0.

Booleans can be directly used in if, and other conditional statements:

```
var can_shoot = true
if can_shoot:
	launch_bullet()
```

All comparison operators return booleans (==, >, <=, etc.). As such, it is not necessary to compare booleans themselves. You do not need to add == true or == false.

Booleans can be combined with the logical operators and, or, not to create complex conditions:

```
if bullets > 0 and not is_reloading():
	launch_bullet()

if bullets == 0 or is_reloading():
	play_clack_sound()
```