//
//  M06_Plants.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/07/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "moduleBasis.h"

#define M06_SLOT 5
#define M06_TAP_NUM 16

@interface M06_Plants : moduleBasis {
    
    IBOutlet UIView* view_0;
    IBOutlet UIView* view_1;
    
    IBOutlet UISlider* SLIDER_BG_HUE;
    IBOutlet UISlider* SLIDER_BG_SAT;
    IBOutlet UISlider* SLIDER_BG_BRI;
    
    // Test SolidColor Shader
    GLuint FS_TEST_SOLID;
    GLuint VS_TEST_SOLID;
    GLuint PRG_TEST_SOLID;
    GLuint UNF_mvpMatrix_TEST_SOLID;
    
    
    
    // BG Parameter
    GLfloat BG_radian[5];
    GLfloat BG_radian_speed[5];
    GLfloat BG_HSB[M06_SLOT][3];
    GLfloat act_BG_HSB[3];
    
    
    // TAP Parameter
    GLfloat TAP_CircleBase[19][2];
    GLfloat TAP_Vertex[M06_TAP_NUM][21][2][4];
    GLfloat TAPED_Center[M06_TAP_NUM][3];
    GLfloat TAP_Color[M06_TAP_NUM][21][2][4];
    
    Byte TAP_INDEX;
    float TAP_COUNTER[M06_TAP_NUM][2];
}

@end


@interface M06_Plants ( INIT_VALUES )
- (void)initializeValues;
@end


@interface M06_Plants ( GESTURE )
- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;
@end

@interface M06_Plants ( ACTION )
- (IBAction)sliders:(UISlider*)sender;
@end