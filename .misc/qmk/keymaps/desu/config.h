/*
Copyright 2012 Jun Wako <wakojun@gmail.com>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


#pragma once


#define USE_SERIAL

#define MASTER_LEFT
// #define MASTER_RIGHT

// Rows are doubled-up
//#define EE_HANDS

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
#define TAPPING_FORCE_HOLD

// If you press a Mod Tap key, press another key, release the Mod Tap
// key, and then release the normal key, it would normally output the
// Mod plus the normal key. whith this option enabled, holding both keys
// are required for the TAPPING_TERM to register the hold action
// https://docs.qmk.fm/#/tap_hold?id=ignore-mod-tap-interrupt
// BUT APPARENTLY IT'S NOW DEFAULT BEHAVIOUR
// #define IGNORE_MOD_TAP_INTERRUPT

// defines how many taps are needed to toggle a layer when using TT(<layer>)
//#define TAPPING_TOGGLE 3
