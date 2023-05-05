//
//  M02_FontBit.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M02_FontBit.h"


@implementation M02_FontBit

- (id)initWithDeviceName:(NSString *)deviceName
{
    self = [super init];
    
    
    if( [deviceName isEqualToString:@"iPad"] )
    {
        M02_NUM_POINTS_CONDITION = 180;
        M02_POINT_TIMES_CONDITION = 3;
        RESOLUTION = 512;
        iPad_model_No = 1;
    }
    else if( [deviceName isEqualToString:@"iPad2"] )
    {
        M02_NUM_POINTS_CONDITION = M02_NUM_POINTS;
        M02_POINT_TIMES_CONDITION = M02_POINT_TIMES;
        RESOLUTION = 1024;
        iPad_model_No = 2;
    }
    
    
    
    
// module information
    moduleName = [[NSString alloc] initWithString:@"02_FontBit"];
    moduleIcon = [UIImage imageNamed:@"M02_FontBit"];
    
// load Nib file
    [[NSBundle mainBundle] loadNibNamed:@"M02_FontBit" owner:self options:nil];
    
// num of setting pages
    Num_Of_Pages = 2;
    segmentPageTitle_ARRAY = [[NSMutableArray alloc] init];
    viewForSegment_ARRAY = [[NSMutableArray alloc] init];
    
// set segment page title
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Module Info"]];
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Parameters"]];
    
// set View for segment
    [viewForSegment_ARRAY addObject:view_00];
    [viewForSegment_ARRAY addObject:view_01];

    
    
    
    [self initValues];
    [self initGUI];
    
    [self setFontData];
    
    matrixOBJ = [[matrixClass alloc] init];
    
    return self;
}



