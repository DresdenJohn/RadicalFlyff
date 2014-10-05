Imports System.IO
Module CUpdater

    Public DebugMode As Boolean = False

    Public PatcherName As String = "RadStarter"

    Sub Main()
        Dim Args() As String = Environment.GetCommandLineArgs

        If Args(1).Equals(PatcherName) Then

            System.Threading.Thread.Sleep(500)

            CUpdater.DeleteFile(PatcherName + ".exe")
            File.Move("NewPatcher.exe", PatcherName + ".exe")

            System.Threading.Thread.Sleep(500)

            System.Diagnostics.Process.Start(PatcherName + ".exe")
        End If

    End Sub

    Public Sub DeleteFile(ByVal FileName As String)
        If File.Exists(FileName) Then File.Delete(FileName)
    End Sub

End Module
