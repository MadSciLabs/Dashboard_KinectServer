/*
 Copyright (C) 2014  Thomas Sanchez Lengeling.
 KinectPV2, Kinect for Windows v2 library for processing
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import wsp5.*;

WsClient client;

PImage img;  // Declare variable "a" of type PImage

float zVal = 300;
float rotX = PI;

int _screenWidth = 1280; //1920;
int _screenHeight = 800; //1080;

int adjustedScreenWidth =  (_screenHeight * 1920) / 1080;
int adjustedScreenHeight = _screenHeight;

int adjustedScreenLeftOffset = (adjustedScreenWidth - _screenWidth)/2;

String _s;
boolean bConnected = false;

void setup() {

  size(400, 400);
  
   img = loadImage("g.jpg");  // Load the image into the program  
  img.resize(40,20);
  
  //START SOCKET CLIENT
  try {
    
    client = new WsClient( this, "ws://localhost:3006");
    client.connect();
    bConnected = true;

  } catch ( Exception e ){

  } 
  
  frameRate(10);
  
}

void draw() {
  
  background(0);
  
  img.loadPixels();
  img.filter(GRAY);
  
  int _size = img.width * img.height;
  String _s = "";
 
  for (int i = 0; i < _size; i++) {
    _s += int(map(red(img.pixels[i]), 255, 0, 0, 5));
  }

  if (bConnected)
  {
    client.send(_s);
  }
  
}