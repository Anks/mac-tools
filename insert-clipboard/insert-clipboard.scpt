#!/usr/bin/osascript
on run
	tell application "System Events"
		keystroke (the clipboard)
	end tell
end run