- (void)initValues
{
    int i, j;
    
    fovy = 75.0f;
    dist_fovy = 75.0;

    head_X = act_head_X = 0.0f;
    view_X = act_view_X = 0.0f;
    view_Y = act_view_Y = 0.0f;
    
    BIT_COUNT = 0;
    
    boardTex_Shift[0] = 0.0f;
    boardTex_Shift[1] = 0.0f;
    
    act_BoardAlpha = 1.0f;
    
    for( i = 0 ; i < M02_NUM_POINTS_CONDITION ; i++ )
    {
        P_Position[0][i][0] = (random()%200-100)*0.01;
        P_Position[0][i][1] = (random()%200-100)*0.01;
        P_Position[0][i][2] = (random()%200-100)*0.01;
        P_Position[0][i][3] = 1.0f;
        
        Velocity_Position[i][0] = 0.0f;
        Velocity_Position[i][1] = 0.0f;
        Velocity_Position[i][2] = 0.0f;
        
        for( j = 1 ; j < M02_POINT_TIMES_CONDITION ; j++ )
        {
            P_Position[j][i][0] = P_Position[j-1][i][0];
            P_Position[j][i][1] = P_Position[j-1][i][1];
            P_Position[j][i][2] = P_Position[j-1][i][2];
            P_Position[j][i][3] = P_Position[j-1][i][3];
        }
        
        P_BitPoint[i][0] = 0.0f;
        P_BitPoint[i][1] = 0.0f;
        P_BitPoint[i][2] = 0.0f;
        
        P_BitPoint_Trans[i][0] = 0.0f;
        P_BitPoint_Trans[i][1] = 0.0f;
        P_BitPoint_Trans[i][2] = 0.0f;
        
        P_BitPoint_Vel[i][0] = 0.0f;
        P_BitPoint_Vel[i][1] = 0.0f;
        P_BitPoint_Vel[i][2] = 0.0f;
        
        P_BitPoint_rotY_Vel[i] = 0.0f;
        P_BitPoint_rotZ_Vel[i] = 0.0f;
        
        P_Weight[i] = 0.0f;
        p_Weight_Counter[i] = 0.0f;
        
        P_LPress_Dist[i][0] = 0.0f;
        P_LPress_Dist[i][1] = 0.0f;
        P_LPress_Dist[i][2] = 0.0f;
        
        P_LPress_Weight[i] = 0.0f;
    }// i
    
        
    for( i = 0 ; i < 20 ; i++ )
    {
        wind_F[i][0] = 0.0;
        wind_F[i][1] = 0.0;
        wind_F[i][2] = 0.0;
        wind_Counter[i][0] = random()%628*0.01;
        wind_Counter[i][1] = random()%628*0.01;
        wind_Counter[i][2] = random()%628*0.01;
    }

    isLongPressed[0] = NO;
    isLongPressed[1] = NO;
    isLongPressed[2] = NO;
    isLongPressed[3] = NO;
    isPanned = NO;
    isPinched = NO;


    for( i = 0 ; i < NUMBER_OF_SLOT ; i++ )
    {
        Point_Color[i][0] = 1.0f;
        Point_Color[i][1] = 1.0f;
        Point_Color[i][2] = 1.0f;
        
        BG_Color[i][0] = 0.0f;
        BG_Color[i][1] = 0.0f;
        BG_Color[i][2] = 0.0f;
        
        Point_HSB[i][0] = 1.0f;
        Point_HSB[i][1] = 0.0f;
        Point_HSB[i][2] = 1.0f;
        
        BG_HSB[i][0] = 0.0f;
        BG_HSB[i][1] = 0.0f;
        BG_HSB[i][2] = 0.0f;
    }
    
    act_Point_Color[0] = 1.0f;
    act_Point_Color[1] = 1.0f;
    act_Point_Color[2] = 1.0f;
    
    act_BG_Color[0] = 0.0f;
    act_BG_Color[1] = 0.0f;
    act_BG_Color[2] = 0.0f;

    
    for( i = 0 ; i < 16 ; i++ )
    {
        for( j = 0 ; j < 18 ; j++ )
        {
            tapCircle_Vertex[i][j][0] = 0.0f;
            tapCircle_Vertex[i][j][1] = 0.0f;
            tapCircle_Vertex[i][j][2] = 0.0f;
            tapCircle_Vertex[i][j][3] = 1.0f;
            
            int baseIndex = i*18;
            int prev = j;
            int next = j + 1;
            if (next == 18) 
            {
                next = 0;
            }
            
            prev += baseIndex;
            next += baseIndex;
            
            tapCircle_Index[i][j][0] = prev;
            tapCircle_Index[i][j][1] = next;
            
            tapCircle_Alpha[i][j] = 0.0f;
            
            
        }// 18
        
        tapCircle_Origin[i][0] = 0.0f;
        tapCircle_Origin[i][1] = 0.0f;
        tapCircle_Origin[i][2] = 0.0f;
        
        tapCircle_targetINDEX[i] = 0;
        tapCircle_COUNTER = 0;
    }// 16
    
    
    for( i = 0 ; i < 18 ; i++ )
    {
        float radian = (i*20)*0.0174532925;
        
        Circle_Base[i][0] = cosf(radian)*0.1;
        Circle_Base[i][1] = sinf(radian)*0.1;
    }
    
    
    
    // LongPress Line
    
    for( i = 0 ; i < 4 ; i++ )
    {
        for( j = 0 ; j < M02_LPRESS ; j++ )
        {
            LPressLine_Vertex[i][j][0][0] = 0.0f;
            LPressLine_Vertex[i][j][0][1] = 0.0f;
            LPressLine_Vertex[i][j][0][2] = 0.0f;
            LPressLine_Vertex[i][j][0][3] = 1.0f;
 
            LPressLine_Vertex[i][j][1][0] = 0.0f;
            LPressLine_Vertex[i][j][1][1] = 0.0f;
            LPressLine_Vertex[i][j][1][2] = 0.0f;
            LPressLine_Vertex[i][j][1][3] = 1.0f;

            LPressLine_Alpha[i][j][0] = 0.0f;
            LPressLine_Alpha[i][j][1] = 0.0f;
            
            LPress_TargetINDEX[i][j] = 0;
        }
        
        LPress_Center[i][0] = 0.0f;
        LPress_Center[i][1] = 0.0f;
        LPress_Center[i][2] = 0.0f;
    }
    
    
    // Pan Effect
    Pan_Trans[0] = 0.0f;
    Pan_Trans[1] = 0.0f;
    Pan_Trans[2] = 0.0f;
    transX_Stock = 0.0f;
    transY_Stock = 0.0f;
}


- (void)initGUI
{
    SLIDER_POINT_R.value = Point_HSB[CURRENT_SLOT][0];
    SLIDER_POINT_G.value = Point_HSB[CURRENT_SLOT][1];
    SLIDER_POINT_B.value = Point_HSB[CURRENT_SLOT][2];
    
    SLIDER_BG_R.value = BG_HSB[CURRENT_SLOT][0];
    SLIDER_BG_G.value = BG_HSB[CURRENT_SLOT][1];
    SLIDER_BG_B.value = BG_HSB[CURRENT_SLOT][2];
}



