﻿'------------------------------------------------------------------------------
' <auto-generated>
'     Dieser Code wurde von einem Tool generiert.
'     Laufzeitversion:4.0.30319.296
'
'     Änderungen an dieser Datei können falsches Verhalten verursachen und gehen verloren, wenn
'     der Code erneut generiert wird.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On

Imports System

Namespace My.Resources
    
    'Diese Klasse wurde von der StronglyTypedResourceBuilder automatisch generiert
    '-Klasse über ein Tool wie ResGen oder Visual Studio automatisch generiert.
    'Um einen Member hinzuzufügen oder zu entfernen, bearbeiten Sie die .ResX-Datei und führen dann ResGen
    'mit der /str-Option erneut aus, oder Sie erstellen Ihr VS-Projekt neu.
    '''<summary>
    '''  Eine stark typisierte Ressourcenklasse zum Suchen von lokalisierten Zeichenfolgen usw.
    '''</summary>
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0"),  _
     Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
     Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute(),  _
     Global.Microsoft.VisualBasic.HideModuleNameAttribute()>  _
    Friend Module Resources
        
        Private resourceMan As Global.System.Resources.ResourceManager
        
        Private resourceCulture As Global.System.Globalization.CultureInfo
        
        '''<summary>
        '''  Gibt die zwischengespeicherte ResourceManager-Instanz zurück, die von dieser Klasse verwendet wird.
        '''</summary>
        <Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Friend ReadOnly Property ResourceManager() As Global.System.Resources.ResourceManager
            Get
                If Object.ReferenceEquals(resourceMan, Nothing) Then
                    Dim temp As Global.System.Resources.ResourceManager = New Global.System.Resources.ResourceManager("Open_Source_Patcher_v3.Resources", GetType(Resources).Assembly)
                    resourceMan = temp
                End If
                Return resourceMan
            End Get
        End Property
        
        '''<summary>
        '''  Überschreibt die CurrentUICulture-Eigenschaft des aktuellen Threads für alle
        '''  Ressourcenzuordnungen, die diese stark typisierte Ressourcenklasse verwenden.
        '''</summary>
        <Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Friend Property Culture() As Global.System.Globalization.CultureInfo
            Get
                Return resourceCulture
            End Get
            Set
                resourceCulture = value
            End Set
        End Property
        
        Friend ReadOnly Property gzip() As Byte()
            Get
                Dim obj As Object = ResourceManager.GetObject("gzip", resourceCulture)
                Return CType(obj,Byte())
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBar() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBar", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarBlue() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarBlue", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarGreen() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarGreen", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarOrange() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarOrange", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarRed() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarRed", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarViolett() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarViolett", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property ProgressBarYellow() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("ProgressBarYellow", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonBlue() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonBlue", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonGreen() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonGreen", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonOrange() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonOrange", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonRed() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonRed", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonViolett() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonViolett", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
        
        Friend ReadOnly Property StartButtonYellow() As System.Drawing.Bitmap
            Get
                Dim obj As Object = ResourceManager.GetObject("StartButtonYellow", resourceCulture)
                Return CType(obj,System.Drawing.Bitmap)
            End Get
        End Property
    End Module
End Namespace
