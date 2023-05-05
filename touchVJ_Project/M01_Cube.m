//
//  M01_Cube.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "M01_Cube.h"


@implementation M01_Cube

- (id)initWithDeviceName:(NSString *)deviceName
{
    self = [super init];
    
    if( [deviceName isEqualToString:@"iPad"] )
    {
        RESOLUTION = 512;
    }
    else if( [deviceName isEqualToString:@"iPad2"] )
    {
        RESOLUTION = 1024;
    }

    
    
// module information
    moduleName = [[NSString alloc] initWithString:@"01_Cube"];
    moduleIcon = [UIImage imageNamed:@"M01_Cube"];
    
// load Nib file
    [[NSBundle mainBundle] loadNibNamed:@"M01_Cube" owner:self options:nil];
    
// num of setting pages
    Num_Of_Pages = 2;
    segmentPageTitle_ARRAY = [[NSMutableArray alloc] init];
    viewForSegment_ARRAY = [[NSMutableArray alloc] init];
    
    // set segment page title
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Module Info"]];
    [segmentPageTitle_ARRAY addObject:[[NSString alloc] initWithString:@"Parameters"]];
    
    // set view for segment
    [viewForSegment_ARRAY addObject:view_00];
    [viewForSegment_ARRAY addObject:view_01];
    
    
    
    // init value and init GUI
    matrix_OBJ = [[matrixClass alloc] init];
    [self initValues];
    [self initGUI];
    
    return self;
}





