//
//  M06_Plants.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/07/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M06_Plants.h"


@implementation M06_Plants

- (id)initWithDeviceName:(NSString *)deviceName
{
    if ( [deviceName isEqualToString:@"iPad"] )
    {
        RESOLUTION = 512;
    }
    else if( [deviceName isEqualToString:@"iPad2"] )
    {
        RESOLUTION = 1024;
    }
    
    
    // module info
    moduleName = [[NSString alloc] initWithFormat:@"06_Plants"];
    moduleIcon = [UIImage imageNamed:@"M06_Plants"];
    
    // loat nib file
    {
        [[NSBundle mainBundle] loadNibNamed:@"M06_Plants" owner:self options:nil];
    }
    
    // Num of pages
    Num_Of_Pages = 2;
    segmentPageTitle_ARRAY = [[NSMutableArray alloc] init];
    viewForSegment_ARRAY = [[NSMutableArray alloc] init];
    
    // set segment page title
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Module Info"]];
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Parameters"]];
    
    // set view for segment
    [viewForSegment_ARRAY addObject:view_0];
    [viewForSegment_ARRAY addObject:view_1];
    
    [self initValues];
    [self initGUI];
    
    return self;
}


- (void)initValues
{
    [self initializeValues];
}


- (void)initGUI
{
    SLIDER_BG_HUE.value = BG_HSB[CURRENT_SLOT][0];
    SLIDER_BG_SAT.value = BG_HSB[CURRENT_SLOT][1];
    SLIDER_BG_BRI.value = BG_HSB[CURRENT_SLOT][2];
}



