# server_backup_profile
Automates the download from a server through scp.
Creates a download backup, so anytime you need to make a local backup from your application, just run this command and everything will be download automatically, without needing to remember or insert data from user, server address, local backup or application path in the server.

## Usage

1. Download de project.
2. Go to project root folder.
3. Type `sudo make`. This perform the utility installation, so the command can be activated from any place.
4. Execute the utlity running `sbprofile`, and you will be guided through the needed steps to register a profile and, after then, downloads the application easily.

## How does the profile information is stored?
Important to know of you have to do some customization. The utility still lacks some *profiling management*, so removing, editing or quering informations profiles may be needed by hand.

The utility creates a hidden folder in your home user directory called `.sbprofile`. There, have text files (without txt extension) holding the profiles informations in the form of `key:value`. You can query, edit or delete profiles changing those profiles files.