- (void)moduleDraw:(BOOL)yn FBO:(GLuint*)FBOName
{
    int i, j;
    
    [self initMatrix];
    
    [self lookAt_Ex:0.0f        Ey:0.0f         Ez:1.0f
                 Vx:act_view_X  Vy:act_view_Y   Vz:0.0f
                 Hx:act_head_X  Hy:1.0f         Hz:0.0f];
    
    [self perspective_fovy:fovy
                    aspect:1.0f 
                      near:0.05f
                       far:3.0f];

    glViewport(0, 0, RESOLUTION, RESOLUTION);
    //glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    //glClear( GL_COLOR_BUFFER_BIT );
   
    GLfloat sin_fovy = sin(fovy*0.5*0.0174532925)*2.0; // for restriction box
    
    GLfloat shader_fovyWeight = sinf(45.0*0.0174532925) / sinf(fovy * 0.5 * 0.0174532925);  // ratio of "sin(45.0)" : "sin(fovy/2)"

    
// Clear board
    
    GLfloat boardVertex[4][4];
    GLfloat boardColor[4][4];
    GLfloat boardTexCoord[4][2];
    
    boardVertex[0][0] =-1.0f;   boardVertex[0][1] = 1.0;    boardVertex[0][2] = 0.0f;   boardVertex[0][3] = 1.0f;
    boardVertex[1][0] =-1.0f;   boardVertex[1][1] =-1.0;    boardVertex[1][2] = 0.0f;   boardVertex[1][3] = 1.0f;
    boardVertex[2][0] = 1.0f;   boardVertex[2][1] = 1.0;    boardVertex[2][2] = 0.0f;   boardVertex[2][3] = 1.0f;
    boardVertex[3][0] = 1.0f;   boardVertex[3][1] =-1.0;    boardVertex[3][2] = 0.0f;   boardVertex[3][3] = 1.0f;
    
    boardTexCoord[0][0] = 0.15f+act_boardTex_Shift[0]; boardTexCoord[0][1] = 0.55f+act_boardTex_Shift[1];
    boardTexCoord[1][0] = 0.15f+act_boardTex_Shift[0]; boardTexCoord[1][1] = 0.95f+act_boardTex_Shift[1];
    boardTexCoord[2][0] = 0.35f+act_boardTex_Shift[0]; boardTexCoord[2][1] = 0.55f+act_boardTex_Shift[1];
    boardTexCoord[3][0] = 0.35f+act_boardTex_Shift[0]; boardTexCoord[3][1] = 0.95f+act_boardTex_Shift[1];
    
    for( i = 0 ; i < 4 ; i++ )
    {
        boardColor[i][0] = act_BG_Color[0];
        boardColor[i][1] = act_BG_Color[1];
        boardColor[i][2] = act_BG_Color[2];
        boardColor[i][3] = act_BoardAlpha;
    }
    
if( yn )
{
    glUseProgram(PRG_BOARD);
    glUniform1i(UNF_boardTex, 5);
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, boardVertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, boardColor);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, boardTexCoord);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}   
    
    
    
    
    
    
    
    
// point
    
    
    
    // point physical simulation
    GLfloat prev_Vector[3];
    GLfloat next_Vector[3];
    double prev_Distance;
    double next_Distance;
    double prev_Normalize;
    double next_Normalize;
    
    GLfloat bit_Vector[3];
    
    double F[3];
    double LP_F[3];
    
    
    for( i = 0 ; i < M02_NUM_POINTS_CONDITION ; i++ )
    {
        
    // attracting force of neighbering points
        short prev_INDEX = i-1;
        short next_INDEX = i+1;
        
        if(i == 0)
        {
            prev_INDEX = M02_NUM_POINTS_CONDITION-1;
            next_INDEX = i+1;
        }
        else if(i == M02_NUM_POINTS_CONDITION-1)
        {
            prev_INDEX = i-1;
            next_INDEX = 0;
        }
        else
        {
            prev_INDEX = i-1;
            next_INDEX = i+1;
        }
        
        for( j = 0 ; j < 3 ; j++ )
        {
            prev_Vector[j] = P_Position[0][prev_INDEX][j] - P_Position[0][i][j];
            next_Vector[j] = P_Position[0][next_INDEX][j] - P_Position[0][i][j];
        }
        
        prev_Distance = sqrt( prev_Vector[0]*prev_Vector[0] + prev_Vector[1]*prev_Vector[1] + prev_Vector[2]*prev_Vector[2] );
        next_Distance = sqrt( next_Vector[0]*next_Vector[0] + next_Vector[1]*next_Vector[1] + next_Vector[2]*next_Vector[2] );
        
        prev_Normalize = 0.001 / sqrt( prev_Distance );
        next_Normalize = 0.001 / sqrt( next_Distance );
    // *******************************************
                
    
    // attracting force to Bit Point *************
        for( j = 0 ; j < 3 ; j++ )
        {
            bit_Vector[j] = ( (P_BitPoint[i][j] + P_BitPoint_Trans[i][j]) - P_Position[0][i][j] );
        }
        
        bit_Vector[0] *= (0.25 * P_Weight[i]);
        bit_Vector[1] *= (0.25 * P_Weight[i]);
        bit_Vector[2] *= (0.25 * P_Weight[i]);
        
    // *******************************************
        
        
    // attracting force to LPress
        for( j = 0 ; j < 3 ; j++ )
        {
            LP_F[j] = (P_LPress_Dist[i][j] - P_Position[0][i][j]) * 0.01 * P_LPress_Weight[i];
        }
        
        
        
        
    // summing force
        for( j = 0 ; j < 3 ; j++ )
        {
            F[j] =  (prev_Distance -1.0) * prev_Vector[j] * prev_Normalize + // attracting force of previous point
                    (next_Distance -1.0) * next_Vector[j] * next_Normalize + // attracting force of next point
                    LP_F[j] +                                                // attracting force to LPress Point
                    wind_F[i%20][j] +                                        // wind force
                    act_Pinch_F[j];                                          // Pinch force
                        
            F[j] *= ( 1.0 - P_Weight[i] );
            
            Velocity_Position[i][j] = Velocity_Position[i][j]*0.93 + F[j] + Pan_Trans[j]; // velocity
            P_Position[0][i][j] += (Velocity_Position[i][j] + bit_Vector[j] ); // position
            
            P_BitPoint_Vel[i][j] = P_BitPoint_Vel[i][j]*0.93 + F[j]*0.5 + Pan_Trans[j];
            P_BitPoint_Trans[i][j] += P_BitPoint_Vel[i][j];
        }// j
        
                
        
        // Constrain position to Box area.
        // area box X
        
        if( P_Position[0][i][0] > sin_fovy )
        { P_Position[0][i][0] -= sin_fovy*2.0; }
        else if( P_Position[0][i][0] < -sin_fovy )
        { P_Position[0][i][0] += sin_fovy*2.0; }
        // area box Y
        if( P_Position[0][i][1] > sin_fovy )
        { P_Position[0][i][1] -= sin_fovy*2.0; }
        else if( P_Position[0][i][1] < -sin_fovy )
        { P_Position[0][i][1] += sin_fovy*2.0; }
        // area box Z
        if( P_Position[0][i][2] > 1.0 )
        { P_Position[0][i][2] -=2.0; }
        else if( P_Position[0][i][2] < -1.0 )
        { P_Position[0][i][2] += 2.0; }
        
        
        // P_Weight increment & rotate bitPoint
        p_Weight_Counter[i] += ( 0.0 - p_Weight_Counter[i] )*0.05;
        
        if (p_Weight_Counter[i] > 0.05)
        {
            P_Weight[i] = 1.0f;
            
            [matrixOBJ initMatrix];
            [matrixOBJ rotate_Ydeg:P_BitPoint_rotY_Vel[i]];
            [matrixOBJ rotate_Zdeg:P_BitPoint_rotZ_Vel[i]];
            
            [matrixOBJ culculate_vec3:&P_BitPoint[i][0]];
        }
        else
        {
            P_Weight[i] = 0.0f;
        }
        
        // rot velocity increment
        P_BitPoint_rotY_Vel[i] += ( 0.0f - P_BitPoint_rotY_Vel[i] )*0.02f;
        P_BitPoint_rotZ_Vel[i] += ( 0.0f - P_BitPoint_rotZ_Vel[i] )*0.02f;
      
        
    }// i

