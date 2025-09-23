/* oldarkdesu's layout for the Dactyl Manuform 5x6 Keyboard */

#include QMK_KEYBOARD_H

// defining layers
#define _ALPHA 0
#define _ALMOD 1
#define _GAMES 2
#define _LOWER 3
#define _RAISE 4
#define _FNCTN 5

//defining layer changes
#define RAISE LT(_RAISE, KC_TAB)
#define LOWER LT(_LOWER, KC_ENT)
#define ALPHA DF(_ALPHA)
#define ALMOD DF(_ALMOD)
#define GAMES DF(_GAMES)

// Left-hand home row mods
#define HOME_A LALT_T(KC_A)
#define HOME_R LGUI_T(KC_R)
#define HOME_S LSFT_T(KC_S)
#define HOME_T LCTL_T(KC_T)
#define HOME_D ALGR_T(KC_D)

// Right-hand home row mods
#define HOME_H ALGR_T(KC_H)
#define HOME_N RCTL_T(KC_N)
#define HOME_E RSFT_T(KC_E)
#define HOME_I RGUI_T(KC_I)
#define HOME_O LALT_T(KC_O)

// movement things
#define WORD_LEFT  LCTL(KC_LEFT)
#define WORD_RIGHT LCTL(KC_RIGHT)

// macros
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
// end-macros

