Imports System
Imports System.IO
Imports System.Security.Cryptography

Module PatchUpdate

    Public version As String = "ver:2.4"

    Public useMerge As Boolean = False
    Public mergeLocation As String = "C:\Server\Resource\"
    Public mergeExeName As String = "1.Merge2.exe"

    Public patchLocation As String = "C:\ResClient"
    Public gZipLocation As String = "C:\gZip.exe"

    Sub Main()

        Console.WriteLine("Universal PatchMaker")
        Console.WriteLine("Press any key to Start")
        Console.ReadKey()

        If useMerge Then
            Console.WriteLine("")
            Console.Write("Creating .Res files....")

            Dim m As New Process
            m.StartInfo.FileName = mergeLocation + mergeExeName
            m.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
            m.Start()

            Do While Process.GetProcessesByName(mergeExeName).Length > 0 : System.Threading.Thread.Sleep(100) : Loop

            Console.Write("DONE" + vbNewLine)
        End If

        Console.WriteLine("")
        Console.Write("Compressing Files....")

        For Each FileFound As String In Directory.GetFiles(patchLocation, "*.gz", SearchOption.AllDirectories)
            File.Delete(FileFound)
        Next

        Dim p As New Process
        p.StartInfo.FileName = "C:\gZip.exe"
        p.StartInfo.Arguments = "-k -r -1" + "  " + patchLocation
        p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
        p.Start()

        Do While Process.GetProcessesByName("gZip").Length > 0 : System.Threading.Thread.Sleep(100) : Loop

        Console.Write("DONE" + vbNewLine)

        Console.WriteLine("")
        Console.Write("Creating list.txt....")
        My.Computer.FileSystem.WriteAllText(patchLocation + "\" + "list.txt", version + vbNewLine, False)

        checkDirectory(patchLocation)

        Console.Write("DONE" + vbNewLine)
        Console.WriteLine("")
        Console.Write("Procedure Completed! Press any key to exit.")
        Console.ReadKey()
    End Sub

    Public Function MD5FileHash(ByVal sFile As String) As String
        If IsNothing(sFile) Then Return Nothing
        Dim MD5 As New MD5CryptoServiceProvider
        Dim Hash As Byte()
        Dim Result As String = ""
        Dim Tmp As String = ""

        Dim FN As New FileStream(sFile, FileMode.Open, FileAccess.Read, FileShare.Read, 8192)
        MD5.ComputeHash(FN)
        FN.Close()

        Hash = MD5.Hash
        For i As Integer = 0 To Hash.Length - 1
            Tmp = Hex(Hash(i))
            If Len(Tmp) = 1 Then Tmp = "0" & Tmp
            Result += Tmp
        Next
        Return Result.ToLower
    End Function

    Public Sub checkDirectory(ByRef location As String)

        For Each Dir As String In Directory.GetDirectories(location)

            checkDirectory(Dir)

        Next

        addFiles(location)

    End Sub

    Public Sub addFiles(ByRef curDir As String)

        Dim di As New DirectoryInfo(curDir)
        Dim fiArr As FileInfo() = di.GetFiles()

        Dim startDate As New DateTime(1970, 1, 1)
        Dim noOfSeconds As Long

        Dim fri As FileInfo
        For Each fri In fiArr

            Dim fileName As String = fri.DirectoryName.Remove(0, patchLocation.Length) + "\" + fri.Name

            fileName = fileName.Remove(0, 1)

            'Dim lastUpdate As String = fri.LastWriteTime.ToString

            'Dim dateUpdated As DateTime

            'DateTime.TryParse(lastUpdate, dateUpdated)

            'noOfSeconds = (dateUpdated - startDate).TotalSeconds

            ' fri.Length.ToString + "|" + noOfSeconds.ToString() + "|" +


            If Not fri.Name.Contains("list") Then
                If Not fri.Name.Contains("SwiftStarter") Then
                    If Not fri.Name.Contains("Updater") Then
                        If Not fri.Name.Contains("gz") Then
                            My.Computer.FileSystem.WriteAllText(
                                patchLocation + "\" + "list.txt",
                                fileName + "|" + 
                                MD5FileHash(fri.FullName) + vbNewLine,
                                True
                            )
                        End If
                    End If
                End If
            End If
            
        Next fri

    End Sub

End Module
