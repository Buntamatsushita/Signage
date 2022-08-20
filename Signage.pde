//天気関係の変数設定
String fore_baseURL = "https://weather.tsukumijima.net/api/forecast?city=";
String city = "017010";
JSONObject forecastMain;
JSONArray forecasts;
JSONObject forecastIcon;

PImage fore_today_icon;
boolean forecast_load = true;
boolean fore_today_text_b = true;

//ニュース関係の変数設定
String news_baseURl = "https://newsapi.org/v2/top-headlines?country=jp&apiKey=";
String API_key;
JSONObject newsMain;
JSONArray news_list;
int news_start_m = millis();
int news_screen_num = 0;
int news_num = 0;
PImage newsImg;
int start_m = millis();

//バス関係の変数設定
JSONObject BUS;
int bus_num = 0;
boolean bus_update = true;
JSONArray current_bus;
int bus_hour, bus_time;
int before_bus_time, bus_time_differ;
String bus_time_text;
String bus_time_remain;
String bus_dest, bus_cource;
boolean bus_b = true;
PImage back, bus_icon, bus_stand;


int[][] Area = new int[4][4];






void setup() {
    //size(displayWidth, displayHeight);
    fullScreen();

    //天気APIの関係
    forecastMain = loadJSONObject(fore_baseURL + city);
    saveJSONObject(forecastMain, "forecastMain.json");
    forecastMain = loadJSONObject("forecastMain.json");
    forecastIcon = loadJSONObject("forecastIcon.json");
    forecasts = forecastMain.getJSONArray("forecasts");
    
    API_key = loadStrings("APIkey.txt")[0];
    newsMain = loadJSONObject(news_baseURl + API_key);
    saveJSONObject(newsMain, "newsMain.json");
    newsMain = loadJSONObject("newsMain.json");
    news_list = newsMain.getJSONArray("articles");
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
    
    
    BUS = loadJSONObject("bus/schedule.json");
    back = loadImage("bus/back.png");
    bus_icon = loadImage("bus/bus.png");
    bus_stand = loadImage("bus/bus_stand.png");
    bus_hour = hour();
    
    
    PFont font = createFont("Meiryo", 10);
    textFont(font);
    
    surface.setResizable(true);
}


void draw() {
    setArea();
    background(255);
    
    forecast(3);
    Clock(1);
    Bus(2);
    news(0);
}
