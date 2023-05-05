#import "mainController.h"

@implementation mainController ( DRAW )

- (void)draw:(CADisplayLink *)disp
{
    int i;
    
    // switch Flag 
    FPS_30_Switch = !FPS_30_Switch;

    
    BOOL isDraw;
    
    if( isFPS_60 || FPS_30_Switch )
    { isDraw = YES; }
    else
    { isDraw = NO; }
    
    
    // rendering module image
    
    if( isDraw )
    { glBindFramebuffer(GL_FRAMEBUFFER, FBO_Rendering); }

    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] moduleDraw:isDraw FBO:&FBO_Rendering];
    

    
    
// drawing Extra & Moniter view
    GLfloat Ext_board_TexCoord[4][2];
    
    

    // common for ExtMonitor & Monitor
    glUseProgram(BOARD_POBJ);
    glUniform1i(UNF_boardTexture, 6);
    glUniform1f(UNF_faderValue, FADER);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, boardVertex);

    if( isDraw )
    {
    // drawing extra view
    if( isExtDraw )
    {
        GLfloat width = Ext_View.frame.size.width;
        GLfloat height = Ext_View.frame.size.height;
        
        GLfloat ratio = height / width;
        
        Ext_board_TexCoord[0][0] = 0.0f;    Ext_board_TexCoord[0][1] = 0.5f + ratio*0.5f;
        Ext_board_TexCoord[1][0] = 0.0f;    Ext_board_TexCoord[1][1] = 0.5f - ratio*0.5f;
        Ext_board_TexCoord[2][0] = 1.0f;    Ext_board_TexCoord[2][1] = 0.5f + ratio*0.5f;
        Ext_board_TexCoord[3][0] = 1.0f;    Ext_board_TexCoord[3][1] = 0.5f - ratio*0.5f;;
        
        glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, Ext_board_TexCoord);
        
        glBindFramebuffer(GL_FRAMEBUFFER, FBO_ExtraMonitor);
        glBindRenderbuffer(GL_RENDERBUFFER, RBO_ExtraMonitor);
        
        glViewport(0, 0, (GLsizei)Ext_View.frame.size.width, (GLsizei)Ext_View.frame.size.height);
        glClear( GL_COLOR_BUFFER_BIT );

        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        
        [eaglContext presentRenderbuffer:GL_RENDERBUFFER];
    }// if isExtScreen

    }// if isDraw (Ext Monitor)
    
    
    
    
    
    // drawing monitor view
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_Moniter);
    glBindRenderbuffer(GL_RENDERBUFFER, RBO_Monitor);
    
    glViewport(0, 0, 640, 480);
    glClear( GL_COLOR_BUFFER_BIT );
    
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, boardTexCoord);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
 
    
    

 
    
    // increment ****
    BPM_COUNTER += incrementFor_1frame;
    
    double LoopLimit;
    
    switch (CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX]) {
        case 0:
            LoopLimit = 0.25;
            break;
        case 1:
            LoopLimit = 0.5;
            break;
        case 2:
            LoopLimit = 1.0;
            break;
        default:
            break;
    }
    
    if( BPM_COUNTER > LoopLimit )
    {
        BPM_COUNTER -= LoopLimit;
        CurrentTempo = 0;
    }
    
    
    
    if ( BPM_COUNTER > TempoPoint[CurrentTempo] ) {
        CurrentTempo++;
        timeLineBarAnimation = 0.02;
    }
    timeLineBarAnimation += ( 0.005 - timeLineBarAnimation )*0.2;
    // increment ****


    Byte check64 = (Byte)(BPM_COUNTER * 64.0 );
    Byte check128 = (Byte)(BPM_COUNTER * 128.0);
    short check256 = (short)(BPM_COUNTER * 256.0);
    
    isBeatFirst_64 = NO;
    if( BeatINDEX_64 != check64 )
    {
        BeatINDEX_64 = check64;
        isBeatFirst_64 = YES; // is used when gestureaction is send to modules
    }
    
    isBeatFirst_128 = NO;
    if( BeatINDEX_128 != check128 )
    {
        BeatINDEX_128 = check128;
        isBeatFirst_128 = YES;  // is used when gestureaction is send to modules
    }
    
    isBeatFirst_256 = NO;
    if( BeatINDEX_256 != check256 )
    {
        BeatINDEX_256 = check256;
        isBeatFirst_256 = YES; // is used when gestureaction is send to modules
    }
            
    // drawing gesture
    
    [self drawGesture];
    [eaglContext presentRenderbuffer:GL_RENDERBUFFER];


    
    
    
    
    
    
    
    
