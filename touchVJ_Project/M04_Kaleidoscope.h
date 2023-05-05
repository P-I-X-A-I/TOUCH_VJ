//
//  M04_Kaleidoscope.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define M04_TAP_NUM 10
#define M04_PIECE_NUM 10
@interface M04_Kaleidoscope : moduleBasis {
    
    IBOutlet UIView* view_0;
    Byte iPad_model_No;
    
    GLuint FBO_Kaleidoscope;
    GLuint TEX_Kaleidoscope;
    GLuint TEX_Pattern;
    
    // shader
    GLuint VS_FBO_KALEIDO;
    GLuint FS_FBO_KALEIDO;
    GLuint PRG_FBO_KALEIDO;
    GLuint UNF_patternTexture;
    
    GLuint VS_FBO_DRAW;
    GLuint FS_FBO_DRAW;
    GLuint PRG_FBO_DRAW;
    GLuint UNF_mvp_Matrix;
    GLuint UNF_FBO_Tex;
    
    GLuint VS_SOLID;
    GLuint FS_SOLID;
    GLuint PRG_SOLID;
    GLuint UNF_mvp_Matrix_SOLID;
    
    //kaleidoscope source
    
    GLfloat Hue_Counter;
    GLfloat COLOR[3][3];
    Byte piece_color_index[M04_PIECE_NUM];
    
    GLfloat piece_Center[M04_PIECE_NUM][2];
    GLfloat piece_MoveTo[M04_PIECE_NUM][2];
    GLfloat piece_rad_1[M04_PIECE_NUM];
    GLfloat piece_rad_2[M04_PIECE_NUM];
    GLfloat piece_rad_1_inc[M04_PIECE_NUM];
    GLfloat piece_rad_2_inc[M04_PIECE_NUM];
    
    
    Byte piece_texcoord_index[M04_PIECE_NUM];
    GLfloat texCoord_index_set[16][4][2];
    
    GLfloat pieceVertex[M04_PIECE_NUM][6][4];
    GLfloat pieceColor[M04_PIECE_NUM][6][4];
    GLfloat pieceTexCoord[M04_PIECE_NUM][6][2];
    
    // drawing 
    GLfloat FBO_board_vertex[10][24][4];
    GLfloat FBO_board_color[10][24][4];
    GLfloat FBO_board_texcoord[10][24][2];
    
    GLfloat fovy_angle;
    GLfloat act_fovy_angle;
    
    // for Gesture
    GLfloat lookingAxis[2];
    GLfloat act_lookingAxis[2];
    
    // draw tap
    GLfloat tap_accel;
    
    Byte TAP_COUNTER;
    GLfloat tapCenter[M04_TAP_NUM][3];
    GLfloat tapCenter_Vel[M04_TAP_NUM][3];
    BOOL isTapDraw[M04_TAP_NUM];
    Byte TAP_DRAW_COUNTER[M04_TAP_NUM];
    GLfloat tapTexCoordShift[M04_TAP_NUM];
    
    GLfloat tapVertex_Base[54][3][2]; // 0-5, 6-23, 24-53
    GLfloat tapAlpha_Base[54][3];
    Byte tapTexcoord_BaseINDEX[54][3];
    GLshort tapDrawINDEX[54][6];
    
    float texScale;
    float act_texScale;
    
    
    // draw LP
    GLfloat LP_Center[4][3];
    
    GLfloat act_LP_Vertex[4][54][3][4];
    GLfloat act_LP_VStock[6][4][54][3][4];
    GLfloat act_LP_Color[4][54][3][4];
    GLfloat LP_TexCoord[54][3][2];
    
    GLfloat act_LP_velocity[4][54][3][3];
    GLfloat act_LP_afterAlpha[4];
    
    
    // Pan
    GLfloat act_PanF[2];
}

@end


@interface M04_Kaleidoscope ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;
@end

@interface M04_Kaleidoscope ( DRAW_PIECE )
- (void)draw_piece;
@end

@interface M04_Kaleidoscope ( DRAW_TAP )
- (void)drawTap;
@end

@interface M04_Kaleidoscope ( DRAW_LONGPRESS )
- (void)drawLongPress;
@end