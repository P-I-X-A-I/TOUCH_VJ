//
//  M05_Structure.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M05_Structure.h"

@implementation M05_Structure

- (id)initWithDeviceName:(NSString *)deviceName
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
    moduleName = [[NSString alloc] initWithFormat:@"05_Structure"];
    moduleIcon = [UIImage imageNamed:@"M05_Structure"];
    
    // load nib file
    [[NSBundle mainBundle] loadNibNamed:@"M05_Structure" owner:self options:nil];
    
    // Num of Setting pages
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
    int i, j;
    
    Byte tempNum = 0;
    
    BGAlpha_radian = 0.0f;
    BGAlpha_rad_speed = 0.025f;
    
    act_fovy = 90.0f;
    fovy_dist = 90.0f;
    fovy_Weight = 1.0f;
    
    eyeVec[0] = eyeVec[1] = 0.0f;
    eyeVec_dist[0] = eyeVec_dist[1] = 0.0f;
    
    for( i = 0 ; i < 5 ; i++ )// slot num
    {
        
        Background_Color[i][0] = 1.0f;
        Background_Color[i][1] = 0.0f;
        Background_Color[i][2] = 1.0f;
        
        Background_RGB[i][0][0] = Background_RGB[i][1][0] = 1.0f;
        Background_RGB[i][0][1] = Background_RGB[i][1][1] = 1.0f;
        Background_RGB[i][0][2] = Background_RGB[i][1][2] = 1.0f;
    }
    
    
    act_Background_Color[0][0] = act_Background_Color[1][0] = 0.0f;
    act_Background_Color[0][1] = act_Background_Color[1][1] = 0.0f;
    act_Background_Color[0][2] = act_Background_Color[1][2] = 0.0f;
    
    
    
    
    
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        basePoint[i][0] = ( random()%200-100 ) * 0.01f;
        basePoint[i][1] = ( random()%200-100 ) * 0.01f;
        basePoint[i][2] = ( random()%200-100 ) * 0.01f;
        
        stock_basePoint[i][0] = basePoint[i][0];
        stock_basePoint[i][1] = basePoint[i][1];
        stock_basePoint[i][2] = basePoint[i][2];
        
        basePoint_Velocity[i][0] = 0.0f;
        basePoint_Velocity[i][1] = 0.0f;
        basePoint_Velocity[i][2] = 0.0f;
        
        for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {
            tetraBasePoint[i][j][0] = basePoint[i][0] + (random()%200-100)*0.001;
            tetraBasePoint[i][j][1] = basePoint[i][1] + (random()%200-100)*0.001;
            tetraBasePoint[i][j][2] = basePoint[i][2] + (random()%200-100)*0.001;
            
            tetraBasePoint_Vel[i][j][0] = 0.0f;
            tetraBasePoint_Vel[i][j][1] = 0.0f;
            tetraBasePoint_Vel[i][j][2] = 0.0f;
            
            tetraINDEX[i][j] = tempNum;
            tempNum++;
            if (tempNum == M05_RADIANS )
            {
                tempNum = 0;
            }
        }
        
        tetraColorBias[i] = 0.0f;
    }

    
    float baseVec[3];
    
    baseVec[0] = 0.0f;  baseVec[1] = 1.0f;  baseVec[2] = 0.0f;
    
    tetraBase_Vert[0][0] = baseVec[0];
    tetraBase_Vert[0][1] = baseVec[1];
    tetraBase_Vert[0][2] = baseVec[2];
    
    [self initMatrix];
    [self rotate_Zdeg:120.0f];
    [self culculate_vec3:baseVec];
    
    tetraBase_Vert[1][0] = baseVec[0];
    tetraBase_Vert[1][1] = baseVec[1];
    tetraBase_Vert[1][2] = baseVec[2];
    
    [self initMatrix];
    [self rotate_Ydeg:120.0f];
    [self culculate_vec3:baseVec];
    
    tetraBase_Vert[2][0] = baseVec[0];
    tetraBase_Vert[2][1] = baseVec[1];
    tetraBase_Vert[2][2] = baseVec[2];
    
    [self initMatrix];
    [self rotate_Ydeg:120.0f];
    [self culculate_vec3:baseVec];
    
    tetraBase_Vert[3][0] = baseVec[0];
    tetraBase_Vert[3][1] = baseVec[1];
    tetraBase_Vert[3][2] = baseVec[2];
    
    
    
    for( i = 0 ; i < M05_RADIANS ; i++ )
    {
        for( j = 0 ; j < 4 ; j++ )
        {
            tetraRot_Vertex[i][j][0] = baseVec[0];
            tetraRot_Vertex[i][j][1] = baseVec[1];
            tetraRot_Vertex[i][j][2] = baseVec[2];
        }
        
        rotAxis_Xrad[i] = ( random()%628 ) * 0.01;
        rotAxis_Xrad_Speed[i] = (random()%1000 - 500)*0.00002;
        rotAxis_Yrad[i] = ( random()%628 ) * 0.01;
        rotAxis_Yrad_Speed[i] = (random()%1000 - 500)*0.00002;
        rotAxis_Zrad[i] = ( random()%628 ) * 0.01;
        rotAxis_Zrad_Speed[i] = (random()%1000 - 500)*0.00002;
    }
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        for( j = 0 ; j < M05_INTER ; j++ )
        {
            for( int k = 0 ; k < M05_INTER_REPEAT ; k++ )
            {
                act_interPoint[k][i][j][0] = 0.0f;
                act_interPoint[k][i][j][1] = 0.0f;
                act_interPoint[k][i][j][2] = 0.0f;
                act_interPoint[k][i][j][3] = 1.0f;
            }
            
            interPoint_Velocity[i][j][0] = 0.0f;
            interPoint_Velocity[i][j][1] = 0.0f;
            interPoint_Velocity[i][j][2] = 0.0f;
        }
        
        Byte nextINDEX = i+1;
        if( nextINDEX == M05_BASEPOINT )
        {
            nextINDEX = 0;
        }
        
        GLfloat VecToNext[3];
        float weight = 1.0 / (M05_INTER+1);
        VecToNext[0] = (basePoint[nextINDEX][0] - basePoint[i][0])*weight;
        VecToNext[1] = (basePoint[nextINDEX][1] - basePoint[i][1])*weight;
        VecToNext[2] = (basePoint[nextINDEX][2] - basePoint[i][2])*weight;
        
        for( j = 0 ; j < M05_INTER ; j++ )
        {
            interPoint_dist[i][j][0] = basePoint[i][0] + VecToNext[0]*(j+1);
            interPoint_dist[i][j][1] = basePoint[i][1] + VecToNext[1]*(j+1);
            interPoint_dist[i][j][2] = basePoint[i][2] + VecToNext[2]*(j+1);
        }
        
    }// i
    
    
    for( i = 0 ; i < 4 ; i++ )// LP
    {
        act_LP_Color[i] = 0.0f;
        act_LP_Line_Color[i] = 0.0f;
        
        LP_Spike_Center[i][0] = 0.0f;
        LP_Spike_Center[i][1] = 0.0f;
        LP_Spike_Center[i][2] = 0.0f;
        
        LP_Spike_Base[i][0] = tetraBase_Vert[i][0]*0.2;//x
        LP_Spike_Base[i][1] = tetraBase_Vert[i][1]*0.2;//y
        LP_Spike_Base[i][2] = tetraBase_Vert[i][2]*0.2;//z
        
        LP_Spike_NormBase[i][0] = -tetraBase_Vert[i][0];
        LP_Spike_NormBase[i][1] = -tetraBase_Vert[i][1];
        LP_Spike_NormBase[i][2] = -tetraBase_Vert[i][2];
        
        for( j = 0 ; j < M05_NUM_SPIKE ; j++ )
        {
            
            LP_Size[i][j] = 0.0f;
            LP_Size_Dist[i][j] = 1.5f + ( random()%200 )*0.01f;
            LP_Size_Velocity[i][j] = 0.0f;
            LP_Size_Coef[i][j] = 0.9 - (random()%100)*0.001f;
            
            LP_X_Velocity[i][j] = (random()%200-100)*0.0001f;
            LP_Y_Velocity[i][j] = 0.0f;
            LP_Z_Velocity[i][j] = (random()%200-100)*0.0001f;

            
            for( int k = 0 ; k < 4 ; k++ )
            {
                rot_LP_Spike_Base[i][j][k][0] = LP_Spike_Base[k][0];
                rot_LP_Spike_Base[i][j][k][1] = LP_Spike_Base[k][1];
                rot_LP_Spike_Base[i][j][k][2] = LP_Spike_Base[k][2];
            }
            
            for( int k = 0 ; k < 12 ; k++ )
            {                
                act_LP_Spike_Vertex[i][j][k][0] = 0.0f;
                act_LP_Spike_Vertex[i][j][k][1] = 0.0f;
                act_LP_Spike_Vertex[i][j][k][2] = 0.0f;
                act_LP_Spike_Vertex[i][j][k][3] = 1.0f;
                
                act_LP_Spike_Norm[i][j][k][0] = 0.0f;
                act_LP_Spike_Norm[i][j][k][1] = 1.0f;
                act_LP_Spike_Norm[i][j][k][2] = 0.0f;
                
                LP_Spike_Color[i][j][k][0] = 0.0f;
                LP_Spike_Color[i][j][k][1] = 0.0f;
                LP_Spike_Color[i][j][k][2] = 0.0f;
                LP_Spike_Color[i][j][k][3] = 0.0f;
            }
            
            LP_Lines_Vertex[i][j][0][0] = 0.0f;
            LP_Lines_Vertex[i][j][0][1] = 0.0f;
            LP_Lines_Vertex[i][j][0][2] = 0.0f;
            LP_Lines_Vertex[i][j][0][3] = 1.0f;
            LP_Lines_Vertex[i][j][1][0] = 0.0f;
            LP_Lines_Vertex[i][j][1][1] = 0.0f;
            LP_Lines_Vertex[i][j][1][2] = 0.0f;
            LP_Lines_Vertex[i][j][1][3] = 1.0f;
            
            LP_Lines_Color[i][j][0][0] = 0.0f;
            LP_Lines_Color[i][j][0][1] = 0.0f;
            LP_Lines_Color[i][j][0][2] = 0.0f;
            LP_Lines_Color[i][j][0][3] = 0.0f;
            LP_Lines_Color[i][j][1][0] = 0.0f;
            LP_Lines_Color[i][j][1][1] = 0.0f;
            LP_Lines_Color[i][j][1][2] = 0.0f;
            LP_Lines_Color[i][j][1][3] = 0.0f;
        }// j NUM_SPIKE
    } // i - 4
    
    
    
    Pan_Center[0] = 0.0f;
    Pan_Center[1] = 0.0f;
    Pan_Center[2] = 0.0f;
    
    
    
    for( i = 0 ; i < M05_NUM_PAN ; i++ )
    {
        Pan_Vertex[i][0] = 0.0f;
        Pan_Vertex[i][1] = 0.0f;
        Pan_Vertex[i][2] = 0.0f;
        Pan_Vertex[i][3] = 1.0f;
        
        Pan_Velocity[i][0] = 0.0f;
        Pan_Velocity[i][1] = 0.0f;
        Pan_Velocity[i][2] = 0.0f;
        
        Pan_Color[i][0] = 1.0f;
        Pan_Color[i][1] = 1.0f;
        Pan_Color[i][2] = 1.0f;
        Pan_Color[i][3] = 0.0f;
    
        Pan_Vec2[i][0] = 1.0f;
        Pan_Vec2[i][1] = 1.0f;
        
        Pan_Coef[i] = (random()%100)*0.0004 + 0.95;
    }
    
    Pan_Alpha_Dist = 0.0f;
    
    
    
    
    for( i = 0 ; i < 300 ; i++ )
    {
        float randomVec[2];
        float normWeight;
        float radius = (random()%2000-1000)*0.006f;
        randomVec[0] = (random()%200-100)*0.01f;
        randomVec[1] = (random()%200-100)*0.01f;
        
        normWeight = 1.0 / sqrtf(randomVec[0]*randomVec[0] + randomVec[1]*randomVec[1]);
        
        randomVec[0] *= normWeight;
        randomVec[1] *= normWeight;
        
        Pinch_Grid_Vertex[i][0] = randomVec[0]*radius;
        Pinch_Grid_Vertex[i][1] = randomVec[1]*radius;
        Pinch_Grid_Vertex[i][2] = (random()%300-200)*0.01;
        Pinch_Grid_Vertex[i][3] = 1.0f;
        
        Pinch_Grid_Color[i][0] = 0.0f;
        Pinch_Grid_Color[i][1] = 0.0f;
        Pinch_Grid_Color[i][2] = 0.0f;
        Pinch_Grid_Color[i][3] = 0.0f;
    }
    
    Pinch_Alpha = 0.0f;
    act_Pinch_Alpha = 0.0f;
}