- (void)moduleDraw:(BOOL)yn FBO:(GLuint *)FBOName
{
    int i, j, k;
    
    glViewport(0, 0, RESOLUTION, RESOLUTION);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    [self initMatrix];
    [self lookAt_Ex:0.0f Ey:0.0f Ez:2.0f
                 Vx:0.0f Vy:0.0f Vz:0.0f
                 Hx:0.0f Hy:1.0f Hz:0.0f];
    
    [self perspective_fovy:90.0f aspect:1.0 near:0.1 far:2.01];
    

    // ************* BG ******************************************************
    // ************* BG ******************************************************
    
    
// Background Board
    GLfloat tempBG_Vertex[4][4];
    GLfloat tempBG_Color[4][4];
    GLfloat rotate_Color[4][3];
    
    UIColor* tempColor;
    
    for( i = 0 ; i < 4 ; i++ )
    {
        float Hue = act_BG_HSB[0] + sinf(BG_radian[i])*0.1;
        
        if( Hue > 1.0 ){ Hue -= 1.0; }
        else if( Hue < 0.0 ){ Hue += 1.0; }
        
        tempColor = [UIColor colorWithHue:Hue
                               saturation:act_BG_HSB[1]
                               brightness:(act_BG_HSB[2]*0.9) + cosf(BG_radian[4-i])*0.1 
                                    alpha:1.0];
        
        const CGFloat* components = CGColorGetComponents(tempColor.CGColor);
        
        rotate_Color[i][0] = *components;   components++;
        rotate_Color[i][1] = *components;   components++;
        rotate_Color[i][2] = *components;  
    }
    
    tempBG_Vertex[0][0] = -2.01f;    tempBG_Vertex[0][1] = 2.01f;
    tempBG_Vertex[1][0] = -2.01f;    tempBG_Vertex[1][1] = -2.01f;
    tempBG_Vertex[2][0] = 2.01f;    tempBG_Vertex[2][1] = 2.01f;
    tempBG_Vertex[3][0] = 2.01f;    tempBG_Vertex[3][1] = -2.01f;
    
    tempBG_Color[0][0] = rotate_Color[0][0];    tempBG_Color[0][1] = rotate_Color[0][1];    tempBG_Color[0][2] = rotate_Color[0][2];
    tempBG_Color[1][0] = rotate_Color[1][0];    tempBG_Color[1][1] = rotate_Color[1][1];    tempBG_Color[1][2] = rotate_Color[1][2];
    tempBG_Color[2][0] = rotate_Color[2][0];    tempBG_Color[2][1] = rotate_Color[2][1];    tempBG_Color[2][2] = rotate_Color[2][2];
    tempBG_Color[3][0] = rotate_Color[3][0];    tempBG_Color[3][1] = rotate_Color[3][1];    tempBG_Color[3][2] = rotate_Color[3][2];
    
    
    for( i = 0 ; i < 4 ; i++ )
    {
        tempBG_Vertex[i][2] = 0.0f;
        tempBG_Vertex[i][3] = 1.0f;
        
        tempBG_Color[i][3] = 1.0f;
    }

// ***************************
    glDisable(GL_DEPTH_TEST);
// ***************************
    
    glUseProgram(PRG_TEST_SOLID);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, tempBG_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, tempBG_Color);
    glUniformMatrix4fv(UNF_mvpMatrix_TEST_SOLID, 1, GL_FALSE, MATRIX);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);

    
    
    
    // BG sinWave
    GLfloat BG_sinWave[4][25][2][4];
    GLfloat BG_sinWave_Col[4][25][2][4];
    
    for( i = 0 ; i < 4 ; i++ )
    {
        float yShift[2];
        
        if( i % 2 == 0 )
        {
            yShift[0] = 1.2;
            yShift[1] = 1.7;
        }
        else
        {
            yShift[0] = -1.2;
            yShift[1] = -1.7;
        }
        
        for( j = 0 ; j < 25 ; j++ )
        {
             
            BG_sinWave[i][j][0][0] = (j-12)*0.25;
            BG_sinWave[i][j][0][1] = sinf(BG_radian[i] + j*0.1 )*cosf(BG_radian[i+1] + j*0.2 )*0.4 + yShift[0];
            BG_sinWave[i][j][0][2] = 0.01f;
            BG_sinWave[i][j][0][3] = 1.0f;
            BG_sinWave[i][j][1][0] = (j-12)*0.25;
            BG_sinWave[i][j][1][1] = sinf(BG_radian[i] + j*0.1 )*cosf(BG_radian[i+1] + j*0.2 )*0.4 + yShift[1];
            BG_sinWave[i][j][1][2] = 0.01f;
            BG_sinWave[i][j][1][3] = 1.0f;
            
            BG_sinWave_Col[i][j][0][0] = 0.0f;
            BG_sinWave_Col[i][j][0][1] = 0.0f;
            BG_sinWave_Col[i][j][0][2] = 0.0f;
            BG_sinWave_Col[i][j][0][3] = 0.2f;
            BG_sinWave_Col[i][j][1][0] = 0.0f;
            BG_sinWave_Col[i][j][1][1] = 0.0f;
            BG_sinWave_Col[i][j][1][2] = 0.0f;
            BG_sinWave_Col[i][j][1][3] = 0.0f;
        }
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &BG_sinWave[i][0][0][0] );
        glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &BG_sinWave_Col[i][0][0][0] );
    
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 25*2);
    }
// ***************************
    glEnable(GL_DEPTH_TEST);
// ***************************

    
    // BG increment
    for( i = 0 ; i < 5 ; i++ )
    {
        BG_radian[i] += BG_radian_speed[i];
        
        if( BG_radian[i] > M_PI*2.0f )
        {
            BG_radian[i] -= M_PI*2.0f;
        }
    }
    
    for( i = 0 ; i < 3 ; i++ )
    {
        act_BG_HSB[i] += ( BG_HSB[CURRENT_SLOT][i] - act_BG_HSB[i] ) * 0.1f;
    }
    