// Sent Actions to Module    
    
    // Tap Action
    if( isBeatFirst_64 && State_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64] )
    {
        [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] isTapped_X:&Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][0]
                                                                    Y:&Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][1]
                                                                  num:BeatINDEX_64];
    }

    // LongPress Action
    if( isBeatFirst_64 )
    {
        for( i = 0 ; i < 4 ; i++ )
        {
            if( State_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][BeatINDEX_64] )
            {
                [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] isLongPressed_X:&Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][0] 
                                                                                 Y:&Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][1]
                                                                             index:(Byte)i
                                                                               num:BeatINDEX_64];
            }
            else
            {
                [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopLongPress:(Byte)i];
            }
        }// i
    }
    
    
    // Pan action
    if( isBeatFirst_256 )
    {
        if( State_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] )
        {
            [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] isPanned_Value:&Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][0]
                                                                          num:BeatINDEX_256];
        }
        else
        {
            [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopPan];
        }
    }
    
    // Pinch action
    if( isBeatFirst_128 )
    {
        if( State_Pinch[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] )
        {
            [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] isPinched_Center:&Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][0]
                                                                         Radius:&Value_Pinch_Radius[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128]
                                                                          Scale:&Value_Pinch_Scale[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128]
                                                                       Velocity:&Value_Pinch_Velocity[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128]
                                                                            num:BeatINDEX_128];
        }
        else
        {
            [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopPinch];
        }
    }
}









- (void)drawGesture
{
    int i;
    
    glLineWidth(1.0f);
    glUseProgram(GESTURE_POBJ);
    
    GLfloat BPM_COUNTER_Norm = (BPM_COUNTER - 0.5) * 1.8;
    GLfloat timeLineColor[4];
    
// Time Line
    
    // black base
    GLfloat base[4][4];
    base[0][0] = -0.92; base[0][1] = 0.88; base[0][2] = 0.0;   base[0][3] = 1.0;
    base[1][0] = -0.92; base[1][1] = 0.92; base[1][2] = 0.0;   base[1][3] = 1.0;
    base[2][0] = 0.92;  base[2][1] = 0.88; base[2][2] = 0.0;   base[2][3] = 1.0;
    base[3][0] = 0.92;  base[3][1] = 0.92; base[3][2] = 0.0;   base[3][3] = 1.0;
    timeLineColor[0] = 0.0;
    timeLineColor[1] = 0.0;
    timeLineColor[2] = 0.0;
    timeLineColor[3] = 0.25;
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, base);
    glUniform4fv(UNF_color, 1, timeLineColor);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    // tempo 0-4 ticker
    timeLineColor[0] = 1.0;
    timeLineColor[1] = 1.0;
    timeLineColor[2] = 1.0;
    timeLineColor[3] = 1.0;
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &timeLine[0][0]);
    glUniform4fv(UNF_color, 1, timeLineColor);
    glDrawArrays(GL_LINES, 0, 8);
    
    // tempo 4-8 ticker
    if( CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] < 1 ) // 0
    {
        timeLineColor[0] = timeLineColor[1] = timeLineColor[2] = timeLineColor [3] = 0.5;
    }
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &timeLine[8][0]);
    glUniform4fv(UNF_color, 1, timeLineColor);
    glDrawArrays(GL_LINES, 0, 8);
    
    // tempo 8-16 ticker
    if( CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] < 2 ) // 0 or 1
    {
        timeLineColor[0] = timeLineColor[1] = timeLineColor[2] = timeLineColor [3] = 0.5;
    }
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &timeLine[16][0]);
    glUniform4fv(UNF_color, 1, timeLineColor);
    glDrawArrays(GL_LINES, 0, 16);

    
