void texturedCube(float x, float y, float z, PImage texture, float size) {
  
  pushMatrix();
  translate(x, y, z);
  scale(size);
  rotateX(rotx);
  rotateY(roty);

  noStroke();

  beginShape(QUADS);
  texture(texture);

  //top  //x, y, z, tx, ty
  vertex(0, 0, 0, 0, 0);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 0, 1, 1, 1);
  vertex(0, 0, 1, 0, 1);

  //bottom
  vertex(0, 1, 0, 0, 0);
  vertex(1, 1, 0, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(0, 1, 1, 0, 1);


  //front
  vertex(0, 1, 1, 0, 1);
  vertex(1, 1, 1, 1, 1);
  vertex(1, 0, 1, 1, 0);
  vertex(0, 0, 1, 0, 0);
  //back

  vertex(0, 1, 0, 0, 1);
  vertex(1, 1, 0, 1, 1);
  vertex(1, 0, 0, 1, 0);
  vertex(0, 0, 0, 0, 0);

  //left
  vertex(1, 1, 1, 0, 1);
  vertex(1, 1, 0, 1, 1);
  vertex(1, 0, 0, 1, 0);
  vertex(1, 0, 1, 0, 0);

  //right
  vertex(0, 1, 1, 0, 1);
  vertex(0, 1, 0, 1, 1);
  vertex(0, 0, 0, 1, 0);
  vertex(0, 0, 1, 0, 0);

  endShape();

  popMatrix();
}
