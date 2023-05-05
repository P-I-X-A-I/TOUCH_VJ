//
//  M03_Rainbow.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M03_Rainbow.h"


@implementation M03_Rainbow

- (id)initWithDeviceName:(NSString *)deviceName
{
    self = [super init];
    
    if( [deviceName isEqualToString:@"iPad"] )
    {
        M03_HUE_CONDITION = 6;
        M03_LP_CONDITION = 5;
        iPad_model_No = 1;
        RESOLUTION = 512;
    }
    else if( [deviceName isEqualToString:@"iPad2"] )
    {
        M03_HUE_CONDITION = M03_HUE;
        M03_LP_CONDITION = M03_LP;
        iPad_model_No = 2;
        RESOLUTION = 1024;
    }
    
    
// module Information
    moduleName = [[NSString alloc] initWithString:@"03_Rainbow"];
    moduleIcon = [UIImage imageNamed:@"M03_Rainbow"];
    
// load Nib File
    [[NSBundle mainBundle] loadNibNamed:@"M03_Rainbow" owner:self options:nil];
    
// Num of Setting pages
    Num_Of_Pages = 1;
    segmentPageTitle_ARRAY = [[NSMutableArray alloc] init];
    viewForSegment_ARRAY = [[NSMutableArray alloc] init];
    
    // set segment page title
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Module Info"]];
    
    // set view for segment
    [viewForSegment_ARRAY addObject:view_00];
    

    
    [self initValues];
    [self initGUI];
    
    return self;
}


