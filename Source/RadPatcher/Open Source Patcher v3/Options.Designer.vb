<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Options
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Options))
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.resolution = New System.Windows.Forms.ComboBox()
        Me.fieldDetail = New System.Windows.Forms.ComboBox()
        Me.objectDetail = New System.Windows.Forms.ComboBox()
        Me.objectRange = New System.Windows.Forms.ComboBox()
        Me.shadowDetail = New System.Windows.Forms.ComboBox()
        Me.fullscreen = New System.Windows.Forms.CheckBox()
        Me.CProgressBarCurrent = New Open_Source_Patcher_v3.CProgressBar()
        Me.CProgressBarTotal = New Open_Source_Patcher_v3.CProgressBar()
        Me.SuspendLayout()
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Font = New System.Drawing.Font("Trebuchet MS", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.DarkGray
        Me.Label2.Location = New System.Drawing.Point(9, 9)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(169, 16)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Swift Flight Online Options Menu"
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
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Location = New System.Drawing.Point(98, 235)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(128, 27)
        Me.Label1.TabIndex = 9
        Me.Label1.Text = "Save"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.Location = New System.Drawing.Point(275, 235)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(128, 27)
        Me.Label3.TabIndex = 10
        Me.Label3.Text = "Close"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'resolution
        '
        Me.resolution.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.resolution.FormattingEnabled = True
        Me.resolution.Items.AddRange(New Object() {"800x600", "1024x768", "1280x720", "1280x768", "1280x800", "1360x768", "1440x900", "1600x1200", "1680x1050"})
        Me.resolution.Location = New System.Drawing.Point(260, 48)
        Me.resolution.Name = "resolution"
        Me.resolution.Size = New System.Drawing.Size(150, 21)
        Me.resolution.TabIndex = 11
        '
        'fieldDetail
        '
        Me.fieldDetail.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.fieldDetail.FormattingEnabled = True
        Me.fieldDetail.Items.AddRange(New Object() {"High", "Medium", "Low"})
        Me.fieldDetail.Location = New System.Drawing.Point(69, 116)
        Me.fieldDetail.Name = "fieldDetail"
        Me.fieldDetail.Size = New System.Drawing.Size(121, 21)
        Me.fieldDetail.TabIndex = 12
        '
        'objectDetail
        '
        Me.objectDetail.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.objectDetail.FormattingEnabled = True
        Me.objectDetail.Items.AddRange(New Object() {"High", "Medium", "Low"})
        Me.objectDetail.Location = New System.Drawing.Point(314, 116)
        Me.objectDetail.Name = "objectDetail"
        Me.objectDetail.Size = New System.Drawing.Size(121, 21)
        Me.objectDetail.TabIndex = 13
        '
        'objectRange
        '
        Me.objectRange.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.objectRange.FormattingEnabled = True
        Me.objectRange.Items.AddRange(New Object() {"High", "Medium", "Low"})
        Me.objectRange.Location = New System.Drawing.Point(314, 184)
        Me.objectRange.Name = "objectRange"
        Me.objectRange.Size = New System.Drawing.Size(121, 21)
        Me.objectRange.TabIndex = 14
        '
        'shadowDetail
        '
        Me.shadowDetail.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.shadowDetail.FormattingEnabled = True
        Me.shadowDetail.Items.AddRange(New Object() {"High", "Medium", "Low"})
        Me.shadowDetail.Location = New System.Drawing.Point(69, 184)
        Me.shadowDetail.Name = "shadowDetail"
        Me.shadowDetail.Size = New System.Drawing.Size(121, 21)
        Me.shadowDetail.TabIndex = 15
        '
        'fullscreen
        '
        Me.fullscreen.BackColor = System.Drawing.Color.Transparent
        Me.fullscreen.Location = New System.Drawing.Point(61, 45)
        Me.fullscreen.Name = "fullscreen"
        Me.fullscreen.Size = New System.Drawing.Size(96, 24)
        Me.fullscreen.TabIndex = 16
        Me.fullscreen.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.fullscreen.UseVisualStyleBackColor = False
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
        'Options
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.ClientSize = New System.Drawing.Size(501, 271)
        Me.Controls.Add(Me.fullscreen)
        Me.Controls.Add(Me.shadowDetail)
        Me.Controls.Add(Me.objectRange)
        Me.Controls.Add(Me.objectDetail)
        Me.Controls.Add(Me.fieldDetail)
        Me.Controls.Add(Me.resolution)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.CProgressBarCurrent)
        Me.Controls.Add(Me.CProgressBarTotal)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Options"
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Patcher"
        Me.TransparencyKey = System.Drawing.Color.Fuchsia
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents CProgressBarTotal As Open_Source_Patcher_v3.CProgressBar
    Friend WithEvents CProgressBarCurrent As Open_Source_Patcher_v3.CProgressBar
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents resolution As System.Windows.Forms.ComboBox
    Friend WithEvents fieldDetail As System.Windows.Forms.ComboBox
    Friend WithEvents objectDetail As System.Windows.Forms.ComboBox
    Friend WithEvents objectRange As System.Windows.Forms.ComboBox
    Friend WithEvents shadowDetail As System.Windows.Forms.ComboBox
    Friend WithEvents fullscreen As System.Windows.Forms.CheckBox

End Class
