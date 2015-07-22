/* LineChart tab, WheeStat6_0 GUI sketch
     chartsSetup() -- initiallizes charts
                   --called in setup loop
     displayCharts() -- sets up and displays charts
                   -- called in draw loop
     setLimits() -- sets limits on x and y displays
*/

void chartsSetup(){
for (int y = 0; y<10; y++) {
  lineChart[y] = new XYChart(this);
  if(y == 0){
    lineChart[y].showXAxis(true);
    lineChart[y].showYAxis(true);
  }
  lineChart[y].setPointColour(color(red[y], green[y], blue[y]));
  lineChart[y].setPointSize(5);
  lineChart[y].setLineWidth(2);
  }
}

void displayCharts(){
  boolean firstChart = true;
  for (int y = 1; y<10; y++) {
    if (showChart[y] == true) {
      firstChart = false;
    }
  }
/*    chartXMax = max(xMax);
  chartYMax = max(yMax);
  chartXMin = min(xMin);
  chartYMin = min(yMin);*/
//  chartXMax = 9999;

  fill(#EADFC9);               // background color
  int chartPosX = 200;        // position of background rectangle
  int chartPosY = 70;
  int chartSzX = 475;         // size of background rectangle
  int chartSzY = 450;
  translate(chartPosX,chartPosY);
//  rect(200, 70, 475, 450);    // chart background 
  rect(0, 0, chartSzX, chartSzY);    // chart background 
  fill(0, 0, 0);
  int posX = 20; //220;  // x position for center of y axis
  int posY = chartSzY/2; //260;  // y position for center of y axis
  translate(posX, posY);
  rotate(3.14159*3/2);
  textAlign(CENTER);
  text("Current  (microamps)", 0, 0);
  rotate(3.14159/2);        // return orientation and location
  translate(-posX, -posY);
translate(-chartPosX,-chartPosY);  

  if (runMode=="ChronoAmp"||runMode=="ChronoAmp2") { 
    xChartLabel = "Time (milliseconds)";
  } else {
    xChartLabel = "Voltage (mV)";
  }
  
  posX = 475;
  posY = 515;
  translate(posX, posY);
  textAlign(CENTER);
  text(xChartLabel, 0, 0);
  translate(-posX, -posY);  
//////////// figure out the data and graph it /////////////////
  if (run==true) {
    read_serial();
    lineChart[0].setData(xData, yData);   
  }  

  if (run == false && runCount >0) { 
    lineChart[0].setData(xRecover[runCount-1], yRecover[runCount-1]);
  }
   if (firstChart == true){         // reset max and min values
   chartXMax = xMax[0];
  chartYMax = yMax[0];
  chartXMin = xMin[0];
  chartYMin = yMin[0];
 }
  setLimits(lineChart[0]);

////////////////////// setup and display charts ///////////////
for (int h=0; h<10; h++) {
/*  int j;
 if (run == true){  
  j = h;
 }
else {
 j = h+1;
}  */
  if (showChart[h] == true){     // draw charts
/* if (chartXMax == 9999){         // reset max and min values
   chartXMax = xMax[h];
  chartYMax = yMax[h];
  chartXMin = xMin[h];
  chartYMin = yMin[h];
 }*/
 if(chartXMax < xMax[h]){
    chartXMax = xMax[h];  
 }
  if(chartXMin > xMin[h]){
    chartXMin = xMin[h];  
 }
  if(chartYMax < yMax[h]){
    chartYMax = yMax[h];  
 }
  if(chartYMin > yMin[h]){
    chartYMin = yMin[h];  
 }
    if(h != 0){      // remember that chart[0] is sized different than other charts
    lineChart[h].setData(xRecover[fileCount-h], yRecover[fileCount-h]);  
        // puts most recent chart in file 0, original chart in highest file number
    setLimits(lineChart[h]);
    lineChart[h].draw(270, 80, 400, 400);  // draw linechart[0] is below
           // line chart 0 params: 250, 70, 430,420
    }

if (selectBox[h] == true) {
  fill(selected);
  stroke(selected);
  rect(legBoxX+40,20*h + legBoxY-5,100,20);    // selection box
  fill(255);
  }
  legend(h,(fileCount-h)*20);         // display legend next to file name, defined in  legend tab
                                      //  gets colors correct
  //text(sFileName[fileCount-h],legBoxX+50,20*h+legBoxY + 10);  // was 780, 130
}
if (showChart[h] == true || hideChart[h] == true){
   textAlign(LEFT);
  text(sFileName[h],legBoxX+50,20*h+legBoxY + 10);  // was 780, 130
 
}
}
   try {
    lineChart[0].draw(250, 70, 430, 420);
  }
  catch(Exception e) {
    println("problem with drawing lineChart[0]");
  } 
}

void setLimits(XYChart thing) {
          thing.setMaxX(chartXMax);
          thing.setMaxY(chartYMax);
          thing.setMinX(chartXMin);
          thing.setMinY(chartYMin);
}