- (void)initValues
{
    UIColor* Color_OBJ;
    int i, j, k;
    
    for( i = 0 ; i < M03_HUE_CONDITION ; i++ )
    {
        float HUE = ((float)i / (float)M03_HUE_CONDITION);
                
        Color_OBJ = [UIColor colorWithHue:HUE saturation:1.0 brightness:1.0 alpha:1.0];
        const CGFloat* components = CGColorGetComponents(Color_OBJ.CGColor);
        
        Rainbow_Bright[i][0] = *components; components++;
        Rainbow_Bright[i][1] = *components; components++;
        Rainbow_Bright[i][2] = *components;
        
        Color_OBJ = [UIColor colorWithHue:HUE + 0.07 saturation:1.0 brightness:0.7 alpha:1.0];
        components = CGColorGetComponents(Color_OBJ.CGColor);
        
        Rainbow_Dark[i][0] = *components;   components++;
        Rainbow_Dark[i][1] = *components;   components++;
        Rainbow_Dark[i][2] = *components;
    }
    
    
    for( i = 0 ; i < 256 ; i++ )
    {
        for( j = 0 ; j < 8 ; j++ )
        {
            Rainbow_Vertex[i][j][0] = 0.0f;
            Rainbow_Vertex[i][j][1] = 0.0f;
            Rainbow_Vertex[i][j][2] = 0.0f;
            Rainbow_Vertex[i][j][3] = 1.0f;
        }// j
        
        for( j = 0 ; j < 8 ; j++ )
        {
            if( j == 3 || j == 4 )
            {
                Rainbow_Color[i][j][0] = Rainbow_Bright[i%M03_HUE_CONDITION][0];
                Rainbow_Color[i][j][1] = Rainbow_Bright[i%M03_HUE_CONDITION][1];
                Rainbow_Color[i][j][2] = Rainbow_Bright[i%M03_HUE_CONDITION][2];
                Rainbow_Color[i][j][3] = 1.0f;
            }
            else
            {
                Rainbow_Color[i][j][0] = Rainbow_Dark[i%M03_HUE_CONDITION][0];
                Rainbow_Color[i][j][1] = Rainbow_Dark[i%M03_HUE_CONDITION][1];
                Rainbow_Color[i][j][2] = Rainbow_Dark[i%M03_HUE_CONDITION][2];
                Rainbow_Color[i][j][3] = 1.0f;
            }
        }// j
        
        Rainbow_TexCoord[i][0][0] = Rainbow_TexCoord[i][1][0] = 0.0f;
        Rainbow_TexCoord[i][0][1] = Rainbow_TexCoord[i][1][1] = 0.5f;
        
        Rainbow_TexCoord[i][2][0] = 0.0f;   Rainbow_TexCoord[i][2][1] = 1.0f;
        
        Rainbow_TexCoord[i][3][0] = 0.25f;  Rainbow_TexCoord[i][3][1] = 0.5f;
        
        Rainbow_TexCoord[i][4][0] = 0.25f;  Rainbow_TexCoord[i][4][1] = 1.0f;
        
        Rainbow_TexCoord[i][5][0] = 0.5f;   Rainbow_TexCoord[i][5][1] = 0.5f;
        
        Rainbow_TexCoord[i][6][0] = Rainbow_TexCoord[i][7][0] = 0.5f;
        Rainbow_TexCoord[i][6][1] = Rainbow_TexCoord[i][7][1] = 1.0f;
        
        
        
        
        tangentVec[i][0] = tangentVec[i][1] = 0.0f;
        basePoint[i][0] = basePoint[i][1] = 0.0f;
        cross_A[i][0] = cross_A[i][1] = 0.0f;
        cross_B[i][0] = cross_B[i][1] = 0.0f;
        
        Rainbow_Counter[i] = 2.0f;
    }// i
    
    pinch_centerX = 0.0f;
    pinch_centerY = 0.0f;
    pinch_radius = 0.0f;
    pinch_scale = 0.0f;
    
    act_pinch_centerX = 0.0f;
    act_pinch_centerY = 0.0f;
    act_pinch_radius = 0.0f;
    act_pinch_scale = 0.0f;
    act_pinch_Alpha = 0.0f;
    
    for( i = 0 ; i < M03_HUE_CONDITION ; i++ )
    {
        pinchPoint_base[i][0] = 0.0f;
        pinchPoint_base[i][1] = 0.0f;
        pinchPoint_base[i][2] = 0.0f;
        pinchPoint_base[i][3] = 1.0f;
        
        pinchPoint_Velocity[i][0] = 0.0f;
        pinchPoint_Velocity[i][1] = 0.0f;
        
        for( k = 0 ; k < 2 ; k++ )
        {
        for( j = 0 ; j < 6 ; j++ )
        {
            pinch_Vertex[k][i][j][0] = 0.0f;
            pinch_Vertex[k][i][j][1] = 0.0f;
            pinch_Vertex[k][i][j][2] = 0.0f;
            pinch_Vertex[k][i][j][3] = 1.0f;
            
            pinch_Color[k][i][j][0] = 0.0f;
            pinch_Color[k][i][j][1] = 0.0f;
            pinch_Color[k][i][j][2] = 0.0f;
            pinch_Color[k][i][j][3] = 0.0f;
        }// j
        
        pinch_Texcoord[k][i][0][0] = pinch_Texcoord[k][i][1][0] = 0.0f;
        pinch_Texcoord[k][i][0][1] = pinch_Texcoord[k][i][1][1] = 0.0f;
        
        pinch_Texcoord[k][i][2][0] = 0.0f;
        pinch_Texcoord[k][i][2][1] = 1.0f;
        
        pinch_Texcoord[k][i][3][0] = 1.0f;
        pinch_Texcoord[k][i][3][1] = 0.0f;
        
        pinch_Texcoord[k][i][4][0] = pinch_Texcoord[k][i][5][0] = 1.0f;
        pinch_Texcoord[k][i][4][1] = pinch_Texcoord[k][i][5][1] = 1.0f;
        }// k
    }
    
    radiusCounter = 0.0f;
    
    
    isFirstPinch = YES;
    
    
    for( i = 0 ; i < M03_TAP ; i++ )
    {
        TAP_Center[i][0] = 0.0f;
        TAP_Center[i][1] = 0.0f;
        
        for( j = 0 ; j < 6 ; j++ )
        {
            
            TAP_Vertex[i][j][0] = 0.0f;
            TAP_Vertex[i][j][1] = 0.0f;
            TAP_Vertex[i][j][2] = 0.0f;
            TAP_Vertex[i][j][3] = 1.0f;
            
            TAP_Color[i][j][0] = 1.0f;
            TAP_Color[i][j][1] = 0.0f;
            TAP_Color[i][j][2] = 0.0f;
            TAP_Color[i][j][3] = 1.0f;
        }
        
        TAP_TexCoord[i][0][0] = 0.0f;    TAP_TexCoord[i][0][1] = 0.0f;
        TAP_TexCoord[i][1][0] = 0.0f;    TAP_TexCoord[i][1][1] = 0.0f;
        TAP_TexCoord[i][2][0] = 0.0f;    TAP_TexCoord[i][2][1] = 1.0f;
        TAP_TexCoord[i][3][0] = 1.0f;    TAP_TexCoord[i][3][1] = 0.0f;
        TAP_TexCoord[i][4][0] = 1.0f;    TAP_TexCoord[i][4][1] = 1.0f;
        TAP_TexCoord[i][5][0] = 1.0f;    TAP_TexCoord[i][5][1] = 1.0f;
        
        TAP_Radian[i] = ( (float)i / (float)M03_TAP ) * M_PI * 2.0;
        TAP_Alpha[i] = 0.0f;
        TAP_sizeDist[i] = 0.0f;
        TAP_actSize[i] = 0.0f;
    }// i
    
    
    for( i = 0 ; i < 4 ; i++ )
    {
        LP_Center_Origin[i][0] = 0.0f;
        LP_Center_Origin[i][1] = 0.0f;
        
        for( j = 0 ; j < M03_LP_CONDITION ; j++ )
        {
            LP_Center[i][j][0] = 0.0f;
            LP_Center[i][j][1] = 0.0f;
            
            LP_Center_Velocity[i][j][0] = 0.0f;
            LP_Center_Velocity[i][j][1] = 0.0f;
            
            for( int k = 0 ; k < 6 ; k++ )
            {
                LP_Vertex[i][j][k][0] = 0.0f;
                LP_Vertex[i][j][k][1] = 0.0f;
                LP_Vertex[i][j][k][2] = 0.0f;
                LP_Vertex[i][j][k][3] = 1.0f;
                
                LP_Color[i][j][k][0] = 0.0f;
                LP_Color[i][j][k][1] = 0.0f;
                LP_Color[i][j][k][2] = 0.0f;
                LP_Color[i][j][k][3] = 0.0f;
            }
            
            LP_TexCoord[i][j][0][0] = 0.0f; LP_TexCoord[i][j][0][1] = 0.0f;
            LP_TexCoord[i][j][1][0] = 0.0f; LP_TexCoord[i][j][1][1] = 0.0f;
            LP_TexCoord[i][j][2][0] = 0.0f; LP_TexCoord[i][j][2][1] = 1.0f;
            LP_TexCoord[i][j][3][0] = 1.0f; LP_TexCoord[i][j][3][1] = 0.0f;
            LP_TexCoord[i][j][4][0] = 1.0f; LP_TexCoord[i][j][4][1] = 1.0f;
            LP_TexCoord[i][j][5][0] = 1.0f; LP_TexCoord[i][j][5][1] = 1.0f;
        
            LP_ColorINDEX[i][j] = random()%M03_HUE_CONDITION;
        }
    }
    
    
        
    
}