- (void)initValues
{
    
    int i, j;
    
    // shader
    
    
    
    CURRENT_SLOT = 0;
    isLongPressed[0] = isLongPressed[1] = isLongPressed[2] = isLongPressed[3] = NO;
    isPanned = NO;
    isPinched = NO;
    
    EyeDepth = 1.0f;
    
    GLfloat tempMatrix[16];
    cubeBase[0][0] = -0.02;     cubeBase[0][1] = 0.02;      cubeBase[0][2] = 0.02;
    cubeBase[1][0] = -0.02;     cubeBase[1][1] = -0.02;     cubeBase[1][2] = 0.02;
    cubeBase[2][0] = 0.02;      cubeBase[2][1] = 0.02;     cubeBase[2][2] = 0.02;
    cubeBase[3][0] = 0.02;      cubeBase[3][1] = -0.02;      cubeBase[3][2] = 0.02;
    cubeBase[4][0] = -0.02;     cubeBase[4][1] = 0.02;      cubeBase[4][2] = -0.02;
    cubeBase[5][0] = -0.02;     cubeBase[5][1] = -0.02;     cubeBase[5][2] = -0.02;
    cubeBase[6][0] = 0.02;      cubeBase[6][1] = 0.02;     cubeBase[6][2] = -0.02;
    cubeBase[7][0] = 0.02;      cubeBase[7][1] = -0.02;      cubeBase[7][2] = -0.02;
    
    for( i = 0 ; i < 16 ; i++ )
    { tempMatrix[i] = 0.0f; }
    
    
    for( i = 0 ; i < NUM_CUBE ; i++ )
    {
        [matrix_OBJ initMatrix];
        [matrix_OBJ rotate_Xdeg:(float)(random()%360)];
        [matrix_OBJ rotate_Ydeg:(float)(random()%360)];
        [matrix_OBJ rotate_Zdeg:(float)(random()%360)];
        //        [matrix_OBJ translate_x:(random()%200-100)*0.005
        //                              y:(random()%200-100)*0.005
        //                              z:(random()%200-100)*0.005];
        
        
        float* matrixPtr = [matrix_OBJ getMatrix];
        
        for( j = 0 ; j < 16 ; j++ )
        {
            tempMatrix[j] = *matrixPtr;
            matrixPtr++;
        }
        
        for( j = 0 ; j < 8 ; j++ )
        {
            cubeVertex[i][j][0] = tempMatrix[0]*cubeBase[j][0] + tempMatrix[4]*cubeBase[j][1] + tempMatrix[8]*cubeBase[j][2] + tempMatrix[12];
            cubeVertex[i][j][1] = tempMatrix[1]*cubeBase[j][0] + tempMatrix[5]*cubeBase[j][1] + tempMatrix[9]*cubeBase[j][2] + tempMatrix[13];
            cubeVertex[i][j][2] = tempMatrix[2]*cubeBase[j][0] + tempMatrix[6]*cubeBase[j][1] + tempMatrix[10]*cubeBase[j][2] + tempMatrix[14];
           // cubeVertex[i][j][3] = 1.0f;
        }
        
        
        
        int INC = i*8;
        cubeIndex[i][0] = 0+INC;
        
        cubeIndex[i][1] = 0+INC;
        cubeIndex[i][2] = 1+INC;
        cubeIndex[i][3] = 2+INC;
        cubeIndex[i][4] = 3+INC;
        cubeIndex[i][5] = 6+INC;
        cubeIndex[i][6] = 7+INC;
        cubeIndex[i][7] = 4+INC;
        cubeIndex[i][8] = 5+INC;
        cubeIndex[i][9] = 0+INC;
        cubeIndex[i][10] = 1+INC;
        
        cubeIndex[i][11] = 1+INC;
        
        cubeIndex[i][12] = 1+INC;
        
        cubeIndex[i][13] = 1+INC;
        cubeIndex[i][14] = 5+INC;
        cubeIndex[i][15] = 3+INC;
        cubeIndex[i][16] = 7+INC;
        cubeIndex[i][17] = 4+INC;
        cubeIndex[i][18] = 0+INC;
        cubeIndex[i][19] = 6+INC;
        cubeIndex[i][20] = 2+INC;
        
        cubeIndex[i][21] = 2+INC;
        
        
        
        
        
        for( j = 0 ; j < 8 ; j++ )
        {
            act_cubeVertex[i][j][0] = 0.0f;
            act_cubeVertex[i][j][1] = 0.0f;
            act_cubeVertex[i][j][2] = 0.0f;
            act_cubeVertex[i][j][3] = 1.0f;
            
            act_cubeColor[i][j][0] = 1.0f;
            act_cubeColor[i][j][1] = 1.0f;
            act_cubeColor[i][j][2] = 1.0f;
            act_cubeColor[i][j][3] = 0.0f;
        }
        
        act_cubeSize[i] = (random()%100)*0.01;
        
        ctlPoint[i][0] = 0.0f;
        ctlPoint[i][1] = 0.0f;
        ctlPoint[i][2] = 0.0f;
        ctlPoint[i][3] = 1.0f;
        
        ctlPoint_dist[i][0] = 0.0f;
        ctlPoint_dist[i][1] = 0.0f;
        ctlPoint_dist[i][2] = 0.0f;
        
        ctlPoint_dist_stock[i][0] = 0.0f;
        ctlPoint_dist_stock[i][1] = 0.0f;
        ctlPoint_dist_stock[i][2] = 0.0f;
        
        ctlPoint_velocity[i][0] = 0.0f;
        ctlPoint_velocity[i][1] = 0.0f;
        ctlPoint_velocity[i][2] = 0.0f;
        
        ctlColor[i][0] = 1.0f;
        ctlColor[i][1] = 1.0f;
        ctlColor[i][2] = 1.0f;
        ctlColor[i][3] = 0.0f;
        
        ctlFriction[i] = random()%100*0.004 + 0.5; // 0.5 - 0.9
    }//i
    
    act_ClearAlpha = 1.0f;
    
    World_Translate[0] = 0.0f;
    World_Translate[1] = 0.0f;
    World_Translate[2] = 0.0f;
    World_Translate_interp[0] = 0.0f;
    World_Translate_interp[1] = 0.0f;
    World_Translate_interp[2] = 0.0f;
    

    ctl_INDEX = 0;

    fovy = 90.0f;
    ViewX = 0.0f;
    ViewY = 0.0f;
    act_ViewX = 0.0f;
    act_ViewY = 0.0f;
    
    act_fovy = 90.0f;
    
    lookAtMat[0] = 1.0f;    lookAtMat[4] = 0.0f;    lookAtMat[8] = 0.0f;    lookAtMat[12] = 0.0f;
    lookAtMat[1] = 0.0f;    lookAtMat[5] = 1.0f;    lookAtMat[9] = 0.0f;    lookAtMat[13] = 0.0f;
    lookAtMat[2] = 0.0f;    lookAtMat[6] = 0.0f;    lookAtMat[10] = 1.0f;    lookAtMat[14] = 0.0f;
    lookAtMat[3] = 0.0f;    lookAtMat[7] = 0.0f;    lookAtMat[11] = 0.0f;    lookAtMat[15] = 1.0f;
    
    
    for( i = 0 ; i < NUMBER_OF_SLOT ; i++ )
    {
        Obj_Color[i][0] = 1.0f;
        Obj_Color[i][1] = 1.0f;
        Obj_Color[i][2] = 1.0f;
        
        BG_Color[i][0] = 0.0f;
        BG_Color[i][1] = 0.0f;
        BG_Color[i][2] = 0.0f;
        
        Obj_HSB[i][0] = 1.0f;
        Obj_HSB[i][1] = 0.0f;
        Obj_HSB[i][2] = 1.0f;
        
        BG_HSB[i][0] = 0.0f;
        BG_HSB[i][1] = 0.0f;
        BG_HSB[i][2] = 0.0f;
    }
    
    isAction_Afterimage = NO;
    isAction_Noise = NO;
    isAction_Stop = NO;
    
    for( i = 0 ; i < 10 ; i++ )
    {
        sizeNoise[i] = 1.0f;
        colorNoise[i] =1.0f;
    }
    
}