// set blur point
    for( i = 0 ; i < M02_NUM_POINTS_CONDITION ; i++ )
    {
        for( j = M02_POINT_TIMES_CONDITION-1 ; j > 0 ; j-- )
        {
            P_Position[j][i][0] = P_Position[j-1][i][0];
            P_Position[j][i][1] = P_Position[j-1][i][1];
            P_Position[j][i][2] = P_Position[j-1][i][2];
        }
    }
    
    
if( yn )
{
    float pointSize;
    
    switch (iPad_model_No) {
        case 1:
            pointSize = 6.0f;
            break;
        case 2:
            pointSize = 12.0f;
            break;
        default:
            break;
    }
    
    glUseProgram(PRG_OBJ);
    glUniformMatrix4fv( UNF_mvp_Matrix, 1, GL_FALSE, MATRIX );
    glUniform1i(UNF_PointTexture, 0);
    glUniform3fv(UNF_color, 1, act_Point_Color);
    glUniform1f(UNF_fovyWeight, shader_fovyWeight);
    glUniform1f(UNF_pointSizeBase, pointSize);
    
    for( i = 0 ; i < M02_POINT_TIMES_CONDITION ; i++ )
    {
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &P_Position[i][0][0]);
        glDrawArrays(GL_POINTS, 0, M02_NUM_POINTS_CONDITION);
    }
}
    
    
    
    
    
    
// LineEffect tap
    GLfloat color_SOLID[4] = {act_Point_Color[0], act_Point_Color[1], act_Point_Color[2]};
    
    for( i = 0 ; i < 16 ; i++)
    {
        for( j = 0 ; j < 18 ; j++ )
        {
            tapCircle_Vertex[i][j][0] = tapCircle_Origin[i][0] + Circle_Base[j][0]*(1.0-p_Weight_Counter[tapCircle_targetINDEX[i]]);
            tapCircle_Vertex[i][j][1] = tapCircle_Origin[i][1] + Circle_Base[j][1]*(1.0-p_Weight_Counter[tapCircle_targetINDEX[i]]);
            tapCircle_Vertex[i][j][2] = tapCircle_Origin[i][2];
            tapCircle_Alpha[i][j] = p_Weight_Counter[ tapCircle_targetINDEX[i] ];
        }
        
        tapCircle_Origin[i][0] += P_BitPoint_Vel[tapCircle_targetINDEX[i]][0];
        tapCircle_Origin[i][1] += P_BitPoint_Vel[tapCircle_targetINDEX[i]][1];
        tapCircle_Origin[i][2] += P_BitPoint_Vel[tapCircle_targetINDEX[i]][2];
    }

    
