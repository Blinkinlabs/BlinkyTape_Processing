public class SerialSelector {
  public boolean m_chosen;
  public String m_port;

  PFont m_font;
  int m_fontSize = 18;
  float m_fontHeight;
  float m_fontAscent;
  
  color m_bgcolor = color(80,120,230,150);
  //color m_bgcolor = color(30,30,50,140);
  color m_color = color(255);

  int m_borderInset = 20;

  public SerialSelector() {
    m_chosen = false;
    
    // Set up the font
    m_font = createFont("Arial", m_fontSize);
    textFont(m_font);
    textSize(m_fontSize);
    m_fontHeight = textAscent() + textDescent();
    m_fontAscent = textAscent();

    // Connect the draw and mouse events, so this displays automagically
    registerMethod("mouseEvent", this);
    registerMethod("draw", this);
  }

  public void mouseEvent(MouseEvent e) {
    // If we haven't selected a serial port, draw a menu to display the possible choices
    if(m_chosen) {
      return;
    }
    
    int x = e.getX();
    int y = e.getY();

    switch (e.getAction()) {
    case MouseEvent.RELEASE:
      // do something for mouse released
//      println("SerialSelector: released!");
      break;
    }
  }

  // Filter out some ports we don't care about
  String[] listPorts() {
    ArrayList<String> ports = new ArrayList<String>();
    
    for(String s : Serial.list()) {
      // Mask unlikely ports
      if(s.startsWith("/dev/cu")
       | s.contains("Bluetooth-PDA-Sync")
       | s.contains("Bluetooth-Modem")) {
        continue;
      }
      
      ports.add(s);
    }
    
    return ports.toArray(new String[0]);
  }

  void draw() {
    // If we haven't selected a serial port, draw a menu to display the possible choices
    if(m_chosen) {
      return;
    }
    
    //mouseY = mouseY + 29;
    

    
    // Draw a rectangle to show we are presenting a meu
    pushStyle();
      fill(m_bgcolor);
      stroke(m_bgcolor);
      strokeWeight(1);
      rect(m_borderInset,m_borderInset,width-m_borderInset*2, height-m_borderInset*2);

      float y = m_borderInset*2 + m_fontAscent;
      textFont(m_font);
      textSize(m_fontSize);
      
      fill(m_color);
      
      textAlign(CENTER);
      text("Connect to a BlinkyTape", width/2, y);
      y+=m_fontHeight*3;

      textAlign(LEFT);
      for (String p : listPorts()) {
        if (mousePressed && (mouseButton == LEFT) && (mouseY > y && mouseY < y + 20)) {
          fill(255, 0, 255);
          m_port = p;
          m_chosen = true;
        }
        else if (mouseY > y && mouseY < y + 20) {
          fill(0, 0, 255);
        }
        else {
          fill(50);
        } 

        text(p, m_borderInset*2, y);
        y+=m_fontHeight;
      }
    popStyle();
  }
}

