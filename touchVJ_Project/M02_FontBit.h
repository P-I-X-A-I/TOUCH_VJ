//
//  M02_FontBit.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define M02_NUM_POINTS 250
#define M02_POINT_TIMES 4
#define M02_LPRESS 5

@interface M02_FontBit : moduleBasis {
    
    IBOutlet UIView* view_00;
    IBOutlet UIView* view_01;
    
    IBOutlet UISlider* SLIDER_POINT_R;
    IBOutlet UISlider* SLIDER_POINT_G;
    IBOutlet UISlider* SLIDER_POINT_B;
    IBOutlet UISlider* SLIDER_BG_R;
    IBOutlet UISlider* SLIDER_BG_G;
    IBOutlet UISlider* SLIDER_BG_B;
    
    GLfloat dist_fovy;
    GLfloat head_X, act_head_X;
    GLfloat view_X, act_view_X;
    GLfloat view_Y, act_view_Y;
    
    matrixClass* matrixOBJ;
    
    GLfloat Point_Color[NUMBER_OF_SLOT][3];
    GLfloat BG_Color[NUMBER_OF_SLOT][3];
    GLfloat Point_HSB[NUMBER_OF_SLOT][3];
    GLfloat BG_HSB[NUMBER_OF_SLOT][3];
    GLfloat act_Point_Color[3];
    GLfloat act_BG_Color[3];
    GLfloat act_BoardAlpha;
    
    unsigned short M02_NUM_POINTS_CONDITION;
    unsigned short M02_POINT_TIMES_CONDITION;

    Byte iPad_model_No;
    
    // shader
    GLuint VS_OBJ;
    GLuint FS_OBJ;
    GLuint PRG_OBJ;
    
    // shader solidcolor
    GLuint VS_SOLID;
    GLuint FS_SOLID;
    GLuint PRG_SOLID;
    GLuint UNF_mvp_Matrix_SOLID;
    GLuint UNF_color_SOLID;
    
    // shader point
    GLuint UNF_color;
    GLuint UNF_mvp_Matrix;
    GLuint UNF_PointTexture;
    GLuint UNF_fovyWeight;
    GLuint TexName_Point;// texture name
    GLuint UNF_pointSizeBase;
    
    // shader clear
    GLuint VS_BOARD;
    GLuint FS_BOARD;
    GLuint PRG_BOARD;
    GLuint UNF_boardTex;
    
    
    // point data
    GLfloat P_Position[M02_POINT_TIMES][M02_NUM_POINTS][4];
    GLfloat P_BitPoint[M02_NUM_POINTS][3];
    GLfloat P_BitPoint_Trans[M02_NUM_POINTS][3];
    GLfloat P_BitPoint_Vel[M02_NUM_POINTS][3];
    GLfloat P_BitPoint_rotY_Vel[M02_NUM_POINTS];
    GLfloat P_BitPoint_rotZ_Vel[M02_NUM_POINTS];
    GLfloat P_Weight[M02_NUM_POINTS];
    GLfloat p_Weight_Counter[M02_NUM_POINTS];
    
    GLfloat P_LPress_Dist[M02_NUM_POINTS][3];
    GLfloat P_LPress_Weight[M02_NUM_POINTS];
    
    GLfloat Velocity_Position[M02_NUM_POINTS][3];
    
    unsigned short BIT_COUNT;
    
    // wind factor
    double wind_F[20][3];
    double wind_Counter[20][3];
    
    // pinch factor
    double act_Pinch_F[3];
    
    // font bit
    Byte font_bitNum[26];
    GLfloat font_bitPos[26][18][2];
    
    // board
    GLfloat boardTex_Shift[2];
    GLfloat act_boardTex_Shift[2];
    
    // Tap Line Effect
    GLshort tapCircle_Index[16][18][2];
    GLfloat tapCircle_Vertex[16][18][4];
    GLfloat tapCircle_Alpha[16][18];
    GLfloat Circle_Base[18][2];
    GLfloat tapCircle_Origin[16][3];
    int tapCircle_targetINDEX[16];
    Byte tapCircle_COUNTER;
    
    // LongPress Line Effect
    GLfloat LPress_Center[4][3];
    GLfloat LPressLine_Vertex[4][M02_LPRESS][2][4];
    GLfloat LPressLine_Alpha[4][M02_LPRESS][2];
    int LPress_TargetINDEX[4][M02_LPRESS];
    
    // Pan Effect
    GLfloat Pan_Trans[3];
    GLfloat transX_Stock;
    GLfloat transY_Stock;
}

@end


@interface M02_FontBit (GESTURE)
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;
@end

@interface M02_FontBit (ACTION)
- (IBAction)slider_color:(UISlider*)sender;
@end

@interface M02_FontBit ( FONT )
- (void)setFontData;
@end