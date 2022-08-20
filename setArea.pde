void setArea(){
    Area[0][0] = 0;
    Area[0][1] = 0;
    Area[0][2] = width/2;
    Area[0][3] = height/2;

    Area[1][0] = width/2;
    Area[1][1] = 0;
    Area[1][2] = width/2;
    Area[1][3] = height/2;

    Area[2][0] = width/2;
    Area[2][1] = height/2;
    Area[2][2] = width/2;
    Area[2][3] = height/2;

    Area[3][0] = 0;
    Area[3][1] = height/2;
    Area[3][2] = width/2;
    Area[3][3] = height/2;
}