- (void)initGUI
{

}


- (void)moduleDraw:(BOOL)yn FBO:(GLuint*)FBOName
{
    
    glDisable( GL_DEPTH_TEST );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE );

    
    int i, j;
    
    [self initMatrix];
    
    [self lookAt_Ex:0.0f Ey:0.0f Ez:1.0f 
                 Vx:0.0f Vy:0.0f Vz:0.0f 
                 Hx:0.0f Hy:1.0f Hz:0.0f];
    
    
    

    for( i = 0 ; i < 256 ; i++ )
    {
        Byte index = i%M03_HUE_CONDITION;
        
        for( j = 0 ; j < 8 ; j++ )
        {
            if( j == 3 || j == 4 )
            {
                Rainbow_Color[i][j][0] = Rainbow_Bright[index][0];
                Rainbow_Color[i][j][1] = Rainbow_Bright[index][1];
                Rainbow_Color[i][j][2] = Rainbow_Bright[index][2];
            }
            else
            {
                Rainbow_Color[i][j][0] = Rainbow_Dark[index][0];
                Rainbow_Color[i][j][1] = Rainbow_Dark[index][1];
                Rainbow_Color[i][j][2] = Rainbow_Dark[index][2];
            }
        }// j
        
        if( Rainbow_Counter[i] > 1.99f )
        {
            for(j = 0 ; j < 8 ; j++ )
            { Rainbow_Color[i][j][3] = 0.0f; }
        }
        else
        {
            for( j = 0 ; j < 8 ; j++ )
            { Rainbow_Color[i][j][3] = 0.4f; }
        }
        
        
        Rainbow_Vertex[i][0][0] = Rainbow_Vertex[i][1][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]-1.0f) + cross_A[i][0]*0.1;
        Rainbow_Vertex[i][0][1] = Rainbow_Vertex[i][1][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]-1.0f) + cross_A[i][1]*0.1;
        
        Rainbow_Vertex[i][2][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]-1.0f) + cross_B[i][0]*0.1;
        Rainbow_Vertex[i][2][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]-1.0f) + cross_B[i][1]*0.1;
        //************************************
        Rainbow_Vertex[i][3][0] = basePoint[i][0] + tangentVec[i][0]*Rainbow_Counter[i] + cross_A[i][0]*0.5;
        Rainbow_Vertex[i][3][1] = basePoint[i][1] + tangentVec[i][1]*Rainbow_Counter[i] + cross_A[i][1]*0.5;
        
        Rainbow_Vertex[i][4][0] = basePoint[i][0] + tangentVec[i][0]*Rainbow_Counter[i] + cross_B[i][0]*0.5;
        Rainbow_Vertex[i][4][1] = basePoint[i][1] + tangentVec[i][1]*Rainbow_Counter[i] + cross_B[i][1]*0.5;
        //************************************
        Rainbow_Vertex[i][5][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]+1.0f) + cross_A[i][0]*0.1;
        Rainbow_Vertex[i][5][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]+1.0f) + cross_A[i][1]*0.1;
        
        Rainbow_Vertex[i][6][0] = Rainbow_Vertex[i][7][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]+1.0f) + cross_B[i][0]*0.1;
        Rainbow_Vertex[i][6][1] = Rainbow_Vertex[i][7][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]+1.0f) + cross_B[i][1]*0.1;
        
     }// i
    
    
