surface moon_surface() {

  // Fetch varying variable "elevation" from displacement shader
  float elevation;
  displacement("elevation", elevation);

  float craterElevation;
  displacement("craterElevation", craterElevation);

  // Shorthand constants for some RGB colors
  color white = color(1.0, 1.0, 1.0);
  color lightgrey = color(0.9, 0.9, 0.9);
  color darkgrey = color(0.2, 0.2, 0.2);
  color black = color(0, 0, 0);
  
  // Normalize the normal to make sure it's unit length
  vector Nn = normalize(N);

  // Make land middlegrey near the craters lightgrey at higher altitudes
  color CSurface = mix(darkgrey, white, smoothstep(0.1, 0.9, elevation));
  
  // Compute illumination (land is diffuse only)
  CSurface *= diffuse(Nn);
  
  // Make the moons craters darker towards the middle
  color Ccrater = mix(darkgrey, black, smoothstep(-0.3, 0.5, -elevation));
  Ccrater *= diffuse(Nn);
  Ccrater += white * specular(Nn, normalize(-I), 0.1);

  color Cbigcrater = mix(darkgrey, black, smoothstep(-0.3, 0.5, -craterElevation));
  Cbigcrater *= diffuse(Nn);
  Cbigcrater += white * specular(Nn, normalize(-I), 0.1);

  // Mix final surface color: black where elevation<0, land elsewhere.
  Ci = mix(Cbigcrater, CSurface, filterstep(0.0, craterElevation));

  // Set output opacity same as input opacity (to play nice)
  Oi = Os;
}