# TeraBoxSecure
An effort to make the TeraBox Windows desktop app as secure and safe as possible

This is done by eliminating the functionality of the auto updater by replacing its' .exe and .dll with versions that have the headers corrupted and removing almost all of the registry entries that get installed with the program - as well as a batch script to launch TeraBox, wait for it to end, and delete all of these registry keys again since it recreates many of them while running

You will get occasional errors while TeraBox is running about the auto updater not being able to run on Windows, this is intentional as stated above