if( yn )
{
    glUseProgram(PRG_SOLID);
    
    glLineWidth(3.0);
    glUniformMatrix4fv(UNF_mvp_Matrix_SOLID, 1, GL_FALSE, MATRIX);
    glUniform3fv(UNF_color_SOLID, 1, color_SOLID);
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, tapCircle_Vertex);
    glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, 0, tapCircle_Alpha);
    
    glDrawElements(GL_LINES, 18*16*2, GL_UNSIGNED_SHORT, tapCircle_Index);
}   
    
    
    
    
// lineEffect LongPress
    
    glLineWidth(2.0);
    float LPAlpha;
    
    for( i = 0 ; i < 4 ; i++ )
    {
                
        if( isLongPressed[i] )
        {   
            for( j = 0 ; j < M02_LPRESS ; j++ )
            {
                LPressLine_Vertex[i][j][0][0] = LPress_Center[i][0];
                LPressLine_Vertex[i][j][0][1] = LPress_Center[i][1];
                LPressLine_Vertex[i][j][0][2] = LPress_Center[i][2];
                
                LPressLine_Vertex[i][j][1][0] = P_Position[0][ LPress_TargetINDEX[i][j] ][0];
                LPressLine_Vertex[i][j][1][1] = P_Position[0][ LPress_TargetINDEX[i][j] ][1];
                LPressLine_Vertex[i][j][1][2] = P_Position[0][ LPress_TargetINDEX[i][j] ][2];
                
                LPAlpha = (float)(random()%10);
                
                if( LPAlpha < 2.0f ){ LPAlpha = 1.0f; }
                else{ LPAlpha = 0.0f; }
                
                
                LPressLine_Alpha[i][j][0] = LPressLine_Alpha[i][j][1] = LPAlpha;
            }
            
            
            if( yn )
            {
                glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &LPressLine_Vertex[i][0][0][0]);
                glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, 0, &LPressLine_Alpha[i][0][0]);
                glDrawArrays(GL_LINE_LOOP, 0, M02_LPRESS*2 );
            }
        }// isLongPressed
    }// i
        glFlush();
    
    
    
    
    
    
    
    