- (void)initGUI
{
    NSLog(@"init GUI %@ %d", moduleName, CURRENT_SLOT);
    
    SLIDER_OBJ_RED.value = Obj_HSB[CURRENT_SLOT][0];
    SLIDER_OBJ_GREEN.value = Obj_HSB[CURRENT_SLOT][1];
    SLIDER_OBJ_BLUE.value = Obj_HSB[CURRENT_SLOT][2];
    
    SLIDER_BG_RED.value = BG_HSB[CURRENT_SLOT][0];
    SLIDER_BG_GREEN.value = BG_HSB[CURRENT_SLOT][1];
    SLIDER_BG_BLUE.value = BG_HSB[CURRENT_SLOT][2];
    
    isAction_Afterimage = NO;
    isAction_Noise = NO;
    isAction_Stop = NO;
}












- (void)moduleDraw:(BOOL)yn FBO:(GLuint*)FBOName
{
    int i, j, k;
    
    
    // set matrix
    [self initMatrix];
    
    [self lookAt_Ex:0.0f Ey:0.0f Ez:act_EyeDepth
                 Vx:act_ViewX Vy:act_ViewY Vz:0.0f 
                 Hx:0.0f Hy:1.0f Hz:0.0f];
    
    float* tempPtr = [self getMatrix];
    
    for( i = 0 ; i < 16 ; i++ )
    {
        lookAtMat[i] = *tempPtr;
        tempPtr++;
    }
    
    
    [self perspective_fovy:act_fovy
                    aspect:1.0f
                      near:0.1f
                       far:5.0f];
    
    
   
    // culcurate EyeDepth & viewSizeRatio
    viewSizeRatio = tanf(act_fovy*0.5*0.0174532925)*act_EyeDepth;
    
    
    Byte tempIndex;
    
    if( !isAction_Stop )
    {
        if (isAction_Noise)
        {
            for( i = 0 ; i < 10 ; i++ )
            {
                sizeNoise[i] = (random()%150)*0.01;
                colorNoise[i] =(float)(random()%2);
            }
        }
        else
        {
            for( i = 0 ; i < 10 ; i++ )
            {
                sizeNoise[i] = 1.0f;
                colorNoise[i] = 1.0f;
            }
        }
    }
    
    for( i = 0 ; i < NUM_CUBE ; i++ )
    {
        tempIndex = i%10;
        
        for( j = 0 ; j < 8 ; j++ )
        {
            act_cubeVertex[i][j][0] = ctlPoint[i][0] + cubeVertex[i][j][0]*act_cubeSize[i]*sizeNoise[tempIndex];
            act_cubeVertex[i][j][1] = ctlPoint[i][1] + cubeVertex[i][j][1]*act_cubeSize[i]*sizeNoise[tempIndex];
            act_cubeVertex[i][j][2] = ctlPoint[i][2] + cubeVertex[i][j][2]*act_cubeSize[i]*sizeNoise[tempIndex];
            
            act_cubeColor[i][j][0] = Obj_Color[CURRENT_SLOT][0];
            act_cubeColor[i][j][1] = Obj_Color[CURRENT_SLOT][1];
            act_cubeColor[i][j][2] = Obj_Color[CURRENT_SLOT][2];
            act_cubeColor[i][j][3] = ctlColor[i][3]*colorNoise[tempIndex];
        }
    }
    
    
    if( yn )
    {
        glUseProgram(PRG_BOARD);
        glViewport(0, 0, RESOLUTION, RESOLUTION);
        glClear( GL_DEPTH_BUFFER_BIT );
        
        glUniformMatrix4fv(UNF_mvp_Board, 1, GL_FALSE, MATRIX);
        glUniform1i(UNF_BoardTex, 5);
        
        
        //*********  clear board ************************
        GLfloat unitX[3];
        GLfloat unitY[3];
        GLfloat unitZ[3];
        
        GLfloat center[3];
        
        
        GLfloat clearVertex[4][4];
        GLfloat clearColor[4][4];
        GLfloat clearTex[4][2];
        GLfloat clearBoardRatio = tanf(act_fovy*0.5*0.0174532925)*5.0;
        
        unitX[0] = lookAtMat[0]*clearBoardRatio;    unitX[1] = lookAtMat[4]*clearBoardRatio;    unitX[2] = lookAtMat[8]*clearBoardRatio;
        unitY[0] = lookAtMat[1]*clearBoardRatio;    unitY[1] = lookAtMat[5]*clearBoardRatio;    unitY[2] = lookAtMat[9]*clearBoardRatio;
        unitZ[0] = lookAtMat[2];                    unitZ[1] = lookAtMat[6];                    unitZ[2] = lookAtMat[10];
        
        center[0] = (-unitZ[0]*4.9);
        center[1] = (-unitZ[1]*4.9);
        center[2] = (1.0f-unitZ[2]*4.9);
        
        // clear vertex
        clearVertex[0][0] = center[0] - unitX[0] + unitY[0];
        clearVertex[0][1] = center[1] - unitX[1] + unitY[1];
        clearVertex[0][2] = center[2] - unitX[2] + unitY[2];
        clearVertex[0][3] = 1.0f;
        
        clearVertex[1][0] = center[0] - unitX[0] - unitY[0];
        clearVertex[1][1] = center[1] - unitX[1] - unitY[1];
        clearVertex[1][2] = center[2] - unitX[2] - unitY[2];
        clearVertex[1][3] = 1.0f;
        
        clearVertex[2][0] = center[0] + unitX[0] + unitY[0];
        clearVertex[2][1] = center[1] + unitX[1] + unitY[1];
        clearVertex[2][2] = center[2] + unitX[2] + unitY[2];
        clearVertex[2][3] = 1.0f;
        
        clearVertex[3][0] = center[0] + unitX[0] - unitY[0];
        clearVertex[3][1] = center[1] + unitX[1] - unitY[1];
        clearVertex[3][2] = center[2] + unitX[2] - unitY[2];
        clearVertex[3][3] = 1.0f;
        
        // clear color
        for( i = 0 ; i < 4 ; i++ )
        {
            clearColor[i][0] = BG_Color[CURRENT_SLOT][0];
            clearColor[i][1] = BG_Color[CURRENT_SLOT][1];
            clearColor[i][2] = BG_Color[CURRENT_SLOT][2];
            clearColor[i][3] = act_ClearAlpha;
        }
        
        // fovy is 50.0 - 140.0 (-40.0 ~ 50.0)
        GLfloat texCenterX = 0.25f - (act_ViewX/viewSizeRatio)*0.05;
        GLfloat texCenterY = 0.75f + (act_ViewY/viewSizeRatio)*0.05;
        GLfloat texScale = 0.15f + (act_fovy-90.0f)*0.001; // -0.04 ~ 0.05
        
        clearTex[0][0] = texCenterX - texScale;  clearTex[0][1] = texCenterY - texScale;
        clearTex[1][0] = texCenterX - texScale;  clearTex[1][1] = texCenterY + texScale;
        clearTex[2][0] = texCenterX + texScale;  clearTex[2][1] = texCenterY - texScale;
        clearTex[3][0] = texCenterX + texScale;  clearTex[3][1] = texCenterY + texScale;
        
        
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, clearVertex);
        glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, clearColor);
        glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, clearTex);
        
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        
        //*********  clear board ************************

        glUseProgram(PRG_OBJ);
        
        glUniformMatrix4fv(UNF_mvp_Matrix, 1, GL_FALSE, MATRIX);
        
        // CUBE
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, act_cubeVertex);
        glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, act_cubeColor);
        
        glDrawElements(GL_TRIANGLE_STRIP, 22*NUM_CUBE, GL_UNSIGNED_SHORT, cubeIndex);
        
        // LINE
        glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, ctlPoint);
        glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, ctlColor);
        
        glDrawArrays(GL_LINES, 0, NUM_CUBE);
        
        
        
        
        glFlush();
        
    }// yn
    
    
    // increment (TAP)
    
    if(!isAction_Stop)
    {
    
    for( i = 0 ; i < NUM_CUBE-80 ; i++ )
    {
        ctlPoint[i][0] += ( ctlPoint_dist[i][0] - ctlPoint[i][0] ) * 0.1f;
        ctlPoint[i][1] += ( ctlPoint_dist[i][1] - ctlPoint[i][1] ) * 0.1f;
        ctlPoint[i][2] += ( ctlPoint_dist[i][2] - ctlPoint[i][2] ) * 0.1f;
        ctlColor[i][3] += ( 0.0f - ctlColor[i][3] ) * 0.04f;
        act_cubeSize[i] += ( cubeSize_dist[i] - act_cubeSize[i] ) * 0.07f;
    }
    
    
    GLfloat posK;
    GLfloat sizeK;
    // ( Long Press )
    for ( i = 0 ; i < 4 ; i++ )
    {
        short j_Start = NUM_CUBE - (80-20*i);
        
        if( isLongPressed[i] )
        {
            for( j = j_Start ; j < j_Start+20 ; j++ )
            {
                // position
                for( k = 0 ; k < 3 ; k++ )
                {
                    posK = (ctlPoint_dist[j][k] - ctlPoint[j][k])*0.1f;
                    ctlPoint_velocity[j][k] = ctlPoint_velocity[j][k]*ctlFriction[j] + posK;
                    ctlPoint[j][k] += ctlPoint_velocity[j][k];
                }
                
                //size
                sizeK = (cubeSize_dist[j] - act_cubeSize[j])*0.1f;
                cubeSize_Velocity[j] = cubeSize_Velocity[j]*ctlFriction[j] + sizeK;
                act_cubeSize[j] += cubeSize_Velocity[j];
                
            }// for j
        }// if
        else
        {
            for( j = j_Start ; j < j_Start+20 ; j++ )
            {
                                
                // size
                sizeK = (cubeSize_dist[j] - act_cubeSize[j])*0.2f;
                cubeSize_Velocity[j] = cubeSize_Velocity[j]*ctlFriction[j] + sizeK;
                act_cubeSize[j] += cubeSize_Velocity[j];
                
                // color
                ctlColor[j][3] += ( 0.0f - ctlColor[j][3] ) * 0.08f;
            }// for j
        }
    }// for i
    
    
    // Pan
    World_Translate_interp[0] += ( World_Translate[0] - World_Translate_interp[0] ) * 0.1f;
    World_Translate_interp[1] += ( World_Translate[1] - World_Translate_interp[1] ) * 0.1f;
    World_Translate_interp[2] += ( World_Translate[2] - World_Translate_interp[2] ) * 0.1f;
    
    for( i = 0 ; i < NUM_CUBE ; i++ )
    {
        for( j = 0 ; j < 3 ; j++ )
        {
            ctlPoint[i][j] += World_Translate_interp[j];
            ctlPoint_dist[i][j] += World_Translate_interp[j];
            ctlPoint_dist_stock[i][j] += World_Translate_interp[j];
        }
    }
    
    
    
    // pinch
    act_ViewX += ( ViewX - act_ViewX )*0.1f;
    act_ViewY += ( ViewY - act_ViewY )*0.1f;
    
    act_fovy += ( fovy - act_fovy ) * 0.1f;
    act_EyeDepth += ( EyeDepth - act_EyeDepth ) * 0.1f;
    
    if( isAction_Afterimage )
    {
        act_ClearAlpha += ( 0.0f - act_ClearAlpha ) * 0.15f;
    }
    else
    {
        act_ClearAlpha += ( 1.0f - act_ClearAlpha ) * 0.05f;
    }
    
    }// isAction_Stop
    
}// moduleDraw







