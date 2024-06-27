# TeraBoxSecure
An effort to make the TeraBox Windows desktop app as secure and safe as possible

This is done by eliminating the functionality of the auto updater by replacing its' .exe and .dll with versions that have the headers corrupted and removing almost all of the registry entries that get installed with the program - as well as a batch script to launch TeraBox, wait for it to end, and delete all of these registry keys again since it recreates many of them while running

You will get occasional errors while TeraBox is running about the auto updater not being able to run on Windows, this is intentional as stated above

This batch script is meant to be installed by an installer made with Advanced Installer 16.3+ - which is available on both my Google Drive and TeraBox

If you want to use the batch script on an existing installation of TeraBox, simply save it as a .bat file in the same directory as TeraBox.exe and replace all instances of [APPDIR] in the batch file with the path to your TeraBox installation