if(yn)
{
    glViewport(0, 0, RESOLUTION, RESOLUTION);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
   
    glUseProgram(PRG_OBJ);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Rainbow_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Rainbow_Color);
    glUniformMatrix4fv( UNF_mvpMatrix, 1, GL_FALSE, MATRIX );
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 256*8);
}//yn
    
    
    // Blured Line
    for( i = 0 ; i < 256 ; i++ )
    {
        for( j = 0 ; j < 8 ; j++ )
        {
            Rainbow_Color[i][j][3] = 0.6f;
        }
        Rainbow_Vertex[i][0][0] = Rainbow_Vertex[i][1][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]-1.0f) + cross_A[i][0]*0.5;
        Rainbow_Vertex[i][0][1] = Rainbow_Vertex[i][1][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]-1.0f) + cross_A[i][1]*0.5;
        
        Rainbow_Vertex[i][2][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]-1.0f) + cross_B[i][0]*0.5;
        Rainbow_Vertex[i][2][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]-1.0f) + cross_B[i][1]*0.5;
        //************************************
        Rainbow_Vertex[i][3][0] = basePoint[i][0] + tangentVec[i][0]*Rainbow_Counter[i] + cross_A[i][0]*2.5;
        Rainbow_Vertex[i][3][1] = basePoint[i][1] + tangentVec[i][1]*Rainbow_Counter[i] + cross_A[i][1]*2.5;
        
        Rainbow_Vertex[i][4][0] = basePoint[i][0] + tangentVec[i][0]*Rainbow_Counter[i] + cross_B[i][0]*2.5;
        Rainbow_Vertex[i][4][1] = basePoint[i][1] + tangentVec[i][1]*Rainbow_Counter[i] + cross_B[i][1]*2.5;
        //************************************
        Rainbow_Vertex[i][5][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]+1.0f) + cross_A[i][0]*0.5;
        Rainbow_Vertex[i][5][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]+1.0f) + cross_A[i][1]*0.5;
        
        Rainbow_Vertex[i][6][0] = Rainbow_Vertex[i][7][0] = basePoint[i][0] + tangentVec[i][0]*(Rainbow_Counter[i]+1.0f) + cross_B[i][0]*0.5;
        Rainbow_Vertex[i][6][1] = Rainbow_Vertex[i][7][1] = basePoint[i][1] + tangentVec[i][1]*(Rainbow_Counter[i]+1.0f) + cross_B[i][1]*0.5;
    }
    
    
