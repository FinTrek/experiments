import org.gwoptics.graphics.graph2D.Graph2D;
import org.gwoptics.graphics.graph2D.LabelPos;
import org.gwoptics.graphics.graph2D.traces.Line2DTrace;
import org.gwoptics.graphics.graph2D.traces.ILine2DEquation;
import org.gwoptics.graphics.graph2D.traces.RollingLine2DTrace;
import processing.serial.*;

int DATA_WIDTH = 300;

class serialData implements ILine2DEquation {
   public double computePoint(double x, int pos) {
     while(port.available() > 2) {
       input = port.readStringUntil('\n');
     }
     if(input != null) {
      input = trim(input);
      if(input.length() > 0) {
        val = int(input)*(5.0f / 1023.0f);
        return val;
      }
     }
     return 0f; 
  }
} 

Graph2D g;
RollingLine2DTrace trace;
Serial port;  
double val;
String input;

void setup(){
  size(DATA_WIDTH,200);
  
  port = new Serial(this, Serial.list()[4], 9600);
  
  g = new Graph2D(this, DATA_WIDTH, 200, false); 
  
  g.setYAxisMin(0);
  g.setYAxisMax(5);
  g.setXAxisMin(0);
  g.setXAxisMax(DATA_WIDTH);
  g.setYAxisLabel("Voltage");
  g.setYAxisTickSpacing(1.00);
  g.setXAxisTickSpacing(100);
  g.setYAxisLabel("Time");  
  trace  = new RollingLine2DTrace(new serialData(),5,.5f);
  trace.setTraceColour(0, 0, 0);
  g.addTrace(trace);
  
}

void draw(){
  background(255);
  g.draw();
}

  