- (void)saveModule:(NSKeyedArchiver*)archiver saveslot:(Byte)num
{
    
    // Obj Color
    [archiver encodeBytes:(const uint8_t *)&Obj_Color[0][0]
                   length:sizeof(Obj_Color) 
                   forKey:[NSString stringWithFormat:@"M01_Obj_Color_%d", num]];
    
    // BG Color
    [archiver encodeBytes:(const uint8_t *)&BG_Color[0][0]
                   length:sizeof(BG_Color)
                   forKey:[NSString stringWithFormat:@"M01_BG_Color_%d", num]];
    
    // Obj HSB
    [archiver encodeBytes:(const uint8_t *)&Obj_HSB[0][0]
                   length:sizeof(Obj_HSB)
                   forKey:[NSString stringWithFormat:@"M01_Obj_HSB_%d", num]];
    
    // BG HSB
    [archiver encodeBytes:(const uint8_t *)&BG_HSB[0][0]
                   length:sizeof(BG_HSB)
                   forKey:[NSString stringWithFormat:@"M01_BG_HSB_%d", num]];
    
}


- (void)loadModule:(NSKeyedUnarchiver*)unArchiver loadslot:(Byte)num
{
    NSUInteger LENGTH;
    int i, iter;
    
    // Obj color
    const uint8_t* Obj_Color_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M01_Obj_Color_%d", num]
                                                        returnedLength:&LENGTH];
    

    if( Obj_Color_decodePtr != NULL )
    {
        GLfloat* Obj_Color_Copy = (GLfloat*)malloc(sizeof(Obj_Color));
        GLfloat* Obj_Color_Free = Obj_Color_Copy;
        GLfloat* Obj_Color_Assignment = &Obj_Color[0][0];
        iter = sizeof(Obj_Color) / sizeof(GLfloat);
    
        memcpy(Obj_Color_Copy, Obj_Color_decodePtr, LENGTH);
    
        for( i = 0 ; i < iter ; i++ )
        {
            *Obj_Color_Assignment = *Obj_Color_Copy;
            Obj_Color_Assignment++;
            Obj_Color_Copy++;
        }
    
        free(Obj_Color_Free);
    }
    
    // BG Color
    const uint8_t* BG_Color_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M01_BG_Color_%d", num]
                                                       returnedLength:&LENGTH];
    
    if( BG_Color_decodePtr != NULL )
    {
        GLfloat* BG_Color_Copy = (GLfloat*)malloc(sizeof(BG_Color));
        GLfloat* BG_Color_Free = BG_Color_Copy;
        GLfloat* BG_Color_Assignment = &BG_Color[0][0];
        iter = sizeof(BG_Color) / sizeof(GLfloat);
    
        memcpy(BG_Color_Copy, BG_Color_decodePtr, LENGTH);
    
        for( i = 0 ; i < iter ; i++ )
        {
            *BG_Color_Assignment = *BG_Color_Copy;
            BG_Color_Assignment++;
            BG_Color_Copy++;
        }
    
        free(BG_Color_Free);
    }
    
    
    const uint8_t* Obj_HSB_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M01_Obj_HSB_%d", num]
                                                      returnedLength:&LENGTH];
    
    if( Obj_HSB_DecodePtr != NULL )
    {
        GLfloat* Obj_HSB_Copy = (GLfloat*)malloc(sizeof(Obj_HSB));
        GLfloat* Obj_HSB_Free = Obj_HSB_Copy;
        GLfloat* Obj_HSB_Assignment = &Obj_HSB[0][0];
        iter = sizeof(Obj_HSB) / sizeof(GLfloat);
        
        memcpy(Obj_HSB_Copy, Obj_HSB_DecodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Obj_HSB_Assignment = *Obj_HSB_Copy;
            Obj_HSB_Assignment++;
            Obj_HSB_Copy++;
        }
        
        free(Obj_HSB_Free);
    }
    
    
    const uint8_t* BG_HSB_DecodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"M01_BG_HSB_%d", num]
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
    NSLog(@"**********************************************SHADER 01 BECOME CURRENT");
    isAction_Afterimage = NO;
    isAction_Noise = NO;
    isAction_Stop = NO;

    
    
    Byte status;
    // set shader source ************************
    status = glIsProgram(PRG_OBJ);
    
    if (status == GL_FALSE)
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M01_Cube" ofType:@"vsh"];    
    
        [self readShaderSourcePath:shaderPath vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
        //[self readShaderSource:ShaderView vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    
        glBindAttribLocation(PRG_OBJ, 0, "position");
        glBindAttribLocation(PRG_OBJ, 1, "color");
    
        [self linkProgram:&PRG_OBJ];
    
        UNF_mvp_Matrix = glGetUniformLocation(PRG_OBJ, "mvp_Matrix");
        NSLog(@"%@ UNF_mvp_Matrix %d", moduleName, UNF_mvp_Matrix);
        [self validateProgramAndDeleteShader_vs:&VS_OBJ fs:&FS_OBJ pg:&PRG_OBJ];
    
    }
    // *******************************************
    
    status = glIsProgram(PRG_BOARD);
    
    if( status == GL_FALSE )
    {
        NSString* shaderPath = [[NSBundle mainBundle] pathForResource:@"M01_Cube2" ofType:@"vsh"];
    
        [self readShaderSourcePath:shaderPath vs:&VS_BOARD fs:&FS_BOARD pg:&PRG_BOARD];
        //[self readShaderSource:ShaderView_2 vs:&VS_BOARD fs:&FS_BOARD pg:&PRG_BOARD];
    
        glBindAttribLocation(PRG_BOARD, 0, "position");
        glBindAttribLocation(PRG_BOARD, 1, "color");
        glBindAttribLocation(PRG_BOARD, 2, "texCoord");
    
        [self linkProgram:&PRG_BOARD];
    
        UNF_mvp_Board = glGetUniformLocation(PRG_BOARD, "mvp_Matrix");
        UNF_BoardTex = glGetUniformLocation(PRG_BOARD, "UNF_BoardTex");
        NSLog(@"UNF_mvp_Board %d", UNF_mvp_Board);
        NSLog(@"UNF_BoardTex %d", UNF_BoardTex);
    
        [self validateProgramAndDeleteShader_vs:&VS_BOARD fs:&FS_BOARD pg:&PRG_BOARD];
    }

    // *******************************************

}
- (void)becomeBackground
{
    
    isAction_Afterimage = NO;
    isAction_Noise = NO;
    isAction_Stop = NO;
    
    glDeleteProgram(PRG_OBJ);
    glDeleteProgram(PRG_BOARD);
  
}






@end