- (void)initGUI
{
    SLIDER_BG_HUE.value = Background_Color[CURRENT_SLOT][0];
    SLIDER_BG_SAT.value = Background_Color[CURRENT_SLOT][1];
    SLIDER_BG_BRI.value = Background_Color[CURRENT_SLOT][2];
}








































- (void)moduleDraw:(BOOL)yn FBO:(GLuint *)FBOName
{
    int i, j, k;
 
    float POINT_SIZE;
    if( iPad_model_No == 1 )
    {
        glLineWidth(1.5f);
        POINT_SIZE = 7.0f;
    }
    else if( iPad_model_No == 2 )
    {
        glLineWidth(3.0f);
        POINT_SIZE = 14.0f;
    }

    // Draw Background********************************************************************
    // Draw Background********************************************************************
    glUseProgram(PRG_BG);
    
    glViewport(0, 0, RESOLUTION, RESOLUTION);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    glUniform1i(UNF_BGTexture, 5); // Common BG Texture
    
    
    GLfloat BG_Vertex[4][4];
    GLfloat BG_Color[4][4];
    GLfloat BG_Tex[4][2];
    
    float BGAlpha = sinf(BGAlpha_radian)*0.2f + 0.8f;
    BGAlpha *= (random()%10)*0.01f + 0.9f;
    
    
    BGAlpha_radian += BGAlpha_rad_speed;
    if(BGAlpha_radian > M_PI )
    {
        BGAlpha_radian -= M_PI;
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        BG_Vertex[i][2] = 0.99999f; // Z 1.0 is most far area;
        BG_Vertex[i][3] = 1.0f;
        
        BG_Color[i][3] = BGAlpha;
    }
    
    BG_Color[0][0] = BG_Color[2][0] = act_Background_Color[0][0];
    BG_Color[0][1] = BG_Color[2][1] = act_Background_Color[0][1];
    BG_Color[0][2] = BG_Color[2][2] = act_Background_Color[0][2];

    BG_Color[1][0] = BG_Color[3][0] = act_Background_Color[1][0];
    BG_Color[1][1] = BG_Color[3][1] = act_Background_Color[1][1];
    BG_Color[1][2] = BG_Color[3][2] = act_Background_Color[1][2];
    
    
    float BGSize = 1.2 + (act_fovy-90.0f)*0.005; // (act_fovy-90 ) is -40 ~ 40
    
    BG_Vertex[0][0] = -BGSize;   BG_Vertex[0][1] = BGSize;
    BG_Vertex[1][0] = -BGSize;   BG_Vertex[1][1] = -BGSize;
    BG_Vertex[2][0] = BGSize;    BG_Vertex[2][1] = BGSize;
    BG_Vertex[3][0] = BGSize;    BG_Vertex[3][1] = -BGSize;
    
    BG_Tex[0][0] = 0.5f;   BG_Tex[0][1] = 0.5f;
    BG_Tex[1][0] = 0.5f;   BG_Tex[1][1] = 1.0f;
    BG_Tex[2][0] = 1.0f;   BG_Tex[2][1] = 0.5f;
    BG_Tex[3][0] = 1.0f;   BG_Tex[3][1] = 1.0f;
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, BG_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, BG_Color);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, BG_Tex);
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    

    
    
    

    
    
    
    
    
    [self culc_Tetra];
    
    [self initMatrix];
    
    [self lookAt_Ex:eyeVec[0] Ey:eyeVec[1] Ez:2.5f
                 Vx:eyeVec[0] Vy:eyeVec[1] Vz:0.0f
                 Hx:0.0f Hy:1.0f Hz:0.0f];
    
    [self perspective_fovy:act_fovy aspect:1.0f near:0.1f far:5.0f];
 

    // Pan Point ************************************************
    // Pan Point ************************************************
    
    float Pan_F[M05_NUM_PAN][3];
    float PanVec[3];
    float PanDistance, PanDistance_Weight;
    float pow_Distance;
    
    for( i = 0 ; i < M05_NUM_PAN ; i++ )
    {
        PanVec[0] = Pan_Center[0] - Pan_Vertex[i][0];
        PanVec[1] = Pan_Center[1] - Pan_Vertex[i][1];
        PanVec[2] = Pan_Center[2] - Pan_Vertex[i][2];
        
        PanDistance = sqrtf( PanVec[0]*PanVec[0] + PanVec[1]*PanVec[1] + PanVec[2]*PanVec[2] );
        PanDistance_Weight = 0.01 / PanDistance;
        
        Pan_Vec2[i][1] = ((int)(PanDistance*20.0f))%16;

        pow_Distance = powf(PanDistance, 2.0f);

        if( PanDistance < 0.2 )
        {
                        
            Pan_F[i][0] = -0.1*PanVec[0];
            Pan_F[i][1] = -0.1*PanVec[1];
            Pan_F[i][2] = -0.1*PanVec[2];
        }
        else
        {   
            // normalize to 0.01
            PanVec[0] *= PanDistance_Weight;
            PanVec[1] *= PanDistance_Weight;
            PanVec[2] *= PanDistance_Weight;
            
            Pan_F[i][0] = PanVec[0] * pow_Distance;
            Pan_F[i][1] = PanVec[1] * pow_Distance;
            Pan_F[i][2] = PanVec[2] * pow_Distance;
        }
        
        
        
    }
    
    if( isPanned )
    {
        Pan_Alpha_Dist += ( 1.0f - Pan_Alpha_Dist )*0.3f;
        
        for( i = 0 ; i < M05_NUM_PAN ; i++ )
        {
            Pan_Velocity[i][0] = Pan_Velocity[i][0]*Pan_Coef[i] + Pan_F[i][0];
            Pan_Velocity[i][1] = Pan_Velocity[i][1]*Pan_Coef[i] + Pan_F[i][1];
            Pan_Velocity[i][2] = Pan_Velocity[i][2]*Pan_Coef[i] + Pan_F[i][2];
            
            Pan_Vertex[i][0] += Pan_Velocity[i][0];
            Pan_Vertex[i][1] += Pan_Velocity[i][1];
            Pan_Vertex[i][2] += Pan_Velocity[i][2];
            
            Pan_Vec2[i][0] = Pan_Vertex[i][2]+2.5;
            
            Pan_Color[i][3] = Pan_Alpha_Dist;
        }
    }
    else
    {
        Pan_Alpha_Dist += ( 0.0f - Pan_Alpha_Dist )*0.1f;
        for( i = 0 ; i < M05_NUM_PAN ; i++ )
        {
            Pan_Vertex[i][0] += Pan_Velocity[i][0];
            Pan_Vertex[i][1] += Pan_Velocity[i][1];
            Pan_Vertex[i][2] += Pan_Velocity[i][2];
            
            Pan_Vec2[i][0] = Pan_Vertex[i][2]+2.5;
            
            Pan_Color[i][3] = Pan_Alpha_Dist;
        }
    }
    
    glDisable(GL_DEPTH_TEST);
    glUseProgram(PRG_SOLID);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Pan_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Pan_Color);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, Pan_Vec2);
    glUniformMatrix4fv(UNF_mvpMatrix, 1, GL_FALSE, MATRIX);
    glUniform1f(UNF_pointSize, POINT_SIZE);
    glUniform1i( UNF_texPoint, 1 );
    
    glDrawArrays(GL_POINTS, 0, M05_NUM_PAN);
    
    glEnable(GL_DEPTH_TEST);
   
    
    
    // TETRA **********************************************************************
    // TETRA **********************************************************************

    