layer_state_t layer_state_set_user(layer_state_t state) {
   return update_tri_layer_state(state, _LOWER, _RAISE, _FNCTN);
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Diagram template
        * ,-----------------------------------.                          ,-----------------------------------.
        * |     |     |     |     |     |     |                          |     |     |     |     |     |     |
        * |-----+-----+-----+-----+-----+-----|                          |-----+-----+-----+-----+-----+-----|
        * |     |     |     |     |     |     |                          |     |     |     |     |     |     |
        * |-----+-----+-----+-----+-----+-----|                          |-----+-----+-----+-----+-----+-----|
        * |     |     |     |     |     |     |                          |     |     |     |     |     |     |
        * |-----+-----+-----+-----+-----+-----|                          |-----+-----+-----+-----+-----+-----|
        * |     |     |     |     |     |     |                          |     |     |     |     |     |     |
        * `-----------+-----+-----+-----------'                          `-----------+-----+-----+-----------'
        *             |     |     |                                                  |     |     |
        *             `-----------;-----------.                          ,-----------;-----------'
        *                         |     |     |                          |     |     |
        *                         |-----+-----|                          |-----+-----|
        *                         |     |     |                          |     |     |
        *                         |-----+-----|                          |-----+-----|
        *                         |     |     |                          |     |     |
        *                         `-----------'                          `-----------'
        *  _______, _______, _______, _______, _______, _______,                                   _______, _______, _______, _______, _______, _______,
        *  _______, _______, _______, _______, _______, _______,                                   _______, _______, _______, _______, _______, _______,
        *  _______, _______, _______, _______, _______, _______,                                   _______, _______, _______, _______, _______, _______,
        *  _______, _______, _______, _______, _______, _______,                                   _______, _______, _______, _______, _______, _______,
        *                    _______, _______,                                                                       _______, _______,
        *                                      _______, _______,                                   _______, _______,
        *                                                      _______, _______,   _______, _______,
        *                                                      _______, _______,   _______, _______
        *
        *
    */
    // colemak
    [_ALPHA] = LAYOUT_5x6(
        KC_GRV , KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,                                  KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , KC_TILD,
        KC_ESC , KC_Q   , KC_W   , KC_F   , KC_P   , KC_B   ,                                  KC_J   , KC_L   , KC_U   , KC_Y   , KC_QUOT, KC_MINS,
        KC_TAB , KC_A   , KC_R   , KC_S   , KC_T   , KC_G   ,                                  KC_M   , KC_N   , KC_E   , KC_I   , KC_O   , KC_ENT ,
        KC_LSFT, KC_Z   , KC_X   , KC_C   , KC_D   , KC_V   ,                                  KC_K   , KC_H   , KC_COMM, KC_DOT , KC_SLSH, KC_RSFT,
                          KC_LGUI, KC_LCTL,                                                                      KC_RCTL, KC_RGUI,
                                             RAISE , KC_BSPC,                                  KC_SPC ,  LOWER ,
                                                            LOWER  , KC_RALT,  KC_RALT,RAISE ,
                                                            KC_LALT, XXXXXXX,  XXXXXXX, KC_LALT
                                                            
    ), 
    // colemak with homerow mods
    [_ALMOD] = LAYOUT_5x6(
        KC_GRV , KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,                                  KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , KC_TILD,
        KC_ESC , KC_Q   , KC_W   , KC_F   , KC_P   , KC_B   ,                                  KC_J   , KC_L   , KC_U   , KC_Y   , KC_QUOT, KC_MINS,
        KC_TAB , HOME_A , HOME_R , HOME_S , HOME_T , KC_G   ,                                  KC_M   , HOME_N , HOME_E , HOME_I , HOME_O , KC_ENT ,
        KC_LSFT, KC_Z   , KC_X   , KC_C   , HOME_D , KC_V   ,                                  KC_K   , HOME_H , KC_COMM, KC_DOT , KC_SLSH, KC_RSFT,
                          KC_LGUI, KC_LCTL,                                                                      KC_RCTL, KC_RGUI,
                                             RAISE , KC_BSPC,                                  KC_SPC ,  LOWER ,
                                                            LOWER  , KC_RALT,  KC_RALT,RAISE ,
                                                            KC_LALT, XXXXXXX,  XXXXXXX, KC_LALT
    ),
    // Gaming layer
    [_GAMES] = LAYOUT_5x6(
        KC_GRV ,KC_1   , KC_2  , KC_3  , KC_4  , KC_5  ,                              XXXXXXX, KC_NUM , KC_PSLS, KC_PAST, KC_PMNS, XXXXXXX,
        KC_ESC ,KC_G   , KC_Q  , KC_W  , KC_E  , KC_R  ,                              XXXXXXX, KC_P7  , KC_P8  , KC_P9  , KC_PPLS, XXXXXXX,
        KC_TAB ,KC_LSFT, KC_A  , KC_S  , KC_D  , KC_F  ,                              XXXXXXX, KC_P4  , KC_P5  , KC_P6  , KC_PENT, XXXXXXX,
        KC_T   ,KC_LCTL, KC_Z  , KC_X  , KC_C  , KC_V  ,                              XXXXXXX, KC_P1  , KC_P2  , KC_P3  , KC_PENT, XXXXXXX,
                         KC_Y  , KC_M  ,                                                                KC_P0  , KC_DOT ,
                                KC_LALT,KC_SPC ,                                               XXXXXXX, XXXXXXX,
                                                KC_H  , KC_B  ,                XXXXXXX, XXXXXXX,
                                                ALPHA , KC_F1 ,                XXXXXXX, XXXXXXX
    ),
    // Symbols layer
    [_RAISE] = LAYOUT_5x6(

        _______, _______, _______, _______, _______, _______,                         _______, _______, _______, _______, _______, _______,
        DBLQUO , KC_EXLM, KC_AT  , KC_HASH, KC_DLR , KC_PERC,                  KC_CIRC, KC_AMPR, KC_ASTR,ALGR(KC_SLSH),ALGR(KC_1), SNGQUO ,
        RNDBRA , KC_TILD, KC_COLN, KC_MINS, KC_LPRN, KC_RPRN,                         KC_RCBR , KC_LCBR, KC_PLUS, KC_SCLN, BCKTCK, CURBRA ,
        ANGBRA , KC_PIPE, KC_GRV , KC_UNDS, KC_LABK, KC_RABK,                         KC_RBRC , KC_LBRC, KC_EQL , KC_QUES,KC_BSLS, SQRBRA ,
                          _______, _______,                                                             _______, _______,
                                            _______, KC_DEL ,                         _______, _______,
                                                     _______, _______,       _______, _______,
                                                     _______, _______,       _______, _______

    ),
    //Num/Nav layer
    [_LOWER] = LAYOUT_5x6(
        _______, _______, _______, _______, _______, _______,                         _______, _______, _______, _______, _______, _______,
        _______, KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,                         KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , _______,
        _______, KC_HOME,KC_PGUP , KC_PGDN, KC_END , _______,                       WORD_LEFT, KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT,WORD_RIGHT,
        _______, _______, _______, _______, _______, _______,                         _______, KC_H   , KC_J   , KC_K   , KC_L   , _______,
                          _______, _______,                                                             _______, _______,
                                            _______, KC_DEL ,                         KC_DEL , _______,
                                            _______, _______,                         _______, _______,
                                            _______, _______,                         _______, _______
    ),
    //Function layer
    [_FNCTN] = LAYOUT_5x6(
        _______, _______, _______, _______, _______, _______,                         _______, _______, _______ , _______ , _______ , _______,
        KC_F12 , KC_F1  , KC_F2  , KC_F3  , KC_F4  , KC_F5  ,                         KC_F6  , KC_F7  , KC_F8   , KC_F9   , KC_F10  , KC_F11 ,
        _______, _______, _______, KC_PSCR, KC_CAPS, SGUI(KC_S),                LGUI(KC_PSCR), KC_MPRV, KC_VOLD , KC_VOLU , KC_MNXT , _______,
        KC_SLEP, _______, _______, GAMES  , ALPHA  , _______,                         _______, ALPHA  , GAMES   , _______ , _______ , KC_SLEP,
                          _______, _______,                                                             _______, _______,
                                            LOWER  , _______,                         _______, RAISE  ,
                                            _______, _______,                         _______, _______,
                                            _______, _______,                         _______, _______
    ),
};
