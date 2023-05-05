//
//  M05_Structure.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/06/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define M05_BASEPOINT 8
#define M05_RADIANS 10
#define M05_TETRA_NUM 3
#define M05_BLUR 3
#define M05_INTER 9
#define M05_INTER_REPEAT 2
#define M05_NUM_SPIKE 7
#define M05_NUM_PAN 100

@interface M05_Structure : moduleBasis {
    
    IBOutlet UIView* view_0;
    IBOutlet UIView* view_1;
    Byte iPad_model_No;
    
    GLfloat Background_Color[5][3];
    GLfloat Background_RGB[5][2][3];
    GLfloat act_Background_Color[2][3];
    
    IBOutlet UISlider* SLIDER_BG_HUE;
    IBOutlet UISlider* SLIDER_BG_SAT;
    IBOutlet UISlider* SLIDER_BG_BRI;
    
    GLfloat eyeVec[2];
    GLfloat eyeVec_dist[2];
    
    // BG shader
    GLuint VS_BG;
    GLuint FS_BG;
    GLuint PRG_BG;
    GLuint UNF_BGTexture;
    
    // Tetra Shader
    GLuint VS_TETRA;
    GLuint FS_TETRA;
    GLuint PRG_TETRA;
    GLuint UNF_mvpMatrix_Tetra;
    GLuint UNF_lightColor;
    
    // Solid Shader
    GLuint VS_SOLID;
    GLuint FS_SOLID;
    GLuint PRG_SOLID;
    GLuint UNF_mvpMatrix;
    GLuint UNF_pointSize;
    GLuint UNF_texPoint;
    GLuint TEX_Point;
    
    // DarkBlur
    GLuint VS_DARK;
    GLuint FS_DARK;
    GLuint PRG_DARK;
    GLuint UNF_mvpMatrix_DARK;
    
    // Solid Line
    GLuint VS_LINE;
    GLuint FS_LINE;
    GLuint PRG_LINE;
    GLuint UNF_mvpMatrix_LINE;
    
    // Draw
    GLfloat BGAlpha_radian;
    GLfloat BGAlpha_rad_speed;
    
    GLfloat act_fovy;
    GLfloat fovy_dist;
    GLfloat fovy_Weight;
    
    GLfloat rotAxis_Xrad[M05_RADIANS];
    GLfloat rotAxis_Yrad[M05_RADIANS];
    GLfloat rotAxis_Zrad[M05_RADIANS];
    GLfloat rotAxis_Xrad_Speed[M05_RADIANS];
    GLfloat rotAxis_Yrad_Speed[M05_RADIANS];
    GLfloat rotAxis_Zrad_Speed[M05_RADIANS];
    
    GLfloat tetraBase_Vert[4][3];
    GLfloat tetraRot_Vertex[M05_RADIANS][4][3];
    
    GLfloat basePoint[M05_BASEPOINT][3];
    GLfloat stock_basePoint[M05_BASEPOINT][3];
    GLfloat basePoint_Velocity[M05_BASEPOINT][3];
    
    GLfloat tetraBasePoint[M05_BASEPOINT][M05_TETRA_NUM][3];
    GLfloat tetraBasePoint_Vel[M05_BASEPOINT][M05_TETRA_NUM][3];
    Byte tetraINDEX[M05_BASEPOINT][M05_TETRA_NUM];
    GLfloat tetraColorBias[M05_BASEPOINT];
    
    GLfloat interPoint_dist[M05_BASEPOINT][M05_INTER][3];
    GLfloat interPoint_Velocity[M05_BASEPOINT][M05_INTER][3];
    GLfloat act_interPoint[M05_INTER_REPEAT][M05_BASEPOINT][M05_INTER][4];
    
    // tap

    // LongPress
    GLfloat LP_Spike_Center[4][3];
    
    GLfloat LP_Spike_Base[4][3];
    GLfloat rot_LP_Spike_Base[4][M05_NUM_SPIKE][4][3];
    
    GLfloat LP_Spike_NormBase[4][3];
    GLfloat act_LP_Spike_Vertex[4][M05_NUM_SPIKE][12][4];
    GLfloat act_LP_Spike_Norm[4][M05_NUM_SPIKE][12][3];
    GLfloat LP_Spike_Color[4][M05_NUM_SPIKE][12][4];
    
    GLfloat LP_Size[4][M05_NUM_SPIKE];
    GLfloat LP_Size_Dist[4][M05_NUM_SPIKE];
    GLfloat LP_Size_Velocity[4][M05_NUM_SPIKE];
    GLfloat LP_Size_Coef[4][M05_NUM_SPIKE];
    
    GLfloat LP_X_Velocity[4][M05_NUM_SPIKE];
    GLfloat LP_Y_Velocity[4][M05_NUM_SPIKE];
    GLfloat LP_Z_Velocity[4][M05_NUM_SPIKE];
    
    GLfloat act_LP_Color[4];
    
    GLfloat LP_Lines_Vertex[4][M05_NUM_SPIKE][2][4];
    GLfloat LP_Lines_Color[4][M05_NUM_SPIKE][2][4];
    GLfloat act_LP_Line_Color[4];
    
    // Pan
    GLfloat Pan_Center[3];
    GLfloat Pan_Alpha_Dist;
    GLfloat Pan_Vertex[M05_NUM_PAN][4];
    GLfloat Pan_Color[M05_NUM_PAN][4];
    GLfloat Pan_Vec2[M05_NUM_PAN][2];
    GLfloat Pan_Velocity[M05_NUM_PAN][3];
    GLfloat Pan_Coef[M05_NUM_PAN];


    // Pinch
    GLfloat Pinch_Grid_Vertex[300][4];
    GLfloat Pinch_Grid_Color[300][4];
    GLfloat Pinch_Alpha;
    GLfloat act_Pinch_Alpha;
}

@end


@interface M05_Structure ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;
@end


@interface M05_Structure ( OTHER )
- (void)culc_Tetra;
- (IBAction)sliders:(UISlider*)sender;
@end