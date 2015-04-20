@Echo OFF
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....

cd C:\RadicalFlyff\Resource
merge3.exe

cls 
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....DONE!
Echo Copying Files to ResClient....

set source=E:\RadicalFlyff\Client
set destination=E:\ResClient
xcopy %source% %destination% /s /e /y

cls
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....DONE!
Echo Copying Files to ResClient....DONE!
Echo All Finished!

PAUSE