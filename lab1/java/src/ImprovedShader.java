public class ImprovedShader extends Shader {
    private int dim = 3;
    void shader(double[] p, double u, double v, double t) {
        u = u-0.5;
        v = v-0.5;
        p[0] = p[1] = p[2] = 0;

        double b, b1, b2;
        //Blue channel
        double b1Part = (u - 0.5) * 16.0 - (v - 0.5) * 4.0;
        double b2Part = (u - 0.5) * 16.0 + (v - 0.5) * 4.0;
        double[] at = {
                u*16,
                v*16,
                0.1*t
        };
        double[][] delta = new double[dim][dim];
        int[] ID = new int[dim];
        double[] F = new double[dim];

        WorleyNoise.noise(at, dim, F, delta, ID);
        double wp = F[1] - F[0];

        b1 = 0.5 + 0.5*SimplexNoise.noise(Math.sin(2*Math.PI*t) + b1Part, Math.sin(2*Math.PI*t)*0.5*v * 2,  t*0.1*2);
        b2 = 0.5 + 0.5*SimplexNoise.noise(Math.cos(2*Math.PI*t) + b2Part, Math.cos(2*Math.PI*t)*0.5*u * 2, -t*0.1*2);
        b = (1 - 0.5*(b1 + b2));

        p[0] += 1-b1;
        p[1] += b;
        p[2] += 1-b2;

        double normalize = 1-(8*u*u+8*v*v);
        double inversenorm = 1-normalize;

        p[0] *= normalize + inversenorm*wp;
        p[1] *= normalize + inversenorm*wp;
        p[2] *= normalize + inversenorm*wp;

    }

}