//
//  M04_Kaleidoscope.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M04_Kaleidoscope.h"


@implementation M04_Kaleidoscope

- (id)initWithDeviceName:(NSString*)deviceName
{
    self = [super init];
    
    if( [deviceName isEqualToString:@"iPad"] )
    {
        RESOLUTION = 512;
        iPad_model_No = 1;
    }
    else if( [deviceName isEqualToString:@"iPad2"] )
    {
        RESOLUTION = 1024;
        iPad_model_No = 2;
    }
    
    // module info
    moduleName = [[NSString alloc] initWithString:@"04_Kaleidoscope"]; //
    moduleIcon = [UIImage imageNamed:@"M04_Kaleidoscope"]; //
    
    // load nib file
    [[NSBundle mainBundle] loadNibNamed:@"M04_Kaleidoscope" owner:self options:nil];//
    
    // Num of Setting pages
    Num_Of_Pages = 1; //
    segmentPageTitle_ARRAY = [[NSMutableArray alloc] init];
    viewForSegment_ARRAY = [[NSMutableArray alloc] init];
    
    // set segment page title
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Module Info"]];//
    
    // set view for segmnet
    [viewForSegment_ARRAY addObject:view_0];
    
    [self initValues];
    [self initGUI];
    
    return self;
    
}


