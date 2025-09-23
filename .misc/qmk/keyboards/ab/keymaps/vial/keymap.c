#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    /* Keymap 0 (el por defecto) */
    [0] = LAYOUT_ortho_4x4(
        KC_P7,   KC_P8,   KC_P9,   KC_MUTE,
        KC_P4,   KC_P5,   KC_P6,   KC_CAPS,
        KC_P1,   KC_P2,   KC_P3,   KC_NUM ,
        KC_P0,   KC_PDOT, KC_PENT, TG(1)   // aquí TG significa 'toggle'. Cuando
    ),                                     // se presiona esta tecla se activa y
                                           // desactiva el keymap en el índice 1.
    /* Keymap 1 */
    [1] = LAYOUT_ortho_4x4(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        KC_D   ,   KC_E ,   KC_F , _______,
        KC_A   ,   KC_B ,   KC_C , _______,
        QK_BOOT, _______, _______, _______ // Aquí "_______" quiere decir la
    )                                      // tecla de la capa anterior eneste
};                                         // caso sería el código TG(1), como ya
                                           // estamos en el keymap 1 este se
                                           // desactiva, por lo que volvemos al 0

/* Aquí se definen los códigos que envia el encoder */
#if defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
                     /*  dirección del encoder:                            */
                     /*  a favor / en contra   de las manecillas del reloj */
    [0] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)}, // control de volumen
    [1] = {ENCODER_CCW_CW(KC_PGUP, KC_PGDN)}, // teclas de izquierda y derecha
};
#endif