if(yn)
{
    
    glUseProgram(PRG_TEX);
    glUniformMatrix4fv( UNF_mvpMatrixTex, 1, GL_FALSE, MATRIX);
    glUniform1i(UNF_lineTex, 5);
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Rainbow_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Rainbow_Color);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, Rainbow_TexCoord);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 256*8);
}// yn
    
    
    
    
    
    // Pinch
    
    GLfloat F[2];
    float radius = act_pinch_radius*act_pinch_scale*0.3;
    float size = 0.35f * act_pinch_scale*act_pinch_radius;
    float radianShift;
    
    radiusCounter += 0.02;
    if( radiusCounter > M_PI*2.0 )
    {
        radiusCounter -= M_PI*2.0;
    }
    radianShift = sinf(radiusCounter)*M_PI;
    
    
    
    for( i = 0 ; i < M03_HUE_CONDITION ; i++ )
    {
        float radian = ((float)i / (float)M03_HUE_CONDITION)*M_PI*2.0f + act_pinch_scale + radianShift;
        
        float pointBase_X = act_pinch_centerX + cosf(radian)*radius;
        float pointBase_Y = act_pinch_centerY + sinf(radian)*radius;
        
        // Vertex
        pinch_Vertex[0][i][0][0] = pointBase_X - size;    pinch_Vertex[0][i][0][1] = pointBase_Y + size;
        pinch_Vertex[0][i][1][0] = pointBase_X - size;    pinch_Vertex[0][i][1][1] = pointBase_Y + size;
        
        pinch_Vertex[0][i][2][0] = pointBase_X - size;    pinch_Vertex[0][i][2][1] = pointBase_Y - size;
        
        pinch_Vertex[0][i][3][0] = pointBase_X + size;    pinch_Vertex[0][i][3][1] = pointBase_Y + size;
        
        pinch_Vertex[0][i][4][0] = pointBase_X + size;    pinch_Vertex[0][i][4][1] = pointBase_Y - size;
        pinch_Vertex[0][i][5][0] = pointBase_X + size;    pinch_Vertex[0][i][5][1] = pointBase_Y - size;

        
        // color
        for( j = 0 ; j < 6 ; j++ )
        {
            pinch_Color[0][i][j][0] = Rainbow_Bright[i][0];
            pinch_Color[0][i][j][1] = Rainbow_Bright[i][1];
            pinch_Color[0][i][j][2] = Rainbow_Bright[i][2];
            pinch_Color[0][i][j][3] = act_pinch_Alpha;
            pinch_Color[1][i][j][0] = Rainbow_Bright[i][0];
            pinch_Color[1][i][j][1] = Rainbow_Bright[i][1];
            pinch_Color[1][i][j][2] = Rainbow_Bright[i][2];
            pinch_Color[1][i][j][3] = act_pinch_Alpha;
        }
        
        
        // pinch point 2 ( moved by spring power )
        float vecX = pointBase_X - pinchPoint_base[i][0];
        float vecY = pointBase_Y - pinchPoint_base[i][1];
        
        vecX *= 0.01f;
        vecY *= 0.01f;
        
        F[0] = vecX;
        F[1] = vecY;
    
        pinchPoint_Velocity[i][0] = pinchPoint_Velocity[i][0]*0.96 + F[0];
        pinchPoint_Velocity[i][1] = pinchPoint_Velocity[i][1]*0.96 + F[1];
    
        pinchPoint_base[i][0] += pinchPoint_Velocity[i][0];
        pinchPoint_base[i][1] += pinchPoint_Velocity[i][1];
        
        // vertex
        pinch_Vertex[1][i][0][0] = pinchPoint_base[i][0] - size;    pinch_Vertex[1][i][0][1] = pinchPoint_base[i][1] + size;
        pinch_Vertex[1][i][1][0] = pinchPoint_base[i][0] - size;    pinch_Vertex[1][i][1][1] = pinchPoint_base[i][1] + size;
        
        pinch_Vertex[1][i][2][0] = pinchPoint_base[i][0] - size;    pinch_Vertex[1][i][2][1] = pinchPoint_base[i][1] - size;

        pinch_Vertex[1][i][3][0] = pinchPoint_base[i][0] + size;    pinch_Vertex[1][i][3][1] = pinchPoint_base[i][1] + size;

        pinch_Vertex[1][i][4][0] = pinchPoint_base[i][0] + size;    pinch_Vertex[1][i][4][1] = pinchPoint_base[i][1] - size;
        pinch_Vertex[1][i][5][0] = pinchPoint_base[i][0] + size;    pinch_Vertex[1][i][5][1] = pinchPoint_base[i][1] - size;
}
    
    
    
    
if(yn)
{
    //glUseProgram(PRG_TEX);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &pinch_Vertex[0][0][0][0] );
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &pinch_Color[0][0][0][0] );
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, &pinch_Texcoord[0][0][0][0] );
    //glUniformMatrix4fv( UNF_mvpMatrixTex, 16, GL_FALSE, MATRIX );
    glUniform1i( UNF_lineTex, 0 );
    glDrawArrays( GL_TRIANGLE_STRIP, 0, M03_HUE_CONDITION*6 );
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &pinch_Vertex[1][0][0][0] );
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &pinch_Color[1][0][0][0] );
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, &pinch_Texcoord[1][0][0][0] );
    glDrawArrays( GL_TRIANGLE_STRIP, 0, M03_HUE_CONDITION*6 );

    
}// yn
    
    

    
// Tap Effect
    for( i = 0 ; i < M03_TAP ; i++ )
    {
        float sizeX = cosf(sinf(TAP_Radian[i])*6.2831853)*TAP_actSize[i];
        float sizeY = sinf(sinf(TAP_Radian[i])*6.2831853)*TAP_actSize[i];
        float sizeX2 = cosf(sinf(TAP_Radian[i])*6.2831853+M_PI_2)*TAP_actSize[i];
        float sizeY2 = sinf(sinf(TAP_Radian[i])*6.2831853+M_PI_2)*TAP_actSize[i];
        
        TAP_Vertex[i][0][0] = TAP_Vertex[i][1][0] = (TAP_Center[i][0] + sizeX);
        TAP_Vertex[i][0][1] = TAP_Vertex[i][1][1] = (TAP_Center[i][1] + sizeY);
        
        TAP_Vertex[i][2][0] = (TAP_Center[i][0] + sizeX2);
        TAP_Vertex[i][2][1] = (TAP_Center[i][1] + sizeY2);
        
        TAP_Vertex[i][3][0] = (TAP_Center[i][0] - sizeX2);
        TAP_Vertex[i][3][1] = (TAP_Center[i][1] - sizeY2);
        
        TAP_Vertex[i][4][0] = TAP_Vertex[i][5][0] = (TAP_Center[i][0] - sizeX);
        TAP_Vertex[i][4][1] = TAP_Vertex[i][5][1] = (TAP_Center[i][1] - sizeY);
        
        
        for( j = 0 ; j < 6 ; j++ )
        {
            TAP_Color[i][j][0] = Rainbow_Bright[i%M03_HUE_CONDITION][0];
            TAP_Color[i][j][1] = Rainbow_Bright[i%M03_HUE_CONDITION][1];
            TAP_Color[i][j][2] = Rainbow_Bright[i%M03_HUE_CONDITION][2];
            TAP_Color[i][j][3] = sqrtf(TAP_Alpha[i]);
        }
    }
    
    
