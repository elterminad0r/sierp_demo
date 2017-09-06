void log_message(String message) {
  stroke(255);
  fill(255);

  textFont(f);
  text(message, 50, 50);
}

void accelerate(int n) {
  for (int i = 0; i < n; i++) {
    PVector _corner;
    switch((int)random(3)) {
    case 0:
      _corner = a;
      break;
    case 1:
      _corner = b;
      break;
    case 2:
      _corner = c;
      break;
    default:
      _corner = a;
      println("switch error");
      break;
    }
    dots.add(current_dot);
    current_dot = new Dot(_corner.copy().add(current_dot.loc).div(2));
  }
}

void decelerate(int n) {
  for (int i = 0; i < n; i++) {
    if (dots.size() > 0) {
      dots.remove(dots.size() - 1);
    }
  }
}

float base;
float dot_size;
ArrayList<Dot> dots;
Dot current_dot;
PVector a, b, c;
boolean rolling;
boolean refresh;
int frametimer;
Dot corner, next_dot;
PFont f;
String msg;
int return_to_normal;

void setup() {
  size(1800, 900);

  base = height - 100;
  return_to_normal = -1;
  msg = "enter a number from 1-6";
  refresh = true;
  dot_size = 10;
  rolling = false;
  float lpad = (width - base) / 2;
  frametimer = -1;
  f = createFont("courier", 20, true);

  a = new PVector(lpad, height - 50);
  b = new PVector(lpad + base, height - 50);
  c = new PVector(lpad + base / 2, height - 50 - base / 2 * sqrt(3));

  dots = new ArrayList<Dot>();
  current_dot = new Dot(new PVector(lpad + base / 2, height - 50 - base / 4 * sqrt(3)));
}

void draw() {
  if (return_to_normal < 0) {
    msg = "enter a number from 1-6";
    refresh = true;
  } else {
    return_to_normal--;
  }

  if (refresh || rolling) {
    if (refresh) {
      refresh = false;
    }

    background(0);
    stroke(255);
    fill(255);

    log_message(msg);

    line(a.x, a.y, b.x, b.y);
    line(b.x, b.y, c.x, c.y);
    line(c.x, c.y, a.x, a.y);

    text("1 & 2", a.x, a.y + 30);
    text("3 & 4", b.x, b.y + 30);
    text("5 & 6", c.x, c.y - 30);

    text("total dots: " + dots.size(), 50, height - 50);

    for (Dot d : dots) {
      d.draw_normal_dot(dot_size);
    }

    if (!rolling) {
      current_dot.draw_new_dot(20);
    } else {
      corner.draw_highlighted_dot(20);
      current_dot.draw_highlighted_dot(20);
      next_dot.draw_new_dot(20);

      frametimer++;

      if (frametimer > 20) {
        frametimer = -1;
        rolling = false;
        refresh = true;
        dots.add(current_dot);
        current_dot = next_dot;
      }
    }
  }
}

void keyPressed() {
  refresh = true;
  if (!rolling) {
    switch (keyCode) {
    case '1':
    case '2':
      corner = new Dot(a);
      next_dot = new Dot(corner.loc.copy().add(current_dot.loc).div(2));
      msg = "entered " + (keyCode - '0');
      return_to_normal = 100;
      rolling = true;
      break;

    case '3':
    case '4':
      corner = new Dot(b);
      next_dot = new Dot(corner.loc.copy().add(current_dot.loc).div(2));
      msg = "entered " + (keyCode - '0');
      return_to_normal = 100;
      rolling = true;
      break;

    case '5':
    case '6':
      corner = new Dot(c);
      next_dot = new Dot(corner.loc.copy().add(current_dot.loc).div(2));
      msg = "entered " + (keyCode - '0');
      return_to_normal = 100;
      rolling = true;
      break;

    case ' ':
      accelerate(1);
      break;

    case RIGHT:
      accelerate(10);
      break;
    case LEFT:
      decelerate(10);
      break;

    case 'M':
      accelerate(100);
      break;
    case 'N':
      decelerate(100);
      break;

    case DOWN:
      dot_size -= 1;
      if (dot_size < 1) {
        dot_size = 1;
      }
      break;
    case UP:
      dot_size += 1;
      if (dot_size > 20) {
        dot_size = 20;
      }
      break;

    case 'R':
      setup();
      break;
    }
  }
}
