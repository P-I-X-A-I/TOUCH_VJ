//
//  moduleBasis.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "matrixClass.h"

#define NUMBER_OF_SLOT 5

@interface moduleBasis : NSObject {
    
    NSString* moduleName;
    UIImage* moduleIcon;
    
    short RESOLUTION;
    
    Byte Num_Of_Pages;
    NSMutableArray* segmentPageTitle_ARRAY;
    NSMutableArray* viewForSegment_ARRAY;
    
    
    GLfloat fovy;
    GLfloat EyeDepth;
    GLfloat viewSizeRatio;
    float MATRIX[16];
    float INVERSE[16];
    
    Byte CURRENT_SLOT;
    
    BOOL isLongPressed[4];
    BOOL isPanned;
    BOOL isPinched;
}

@property ( readonly ) NSString* moduleName;
@property ( readonly ) UIImage* moduleIcon;
@property ( readonly ) Byte Num_Of_Pages;
@property ( readonly ) NSMutableArray* segmentPageTitle_ARRAY;
@property ( assign ) NSMutableArray* viewForSegment_ARRAY;

- (id)initWithDeviceName:(NSString*)deviceName;

- (void)moduleDraw:(BOOL)yn FBO:(GLuint*)FBOName; // need to be overrride
- (void)dealloc;

- (void)setDefault; // equal to initValues

- (void)initValues; // need to be overrride
- (void)initGUI; // need to be override

- (void)saveModule:(NSKeyedArchiver*)archiver saveslot:(Byte)num;// need to be override
- (void)loadModule:(NSKeyedUnarchiver*)unArchiver loadslot:(Byte)num; // need to be override

- (void)becomeCurrent;// need to be override
- (void)becomeBackground; // need to be override
- (void)setCurrentSlotIndex:(Byte)index;


- (void)readShaderSourcePath:(NSString*)path vs:(GLuint*)vsObj fs:(GLuint*)fsObj pg:(GLuint*)pgObj;
- (void)linkProgram:(GLuint*)pgObj;
- (void)validateProgramAndDeleteShader_vs:(GLuint*)vsObj fs:(GLuint*)fsObj pg:(GLuint*)pgObj;

- (void)isTapped_X:(GLfloat*)tapX_ptr Y:(GLfloat*)tapY_ptr num:(Byte)NUM;
- (void)isLongPressed_X:(GLfloat*)LPress_X_ptr Y:(GLfloat*)LPress_Y_ptr index:(Byte)LPress_INDEX num:(Byte)NUM;
- (void)isPanned_Value:(GLfloat*)Value_ptr num:(Byte)NUM;
- (void)isPinched_Center:(GLfloat*)Center_ptr Radius:(GLfloat*)Radius_ptr Scale:(GLfloat*)Scale_ptr Velocity:(GLfloat*)Vel_ptr num:(Byte)NUM;

- (void)stopLongPress:(Byte)index;
- (void)stopPan;
- (void)stopPinch;

// for matrix**************
- (void)rotate_Xdeg:(float)degree;
- (void)rotate_Ydeg:(float)degree;
- (void)rotate_Zdeg:(float)degree;

- (void)translate_x:(float)tx y:(float)ty z:(float)tz;

- (void)scale_x:(float)xf y:(float)yf z:(float)zf;

- (void)lookAt_Ex:(float)eyeX Ey:(float)eyeY Ez:(float)eyeZ
			   Vx:(float)viewX Vy:(float)viewY Vz:(float)viewZ
			   Hx:(float)headX Hy:(float)headY Hz:(float)headZ;


- (void)perspective_fovy:(float)degree aspect:(float)ratio near:(float)N far:(float)F;

- (void)initMatrix;
- (float*)getMatrix;

- (void)culculate_matrix:(float*)matrix;
- (float*)inverse_matrix:(float*)matPtr;

- (void)culculate_vec4:(float*)vec4;
- (void)culculate_vec3:(float*)vec3;

@end