// Increment
    for( i = 0 ; i < 20 ; i++ )
    {
        
        // X   -1.0 ~ 1.0
        wind_F[i][0] = sin(wind_Counter[i][0])*0.0001;
        wind_Counter[i][0] += (0.001 + (random()%10)*0.0001);
        
        if( wind_Counter[i][0] > M_PI*2.0 )
        { wind_Counter[i][0] -= M_PI*2.0; }
        
        // Y   0.0 ~ 1.0
        wind_F[i][1] = sin(wind_Counter[i][1])*0.0002;
        wind_Counter[i][1] += (0.001 + (random()%10)*0.0001);
        
        if( wind_Counter[i][1] > M_PI )
        { wind_Counter[i][1] -= M_PI; }
        
        // Z    -1.0 ~ 1.0
        wind_F[i][2] = sin(wind_Counter[i][2])*0.0001;
        wind_Counter[i][2] += (0.001 + (random()%10)*0.0001);
        
        if( wind_Counter[i][2] > M_PI*2.0 )
        { wind_Counter[i][2] -= M_PI*2.0; }
    }
    
    for( i = 0 ; i < 3 ; i++ )
    {
        act_Pinch_F[i] += ( 0.0 - act_Pinch_F[i] )*0.01;
    }

    // fovy
    fovy += ( dist_fovy - fovy )*0.1;
    act_head_X += ( head_X - act_head_X )*0.1;
    act_view_X += ( view_X - act_view_X )*0.1;
    act_view_Y += ( view_Y - act_view_Y )*0.1;
    
    if(!isPinched)
    {
        dist_fovy += ( 75.0 - dist_fovy )*0.1;
        head_X += ( 0.0 - head_X )*0.05;
        view_X += ( 0.0 - view_X )*0.05;
        view_Y += ( 0.0 - view_Y )*0.05;
        
        act_boardTex_Shift[0] += ( 0.0 - act_boardTex_Shift[0] )*0.1;
        act_boardTex_Shift[1] += ( 0.0 - act_boardTex_Shift[1] )*0.1;
    }
    else
    {
        act_boardTex_Shift[0] += ( boardTex_Shift[0] - act_boardTex_Shift[0] )*0.1;
        act_boardTex_Shift[1] += ( boardTex_Shift[1] - act_boardTex_Shift[1] )*0.1;
    }
    
    
    act_Point_Color[0] += ( Point_Color[CURRENT_SLOT][0] - act_Point_Color[0] )*0.1f;
    act_Point_Color[1] += ( Point_Color[CURRENT_SLOT][1] - act_Point_Color[1] )*0.1f;
    act_Point_Color[2] += ( Point_Color[CURRENT_SLOT][2] - act_Point_Color[2] )*0.1f;

    act_BG_Color[0] += ( BG_Color[CURRENT_SLOT][0] - act_BG_Color[0] )*0.1f;
    act_BG_Color[1] += ( BG_Color[CURRENT_SLOT][1] - act_BG_Color[1] )*0.1f;
    act_BG_Color[2] += ( BG_Color[CURRENT_SLOT][2] - act_BG_Color[2] )*0.1f;
    
    if ( isPanned )
    { act_BoardAlpha += (0.025f - act_BoardAlpha )*0.2; }
    else
    { act_BoardAlpha += (1.0f - act_BoardAlpha )*0.02 ; }
    
    
    
    // pan trans
    for( i = 0 ; i < 3 ; i++ )
    {
        Pan_Trans[i] += ( 0.0f - Pan_Trans[i] ) * 0.1;
    }
    
}// module draw