// culcurate basepoint ******************************
    double F[3];
    double vecTo[3];
    double distance, distanceWeight;
    double distanceConvert;
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        F[0] = F[1] = F[2] = 0.0f;
        
        for( j = 0 ; j < M05_BASEPOINT ; j++ )
        {
            if( j != i )
            {
                vecTo[0] = stock_basePoint[j][0] - stock_basePoint[i][0];
                vecTo[1] = stock_basePoint[j][1] - stock_basePoint[i][1];
                vecTo[2] = stock_basePoint[j][2] - stock_basePoint[i][2];
                
                distance = sqrtf( vecTo[0]*vecTo[0] + vecTo[1]*vecTo[1] + vecTo[2]*vecTo[2] );
                distanceWeight = 1.0 / distance;
                
                vecTo[0] *= distanceWeight;
                vecTo[1] *= distanceWeight;
                vecTo[2] *= distanceWeight;
                
                distanceConvert = ( distance - 2.0 ) * 0.001;
                
                F[0] += vecTo[0]*distanceConvert;
                F[1] += vecTo[1]*distanceConvert;
                F[2] += vecTo[2]*distanceConvert;
            }
        }// j
            
        
        
        basePoint_Velocity[i][0] = basePoint_Velocity[i][0]*0.98 + F[0];
        basePoint_Velocity[i][1] = basePoint_Velocity[i][1]*0.98 + F[1];
        basePoint_Velocity[i][2] = basePoint_Velocity[i][2]*0.98 + F[2];
        
        basePoint[i][0] += basePoint_Velocity[i][0];
        basePoint[i][1] += basePoint_Velocity[i][1];
        basePoint[i][2] += basePoint_Velocity[i][2];
            
    }// i
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        F[0] = F[1] = F[2] = 0.0f;
        
        
        //culcurate tetra base
        for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {
            vecTo[0] = tetraBasePoint[i][j][0] - basePoint[i][0];
            vecTo[1] = tetraBasePoint[i][j][1] - basePoint[i][1];
            vecTo[2] = tetraBasePoint[i][j][2] - basePoint[i][2];
            
            distance = sqrtf( vecTo[0]*vecTo[0] + vecTo[1]*vecTo[1] + vecTo[2]*vecTo[2] );
            distanceWeight = 1.0 / distance;
            
            vecTo[0] *= distanceWeight;
            vecTo[1] *= distanceWeight;
            vecTo[2] *= distanceWeight;
            
            distanceConvert = (0.3 - distance)*0.02;
            //if( distanceConvert < 0.0f ){ distanceConvert = 0.0f; }
            
            F[0] = vecTo[0] * distanceConvert;
            F[1] = vecTo[1] * distanceConvert;
            F[2] = vecTo[2] * distanceConvert;
            
            tetraBasePoint_Vel[i][j][0] = tetraBasePoint_Vel[i][j][0]*0.95 + F[0];
            tetraBasePoint_Vel[i][j][1] = tetraBasePoint_Vel[i][j][1]*0.95 + F[1];
            tetraBasePoint_Vel[i][j][2] = tetraBasePoint_Vel[i][j][2]*0.95 + F[2];
            
            tetraBasePoint[i][j][0] += tetraBasePoint_Vel[i][j][0];
            tetraBasePoint[i][j][1] += tetraBasePoint_Vel[i][j][1];
            tetraBasePoint[i][j][2] += tetraBasePoint_Vel[i][j][2];
        }
        
        
        // culcurate inter base
        Byte nextINDEX = i+1;
        GLfloat VecToNext[3];
        float interWeight = 1.0 / (M05_INTER+1);
        if( i == M05_BASEPOINT-1 )
        {
            nextINDEX = 0;
        }
        
        VecToNext[0] = (basePoint[nextINDEX][0] - basePoint[i][0])*interWeight;
        VecToNext[1] = (basePoint[nextINDEX][1] - basePoint[i][1])*interWeight;
        VecToNext[2] = (basePoint[nextINDEX][2] - basePoint[i][2])*interWeight;
        
        for( j = 0 ; j < M05_INTER ; j++ )
        {
            interPoint_dist[i][j][0] = basePoint[i][0] + VecToNext[0]*(j+1);
            interPoint_dist[i][j][1] = basePoint[i][1] + VecToNext[1]*(j+1);
            interPoint_dist[i][j][2] = basePoint[i][2] + VecToNext[2]*(j+1);
        }
        
    }
    
    
