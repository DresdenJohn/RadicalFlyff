Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Globalization
Imports System.Security.Cryptography
Imports System.Net.NetworkInformation
Public Class CFunc

    Private Shared WithEvents Client As New WebClient
    Private Shared PatchList(0) As String
    Private Shared MaxUpdate As Integer = 0
    Public Shared IsFinished As Boolean = False

    Private Shared Sub Client_DownloadProgressChanged(ByVal sender As Object, ByVal e As System.Net.DownloadProgressChangedEventArgs) Handles Client.DownloadProgressChanged
        CPatcher.CProgressBarCurrent.Value = e.ProgressPercentage
    End Sub

    Public Shared Sub Download(ByRef URL As String, ByRef Destination As String)
        CFunc.Client.DownloadFileAsync(New Uri(URL), Destination)
        Do While CFunc.Client.IsBusy : Application.DoEvents() : Loop
    End Sub

    Public Shared Sub Init()

        If Not Config.PatchUrl.EndsWith("/") Then Config.PatchUrl &= "/"

        If Config.IsDebugging Then
            If File.Exists(Config.ClientName) And File.Exists(Config.antihack) Then
                Process.Start(Config.ClientName, Config.ClientParam)
                CFunc.Delay(1000)
                If Config.useAntihack Then
                    Dim m As New Process
                    m.StartInfo.FileName = Config.antihack
                    m.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
                    m.Start()
                End If
                
                End
            Else
                MessageBox.Show("Required Startup Files are missing.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End
            End If
        End If

        CFunc.SetPatcherColor(Config.PatcherColor)

        CFunc.Status("Checking for Updates...")
        CFunc.DeleteFile("list.txt")
        CFunc.Download(Config.PatchUrl & "list.txt", "list.txt")

        If Not File.Exists("list.txt") Then
            MessageBox.Show("A connection could not be established." & vbNewLine & "Please check your connection and try again.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error, MessageBoxDefaultButton.Button1)
            CPatcher.Dispose()
            Return
        End If

        CPatcher.CProgressBarTotal.Maximum = 1

        ' Step 1: Check for new version of patcher

        Dim Scanner As New StreamReader("list.txt")
        Dim Version As String = Scanner.ReadLine



        If Not Version = Config.Version Then
            Scanner.Close()
            CFunc.SelfUpdate()
        End If

        ' Step 2: Check using server's last update creation to see if an udpate is required.


        ' Step 3: Patch files

        Dim counter As Integer = 1



        Do Until Scanner.EndOfStream
            Dim Line As String = Scanner.ReadLine
            Dim Args() As String = Line.Split("|")

            CFunc.Status("Checking for patches...Please Wait...")
            CFunc.DirectoryCheck(Args(0))
            CFunc.FileCheck(Args)

            counter += 1
        Loop
        Scanner.Close()

        CPatcher.CProgressBarTotal.Maximum += CFunc.MaxUpdate
        CPatcher.Label3.Text = "1/" & CPatcher.CProgressBarTotal.Maximum

        For i As Integer = 0 To CFunc.PatchList.Length - 2
            CPatcher.Label3.Text = i + 1 & "/" & CPatcher.CProgressBarTotal.Maximum
            Dim Args() As String = CFunc.PatchList(i).Split(vbTab)

            CFunc.Status(Args(0))
            CFunc.Download(Config.PatchUrl & Args(0) & ".gz", Args(0) + ".gz")

            CPatcher.CProgressBarTotal.Value += 1

            CFunc.Decompress(Args(0) + ".gz")
        Next

        CPatcher.CProgressBarTotal.Value = CPatcher.CProgressBarTotal.Maximum
        CPatcher.Label3.Text = CPatcher.CProgressBarTotal.Maximum & "/" & CPatcher.CProgressBarTotal.Maximum

        Do While Process.GetProcessesByName("gZip").Length > 0 : Application.DoEvents() : Loop
        CFunc.DeleteFile("gZip.exe")

        'For i As Integer = 0 To CFunc.PatchList.Length - 2
        '    Dim Args() As String = CFunc.PatchList(i).Split(vbTab)

        '    Dim Fecha As New DateTime(1970, 1, 1)

        '    'Fecha.AddSeconds(Args(2))



        '    If Not Args(0).EndsWith(".gz") And File.Exists(Args(0)) Then
        '        If Not Args(0).Contains("SwiftStarter") Then
        '            File.SetLastWriteTime(Args(0), Fecha)
        '        End If
        '    End If

        'Next

        CFunc.IsFinished = True
        CPatcher.Label1.Enabled = True
        CFunc.Status("Update finished!")

    End Sub

    Private Shared Function AddLineToStringArray(ByVal Array As String(), ByVal Line As String) As String()
        Dim IncreasedArray As String() = New String(Array.Length) {}
        For Pos As Integer = 0 To Array.Length - 1
            IncreasedArray(Pos) = Array(Pos)
        Next
        IncreasedArray(Array.Length - 1) = Line
        Return IncreasedArray
    End Function

    Public Shared Sub FileCheck(ByVal Param() As String)

        'Dim startDate As New DateTime(1970, 1, 1)
        'Dim noOfSeconds As Long = 0

        'Dim fileInfo As New FileInfo(Param(0))
        'Dim lastUpdate As String = fileInfo.LastWriteTime.ToString

        'Dim dateUpdated As DateTime = DateTime.Parse(lastUpdate)

        'noOfSeconds = (dateUpdated - startDate).TotalSeconds

        If Not Param(0).EndsWith(".gz") Then
            If Not Param(0).Contains("SwiftStarter") Then
                If Not File.Exists(Param(0)) Then
                    CFunc.PatchList = CFunc.AddLineToStringArray(CFunc.PatchList, Param(0) & vbTab & Param(1))
                    CFunc.MaxUpdate += 1
                    'ElseIf Not noOfSeconds.Equals(0) Then
                    '    CFunc.PatchList = CFunc.AddLineToStringArray(CFunc.PatchList, Param(0) & vbTab & Param(1) & vbTab & Param(2))
                    '    CFunc.MaxUpdate += 1
                    'ElseIf Not fileInfo.Length.ToString = Param(1) Then
                    '    CFunc.PatchList = CFunc.AddLineToStringArray(CFunc.PatchList, Param(0) & vbTab & Param(1) & vbTab & Param(2))
                    '    CFunc.MaxUpdate += 1
                ElseIf Config.UseMd5Check AndAlso Not MD5FileHash(Param(0)) = Param(1) Then
                    CFunc.PatchList = CFunc.AddLineToStringArray(CFunc.PatchList, Param(0) & vbTab & Param(1))
                    CFunc.MaxUpdate += 1
                End If
            End If
        End If

    End Sub

    Public Shared Sub DirectoryCheck(ByVal Param As String)

        If Not Param.Contains("\") Then
            Exit Sub
        End If
        Dim nParam() As String = Param.Split("\")
        Dim Str As String = Nothing
        For i As Integer = 0 To nParam.Length - 2
            Str &= nParam(i) & "\"
            If Not Directory.Exists(Str) Then
                Directory.CreateDirectory(Str)
            End If
        Next
    End Sub

    Public Shared Sub DeleteFile(ByVal FileName As String)
        If File.Exists(FileName) Then File.Delete(FileName)
    End Sub

    Public Shared Sub DeleteDirectory(ByVal DirectoryName As String)
        If Directory.Exists(DirectoryName) Then Directory.Delete(DirectoryName)
    End Sub

    Public Shared Sub Decompress(ByVal lpszFile As String)
        Do While Process.GetProcessesByName("gzip").Length >= Config.MaxDecompress : Application.DoEvents() : Loop
        If lpszFile.EndsWith(".gz") Then
            If Not File.Exists("gZip.exe") Then
                File.WriteAllBytes("gZip.exe", My.Resources.gzip)
                CFunc.Delay(1000)
            End If
            Dim p As New Process
            p.StartInfo.FileName = "gZip.exe"
            p.StartInfo.Arguments = "-f -q -d " & Chr(34) & lpszFile & Chr(34)
            p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
            p.Start()
        End If
    End Sub

    Private Shared Sub Status(ByRef Text As String)
        CPatcher.LabelStaus.Text = Text
        Application.DoEvents()
    End Sub

    Public Shared Sub Delay(ByVal zeit As Integer)
        Dim zeit1 As Integer = Environment.TickCount
        While (Environment.TickCount - zeit1) < zeit
            Application.DoEvents()
        End While
    End Sub

    Public Shared Function MD5FileHash(ByVal sFile As String) As String
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

    Public Shared Sub SetPatcherColor(ByVal Value As Config.Clr)
        Select Case Value
            Case Config.Clr.Blue
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarBlue
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarBlue
                CPatcher.Label1.Image = My.Resources.StartButtonBlue
            Case Config.Clr.Green
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarGreen
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarGreen
                CPatcher.Label1.Image = My.Resources.StartButtonGreen
            Case Config.Clr.Orange
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarOrange
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarOrange
                CPatcher.Label1.Image = My.Resources.StartButtonOrange
            Case Config.Clr.Red
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarRed
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarRed
                CPatcher.Label1.Image = My.Resources.StartButtonRed
            Case Config.Clr.Violett
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarViolett
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarViolett
                CPatcher.Label1.Image = My.Resources.StartButtonViolett
            Case Config.Clr.Yellow
                CPatcher.CProgressBarCurrent.PictureBox1.BackgroundImage = My.Resources.ProgressBarYellow
                CPatcher.CProgressBarTotal.PictureBox1.BackgroundImage = My.Resources.ProgressBarYellow
                CPatcher.Label1.Image = My.Resources.StartButtonYellow
        End Select
    End Sub

    Private Shared Sub SelfUpdate()
        CFunc.DeleteFile("Updater.exe")
        CFunc.DeleteFile("NewPatcher.exe")
        CFunc.Download(Config.PatchUrl & "Updater.exe", "Updater.exe")
        CFunc.Download(Config.PatchUrl & Config.PatcherName & ".exe", "NewPatcher.exe")


        Dim p As New Process
        p.StartInfo.FileName = "Updater.exe"
        p.StartInfo.Arguments = Config.PatcherName
        p.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
        p.Start()
        

        CFunc.Delay(500)
        End
    End Sub

End Class
