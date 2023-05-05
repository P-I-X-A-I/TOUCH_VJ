
#import "M05_Structure.h"

@implementation M05_Structure ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    GLfloat tapX = (*tapX_ptr)*fovy_Weight;
    GLfloat tapY = (*tapY_ptr)*0.75*fovy_Weight;
    
    Byte INDEX = random()%M05_BASEPOINT;
    float randomZ = (random()%200-100)*0.015f;
    float depthWeight = 2.5f - randomZ;
    
    
    stock_basePoint[INDEX][0] = basePoint[INDEX][0] = tapX*depthWeight + eyeVec[0];
    stock_basePoint[INDEX][1] = basePoint[INDEX][1] = tapY*depthWeight + eyeVec[1];
    stock_basePoint[INDEX][2] = basePoint[INDEX][2] = randomZ;
    
    for( int i = 0 ; i < M05_TETRA_NUM ; i++ )
    {
        tetraBasePoint[INDEX][i][0] = basePoint[INDEX][0] + (random()%200-100)*0.01;
        tetraBasePoint[INDEX][i][1] = basePoint[INDEX][1] + (random()%200-100)*0.01;
        tetraBasePoint[INDEX][i][2] = basePoint[INDEX][2] + (random()%200-100)*0.01;
    }
    
    tetraColorBias[INDEX] = 1.0f;
}

- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    int i, j;
    
    GLfloat X = (*LPress_X_ptr)*fovy_Weight;
    GLfloat Y = (*LPress_Y_ptr*0.75)*fovy_Weight;
    
    matrixClass* tempMatrix = [[matrixClass alloc] init];
    
    if( !isLongPressed[LPress_INDEX] )
    {
        isLongPressed[LPress_INDEX] = YES;
        
        float randomZ = (random()%100-50)*-0.01;
        float depthWeight = 2.5f - randomZ;
    
        LP_Spike_Center[LPress_INDEX][0] = X*depthWeight + eyeVec[0];
        LP_Spike_Center[LPress_INDEX][1] = Y*depthWeight + eyeVec[1];
        LP_Spike_Center[LPress_INDEX][2] = randomZ;
        
        
        
        GLfloat temp_LP_Spike_NormBase[M05_NUM_SPIKE][4][3];
        
        act_LP_Color[LPress_INDEX] = 1.0f;
        act_LP_Line_Color[LPress_INDEX] = 1.0f;
        
        for( i = 0 ; i < M05_NUM_SPIKE ; i++ )
        {
            rot_LP_Spike_Base[LPress_INDEX][i][0][0] = LP_Spike_Base[0][0];
            rot_LP_Spike_Base[LPress_INDEX][i][0][1] = LP_Spike_Base[0][1];
            rot_LP_Spike_Base[LPress_INDEX][i][0][2] = LP_Spike_Base[0][2];
            
            rot_LP_Spike_Base[LPress_INDEX][i][1][0] = LP_Spike_Base[1][0]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][1][1] = LP_Spike_Base[1][1]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][1][2] = LP_Spike_Base[1][2]*0.5;
            
            rot_LP_Spike_Base[LPress_INDEX][i][2][0] = LP_Spike_Base[2][0]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][2][1] = LP_Spike_Base[2][1]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][2][2] = LP_Spike_Base[2][2]*0.5;
            
            rot_LP_Spike_Base[LPress_INDEX][i][3][0] = LP_Spike_Base[3][0]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][3][1] = LP_Spike_Base[3][1]*0.5;
            rot_LP_Spike_Base[LPress_INDEX][i][3][2] = LP_Spike_Base[3][2]*0.5;
            
           for( j = 0 ; j < 4 ; j++ )
            {                
                temp_LP_Spike_NormBase[i][j][0] = LP_Spike_NormBase[j][0];
                temp_LP_Spike_NormBase[i][j][1] = LP_Spike_NormBase[j][1];
                temp_LP_Spike_NormBase[i][j][2] = LP_Spike_NormBase[j][2];
            }
            
            [tempMatrix initMatrix];
            [tempMatrix rotate_Xdeg:(float)(random()%360)];
            [tempMatrix rotate_Ydeg:(float)(random()%360)];
            [tempMatrix rotate_Zdeg:(float)(random()%360)];
            
            [tempMatrix culculate_vec3:&rot_LP_Spike_Base[LPress_INDEX][i][0][0]];
            [tempMatrix culculate_vec3:&rot_LP_Spike_Base[LPress_INDEX][i][1][0]];
            [tempMatrix culculate_vec3:&rot_LP_Spike_Base[LPress_INDEX][i][2][0]];
            [tempMatrix culculate_vec3:&rot_LP_Spike_Base[LPress_INDEX][i][3][0]];
            
            [tempMatrix culculate_vec3:&temp_LP_Spike_NormBase[i][0][0]];
            [tempMatrix culculate_vec3:&temp_LP_Spike_NormBase[i][1][0]];
            [tempMatrix culculate_vec3:&temp_LP_Spike_NormBase[i][2][0]];
            [tempMatrix culculate_vec3:&temp_LP_Spike_NormBase[i][3][0]];
        }
    
    
        for( i = 0 ; i < M05_NUM_SPIKE ; i++ )
        {
            LP_Size_Dist[LPress_INDEX][i] = 1.0 + ( random()%100 )*0.005f;
            
            
            for( j = 0 ; j < 3 ; j++ )
            {
                rot_LP_Spike_Base[LPress_INDEX][i][0][j] *= LP_Size_Dist[LPress_INDEX][i];
 
                act_LP_Spike_Norm[LPress_INDEX][i][0][j] = temp_LP_Spike_NormBase[i][0][j];
                act_LP_Spike_Norm[LPress_INDEX][i][1][j] = temp_LP_Spike_NormBase[i][0][j];
                act_LP_Spike_Norm[LPress_INDEX][i][2][j] = temp_LP_Spike_NormBase[i][0][j];
                
                act_LP_Spike_Norm[LPress_INDEX][i][3][j] = temp_LP_Spike_NormBase[i][3][j];
                act_LP_Spike_Norm[LPress_INDEX][i][4][j] = temp_LP_Spike_NormBase[i][3][j];
                act_LP_Spike_Norm[LPress_INDEX][i][5][j] = temp_LP_Spike_NormBase[i][3][j];
                
                act_LP_Spike_Norm[LPress_INDEX][i][6][j] = temp_LP_Spike_NormBase[i][1][j];
                act_LP_Spike_Norm[LPress_INDEX][i][7][j] = temp_LP_Spike_NormBase[i][1][j];
                act_LP_Spike_Norm[LPress_INDEX][i][8][j] = temp_LP_Spike_NormBase[i][1][j];
                
                act_LP_Spike_Norm[LPress_INDEX][i][9][j] = temp_LP_Spike_NormBase[i][2][j];
                act_LP_Spike_Norm[LPress_INDEX][i][10][j] = temp_LP_Spike_NormBase[i][2][j];
                act_LP_Spike_Norm[LPress_INDEX][i][11][j] = temp_LP_Spike_NormBase[i][2][j];
            }
            
            for( j = 0 ; j < 12 ; j++ )
            {
                LP_Spike_Color[LPress_INDEX][i][j][3] = 1.0f;
                
                act_LP_Spike_Vertex[LPress_INDEX][i][j][0] = LP_Spike_Center[LPress_INDEX][0];
                act_LP_Spike_Vertex[LPress_INDEX][i][j][1] = LP_Spike_Center[LPress_INDEX][1];
                act_LP_Spike_Vertex[LPress_INDEX][i][j][2] = LP_Spike_Center[LPress_INDEX][2];
            }
            
            LP_Size[LPress_INDEX][i] = 0.0f;
            LP_Size_Velocity[LPress_INDEX][i] = 0.0f;
            LP_Y_Velocity[LPress_INDEX][i] = powf( (random()%100*0.001), 2.0f );
            
        }// i M05_NUM SPIKE
        
    }// isLongPress
 
    [tempMatrix release];
}

- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{
    
    
    
    GLfloat* panPtr = Value_ptr;
    GLfloat posX = (*panPtr)*fovy_Weight;
    panPtr++;
    GLfloat posY = (*panPtr)*0.75*fovy_Weight;
    panPtr++;
    //GLfloat transX = *panPtr;
    panPtr++;
    //GLfloat transY = *panPtr;
    panPtr++;
    //GLfloat vecX = *panPtr;
    panPtr++;
    //GLfloat vecY = *panPtr;
    panPtr++;
    //GLfloat velocity = *panPtr;
    
    
    Pan_Center[2] = sinf(rotAxis_Xrad[0])*0.5f;
    float depthWeight = 2.5f - Pan_Center[2];

    
    Pan_Center[0] = posX*depthWeight + eyeVec[0];
    Pan_Center[1] = posY*depthWeight + eyeVec[1];

    if( !isPanned )
    {
        int i;
        
        for( i = 0 ; i < M05_NUM_PAN ; i++ )
        {
            Pan_Velocity[i][0] = (random()%200-100)*0.0001;
            Pan_Velocity[i][1] = (random()%200-100)*0.0001;
            Pan_Velocity[i][2] = (random()%200-100)*0.0001;
            
            Pan_Vertex[i][0] = Pan_Center[0]+0.01;
            Pan_Vertex[i][1] = Pan_Center[1]+0.01;
            Pan_Vertex[i][2] = Pan_Center[2]+0.01;
        }
    }

    isPanned = YES;
}

- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    GLfloat* centerPtr = Center_ptr;
    GLfloat centerX = *centerPtr; centerPtr++;
    GLfloat centerY = (*centerPtr)*0.75;
    
    //GLfloat Radius = *Radius_ptr;
    GLfloat Scale = *Scale_ptr;
    
    eyeVec_dist[0] = centerX;
    eyeVec_dist[1] = centerY;
    
    if( Scale > 2.0 )
    { Scale = 2.0f; }
    
    Scale -= 1.0f;

        fovy_dist = 90.0f - Scale * 40.0f;
    
    if( !isPinched )
    {
        isPinched = YES;
        Pinch_Alpha = 0.5;
    }
    
    //NSLog(@"%f %f %f %f %f", centerX, centerY, Radius, Scale, absoluteRadius );
}

- (void)stopLongPress:(Byte)index
{
    isLongPressed[index] = NO;
}

- (void)stopPan
{
    isPanned = NO;
}

- (void)stopPinch
{
    isPinched = NO;
    fovy_dist = 90.0f;
    eyeVec_dist[0] = 0.0f;
    eyeVec_dist[1] = 0.0f;
    Pinch_Alpha = 0.0f;
}

@end