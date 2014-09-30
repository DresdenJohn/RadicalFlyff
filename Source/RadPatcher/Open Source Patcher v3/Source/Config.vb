Public Class Config

    Public Shared Version As String = "ver:2.4"
    Public Shared FormMove As Boolean = True
    Public Shared PatchUrl As String = "http://localhost/flyffpatch/" '"http://198.204.232.58/sfopatch/" '
    Public Shared MaxDecompress As Integer = 10
    Public Shared UseMd5Check As Boolean = True
    Public Shared PatcherColor As Config.Clr = Config.Clr.Blue
    Public Shared NewsURL As String = "http://swiftgaming.net/flyffPatch.aspx"
    Public Shared antihack As String = "SwiftProtect.exe"
    Public Shared useAntihack As Boolean = False

    Public Shared PatcherName As String = "SwiftStarter"
    Public Shared ClientName As String = "Neuz.exe"
    Public Shared ClientParam As String = "okgoogle 1"
    Public Shared IsDebugging As Boolean = False

    Public Enum Clr
        Blue
        Green
        Orange
        Red
        Violett
        Yellow
    End Enum

End Class