if(yn)
{
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, TAP_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, TAP_Color);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, TAP_TexCoord);

    glDrawArrays(GL_TRIANGLE_STRIP, 0, M03_TAP*6);
}
    
    
    
    
// Long Press 
    GLfloat F_LP[2];
    GLfloat K = 0.2;
    GLfloat LP_size = 1.0;
    
    for( i = 0 ; i < 4 ; i++ )
    {
        for( j = 0 ; j < M03_LP_CONDITION ; j++ )
        {
            float vecToX, vecToY, distance, weight;
            
            // force between origin and each point
            vecToX = LP_Center[i][j][0] - LP_Center_Origin[i][0];
            vecToY = LP_Center[i][j][1] - LP_Center_Origin[i][1];
            
            distance = sqrtf(vecToX*vecToX + vecToY*vecToY);
            weight = 0.15f - distance;
            LP_size = 1.0 * weight;
            
            F_LP[0] = vecToX * weight * K;
            F_LP[1] = vecToY * weight * K;
            
            
            // add force to point velocity
            LP_Center_Velocity[i][j][0] = LP_Center_Velocity[i][j][0]*0.99 + F_LP[0];
            LP_Center_Velocity[i][j][1] = LP_Center_Velocity[i][j][1]*0.99 + F_LP[1];
            
            LP_Center[i][j][0] += LP_Center_Velocity[i][j][0]; 
            LP_Center[i][j][1] += LP_Center_Velocity[i][j][1];
            
                        
            
            LP_Vertex[i][j][0][0] = LP_Center[i][j][0] - LP_size;   LP_Vertex[i][j][0][1] = LP_Center[i][j][1] + LP_size;
            LP_Vertex[i][j][1][0] = LP_Center[i][j][0] - LP_size;   LP_Vertex[i][j][1][1] = LP_Center[i][j][1] + LP_size;
            LP_Vertex[i][j][2][0] = LP_Center[i][j][0] - LP_size;   LP_Vertex[i][j][2][1] = LP_Center[i][j][1] - LP_size;
            LP_Vertex[i][j][3][0] = LP_Center[i][j][0] + LP_size;   LP_Vertex[i][j][3][1] = LP_Center[i][j][1] + LP_size;
            LP_Vertex[i][j][4][0] = LP_Center[i][j][0] + LP_size;   LP_Vertex[i][j][4][1] = LP_Center[i][j][1] - LP_size;
            LP_Vertex[i][j][5][0] = LP_Center[i][j][0] + LP_size;   LP_Vertex[i][j][5][1] = LP_Center[i][j][1] - LP_size;
            
            for( int k = 0 ; k < 6 ; k++ )
            {
                LP_Color[i][j][k][0] = Rainbow_Bright[LP_ColorINDEX[i][j]][0];
                LP_Color[i][j][k][1] = Rainbow_Bright[LP_ColorINDEX[i][j]][1];
                LP_Color[i][j][k][2] = Rainbow_Bright[LP_ColorINDEX[i][j]][2];
                LP_Color[i][j][k][3] = LP_actAlpha[i];
            }
        }
    }
    
    
    for( i = 0 ; i < M03_LP_CONDITION ; i++ )
    {
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &LP_Vertex[i][0][0][0] );
        glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &LP_Color[i][0][0][0]);
        glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, &LP_TexCoord[i][0][0][0] );
    
        glDrawArrays(GL_TRIANGLE_STRIP, 0, M03_LP_CONDITION*6);
    }
    
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    glEnable(GL_DEPTH_TEST);

    
    glFlush();
    

    
    
