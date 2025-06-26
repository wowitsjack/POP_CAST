# Pop!_Cast

An automated installer for GNOME Network Displays on Pop!_OS and Ubuntu-based systems, specifically optimized for Microsoft Wireless Display Adapter V2 compatibility.

## What This Does

This installer automates the process of building GNOME Network Displays from source, ensuring compatibility with systems that have issues with the Flatpak version. It installs all necessary dependencies, codecs, and builds version 0.90.5 which is compatible with Ubuntu 22.04's NetworkManager.

## Why Use This?

- **Flatpak Limitations**: The Flatpak version of GNOME Network Displays often has codec and permission issues
- **Microsoft Adapter Support**: Specifically tested with Microsoft Wireless Display Adapter V2
- **WiFi P2P**: Requires proper WiFi P2P support which this version provides
- **System Integration**: Full system integration without sandboxing restrictions

## System Requirements

- Pop!_OS 22.04 or Ubuntu 22.04 (or derivatives)
- WiFi adapter with P2P support
- Administrative privileges (sudo access)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/wowitsjack/POP_CAST.git
   cd POP_CAST
   ```

2. Make the installer executable:
   ```bash
   chmod +x pop_cast_installer.sh
   ```

3. Run the installer:
   ```bash
   ./pop_cast_installer.sh
   ```

The installer will guide you through each step of the process.

## What Gets Installed

- Build tools (meson, ninja, cmake, etc.)
- Development libraries (GTK3, NetworkManager, PulseAudio, etc.)
- GStreamer codecs for media support
- GNOME Network Displays v0.90.5 (built from source)

## Usage

After installation, you can:

1. Find "Network Displays" in your applications menu
2. Run `gnome-network-displays` from the terminal
3. Connect to compatible wireless display adapters

## Troubleshooting

If you encounter issues:

1. Ensure your WiFi adapter supports P2P mode
2. Check that NetworkManager is running
3. Verify the Microsoft adapter is in pairing mode
4. Check system logs for error messages

## Technical Details

This installer builds GNOME Network Displays v0.90.5 instead of the latest version due to compatibility requirements with Ubuntu 22.04's NetworkManager (version 1.36.6). The newer versions require functions that aren't available in this NetworkManager version.

## License

This installer script is provided as-is. GNOME Network Displays is licensed under the GPL-3.0 license. 