- (void)initValues
{
    int i, j;
    
    GLfloat boardGrid[11][11][2];
    GLfloat boardColor[11][11][4];
    GLfloat boardTexcoord[11][11][2];
    
    fovy_angle = 90.0f;
    act_fovy_angle = 80.0f;
    
    for(i = 0 ; i < 11 ; i++ )
    {
        for( j = 0 ; j < 11 ; j++ )
        {
            GLfloat X = (j-5)*0.6;
            GLfloat Y = (5-i)*0.6;
            boardGrid[i][j][0] = X;
            boardGrid[i][j][1] = Y;
            
            boardTexcoord[i][j][0] = j*0.1f;
            boardTexcoord[i][j][1] = i*0.1f;
            
            GLfloat alphaX = (j-5)*0.2;
            GLfloat alphaY = (5-i)*0.2;
            float distance = sqrtf(alphaX*alphaX + alphaY*alphaY);
            distance = 1.0 - distance;
            
            boardColor[i][j][0] = 0.2f;
            boardColor[i][j][1] = 0.2f;
            boardColor[i][j][2] = 0.2f;
            boardColor[i][j][3] = distance*0.3;
        }
    }
    
    for( i = 0 ; i < 10 ; i++ )
    {
        for( j = 0 ; j < 11 ; j++ )
        {
            short index = j*2 + 1;
            // vertex
            FBO_board_vertex[i][index][0] = boardGrid[i][j][0];
            FBO_board_vertex[i][index][1] = boardGrid[i][j][1];
            FBO_board_vertex[i][index][2] = -1.0f;
            FBO_board_vertex[i][index][3] = 1.0f;
            
            FBO_board_vertex[i][index+1][0] = boardGrid[i+1][j][0];
            FBO_board_vertex[i][index+1][1] = boardGrid[i+1][j][1];
            FBO_board_vertex[i][index+1][2] = -1.0f;
            FBO_board_vertex[i][index+1][3] = 1.0f;
            // color
            FBO_board_color[i][index][0] = boardColor[i][j][0];
            FBO_board_color[i][index][1] = boardColor[i][j][1];
            FBO_board_color[i][index][2] = boardColor[i][j][2];
            FBO_board_color[i][index][3] = boardColor[i][j][3];
            
            FBO_board_color[i][index+1][0] = boardColor[i+1][j][0];
            FBO_board_color[i][index+1][1] = boardColor[i+1][j][1];
            FBO_board_color[i][index+1][2] = boardColor[i+1][j][2];
            FBO_board_color[i][index+1][3] = boardColor[i+1][j][3];
            // texcoord
            FBO_board_texcoord[i][index][0] = boardTexcoord[i][j][0];
            FBO_board_texcoord[i][index][1] = boardTexcoord[i][j][1];
            
            FBO_board_texcoord[i][index+1][0] = boardTexcoord[i+1][j][0];
            FBO_board_texcoord[i][index+1][1] = boardTexcoord[i+1][j][1];
        }
        
        FBO_board_vertex[i][0][0] = FBO_board_vertex[i][1][0];
        FBO_board_vertex[i][0][1] = FBO_board_vertex[i][1][1];
        FBO_board_vertex[i][0][2] = FBO_board_vertex[i][1][2];
        FBO_board_vertex[i][0][3] = FBO_board_vertex[i][1][3];
        FBO_board_vertex[i][23][0] = FBO_board_vertex[i][22][0];
        FBO_board_vertex[i][23][1] = FBO_board_vertex[i][22][1];
        FBO_board_vertex[i][23][2] = FBO_board_vertex[i][22][2];
        FBO_board_vertex[i][23][3] = FBO_board_vertex[i][22][3];
        
        FBO_board_color[i][0][0] = FBO_board_color[i][1][0];
        FBO_board_color[i][0][1] = FBO_board_color[i][1][1];
        FBO_board_color[i][0][2] = FBO_board_color[i][1][2];
        FBO_board_color[i][0][3] = FBO_board_color[i][1][3];
        FBO_board_color[i][23][0] = FBO_board_color[i][22][0];
        FBO_board_color[i][23][1] = FBO_board_color[i][22][1];
        FBO_board_color[i][23][2] = FBO_board_color[i][22][2];
        FBO_board_color[i][23][3] = FBO_board_color[i][22][3];
        
        FBO_board_texcoord[i][0][0] = FBO_board_texcoord[i][1][0];
        FBO_board_texcoord[i][0][1] = FBO_board_texcoord[i][1][1];
        FBO_board_texcoord[i][23][0] = FBO_board_texcoord[i][22][0];
        FBO_board_texcoord[i][23][1] = FBO_board_texcoord[i][22][1];
    }
    
    
    Hue_Counter = 0.0f;
    COLOR[0][0] = COLOR[0][1] = COLOR[0][2] = 0.0f;
    COLOR[1][0] = COLOR[1][1] = COLOR[1][2] = 0.0f;
    COLOR[2][0] = COLOR[2][1] = COLOR[2][2] = 0.0f;
    
    
    for( i = 0 ; i < M04_PIECE_NUM ; i++ )
    {
        piece_Center[i][0] = (random()%100-50)*0.01f;
        piece_Center[i][1] = (random()%100-50)*0.01f;
        
        GLfloat vecX, vecY, distanceWeight;
        vecX = -piece_Center[i][0];
        vecY = -piece_Center[i][1];
        
        distanceWeight = 1.0 / sqrtf(vecX*vecX + vecY*vecY); 
        
        piece_MoveTo[i][0] = piece_Center[i][0] + vecX*distanceWeight;
        piece_MoveTo[i][1] = piece_Center[i][1] + vecY*distanceWeight;
        
        piece_rad_1[i] = 0.0f;
        piece_rad_2[i] = 0.0f;
        
        piece_rad_1_inc[i] = (random()%11 + 3)*0.0004;
        piece_rad_2_inc[i] = (random()%11 + 3)*0.0004;
        
        piece_color_index[i] = random()%3;
        
        if( piece_color_index[i] == 2 )
        {
            piece_texcoord_index[i] = random()%8+8;
        }
        else
        {
            piece_texcoord_index[i] = random()%8;
        }
        
        for(j = 0 ; j < 6 ; j++ )
        {
            pieceVertex[i][j][0] = 0.0f;
            pieceVertex[i][j][1] = 0.0f;
            pieceVertex[i][j][2] = 0.0f;
            pieceVertex[i][j][3] = 1.0f;
            
            pieceColor[i][j][0] = 0.0f;
            pieceColor[i][j][1] = 0.0f;
            pieceColor[i][j][2] = 0.0f;
            pieceColor[i][j][3] = 0.0f;
            
            pieceTexCoord[i][j][0] = 0.0f;
            pieceTexCoord[i][j][1] = 0.0f;
        }
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        for( j = 0 ; j < 4 ; j++ )
        {
            short INDEX = i*4 + j;
            
            texCoord_index_set[INDEX][0][0] = j*0.25+0.01;   texCoord_index_set[INDEX][0][1] = i*0.25+0.01;
            texCoord_index_set[INDEX][1][0] = j*0.25+0.01;   texCoord_index_set[INDEX][1][1] = i*0.25+0.24;
            texCoord_index_set[INDEX][2][0] = j*0.25+0.24;   texCoord_index_set[INDEX][2][1] = i*0.25+0.01;
            texCoord_index_set[INDEX][3][0] = j*0.25+0.24;   texCoord_index_set[INDEX][3][1] = i*0.25+0.24;
        }
    }
    
    
    // tap drawing
    TAP_COUNTER = 0;
    for(i = 0 ; i < M04_TAP_NUM ; i++ )
    {
        tapCenter[i][0] = 0.0f;
        tapCenter[i][1] = 0.0f;
        tapCenter[i][2] = 0.0f;
        
        tapCenter_Vel[i][0] = 0.0f;
        tapCenter_Vel[i][1] = 0.0f;
        tapCenter_Vel[i][2] = 0.0f;
    }
    
    
    
    // 0 - 5
    float tapSize = 0.075;
    
    for( i = 0 ; i < 6 ; i++ )
    {
        tapVertex_Base[i][0][0] = 0.0f;                                 tapVertex_Base[i][0][1] = 0.0f;
        tapVertex_Base[i][1][0] = cosf(i*60.0*0.0174532925)*tapSize;        tapVertex_Base[i][1][1] = sinf(i*60.0*0.0174532925)*tapSize;
        tapVertex_Base[i][2][0] = cosf((i+1)*60.0*0.0174532925)*tapSize;    tapVertex_Base[i][2][1] = sinf((i+1)*60.0*0.0174532925)*tapSize;
    }
    
    // 6 - 23
    for( i = 0 ; i < 6 ; i++ )
    {
        float radian_1 = i*60.0f*0.0174532925;
        float centerX, centerY;
        
        centerX = cosf(radian_1)*tapSize;
        centerY = sinf(radian_1)*tapSize;
        
        for( j = 0 ; j < 3 ; j++ )
        {
            int INDEX = (i*3 + j)+6;
            
            float radian_2 = (radian_1 - 60.0f*0.0174532925) + (j*60.0f*0.0174532925);
            
            tapVertex_Base[INDEX][0][0] = centerX;
            tapVertex_Base[INDEX][0][1] = centerY;
            
            tapVertex_Base[INDEX][1][0] = centerX + cosf(radian_2)*tapSize;
            tapVertex_Base[INDEX][1][1] = centerY + sinf(radian_2)*tapSize;

            tapVertex_Base[INDEX][2][0] = centerX + cosf(radian_2+60.0f*0.0174532925)*tapSize;
            tapVertex_Base[INDEX][2][1] = centerY + sinf(radian_2+60.0f*0.0174532925)*tapSize;
        }
    }
    
    // 24 - 47
    for( i = 0 ; i < 6 ; i++ )
    {
        float radian_1 = i*60.0f*0.0174532925;
        
        GLfloat centerX = cosf(radian_1)*tapSize*2.0;
        GLfloat centerY = sinf(radian_1)*tapSize*2.0;
        
        for( j = 0 ; j < 4 ; j++ )
        {
            int INDEX = (i*4 + j) + 24;
            
            float radian_2 = ( radian_1 - 120.0f*0.0174532925 ) + ( j*60.0f*0.0174532925 );
            
            tapVertex_Base[INDEX][0][0] = centerX;
            tapVertex_Base[INDEX][0][1] = centerY;
            
            tapVertex_Base[INDEX][1][0] = centerX + cosf(radian_2)*tapSize;
            tapVertex_Base[INDEX][1][1] = centerY + sinf(radian_2)*tapSize;
            
            tapVertex_Base[INDEX][2][0] = centerX + cosf(radian_2+60.0f*0.0174532925)*tapSize;
            tapVertex_Base[INDEX][2][1] = centerY + sinf(radian_2+60.0f*0.0174532925)*tapSize;
        }
    }
    
    
    // 48 - 53
    for( i = 0 ; i < 6 ; i++ )
    {
        float radian_1 = (i*60.0f + 30.0)*0.0174532925;
        
        GLfloat centerX = cosf(radian_1)*sqrt(3.0)*tapSize;
        GLfloat centerY = sinf(radian_1)*sqrt(3.0)*tapSize;
        
        int INDEX = 48+i;
        
        tapVertex_Base[INDEX][0][0] = centerX;
        tapVertex_Base[INDEX][0][1] = centerY;
        
        tapVertex_Base[INDEX][1][0] = centerX + cosf(radian_1 - 30.0f*0.0174532925)*tapSize;
        tapVertex_Base[INDEX][1][1] = centerY + sinf(radian_1 - 30.0f*0.0174532925)*tapSize;
        
        tapVertex_Base[INDEX][2][0] = centerX + cosf(radian_1 + 30.0f*0.0174532925)*tapSize;
        tapVertex_Base[INDEX][2][1] = centerY + sinf(radian_1 + 30.0f*0.0174532925)*tapSize;
    }

    // texcoord base
    
    // 0-5
    for( i = 0 ; i < 6 ; i++ )
    {
        tapTexcoord_BaseINDEX[i][0] = 0;
        
        switch (i%2)
        {
            case 0:
                tapTexcoord_BaseINDEX[i][1] = 1;
                tapTexcoord_BaseINDEX[i][2] = 2;
                break;
            case 1:
                tapTexcoord_BaseINDEX[i][1] = 2;
                tapTexcoord_BaseINDEX[i][2] = 1;
                break;
        }
    }
    
    // 6 - 23
    for( i = 0 ; i < 6 ; i++ )
    {
        int center_INDEX = i%2 + 1;
        int alternative_INDEX;
        
        if( center_INDEX == 1 )
        {
            alternative_INDEX = 2;
        }
        else
        {
            alternative_INDEX = 1;
        }
        
        for( j = 0 ; j < 3 ; j++ )
        {
            int INDEX = (i*3 + j)+6;
            
            tapTexcoord_BaseINDEX[INDEX][0] = center_INDEX;
            
            switch ( j%2 )
            {
                case 0:
                    tapTexcoord_BaseINDEX[INDEX][1] = 0;
                    tapTexcoord_BaseINDEX[INDEX][2] = alternative_INDEX;
                    break;
                case 1:
                    tapTexcoord_BaseINDEX[INDEX][1] = alternative_INDEX;
                    tapTexcoord_BaseINDEX[INDEX][2] = 0;
                    break;
            }
        }
    }
    
    
    // 24 - 47
    for( i = 0 ; i < 6 ; i++ )
    {
        int center_INDEX;
        int alternative_INDEX;
        
        switch ( i%2 )
        {
            case 0:
                center_INDEX = 2;
                alternative_INDEX = 1;
                break;
            case 1:
                center_INDEX = 1;
                alternative_INDEX = 2;
                break;
        }
        
        for( j = 0 ; j < 4 ; j++ )
        {
            int INDEX = (i*4 + j)+24;
            
            tapTexcoord_BaseINDEX[INDEX][0] = center_INDEX;
            
            switch ( j%2 )
            {
                case 0:
                    tapTexcoord_BaseINDEX[INDEX][1] = 0;
                    tapTexcoord_BaseINDEX[INDEX][2] = alternative_INDEX;
                    break;
                case 1:
                    tapTexcoord_BaseINDEX[INDEX][1] = alternative_INDEX;
                    tapTexcoord_BaseINDEX[INDEX][2] = 0;
                    break;
            }
        }
    }
    
    
    // 48-53
    for( i = 0 ; i < 6 ; i++ )
    {
        int INDEX = 48 + i;
        
        switch (i%2)
        {
            case 0:
                tapTexcoord_BaseINDEX[INDEX][0] = 0;
                tapTexcoord_BaseINDEX[INDEX][1] = 1;
                tapTexcoord_BaseINDEX[INDEX][2] = 2;
                break;
            case 1:
                tapTexcoord_BaseINDEX[INDEX][0] = 0;
                tapTexcoord_BaseINDEX[INDEX][1] = 2;
                tapTexcoord_BaseINDEX[INDEX][2] = 1;
                break;
        }
    }
    
    
    for( i = 0 ; i < 54 ; i++ )
    {
        int INDEX_BASE = i*3;
        
        tapDrawINDEX[i][0] = INDEX_BASE;      tapDrawINDEX[i][1] = INDEX_BASE+1;
        tapDrawINDEX[i][2] = INDEX_BASE+1;    tapDrawINDEX[i][3] = INDEX_BASE+2;
        tapDrawINDEX[i][4] = INDEX_BASE+2;    tapDrawINDEX[i][5] = INDEX_BASE;
    }
    
    
    for( i = 0 ; i < 54 ; i++ )
    {
        tapAlpha_Base[i][0] = tapAlpha_Base[i][1] = tapAlpha_Base[i][2] = 1.0f;
    }
    
    tapAlpha_Base[24][1] = 0.0f;
    tapAlpha_Base[25][1] = tapAlpha_Base[25][2] = 0.0f;
    tapAlpha_Base[26][1] = tapAlpha_Base[26][2] = 0.0f;
    tapAlpha_Base[27][1] = 0.0f;
    tapAlpha_Base[28][1] = 0.0f;
    tapAlpha_Base[29][1] = tapAlpha_Base[29][2] = 0.0f;
    tapAlpha_Base[30][1] = tapAlpha_Base[30][2] = 0.0f;
    tapAlpha_Base[31][1] = 0.0f;
    tapAlpha_Base[32][1] = 0.0f;
    tapAlpha_Base[33][1] = tapAlpha_Base[33][2] = 0.0f;
    tapAlpha_Base[34][1] = tapAlpha_Base[34][2] = 0.0f;
    tapAlpha_Base[35][1] = 0.0f;
    tapAlpha_Base[36][1] = 0.0f;
    tapAlpha_Base[37][1] = tapAlpha_Base[37][2] = 0.0f;
    tapAlpha_Base[38][1] = tapAlpha_Base[38][2] = 0.0f;
    tapAlpha_Base[39][1] = 0.0f;
    tapAlpha_Base[40][1] = 0.0f;
    tapAlpha_Base[41][1] = tapAlpha_Base[41][2] = 0.0f;
    tapAlpha_Base[42][1] = tapAlpha_Base[42][2] = 0.0f;
    tapAlpha_Base[43][1] = 0.0f;
    tapAlpha_Base[44][1] = 0.0f;
    tapAlpha_Base[45][1] = tapAlpha_Base[45][2] = 0.0f;
    tapAlpha_Base[46][1] = tapAlpha_Base[46][2] = 0.0f;
    tapAlpha_Base[47][1] = 0.0f;
   
    tapAlpha_Base[48][1] = tapAlpha_Base[48][2] = 0.0f;
    tapAlpha_Base[49][1] = tapAlpha_Base[49][2] = 0.0f;
    tapAlpha_Base[50][1] = tapAlpha_Base[50][2] = 0.0f;
    tapAlpha_Base[51][1] = tapAlpha_Base[51][2] = 0.0f;
    tapAlpha_Base[52][1] = tapAlpha_Base[52][2] = 0.0f;
    tapAlpha_Base[53][1] = tapAlpha_Base[53][2] = 0.0f;
    
    texScale = 1.0f;
    act_texScale = 1.0f;
    
    for( i = 0 ; i < M04_TAP_NUM ; i++ )
    {
        tapTexCoordShift[i] = (random()%30 - 15)*0.01;
    }
    
    
    
    float tempTexCoord[3][2];
    
    tempTexCoord[0][0] = 0.5 + cosf(M_PI_2)*0.3;
    tempTexCoord[0][1] = 0.5 + sinf(M_PI_2)*0.3;

    tempTexCoord[1][0] = 0.5 + cosf(M_PI_2 + 120.0*0.0174532925)*0.3;
    tempTexCoord[1][1] = 0.5 + sinf(M_PI_2 + 120.0*0.0174532925)*0.3;
    
    tempTexCoord[1][0] = 0.5 + cosf(M_PI_2 + 240.0*0.0174532925)*0.3;
    tempTexCoord[1][1] = 0.5 + sinf(M_PI_2 + 240.0*0.0174532925)*0.3;

    for( i = 0 ; i < 4 ; i++ )
    {
        for( j = 0 ; j < 54 ; j++ )
        {
            
            for( int k = 0 ; k < 3 ; k++ )
            {
                act_LP_Vertex[i][j][k][0] = 0.0f;
                act_LP_Vertex[i][j][k][1] = 0.0f;
                act_LP_Vertex[i][j][k][2] = 0.0f;
                act_LP_Vertex[i][j][k][3] = 1.0f;
                
                for( int l = 0 ; l < 3 ; l++ )
                {
                    act_LP_VStock[l][i][j][k][0] = 0.0f;
                    act_LP_VStock[l][i][j][k][1] = 0.0f;
                    act_LP_VStock[l][i][j][k][2] = 0.0f;
                    act_LP_VStock[l][i][j][k][3] = 1.0f;
                }
                
                
                act_LP_Color[i][j][k][0] = 0.0f;
                act_LP_Color[i][j][k][1] = 0.0f;
                act_LP_Color[i][j][k][2] = 0.0f;
                act_LP_Color[i][j][k][3] = 0.0f;
                
                act_LP_velocity[i][j][k][0] = 0.0f;
                act_LP_velocity[i][j][k][1] = 0.0f;
                act_LP_velocity[i][j][k][2] = 0.0f;
            }
        }
    }
    
    for( i = 0 ; i < 54 ; i++ )
    {
        for( j = 0 ; j < 3 ; j++ )
        {
            LP_TexCoord[i][j][0] = tempTexCoord[ tapTexcoord_BaseINDEX[i][j] ][0];
            LP_TexCoord[i][j][1] = tempTexCoord[ tapTexcoord_BaseINDEX[i][j] ][1];
        }
    }
    
    for(i = 0 ; i < 4 ; i++ )
    {
        act_LP_afterAlpha[i] = 0.0f;
    }


    act_PanF[0] = 0.0f;
    act_PanF[1] = 0.0f;

}