// increment
    act_trans[0] += ( dist_trans[0] - act_trans[0] )*0.2f;
    act_trans[1] += ( dist_trans[1] - act_trans[1] )*0.2f;
    
    for( i = 0 ; i < 256 ; i++ )
    {
        Rainbow_Counter[i] += ( 2.0f - Rainbow_Counter[i] )*0.04f;
        
        basePoint[i][0] += act_trans[0]*0.005;
        basePoint[i][1] += act_trans[1]*0.005;
    }
    
    
    act_pinch_centerX += ( pinch_centerX - act_pinch_centerX ) * 0.2f;
    act_pinch_centerY += ( pinch_centerY - act_pinch_centerY ) * 0.2f;
    act_pinch_radius += ( pinch_radius - act_pinch_radius ) * 0.2f;
    act_pinch_scale += ( pinch_scale - act_pinch_scale ) * 0.2f;
    
    if( isPinched )
    { act_pinch_Alpha += ( 0.5f - act_pinch_Alpha )*0.1f; }
    else
    { act_pinch_Alpha += ( 0.0f - act_pinch_Alpha )*0.1f; }
    
    
    for( i = 0 ; i < M03_TAP ; i++ )
    {
        TAP_Radian[i] += 0.02f;
        if(TAP_Radian[i] > (M_PI*2.0f) )
        {
            TAP_Radian[i] -= M_PI*2.0f;
        }
        
        TAP_Alpha[i] += ( 0.0f - TAP_Alpha[i] ) * 0.05f;
        TAP_actSize[i] += ( TAP_sizeDist[i] - TAP_actSize[i] ) * 0.2f;
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        if( isLongPressed[i] )
        {
            LP_actAlpha[i] += ( 1.0f - LP_actAlpha[i] ) * 0.1f;
        }
        else
        {
            LP_actAlpha[i] += ( 0.0f - LP_actAlpha[i] ) * 0.1f;
        }
    }
    
}//module draw


