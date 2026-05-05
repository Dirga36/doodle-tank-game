# Doodle Tank Game - Agent Notes

## Quick start
- Open the project in Godot 4.6+ (project.godot) and press Play.
- The main scene is res://scenes/opening/opening.tscn.
- Export presets are defined in export_presets.cfg.

## Project layout
- scenes/ holds gameplay and menu scenes (see scenes/opening/ and scenes/game_scene/).
- scripts/ holds global state and flow scripts (game_state.gd, level_and_state_manager.gd, level_state.gd).
- addons/maaacks_game_template provides the base menus and UI framework.

## Godot settings to respect
- Autoloads are configured in project.godot: AppConfig, SceneLoader, ProjectMusicController, ProjectUISoundController.
- Global UI theme is resources/themes/steal_this_theme.tres.
- Input actions are defined in project.godot (up/down/left/right/interact/shoot).

## Pitfalls
- Avoid editing *.uid files; they are auto-generated.
- Prefer the Godot editor for project settings instead of editing project.godot by hand.
- Changes inside addons/ may be overwritten by plugin updates.

## Reference docs
- Project overview: README.md
- Template docs: addons/maaacks_game_template/README.md and addons/maaacks_game_template/docs/