- (void)initGUI
{

}


- (void)moduleDraw:(BOOL)yn FBO:(GLuint *)FBOName
{
    int i, j;
    
    
    // blend mode
    glDisable( GL_DEPTH_TEST );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE );

    
    // draw FBO_Kaleidoscope
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_Kaleidoscope);
    glUseProgram(PRG_FBO_KALEIDO);
    glUniform1i(UNF_patternTexture, 1);
    
    glViewport(0, 0, 128, 128);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear( GL_COLOR_BUFFER_BIT );
    
//  color
    GLfloat Hue_2 = Hue_Counter + 0.5;
   // GLfloat Hue_3 = Hue_Counter + 0.6666;
    
    if( Hue_2 > 1.0f )
    { Hue_2 -= 1.0f; }
   // if( Hue_3 > 1.0f )
   // { Hue_3 -= 1.0f; }
    
    
    UIColor* colorObj = [UIColor colorWithHue:Hue_Counter saturation:1.0 brightness:1.0 alpha:1.0];
    const CGFloat* components = CGColorGetComponents(colorObj.CGColor);
    COLOR[0][0] = *components;  components++;
    COLOR[0][1] = *components;  components++;
    COLOR[0][2] = *components;

    colorObj = [UIColor colorWithHue:Hue_2 saturation:0.75f brightness:1.0f alpha:1.0f];
    components = CGColorGetComponents(colorObj.CGColor);
    COLOR[1][0] = *components;  components++;
    COLOR[1][1] = *components;  components++;
    COLOR[1][2] = *components;
    
    colorObj = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:1.0f];
    components = CGColorGetComponents(colorObj.CGColor);
    COLOR[2][0] = *components;  components++;
    COLOR[2][1] = *components;  components++;
    COLOR[2][2] = *components;
    
    
    
    
