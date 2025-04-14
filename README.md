# Toolbox

This PowerShell script creates a graphical user interface (GUI) to consolidate various tools, documents, and scripts useful in a Windows environment. The interface is organized into three main categories: Tools, Docs, and Scripts. You can change this script to adapt to your needs. 

# Features

### Category: Tools

- Admin Exchange: Opens the Exchange Admin Center in incognito mode. Check if google chrome is installed.
- LAPS UI: Launches the LAPS user interface. Check if LAPS UI is installed. 
- Bastion: Initiates an RDP connection to a Bastion server. 
- Active Directory: Opens the Active Directory management tool. Check if RSAT tool "Active Directory" is installed. 
- Fleet Management: Opens an Excel file for fleet management. 
- RunDeck: Opens RunDeck in the Chrome browser. Check if google chrome is installed.

### Category: Docs

- Confluence Documentation: Opens Confluence documentation in the Chrome browser. 
- Fresh Service Documentation: Opens Fresh Service documentation in the Chrome browser.
- DEX Documentation: Opens Windows Explorer to a specific network path. 

### Category: Scripts

- Compare Active Directory Groups: Executes a PowerShell script to compare AD groups. You need to set the path to your PS1 script.
- Search Active Directory Group(s): Executes a PowerShell script to search for AD groups. You need to set the path to your PS1 script. 

## Prerequisites

- PowerShell: The script must be run in a PowerShell environment, running with Powershell ISE, **without** admin rights. (The script will ask for admin rights when necessary)
- Google Chrome: Some features require Google Chrome installed at the specified location.
- LAPS UI: The LAPS user interface must be installed at the specified location.
- Active Directory Tools: Active Directory management tools must be installed.

### Installation

- Copy the script into a .ps1 file.
- Run the script in PowerShell with the necessary privileges.

### Usage

- Launch the PowerShell script.
- Use the graphical interface to access the various tools, documents, and scripts.
