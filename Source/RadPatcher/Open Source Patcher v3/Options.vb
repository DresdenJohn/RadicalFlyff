Imports System.IO
Imports System.Runtime.InteropServices
Imports System.Text

Public Class Options

    Public Sub saveINI()

        Dim currentNeuzFile As String = File.ReadAllText("neuz.ini")

        Dim newNeuzFile As String = ""

        ' Wait. What's that? the InstantHelp is always set to 1? FUCK THAT. FUCK THAT PENGUIN ASSISTANT.
        newNeuzFile = currentNeuzFile.Replace("InstantHelp 1", "InstantHelp 0")

        ' Check to use fullscreen mode or not
        If fullscreen.Checked Then
            newNeuzFile = currentNeuzFile.Replace("fullscreen 0", "fullscreen 1")
        Else
            newNeuzFile = currentNeuzFile.Replace("fullscreen 1", "fullscreen 0")
        End If

        ' Check and set the resolution for the window
        Dim selectedResolution As String = resolution.SelectedItem
        selectedResolution = selectedResolution.Replace("x", " ")

        newNeuzFile = newNeuzFile.Replace("800 600", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1024 768", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1280 720", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1280 768", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1280 800", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1360 768", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1440 900", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1600 1200", selectedResolution)
        newNeuzFile = newNeuzFile.Replace("1680 1050", selectedResolution)

        ' Pull the options for detail and view/distance
        Dim textureDetail As String = fieldDetail.SelectedIndex.ToString
        Dim objectView As String = objectRange.SelectedIndex.ToString
        Dim detailAmount As String = objectDetail.SelectedIndex.ToString

        ' Set detail options
        newNeuzFile = newNeuzFile.Replace("texture 0", "texture " + textureDetail)
        newNeuzFile = newNeuzFile.Replace("texture 1", "texture " + textureDetail)
        newNeuzFile = newNeuzFile.Replace("texture 2", "texture " + textureDetail)

        newNeuzFile = newNeuzFile.Replace("view 0", "view " + objectView)
        newNeuzFile = newNeuzFile.Replace("view 1", "view " + objectView)
        newNeuzFile = newNeuzFile.Replace("view 2", "view " + objectView)

        newNeuzFile = newNeuzFile.Replace("detail 0", "detail " + detailAmount)
        newNeuzFile = newNeuzFile.Replace("detail 1", "detail " + detailAmount)
        newNeuzFile = newNeuzFile.Replace("detail 2", "detail " + detailAmount)

        ' Finally save it to the file
        File.WriteAllText("neuz.ini", newNeuzFile)

    End Sub

    Private Sub Label6_Click(sender As Object, e As EventArgs) Handles Label6.Click
        Me.Close()
    End Sub

    Private Sub Label1_Click(sender As Object, e As EventArgs) Handles Label1.Click
        saveINI()
        CPatcher.LabelStaus.Text = "Options Saved."
        Me.Close()
    End Sub

    Private Sub Options_Load(sender As Object, e As EventArgs) Handles Me.Load
        resolution.SelectedIndex = 1
        fieldDetail.SelectedIndex = 2
        objectDetail.SelectedIndex = 2
        objectRange.SelectedIndex = 2
        shadowDetail.SelectedIndex = 0
    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click
        Me.Close()
    End Sub
End Class