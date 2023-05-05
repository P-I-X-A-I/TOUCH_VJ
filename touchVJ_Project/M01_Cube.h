//
//  M01_Cube.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define NUM_CUBE 300

@interface M01_Cube : moduleBasis {
 
    IBOutlet UIView* view_00;
    IBOutlet UIView* view_01;
    
    IBOutlet UISlider* SLIDER_OBJ_RED;
    IBOutlet UISlider* SLIDER_OBJ_GREEN;
    IBOutlet UISlider* SLIDER_OBJ_BLUE;
    IBOutlet UISlider* SLIDER_BG_RED;
    IBOutlet UISlider* SLIDER_BG_GREEN;
    IBOutlet UISlider* SLIDER_BG_BLUE;

    GLuint VS_OBJ;
    GLuint FS_OBJ;
    GLuint PRG_OBJ;
    
    GLuint VS_BOARD;
    GLuint FS_BOARD;
    GLuint PRG_BOARD;
    
    GLuint UNF_mvp_Matrix;
    GLuint UNF_mvp_Board;
    GLuint UNF_BoardTex;
    
    // for drawing
    GLfloat cubeVertex[NUM_CUBE][8][3];
    GLfloat act_cubeVertex[NUM_CUBE][8][4];
    GLfloat act_cubeColor[NUM_CUBE][8][4];
    GLfloat act_cubeSize[NUM_CUBE];
    GLushort cubeIndex[NUM_CUBE][22];

    GLfloat cubeBase[8][3];
    
    GLfloat ctlPoint[NUM_CUBE][4];
    GLfloat ctlPoint_dist[NUM_CUBE][3];
    GLfloat ctlPoint_dist_stock[NUM_CUBE][3];
    GLfloat ctlPoint_velocity[NUM_CUBE][3];
    
    GLfloat ctlColor[NUM_CUBE][4];
    
    GLfloat ctlFriction[NUM_CUBE];
    
    GLfloat cubeSize_dist[NUM_CUBE];
    GLfloat cubeSize_Velocity[NUM_CUBE];
    
    GLfloat Pan_Translate_Stock[3];
    GLfloat World_Translate[3];
    GLfloat World_Translate_interp[3];
    
    short ctl_INDEX;
    
    matrixClass* matrix_OBJ;
    
    GLfloat ViewX;
    GLfloat ViewY;
    GLfloat act_ViewX;
    GLfloat act_ViewY;
    GLfloat act_fovy;
    GLfloat act_EyeDepth;
    GLfloat act_ClearAlpha;
    
    GLfloat lookAtMat[16];
    
    GLfloat Obj_Color[NUMBER_OF_SLOT][3]; //
    GLfloat BG_Color[NUMBER_OF_SLOT][3]; //
    GLfloat Obj_HSB[NUMBER_OF_SLOT][3];
    GLfloat BG_HSB[NUMBER_OF_SLOT][3];
    
    BOOL isAction_Afterimage;
    BOOL isAction_Noise;
    BOOL isAction_Stop;
    
    GLfloat sizeNoise[10];
    GLfloat colorNoise[10];

}


@end


@interface M01_Cube (GESTURE)
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;

@end

@interface M01_Cube (ACTION)
- (IBAction)button_Afterimage:(UIButton*)sender;
- (IBAction)button_Noise:(UIButton*)sender;
- (IBAction)button_Stop:(UIButton*)sender;

- (IBAction)slider_color:(UISlider*)sender;
@end
