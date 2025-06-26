#!/bin/bash

# Pop!_Cast Installer
# A wizard to install GNOME Network Displays from source on Pop!_OS and Ubuntu-based systems.
# Tailored for the Microsoft Wireless Display Adapter V2.

# --- Colors and Styles ---
COLOR_BLUE="\\033[1;34m"
COLOR_GREEN="\\033[1;32m"
COLOR_YELLOW="\\033[1;33m"
COLOR_RED="\\033[1;31m"
COLOR_RESET="\\033[0m"
STYLE_BOLD="\\033[1m"
STYLE_RESET="\\033[0m"

# --- Helper Functions ---
function print_step {
    echo -e "\\n${COLOR_BLUE}==> ${STYLE_BOLD}$1${STYLE_RESET}${COLOR_RESET}"
}

function print_success {
    echo -e "${COLOR_GREEN}✔ ${1}${COLOR_RESET}"
}

function print_warning {
    echo -e "${COLOR_YELLOW}⚠ ${1}${COLOR_RESET}"
}

function print_error {
    echo -e "${COLOR_RED}✖ ${1}${COLOR_RESET}"
}

function wait_for_user {
    read -p "Press Enter to continue..."
}

# --- Main Wizard ---
clear
echo -e "${STYLE_BOLD}Welcome to the Pop!_Cast Installer${STYLE_RESET}"
echo "This script will guide you through installing the necessary components for"
echo "screen casting (Miracast) on Pop!_OS and other Ubuntu-based systems."
echo "This wizard will install everything you need, step by step."
echo ""
wait_for_user

# --- Step 1: System Update ---
print_step "Step 1: Updating your system..."
echo "Ensuring package lists are up to date."
sudo apt update
print_success "System updated!"
wait_for_user

# --- Step 2: Install Build Dependencies ---
print_step "Step 2: Installing necessary tools and libraries..."
echo "Installing required dependencies for building from source."
DEPS=(
    "build-essential" "git" "meson" "ninja-build" "pkg-config" "cmake" "gettext"
    "libgtk-3-dev" "libnm-dev" "libpulse-dev" "libavahi-client-dev" "libavahi-gobject-dev"
    "libgstreamer-plugins-base1.0-dev" "libgstrtspserver-1.0-dev"
    "libprotobuf-c-dev" "libjson-glib-dev" "libsoup2.4-dev"
)
sudo apt install -y "${DEPS[@]}"
print_success "All build tools are installed!"
wait_for_user

# --- Step 3: Install GStreamer Codecs ---
print_step "Step 3: Installing media codecs..."
echo "Installing GStreamer media codecs for video and audio playback."
CODECS=(
    "gstreamer1.0-plugins-bad" "gstreamer1.0-plugins-ugly"
    "gstreamer1.0-plugins-good" "gstreamer1.0-libav" "gstreamer1.0-rtsp"
)
sudo apt install -y "${CODECS[@]}"
print_success "Media codecs are ready to go!"
wait_for_user

# --- Step 4: Download the Source Code ---
print_step "Step 4: Downloading GNOME Network Displays..."
if [ -d "gnome-network-displays" ]; then
    print_warning "A 'gnome-network-displays' directory already exists. Using existing directory."
else
    echo "Cloning the official repository..."
    git clone https://gitlab.gnome.org/GNOME/gnome-network-displays.git
fi
cd gnome-network-displays
print_success "Source code downloaded!"
wait_for_user

# --- Step 5: Check Out Compatible Version ---
print_step "Step 5: Selecting a compatible version..."
echo "The latest version of GNOME Network Displays has compatibility issues with this system's NetworkManager."
echo "Checking out version 0.90.5, which is known to be compatible."
git checkout v0.90.5
print_success "Ready to build version 0.90.5!"
wait_for_user

# --- Step 6: Configure the Build ---
print_step "Step 6: Configuring the build..."
echo "Configuring the build environment using Meson."
if [ -d "build" ]; then
    rm -rf build
fi
meson build
print_success "Build configured successfully!"
wait_for_user

# --- Step 7: Compile the Software ---
print_step "Step 7: Compiling... this might take a moment!"
echo "Compiling the source code. This may take a few minutes."
cd build
ninja
if [ $? -ne 0 ]; then
    print_error "Oh no, the build failed! Please check the output above for errors."
    exit 1
fi
print_success "Compilation successful!"
wait_for_user

# --- Step 8: Install the Software ---
print_step "Step 8: Installing Pop!_Cast..."
echo "Installing the compiled software to the system."
sudo ninja install
print_success "Installation complete!"
wait_for_user

# --- Final Message ---
clear
echo -e "${STYLE_BOLD}Installation complete! Pop!_Cast is ready!${STYLE_RESET}"
echo ""
echo "You can now find 'Network Displays' in your applications menu,"
echo "or you can run it from the terminal with the command:"
echo -e "${COLOR_BLUE}gnome-network-displays${COLOR_RESET}"
echo ""
echo "The installation is complete."
echo ""
cd ../.. 