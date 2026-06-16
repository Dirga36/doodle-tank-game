# Doodle Tank Game — Refactor Backlog

**Overview**  
This backlog prioritizes architectural and maintainability improvements identified in the codebase audit. Tasks are ordered by foundational impact first, then by risk reduction and code quality.

---

## 🔴 P0: Foundational Consolidation
These items unblock other improvements and reduce the most critical risks.

### P0.1: Consolidate Game State and Level Progression Ownership
**Impact:** High — Duplicated logic across three layers creates drift risk; checkpoint, current level, and save state can fall out of sync.

**Current Problem:**
- `GameState` (scripts/game_state.gd) maintains current_level_path, checkpoint_level_path, and persistence
- `LevelAndStateManager` (scripts/level_and_state_manager.gd) overrides set_current_level_path and set_checkpoint_level_path
- Template's `LevelManager` (addons/maaacks_game_template/extras/scripts/level_manager.gd) has its own current_level_path and checkpoint_level_path

**Solution:**
1. Move all progression state (current level, checkpoint, total games played, time) into a single `GameProgressionState` resource class
2. Make `LevelAndStateManager` the only caller of GameState for persistence; remove the setter overrides and have it call a unified API
3. Update all menu and game logic to call through `LevelAndStateManager` instead of directly to `GameState`
4. Verify checkpoint flow end-to-end: new game → continue → level select → progression → win/lose transitions

**Files to refactor:**
- [scripts/game_state.gd](scripts/game_state.gd)
- [scripts/level_and_state_manager.gd](scripts/level_and_state_manager.gd)
- [scripts/level_state.gd](scripts/level_state.gd)

**Estimated effort:** 4–6 hours (includes testing in Godot editor)

**Dependencies:** None (foundational)

---

### P0.2: Eliminate Global Player Singleton
**Impact:** High — `Global.player_node` couples gameplay, HUD, and combat code and makes scene reuse impossible.

