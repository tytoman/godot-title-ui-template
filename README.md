# Godot Title UI Template

## Contents

The following mechanisms are implemented in this template.

- Title screen
  - There are buttons for scene transitions, settings screen, credits screen and end of game
- Settings screen.
  - `Master` bus volume adjustment slider
- Credits screen
  - Godot licence notice
- Load screen
- Screen and scene transition buttons

Each function is componentised and can be reconfigured without writing code.

## Description

### Components

#### SoundPlayButton

A button that specifies an `AudioStreamPlayer` and plays the sound when the button is pressed. Base class of `LoadSceneButton` with `TransitButton`.

#### TransitButton

A button that performs screen transitions. Specifies the `TransitableControl` before and after the transition, waits for `interval` seconds and switches screens.

#### LoadSceneButton

Specifies the path of the scene to load in `scene_path`. Displays the load screen, asynchronously loads the scene, displays the loading bar and switches scenes when loading is complete.

#### QuitButton

A button that executes `quit` when pressed. It does not inherit from the `SoundPlayButton`, as playing a sound will terminate the process and not play it.

#### TransitableControl

A `Control` that can be used to transition between screens by means of a `TransitButton`. It can be animated by specifying scale, position and duration. It can also be used by attaching it to other nodes that inherit from `Control`. During the transition animation, all buttons existing in the child are disabled.

#### AudioVoulmeSlider

A slider that sets the volume of a given bus.

Cannot be added as a node as it inherits from `Slider` and must be attached to a `HSlider` or `VSlider`.

#### LoadingProgressBar

Specify `LoadingScreenSingleton` (see below) to display the loading status. The range must be set to `0~1`.

Like the `AudioVolumeSlider`, it can be attached to an `HSlider` or `VSlider`.

### Singleton

#### LoadingScreenSingleton

Registered in Autoload under the name `LoadingScreen`. If you want to use it in another project, you need to register `loading_screen.tscn` manually.

You can set the transition settings the edge and the rule texture from the `LoadingControl/ColourRect` Material in `loading_screen.tscn`.

## Usage

You can use the `title_ui_template` by moving it directly to the project you want to use and registering `loading_screen.tscn` as LoadingScreen to Autoload. Each component can be used by adding it as a note or attaching it to the relevant node.