# Floating Logo System

A FiveM script that adds a floating logo with auto-shoot functionality.

## Features

- Toggle a floating logo attached to the player
- Auto-shoot functionality targeting the closest player

## Requirements

- FiveM server with ESX framework
- MySQL database

## Installation

1. Download the script files
2. Place them in your FiveM server's resources folder
3. Add `start floating_logo_system` to your server.cfg
4. Import the database.sql file into your MySQL database

## Usage

### Commands

- `/togglelogo` - Toggle the floating logo on/off
- `/toggleautoshoot` - Toggle the auto-shoot functionality on/off

### Permissions

No specific permissions are required to use this script.

## Configuration

The script can be configured in the `config.lua` file. You can adjust the logo model, offset, scale, auto-shoot interval, range, and damage.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=floating-logo-system&utm_content=bottom) — describe it in one sentence and get the full source code.
