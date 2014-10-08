<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class CPatcher
    Inherits System.Windows.Forms.Form

    'Das Formular überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(CPatcher))
        Me.LabelStaus = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.WebBrowser1 = New System.Windows.Forms.WebBrowser()
        Me.CProgressBarCurrent = New Open_Source_Patcher_v3.CProgressBar()
        Me.CProgressBarTotal = New Open_Source_Patcher_v3.CProgressBar()
        Me.SuspendLayout()
        '
        'LabelStaus
        '
        Me.LabelStaus.BackColor = System.Drawing.Color.Transparent
        Me.LabelStaus.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LabelStaus.ForeColor = System.Drawing.Color.DarkGray
        Me.LabelStaus.Location = New System.Drawing.Point(10, 451)
        Me.LabelStaus.Name = "LabelStaus"
        Me.LabelStaus.Size = New System.Drawing.Size(352, 16)
        Me.LabelStaus.TabIndex = 2
        Me.LabelStaus.Text = "-"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Enabled = False
        Me.Label1.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.Color.DarkGray
        Me.Label1.Location = New System.Drawing.Point(368, 446)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(125, 25)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Start Game"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.DarkGray
        Me.Label2.Location = New System.Drawing.Point(9, 9)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(151, 16)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Radical Flight Online Patcher"
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.Color.DarkGray
        Me.Label3.Location = New System.Drawing.Point(403, 381)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(84, 16)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "0/0"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.ForeColor = System.Drawing.Color.DarkGray
        Me.Label4.Location = New System.Drawing.Point(12, 381)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(52, 16)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "Progress"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.Label5.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.Color.DarkGray
        Me.Label5.Location = New System.Drawing.Point(10, 408)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(80, 16)
        Me.Label5.TabIndex = 7
        Me.Label5.Text = "Total Progress"
        '
        'Label6
        '
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.Label6.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.Color.DarkGray
        Me.Label6.Location = New System.Drawing.Point(477, 10)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(14, 16)
        Me.Label6.TabIndex = 8
        Me.Label6.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label7
        '
        Me.Label7.BackColor = System.Drawing.Color.Transparent
        Me.Label7.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.ForeColor = System.Drawing.Color.DarkGray
        Me.Label7.Location = New System.Drawing.Point(458, 10)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(14, 16)
        Me.Label7.TabIndex = 9
        Me.Label7.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'Label8
        '
        Me.Label8.BackColor = System.Drawing.Color.Transparent
        Me.Label8.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.ForeColor = System.Drawing.Color.DarkGray
        Me.Label8.Location = New System.Drawing.Point(439, 10)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(14, 16)
        Me.Label8.TabIndex = 10
        Me.Label8.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'WebBrowser1
        '
        Me.WebBrowser1.AllowNavigation = False
        Me.WebBrowser1.Location = New System.Drawing.Point(6, 31)
        Me.WebBrowser1.MinimumSize = New System.Drawing.Size(20, 20)
        Me.WebBrowser1.Name = "WebBrowser1"
        Me.WebBrowser1.ScrollBarsEnabled = False
        Me.WebBrowser1.Size = New System.Drawing.Size(487, 335)
        Me.WebBrowser1.TabIndex = 11
        '
        'CProgressBarCurrent
        '
        Me.CProgressBarCurrent.BackColor = System.Drawing.Color.Transparent
        Me.CProgressBarCurrent.BackgroundImage = CType(resources.GetObject("CProgressBarCurrent.BackgroundImage"), System.Drawing.Image)
        Me.CProgressBarCurrent.Location = New System.Drawing.Point(12, 400)
        Me.CProgressBarCurrent.Maximum = 100.0R
        Me.CProgressBarCurrent.Minimum = 0.0R
        Me.CProgressBarCurrent.Name = "CProgressBarCurrent"
        Me.CProgressBarCurrent.Size = New System.Drawing.Size(475, 5)
        Me.CProgressBarCurrent.TabIndex = 1
        Me.CProgressBarCurrent.Value = 0.0R
        '
        'CProgressBarTotal
        '
        Me.CProgressBarTotal.BackColor = System.Drawing.Color.Transparent
        Me.CProgressBarTotal.BackgroundImage = CType(resources.GetObject("CProgressBarTotal.BackgroundImage"), System.Drawing.Image)
        Me.CProgressBarTotal.Location = New System.Drawing.Point(12, 428)
        Me.CProgressBarTotal.Maximum = 100.0R
        Me.CProgressBarTotal.Minimum = 0.0R
        Me.CProgressBarTotal.Name = "CProgressBarTotal"
        Me.CProgressBarTotal.Size = New System.Drawing.Size(475, 5)
        Me.CProgressBarTotal.TabIndex = 0
        Me.CProgressBarTotal.Value = 0.0R
        '
        'CPatcher
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.ClientSize = New System.Drawing.Size(501, 478)
        Me.Controls.Add(Me.WebBrowser1)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.LabelStaus)
        Me.Controls.Add(Me.CProgressBarCurrent)
        Me.Controls.Add(Me.CProgressBarTotal)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "CPatcher"
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Patcher"
        Me.TransparencyKey = System.Drawing.Color.Fuchsia
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents CProgressBarTotal As Open_Source_Patcher_v3.CProgressBar
    Friend WithEvents CProgressBarCurrent As Open_Source_Patcher_v3.CProgressBar
    Friend WithEvents LabelStaus As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents WebBrowser1 As System.Windows.Forms.WebBrowser

End Class
