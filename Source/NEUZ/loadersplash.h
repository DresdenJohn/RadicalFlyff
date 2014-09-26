//////////////////////////////////////////////////////////////////////

//                                                                    //

// loadersplash.h , Affichage du splatch pour flyff                    //

//                                                                    //

//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FLYFF_SPLASH)

#define AFX_FLYFF_SPLASH

#if _MSC_VER > 1000

#pragma once

#endif // _MSC_VER > 1000

// bon sa devrais tourner , cherche pas je rox le boeuf bourée xD

#ifdef __LOADER_SPLASH

class SPLASHLOAD

{

public:

    void exit();

    void Active();

    void Load(HINSTANCE hInstance,int resid);

    BOOL SHOW;

    SPLASHLOAD();

    virtual ~SPLASHLOAD();

private:

    UINT TimerID;

    HWND hParentWindow;

    HWND hSplashWnd;

};

#endif

#endif // !defined(AFX_FLYFF_SPLASH)