// Pan
    act_PanF[0] += ( 0.0f - act_PanF[0] )*0.1;
    act_PanF[1] += ( 0.0f - act_PanF[1] )*0.1;
    
    
    
    
    
    
// **    
    [self draw_piece];
    

if(yn)
{
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, pieceVertex );
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, pieceColor );
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, pieceTexCoord );
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, M04_PIECE_NUM*6);
}   
    
    
// increment
    Hue_Counter += 0.0005;
    if(Hue_Counter > 1.0f)
    { Hue_Counter -= 1.0f; }
    
    for( i = 0 ; i < M04_PIECE_NUM ; i++ )
    {
        piece_rad_1[i] += ( piece_rad_1_inc[i] + tap_accel);
        piece_rad_2[i] += ( piece_rad_2_inc[i] + tap_accel);
        
        if( piece_rad_1[i] > M_PI*2.0f )
        { piece_rad_1[i] -= M_PI*2.0f; }
        if( piece_rad_2[i] > M_PI*2.0f )
        { piece_rad_2[i] -= M_PI*2.0f; }
    }
    
    tap_accel += ( 0.0f - tap_accel )*0.1f;
    
    
    
    
    
    
    
    

    
    // Draw main FBO
    
    [self initMatrix];
    
    [self lookAt_Ex:act_lookingAxis[0]          Ey:act_lookingAxis[1]       Ez:1.0f
                 Vx:act_lookingAxis[0]          Vy:act_lookingAxis[1]       Vz:0.0f
                 Hx:sinf(act_lookingAxis[0])    Hy:cosf(act_lookingAxis[0]) Hz:0.0f];
    
    [self perspective_fovy:act_fovy_angle aspect:1.0f near:0.1f far:3.0f];
    
    
    viewSizeRatio = tanf( act_fovy_angle*0.5*0.0174532925 );
    
