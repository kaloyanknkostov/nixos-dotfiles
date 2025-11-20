/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=16" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#141415"; /* base00: Normal Background */
static const char col_gray2[]       = "#252530"; /* base02: Inactive Window Border */
static const char col_gray3[]       = "#cdcdcd"; /* base05: Normal Text */
static const char col_gray4[]       = "#141415"; /* base00: Selected Text (Dark text for contrast) */
static const char col_cyan[]        = "#6e94b2"; /* base0D: Selected Background/Border (Blue) */

static const char *colors[][3]      = {
    /* fg         bg         border   */
    [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
    [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};
/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     * WM_CLASS(STRING) = instance, class
     * WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    { "zen",  NULL,       NULL,       1 << 0,       0,           -1 },
    { "ghostty",  NULL,       NULL,       1 << 1,       0,           -1 },
    { "yazi-file-picker",  NULL,       NULL,       0,       1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },    /* first entry is default */
    { "><>",      NULL },    /* no layout function means floating behavior */
    { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask /* <<< CHANGED from Mod1Mask to Mod4Mask (Super key) */
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "ghostty", NULL };

void
tagandview(const Arg *arg)
{
    tag(arg);
    view(arg);
}

static const Key keys[] = {
    /* System keys ____________________________________________________________________________________________________________*/
    { MODKEY,                       XK_space,		    spawn,			        {.v = dmenucmd } },
    { MODKEY,                       XK_Return,		    spawn,		                {.v = termcmd } },
    { MODKEY,                       XK_b,		    togglebar,			        {0} },
    { MODKEY,                       XK_q,		    killclient,				{0} },
    { MODKEY|ShiftMask,             XK_q,		    quit,				{0} },
    /* Tags____________________________________________________________________________________________________________________*/
    { MODKEY,                       XK_1,		    view,				{.ui = 1 << 0} },
    { MODKEY,                       XK_2,		    view,				{.ui = 1 << 1} },
    { MODKEY,                       XK_3,		    view,				{.ui = 1 << 2} },
    { MODKEY,                       XK_4,		    view,				{.ui = 1 << 3} },
    { MODKEY,                       XK_5,		    view,				{.ui = 1 << 4} },
    { MODKEY,                       XK_6,		    view,				{.ui = 1 << 5} },
    { MODKEY,                       XK_7,		    view,				{.ui = 1 << 6} },
    { MODKEY,                       XK_8,		    view,				{.ui = 1 << 7} },
    { MODKEY,                       XK_9,		    view,				{.ui = 1 << 8} },
    { MODKEY|ShiftMask,             XK_1,		    tagandview,				{.ui = 1 << 0} },
    { MODKEY,                       XK_bracketleft,	    tagandview,				{.ui = 1 << 1} },
    { MODKEY|ShiftMask,             XK_bracketleft,	    tagandview,				{.ui = 1 << 2} },
    { MODKEY|ShiftMask,             XK_9,		    tagandview,				{.ui = 1 << 3} },
    { MODKEY|ShiftMask,             XK_7,		    tagandview,				{.ui = 1 << 4} },
    { MODKEY|ShiftMask,             XK_grave,		    tagandview,				{.ui = 1 << 5} },
    { MODKEY|ShiftMask,             XK_0,		    tagandview,				{.ui = 1 << 6} },
    { MODKEY|ShiftMask,             XK_bracketright,	    tagandview,				{.ui = 1 << 7} },
    { MODKEY,                       XK_bracketright,	    tagandview,				{.ui = 1 << 8} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
