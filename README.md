# Set-RDSetting

Ok, so this was off the back of a previous script where after I had been
required to find all users who had the "Deny this user permissions to log on
to Remote Desktop Session Host server" setting enabled, I then needed to
remove that setting.

I wasn't bright enough to build it all in the same script (ie. find and
 then fix) in the necessary time frame so this script utilised the CSV
 files that were output from the 'find' script and then clears the setting.

Sticking it here as changing settings not available to using AD User
or AD Object was new to me and this may come in handy again some time.