Imports System.IO
Public Class CPatcher

#Region "=> Form"
    ' Form Bewegen
    Private ptMouseDownLocation As Point
    Private Sub f_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles Me.MouseDown
        If Config.FormMove AndAlso e.Button = Windows.Forms.MouseButtons.Left Then
            ptMouseDownLocation = e.Location
        End If
    End Sub
    Private Sub f_MouseMove(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles Me.MouseMove
        If Config.FormMove AndAlso e.Button = Windows.Forms.MouseButtons.Left Then
            Me.Location = e.Location - ptMouseDownLocation + Me.Location
        End If
    End Sub
    ' Initialisierung
    Private Sub CPatcher_Shown(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        CFunc.Init()
    End Sub
    ' Form unten rechts positionieren und im Vordergrund halten
    Private Sub CPatcher_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim x As Integer = Screen.PrimaryScreen.WorkingArea.Width - Me.Width
        Dim y As Integer = Screen.PrimaryScreen.WorkingArea.Height - Me.Height
        'Me.Location = New Point(x, y)
        WebBrowser1.Url = New Uri(Config.NewsURL)

        'Me.TopMost = True
    End Sub
    ' Exit
    Private Sub Label6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label6.Click
        End
    End Sub
    Private Sub FixedToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        End
    End Sub
    ' Minimieren
    Private Sub Label7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label7.Click
        Me.WindowState = FormWindowState.Minimized
    End Sub
    ' Hilfe / Credits anzeigen
    Private Sub Label8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label8.Click
        Options.Show()
    End Sub
    ' Client start
    Private Sub Label1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label1.Click
        If Not CFunc.IsFinished Then Exit Sub
        If File.Exists(Config.ClientName) Then
            Process.Start(Config.ClientName, Config.ClientParam)
            If Config.useAntihack Then
                CFunc.Delay(1000)
                Dim m As New Process
                m.StartInfo.FileName = Config.antihack
                m.StartInfo.WindowStyle = ProcessWindowStyle.Hidden
                m.Start()
            End If
            End
        Else
            MessageBox.Show(Config.ClientName & " could not be found.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub
#End Region

    Private Sub Label2_Click(sender As Object, e As EventArgs) Handles Label2.Click

    End Sub
End Class