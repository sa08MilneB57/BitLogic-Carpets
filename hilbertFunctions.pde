//assumes a square of n by n points
//n should be a power of 2 
//(x,y) goes from (0,0) to (n -1,n -1)
//d goes from 0 to n^2-1

int nthBit(int x, int n){
  //nth digit of x
  return (x>>n) & 1;
}

//rotate/flip a quadrant appropriately
int[] rot(int n, int x, int y, int rx, int ry) {
    if (ry == 0) {
        if (rx == 1) {
            x = n-1 - x;
            y = n-1 - y;
        }

        //Swap x and y
        int t  = x;
        x = y;
        y = t;
    }
    int[] out = {x,y};
    return out;
}

//convert d to (x,y)
int[] hilbertXY(int n, int d) {
    int rx, ry, s, t=d;
    int x = 0;
    int y = 0;
    for (s=1; s<n; s*=2) {
        rx = 1 & (t/2);
        ry = 1 & (t ^ rx);
        int[] out = rot(s, x, y, rx, ry);
        x = out[0] + s * rx;
        y = out[1] + s * ry;
        t /= 4;
    }
    int[] out = {x,y};
    return out;
}

//convert (x,y) to d
int hilbertD (int n, int x, int y) {
    int rx, ry, s, d=0;
    for (s=n/2; s>0; s/=2) {
        rx = nthBit(x,s);//sth digit of x
        ry = nthBit(y,s);//sth digit of y
        d += s * s * ((3 * rx) ^ ry);
        rot(n, x, y, rx, ry);
    }
    return d;
}