- (void)saveModule:(NSKeyedArchiver *)archiver saveslot:(Byte)num
{

}
- (void)loadModule:(NSKeyedUnarchiver *)unArchiver loadslot:(Byte)num
{
    [self initGUI];
}

- (void)becomeCurrent
{
    NSInteger ImgWidth;
    NSInteger ImgHeight;
    CGContextRef textureContext;
    GLubyte* texPointer;
    
    CGImageRef pointTexture = [UIImage imageNamed:@"M03_PointTexture.png"].CGImage;
    
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
    // **** Shader ******************************************
    
    status = glIsProgram(PRG_OBJ);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M03_Rainbow" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    
        glBindAttribLocation(PRG_OBJ, 0, "position");
        glBindAttribLocation(PRG_OBJ, 1, "color");
    
        [self linkProgram:&PRG_OBJ];
    
        UNF_mvpMatrix = glGetUniformLocation(PRG_OBJ, "mvpMatrix");
        NSLog(@"%@ UNF_mvpMatrix %d", moduleName, UNF_mvpMatrix);
    
        [self validateProgramAndDeleteShader_vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    }
    
    // ******************************************************
    status = glIsProgram(PRG_TEX);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M03_Rainbow_Tex" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_TEX fs:&FS_TEX pg:&PRG_TEX];
    
        glBindAttribLocation(PRG_TEX, 0, "position");
        glBindAttribLocation(PRG_TEX, 1, "color");
        glBindAttribLocation(PRG_TEX, 2, "texCoord");
    
        [self linkProgram:&PRG_TEX];
    
        UNF_mvpMatrixTex = glGetUniformLocation(PRG_TEX, "mvpMatrix");
        UNF_lineTex = glGetUniformLocation(PRG_TEX, "lineTex");
        NSLog(@"%@ UNF_mvpMatrix_Tex %d", moduleName, UNF_mvpMatrixTex);
        NSLog(@"%@ UNF_lineTex %d", moduleName, UNF_lineTex );
    
        [self validateProgramAndDeleteShader_vs:&VS_TEX fs:&FS_TEX pg:&PRG_TEX];
    }
    // *********************************************************

}
- (void)becomeBackground
{
    glDeleteTextures(1, &TexName_Point);
    
    glDeleteProgram(PRG_OBJ);
    glDeleteProgram(PRG_TEX);
}

@end
