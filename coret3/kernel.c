void kmain(void) {
    char *str = "Kernel loaded!";
    char *video_memory = (char *)0xB8000;

    for (int i = 0; str[i] != '\0'; ++i) {
        video_memory[2*i] = str[i];
        video_memory[2*i+1] = 0x07;
    }

    while(1);
}