if(yn)
{    
    for( i = 0 ; i < 10 ; i++ )
    {
        for( j = 0 ; j < 24 ; j++ )
        {
            FBO_board_vertex[i][j][3] = 1.0f/viewSizeRatio;
        }
    }
    
    
    glBindFramebuffer(GL_FRAMEBUFFER, *FBOName);
    glUseProgram(PRG_FBO_DRAW);
   
    glViewport(0, 0, RESOLUTION, RESOLUTION);
    glClear(GL_COLOR_BUFFER_BIT);

    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, FBO_board_vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, FBO_board_color);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, FBO_board_texcoord);
    glUniformMatrix4fv(UNF_mvp_Matrix, 1, GL_FALSE, MATRIX);
    glUniform1i(UNF_FBO_Tex, 0);// texture 0
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 24*10);
}   

    
    
// tap kaleidoscope
    
    [self drawTap];
        
// LP kaleidoscope
    [self drawLongPress];
    
    
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    glEnable(GL_DEPTH_TEST);
    
    glFlush();
    
    
    
    
// increment
    act_fovy_angle += ( fovy_angle - act_fovy_angle ) * 0.1f;
    
    act_lookingAxis[0] += ( lookingAxis[0] - act_lookingAxis[0] ) * 0.1;
    act_lookingAxis[1] += ( lookingAxis[1] - act_lookingAxis[1] ) * 0.1;
    
}