// 
    GLfloat tempVertex[M05_BASEPOINT][M05_TETRA_NUM][12][4];
    GLfloat tempColor[M05_BASEPOINT][M05_TETRA_NUM][12][4];
    GLfloat tempNorm[M05_BASEPOINT][M05_TETRA_NUM][12][3];
    GLfloat scaledBlur_Vertex[M05_BLUR][M05_BASEPOINT][M05_TETRA_NUM][12][4];
    float Alpha, tempZ;
    
    GLfloat scaleFactor[M05_BASEPOINT][M05_TETRA_NUM];
    
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        
        for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {
            tempZ = tetraBasePoint[i][j][2];
            
            if (fabsf(tempZ) > 1.0)
            {
                tempZ = 1.0f;
            }
            
            Alpha = 1.0 - tempZ*tempZ;
            
            scaleFactor[i][j] = Alpha;
            
            for( k = 0 ; k < 12 ; k++ )
            {
                tempVertex[i][j][k][3] = 1.0f;
            
                tempColor[i][j][k][0] = (1.0-Alpha)*0.1 + tetraColorBias[i];
                tempColor[i][j][k][1] = (1.0-Alpha)*0.1 + tetraColorBias[i];
                tempColor[i][j][k][2] = (1.0-Alpha)*0.1 + tetraColorBias[i];
                tempColor[i][j][k][3] = Alpha*0.2 + 0.8;
                
                for( int l = 0 ; l < M05_BLUR ; l++ )
                {
                    scaledBlur_Vertex[l][i][j][k][3] = 1.0f;
                }
            }
        }
    }
    
    
    float sizedTetraRot_Vertex[M05_RADIANS][4][3];
    float tetraSize = 0.2;
    for( i = 0 ; i < M05_RADIANS ; i++ )
    {
        for( j = 0 ; j < 4 ; j++ )
        {
            sizedTetraRot_Vertex[i][j][0] = tetraRot_Vertex[i][j][0] * tetraSize;
            sizedTetraRot_Vertex[i][j][1] = tetraRot_Vertex[i][j][1] * tetraSize;
            sizedTetraRot_Vertex[i][j][2] = tetraRot_Vertex[i][j][2] * tetraSize;
        }
    }
    
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {
            for( k = 0 ; k < 3 ; k++ )
            {
                tempVertex[i][j][0][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][1][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][2][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k] + tetraBasePoint[i][j][k];
            
                tempVertex[i][j][3][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][4][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][5][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k] + tetraBasePoint[i][j][k];
            
                tempVertex[i][j][6][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][7][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][8][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k] + tetraBasePoint[i][j][k];
        
                tempVertex[i][j][9][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][10][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k] + tetraBasePoint[i][j][k];
                tempVertex[i][j][11][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k] + tetraBasePoint[i][j][k];
            
                tempNorm[i][j][0][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][0][k];
                tempNorm[i][j][1][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][0][k];
                tempNorm[i][j][2][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][0][k];
            
                tempNorm[i][j][3][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][3][k];
                tempNorm[i][j][4][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][3][k];
                tempNorm[i][j][5][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][3][k];
            
                tempNorm[i][j][6][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][1][k];
                tempNorm[i][j][7][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][1][k];
                tempNorm[i][j][8][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][1][k];
                
                tempNorm[i][j][9][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][2][k];
                tempNorm[i][j][10][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][2][k];
                tempNorm[i][j][11][k] = -tetraRot_Vertex[ tetraINDEX[i][j] ][2][k];
                

                // scaled
                for( int l = 0 ; l < M05_BLUR ; l++ )
                {   
                    float scale = (1.0 - scaleFactor[i][j]) + l*0.075 + tetraColorBias[i];
                    scaledBlur_Vertex[l][i][j][0][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][1][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][2][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k]*scale + tetraBasePoint[i][j][k];

                    scaledBlur_Vertex[l][i][j][3][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][4][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][5][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k]*scale + tetraBasePoint[i][j][k];

                    scaledBlur_Vertex[l][i][j][6][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][7][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][8][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][2][k]*scale + tetraBasePoint[i][j][k];

                    scaledBlur_Vertex[l][i][j][9][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][0][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][10][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][1][k]*scale + tetraBasePoint[i][j][k];
                    scaledBlur_Vertex[l][i][j][11][k] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][3][k]*scale + tetraBasePoint[i][j][k];
                }// l
            }// k
        }// j
    }// i
    
    
    // TETRA BLUR ***********************************************************************
    // TETRA BLUR ***********************************************************************
    GLfloat blur_Vertex[M05_BASEPOINT][M05_TETRA_NUM][4][6][4];
    GLfloat blur_Color[M05_BASEPOINT][M05_TETRA_NUM][4][6][4];
    GLfloat blurVec[3];
    GLfloat blurDistance, blurDistanceWeight;
    GLfloat blurAlpha[2];
    GLfloat blurLength;
    
    blurAlpha[0] = 0.125f + sinf(BGAlpha_radian)*0.125f;
    blurAlpha[1] = 0.05f + sinf(BGAlpha_radian)*0.05f;
    blurLength = 0.2f*sinf(BGAlpha_radian) + 0.2f;
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {
            blurVec[0] = 0.0 - tetraBasePoint[i][j][0];
            blurVec[1] = 5.0 - tetraBasePoint[i][j][1];
            blurVec[2] = 0.0 - tetraBasePoint[i][j][2];
            
            blurDistance = sqrtf( blurVec[0]*blurVec[0] + blurVec[1]*blurVec[1] + blurVec[2]*blurVec[2] );
            blurDistanceWeight = blurLength / blurDistance;
            
            blurVec[0] *= blurDistanceWeight;
            blurVec[1] *= blurDistanceWeight;
            blurVec[2] *= blurDistanceWeight;
            
            for( k = 0 ; k < 4 ; k++ )
            {
                for( int l = 0 ; l < 6 ; l++ )
                {
                    blur_Vertex[i][j][k][l][3] = 1.0f;
                    blur_Color[i][j][k][l][0] = 0.0f;
                    blur_Color[i][j][k][l][1] = 0.0f;
                    blur_Color[i][j][k][l][2] = 0.0f;
                }
                
                
                blur_Vertex[i][j][k][0][0] = blur_Vertex[i][j][k][1][0] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][k][0] + tetraBasePoint[i][j][0];
                blur_Vertex[i][j][k][0][1] = blur_Vertex[i][j][k][1][1] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][k][1] + tetraBasePoint[i][j][1];
                blur_Vertex[i][j][k][0][2] = blur_Vertex[i][j][k][1][2] = sizedTetraRot_Vertex[ tetraINDEX[i][j] ][k][2] + tetraBasePoint[i][j][2];
                blur_Color[i][j][k][0][3] = blur_Color[i][j][k][1][3] = blurAlpha[0];
                
                blur_Vertex[i][j][k][2][0] = tetraBasePoint[i][j][0];
                blur_Vertex[i][j][k][2][1] = tetraBasePoint[i][j][1];
                blur_Vertex[i][j][k][2][2] = tetraBasePoint[i][j][2];
                blur_Color[i][j][k][2][3] = blurAlpha[1];
                
                blur_Vertex[i][j][k][3][0] = blur_Vertex[i][j][k][1][0] - blurVec[0];
                blur_Vertex[i][j][k][3][1] = blur_Vertex[i][j][k][1][1] - blurVec[1];
                blur_Vertex[i][j][k][3][2] = blur_Vertex[i][j][k][1][2] - blurVec[2];
                blur_Color[i][j][k][3][3] = 0.0f;
                
                blur_Vertex[i][j][k][5][0] = blur_Vertex[i][j][k][4][0] = blur_Vertex[i][j][k][2][0] - blurVec[0];
                blur_Vertex[i][j][k][5][1] = blur_Vertex[i][j][k][4][1] = blur_Vertex[i][j][k][2][1] - blurVec[1];
                blur_Vertex[i][j][k][5][2] = blur_Vertex[i][j][k][4][2] = blur_Vertex[i][j][k][2][2] - blurVec[2];
                blur_Color[i][j][k][5][3] = blur_Color[i][j][k][4][3] = 0.0f;
            }
        }
    }
    
    
    //**************************************************
    glDisable(GL_DEPTH_TEST);
    //**************************************************
    
    // Draw Blur
    glUseProgram(PRG_DARK);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, blur_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, blur_Color);
    glUniformMatrix4fv(UNF_mvpMatrix, 1, GL_FALSE, MATRIX );
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, M05_BASEPOINT*M05_TETRA_NUM*4*6);

    //**************************************************
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    glEnable(GL_DEPTH_TEST);
    //**************************************************

    // Draw Tetra
    glUseProgram(PRG_TETRA);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, tempVertex );
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, tempColor );
    glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, tempNorm );
    glUniformMatrix4fv(UNF_mvpMatrix, 1, GL_FALSE, MATRIX);
    glUniform3fv(UNF_lightColor, 3, &act_Background_Color[0][0]);
    
    glDrawArrays(GL_TRIANGLES, 0, M05_BASEPOINT*M05_TETRA_NUM*12);    

 
    

    // Draw BOKE***********************************************    
    // Draw BOKE***********************************************    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {for( j = 0 ; j < M05_TETRA_NUM ; j++ )
        {for( k = 0 ; k < 12 ; k++ )
            {
                tempColor[i][j][k][3] = 0.15f;
            }
        }
    }
    
    for( i = 0 ; i < M05_BLUR ; i++ )
    {
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &scaledBlur_Vertex[i][0][0][0][0]);
        glDrawArrays(GL_TRIANGLES, 0, M05_BASEPOINT*M05_TETRA_NUM*12);    
    }
    // Draw BOKE***********************************************    
    // Draw BOKE***********************************************    
   
    
    
    
    
    
    
    
    
    
    
    
    
    // *** LONG PRESS ************************************************************************
    // *** LONG PRESS ************************************************************************
    
    
    for( i = 0 ; i < 4 ; i++ )
    {
        if( isLongPressed[i] )
        {
            act_LP_Color[i] += ( 0.0f - act_LP_Color[i] )*0.1f;

            for( j = 0 ; j < M05_NUM_SPIKE ; j++ )
            {
                LP_Size_Velocity[i][j] = LP_Size_Velocity[i][j]*LP_Size_Coef[i][j]*0.8 + ((1.0 + act_LP_Color[i])*2.0 - LP_Size[i][j])*0.3f;
                LP_Size[i][j] += LP_Size_Velocity[i][j];
                
                
                
                for( k = 0 ; k < 12 ; k++ )
                {
                    LP_Spike_Color[i][j][k][0] = LP_Spike_Color[i][j][k][1] = LP_Spike_Color[i][j][k][2] = act_LP_Color[i];
                }
                
                LP_Lines_Color[i][j][0][3] = act_LP_Line_Color[i];
                //LP_Lines_Color[i][j][1][3] = act_LP_Line_Color[i];
            }// j
        }// if isLongPressed
        else
        {
            for( j = 0 ; j < M05_NUM_SPIKE ; j++ )
            {
                LP_Y_Velocity[i][j] += ((LP_Y_Velocity[i][j]*LP_Size_Coef[i][j])*0.02 - 0.00098);
                
                for( k = 0 ; k < 4 ; k++ )
                {
                    rot_LP_Spike_Base[i][j][k][0] += LP_X_Velocity[i][j];
                    rot_LP_Spike_Base[i][j][k][1] += LP_Y_Velocity[i][j];
                    rot_LP_Spike_Base[i][j][k][2] += LP_Z_Velocity[i][j];
                }
                
                
                for( k = 0 ; k < 12 ; k++ )
                {
                    LP_Spike_Color[i][j][k][3] += ( 0.0f - LP_Spike_Color[i][j][k][3] )*0.05f;
                }
                
                LP_Lines_Color[i][j][0][3] = act_LP_Line_Color[i];
               // LP_Lines_Color[i][j][1][3] = act_LP_Line_Color[i];
            }// j            
        }// else
        
        
        
        for( j = 0 ; j < M05_NUM_SPIKE ; j++ )
        {
            
            for( k = 0 ; k < 3 ; k++ )
            {
                LP_Lines_Vertex[i][j][0][k] = LP_Spike_Center[i][k];
                LP_Lines_Vertex[i][j][1][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][0][k]*10.0f; 
                
                act_LP_Spike_Vertex[i][j][0][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][1][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][1][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][2][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][2][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][3][k]*LP_Size[i][j];
                
                act_LP_Spike_Vertex[i][j][3][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][0][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][4][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][2][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][5][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][1][k]*LP_Size[i][j];
                
                act_LP_Spike_Vertex[i][j][6][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][0][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][7][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][3][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][8][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][2][k]*LP_Size[i][j];
                
                act_LP_Spike_Vertex[i][j][9][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][0][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][10][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][1][k]*LP_Size[i][j]; 
                act_LP_Spike_Vertex[i][j][11][k] = LP_Spike_Center[i][k] + rot_LP_Spike_Base[i][j][3][k]*LP_Size[i][j]; 
            }// k
        }// j M05_NUM_SPIKE
    } // i 4
    
    
    
    
    glUseProgram(PRG_TETRA);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, act_LP_Spike_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, LP_Spike_Color);
    glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, act_LP_Spike_Norm);
    glUniformMatrix4fv(UNF_mvpMatrix, 1, GL_FALSE, MATRIX);
    glUniform3fv(UNF_lightColor, 3, &act_Background_Color[0][0]);

    glDrawArrays(GL_TRIANGLES, 0, 4*M05_NUM_SPIKE*12);
    
 
    glUseProgram(PRG_LINE);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, LP_Lines_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, LP_Lines_Color);
    glUniformMatrix4fv(UNF_mvpMatrix_LINE, 1, GL_FALSE, MATRIX);
    
    glDrawArrays(GL_LINES, 0, 4*M05_NUM_SPIKE*2);
    
    
    for( i = 0 ; i < 300 ; i++ )
    {
        Pinch_Grid_Color[i][3] = act_Pinch_Alpha;
        Pinch_Grid_Vertex[i][1]+=0.003;
        
        if(Pinch_Grid_Vertex[i][1] > 5.0f)
        {
            Pinch_Grid_Vertex[i][1] -= 10.0f;
        }
    }
    
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Pinch_Grid_Vertex);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Pinch_Grid_Color);
    
    glDrawArrays(GL_POINTS, 0, 300);
    
    
    
    // Inter Point ********************************************************
    // Inter Point ********************************************************
    
    GLfloat interF[3];
    GLfloat interVec[3];
    GLfloat interDistance, interDistanceWeight;
    GLfloat F_weight;
    
    //:::::::::::::::::::::::::::::::::
    
    for( i = M05_INTER_REPEAT-1 ; i > 0 ; i-- )
    {
        for( j = 0 ; j < M05_BASEPOINT ; j++ )
        {
            for( k = 0 ; k < M05_INTER ; k++ )
            {
                act_interPoint[i][j][k][0] = act_interPoint[i-1][j][k][0];
                act_interPoint[i][j][k][1] = act_interPoint[i-1][j][k][1];
                act_interPoint[i][j][k][2] = act_interPoint[i-1][j][k][2];
            }
        }
    }
    
    //:::::::::::::::::::::::::::::::::
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        for( j = 0 ; j < M05_INTER ; j++ )
        {
            interVec[0] = interPoint_dist[i][j][0] - act_interPoint[0][i][j][0];
            interVec[1] = interPoint_dist[i][j][1] - act_interPoint[0][i][j][1];
            interVec[2] = interPoint_dist[i][j][2] - act_interPoint[0][i][j][2];
            
            interDistance = sqrtf( interVec[0]*interVec[0] + interVec[1]*interVec[1] + interVec[2]*interVec[2] );
            interDistanceWeight = 0.01 / interDistance;
            
            F_weight = interDistanceWeight * sqrtf(interDistance);
            
            interVec[0] *= F_weight;
            interVec[1] *= F_weight;
            interVec[2] *= F_weight;
            
            interF[0] = interVec[0];
            interF[1] = interVec[1];
            interF[2] = interVec[2];
            
            interPoint_Velocity[i][j][0] = interPoint_Velocity[i][j][0]*0.96 + interF[0];
            interPoint_Velocity[i][j][1] = interPoint_Velocity[i][j][1]*0.96 + interF[1];
            interPoint_Velocity[i][j][2] = interPoint_Velocity[i][j][2]*0.96 + interF[2];
            
            act_interPoint[0][i][j][0] += interPoint_Velocity[i][j][0];
            act_interPoint[0][i][j][1] += interPoint_Velocity[i][j][1];
            act_interPoint[0][i][j][2] += interPoint_Velocity[i][j][2];
        }
    }
    
    GLfloat tempPointColor[5][M05_BASEPOINT][M05_INTER][4];
    GLfloat tempSizeWeight[5][M05_BASEPOINT][M05_INTER][2];
    
    for( i = 0 ; i < M05_INTER_REPEAT ; i++ )
    {
        for( j = 0 ; j < M05_BASEPOINT ; j++ )
        {            
            for( k = 0 ; k < M05_INTER ; k++ )
            {
                float depthWeight = (act_interPoint[i][j][k][2]+3.0f)*0.4f; // 0.2 -- 2.2
                
                float lineAlpha = sqrtf(interPoint_Velocity[j][k][0]*interPoint_Velocity[j][k][0] +
                                        interPoint_Velocity[j][k][1]*interPoint_Velocity[j][k][1] +
                                        interPoint_Velocity[j][k][2]*interPoint_Velocity[j][k][2]
                                        )*5.0f;
                if( lineAlpha > 1.0 )
                { lineAlpha = 1.0f; }
                
                tempPointColor[i][j][k][0] = 1.0f;
                tempPointColor[i][j][k][1] = 1.0f;
                tempPointColor[i][j][k][2] = 1.0f;
                tempPointColor[i][j][k][3] = lineAlpha;
                
                tempSizeWeight[i][j][k][0] = lineAlpha*3.0f*depthWeight + 1.0f;
                tempSizeWeight[i][j][k][1] = (int)(lineAlpha*30.0 + (act_interPoint[i][j][k][2]+2.5)*40.0f)%16; // must be 0.0 - 15.0
            }
        }
    }
    
    //::::::::::::::::::::::::::::::::
    
       
    
    glUseProgram(PRG_SOLID);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, act_interPoint);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, tempPointColor);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, tempSizeWeight);
    glUniformMatrix4fv(UNF_mvpMatrix, 1, GL_FALSE, MATRIX);
    glUniform1f(UNF_pointSize, POINT_SIZE);
    glUniform1i( UNF_texPoint, 1 );
    
    glDrawArrays(GL_POINTS, 0, M05_INTER_REPEAT*M05_BASEPOINT*M05_INTER);
    
    
   
    glFlush();
    
    
 
    
    
    
    
    
    
    
    
    
    
    // increment etc...
    
    act_fovy += ( fovy_dist - act_fovy )*0.03f;
    fovy_Weight = tanf(act_fovy*0.5*0.0174532925) / tanf(90.0f*0.5*0.0174532925);
    
    eyeVec[0] += ( eyeVec_dist[0] - eyeVec[0] )*0.1f;
    eyeVec[1] += ( eyeVec_dist[1] - eyeVec[1] )*0.1f;
    
    for( i = 0 ; i < 3 ; i++ )
    {
        act_Background_Color[0][i] += ( Background_RGB[CURRENT_SLOT][0][i] - act_Background_Color[0][i] )*0.1f;
        act_Background_Color[1][i] += ( Background_RGB[CURRENT_SLOT][1][i] - act_Background_Color[1][i] )*0.1f;
    }
    
    
    for( i = 0 ; i < M05_BASEPOINT ; i++ )
    {
        stock_basePoint[i][0] = basePoint[i][0];
        stock_basePoint[i][1] = basePoint[i][1];
        stock_basePoint[i][2] = basePoint[i][2];
        
        tetraColorBias[i] += ( 0.0f - tetraColorBias[i] ) * 0.05f;
    }
    
    for( i = 0 ; i < M05_RADIANS ; i++ )
    {
        rotAxis_Xrad[i] += rotAxis_Xrad_Speed[i];
        rotAxis_Yrad[i] += rotAxis_Yrad_Speed[i];
        rotAxis_Zrad[i] += rotAxis_Zrad_Speed[i];
        
        if( rotAxis_Xrad[i] > M_PI*2.0 )
        { rotAxis_Xrad[i] -= M_PI*2.0f; }
        else if( rotAxis_Xrad[i] < 0.0f )
        { rotAxis_Xrad[i] += M_PI*2.0f; }
        
        if( rotAxis_Yrad[i] > M_PI*2.0f )
        { rotAxis_Yrad[i] -= M_PI*2.0f; }
        else if( rotAxis_Yrad[i] < 0.0f )
        { rotAxis_Yrad[i] += M_PI*2.0f; }
        
        if( rotAxis_Zrad[i] > M_PI*2.0f )
        { rotAxis_Zrad[i] -= M_PI*2.0f; }
        else if( rotAxis_Zrad[i] < 0.0f )
        { rotAxis_Zrad[i] += M_PI*2.0f; }
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        act_LP_Line_Color[i] += ( 0.0f - act_LP_Line_Color[i] )*0.1f;
    }
    
    act_Pinch_Alpha += ( Pinch_Alpha - act_Pinch_Alpha )*0.02f;
}




