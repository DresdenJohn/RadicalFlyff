//////////////////////////////////////////////////////////////////////
//                                                                   //
// Loadersplash.cpp, List splatch for flyff				             //
//                                                                   //
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"    // Prerequisites

#include "windows.h"    // Since we Cheat by windows

#include "loadersplash.h"    // we call our .h

//////////////////////////////////////////////////////////////////////
// Construction / Destruction
//////////////////////////////////////////////////////////////////////

#ifdef __LOADER_SPLASH

SPLASHLOAD::SPLASHLOAD()

{

}

SPLASHLOAD::~SPLASHLOAD()

{

DestroyWindow(hSplashWnd);

}

void SPLASHLOAD::Load(HINSTANCE hInstance,int resid)

{

hSplashWnd=CreateWindowEx(WS_EX_CLIENTEDGE,"STATIC","Loading",

    WS_POPUP|WS_DLGFRAME|SS_BITMAP,301,301,550,300,NULL,NULL,hInstance,NULL); // = 550 Large?, 300 = Small?, in german for german: p

SendMessage(hSplashWnd,STM_SETIMAGE,IMAGE_BITMAP,(LPARAM)LoadBitmap(hInstance,MAKEINTRESOURCE(resid)));

// A window should be used with BMP in the background as I am a big lazy to explain how to put a lib

this->SHOW = FALSE;

}

void SPLASHLOAD::Active()

{

  int x,y;

  int tx,ty;

  HDWP windefer;

  RECT rect;

  GetClientRect(hSplashWnd,&rect);

  x=rect.right;y=rect.bottom;

  POINT Ecran = {GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN)} ;

  // Take the size of the screen - the fenaitre to center

  tx = ((Ecran.x/2)-(x/2)); // Screen size divided by 2 minus size image divided by 2 = center

  ty = ((Ecran.y/2)-(y/2));

  windefer=BeginDeferWindowPos(1);

  DeferWindowPos(windefer,hSplashWnd,HWND_NOTOPMOST,tx,ty,50,50,SWP_NOSIZE|SWP_SHOWWINDOW|SWP_NOZORDER);

  EndDeferWindowPos(windefer);


  AnimateWindow(hSplashWnd, 200, AW_BLEND);
  // ShowWindow(hSplashWnd,SW_SHOWNORMAL);
  
  UpdateWindow(hSplashWnd);

  this->SHOW = TRUE;

}

void SPLASHLOAD::exit()

{

  ShowWindow(hSplashWnd, SW_HIDE);

// If t had the courage to read, it's me that is pre-written speech Karles for gift: 3 Yes me: p

// Why its shocks you than me, then write davedevils meant something?

  this->SHOW = FALSE;

}

#endif