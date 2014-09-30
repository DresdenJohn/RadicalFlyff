Public Class CProgressBar

    Public Sub New()
        InitializeComponent()
    End Sub

    Protected MinValue As Double = 0.0
    Protected MaxValue As Double = 100.0
    Protected Percent As Double = 0.0

    Property Minimum As Double
        Get
            Return MinValue
        End Get
        Set(ByVal value As Double)
            If MinValue < 0 Then MinValue = 0 Else If MinValue > MaxValue Then MinValue = MaxValue
            MinValue = value
        End Set
    End Property

    Property Maximum As Double
        Get
            Return MaxValue
        End Get
        Set(ByVal value As Double)
            If MaxValue < 0 Then MaxValue = 0 Else If MaxValue < MinValue Then MaxValue = MinValue
            MaxValue = value
        End Set
    End Property

    Property Value As Double
        Get
            Return Percent
        End Get
        Set(ByVal value As Double)
            If value < Minimum Then value = Minimum Else If value > Maximum Then value = Maximum
            Percent = value
            If Percent = 0 Then
                picturebox1.Width = CInt(value * 4.75)
            Else
                picturebox1.Width = CInt(value * 4.75 / Maximum * 100)
            End If
        End Set
    End Property

    Private Sub Pbar_SizeChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.SizeChanged
        Me.Size = New Size(475, 5)
        Me.BackgroundImage = My.Resources.ProgressBar
        Me.BackColor = Color.Transparent
    End Sub

End Class
