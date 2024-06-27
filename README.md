# TeraBoxSecure
An effort to make the TeraBox Windows desktop app as secure and safe as possible

This is done by eliminating the functionality of the auto updater by replacing its' .exe and .dll with versions that have the headers corrupted and removing almost all of the registry entries that get installed with the program - as well as a batch script to launch TeraBox, wait for it to end, and delete all of these registry keys again since it recreates many of them while running

You will get occasional errors while TeraBox is running about the auto updater not being able to run on Windows, this is intentional as stated above

This batch script is meant to be installed by an installer made with Advanced Installer 16.3+ and utilizes files with corrupted headers to replace the auto updater as well as some custom config files - neither of which are provided here

I've made my own installer using Advanced Installer for TeraBoxSecure (which I highly recommend you use rather than trying to do it yourself) and it is available on my [Google Drive]([https://www.google.com](https://drive.google.com/file/d/1rwlfD5PC0_0vtwV8cm02eTkDd5c_--RA)
