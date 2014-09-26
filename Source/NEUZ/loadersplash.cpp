//////////////////////////////////////////////////////////////////////

//                                                                    //

// loadersplash.cpp , Affichage du splatch pour flyff                //

//                                                                    //

//////////////////////////////////////////////////////////////////////

#include "stdafx.h"    // Prérequis

#include "windows.h"    // Vu que on Cheat par windows

#include "loadersplash.h"    // on appel notre .h

//////////////////////////////////////////////////////////////////////

// Construction/Destruction

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

hSplashWnd=CreateWindowEx(WS_EX_CLIENTEDGE,"STATIC","Chargement en Cours",

    WS_POPUP|WS_DLGFRAME|SS_BITMAP,301,301,550,300,NULL,NULL,hInstance,NULL); // 550 = länge , 300 = breite , in german for german :p

SendMessage(hSplashWnd,STM_SETIMAGE,IMAGE_BITMAP,(LPARAM)LoadBitmap(hInstance,MAKEINTRESOURCE(resid)));

// on utilisera une fenetre avec du BMP en fond vu que je suis un gros faignant pour vous expliquer comment mettre une lib

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

  // on prend la taille de l'ecran - la fenaitre pour centrer

  tx = ((Ecran.x/2)-(x/2)); // Taille de ecran divisée par 2 moins taille de image divisée par 2 =  center

  ty = ((Ecran.y/2)-(y/2));

  windefer=BeginDeferWindowPos(1);

  DeferWindowPos(windefer,hSplashWnd,HWND_NOTOPMOST,tx,ty,50,50,SWP_NOSIZE|SWP_SHOWWINDOW|SWP_NOZORDER);

  EndDeferWindowPos(windefer);

  ShowWindow(hSplashWnd,SW_SHOWNORMAL);

  UpdateWindow(hSplashWnd);

  this->SHOW = TRUE;

}

void SPLASHLOAD::exit()

{

  ShowWindow(hSplashWnd,SW_HIDE);

// si ta eu le courage de lire , c'est moi qui est pré-ecrit le discours de karles pour le cadeau :3 Oui moi :p

// Pourquoi sa te choque que moi , davedevils puis écrire des chose censée ?

  this->SHOW = FALSE;

}

#endif