**Current Problem:**
- Player writes `self` to `Global.player_node` in [scenes/game_scene/player/player.gd:13](scenes/game_scene/player/player.gd#L13)
- Enemy reads from it in [scenes/game_scene/enemy/enemy.gd:9](scenes/game_scene/enemy/enemy.gd#L9)
- HUD reads from it in [scenes/game_scene/hud/health_bar.gd:29](scenes/game_scene/hud/health_bar.gd#L29)

**Solution:**
1. Create a lightweight `GameplayContext` autoload or scene root to track gameplay references (player, spawner containers, base, objectives)
2. Update player.gd to emit a signal on ready instead of writing to global
3. Update enemy.gd and health_bar.gd to fetch the player reference from GameplayContext instead of Global
4. Test that player spawn, HUD update, and combat work correctly with the new lookup

**Files to refactor:**
- [global.gd](global.gd)
- [scenes/game_scene/player/player.gd](scenes/game_scene/player/player.gd)
- [scenes/game_scene/enemy/enemy.gd](scenes/game_scene/enemy/enemy.gd)
- [scenes/game_scene/hud/health_bar.gd](scenes/game_scene/hud/health_bar.gd)

**Estimated effort:** 2–3 hours

**Dependencies:** Can be done in parallel with P0.1

---

## 🟠 P1: High-Risk Spawn and Combat Cleanup
Reduce fragility and improve error handling in the most complex systems.

### P1.1: Harden Spawner Addon With Validation and Typing
**Impact:** High — Implicit parent access, untyped scene assumptions, and TODO-driven behavior make spawn failures silent and hard to debug.

**Current Problem:**
- `spawner_container.gd` uses `get_parent().spawner_data` without checking validity (lines 106–107, 159–160)
- `single_spawner.gd` prints warnings but does not fail early when `enemy_scene` is null (line 48)
- `wave_manager.gd` connects to signals but does not validate container state (lines 32–35)
- TODOs left in the code at lines 7, 143, 147 in `spawner_container.gd`

**Solution:**
1. Add explicit null checks and return early from spawn logic if preconditions fail
2. Replace print() calls with push_warning() or push_error()
3. Add explicit type hints for all spawner parameters and signals
4. Complete or remove TODO items (wave_finished signal, specific_enemy_wave_spawned_multi_spawner signal)
5. Add a validation helper in SpawnerContainer to check that children are valid spawner nodes

**Files to refactor:**
- [addons/spawner/scripts/spawner_container.gd](addons/spawner/scripts/spawner_container.gd)
- [addons/spawner/scripts/single_spawner.gd](addons/spawner/scripts/single_spawner.gd)
- [addons/spawner/scripts/multiple_spawner.gd](addons/spawner/scripts/multiple_spawner.gd)
- [addons/spawner/scripts/wave_manager.gd](addons/spawner/scripts/wave_manager.gd)

**Estimated effort:** 3–4 hours

**Dependencies:** After P0.2 (so gameplay context is in place)

---

### P1.2: Fix Bullet Spawn Coupling and Cleanup
**Impact:** Medium — Bullets are spawned under scene tree root instead of a gameplay layer, which pollutes the scene tree and couples combat code to scene structure.

**Current Problem:**
- [scenes/game_scene/player/turret.gd:54](scenes/game_scene/player/turret.gd#L54) and [scenes/game_scene/the_base/the_weapon.gd:54](scenes/game_scene/the_base/the_weapon.gd#L54) both use `get_tree().root.add_child(bullet)`

**Solution:**
1. Add a BulletManager node under the GameplayContext to own all active projectiles
2. Update turret.gd and the_weapon.gd to add bullets to BulletManager instead of root
3. Verify bullet cleanup still works (VisibleOnScreenNotifier2D should still queue_free)

**Files to refactor:**
- [scenes/game_scene/player/turret.gd](scenes/game_scene/player/turret.gd)
- [scenes/game_scene/the_base/the_weapon.gd](scenes/game_scene/the_base/the_weapon.gd)
- [scenes/game_scene/allied_projectile/bullet.gd](scenes/game_scene/allied_projectile/bullet.gd)

**Estimated effort:** 1–2 hours

**Dependencies:** P0.2 (GameplayContext must exist)

---

### P1.3: Standardize Gameplay Script Typing and Naming
**Impact:** Medium — Untyped parameters and generic local names reduce readability and refactor safety.

**Current Problem:**
- `enemy.gd:17` has `func take_damage(amount):` (no type)
- `turret.gd` and `the_weapon.gd` use capitalized variable names for resources (`Bullet`, `Muzzle`)
- `spawner_container.gd` and related spawner scripts have inconsistent naming (inst, spawner_data, entity, etc.)

**Solution:**
1. Add type hints to all function parameters and return values in gameplay scripts
2. Rename capitalized local variables and exports to lowercase_snake_case (e.g., `Bullet` → `bullet_scene`, `Muzzle` → `muzzle_marker`)
3. Use consistent naming for spawned entities (e.g., always `enemy_instance` not `inst`)

**Files to refactor:**
- [scenes/game_scene/enemy/enemy.gd](scenes/game_scene/enemy/enemy.gd)
- [scenes/game_scene/player/player.gd](scenes/game_scene/player/player.gd)
- [scenes/game_scene/player/turret.gd](scenes/game_scene/player/turret.gd)
- [scenes/game_scene/the_base/the_base.gd](scenes/game_scene/the_base/the_base.gd)
- [scenes/game_scene/the_base/the_weapon.gd](scenes/game_scene/the_base/the_weapon.gd)
- [scenes/game_scene/allied_projectile/bullet.gd](scenes/game_scene/allied_projectile/bullet.gd)

**Estimated effort:** 2–3 hours

**Dependencies:** None (can be done in parallel)

---

## 🟡 P2: Remove Fragile Scene Coupling
Reduce hard-coded paths and improve maintainability.

### P2.1: Replace Hard-Coded Scene Paths in HUD Scripts
**Impact:** Medium — Hard-coded relative paths like `"../../../../../../GameTimer"` break if scene structure changes.

**Current Problem:**
- [scenes/game_scene/hud/time_played.gd:19](scenes/game_scene/hud/time_played.gd#L19) uses `get_node_or_null("../../../../../../GameTimer")`

**Solution:**
1. Export a NodePath in time_played.gd that can be wired in the editor
2. Alternatively, have GameTimer emit a signal on ready and let HUD register as a listener
3. Test that the timer still updates correctly during gameplay and pause

**Files to refactor:**
- [scenes/game_scene/hud/time_played.gd](scenes/game_scene/hud/time_played.gd)
- [scenes/game_scene/game_timer.gd](scenes/game_scene/game_timer.gd) (if using signals)

**Estimated effort:** 1 hour

**Dependencies:** None

---

### P2.2: Implement Missing / Placeholder UI Windows
**Impact:** Medium — Dead or placeholder windows create confusion and fail silently.

**Current Problem:**
- [scenes/windows/level_won_window.gd:5–6](scenes/windows/level_won_window.gd#L5) is a placeholder with only `pass # Replace with function body.`

**Solution:**
1. Either fully implement level_won_window.gd to handle continue/restart/menu actions, or remove it
2. Ensure only one authoritative win/lose flow exists (either use the template's win_lose_manager or the custom windows, not both)
3. Update game_ui.tscn to wire the correct window for each scenario

**Files to refactor:**
- [scenes/windows/level_won_window.gd](scenes/windows/level_won_window.gd)
- [scenes/windows/game_won_window.gd](scenes/windows/game_won_window.gd)
- [scenes/windows/game_lost_window.gd](scenes/windows/game_lost_window.gd)
- [scenes/game_scene/game_ui.tscn](scenes/game_scene/game_ui.tscn)

**Estimated effort:** 2–3 hours

**Dependencies:** P0.1 (so progression flow is consolidated)

---

### P2.3: Consolidate Main Menu Logic
**Impact:** Low-Medium — Duplicated button/visibility logic between main_menu.gd and main_menu_with_animations.gd.

**Current Problem:**
- Both [scenes/menus/main_menu/main_menu.gd](scenes/menus/main_menu/main_menu.gd) (line 25) and [scenes/menus/main_menu/main_menu_with_animations.gd](scenes/menus/main_menu/main_menu_with_animations.gd) (line 54) duplicate `_show_level_select_if_set()` and `_show_continue_if_set()` logic
- Both call `GameState.reset()`, `GameState.continue_game()`, and `load_game_scene()`

**Solution:**
1. Move shared visibility and button-wiring logic into the base menu (the template's MainMenu)
2. Have the animated variant inherit and only override animation-specific behavior
3. Or move all shared logic to a helper mixin/utility

**Files to refactor:**
- [scenes/menus/main_menu/main_menu.gd](scenes/menus/main_menu/main_menu.gd)
- [scenes/menus/main_menu/main_menu_with_animations.gd](scenes/menus/main_menu/main_menu_with_animations.gd)

**Estimated effort:** 1–2 hours

**Dependencies:** None

---

## 🟢 P3: Documentation and Validation
Long-term maintainability and safety checks.

### P3.1: Add Project-Level Architecture Documentation
**Impact:** Medium — Onboarding and safe maintenance require reverse engineering without clear docs.

**Current Problem:**
- [README.md](README.md) is only a one-line description
- [AGENTS.md](AGENTS.md) is minimal and does not detail the game flow

**Solution:**
1. Create [ARCHITECTURE.md](ARCHITECTURE.md) documenting:
   - Autoload/singleton responsibilities (AppConfig, SceneLoader, ProjectMusicController, etc.)
   - Game flow (startup → main menu → level → win/lose → checkpoint/continue)
   - Save/progression model (GameState, LevelState, persistence timing)
   - Scene ownership and layer structure (GameplayContext, spawner containers, HUD)
   - Input model and action definitions
   - Spawn system: single vs. multiple spawners, wave flow, max active enemy limits
2. Keep it aligned with actual code by reviewing after each major refactor

**Estimated effort:** 2–3 hours (one-time)

**Dependencies:** After P0.1 and P0.2 (so consolidated logic is final)

---

### P3.2: Add Integration Tests for Core Flows
**Impact:** Medium — High-risk flows (save/load, checkpoint, progression, win/lose) have no automated checks.

**Current Problem:**
- No visible tests for save/load state
- No validation for checkpoint continuation
- No checks for wave progression or enemy spawn limits
- No tests for win/lose transitions

**Solution:**
1. Create a simple test/validation script that runs in the editor:
   - Start new game → check GameState is initialized
   - Continue game → check checkpoint is loaded
   - Complete a level → check progression state updates
   - Lose game → check state reset
2. Run this as an editor script before each release or on demand

**Files to create:**
- [tests/test_progression.gd](tests/test_progression.gd) (new)
- [tests/test_spawn.gd](tests/test_spawn.gd) (new)

**Estimated effort:** 3–4 hours

**Dependencies:** After P0.1 (so state API is stable)

---

## 📋 Summary Table

| Priority | ID | Title | Effort | Impact | Blocker | Status |
|----------|-----|-------|--------|--------|---------|--------|
| P0 | P0.1 | Consolidate Game State and Level Progression | 4–6 hrs | 🔴 High | ✓ | Not started |
| P0 | P0.2 | Eliminate Global Player Singleton | 2–3 hrs | 🔴 High | ✓ | Not started |
| P1 | P1.1 | Harden Spawner Addon With Validation | 3–4 hrs | 🟠 High | ✗ | Not started |
| P1 | P1.2 | Fix Bullet Spawn Coupling | 1–2 hrs | 🟠 Medium | ✗ | Not started |
| P1 | P1.3 | Standardize Gameplay Script Typing | 2–3 hrs | 🟠 Medium | ✗ | Not started |
| P2 | P2.1 | Replace Hard-Coded Scene Paths in HUD | 1 hr | 🟡 Medium | ✗ | Not started |
| P2 | P2.2 | Implement Missing / Placeholder UI Windows | 2–3 hrs | 🟡 Medium | ✗ | Not started |
| P2 | P2.3 | Consolidate Main Menu Logic | 1–2 hrs | 🟡 Low-Med | ✗ | Not started |
| P3 | P3.1 | Add Project-Level Architecture Documentation | 2–3 hrs | 🟢 Medium | ✗ | Not started |
| P3 | P3.2 | Add Integration Tests for Core Flows | 3–4 hrs | 🟢 Medium | ✗ | Not started |

---

## 🚀 Recommended Execution Order

1. **Complete P0.1 and P0.2 first** (8–9 hours total)
   - These are foundational and unblock the rest
   - Do P0.1 and P0.2 in parallel if bandwidth allows
2. **Then do P1 tasks** (7–9 hours total)
   - P1.1, P1.2, P1.3 can be done in any order once P0.2 is done
3. **Then do P2 tasks** (4–7 hours total)
   - P2.1, P2.2, P2.3 can run in parallel; do P2.2 after P0.1 for best effect
4. **Finally do P3 tasks** (5–7 hours total)
   - P3.1 after all gameplay refactors are stable
   - P3.2 after P0.1 so test API is clear

**Total estimated effort:** 24–32 hours spread over 2–4 weeks depending on bandwidth.

---

## Notes

- Each task includes specific file paths and line numbers for quick navigation.
- Test in the Godot editor after each P0/P1 task to catch integration issues early.
- After all P0 and P1 work, run a full playthrough (spawn, win, lose, checkpoint, continue) before moving to P2.
- Keep this backlog updated as priorities or blockers change.