// TimeLineBar

    timeLineBar[0][0] = BPM_COUNTER_Norm - timeLineBarAnimation; timeLineBar[0][1] = 0.91 + timeLineBarAnimation;
    timeLineBar[1][0] = BPM_COUNTER_Norm - timeLineBarAnimation; timeLineBar[1][1] = 0.89 - timeLineBarAnimation;
    timeLineBar[2][0] = BPM_COUNTER_Norm + timeLineBarAnimation; timeLineBar[2][1] = 0.89 - timeLineBarAnimation;
    timeLineBar[3][0] = BPM_COUNTER_Norm + timeLineBarAnimation; timeLineBar[3][1] = 0.91 + timeLineBarAnimation;
    
    timeLineColor[0] = timeLineColor[1] = timeLineColor[2] = timeLineColor[3] = 1.0;
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, timeLineBar);
    glUniform4fv(UNF_color, 1, timeLineColor);
    glDrawArrays(GL_LINE_LOOP, 0, 4);

 
// Draw Gestures
    glLineWidth(2.0f);

// Tap

    if( State_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64] && isBeatFirst_64 )
    {        
        TapColor[3] = 1.0f;
        TapAnimation = 0.05;
    }
    else if( !State_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64] )
    {
        TapColor[3] = 0.0f;
    }
    
    for( i = 0 ; i < 19 ; i++ )
    {
        TapVertex[i][0] = Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][0] + CircleVertex[i][0]*TapAnimation;
        TapVertex[i][1] = Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][1] + CircleVertex[i][1]*TapAnimation;
    }
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, TapVertex);
    glUniform4fv(UNF_color, 1, TapColor);
    glDrawArrays(GL_LINE_STRIP, 0, 19);
    
    TapColor[3] += (0.0f - TapColor[3])*0.05f;
    TapAnimation += ( 0.07 - TapAnimation )*0.3;
 
    
    
    
    
// Longpress
    LongPressAnimation += 0.25;
    GLfloat waveValue = sinf(LongPressAnimation)*0.1 + 1.0;
    GLfloat squareX = 0.04 * waveValue;
    GLfloat squareY = 0.05333 * waveValue;
    
    if (isLongPressed)
    {
        State_LongPress[ SLOT_INDEX ][ CURRENT_MODULE_INDEX ][ LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] ][ BeatINDEX_64 ] = YES;
    }

    for (i = 0; i < MAX_LONGPRESS_POINT; i++)
    {
        if ( State_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][BeatINDEX_64] )
        {
            LongPressVertex[i][0][0] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][0] - squareX;
            LongPressVertex[i][0][1] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][1] + squareY;
            LongPressVertex[i][1][0] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][0] - squareX;
            LongPressVertex[i][1][1] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][1] - squareY;
            LongPressVertex[i][2][0] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][0] + squareX;
            LongPressVertex[i][2][1] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][1] - squareY;
            LongPressVertex[i][3][0] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][0] + squareX;
            LongPressVertex[i][3][1] = Value_LongPress[SLOT_INDEX][CURRENT_MODULE_INDEX][i][1] + squareY;
        }// if
        else
        {
            LongPressVertex[i][0][0] = -20.0;
            LongPressVertex[i][0][1] = -20.0;
            LongPressVertex[i][1][0] = -20.0;
            LongPressVertex[i][1][1] = -20.0;
            LongPressVertex[i][2][0] = -20.0;
            LongPressVertex[i][2][1] = -20.0;
            LongPressVertex[i][3][0] = -20.0;
            LongPressVertex[i][3][1] = -20.0;
        }
    }// for i
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, LongPressVertex);
    glUniform4fv(UNF_color, 1, LongPressColor);
    glDrawElements(GL_LINES, 40, GL_UNSIGNED_BYTE, LongPressElements);


