float x=250,y=250,r=10,v,vx,vy,ax,ay=0.02,airR=0.999,ban,bab,man,mv,mvx,mvy,me=0.5,mw=1,p=1,dead;
int lift,liftp,lifthi;

void setup(){
  size(500,700);
  background(255);
  frameRate(100);//1フレーム＝1(s)と考える。
}

void draw(){
  
  //重力設定-------------------------------------------------
  vx += ax;
  vy += ay;
  //---------------------------------------------------------
  
  //ボールの速度設定-----------------------------------------
  v=sqrt(sq(vx)+sq(vy));
  //---------------------------------------------------------
  
  
  //マウスの速度設定-----------------------------------------
  mv=sqrt(sq(mouseX-pmouseX)+sq(mouseY-pmouseY));
  mvx=mouseX-pmouseX;
  mvy=mouseY-pmouseY;
  //---------------------------------------------------------
  
  /*
  //マウスの移動角度設定-------------------------------------
  if(pmouseX==mouseX){
    man=0;//                                  0で割るのを防ぐ
  }else{
    man=atan(( mouseY-pmouseY )/( mouseX-pmouseX ));//前フレームのマウスの場所から次のマウスまでの角度
  }
    
  if(mouseX>pmouseX && mouseY<pmouseY){man=-man;}//第１象限
  if(mouseX<pmouseX && mouseY<pmouseY){man=-man+radians(180);}//第２象限
  if(mouseX<pmouseX && mouseY>pmouseY){man=radians(180)-man;}//第３象限
  if(mouseX>pmouseX && mouseY>pmouseY){man=radians(360)-man;}//第４象限
  //----------------------------------------------------------
  */
  
  //マウスとボールの角度--------------------------------------
  if(x==mouseX && mouseY<y){
    ban=PI/2;
  }
  
  if(x==mouseX && mouseY>y){
    ban=3*PI/2;
  }
  if(x!=mouseX){
    ban=atan(( mouseY-y )/( mouseX-x ));
  }
  
  if(mouseX>x && mouseY<y){ban=-ban;}//第１象限
  if(mouseX<x && mouseY<y){ban=-ban+radians(180);}//第２象限
  if(mouseX<x && mouseY>y){ban=radians(180)-ban;}//第３象限
  if(mouseX>x && mouseY>y){ban=radians(360)-ban;}//第４象限
  //----------------------------------------------------------
  
  
  //マウスとの衝突判定----------------------------------------
  if(r>dist(x,y,mouseX,mouseY) && p<0.1){
    liftp++;
    p=1;
    vx=-v*cos(ban)+me*mvx;
    vy=-vy+me*mvy;
  }
  //----------------------------------------------------------
  
  
  
  //壁との衝突判定--------------------------------------
    if(r>x-0){x=r;vx=-vx*mw;}
    if(r>500-x){x=500-r;vx=-vx*mw;}
    if(r>y-0){y=r;vy=-vy*mw;}
    if(r>700-y){y=700-r;vy=-vy*mw;dead=1;}
  //----------------------------------------------------------
    
  
  //点数処理--------------------------------------------------
    if(dead==1){
      lift=liftp;
      liftp=0;
      if(lift>lifthi){lifthi=lift;}
      lift=0;
}
  //----------------------------------------------------------
    
  p*=0.92;
  dead*=0.92;

  
  //描画------------------------------------------------------  
  background(200*dead,200,200);
  textAlign(CENTER);
  textSize(20);
  fill(255,255,0,100);
  textSize(150);
  text(+liftp,250,200);
  fill(255,255,0);
  textSize(25);
  text("MAX Score = "+lifthi,100,60);
  noStroke();
  fill(0);
  x=x+vx;
  y=y+vy;
  ellipse(x,y,r*2,r*2);
 //-----------------------------------------------------------
 
 
 //空気抵抗---------------------------------------------------
  vy=vy*airR;
  vx=vx*airR;
 //-----------------------------------------------------------
}

void mousePressed(){
  vy=vy-1;
}
