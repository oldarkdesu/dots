// Copyright 2023 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H

#define _COLEM 0
#define _GAMES 1
#define _LOWER 2
#define _RAISE 3
#define _FNCTN 4

//defining layer changes
#define GAMES DF(_GAMES)
#define COLEM DF(_COLEM)
#define RAISE LT(_RAISE, KC_TAB)
#define LOWER LT(_LOWER, KC_ENT)

// movement things
#define WORD_LEFT  LCTL(KC_LEFT)
#define WORD_RIGHT LCTL(KC_RIGHT)

#define MOD_LEFT  MT(MOD_RCTL, KC_LEFT)
#define MOD_DOWN  MT(MOD_RGUI, KC_DOWN)
#define MOD_UP    MT(MOD_LALT, KC_UP)
#define MOD_RIGHT MT(MOD_RSFT, KC_RIGHT)

//#region macros
enum custom_keycodes {
    QMKBEST = SAFE_RANGE,
    CURBRA, // {|}
    SQRBRA, // [|]
    ANGBRA, // <|>
    RNDBRA, // (|)
    SNGQUO, // '|'
    DBLQUO, // "|"
    BCKTCK, // `|`
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case QMKBEST:  // from documentation:
            if (record->event.pressed) {
                // when keycode QMKBEST is pressed
                SEND_STRING("QMK is the best thing ever!");
            } else {
                // when keycode QMKBEST is released
            }
            break;
        case CURBRA:
            if (record->event.pressed)
                SEND_STRING("{}"SS_TAP(X_LEFT));
            break;
        case SQRBRA:
            if (record->event.pressed)
                SEND_STRING("[]"SS_TAP(X_LEFT));
            break;
        case ANGBRA:
            if (record->event.pressed)
                SEND_STRING("<>"SS_TAP(X_LEFT));
            break;
        case RNDBRA:
            if (record->event.pressed)
                SEND_STRING("()"SS_TAP(X_LEFT));
            break;
        case DBLQUO:
            if (record->event.pressed)
                SEND_STRING("\"\""SS_TAP(X_LEFT));
            break;
        case SNGQUO:
            if (record->event.pressed)
                SEND_STRING("\'\'"SS_TAP(X_LEFT));
            break;
        case BCKTCK:
            if (record->event.pressed)
                SEND_STRING("``"SS_TAP(X_LEFT));
            break;
    }

    return true;
};
//#endregion

layer_state_t layer_state_set_user(layer_state_t state) {
   return update_tri_layer_state(state, _LOWER, _RAISE, _FNCTN);
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Qwerty
     * ,-----------------------------------------.                 ,-----------------------------------------.
     * |   `  |   1  |   2  |   3  |   4  |   5  |                 |   6  |   7  |   8  |   9  |   0  | Del  |
     * |------+------+------+------+------+------|                 |------+------+------+------+------+------|
     * | Esc  |   Q  |   W  |   E  |   R  |   T  |                 |   Y  |   U  |   I  |   O  |   P  | Bksp |
     * |------+------+------+------+------+------|                 |------+------+------+------+------+------|
     * | Tab  |   A  |   S  |   D  |   F  |   G  |                 |   H  |   J  |   K  |   L  |   ;  |  '   |
     * |------+------+------+------+------+------|                 |------+------+------+------+------+------|
     * | Shift|   Z  |   X  |   C  |   V  |   B  |                 |   N  |   M  |   ,  |   .  |   /  |Enter |
     * |------+------+------+------+------+------+------.   ,------+------+------+------+------+------+------|
     * | Ctrl | None | Super| Alt  |Raise |Space |None  |   | None |Space | Lower| Left | Down |  Up  |Right |
     * `------------------------------------------------'   `------------------------------------------------'
     */
    [_GAMES] = LAYOUT(
        KC_ESC,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                      KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_DEL,
        KC_GRV,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                      KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC,
        KC_TAB,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                      KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
        KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                      KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
        KC_LCTL, KC_NO,   KC_NO, KC_LALT,  RAISE,   KC_BSPC, LOWER,      RAISE, KC_SPC,    LOWER,   MOD_LEFT,MOD_DOWN,MOD_UP,  MOD_RIGHT
    ),
    [_COLEM] = LAYOUT(
        KC_GRV , KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,                   KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_DEL,
        KC_ESC , KC_Q   , KC_W   , KC_F   , KC_P   , KC_B   ,                   KC_J,    KC_L,    KC_U,    KC_Y, KC_QUOT,    KC_MINS,
        KC_TAB , KC_A   , KC_R   , KC_S   , KC_T   , KC_G   ,                   KC_M,    KC_N,    KC_E,    KC_I,    KC_O,    KC_ENT ,
        KC_LSFT, KC_Z   , KC_X   , KC_C   , KC_D   , KC_V   ,                   KC_K,    KC_H, KC_COMM,  KC_DOT, KC_SLSH,    KC_RSFT,
        KC_LSFT, KC_LALT,KC_LGUI , KC_LCTL, RAISE  , KC_BSPC, LOWER,     RAISE, KC_SPC,    LOWER, MOD_LEFT,MOD_DOWN,MOD_UP,  MOD_RIGHT 
    ),
    [_LOWER] = LAYOUT(
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        _______, KC_HOME,KC_PGUP , KC_PGDN, KC_END , _______,                 WORD_LEFT, KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT,WORD_RIGHT,
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, KC_DEL , _______, _______, _______, _______, _______, _______, _______, _______
    ),
    [_RAISE] = LAYOUT(
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        DBLQUO , KC_EXLM, KC_AT  , KC_HASH, KC_DLR , KC_PERC,            KC_CIRC, KC_AMPR, KC_ASTR,ALGR(KC_SLSH),ALGR(KC_1), SNGQUO ,
        RNDBRA , KC_TILD, KC_COLN, KC_MINS, KC_LPRN, KC_RPRN,                   KC_RCBR , KC_LCBR, KC_PLUS, KC_SCLN, BCKTCK, CURBRA ,
        ANGBRA , KC_PIPE, KC_GRV , KC_UNDS, KC_LABK, KC_RABK,                   KC_RBRC , KC_LBRC, KC_EQL , KC_QUES,KC_BSLS, SQRBRA ,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
    ),
    [_FNCTN] = LAYOUT(
        KC_F12 , KC_F1  , KC_F2  , KC_F3  , KC_F4  , KC_F5  ,                   KC_F6  , KC_F7  , KC_F8  , KC_F9  , KC_F10 , KC_F11 ,
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        _______, _______, _______, KC_PSCR, KC_CAPS, SGUI(KC_S),       LGUI(KC_PSCR), KC_MPRV, KC_VOLD , KC_VOLU , KC_MNXT , _______,
        _______, _______, _______, _______, _______, _______,                   _______, _______, _______, _______, _______, _______,
        KC_SLEP, _______,   COLEM,   GAMES,   LOWER, _______, RAISE,     LOWER, _______,   RAISE,   GAMES,   COLEM, _______, KC_SLEP
    )
};

