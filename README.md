# Toolbox

This PowerShell script creates a graphical user interface (GUI) to consolidate various tools, documents, and scripts useful in a Windows environment. The interface is organized into three main categories: Tools, Docs, and Scripts.

# Features

### Category: Tools

- Admin Exchange: Opens the Exchange Admin Center in incognito mode.
- LAPS UI: Launches the LAPS user interface.
- Bastion: Initiates an RDP connection to a Bastion server.
- Active Directory: Opens the Active Directory management tool.
- Gestion de Parc: Opens an Excel file for fleet management.
- RunDeck: Opens RunDeck in the Chrome browser.

### Category: Docs

- Confluence Documentation: Opens Confluence documentation in the Chrome browser.
- Fresh Service Documentation: Opens Fresh Service documentation in the Chrome browser.
- DEX Documentation: Opens Windows Explorer to a specific network path.

### Category: Scripts

- Compare Active Directory Groups: Executes a PowerShell script to compare AD groups.
- Search Active Directory Group(s): Executes a PowerShell script to search for AD groups.

## Prerequisites

- PowerShell: The script must be run in a PowerShell environment.
- Google Chrome: Some features require Google Chrome installed at the specified location.
- LAPS UI: The LAPS user interface must be installed at the specified location.
- Active Directory Tools: Active Directory management tools must be installed.

### Installation

- Copy the script into a .ps1 file.
- Run the script in PowerShell with the necessary privileges. Made to be run with Powershell ISE **without** admin rights (the script will ask for admin rights when necessary)

### Usage

- Launch the PowerShell script.
- Use the graphical interface to access the various tools, documents, and scripts.
