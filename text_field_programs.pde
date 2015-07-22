/******************* text field programs tab ***********************/

public void getParams() {  

/********************************* 
mode = params[0]  vOffset      = 5
vInit    = 1      initialDelay = 6
vFinal   = 2      nRuns        = 7
scanRate = 3      logIvl       = 8
cGain    = 4      del2         = 9
************************************/

  /* Info from text fields transmitted to u-controller as strings
   * to convert to float, int, or char, use commands below:
   *  float fSpeed = float(stringSpeed);
   *  iSpeed = round(fSpeed);
   *  cSpeed = char(iSpeed);
  */ 
  params[1] = cp5.get(Textfield.class, "Starting_Voltage").getText();
  params[2] = cp5.get(Textfield.class, "End_Voltage").getText();
  params[3] = cp5.get(Textfield.class, "Scan_Rate").getText();
  cGain = cp5.get(Textfield.class, "Gain").getText();
    iGain = round(float(cGain));       
    if (iGain <= -1) {
      iGain = 0;
    }
    if (iGain >= 31) {
      iGain = 30;
    }
  params[4]  = nf(iGain, 3);   // pad with zeros to 3 digits, changed from 6 digits
  vOffset = cp5.get(Textfield.class, "offset").getText();
    iOffset = round(float(vOffset))+165; //512;
  params[5] = nf(iOffset, 6);   // pad with zeros to 6 digits
  params[6] = cp5.get(Textfield.class, "Delay_Time").getText();
  params[7] = cp5.get(Textfield.class, "Number_of_Runs").getText();
  params[8] = cp5.get(Textfield.class, "Run_Interval").getText();
  params[9] = cp5.get(Textfield.class, "delay2").getText();

}