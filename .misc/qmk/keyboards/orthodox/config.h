// Copyright 2023 oldarkdesu (@OldarkDesu)
// SPDX-License-Identifier: GPL-2.0-or-later

#pragma once

/*
 * Feature disable options
 *  These options are also useful to firmware size reduction.
 */

/* disable debug print */
//#define NO_DEBUG

/* disable print */
//#define NO_PRINT

/* disable action features */
//#define NO_ACTION_LAYER
//#define NO_ACTION_TAPPING
//#define NO_ACTION_ONESHOT

// changed by me

#define MASTER_LEFT
#define SOFT_SERIAL_PIN D1

#define MATRIX_COLS 7
#define MATRIX_ROWS 10
#define MATRIX_COL_PINS {D0,D4,C6,D7,E6,B4,B5}
#define MATRIX_ROW_PINS {F7,B1,B3,B2,B6}
#define DIODE_DIRECTION COL2ROW


// in miliseconds. if the key is released before the tapping term it
// is considered a tap, otherwise it is considered a hold.
// https://docs.qmk.fm/#/tap_hold?id=tapping-term
#define TAPPING_TERM 200

// If you press a Mod Tap key, tap another key (press and release) and
// then release the Mod Tap key, all within the tapping term, it will
// output the tapping function for both keys.
// https://docs.qmk.fm/#/tap_hold?id=permissive-hold
#define PERMISSIVE_HOLD

// if a modkey is tapped and then held, normally the tapping function is
// repeated. with this option enabled the hold functionality is activated
// instead
// https://docs.qmk.fm/#/tap_hold?id=tapping-force-hold
// This apparently is deprecated
// #define TAPPING_FORCE_HOLD

// If you press a Mod Tap key, press another key, release the Mod Tap
// key, and then release the normal key, it would normally output the
// Mod plus the normal key. whith this option enabled, holding both keys
// are required for the TAPPING_TERM to register the hold action
// https://docs.qmk.fm/#/tap_hold?id=ignore-mod-tap-interrupt
// BUT APPARENTLY IT'S NOW DEFAULT BEHAVIOUR
// #define IGNORE_MOD_TAP_INTERRUPT

// defines how many taps are needed to toggle a layer when using TT(<layer>)
//#define TAPPING_TOGGLE 3
