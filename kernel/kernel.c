void kernel_main(void) {
    volatile unsigned short *vga = (volatile unsigned short *)0xB8000;
    const char *msg = "Hello from Matthew's OS!";
    unsigned char color = 0x0F;

    for (int i = 0; msg[i] != '\0'; i++) {
        vga[i] = (unsigned short)msg[i] | ((unsigned short)color << 8);
    }

    while (1) {}
}