// pinch
    
    // record pinch data
    if( isPinch )
    {
        State_Pinch[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = YES;
        
        Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][0] = last_Pinch_Center[0];
        Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][1] = last_Pinch_Center[1];
        
        Value_Pinch_Radius[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = last_Pinch_Radius;
        Value_Pinch_Scale[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = last_Pinch_Scale;
        Value_Pinch_Velocity[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = last_Pinch_Velocity;
    }
    
    // drawing pinch 
    short pinchINDEX = BeatINDEX_128 -1;
    
    if( pinchINDEX < 0 )
    { pinchINDEX = 255; }
    
        if( isPinchHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] == 1 ||  isPinchHead[SLOT_INDEX][CURRENT_MODULE_INDEX][pinchINDEX] == 2 )
        {
            act_Pinch_Center[0] = Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][0];
            act_Pinch_Center[1] = Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][1];
            act_Pinch_Scale = Value_Pinch_Scale[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128];
        }
    
        pinchWeight = Value_Pinch_Radius[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] * act_Pinch_Scale;
    
        for( i = 0 ; i < 19 ; i++ )
        {        
            tempPinchVertex[i][0] = act_Pinch_Center[0] + pinchWeight*CircleVertex[i][0];
            tempPinchVertex[i][1] = act_Pinch_Center[1] + pinchWeight*CircleVertex[i][1];
            tempPinchVertex[i][2] = 0.0f;
            tempPinchVertex[i][3] = 1.0f;
        }
    
        if ( State_Pinch[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] )
        {
            tempPinchColor[0] = 1.0f;
            tempPinchColor[1] = 1.0f;
            tempPinchColor[2] = 0.0f;
            tempPinchColor[3] = 1.0f;
        }
        else
        {
            tempPinchColor[0] = 1.0f;
            tempPinchColor[1] = 1.0f;
            tempPinchColor[2] = 0.0f;
            tempPinchColor[3] = 0.0f;
        }
    
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, tempPinchVertex);
    glUniform4fv(UNF_color, 1, tempPinchColor);
    glDrawArrays(GL_LINE_STRIP, 0, 19);
    
    act_Pinch_Scale += ( Value_Pinch_Scale[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] - act_Pinch_Scale )*0.3;
    act_Pinch_Center[0] += ( Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][0] - act_Pinch_Center[0] ) * 0.3;
    act_Pinch_Center[1] += ( Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][1] - act_Pinch_Center[1] ) * 0.3;
    
    
    
// pan
    
    glUseProgram(GESTURE_2_POBJ);
    
    
    // Update Data during Panning
    if (isPan)
    {
        State_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] = YES;
 
        // record pan only isPan is YES
        for( i = 0 ; i < 7 ; i++ )
        {
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][i] = last_Value_Pan[i];
        }
    }
    
    // Drawing Pan
        if( State_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256])
        {
            short INDEX_first;
            short INDEX_second;
            
            INDEX_first = BeatINDEX_256;
            if( BeatINDEX_256 == 0 )
            {
                INDEX_second = POINTS_OF_PAN-1;
            }
            else
            {
                INDEX_second = BeatINDEX_256-1;
            }
            
            for( i = 4 ; i > 0 ; i-- )
            {
                Vertex_Pan[i][0][0] = Vertex_Pan[i-1][0][0];
                Vertex_Pan[i][0][1] = Vertex_Pan[i-1][0][1];
                Vertex_Pan[i][1][0] = Vertex_Pan[i-1][1][0];
                Vertex_Pan[i][1][1] = Vertex_Pan[i-1][1][1];
                
                Color_Pan[i][0][3] = Color_Pan[i-1][0][3];
                Color_Pan[i][1][3] = Color_Pan[i-1][1][3];
            }
            
                Vertex_Pan[0][0][0] = Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][0];
                Vertex_Pan[0][0][1] = Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][1];
                Vertex_Pan[0][1][0] = Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256-1][0];
                Vertex_Pan[0][1][1] = Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256-1][1];
            
            if( isPanHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] == 1 || isPanHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256-1] == 2 )
            {
                Color_Pan[0][0][3] = 0.0f;
                Color_Pan[0][1][3] = 0.0f;
            }
            else
            {
                Color_Pan[0][0][3] = 1.0f;
                Color_Pan[0][1][3] = 1.0f;
                
            }
        }// is two State_Pan is "YES" & isFirstBeat_256
        
    
    for( i = 0 ; i < 5 ; i++ )
    {
        Color_Pan[i][0][3] += ( 0.0f - Color_Pan[i][0][3] ) * 0.2;
        Color_Pan[i][1][3] += ( 0.0f - Color_Pan[i][1][3] ) * 0.2;
    }
        
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Vertex_Pan);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Color_Pan);
    glDrawArrays(GL_LINES, 0, 10);
    glDrawArrays(GL_POINTS, 0, 10);
    
}

@end