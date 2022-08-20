void news(int area) {
    int news_x, news_y, news_width, news_height;
    String news_title;
    float news_title_size, news_title_width;
    float mag;
    
    //場所
    news_x = Area[area][0];
    news_y = Area[area][1];
    news_width = Area[area][2];
    news_height = Area[area][3];
    
    mag = ((news_height / 9) * 4) / float(newsImg.height);
    if (news_screen_num == 0) {
        imageMode(CENTER);
        image(newsImg, news_x + (news_width / 2), news_y + (news_height / 4),newsImg.width * mag, newsImg.height * mag);
        
        fill(240);
        noStroke();
        rect(news_x, news_y + ((news_height / 9) * 5), news_width ,(news_height / 9) * 4);
        news_title_size = news_height * 0.05;
        textSize(news_title_size);
        String[] news_title_sp = split(news_list.getJSONObject(news_num).getString("title")," - ");
        news_title = news_title_sp[0];
        news_title_width = textWidth(news_title);
        fill(0);
        if (match(news_title, "【速報】") != null) {fill(255,0,0);}
        text(news_title, news_x + (news_width / 20), news_y + news_title_size + ((news_height / 9) * 5),(news_width / 4) * 3,news_height / 3);
        
        String Author = news_title_sp[1] + "  ";
        textSize(news_height * 0.03);
        fill(0);
        text(Author, news_x + news_width - int(textWidth(Author)), news_y + news_height - (news_height * 0.03));
        if ((millis() - news_start_m) > 16000) {
            news_screen_num = 1;
            news_start_m = millis();
        }
    } else if (news_screen_num == 1) {
        imageMode(CENTER);
        image(newsImg, news_x + (news_width / 2), news_y + (news_height / 4),newsImg.width * mag, newsImg.height * mag);
        
        fill(240);
        noStroke();
        rect(news_x, news_y + ((news_height / 9) * 5), news_width ,(news_height / 9) * 4);
        news_title_size = news_height * 0.05;
        textSize(news_title_size);
        String[] news_title_sp = split(news_list.getJSONObject(news_num).getString("title")," - ");
        news_title = news_title_sp[0];
        news_title_width = textWidth(news_title);
        fill(0);
        if (match(news_title, "【速報】") != null) {fill(255,0,0);}
        text(news_title, news_x + (news_width / 20), news_y + news_title_size + ((news_height / 9) * 5),(news_width / 4) * 3,news_height / 3);
        
        String Author = news_title_sp[1] + "  ";
        textSize(news_height * 0.03);
        fill(0);
        text(Author, news_x + news_width - int(textWidth(Author)), news_y + news_height - (news_height * 0.03));
        
        fill(0,255 * ((millis() - news_start_m) / 2000.0));
        rect(news_x, news_y, news_width, news_height);
        if ((millis() - news_start_m) > 2000) {
            if (news_num < news_list.size() - 1) {
                news_num ++;
            } else{
                news_num = 0;
            }
            news_screen_num = 2;
            String newsImg_url = "NoImage.png";
            if (news_list.getJSONObject(news_num).isNull("urlToImage")) {
                
            } else{
                newsImg_url = news_list.getJSONObject(news_num).getString("urlToImage");
            }
            if (loadImage(newsImg_url) == null) {
                newsImg_url = "NoImage.png";
                newsImg = loadImage(newsImg_url);
            } else{
                newsImg = loadImage(newsImg_url);
            }
            news_start_m = millis();
        }
    } else if (news_screen_num == 2) {
        imageMode(CENTER);
        image(newsImg, news_x + (news_width / 2), news_y + (news_height / 4),newsImg.width * mag, newsImg.height * mag);
        
        fill(240);
        noStroke();
        rect(news_x, news_y + ((news_height / 9) * 5), news_width ,(news_height / 9) * 4);
        news_title_size = news_height * 0.05;
        textSize(news_title_size);
        String[] news_title_sp = split(news_list.getJSONObject(news_num).getString("title")," - ");
        news_title = news_title_sp[0];
        news_title_width = textWidth(news_title);
        fill(0);
        if (match(news_title, "【速報】") != null) {fill(255,0,0);}
        text(news_title, news_x + (news_width / 20), news_y + news_title_size + ((news_height / 9) * 5),(news_width / 4) * 3,news_height / 3);
        
        String Author = news_title_sp[1] + "  ";
        textSize(news_height * 0.03);
        fill(0);
        text(Author, news_x + news_width - int(textWidth(Author)), news_y + news_height - (news_height * 0.03));
        
        fill(0,255 * (1 - ((millis() - news_start_m) / 2000.0)));
        rect(news_x, news_y, news_width, news_height);
        if ((millis() - news_start_m) > 2000) {
            news_screen_num = 0;
            news_start_m = millis();
        }
    }
    
    if ((millis() - start_m) > 600000) {
        newsMain = loadJSONObject(news_baseURl + API_key);
        saveJSONObject(newsMain, "newsMain.json");
        println("news reload");
        start_m = millis();
    }
}

