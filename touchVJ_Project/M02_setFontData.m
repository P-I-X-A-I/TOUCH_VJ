#import "M02_FontBit.h"

@implementation M02_FontBit ( FONT )

- (void)setFontData
{
    int i, j;
    
    for(i = 0 ; i < 26 ; i++ )
    {
        font_bitNum[i] = 0;
        
        for( j = 0 ; j < 17 ; j++ )
        {
            font_bitPos[i][j][0] = 0.0f;
            font_bitPos[i][j][1] = 0.0f;
        }
    }
    
    //A
    font_bitNum[0] = 14;
    
    // X                                // Y
    font_bitPos[0][ 0][0] =-0.02f;     font_bitPos[0][ 0][1] =-0.02f;
    font_bitPos[0][ 1][0] =-0.02f;     font_bitPos[0][ 1][1] =-0.01f;
    font_bitPos[0][ 2][0] =-0.02f;     font_bitPos[0][ 2][1] = 0.00f;
    font_bitPos[0][ 3][0] =-0.02f;     font_bitPos[0][ 3][1] = 0.01f;
    font_bitPos[0][ 4][0] =-0.01f;     font_bitPos[0][ 4][1] = 0.00f;
    font_bitPos[0][ 5][0] =-0.01f;     font_bitPos[0][ 5][1] = 0.02f;
    font_bitPos[0][ 6][0] = 0.00f;     font_bitPos[0][ 6][1] = 0.00f;
    font_bitPos[0][ 7][0] = 0.00f;     font_bitPos[0][ 7][1] = 0.02f;
    font_bitPos[0][ 8][0] = 0.01f;     font_bitPos[0][ 8][1] = 0.00f;
    font_bitPos[0][ 9][0] = 0.01f;     font_bitPos[0][ 9][1] = 0.02f;
    font_bitPos[0][10][0] = 0.02f;     font_bitPos[0][10][1] =-0.02f;
    font_bitPos[0][11][0] = 0.02f;     font_bitPos[0][11][1] =-0.01f;
    font_bitPos[0][12][0] = 0.02f;     font_bitPos[0][12][1] = 0.00f;
    font_bitPos[0][13][0] = 0.02f;     font_bitPos[0][13][1] = 0.01f;

    // B
    font_bitNum[1] = 18;
    
    font_bitPos[1][ 0][0] =-0.02f;     font_bitPos[1][ 0][1] =-0.02f;
    font_bitPos[1][ 1][0] =-0.02f;     font_bitPos[1][ 1][1] =-0.01f;
    font_bitPos[1][ 2][0] =-0.02f;     font_bitPos[1][ 2][1] = 0.00f;
    font_bitPos[1][ 3][0] =-0.02f;     font_bitPos[1][ 3][1] = 0.01f;
    font_bitPos[1][ 4][0] =-0.02f;     font_bitPos[1][ 4][1] = 0.02f;
    font_bitPos[1][ 5][0] =-0.01f;     font_bitPos[1][ 5][1] =-0.02f;
    font_bitPos[1][ 6][0] =-0.01f;     font_bitPos[1][ 6][1] = 0.00f;
    font_bitPos[1][ 7][0] =-0.01f;     font_bitPos[1][ 7][1] = 0.02f;
    font_bitPos[1][ 8][0] = 0.00f;     font_bitPos[1][ 8][1] =-0.02f;
    font_bitPos[1][ 9][0] = 0.00f;     font_bitPos[1][ 9][1] = 0.00f;
    font_bitPos[1][10][0] = 0.00f;     font_bitPos[1][10][1] = 0.02f;
    font_bitPos[1][11][0] = 0.01f;     font_bitPos[1][11][1] =-0.02f;
    font_bitPos[1][12][0] = 0.01f;     font_bitPos[1][12][1] = 0.00f;
    font_bitPos[1][13][0] = 0.01f;     font_bitPos[1][13][1] = 0.02f;
    font_bitPos[1][14][0] = 0.02f;     font_bitPos[1][14][1] =-0.015f;
    font_bitPos[1][15][0] = 0.02f;     font_bitPos[1][15][1] =-0.005f;
    font_bitPos[1][16][0] = 0.02f;     font_bitPos[1][16][1] = 0.005f;
    font_bitPos[1][17][0] = 0.02f;     font_bitPos[1][17][1] = 0.015f;
    
    // C
    font_bitNum[2] = 11;
    
    font_bitPos[2][ 0][0] =-0.02f;     font_bitPos[2][ 0][1] =-0.01f;
    font_bitPos[2][ 1][0] =-0.02f;     font_bitPos[2][ 1][1] = 0.00f;
    font_bitPos[2][ 2][0] =-0.02f;     font_bitPos[2][ 2][1] = 0.01f;
    font_bitPos[2][ 3][0] =-0.01f;     font_bitPos[2][ 3][1] =-0.02f;
    font_bitPos[2][ 4][0] =-0.01f;     font_bitPos[2][ 4][1] = 0.02f;
    font_bitPos[2][ 5][0] = 0.00f;     font_bitPos[2][ 5][1] =-0.02f;
    font_bitPos[2][ 6][0] = 0.00f;     font_bitPos[2][ 6][1] = 0.02f;
    font_bitPos[2][ 7][0] = 0.01f;     font_bitPos[2][ 7][1] =-0.02f;
    font_bitPos[2][ 8][0] = 0.01f;     font_bitPos[2][ 8][1] = 0.02f;
    font_bitPos[2][ 9][0] = 0.02f;     font_bitPos[2][ 9][1] =-0.02f;
    font_bitPos[2][10][0] = 0.02f;     font_bitPos[2][10][1] = 0.02f;
    
    // D
    font_bitNum[3] = 14;
    
    font_bitPos[3][ 0][0] =-0.02f;     font_bitPos[3][ 0][1] =-0.02f;
    font_bitPos[3][ 1][0] =-0.02f;     font_bitPos[3][ 1][1] =-0.01f;
    font_bitPos[3][ 2][0] =-0.02f;     font_bitPos[3][ 2][1] = 0.00f;
    font_bitPos[3][ 3][0] =-0.02f;     font_bitPos[3][ 3][1] = 0.01f;
    font_bitPos[3][ 4][0] =-0.02f;     font_bitPos[3][ 4][1] = 0.02f;
    font_bitPos[3][ 5][0] =-0.01f;     font_bitPos[3][ 5][1] =-0.02f;
    font_bitPos[3][ 6][0] =-0.01f;     font_bitPos[3][ 6][1] = 0.02f;
    font_bitPos[3][ 7][0] = 0.00f;     font_bitPos[3][ 7][1] =-0.02f;
    font_bitPos[3][ 8][0] = 0.00f;     font_bitPos[3][ 8][1] = 0.02f;
    font_bitPos[3][ 9][0] = 0.01f;     font_bitPos[3][ 9][1] =-0.02f;
    font_bitPos[3][10][0] = 0.01f;     font_bitPos[3][10][1] = 0.02f;
    font_bitPos[3][11][0] = 0.02f;     font_bitPos[3][11][1] =-0.01f;
    font_bitPos[3][12][0] = 0.02f;     font_bitPos[3][12][1] = 0.00f;
    font_bitPos[3][13][0] = 0.02f;     font_bitPos[3][13][1] = 0.01f;
    
    //E
    font_bitNum[4] = 17;
    
    font_bitPos[4][ 0][0] =-0.02f;     font_bitPos[4][ 0][1] =-0.02f;
    font_bitPos[4][ 1][0] =-0.02f;     font_bitPos[4][ 1][1] =-0.01f;
    font_bitPos[4][ 2][0] =-0.02f;     font_bitPos[4][ 2][1] = 0.00f;
    font_bitPos[4][ 3][0] =-0.02f;     font_bitPos[4][ 3][1] = 0.01f;
    font_bitPos[4][ 4][0] =-0.02f;     font_bitPos[4][ 4][1] = 0.02f;
    font_bitPos[4][ 5][0] =-0.01f;     font_bitPos[4][ 5][1] =-0.02f;
    font_bitPos[4][ 6][0] =-0.01f;     font_bitPos[4][ 6][1] = 0.00f;
    font_bitPos[4][ 7][0] =-0.01f;     font_bitPos[4][ 7][1] = 0.02f;
    font_bitPos[4][ 8][0] = 0.00f;     font_bitPos[4][ 8][1] =-0.02f;
    font_bitPos[4][ 9][0] = 0.00f;     font_bitPos[4][ 9][1] = 0.00f;
    font_bitPos[4][10][0] = 0.00f;     font_bitPos[4][10][1] = 0.02f;
    font_bitPos[4][11][0] = 0.01f;     font_bitPos[4][11][1] =-0.02f;
    font_bitPos[4][12][0] = 0.01f;     font_bitPos[4][12][1] = 0.00f;
    font_bitPos[4][13][0] = 0.01f;     font_bitPos[4][13][1] = 0.02f;
    font_bitPos[4][14][0] = 0.02f;     font_bitPos[4][14][1] =-0.02f;
    font_bitPos[4][15][0] = 0.02f;     font_bitPos[4][15][1] = 0.00f;
    font_bitPos[4][16][0] = 0.02f;     font_bitPos[4][16][1] = 0.02f;
    
    // F
    font_bitNum[5] = 12;
    
    font_bitPos[5][ 0][0] =-0.02f;     font_bitPos[5][ 0][1] =-0.02f;
    font_bitPos[5][ 1][0] =-0.02f;     font_bitPos[5][ 1][1] =-0.01f;
    font_bitPos[5][ 2][0] =-0.02f;     font_bitPos[5][ 2][1] = 0.00f;
    font_bitPos[5][ 3][0] =-0.02f;     font_bitPos[5][ 3][1] = 0.01f;
    font_bitPos[5][ 4][0] =-0.02f;     font_bitPos[5][ 4][1] = 0.02f;
    font_bitPos[5][ 5][0] =-0.01f;     font_bitPos[5][ 5][1] = 0.00f;
    font_bitPos[5][ 6][0] =-0.01f;     font_bitPos[5][ 6][1] = 0.02f;
    font_bitPos[5][ 7][0] = 0.00f;     font_bitPos[5][ 7][1] = 0.00f;
    font_bitPos[5][ 8][0] = 0.00f;     font_bitPos[5][ 8][1] = 0.02f;
    font_bitPos[5][ 9][0] = 0.01f;     font_bitPos[5][ 9][1] = 0.00f;
    font_bitPos[5][10][0] = 0.01f;     font_bitPos[5][10][1] = 0.02f;
    font_bitPos[5][11][0] = 0.02f;     font_bitPos[5][11][1] = 0.02f;
    
    //G
    font_bitNum[6] = 14;

    font_bitPos[6][ 0][0] =-0.02f;     font_bitPos[6][ 0][1] =-0.01f;
    font_bitPos[6][ 1][0] =-0.02f;     font_bitPos[6][ 1][1] = 0.00f;
    font_bitPos[6][ 2][0] =-0.02f;     font_bitPos[6][ 2][1] = 0.01f;
    font_bitPos[6][ 3][0] =-0.01f;     font_bitPos[6][ 3][1] =-0.02f;
    font_bitPos[6][ 4][0] =-0.01f;     font_bitPos[6][ 4][1] = 0.02f;
    font_bitPos[6][ 5][0] = 0.00f;     font_bitPos[6][ 5][1] =-0.02f;
    font_bitPos[6][ 6][0] = 0.00f;     font_bitPos[6][ 6][1] = 0.02f;
    font_bitPos[6][ 7][0] = 0.01f;     font_bitPos[6][ 7][1] =-0.02f;
    font_bitPos[6][ 8][0] = 0.01f;     font_bitPos[6][ 8][1] = 0.00f;
    font_bitPos[6][ 9][0] = 0.01f;     font_bitPos[6][ 9][1] = 0.02f;
    font_bitPos[6][10][0] = 0.02f;     font_bitPos[6][10][1] =-0.02f;
    font_bitPos[6][11][0] = 0.02f;     font_bitPos[6][11][1] =-0.01f;
    font_bitPos[6][12][0] = 0.02f;     font_bitPos[6][12][1] = 0.00f;
    font_bitPos[6][13][0] = 0.02f;     font_bitPos[6][13][1] = 0.02f;
    
    // H
    font_bitNum[7] = 13;
    
    font_bitPos[7][ 0][0] =-0.02f;     font_bitPos[7][ 0][1] =-0.02f;
    font_bitPos[7][ 1][0] =-0.02f;     font_bitPos[7][ 1][1] =-0.01f;
    font_bitPos[7][ 2][0] =-0.02f;     font_bitPos[7][ 2][1] = 0.00f;
    font_bitPos[7][ 3][0] =-0.02f;     font_bitPos[7][ 3][1] = 0.01f;
    font_bitPos[7][ 4][0] =-0.02f;     font_bitPos[7][ 4][1] = 0.02f;
    font_bitPos[7][ 5][0] =-0.01f;     font_bitPos[7][ 5][1] = 0.00f;
    font_bitPos[7][ 6][0] = 0.00f;     font_bitPos[7][ 6][1] = 0.00f;
    font_bitPos[7][ 7][0] = 0.01f;     font_bitPos[7][ 7][1] = 0.00f;
    font_bitPos[7][ 8][0] = 0.02f;     font_bitPos[7][ 8][1] =-0.02f;
    font_bitPos[7][ 9][0] = 0.02f;     font_bitPos[7][ 9][1] =-0.01f;
    font_bitPos[7][10][0] = 0.02f;     font_bitPos[7][10][1] = 0.00f;
    font_bitPos[7][11][0] = 0.02f;     font_bitPos[7][11][1] = 0.01f;
    font_bitPos[7][12][0] = 0.02f;     font_bitPos[7][12][1] = 0.02f;
    
    
    // I
    font_bitNum[8] = 9;
    
    font_bitPos[8][ 0][0] =-0.01f;     font_bitPos[8][ 0][1] =-0.02f;
    font_bitPos[8][ 1][0] =-0.01f;     font_bitPos[8][ 1][1] = 0.02f;
    font_bitPos[8][ 2][0] = 0.00f;     font_bitPos[8][ 2][1] =-0.02f;
    font_bitPos[8][ 3][0] = 0.00f;     font_bitPos[8][ 3][1] =-0.01f;
    font_bitPos[8][ 4][0] = 0.00f;     font_bitPos[8][ 4][1] = 0.00f;
    font_bitPos[8][ 5][0] = 0.00f;     font_bitPos[8][ 5][1] = 0.01f;
    font_bitPos[8][ 6][0] = 0.00f;     font_bitPos[8][ 6][1] = 0.02f;
    font_bitPos[8][ 7][0] = 0.01f;     font_bitPos[8][ 7][1] =-0.02f;
    font_bitPos[8][ 8][0] = 0.01f;     font_bitPos[8][ 8][1] = 0.02f;
    
    
    // J
    font_bitNum[9] = 10;

    font_bitPos[9][ 0][0] =-0.02f;     font_bitPos[9][ 0][1] =-0.02f;
    font_bitPos[9][ 1][0] =-0.02f;     font_bitPos[9][ 1][1] = 0.02f;
    font_bitPos[9][ 2][0] =-0.01f;     font_bitPos[9][ 2][1] =-0.02f;
    font_bitPos[9][ 3][0] =-0.01f;     font_bitPos[9][ 3][1] = 0.02f;
    font_bitPos[9][ 4][0] = 0.00f;     font_bitPos[9][ 4][1] =-0.01f;
    font_bitPos[9][ 5][0] = 0.00f;     font_bitPos[9][ 5][1] = 0.00f;
    font_bitPos[9][ 6][0] = 0.00f;     font_bitPos[9][ 6][1] = 0.01f;
    font_bitPos[9][ 7][0] = 0.00f;     font_bitPos[9][ 7][1] = 0.02f;
    font_bitPos[9][ 8][0] = 0.01f;     font_bitPos[9][ 8][1] = 0.02f;
    font_bitPos[9][ 9][0] = 0.02f;     font_bitPos[9][ 9][1] = 0.02f;
    
    // K
    font_bitNum[10] = 11;
    
    font_bitPos[10][ 0][0] =-0.02f;     font_bitPos[10][ 0][1] =-0.02f;
    font_bitPos[10][ 1][0] =-0.02f;     font_bitPos[10][ 1][1] =-0.01f;
    font_bitPos[10][ 2][0] =-0.02f;     font_bitPos[10][ 2][1] = 0.00f;
    font_bitPos[10][ 3][0] =-0.02f;     font_bitPos[10][ 3][1] = 0.01f;
    font_bitPos[10][ 4][0] =-0.02f;     font_bitPos[10][ 4][1] = 0.02f;
    font_bitPos[10][ 5][0] =-0.01f;     font_bitPos[10][ 5][1] = 0.00f;
    font_bitPos[10][ 6][0] = 0.00f;     font_bitPos[10][ 6][1] = 0.00f;
    font_bitPos[10][ 7][0] = 0.01f;     font_bitPos[10][ 7][1] =-0.01f;
    font_bitPos[10][ 8][0] = 0.01f;     font_bitPos[10][ 8][1] = 0.01f;
    font_bitPos[10][ 9][0] = 0.02f;     font_bitPos[10][ 9][1] =-0.02f;
    font_bitPos[10][10][0] = 0.02f;     font_bitPos[10][10][1] = 0.02f;
    
    // L
    font_bitNum[11] = 9;
    
    font_bitPos[11][ 0][0] =-0.02f;     font_bitPos[11][ 0][1] =-0.02f;
    font_bitPos[11][ 1][0] =-0.02f;     font_bitPos[11][ 1][1] =-0.01f;
    font_bitPos[11][ 2][0] =-0.02f;     font_bitPos[11][ 2][1] = 0.00f;
    font_bitPos[11][ 3][0] =-0.02f;     font_bitPos[11][ 3][1] = 0.01f;
    font_bitPos[11][ 4][0] =-0.02f;     font_bitPos[11][ 4][1] = 0.02f;
    font_bitPos[11][ 5][0] =-0.01f;     font_bitPos[11][ 5][1] =-0.02f;
    font_bitPos[11][ 6][0] = 0.00f;     font_bitPos[11][ 6][1] =-0.02f;
    font_bitPos[11][ 7][0] = 0.01f;     font_bitPos[11][ 7][1] =-0.02f;
    font_bitPos[11][ 8][0] = 0.02f;     font_bitPos[11][ 8][1] =-0.02f;

    
    // M
    font_bitNum[12] = 13;
    
    font_bitPos[12][ 0][0] =-0.02f;     font_bitPos[12][ 0][1] =-0.02f;
    font_bitPos[12][ 1][0] =-0.02f;     font_bitPos[12][ 1][1] =-0.01f;
    font_bitPos[12][ 2][0] =-0.02f;     font_bitPos[12][ 2][1] = 0.00f;
    font_bitPos[12][ 3][0] =-0.02f;     font_bitPos[12][ 3][1] = 0.01f;
    font_bitPos[12][ 4][0] =-0.02f;     font_bitPos[12][ 4][1] = 0.02f;
    font_bitPos[12][ 5][0] =-0.01f;     font_bitPos[12][ 5][1] = 0.01f;
    font_bitPos[12][ 6][0] = 0.00f;     font_bitPos[12][ 6][1] = 0.00f;
    font_bitPos[12][ 7][0] = 0.01f;     font_bitPos[12][ 7][1] = 0.01f;
    font_bitPos[12][ 8][0] = 0.02f;     font_bitPos[12][ 8][1] =-0.02f;
    font_bitPos[12][ 9][0] = 0.02f;     font_bitPos[12][ 9][1] =-0.01f;
    font_bitPos[12][10][0] = 0.02f;     font_bitPos[12][10][1] = 0.00f;
    font_bitPos[12][11][0] = 0.02f;     font_bitPos[12][11][1] = 0.01f;
    font_bitPos[12][12][0] = 0.02f;     font_bitPos[12][12][1] = 0.02f;
    
    // N
    font_bitNum[13] = 13;

    font_bitPos[13][ 0][0] =-0.02f;     font_bitPos[13][ 0][1] =-0.02f;
    font_bitPos[13][ 1][0] =-0.02f;     font_bitPos[13][ 1][1] =-0.01f;
    font_bitPos[13][ 2][0] =-0.02f;     font_bitPos[13][ 2][1] = 0.00f;
    font_bitPos[13][ 3][0] =-0.02f;     font_bitPos[13][ 3][1] = 0.01f;
    font_bitPos[13][ 4][0] =-0.02f;     font_bitPos[13][ 4][1] = 0.02f;
    font_bitPos[13][ 5][0] =-0.01f;     font_bitPos[13][ 5][1] = 0.01f;
    font_bitPos[13][ 6][0] = 0.00f;     font_bitPos[13][ 6][1] = 0.00f;
    font_bitPos[13][ 7][0] = 0.01f;     font_bitPos[13][ 7][1] =-0.01f;
    font_bitPos[13][ 8][0] = 0.02f;     font_bitPos[13][ 8][1] =-0.02f;
    font_bitPos[13][ 9][0] = 0.02f;     font_bitPos[13][ 9][1] =-0.01f;
    font_bitPos[13][10][0] = 0.02f;     font_bitPos[13][10][1] = 0.00f;
    font_bitPos[13][11][0] = 0.02f;     font_bitPos[13][11][1] = 0.01f;
    font_bitPos[13][12][0] = 0.02f;     font_bitPos[13][12][1] = 0.02f;
    
    
    // O
    font_bitNum[14] = 12;
    
    font_bitPos[14][ 0][0] =-0.02f;     font_bitPos[14][ 0][1] =-0.01f;
    font_bitPos[14][ 1][0] =-0.02f;     font_bitPos[14][ 1][1] = 0.00f;
    font_bitPos[14][ 2][0] =-0.02f;     font_bitPos[14][ 2][1] = 0.01f;
    font_bitPos[14][ 3][0] =-0.01f;     font_bitPos[14][ 3][1] =-0.02f;
    font_bitPos[14][ 4][0] =-0.01f;     font_bitPos[14][ 4][1] = 0.02f;
    font_bitPos[14][ 5][0] = 0.00f;     font_bitPos[14][ 5][1] =-0.02f;
    font_bitPos[14][ 6][0] = 0.00f;     font_bitPos[14][ 6][1] = 0.02f;
    font_bitPos[14][ 7][0] = 0.01f;     font_bitPos[14][ 7][1] =-0.02f;
    font_bitPos[14][ 8][0] = 0.01f;     font_bitPos[14][ 8][1] = 0.02f;
    font_bitPos[14][ 9][0] = 0.02f;     font_bitPos[14][ 9][1] =-0.01f;
    font_bitPos[14][10][0] = 0.02f;     font_bitPos[14][10][1] = 0.00f;
    font_bitPos[14][11][0] = 0.02f;     font_bitPos[14][11][1] = 0.01f;
    
    // P
    font_bitNum[15] = 13;
    
    font_bitPos[15][ 0][0] =-0.02f;     font_bitPos[15][ 0][1] =-0.02f;
    font_bitPos[15][ 1][0] =-0.02f;     font_bitPos[15][ 1][1] =-0.01f;
    font_bitPos[15][ 2][0] =-0.02f;     font_bitPos[15][ 2][1] = 0.00f;
    font_bitPos[15][ 3][0] =-0.02f;     font_bitPos[15][ 3][1] = 0.01f;
    font_bitPos[15][ 4][0] =-0.02f;     font_bitPos[15][ 4][1] = 0.02f;
    font_bitPos[15][ 5][0] =-0.01f;     font_bitPos[15][ 5][1] = 0.00f;
    font_bitPos[15][ 6][0] =-0.01f;     font_bitPos[15][ 6][1] = 0.02f;
    font_bitPos[15][ 7][0] = 0.00f;     font_bitPos[15][ 7][1] = 0.00f;
    font_bitPos[15][ 8][0] = 0.00f;     font_bitPos[15][ 8][1] = 0.02f;
    font_bitPos[15][ 9][0] = 0.01f;     font_bitPos[15][ 9][1] = 0.00f;
    font_bitPos[15][10][0] = 0.01f;     font_bitPos[15][10][1] = 0.02f;
    font_bitPos[15][11][0] = 0.02f;     font_bitPos[15][11][1] = 0.015f;
    font_bitPos[15][12][0] = 0.02f;     font_bitPos[15][12][1] = 0.005f;
    
    // Q
    font_bitNum[16] = 14;

    font_bitPos[16][ 0][0] =-0.02f;     font_bitPos[16][ 0][1] =-0.01f;
    font_bitPos[16][ 1][0] =-0.02f;     font_bitPos[16][ 1][1] = 0.00f;
    font_bitPos[16][ 2][0] =-0.02f;     font_bitPos[16][ 2][1] = 0.01f;
    font_bitPos[16][ 3][0] =-0.01f;     font_bitPos[16][ 3][1] =-0.02f;
    font_bitPos[16][ 4][0] =-0.01f;     font_bitPos[16][ 4][1] = 0.02f;
    font_bitPos[16][ 5][0] = 0.00f;     font_bitPos[16][ 5][1] =-0.02f;
    font_bitPos[16][ 6][0] = 0.00f;     font_bitPos[16][ 6][1] = 0.02f;
    font_bitPos[16][ 7][0] = 0.01f;     font_bitPos[16][ 7][1] =-0.03f;
    font_bitPos[16][ 8][0] = 0.01f;     font_bitPos[16][ 8][1] =-0.02f;
    font_bitPos[16][ 9][0] = 0.01f;     font_bitPos[16][ 9][1] = 0.02f;
    font_bitPos[16][10][0] = 0.02f;     font_bitPos[16][10][1] =-0.03f;
    font_bitPos[16][11][0] = 0.02f;     font_bitPos[16][11][1] =-0.01f;
    font_bitPos[16][12][0] = 0.02f;     font_bitPos[16][12][1] = 0.00f;
    font_bitPos[16][13][0] = 0.02f;     font_bitPos[16][13][1] = 0.01f;
    
    // R
    font_bitNum[17] = 15;

    font_bitPos[17][ 0][0] =-0.02f;     font_bitPos[17][ 0][1] =-0.02f;
    font_bitPos[17][ 1][0] =-0.02f;     font_bitPos[17][ 1][1] =-0.01f;
    font_bitPos[17][ 2][0] =-0.02f;     font_bitPos[17][ 2][1] = 0.00f;
    font_bitPos[17][ 3][0] =-0.02f;     font_bitPos[17][ 3][1] = 0.01f;
    font_bitPos[17][ 4][0] =-0.02f;     font_bitPos[17][ 4][1] = 0.02f;
    font_bitPos[17][ 5][0] =-0.01f;     font_bitPos[17][ 5][1] = 0.00f;
    font_bitPos[17][ 6][0] =-0.01f;     font_bitPos[17][ 6][1] = 0.02f;
    font_bitPos[17][ 7][0] = 0.00f;     font_bitPos[17][ 7][1] = 0.00f;
    font_bitPos[17][ 8][0] = 0.00f;     font_bitPos[17][ 8][1] = 0.02f;
    font_bitPos[17][ 9][0] = 0.01f;     font_bitPos[17][ 9][1] =-0.01f;
    font_bitPos[17][10][0] = 0.01f;     font_bitPos[17][10][1] = 0.00f;
    font_bitPos[17][11][0] = 0.01f;     font_bitPos[17][11][1] = 0.02f;
    font_bitPos[17][12][0] = 0.02f;     font_bitPos[17][12][1] =-0.02f;
    font_bitPos[17][13][0] = 0.02f;     font_bitPos[17][13][1] = 0.005f;
    font_bitPos[17][14][0] = 0.02f;     font_bitPos[17][14][1] = 0.015f;
    
    // S
    font_bitNum[18] = 15;

    font_bitPos[18][ 0][0] = -0.02f;     font_bitPos[18][ 0][1] = -0.02f;
    font_bitPos[18][ 1][0] = -0.02f;     font_bitPos[18][ 1][1] = 0.005f;
    font_bitPos[18][ 2][0] = -0.02f;     font_bitPos[18][ 2][1] = 0.015f;
    font_bitPos[18][ 3][0] = -0.01f;     font_bitPos[18][ 3][1] = -0.02f;
    font_bitPos[18][ 4][0] = -0.01f;     font_bitPos[18][ 4][1] = 0.0f;
    font_bitPos[18][ 5][0] = -0.01f;     font_bitPos[18][ 5][1] = 0.02f;
    font_bitPos[18][ 6][0] = 0.0f;       font_bitPos[18][ 6][1] = -0.02f;
    font_bitPos[18][ 7][0] = 0.0f;       font_bitPos[18][ 7][1] = 0.0f;
    font_bitPos[18][ 8][0] = 0.0f;       font_bitPos[18][ 8][1] = 0.02f;
    font_bitPos[18][ 9][0] = 0.01f;      font_bitPos[18][ 9][1] = -0.02f;
    font_bitPos[18][10][0] = 0.01f;      font_bitPos[18][10][1] = 0.0f;
    font_bitPos[18][11][0] = 0.01f;      font_bitPos[18][11][1] = 0.02f;
    font_bitPos[18][12][0] = 0.02f;      font_bitPos[18][12][1] = -0.015f;
    font_bitPos[18][13][0] = 0.02f;      font_bitPos[18][13][1] = -0.005f;
    font_bitPos[18][14][0] = 0.02f;      font_bitPos[18][14][1] = 0.02f;
    
    // T
    font_bitNum[19] = 9;
    
    font_bitPos[19][ 0][0] =-0.02f;     font_bitPos[19][ 0][1] = 0.02f;
    font_bitPos[19][ 1][0] =-0.01f;     font_bitPos[19][ 1][1] = 0.02f;
    font_bitPos[19][ 2][0] = 0.00f;     font_bitPos[19][ 2][1] =-0.02f;
    font_bitPos[19][ 3][0] = 0.00f;     font_bitPos[19][ 3][1] =-0.01f;
    font_bitPos[19][ 4][0] = 0.00f;     font_bitPos[19][ 4][1] = 0.00f;
    font_bitPos[19][ 5][0] = 0.00f;     font_bitPos[19][ 5][1] = 0.01f;
    font_bitPos[19][ 6][0] = 0.00f;     font_bitPos[19][ 6][1] = 0.02f;
    font_bitPos[19][ 7][0] = 0.01f;     font_bitPos[19][ 7][1] = 0.02f;
    font_bitPos[19][ 8][0] = 0.02f;     font_bitPos[19][ 8][1] = 0.02f;
    
    // U
    font_bitNum[20] = 11;

    font_bitPos[20][ 0][0] =-0.02f;     font_bitPos[20][ 0][1] =-0.01f;
    font_bitPos[20][ 1][0] =-0.02f;     font_bitPos[20][ 1][1] = 0.00f;
    font_bitPos[20][ 2][0] =-0.02f;     font_bitPos[20][ 2][1] = 0.01f;
    font_bitPos[20][ 3][0] =-0.02f;     font_bitPos[20][ 3][1] = 0.02f;
    font_bitPos[20][ 4][0] =-0.01f;     font_bitPos[20][ 4][1] =-0.02f;
    font_bitPos[20][ 5][0] = 0.00f;     font_bitPos[20][ 5][1] =-0.02f;
    font_bitPos[20][ 6][0] = 0.01f;     font_bitPos[20][ 6][1] =-0.02f;
    font_bitPos[20][ 7][0] = 0.02f;     font_bitPos[20][ 7][1] =-0.01f;
    font_bitPos[20][ 8][0] = 0.02f;     font_bitPos[20][ 8][1] = 0.00f;
    font_bitPos[20][ 9][0] = 0.02f;     font_bitPos[20][ 9][1] = 0.01f;
    font_bitPos[20][10][0] = 0.02f;     font_bitPos[20][10][1] = 0.02f;
    
    // V
    font_bitNum[21] = 9;
    
    font_bitPos[21][ 0][0] =-0.02f;     font_bitPos[21][ 0][1] = 0.00f;
    font_bitPos[21][ 1][0] =-0.02f;     font_bitPos[21][ 1][1] = 0.01f;
    font_bitPos[21][ 2][0] =-0.02f;     font_bitPos[21][ 2][1] = 0.02f;
    font_bitPos[21][ 3][0] =-0.01f;     font_bitPos[21][ 3][1] =-0.01f;
    font_bitPos[21][ 4][0] = 0.00f;     font_bitPos[21][ 4][1] =-0.02f;
    font_bitPos[21][ 5][0] = 0.01f;     font_bitPos[21][ 5][1] =-0.01f;
    font_bitPos[21][ 6][0] = 0.02f;     font_bitPos[21][ 6][1] = 0.00f;
    font_bitPos[21][ 7][0] = 0.02f;     font_bitPos[21][ 7][1] = 0.01f;
    font_bitPos[21][ 8][0] = 0.02f;     font_bitPos[21][ 8][1] = 0.02f;
    
    // W
    font_bitNum[22] = 14;
    
    font_bitPos[22][ 0][0] =-0.02f;     font_bitPos[22][ 0][1] =-0.01f;
    font_bitPos[22][ 1][0] =-0.02f;     font_bitPos[22][ 1][1] = 0.00f;
    font_bitPos[22][ 2][0] =-0.02f;     font_bitPos[22][ 2][1] = 0.01f;
    font_bitPos[22][ 3][0] =-0.02f;     font_bitPos[22][ 3][1] = 0.02f;
    font_bitPos[22][ 4][0] =-0.01f;     font_bitPos[22][ 4][1] =-0.02f;
    font_bitPos[22][ 5][0] = 0.00f;     font_bitPos[22][ 5][1] =-0.01f;
    font_bitPos[22][ 6][0] = 0.00f;     font_bitPos[22][ 6][1] = 0.00f;
    font_bitPos[22][ 7][0] = 0.00f;     font_bitPos[22][ 7][1] = 0.01f;
    font_bitPos[22][ 8][0] = 0.00f;     font_bitPos[22][ 8][1] = 0.02f;
    font_bitPos[22][ 9][0] = 0.01f;     font_bitPos[22][ 9][1] =-0.02f;
    font_bitPos[22][10][0] = 0.02f;     font_bitPos[22][10][1] =-0.01f;
    font_bitPos[22][11][0] = 0.02f;     font_bitPos[22][11][1] = 0.00f;
    font_bitPos[22][12][0] = 0.02f;     font_bitPos[22][12][1] = 0.01f;
    font_bitPos[22][13][0] = 0.02f;     font_bitPos[22][13][1] = 0.02f;
    
    // X
    font_bitNum[23] = 9;
    
    font_bitPos[23][ 0][0] =-0.02f;     font_bitPos[23][ 0][1] =-0.02f;
    font_bitPos[23][ 1][0] =-0.02f;     font_bitPos[23][ 1][1] = 0.02f;
    font_bitPos[23][ 2][0] =-0.01f;     font_bitPos[23][ 2][1] =-0.01f;
    font_bitPos[23][ 3][0] =-0.01f;     font_bitPos[23][ 3][1] = 0.01f;
    font_bitPos[23][ 4][0] = 0.00f;     font_bitPos[23][ 4][1] = 0.00f;
    font_bitPos[23][ 5][0] = 0.01f;     font_bitPos[23][ 5][1] =-0.01f;
    font_bitPos[23][ 6][0] = 0.01f;     font_bitPos[23][ 6][1] = 0.01f;
    font_bitPos[23][ 7][0] = 0.02f;     font_bitPos[23][ 7][1] =-0.02f;
    font_bitPos[23][ 8][0] = 0.02f;     font_bitPos[23][ 8][1] = 0.02f;
    
    // Y
    font_bitNum[24] = 7;

    font_bitPos[24][ 0][0] =-0.02f;     font_bitPos[24][ 0][1] = 0.02f;
    font_bitPos[24][ 1][0] =-0.01f;     font_bitPos[24][ 1][1] = 0.01f;
    font_bitPos[24][ 2][0] = 0.00f;     font_bitPos[24][ 2][1] =-0.02f;
    font_bitPos[24][ 3][0] = 0.00f;     font_bitPos[24][ 3][1] =-0.01f;
    font_bitPos[24][ 4][0] = 0.00f;     font_bitPos[24][ 4][1] = 0.00f;
    font_bitPos[24][ 5][0] = 0.01f;     font_bitPos[24][ 5][1] = 0.01f;
    font_bitPos[24][ 6][0] = 0.02f;     font_bitPos[24][ 6][1] = 0.02f;
    
    // Z
    font_bitNum[25] = 13;
    
    font_bitPos[25][ 0][0] =-0.02f;     font_bitPos[25][ 0][1] =-0.02f;
    font_bitPos[25][ 1][0] =-0.02f;     font_bitPos[25][ 1][1] = 0.02f;
    font_bitPos[25][ 2][0] =-0.01f;     font_bitPos[25][ 2][1] =-0.02f;
    font_bitPos[25][ 3][0] =-0.01f;     font_bitPos[25][ 3][1] =-0.01f;
    font_bitPos[25][ 4][0] =-0.01f;     font_bitPos[25][ 4][1] = 0.02f;
    font_bitPos[25][ 5][0] = 0.00f;     font_bitPos[25][ 5][1] =-0.02f;
    font_bitPos[25][ 6][0] = 0.00f;     font_bitPos[25][ 6][1] = 0.00f;
    font_bitPos[25][ 7][0] = 0.00f;     font_bitPos[25][ 7][1] = 0.02f;
    font_bitPos[25][ 8][0] = 0.01f;     font_bitPos[25][ 8][1] =-0.02f;
    font_bitPos[25][ 9][0] = 0.01f;     font_bitPos[25][ 9][1] = 0.01f;
    font_bitPos[25][10][0] = 0.01f;     font_bitPos[25][10][1] = 0.02f;
    font_bitPos[25][11][0] = 0.02f;     font_bitPos[25][11][1] =-0.02f;
    font_bitPos[25][12][0] = 0.02f;     font_bitPos[25][12][1] = 0.02f;

}

@end