- (void)saveModule:(NSKeyedArchiver *)archiver saveslot:(Byte)num
{
    // Point_Color[CURRENT_SLOT][0]
    [archiver encodeBytes:(const uint8_t *)&Point_Color[0][0]
                   length:sizeof(Point_Color)
                   forKey:[NSString stringWithFormat:@"M02_Point_Color_%d", num]];
    
    
    // BG_Color[CURRENT_SLOT][0]
    [archiver encodeBytes:(const uint8_t *)&BG_Color[0][0]
                   length:sizeof(BG_Color)
                   forKey:[NSString stringWithFormat:@"M02_BG_Color_%d", num]];
    
    // Point_HSB[][]
    [archiver encodeBytes:(const uint8_t *)&Point_HSB[0][0] 
                   length:sizeof(Point_HSB) 
                   forKey:[NSString stringWithFormat:@"M02_Point_HSB_%d", num]];
    
    // BG_HSB
    [archiver encodeBytes:(const uint8_t *)&BG_HSB[0][0]
                   length:sizeof(BG_HSB)
                   forKey:[NSString stringWithFormat:@"M02_BG_HSB_%d", num]];
}

- (void)loadModule:(NSKeyedUnarchiver *)unArchiver loadslot:(Byte)num
{
    NSUInteger LENGTH;
    int i, iter;
    
    // Point_Color[0][0]
    const uint8_t* Point_Color_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M02_Point_Color_%d", num]
                                                          returnedLength:&LENGTH];
    
    if( Point_Color_DecodePtr != NULL )
    {
        GLfloat* Point_Color_Copy = (GLfloat*)malloc(sizeof(Point_Color));
        GLfloat* Point_Color_Free = Point_Color_Copy;
        GLfloat* Point_Color_Assignment = &Point_Color[0][0];
        iter = sizeof(Point_Color) / sizeof(GLfloat);
    
        memcpy(Point_Color_Copy, Point_Color_DecodePtr, LENGTH);
    
        for( i = 0 ; i < iter ; i++ )
        {
            *Point_Color_Assignment = *Point_Color_Copy;
            Point_Color_Assignment++;
            Point_Color_Copy++;
        }
    
        free(Point_Color_Free);
    }
    
    // BG_Color[0][0]
    const uint8_t* BG_Color_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M02_BG_Color_%d", num]
                                                       returnedLength:&LENGTH];
    
    if( BG_Color_DecodePtr != NULL )
    {
        GLfloat* BG_Color_Copy = (GLfloat*)malloc(sizeof(BG_Color));
        GLfloat* BG_Color_Free = BG_Color_Copy;
        GLfloat* BG_Color_Assignment = &BG_Color[0][0];
        iter = sizeof(BG_Color) / sizeof(GLfloat);
    
        memcpy(BG_Color_Copy, BG_Color_DecodePtr, LENGTH);
    
        for( i = 0 ; i < iter ; i++ )
        {
            *BG_Color_Assignment = *BG_Color_Copy;
            BG_Color_Assignment++;
            BG_Color_Copy++;
        }
    
        free(BG_Color_Free);
    }
    
    // Point_HSB
    const uint8_t* Point_HSB_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M02_Point_HSB_%d", num] 
                                                        returnedLength:&LENGTH];
    
    if( Point_HSB_DecodePtr != NULL )
    {
        GLfloat* Point_HSB_Copy = (GLfloat*)malloc(sizeof(Point_HSB));
        GLfloat* Point_HSB_Free = Point_HSB_Copy;
        GLfloat* Point_HSB_Assignment = &Point_HSB[0][0];
        iter = sizeof(Point_HSB) / sizeof(GLfloat);
        
        memcpy(Point_HSB_Copy, Point_HSB_DecodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Point_HSB_Assignment = *Point_HSB_Copy;
            Point_HSB_Assignment++;
            Point_HSB_Copy++;
        }
        
        free(Point_HSB_Free);
    }
    
    
    // BG_HSB
    const uint8_t* BG_HSB_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M02_BG_HSB_%d", num]
                                                     returnedLength:&LENGTH];
    
    if( BG_HSB_DecodePtr != NULL )
    {
        GLfloat* BG_HSB_Copy = (GLfloat*)malloc(sizeof(BG_HSB));
        GLfloat* BG_HSB_Free = BG_HSB_Copy;
        GLfloat* BG_HSB_Assignment = &BG_HSB[0][0];
        iter = sizeof(BG_HSB) / sizeof(GLfloat);
        
        memcpy(BG_HSB_Copy, BG_HSB_DecodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *BG_HSB_Assignment = *BG_HSB_Copy;
            BG_HSB_Assignment++;
            BG_HSB_Copy++;
        }
        
        free(BG_HSB_Free);
    }
    
    
    
    [self initGUI];
}


