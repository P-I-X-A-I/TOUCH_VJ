//
//  M03_Rainbow.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define M03_HUE 8
#define M03_TAP 64
#define M03_LP 6

@interface M03_Rainbow : moduleBasis {
    
    IBOutlet UIView* view_00;
    
    Byte M03_HUE_CONDITION;

    Byte iPad_model_No;
    
    // shader
    GLuint VS_OBJ;
    GLuint FS_OBJ;
    GLuint PRG_OBJ;
    
    // shader
    GLuint UNF_mvpMatrix;
    
    GLuint VS_TEX;
    GLuint FS_TEX;
    GLuint PRG_TEX;
    GLuint UNF_mvpMatrixTex;
    GLuint UNF_lineTex;
    
    GLuint TexName_Point;
    // for drawing 
    Byte CURRENT_PAN_NUM;
    
    GLfloat Rainbow_Bright[M03_HUE][3];
    GLfloat Rainbow_Dark[M03_HUE][3];
    
    GLfloat tangentVec[256][2];
    GLfloat basePoint[256][2];
    GLfloat cross_A[256][2];
    GLfloat cross_B[256][2];
    GLfloat Rainbow_Vertex[256][8][4];
    GLfloat Rainbow_Color[256][8][4];
    GLfloat Rainbow_TexCoord[256][8][2];
    
    GLfloat Rainbow_Counter[256];
    
    GLfloat act_trans[2];
    GLfloat prev_trans[2];
    GLfloat dist_trans[2];
    
    // for pinch drawing
    GLfloat pinch_centerX;
    GLfloat pinch_centerY;
    GLfloat pinch_radius;
    GLfloat pinch_scale;
    
    GLfloat act_pinch_centerX;
    GLfloat act_pinch_centerY;
    GLfloat act_pinch_radius;
    GLfloat act_pinch_scale;
    
    GLfloat act_pinch_Alpha;
    
    GLfloat pinch_Vertex[2][M03_HUE][6][4];
    GLfloat pinch_Color[2][M03_HUE][6][4];
    GLfloat pinch_Texcoord[2][M03_HUE][6][2];

    GLfloat pinchPoint_base[M03_HUE][4];
    GLfloat pinchPoint_Velocity[M03_HUE][2];
    
    float radiusCounter;
    
    BOOL isFirstPinch;
    
    // tap
    GLfloat TAP_Center[M03_TAP][2];
    GLfloat TAP_Vertex[M03_TAP][6][4];
    GLfloat TAP_Color[M03_TAP][6][4];
    GLfloat TAP_TexCoord[M03_TAP][6][2];
    GLfloat TAP_Radian[M03_TAP];
    GLfloat TAP_Alpha[M03_TAP];
    GLfloat TAP_sizeDist[M03_TAP];
    GLfloat TAP_actSize[M03_TAP];
    
    Byte M03_LP_CONDITION;
    GLfloat LP_Center_Origin[4][2];
    GLfloat LP_Center[4][M03_LP][2];
    GLfloat LP_Center_Velocity[4][M03_LP][2];
    
    GLfloat LP_Vertex[4][M03_LP][6][4];
    GLfloat LP_Color[4][M03_LP][6][4];
    GLfloat LP_TexCoord[4][M03_LP][6][2];
    GLfloat LP_actAlpha[4];
    Byte LP_ColorINDEX[4][M03_LP];
}

@end



@interface M03_Rainbow (GESTURE)
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;
@end