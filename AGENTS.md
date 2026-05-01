# Agent Guidance

This is a Godot 4.6 project for a top-down tank shooter. Keep changes small and scene-aware.

## Entry Points

- Main scene: [main.tscn](main.tscn)
- Project config and input map: [project.godot](project.godot)
- Core gameplay scripts: [tanks/tank.gd](tanks/tank.gd), [turrets/turret.gd](turrets/turret.gd), [bullets/bullet.gd](bullets/bullet.gd)

## Conventions

- Preserve the current node hierarchy and node names unless a change explicitly requires a scene restructure.
- Keep movement, turret aiming, and bullet spawning logic in the existing tank/turret/bullet scripts instead of spreading it into new systems.
- Treat the input actions `up`, `left`, `down`, `right`, and `shoot` as the canonical controls; update [project.godot](project.godot) and the affected scenes together if they change.
- The turret fires from its `Marker2D` muzzle and bullets are cleaned up with `VisibleOnScreenNotifier2D`; keep those paths and lifecycle assumptions in sync with scene edits.
- Prefer editing Godot scenes and scripts directly; there is no project-level build or test harness in the repository.

## Useful Context

- Tanks use `CharacterBody2D` movement with exported tuning values.
- Turrets track the mouse every physics frame and instantiate [bullets/bullet.tscn](bullets/bullet.tscn).
- Bullets move using their local X axis and despawn when they leave the screen.