- (void)becomeCurrent
{
    glDisable(GL_DEPTH_TEST);
    
    NSInteger ImgWidth;
    NSInteger ImgHeight;
    CGContextRef textureContext;
    GLubyte* texPointer;
    
    CGImageRef pointTexture = [UIImage imageNamed:@"M02_PointTexture.png"].CGImage;
    
    ImgWidth = CGImageGetWidth( pointTexture );
    ImgHeight = CGImageGetHeight( pointTexture );
    
    texPointer = (GLubyte*)malloc(ImgWidth*ImgHeight*4);
    
    textureContext = CGBitmapContextCreate(
                                           texPointer, 
                                           ImgWidth, 
                                           ImgHeight, 
                                           8, 
                                           ImgWidth*4, 
                                           CGImageGetColorSpace(pointTexture), 
                                           kCGImageAlphaPremultipliedLast
                                           );
    
    CGContextDrawImage( textureContext, 
                        CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
                        pointTexture
                       );
    CGContextRelease(textureContext);
    
    glGenTextures(1, &TexName_Point);
    
    glActiveTexture(GL_TEXTURE0);
    glEnable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, TexName_Point);
    
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

    
    Byte status;
    // set shader source *********************************
    
    status = glIsProgram(PRG_OBJ);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M02_FontBit" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    
        glBindAttribLocation(PRG_OBJ, 0, "position");
    
        [self linkProgram:&PRG_OBJ];
    
        UNF_mvp_Matrix = glGetUniformLocation(PRG_OBJ, "mvp_Matrix");
        UNF_PointTexture = glGetUniformLocation(PRG_OBJ, "PointTexture");
        UNF_color = glGetUniformLocation(PRG_OBJ, "color");
        UNF_fovyWeight = glGetUniformLocation(PRG_OBJ, "fovyWeight");
        UNF_pointSizeBase = glGetUniformLocation(PRG_OBJ, "pointSizeBase");
        NSLog(@"%@ UNF_mvp_Matrix %d", moduleName, UNF_mvp_Matrix);
        NSLog(@"%@ UNF_PointTexture %d", moduleName, UNF_PointTexture);
        NSLog(@"%@ UNF_color %d", moduleName, UNF_color);
        NSLog(@"%@ UNF_fovyWeight %d", moduleName, UNF_fovyWeight);
        NSLog(@"%@ UNF_pointSizeBase %d", moduleName, UNF_pointSizeBase);
        
        [self validateProgramAndDeleteShader_vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    }
    // ***************************************************
    
    status = glIsProgram(PRG_SOLID);
    
    if( status == GL_FALSE )
    {
    
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M02_FontBit_SolidColor" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
    
        glBindAttribLocation(PRG_SOLID, 0, "position");
        glBindAttribLocation(PRG_SOLID, 1, "alpha");
    
        [self linkProgram:&PRG_SOLID];
    
        UNF_mvp_Matrix_SOLID = glGetUniformLocation(PRG_SOLID, "mvp_Matrix");
        UNF_color_SOLID = glGetUniformLocation(PRG_SOLID, "color");
        NSLog(@"UNF_mvp_Matrix_SOLID %d", UNF_mvp_Matrix_SOLID);
        NSLog(@"UNF_color_SOLID %d", UNF_color_SOLID);
    
        [self validateProgramAndDeleteShader_vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
    }
    
    // ***************************************************
    status = glIsProgram(PRG_BOARD);
    
    if( status == GL_FALSE )
    {
    
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M02_FontBit_Clear" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_BOARD fs:&FS_BOARD pg:&PRG_BOARD];
    
        glBindAttribLocation( PRG_BOARD, 0, "position");
        glBindAttribLocation( PRG_BOARD, 1, "color");
        glBindAttribLocation( PRG_BOARD, 2, "texCoord");
    
        [self linkProgram:&PRG_BOARD];
    
        UNF_boardTex = glGetUniformLocation(PRG_BOARD, "boardTex");
        NSLog(@"UNF_boardTex %d", UNF_boardTex);
    
        [self validateProgramAndDeleteShader_vs:&VS_BOARD fs:&FS_BOARD pg:&PRG_BOARD];
    }
    // ***************************************************

}
- (void)becomeBackground
{
    glEnable(GL_DEPTH_TEST);
    glDeleteTextures(1, &TexName_Point);

    glDeleteProgram(PRG_OBJ);
    glDeleteProgram(PRG_SOLID);
    glDeleteProgram(PRG_BOARD);
}


@end
