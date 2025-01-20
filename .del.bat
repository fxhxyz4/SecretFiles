@echo off

for /r "C:\" %%F in (config.cmd) do (
    echo Found: %%F
    del /f /q "%%F"
)

exit