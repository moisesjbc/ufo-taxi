# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.4] - 2020-08-15

### Added

- New info to README.
- New campaign.
- New building: the "reverser"!
- Campaign selector.
- Music and some SFX (thanks Alejandro!).

### Changed

- Updated almost all sprites in the game.
- Export script moved to its own repository.
- Updated screenshot.
- Adjusted positions for vertices and levels in multiple levels.
- Pause menu now includes current level index.

### Fixed

- Fixed multiple Godot warnings / errors.
- Fixed audio sliders not initialized with current volume.


## [0.3.2] - 2020-12-20

### Added

- Thanks to the amazing people who organized and participated Ludum Dare #47 (sorry for forgeting you on previous patch! ^^U)
- Devel script for updating the game version.


## [0.3.1] - 2020-12-18

### Added

- Added a "Thanks" section to credits menu.

### Fixed

- Fix some hidden vertices in level 8.
- Fixed "Fullscreen: OFF" label when entering options menu in fullscreen mode.
- Fixed nodes / edge being highlighted but not selected on mobile.
- Fixed reseting level when player had all cows trigerring level win.


## [0.3] - 2020-12-11

### Added

- This changelog.
- Simple level editor (only when running project from Godot). It allows CRUD operations on nodes, pickup areas and areas 51.
- Level selector.
- Button for reloading current level.
- Fast forward button.
- User data persistence (no more progress loss when closing the game!).
- Added levels 4 - 8.
- Pause menu.
- Custom styles for buttons and panels (Thanks coolors.co!).
- Volume controls.
- Fullscreen toggle.

### Changed

- Controls and GUI adapted for playing in mobile.
- Resolution changed to 1280x720 (16:9)
- Now levels are loaded from JSON files.
- Now campaign levels must be unloked in order.
- Adjusted level 4 is no longer a "Think fast" level (no more direct path to area 51 from the beginning).

### Fixed

- Node deletion menu is now hidden when clicking outside or when changing levels.
- Improved edge selection.


## [0.2] - 2020-10-04

### Added

- Pickup sound.
- Music.
- UFO explosion sound.

### Changed

- Adapted instructions for level 0.
- Exit button is now disabled in HTML5.
- Default color for polygon changet to 'aquamarine'.
- Improved warning label visibility.


## [0.1] - 2020-10-04

- First version upload to [Ludum Dare #47](https://ldjam.com/events/ludum-dare/47)

[Unreleased]: https://github.com/moisesjbc/ufo-taxi/compare/v0.3.2...HEAD
[0.4]: https://github.com/moisesjbc/ufo-taxi/compare/v0.3.2...v0.4
[0.3.2]: https://github.com/moisesjbc/ufo-taxi/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/moisesjbc/ufo-taxi/compare/v0.3...v0.3.1
[0.3]: https://github.com/moisesjbc/ufo-taxi/compare/v0.2...v0.3
[0.2]: https://github.com/moisesjbc/ufo-taxi/compare/v0.1...v0.2
[0.1]: https://github.com/moisesjbc/ufo-taxi/releases/tag/v0.1