- (void)saveModule:(NSKeyedArchiver *)archiver saveslot:(Byte)num
{

}

- (void)loadModule:(NSKeyedUnarchiver *)unArchiver loadslot:(Byte)num
{

}


- (void)becomeCurrent
{
    // set Texture, Shader, FBO
    glGenFramebuffers(1, &FBO_Kaleidoscope);
    glGenTextures(1, &TEX_Kaleidoscope);
    
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_Kaleidoscope);
    
    glActiveTexture(GL_TEXTURE0);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, TEX_Kaleidoscope);
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
    
    
    glTexImage2D(
                 GL_TEXTURE_2D, 
                 0, 
                 GL_RGBA, 
                 128, 
                 128,
                 0, 
                 GL_RGBA, 
                 GL_UNSIGNED_BYTE, 
                 0
                 );

    glFramebufferTexture2D(
                           GL_FRAMEBUFFER, 
                           GL_COLOR_ATTACHMENT0, 
                           GL_TEXTURE_2D, 
                           TEX_Kaleidoscope, 
                           0
                           );
    
    int status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    NSLog(@"FBO kaleidoscope : %x", status );
    
    
    // Texture Pattern    
    glGenTextures(1, &TEX_Pattern);
    NSInteger ImgWidth;
    NSInteger ImgHeight;
    CGContextRef textureContext;
    GLubyte* texPointer;
    
    CGImageRef patternTexture = [UIImage imageNamed:@"M04_Kaleidoscope_Texture.png"].CGImage;
    
    ImgWidth = CGImageGetWidth( patternTexture );
    ImgHeight = CGImageGetHeight( patternTexture );
    
    texPointer = (GLubyte*)malloc(ImgWidth*ImgHeight*4);
    
    textureContext = CGBitmapContextCreate(
                                           texPointer, 
                                           ImgWidth, 
                                           ImgHeight, 
                                           8, 
                                           ImgWidth*4, 
                                           CGImageGetColorSpace(patternTexture), 
                                           kCGImageAlphaPremultipliedLast
                                           );
    
    CGContextDrawImage( textureContext, 
                       CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
                       patternTexture
                       );
    
    CGContextRelease(textureContext);
    
    glActiveTexture( GL_TEXTURE1 );
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, TEX_Pattern);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glTexImage2D(
                 GL_TEXTURE_2D, 
                 0, 
                 GL_RGBA, 
                 ImgWidth, 
                 ImgHeight, 
                 0, 
                 GL_RGBA, 
                 GL_UNSIGNED_BYTE, 
                 texPointer
                 );
    
    free(texPointer);
    
    
    // shader *************************************
    status = glIsProgram(PRG_FBO_KALEIDO);
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M04_FBO_kaleidoscope" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_FBO_KALEIDO fs:&FS_FBO_KALEIDO pg:&PRG_FBO_KALEIDO];
        
        glBindAttribLocation(PRG_FBO_KALEIDO, 0, "position");
        glBindAttribLocation(PRG_FBO_KALEIDO, 1, "color");
        glBindAttribLocation(PRG_FBO_KALEIDO, 2, "texCoord");
        
        [self linkProgram:&PRG_FBO_KALEIDO];
        
        // UNF
        UNF_patternTexture = glGetUniformLocation(PRG_FBO_KALEIDO, "patternTexture");
        NSLog(@"%@ UNF_patternTexture %d", moduleName, UNF_patternTexture);
        
        [self validateProgramAndDeleteShader_vs:&VS_FBO_KALEIDO fs:&FS_FBO_KALEIDO pg:&PRG_FBO_KALEIDO];
    }
    
    status = glIsProgram(PRG_FBO_DRAW);
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M04_Draw_FBO" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_FBO_DRAW fs:&FS_FBO_DRAW pg:&PRG_FBO_DRAW];
        
        glBindAttribLocation(PRG_FBO_DRAW, 0, "position");
        glBindAttribLocation(PRG_FBO_DRAW, 1, "color");
        glBindAttribLocation(PRG_FBO_DRAW, 2, "texCoord");
        
        [self linkProgram:&PRG_FBO_DRAW];
        
        // UNF
        UNF_mvp_Matrix = glGetUniformLocation(PRG_FBO_DRAW, "mvp_Matrix");
        UNF_FBO_Tex = glGetUniformLocation(PRG_FBO_DRAW, "FBO_Tex");
        NSLog(@"%@ UNF_mvp_Matrix %d", moduleName, UNF_mvp_Matrix);
        NSLog(@"%@ UNF_FBO_Tex %d", moduleName, UNF_FBO_Tex);
        
        [self validateProgramAndDeleteShader_vs:&VS_FBO_DRAW fs:&FS_FBO_DRAW pg:&PRG_FBO_DRAW];
        
    }
    
    // shader *************************************

    status = glIsProgram( PRG_SOLID );
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M04_Kaleidoscope_solidcolor" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
        
        glBindAttribLocation(PRG_SOLID, 0, "position");
        glBindAttribLocation(PRG_SOLID, 1, "color");
        
        [self linkProgram:&PRG_SOLID];
        
        // UNF
        UNF_mvp_Matrix_SOLID = glGetUniformLocation(PRG_SOLID, "mvp_Matrix");
        NSLog(@"%@ UNF_mvp_Matrix_SOLID %d", moduleName, UNF_mvp_Matrix_SOLID);
        
        [self validateProgramAndDeleteShader_vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
    }
    
}



- (void)becomeBackground
{
    // delete Texture, Shader, FBO
    glDeleteTextures(1, &TEX_Kaleidoscope);
    glDeleteFramebuffers(1, &FBO_Kaleidoscope);
    glDeleteTextures(1, &TEX_Pattern);
    
    glDeleteProgram(PRG_FBO_KALEIDO);
    glDeleteProgram(PRG_FBO_DRAW);
    glDeleteProgram(PRG_SOLID);
}



@end
