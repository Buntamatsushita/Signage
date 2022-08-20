void Bus(int area) {
    int bus_x, bus_y, bus_width, bus_height;
    
    
    
    //場所
    bus_x = Area[area][0];
    bus_y = Area[area][1];
    bus_width = Area[area][2];
    bus_height = Area[area][3];
    
    
    if (bus_update && bus_hour < 22) {
        bus_update = false;
        bus_hour = hour();
        
        current_bus = BUS.getJSONArray(str(bus_hour));
        
        bus_time = current_bus.getJSONObject(bus_num).getInt("min");
        while(bus_time < minute()) {
            bus_num ++;
            if (bus_num >= current_bus.size()) {
                bus_num = 0;
                bus_hour ++;
                if (bus_hour > 21) {
                    bus_b = false;
                    bus_time_text = "本日のバスは終了しました";
                    bus_dest = "";
                    bus_cource = "おやすみなさい";
                    break;
                }
                current_bus = BUS.getJSONArray(str(bus_hour));
                before_bus_time = bus_time;
                bus_time = current_bus.getJSONObject(bus_num).getInt("min");
                
                break;
            }
            before_bus_time = bus_time;
            bus_time = current_bus.getJSONObject(bus_num).getInt("min");
            
        }

        if (hour() == bus_hour) {
            bus_time_differ = bus_time - before_bus_time;
        } else { 
            bus_time_differ = bus_time + (59 - before_bus_time);
        }
        
        if (bus_hour < 22) {
            if (bus_hour < 10) {
                bus_time_text = "0" + str(bus_hour) + "時";
            } else{
                bus_time_text = str(bus_hour) + "時";
            }
            if (bus_time < 10) {
                bus_time_text = bus_time_text + "0" + str(bus_time) + "分";
            } else{
                bus_time_text = bus_time_text + str(bus_time) + "分";
            }
            bus_dest = current_bus.getJSONObject(bus_num).getString("dest");
            bus_cource = current_bus.getJSONObject(bus_num).getString("number");
        }
    } else if (bus_hour >= 22) {
        bus_b = false;
        bus_time_text = "本日のバスは終了しました";
        bus_dest = "おやすみなさい";
        bus_cource = "";
    } else if (hour() == 6) {
        bus_b = true;
        bus_hour = hour();
    }
    if (bus_time < minute() && hour() == bus_hour) {
        bus_update = true;
    }
    
    
    
    if (bus_hour < 22) {
        float bus_text_size = bus_height * 0.1;
        textSize(bus_text_size);
        float bus_text_width = textWidth("次のバスは");
        text("  次のバスは", bus_x , bus_y + bus_text_size);
        float bus_time_size = bus_height * 0.2;
        textSize(bus_time_size);
        float bus_time_width = textWidth(bus_time_text);
        text(bus_time_text, bus_x + ((bus_width - bus_time_width) / 2), bus_y + bus_text_size + bus_time_size + (bus_height * 0.03));
        
        
        float bus_location_size = bus_height * 0.15;
        textSize(bus_location_size);
        float bus_location_width = textWidth(bus_dest);
        text(bus_dest, bus_x + ((bus_width - bus_location_width) / 2), bus_y + bus_text_size + bus_time_size + bus_location_size + (bus_height * 0.06));
        textSize(bus_location_size * 0.5);
        text("(" + bus_cource + ")", bus_x, bus_y + bus_text_size + bus_time_size + bus_location_size + (bus_height * 0.06));
        
        float bus_location2_size = bus_height * 0.05;
        textSize(bus_location2_size);
        text("行き", bus_x + bus_width - textWidth("行き　　"), bus_y + bus_text_size + bus_time_size + bus_location_size - bus_location2_size + (bus_height * 0.06));
        
        
        
        
        //バスの絵の表示
        float bus_icon_ratio = ((bus_height / 10) * 2) / float(bus_icon.height);
        float bus_stand_ratio = ((bus_height / 10) * 2) / float(bus_stand.height);
        
        image(back,bus_x, bus_y + ((bus_height / 10) * 6),bus_width ,(bus_height / 10) * 4);
        
        imageMode(CORNER);
        
        //バスの絵の位置を決める
        float bus_icon_x;
        if (hour() == bus_hour) {
            bus_icon_x = bus_x + ((bus_width - (bus_icon.width * bus_icon_ratio) - ((bus_stand.width * bus_stand_ratio) / 2)) * (float(minute() - before_bus_time) / float(bus_time_differ)));
            println((float(minute() - before_bus_time) / float(bus_time_differ)));
        } else {
            bus_icon_x = bus_x + ((bus_width - (bus_icon.width * bus_icon_ratio) - ((bus_stand.width * bus_stand_ratio) / 2)) * (float(bus_time_differ - (59 - minute())) / float(bus_time_differ)));
            println((float(bus_time_differ - (59 - minute())) / float(bus_time_differ)));
        }
        if(hour() == bus_hour){
            bus_time_remain = "あと"+ str(bus_time - minute()) +"分";
        }else{
            bus_time_remain = "あと"+ str(bus_time + (60 - minute())) +"分";
        }
        if (minute() == bus_time){
            bus_time_remain = "到着";
        } else if(minute() + 1 == bus_time){
            bus_time_remain = "まもなく到着";
        }

        //バス停表示
        image(bus_stand,bus_x + bus_width - (bus_stand.width * bus_stand_ratio), bus_y + bus_height - (bus_stand.height * bus_stand_ratio), bus_stand.width * bus_stand_ratio, bus_stand.height * bus_stand_ratio);
        //バス表示
        image(bus_icon,bus_icon_x, bus_y + bus_height - (bus_icon.height * bus_icon_ratio), bus_icon.width * bus_icon_ratio, bus_icon.height * bus_icon_ratio);
        fill(255,0,0);
        text(bus_time_remain,bus_icon_x, bus_y + bus_height - (bus_icon.height * bus_icon_ratio));
        
    } else{
        float bus_time_size = bus_height * 0.1;
        textSize(bus_time_size);
        float bus_time_width = textWidth(bus_time_text);
        text(bus_time_text, bus_x + ((bus_width - bus_time_width) / 2), bus_y + (bus_time_size * 2) + (bus_height * 0.03));
        
        float bus_location_size = bus_height * 0.1;
        textSize(bus_location_size);
        float bus_location_width = textWidth(bus_dest);
        text(bus_dest, bus_x + ((bus_width - bus_location_width) / 2), bus_y + (bus_time_size * 2) + bus_location_size + (bus_height * 0.06));
    }
}