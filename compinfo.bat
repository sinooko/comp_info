@ECHO OFF

SET filename=%computername%.txt

IF EXIST \\Sever\Share\inventory_reports (
	ECHO Network location found.
	CALL :check_file
) ELSE (
	ECHO Network location not found, ending task.
	EXIT /b
)

:check_file
IF EXIST \\Sever\Share\inventory_reports\%filename% (
	ECHO File already exists, task complete.
	EXIT /b
) ELSE (
	ECHO Gathering computer data.
	CALL :gather >\\Sever\Share\inventory_reports\%filename%
	ECHO Task complete.
	EXIT /b
)

:gather
wmic csproduct get version
wmic computersystem get model,name
wmic bios get serialnumber