- (void)saveModule:(NSKeyedArchiver *)archiver saveslot:(Byte)num
{
    // Background_Color
    [archiver encodeBytes:(const uint8_t *)&Background_Color[0][0]
                   length:sizeof(Background_Color)
                   forKey:[NSString stringWithFormat:@"M05_Background_Color_%d", num]];
    
    // Background_RGB
    [archiver encodeBytes:(const uint8_t *)&Background_RGB[0][0][0]
                   length:sizeof(Background_RGB)
                   forKey:[NSString stringWithFormat:@"M05_Background_RGB_%d", num]];
}

- (void)loadModule:(NSKeyedUnarchiver *)unArchiver loadslot:(Byte)num
{
    NSUInteger LENGTH;
    int i, iter;
    
    // Background_Color
    const uint8_t* Background_Color_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M05_Background_Color_%d", num]
                                                               returnedLength:&LENGTH];
    
    if( Background_Color_DecodePtr != NULL )
    {
        GLfloat* Background_Color_Copy = (GLfloat*)malloc(sizeof(Background_Color));
        GLfloat* Background_Color_Free = Background_Color_Copy;
        GLfloat* Background_Color_Assignment = &Background_Color[0][0];
        iter = sizeof(Background_Color) / sizeof(GLfloat);
        
        memcpy(Background_Color_Copy, Background_Color_DecodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Background_Color_Assignment = *Background_Color_Copy;
            Background_Color_Assignment++;
            Background_Color_Copy++;
        }
        
        free(Background_Color_Free);
    }
    
    
    // Background_RGB
    const uint8_t* Background_RGB_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M05_Background_RGB_%d", num]
                                                             returnedLength:&LENGTH];
    
    if( Background_RGB_DecodePtr != NULL )
    {
        GLfloat* Background_RGB_Copy = (GLfloat*)malloc(sizeof(Background_RGB));
        GLfloat* Background_RGB_Free = Background_RGB_Copy;
        GLfloat* Background_RGB_Assignment = &Background_RGB[0][0][0];
        iter = sizeof(Background_RGB) / sizeof(GLfloat);
        
        memcpy(Background_RGB_Copy, Background_RGB_DecodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Background_RGB_Assignment = *Background_RGB_Copy;
            Background_RGB_Assignment++;
            Background_RGB_Copy++;
        }
        
        free(Background_RGB_Free);
    }
    
    [self initGUI];
}




