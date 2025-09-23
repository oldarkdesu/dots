#include QMK_KEYBOARD_H

/* Aquí se declaran los keycodes personalizados */
enum custom_keycodes {
    JSLOG = SAFE_RANGE,
};

char last_kc[10] = ""; // último keycode presionado

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    /* Aquí se especifica qué pasa cuando ejecutan los keycodes personalizados */
    switch (keycode) {
        case JSLOG:
            if (record->event.pressed) {
                // when keycode JSLOG is pressed
                SEND_STRING("Console.log();"SS_TAP(X_LEFT)SS_TAP(X_LEFT));
            } else {
                // when keycode JSLOG is released
            }
            break;
        default:
            break;
    }

    /* Aquí se extrae el número correspondiente al keycode (HEX)*/
    sprintf(last_kc, "0x%x", keycode);

    return true;
};

/* Aquí se definen los keymaps (o las "capas") */
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
        QK_BOOT, XXXXXXX, JSLOG  , _______ // Aquí "_______" quiere decir la
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


/* configuración del display. Copiado de la documentación oficial */
#ifdef OLED_ENABLE
bool oled_task_user(void) {
    // Host Keyboard Layer Status
    oled_write_P(PSTR("Layer: "), false);

    switch (get_highest_layer(layer_state)) {
        case 0:
            oled_write_P(PSTR("NumPad\n"), false);
            break;
        case 1:
            oled_write_P(PSTR("Funciones\n"), false);
            break;
        default:
            // Or use the write_ln shortcut over adding '\n' to the end of your
            // string
            oled_write_ln_P(PSTR("Undefined"), false);
    }

    // Host Keyboard LED Status
    led_t led_state = host_keyboard_led_state();
    oled_write_P(led_state.num_lock ? PSTR("NUM ") : PSTR("    "), false);
    oled_write_P(led_state.caps_lock ? PSTR("CAP ") : PSTR("    "), false);
    oled_write_P(led_state.scroll_lock ? PSTR("SCR ") : PSTR("    "), false);

    /* aquí se añade el número hexadecimal que corresponde al último código
       presionado */
    oled_write_P(PSTR("\nKeyCode: "), false);
    oled_write(last_kc, false);

    return false;
}
#endif


