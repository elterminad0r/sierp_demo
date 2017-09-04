class Dot {
  PVector loc;

  Dot(PVector _loc) {
    loc = _loc;
  }

  private void draw_dot(float r) {
    ellipse(loc.x, loc.y, r, r);
  }

  void draw_normal_dot(float r) {
    fill(255);  
    stroke(255);
    draw_dot(r);
  }

  void draw_new_dot(float r) {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    draw_dot(r);
  }

  void draw_highlighted_dot(float r) {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    draw_dot(r);
  }
}