// ************* BG ******************************************************
// ************* BG ******************************************************
    
    

    
// TAP
    for( i = 0 ; i < M06_TAP_NUM ; i++ )
    {
        float sqrt_COUNTER = sqrtf(TAP_COUNTER[i][0]);
        float pow_COUNTER = powf(TAP_COUNTER[i][1], 10.0f);
        float doublePow = powf(pow_COUNTER, 10.0);
        
        
            for( j = 0 ; j < 19 ; j++ )
            {
                TAP_Vertex[i][j+1][0][0] = TAPED_Center[i][0] + TAP_CircleBase[j][0]*sqrt_COUNTER;
                TAP_Vertex[i][j+1][0][1] = TAPED_Center[i][1] + TAP_CircleBase[j][1]*sqrt_COUNTER;
                TAP_Vertex[i][j+1][0][2] = TAPED_Center[i][2];
                
                TAP_Vertex[i][j+1][1][0] = TAPED_Center[i][0] + TAP_CircleBase[j][0]*pow_COUNTER;
                TAP_Vertex[i][j+1][1][1] = TAPED_Center[i][1] + TAP_CircleBase[j][1]*pow_COUNTER;
                TAP_Vertex[i][j+1][1][2] = TAPED_Center[i][2];
            }
            
            TAP_Vertex[i][0][0][0]=TAP_Vertex[i][0][1][0] = TAP_Vertex[i][1][0][0];
            TAP_Vertex[i][0][0][1]=TAP_Vertex[i][0][1][1] = TAP_Vertex[i][1][0][1];
            TAP_Vertex[i][0][0][2]=TAP_Vertex[i][0][1][2] = TAP_Vertex[i][1][0][2];
            TAP_Vertex[i][20][0][0]=TAP_Vertex[i][20][1][0] = TAP_Vertex[i][19][1][0];
            TAP_Vertex[i][20][0][1]=TAP_Vertex[i][20][1][1] = TAP_Vertex[i][19][1][1];
            TAP_Vertex[i][20][0][2]=TAP_Vertex[i][20][1][2] = TAP_Vertex[i][19][1][2];
        
        for( j = 0 ; j < 21 ; j++ )
        {
            TAP_Color[i][j][0][3] = 1.0-doublePow;
            TAP_Color[i][j][1][3] = 1.0-doublePow;
        }
    } // M06_TAP_NUM
    
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, TAP_Vertex );
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, TAP_Color );
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, M06_TAP_NUM*21*2);
    
    
// TAP increment
    for( i = 0 ; i < M06_TAP_NUM ; i++ )
    {
        TAP_COUNTER[i][0] += ( 1.0 - TAP_COUNTER[i][0] )*0.12;
        TAP_COUNTER[i][1] += ( 1.0 - TAP_COUNTER[i][1] )*0.09;
        
        TAPED_Center[i][2] += 0.002;
    }
    
    
    
    
}// module Draw







- (void)saveModule:(NSKeyedArchiver *)archiver saveslot:(Byte)num
{

}

- (void)loadModule:(NSKeyedUnarchiver *)unArchiver loadslot:(Byte)num
{

}


- (void)becomeCurrent
{
    int status;
    
    
    status = glIsProgram(PRG_TEST_SOLID);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M06_Test_SolidColor" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_TEST_SOLID fs:&FS_TEST_SOLID pg:&PRG_TEST_SOLID];
        
        glBindAttribLocation(PRG_TEST_SOLID, 0, "position");
        glBindAttribLocation(PRG_TEST_SOLID, 1, "color");
        
        [self linkProgram:&PRG_TEST_SOLID];
        
        UNF_mvpMatrix_TEST_SOLID = glGetUniformLocation(PRG_TEST_SOLID, "mvpMatrix");
        NSLog(@"%@ UNF_mvpMatrix_TEST_SOLID %d", moduleName, UNF_mvpMatrix_TEST_SOLID );
        
        [self validateProgramAndDeleteShader_vs:&VS_TEST_SOLID fs:&FS_TEST_SOLID pg:&PRG_TEST_SOLID];
    }
}


- (void)becomeBackground
{
    glDeleteProgram(PRG_TEST_SOLID);
}
@end
