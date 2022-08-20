void forecast(int area) {
    int forecast_x, forecast_y, forecast_width, forecast_height;
    String get_time = forecastMain.getString("publicTimeFormatted");
    
    float fore_text_width = 0;
    float fore_text_size = 0;
    float icon_size = 0;
    
    //場所
    forecast_x = Area[area][0];
    forecast_y = Area[area][1];
    forecast_width = Area[area][2];
    forecast_height = Area[area][3];
    
    fill(121, 255, 158);
    rect(forecast_x, forecast_y, forecast_width, forecast_height);
    
    
    fill(0);
    fore_text_size = forecast_height * 0.1;
    textSize(fore_text_size);
    fore_text_width = textWidth("今日の天気");
    text("今日の天気", forecast_x + ((forecast_width - fore_text_width) / 2), forecast_y + fore_text_size);
    
    textSize(forecast_height * 0.02);
    text("(" + get_time + ")", forecast_x + ((forecast_width - fore_text_width) / 2) + fore_text_width, forecast_y + fore_text_size);
    
    
    String forecast_today = forecasts.getJSONObject(0).getString("telop");
    JSONObject forecast_today_text_array = forecastMain.getJSONObject("description");
    String forecast_today_text = forecast_today_text_array.getString("bodyText");
    if (fore_today_text_b) {
        String[] tmp = split(forecast_today_text, "\n\n　");
        String[] result_list = new String[1];
        String result = "";
        for (int i = 0; i < tmp.length; i ++) {
            if (tmp[i].length() > 50) {
                String[]tmp2 = split(tmp[i], "。");
                for (int j = 0; j < tmp2.length - 1; j++) {
                    result = result + tmp2[j] + "。\n";
                }
            } else{
                result = result + tmp[i] + "\n";
            }
        }
        result_list[0] = result;
        saveStrings("fore_today_text.txt", result_list);
        fore_today_text_b = false;
        forecast_today_text = result;
    } else {
        String[] tmp = loadStrings("fore_today_text.txt");
        String result = "";
        for (int i = 0; i < tmp.length; i ++) {
            if (i == 0) {
                result = result + tmp[i] + "\n";
            } else{
                result = result + "　" + tmp[i] + "\n";
            }
        }
        forecast_today_text = result;
    }
    String foreImgPath = "/forecastIcons/" + forecastIcon.getString(forecast_today) + ".png";
    
    fore_today_icon = loadImage(foreImgPath);
    icon_size = forecast_height * 0.4;
    imageMode(CORNER);
    image(fore_today_icon, forecast_x + (forecast_width / 2) - (icon_size / 2), forecast_y + (fore_text_size), icon_size, icon_size);
    textSize(forecast_height * 0.08);
    text(forecast_today, forecast_x + ((forecast_width - textWidth(forecast_today)) / 2), forecast_y + fore_text_size + icon_size);
    textSize(forecast_height * 0.025);
    text(forecast_today_text, forecast_x + (forecast_width * 0.01), forecast_y + fore_text_size + forecast_height * 0.1 + icon_size, forecast_width - (forecast_width * 0.01), forecast_height / 2);
    
    if (minute() == 0 && second() == 0 && forecast_load) {
        forecastMain = loadJSONObject(fore_baseURL + city);
        saveJSONObject(forecastMain, "forecastMain.json");
        forecastMain = loadJSONObject("forecastMain.json");
        forecastIcon = loadJSONObject("forecastIcon.json");
        forecasts = forecastMain.getJSONArray("forecasts");
        forecast_load = false;
        println("forecasts reload");
    }else if(minute() == 0 && second() == 1){
        forecast_load = true;
    }
}