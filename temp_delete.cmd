@echo off

echo @echo off > temp_delete.cmd
echo timeout /t 2 > nul >> temp_delete.cmd
echo del "config.cmd" >> temp_delete.cmd
echo del "temp_delete.cmd" >> temp_delete.cmd

start "" /b temp_delete.cmd

exit