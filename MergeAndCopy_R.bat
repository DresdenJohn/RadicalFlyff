@Echo OFF
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....

cd R:\RadicalFlyff\Resource
merge3.exe

cls 
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....DONE!
Echo Copying Files to ResClient....

set source=R:\RadicalFlyff\Client
set destination=R:\ResClient
xcopy %source% %destination% /s /e /y

cls
Echo Flyff Merge, Copy, and Patch service!
Echo Made by John
Echo Running Merge....DONE!
Echo Copying Files to ResClient....DONE!
Echo All Finished!

PAUSE