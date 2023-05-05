
#import "M04_Kaleidoscope.h"

@implementation M04_Kaleidoscope ( DRAW_PIECE )

- (void)draw_piece
{
    int i, j;
    
    
     // :::::: Piece 0 & 1
    GLfloat boxFront[4][4];
    
    boxFront[0][0] = -0.5f; boxFront[0][1] = 0.5f;   boxFront[0][2] = 0.5f;  boxFront[0][3] = 1.0f;
    boxFront[1][0] = -0.5f; boxFront[1][1] = -0.5f;  boxFront[1][2] = 0.5f;  boxFront[1][3] = 1.0f;
    boxFront[2][0] = 0.5f;  boxFront[2][1] = 0.5f;   boxFront[2][2] = 0.5f;  boxFront[2][3] = 1.0f;
    boxFront[3][0] = 0.5f;  boxFront[3][1] = -0.5f;  boxFront[3][2] = 0.5f;  boxFront[3][3] = 1.0f;

    
    
    
    // culcurate rotate box vertex
    for( i = 0 ; i < 2 ; i++ )
    {
        GLfloat Alpha = sqrtf( fabsf( sinf(piece_rad_1[i]) ) );
        GLfloat boxCulc[4][4];
        
        for( j = 0 ; j < 4 ; j++ )
        {
            for( int k = 0 ; k < 4 ; k++ )
            {
                boxCulc[j][k] = boxFront[j][k];
            }
        }
        
        [self initMatrix];
        [self rotate_Xdeg:sinf(piece_rad_2[i])*180.0f];
        [self rotate_Ydeg:cosf(piece_rad_1[i])*180.0f];
        [self rotate_Zdeg:cosf(piece_rad_2[i])*180.0f];
        [self translate_x:piece_Center[i][0] y:piece_Center[i][1] z:0.0f];

    
        for(j = 0 ; j < 4 ; j++ )
        {
            [self culculate_vec4:&boxCulc[j][0]];
        }
        
        // vertex
        for(j = 0 ; j < 4 ; j++)
        {
            pieceVertex[i][0][j] = pieceVertex[i][1][j] = boxCulc[0][j];
            pieceVertex[i][2][j] = boxCulc[1][j];
            pieceVertex[i][3][j] = boxCulc[2][j];
            pieceVertex[i][4][j] = pieceVertex[i][5][j] = boxCulc[3][j];
            
        }
        
        // color
        for( j = 0 ; j < 6 ; j++ )
        {
            pieceColor[i][j][0] = COLOR[piece_color_index[i]][0];
            pieceColor[i][j][1] = COLOR[piece_color_index[i]][1];
            pieceColor[i][j][2] = COLOR[piece_color_index[i]][2];
            pieceColor[i][j][3] = Alpha;
        }
        
        // texcoord
        pieceTexCoord[i][0][0] = pieceTexCoord[i][1][0] = texCoord_index_set[ piece_texcoord_index[i] ][0][0];
        pieceTexCoord[i][0][1] = pieceTexCoord[i][1][1] = texCoord_index_set[ piece_texcoord_index[i] ][0][1];
        
        pieceTexCoord[i][2][0] = texCoord_index_set[ piece_texcoord_index[i] ][1][0];
        pieceTexCoord[i][2][1] = texCoord_index_set[ piece_texcoord_index[i] ][1][1];
        
        pieceTexCoord[i][3][0] = texCoord_index_set[ piece_texcoord_index[i] ][2][0];
        pieceTexCoord[i][3][1] = texCoord_index_set[ piece_texcoord_index[i] ][2][1];
        
        pieceTexCoord[i][4][0] = pieceTexCoord[i][5][0] = texCoord_index_set[ piece_texcoord_index[i] ][3][0];
        pieceTexCoord[i][4][1] = pieceTexCoord[i][5][1] = texCoord_index_set[ piece_texcoord_index[i] ][3][1];
        
        if( Alpha < 0.02 )
        {
            piece_Center[i][0] = ( random()%100-50 ) * 0.01f;
            piece_Center[i][1] = ( random()%100-50 ) * 0.01f;
            
            piece_color_index[i] = random()%3;
            
            if(piece_color_index[i] == 2){ piece_texcoord_index[i] = random()%8+8; }
            else{ piece_texcoord_index[i] = random()%8; }
            
            piece_rad_1_inc[i] = (random()%11 + 3)*0.0002;
            piece_rad_2_inc[i] = (random()%11 + 3)*0.0002;
        }
   }   //i
        
        
        
        
        
        
        
        
    
    
    
    
    // Piece 2 & 3
    
    for( i = 0 ; i < 6 ; i++ )
    {
        pieceVertex[2][i][2] = pieceVertex[3][i][2] = 0.0f; //z
        pieceVertex[2][i][3] = pieceVertex[3][i][3] = 1.0f; //w
    }
    
    
    for( i = 2 ; i < 4 ; i++ )
    {
        float size = 0.25f + sinf( piece_rad_2[i] )*0.25f;
        GLfloat Alpha = sqrtf( fabsf( sinf(piece_rad_2[i]) ) );
        
        pieceVertex[i][0][0] = pieceVertex[i][1][0] = piece_Center[i][0] + cosf(piece_rad_1[i]*2.0)*size;
        pieceVertex[i][0][1] = pieceVertex[i][1][1] = piece_Center[i][1] + sinf(piece_rad_1[i]*2.0)*size;
        
        pieceVertex[i][2][0] = piece_Center[i][0] + cosf(piece_rad_1[i]*2.0+M_PI_2)*size;
        pieceVertex[i][2][1] = piece_Center[i][1] + sinf(piece_rad_1[i]*2.0+M_PI_2)*size;
        
        pieceVertex[i][3][0] = piece_Center[i][0] + cosf(piece_rad_1[i]*2.0-M_PI_2)*size;
        pieceVertex[i][3][1] = piece_Center[i][1] + sinf(piece_rad_1[i]*2.0-M_PI_2)*size;
        
        pieceVertex[i][4][0] = pieceVertex[i][5][0] = piece_Center[i][0] + cosf(piece_rad_1[i]*2.0 + M_PI)*size;
        pieceVertex[i][4][1] = pieceVertex[i][5][1] = piece_Center[i][1] + sinf(piece_rad_1[i]*2.0 + M_PI)*size;
    
    
    
        for( j = 0 ; j < 6 ; j++ )
        {
            pieceColor[i][j][0] = COLOR[ piece_color_index[i] ][0];
            pieceColor[i][j][1] = COLOR[ piece_color_index[i] ][1];
            pieceColor[i][j][2] = COLOR[ piece_color_index[i] ][2];
            pieceColor[i][j][3] = Alpha;
        }
        
        
        pieceTexCoord[i][0][0] = pieceTexCoord[i][1][0] = texCoord_index_set[ piece_texcoord_index[i] ][0][0];
        pieceTexCoord[i][0][1] = pieceTexCoord[i][1][1] = texCoord_index_set[ piece_texcoord_index[i] ][0][1];
        
        pieceTexCoord[i][2][0] = texCoord_index_set[ piece_texcoord_index[i] ][1][0];
        pieceTexCoord[i][2][1] = texCoord_index_set[ piece_texcoord_index[i] ][1][1];
        
        pieceTexCoord[i][3][0] = texCoord_index_set[ piece_texcoord_index[i] ][2][0];
        pieceTexCoord[i][3][1] = texCoord_index_set[ piece_texcoord_index[i] ][2][1];
        
        pieceTexCoord[i][4][0] = pieceTexCoord[i][5][0] = texCoord_index_set[ piece_texcoord_index[i] ][3][0];
        pieceTexCoord[i][4][1] = pieceTexCoord[i][5][1] = texCoord_index_set[ piece_texcoord_index[i] ][3][1];
        
        
        if (Alpha < 0.02)
        {
            piece_Center[i][0] = (random()%100-50)*0.01f;
            piece_Center[i][1] = (random()%100-50)*0.01f;
            
            piece_color_index[i] = random()%3;
            
            if( piece_color_index[i] == 2 )
            { piece_texcoord_index[i] = random()%8 + 8;}
            else
            { piece_texcoord_index[i] = random()%8; }
            
            piece_rad_1_inc[i] = (random()%11 + 3)*0.0002;
        }
    } // i 2&3
    
    
    
    
    for( i = 4 ; i < M04_PIECE_NUM ; i++ )
    {
        GLfloat Alpha = sqrtf( fabsf( sinf(piece_rad_2[i]) ) );
        GLfloat zero_to_one = piece_rad_1[i] / (M_PI*2.0f);
        float size = 0.25f + sinf( piece_rad_2[i] )*0.25f;
        GLfloat center[2];
        
        center[0] = piece_Center[i][0]*(1.0f-zero_to_one) + piece_MoveTo[i][0]*zero_to_one;
        center[1] = piece_Center[i][1]*(1.0f-zero_to_one) + piece_MoveTo[i][1]*zero_to_one;
        
        // vertex
        for( j = 0 ; j < 6 ; j++ )
        {
            pieceVertex[i][j][2] = 0.0f;
            pieceVertex[i][j][3] = 1.0f;
        }
        
        pieceVertex[i][0][0] = pieceVertex[i][1][0] = center[0] + cosf(piece_rad_2[i]*2.0)*size;
        pieceVertex[i][0][1] = pieceVertex[i][1][1] = center[1] + sinf(piece_rad_2[i]*2.0)*size;
        
        pieceVertex[i][2][0] = center[0] + cosf(piece_rad_2[i]*2.0 + M_PI_2)*size;
        pieceVertex[i][2][1] = center[1] + sinf(piece_rad_2[i]*2.0 + M_PI_2)*size;
        
        pieceVertex[i][3][0] = center[0] + cosf(piece_rad_2[i]*2.0 - M_PI_2)*size;
        pieceVertex[i][3][1] = center[1] + sinf(piece_rad_2[i]*2.0 - M_PI_2)*size;
        
        pieceVertex[i][4][0] = pieceVertex[i][5][0] = center[0] + cosf(piece_rad_2[i]*2.0 + M_PI)*size;
        pieceVertex[i][4][1] = pieceVertex[i][5][1] = center[1] + sinf(piece_rad_2[i]*2.0 + M_PI)*size;
        
        
        // color
        for( j = 0 ; j < 6 ; j++ )
        {
            pieceColor[i][j][0] = COLOR[ piece_color_index[i] ][0];
            pieceColor[i][j][1] = COLOR[ piece_color_index[i] ][1];
            pieceColor[i][j][2] = COLOR[ piece_color_index[i] ][2];
            pieceColor[i][j][3] = Alpha;
        }
        
        // texcoord
        pieceTexCoord[i][0][0] = pieceTexCoord[i][1][0] = texCoord_index_set[ piece_texcoord_index[i] ][0][0];
        pieceTexCoord[i][0][1] = pieceTexCoord[i][1][1] = texCoord_index_set[ piece_texcoord_index[i] ][0][1];
        
        pieceTexCoord[i][2][0] = texCoord_index_set[ piece_texcoord_index[i] ][1][0];
        pieceTexCoord[i][2][1] = texCoord_index_set[ piece_texcoord_index[i] ][1][1];
        
        pieceTexCoord[i][3][0] = texCoord_index_set[ piece_texcoord_index[i] ][2][0];
        pieceTexCoord[i][3][1] = texCoord_index_set[ piece_texcoord_index[i] ][2][1];
        
        pieceTexCoord[i][4][0] = pieceTexCoord[i][5][0] = texCoord_index_set[ piece_texcoord_index[i] ][3][0];
        pieceTexCoord[i][4][1] = pieceTexCoord[i][5][1] = texCoord_index_set[ piece_texcoord_index[i] ][3][1];
        
        if (Alpha < 0.01)
        {
            piece_Center[i][0] = (random()%100-50)*0.01f;
            piece_Center[i][1] = (random()%100-50)*0.01f;
            
            GLfloat vecX, vecY, distanceWeight;
            vecX = -piece_Center[i][0];
            vecY = -piece_Center[i][1];
            
            distanceWeight = 1.0 / sqrtf(vecX*vecX + vecY*vecY); 
            
            piece_MoveTo[i][0] = piece_Center[i][0] + vecX*distanceWeight;
            piece_MoveTo[i][1] = piece_Center[i][1] + vecY*distanceWeight;
            piece_color_index[i] = random()%3;
            
            if( piece_color_index[i] == 2 )
            { piece_texcoord_index[i] = random()%8 + 8;}
            else
            { piece_texcoord_index[i] = random()%8; }
            
            piece_rad_1_inc[i] = (random()%11 + 3)*0.0002;
        }
}
    
    
}

@end