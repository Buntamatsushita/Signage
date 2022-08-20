void Clock(int area) {
    //変数関係
    int clock_x, clock_y, clock_width, clock_height;
    String Hour = "00";
    String Minute = "00";
    String Secound = "00";
    String clock = "";
    
    //場所
    clock_x = Area[area][0];
    clock_y = Area[area][1];
    clock_width = Area[area][2];
    clock_height = Area[area][3];
    
    //時計作り
    if (hour() < 10) {
        Hour = "0" + str(hour());
    } else {
        Hour = str(hour());
    }
    if (minute() < 10) {
        Minute = "0" + str(minute());
    } else {
        Minute = str(minute());
    }
    if (second() < 10) {
        Secound = "0" + str(second());
    } else {
        Secound = str(second());
    }
    clock = Hour + ":" + Minute + ":" + Secound;
    
    //描画
    fill(255);
    rect(clock_x, clock_y, clock_width, clock_height);
    fill(0);
    textSize(clock_height * 0.35);
    text(clock, clock_x + ((clock_width - textWidth(clock)) / 2), clock_y + clock_height - (clock_height * 0.35));
    
    
    
    
}