- (void)becomeCurrent
{
    int status;

    
    // BG Shader *******************************
    status = glIsProgram(PRG_BG);
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M05_Background" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_BG fs:&FS_BG pg:&PRG_BG];
        
        glBindAttribLocation(PRG_BG, 0, "position");
        glBindAttribLocation(PRG_BG, 1, "color");
        glBindAttribLocation(PRG_BG, 2, "texCoord");
        
        [self linkProgram:&PRG_BG];
        
        UNF_BGTexture = glGetUniformLocation(PRG_BG, "BGTexture");
        NSLog(@"%@ UNF_BGTexture %d", moduleName, UNF_BGTexture);
        
        [self validateProgramAndDeleteShader_vs:&VS_BG fs:&FS_BG pg:&PRG_BG];
    }
    
    // Tetra Shader
    status = glIsProgram( PRG_TETRA );
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M05_Tetra" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_TETRA fs:&FS_TETRA pg:&PRG_TETRA];
        
        glBindAttribLocation(PRG_TETRA, 0, "position");
        glBindAttribLocation(PRG_TETRA, 1, "color");
        glBindAttribLocation(PRG_TETRA, 2, "normal");
        
        [self linkProgram:&PRG_TETRA];
        
        UNF_mvpMatrix_Tetra = glGetUniformLocation(PRG_TETRA, "mvpMatrix");
        UNF_lightColor = glGetUniformLocation(PRG_TETRA, "lightColor");
        NSLog(@"%@ UNF_mvpMatrix_Tetra %d", moduleName, UNF_mvpMatrix_Tetra );
        NSLog(@"%@ UNF_lightColor %d", moduleName, UNF_lightColor );
        
        [self validateProgramAndDeleteShader_vs:&VS_TETRA fs:&FS_TETRA pg:&PRG_TETRA];
    }
    
    // Solid Shader *****************************
    status = glIsProgram(PRG_SOLID);
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M05_SolidColor" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
        
        glBindAttribLocation(PRG_SOLID, 0, "position");
        glBindAttribLocation(PRG_SOLID, 1, "color");
        glBindAttribLocation(PRG_SOLID, 2, "sizeWeight");
        
        [self linkProgram:&PRG_SOLID];
        
        UNF_mvpMatrix = glGetUniformLocation(PRG_SOLID, "mvpMatrix");
        UNF_pointSize = glGetUniformLocation(PRG_SOLID, "pointSize");
        UNF_texPoint = glGetUniformLocation(PRG_SOLID, "texPoint");
        NSLog(@"%@ UNF_mvpMatrix %d", moduleName, UNF_mvpMatrix);
        NSLog(@"%@ UNF_pointSize %d", moduleName, UNF_pointSize);
        NSLog(@"%@ UNF_texPoint %d", moduleName, UNF_texPoint);
        
        [self validateProgramAndDeleteShader_vs:&VS_SOLID fs:&FS_SOLID pg:&PRG_SOLID];
    }

    glGenTextures(1, &TEX_Point);
    NSInteger ImgWidth;
    NSInteger ImgHeight;
    CGContextRef textureContext;
    GLubyte* texPointer;
    
    CGImageRef patternTexture = [UIImage imageNamed:@"M05Texture.png"].CGImage;
    
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
    glBindTexture(GL_TEXTURE_2D, TEX_Point);
    
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

    // DRAR Shader
    status = glIsProgram( PRG_DARK );
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M05_darkBlur" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_DARK fs:&FS_DARK pg:&PRG_DARK];
        
        glBindAttribLocation(PRG_TETRA, 0, "position");
        glBindAttribLocation(PRG_TETRA, 1, "color");
        
        [self linkProgram:&PRG_DARK];
        
        UNF_mvpMatrix_DARK = glGetUniformLocation(PRG_TETRA, "mvpMatrix");
        NSLog(@"%@ UNF_mvpMatrix_DARK %d", moduleName, UNF_mvpMatrix_DARK );
        
        [self validateProgramAndDeleteShader_vs:&VS_DARK fs:&FS_DARK pg:&PRG_DARK];
    }
    
    
    // Line
    status = glIsProgram(PRG_LINE);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M05_SolidLine" ofType:@"vsh"];
        
        [self readShaderSourcePath:shaderPath vs:&VS_LINE fs:&FS_LINE pg:&PRG_LINE];
        
        glBindAttribLocation(PRG_LINE, 0, "position");
        glBindAttribLocation(PRG_LINE, 1, "color");
        
        [self linkProgram:&PRG_LINE];
        
        UNF_mvpMatrix_LINE = glGetUniformLocation(PRG_LINE, "mvpMatrix");
        NSLog(@"%@ UNF_mvpMatrix_LINE %d", moduleName, UNF_mvpMatrix_LINE);
        
        [self validateProgramAndDeleteShader_vs:&VS_LINE fs:&FS_LINE pg:&PRG_LINE];
    }
    
}


- (void)becomeBackground
{

    glDeleteProgram(PRG_BG);
    glDeleteProgram(PRG_TETRA);
    glDeleteProgram(PRG_SOLID);
    glDeleteProgram(PRG_DARK);
    glDeleteProgram(PRG_LINE);
    
    glDeleteTextures(1, &TEX_Point);
}

@end
