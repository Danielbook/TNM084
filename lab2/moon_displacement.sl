displacement moon_displacement(output varying float elevation = 0.0, craterElevation = 0.0) {

  // These two variables could be made input parameters.
  float bumpamount = 0.025;
  float sealevel = 0.0;

  // Specify a coordinate space for the 3D texture coordinates
  point Ptex = transform("shader", P);
  
  // Largest features are "continental scale"
  elevation = noise(Ptex*4.0)-0.5;
  // Make the continents and seas have flat peaks
  elevation = smoothstep(-0.3, 0.1, elevation);

  // Create the smaller craters
  craterElevation = -abs(noise(Ptex*7.0)-0.5);
  craterElevation = smoothstep(-0.4, 0.0, craterElevation);

  // Add a fractal sum of Perlin noise to create a rough surface and the bigger craters
  float freq;
  for (freq=1.0; freq<256.0; freq*=2.0) {
    elevation += 0.7/freq*(noise(Ptex*15.0*freq)-0.5);
    if(elevation > 0) { craterElevation += 2.5/freq*((noise(Ptex*10.0*freq)-0.5)); };
  }

  // Adjust for desired crater level
  elevation -= sealevel;
  
  float disp = min(elevation, craterElevation);

  // Displace along normal, and recompute normal
  P += bumpamount * disp * N;
  N = calculatenormal(P);
}