
#import "M02_FontBit.h"

@implementation M02_FontBit ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM
{
    int i;
    
    float fovyWeight = tanf(fovy*0.5*0.0174532925);
    GLfloat zValue = (random()%60)*0.01;
    GLfloat tapX = (*tapX_ptr*fovyWeight) * (1.0 - zValue);
    GLfloat tapY = (*tapY_ptr*0.75*fovyWeight) * (1.0 - zValue);
    Byte fontIndex = random()%26;
    
    GLfloat initial_Velocity[3];
    
    for(i = 0 ; i < 3 ; i++)
    {
        initial_Velocity[i] = (random()%200-100)*0.00005;
    }
    
    [matrixOBJ initMatrix];
        
    GLfloat rotY_Vel = (float)(random()%30-15);
    GLfloat rotZ_Vel = (float)(random()%30-15);
    
    [matrixOBJ rotate_Zdeg:rotZ_Vel];

    rotY_Vel *= 0.1;
    rotZ_Vel *= 0.1;
    
    //**************************************************
    tapCircle_targetINDEX[tapCircle_COUNTER] = BIT_COUNT;
    
    tapCircle_Origin[tapCircle_COUNTER][0] = tapX;
    tapCircle_Origin[tapCircle_COUNTER][1] = tapY;
    tapCircle_Origin[tapCircle_COUNTER][2] = zValue;
    
    tapCircle_COUNTER++;
    
    if (tapCircle_COUNTER >= 16)
    { tapCircle_COUNTER = 0; }
    //**************************************************

    
    for( i = 0 ; i < font_bitNum[fontIndex] ; i++ )
    {
        P_BitPoint[BIT_COUNT][0] = font_bitPos[fontIndex][i][0];
        P_BitPoint[BIT_COUNT][1] = font_bitPos[fontIndex][i][1];
        P_BitPoint[BIT_COUNT][2] = 0.0;
        
        P_BitPoint_Trans[BIT_COUNT][0] = tapX;
        P_BitPoint_Trans[BIT_COUNT][1] = tapY;
        P_BitPoint_Trans[BIT_COUNT][2] = zValue;
        
        P_BitPoint_rotY_Vel[BIT_COUNT] = rotY_Vel;
        P_BitPoint_rotZ_Vel[BIT_COUNT] = rotZ_Vel;
        
        [matrixOBJ culculate_vec3:&P_BitPoint[BIT_COUNT][0]];
        
        P_BitPoint_Vel[BIT_COUNT][0] = initial_Velocity[0];
        P_BitPoint_Vel[BIT_COUNT][1] = initial_Velocity[1];
        P_BitPoint_Vel[BIT_COUNT][2] = initial_Velocity[2];
        
        P_Weight[BIT_COUNT] = 1.0f;
        p_Weight_Counter[BIT_COUNT] = 1.0f;
        
        
        BIT_COUNT++;
        if (BIT_COUNT >= M02_NUM_POINTS_CONDITION)
        { BIT_COUNT = 0; }
    }
}

- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM
{
    int i;
    
    if ( !isLongPressed[LPress_INDEX] )
    {
        isLongPressed[LPress_INDEX] = YES;
    
        float fovyWeight = tanf(fovy*0.5*0.0174532925);
        GLfloat zValue = (random()%60)*0.01;
        GLfloat LPress_X = (*LPress_X_ptr*fovyWeight) * (1.0 - zValue);
        GLfloat LPress_Y = (*LPress_Y_ptr*0.75*fovyWeight) * (1.0 - zValue);
    
        LPress_Center[LPress_INDEX][0] = LPress_X;
        LPress_Center[LPress_INDEX][1] = LPress_Y;
        LPress_Center[LPress_INDEX][2] = zValue;
        
        
        for( i = 0 ; i < M02_LPRESS ; i++ )
        {
            LPress_TargetINDEX[LPress_INDEX][i] = random()%M02_NUM_POINTS_CONDITION;
            
            P_LPress_Dist[ LPress_TargetINDEX[LPress_INDEX][i] ][0] = LPress_X;
            P_LPress_Dist[ LPress_TargetINDEX[LPress_INDEX][i] ][1] = LPress_Y;
            P_LPress_Dist[ LPress_TargetINDEX[LPress_INDEX][i] ][2] = zValue;
            
            P_LPress_Weight[ LPress_TargetINDEX[LPress_INDEX][i] ] = 1.0f;
        }
    }
}
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM
{
    isPanned = YES;

    GLfloat* ptr = Value_ptr;
    
    //GLfloat posX = *ptr;
    ptr++;
    //GLfloat posY = *ptr;
    ptr++;
    GLfloat transX = *ptr;
    ptr++;
    GLfloat transY = *ptr;
    ptr++;
    //GLfloat vecX = *ptr;
    ptr++;
   //GLfloat vecY = *ptr;
    ptr++;
    //GLfloat velocity = *ptr;
    ptr++;
    
    
    Pan_Trans[0] = ( transX - transX_Stock )*0.015;
    Pan_Trans[1] = ( transY - transY_Stock )*0.015;
    Pan_Trans[2] = 0.0f;
    
    transX_Stock = transX;
    transY_Stock = transY;
    
}
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM
{
    isPinched = YES;
    
    float fovyWeight = tanf(fovy*0.5*0.0174532925);
    
    
    
    GLfloat* Cptr = Center_ptr;
    GLfloat center_x = (*Cptr);
    Cptr++;
    GLfloat center_y = (*Cptr)*0.75;
    //GLfloat radius = *Radius_ptr;
    GLfloat scale = *Scale_ptr;
    //GLfloat velocity = *Vel_ptr;
    
    boardTex_Shift[0] = center_x*0.1;
    boardTex_Shift[1] = center_y*0.05;
    
    center_x *= fovyWeight;
    center_y *= fovyWeight;
    
    act_Pinch_F[0] = -center_x * 0.002;
    act_Pinch_F[1] = -center_y * 0.002;
    
    head_X = -center_x * 0.25;
    view_X = center_x * 0.3;
    view_Y = center_y * 0.15;
    
    if (scale < 1.0)
    {
        act_Pinch_F[2] = (0.0 - (1.0 - scale)) * 0.002;
        
        dist_fovy = 75.0 - (1.0 - scale)*30.0;
    }
    else
    {
        double value = (scale - 1.0);
        
        if (value > 2.0){ value = 2.0; }
        act_Pinch_F[2] = value * 0.001;
        
        dist_fovy = 75.0 + (value*15.0);
    }
}

- (void)stopLongPress:(Byte)index
{
    isLongPressed[index] = NO;
    
    for( int i = 0 ; i < M02_LPRESS ; i++ )
    {
        P_LPress_Weight[ LPress_TargetINDEX[index][i] ] = 0.0f;
    }
}
- (void)stopPan
{
    isPanned = NO;
    
    transX_Stock = 0.0f;
    transY_Stock = 0.0f;
}
- (void)stopPinch
{
    isPinched = NO;
}

@end