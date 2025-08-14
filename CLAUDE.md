# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a ZMK firmware configuration repository for a Corne (crkbd) split mechanical keyboard. ZMK is an open-source keyboard firmware built on the Zephyr RTOS framework.

## Key Files and Structure

- `config/corne.keymap` - Main keyboard layout configuration using device tree syntax
- `build.yaml` - Defines the build matrix for GitHub Actions (board: nice_nano_v2, shields: corne_left/corne_right)
- `config/west.yml` - West manifest file that manages ZMK dependencies (currently using ZMK v0.3)
- `.github/workflows/build.yml` - GitHub Actions workflow that builds the firmware

## Common Development Tasks

### Building Firmware
The firmware is automatically built via GitHub Actions when pushing to the repository. The workflow uses the ZMK build system and generates firmware files for both halves of the Corne keyboard.

### Modifying Keymaps
Edit `config/corne.keymap` to change the keyboard layout. The keymap uses:
- Device tree syntax (.dtsi includes and bindings)
- ZMK behavior definitions from `<behaviors.dtsi>`
- Key codes from `<dt-bindings/zmk/keys.h>`
- Bluetooth codes from `<dt-bindings/zmk/bt.h>`

The keymap structure uses layers (default_layer shown, with layer switching via `&mo` commands).

### Testing Changes
Push changes to GitHub to trigger the build workflow. Successfully built firmware artifacts will be available as workflow artifacts.

## Architecture Notes

- The project uses West (Zephyr's meta-tool) for dependency management
- Board configuration targets the nice_nano_v2 microcontroller
- Split keyboard configuration with separate left/right shield builds
- The actual ZMK framework code is pulled as a dependency, not stored in this repo