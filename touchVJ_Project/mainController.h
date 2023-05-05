//
//  mainController.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>
#import <StoreKit/StoreKit.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


#import "viewController.h"
#import "glesView.h"

// module *************
#import "moduleBasis.h"
#import "M01_Cube.h"
#import "M02_FontBit.h"
#import "M03_Rainbow.h"
#import "M04_Kaleidoscope.h"
#import "M05_Structure.h"
#import "M06_Plants.h"
// module *************

#define NUM_OF_SLOT 5
#define MAX_LONGPRESS_POINT 4
#define POINTS_OF_PAN 256
#define NUM_OF_MODULES 16

@interface mainController : NSObject {
    
    IBOutlet NSObject* appDelegate;
    
    IBOutlet UIWindow* window;
    IBOutlet UIView* titleView;
    IBOutlet UIView* storeView;
    
    
    IBOutlet UIButton* startButton;
    IBOutlet UIButton* storeButton;
    IBOutlet UIButton* returnFromStoreButton;
    IBOutlet UIButton* returnFromMainButton;
    
    IBOutlet viewController* mainViewController;
    IBOutlet viewController* storeViewController;
    IBOutlet viewController* titleViewController;
    IBOutlet glesView* GLES_View;
    
// Common GUI
    IBOutlet UIView* SegmentContainerView;
    IBOutlet UIView* SegmentSettingView;
    
    IBOutlet UISegmentedControl* SEGMENT_SLOT_INDEX;///
    IBOutlet UISegmentedControl* SEGMENT_LOOP_POINT;///
    IBOutlet UISegmentedControl* SEGMENT_CLEAR_GESTURE;///
    IBOutlet UISegmentedControl* SEGMENT_PRAM_AND_OPTION;///
    
    IBOutlet UIButton* BUTTON_CUE;///
    IBOutlet UISlider* SLIDER_BPM;///
    IBOutlet UISlider* SLIDER_FADER;///
    IBOutlet UILabel* LABEL_BPM;
    IBOutlet UILabel* LABEL_BPM2;
    IBOutlet UILabel* LABEL_FADER;
    IBOutlet UILabel* LABEL_FADER2;
    
    IBOutlet UIImageView* VIEW_CURRENT_MODULE;
    IBOutlet UIImageView* VIEW_NEXT_MODULE;
    IBOutlet UIButton* BUTTON_MODULE_PREV;///
    IBOutlet UIButton* BUTTON_MODULE_NEXT;///
    IBOutlet UIButton* BUTTON_MODULE_CHANGE;///
    IBOutlet UIImageView* IMAGEVIEW_MODULE_FRAME;
    
    IBOutlet UIButton* BUTTON_RESET_PARAM;
    IBOutlet UIButton* BUTTON_SAVE;
    IBOutlet UIButton* BUTTON_LOAD;
    IBOutlet UIButton* BUTTON_EXIT;
    
    CADisplayLink* dispLink;
    EAGLContext* eaglContext;
    
    UIView* current_Segment_View;;

// External Monitor
    UIWindow* Ext_Window;
    glesView* Ext_View;
    BOOL isExtDraw;
    NSArray* ScreenMode_ARRAY;
    NSMutableArray* TableViewCell_ARRAY;
    
    IBOutlet UITableView* TABLEVIEW_MONITOR_RESOLUTION;//

// FPS Setting
    IBOutlet UISegmentedControl* SEGMENT_FPS;//
    IBOutlet UILabel* LABEL_FPS;
    BOOL isFPS_60;
    BOOL FPS_30_Switch;
    
// board vertex
    GLfloat boardVertex[4][4];
    GLfloat boardTexCoord[4][2];
    
// board & gesture shader
    IBOutlet UITextView* ShaderSource_View;
    GLuint BOARD_VS_SOBJ;
    GLuint BOARD_FS_SOBJ;
    GLuint BOARD_POBJ;
    GLuint UNF_boardTexture;
    GLuint UNF_faderValue;

    GLuint GESTURE_VS_SOBJ;
    GLuint GESTURE_FS_SOBJ;
    GLuint GESTURE_POBJ;
    GLuint UNF_color;
    
    GLuint GESTURE_2_VS_SOBJ;
    GLuint GESTURE_2_FS_SOBJ;
    GLuint GESTURE_2_POBJ;
    
// Buffer
    GLuint FBO_Rendering;
    GLuint FBO_Moniter;
    GLuint FBO_ExtraMonitor;
    
    GLuint TEX_Rendering;
    GLuint TEX_Depth;
    GLuint Tex_BGTexture;
    GLuint RBO_Monitor;
    GLuint RBO_ExtraMonitor;
    
    short isFBO_ExtraMonitor;
    short isRBO_ExtraMonitor;
// Universal Status
    Byte iPad_model_No;
    
    NSString* modelName;
    NSString* deviceName;
    NSString* language;
    UIAlertView* ALERT_VIEW;
    
    Byte BPM;//
    GLfloat FADER;//
    double BPM_COUNTER;
    double incrementFor_1frame;
    
    Byte CURRENT_LOOP_POINT[NUM_OF_SLOT][NUM_OF_MODULES]; // 1 * 5 * modules
    
    Byte BeatINDEX_64;
    Byte BeatINDEX_128;
    Byte BeatINDEX_256;
    
    BOOL isBeatFirst_64; // is used when gesture action send to modules
    BOOL isBeatFirst_128; // is used when gesture action send to modules
    BOOL isBeatFirst_256; // is used when gesture action send to modules
    
    enum MODE {TITLE_MODE, STORE_MODE, DRAW_MODE}CurrentMode;

    GLfloat timeLine[34][4];
    Byte CurrentTempo;
    double TempoPoint[17];
    GLfloat timeLineBar[4][4];
    GLfloat timeLineBarAnimation;
    
    Byte SLOT_INDEX;
 
    

// for modules
    NSMutableArray* module_ARRAY;
    short CURRENT_MODULE_INDEX;
    short NEXT_MODULE_INDEX;
    UIImage* In_Use_Icon;
    
// Gesture Recognizer
    UITapGestureRecognizer* Tap_GR;
    UILongPressGestureRecognizer* LongPress_GR;
    UIPanGestureRecognizer* Pan_GR;
    UIPinchGestureRecognizer* Pinch_GR;
    UIRotationGestureRecognizer* Rot_GR;
    UISwipeGestureRecognizer* Swipe_GR;

// Gesture Recording
    //tap
    BOOL State_Tap[NUM_OF_SLOT][NUM_OF_MODULES][64];// 1byte * 5 * 16* 64 = 5120byte
    GLfloat Value_Tap[NUM_OF_SLOT][NUM_OF_MODULES][64][2];// 4byte * 5 * 16 * 64 * 2 = 40960byte
    
    // longpress
    BOOL State_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][MAX_LONGPRESS_POINT][64];// 1byte * 5 * 4 * 16 * 64 = 20480byte
    GLfloat Value_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][MAX_LONGPRESS_POINT][2];// 4byte * 5 * 4 * 16 * 2 = 7360byte
    Byte LongPress_INDEX[NUM_OF_SLOT][NUM_OF_MODULES];// 1byte * 5 * 16 = 80byte
    BOOL isLongPressed;
    
    // pan
    BOOL State_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN];//  1byte * 5 * 16 * 256 = 20480byte
    GLfloat Value_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN][7];// 4byte * 5 * 16 * 256 * 7 = 573440byte
    Byte isPanHead[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN];// 1byte * 5 * 16 * 256 = 20480byte
    BOOL isPan;
    
    // pinch
    BOOL State_Pinch[NUM_OF_SLOT][NUM_OF_MODULES][128];// 1byte * 5 * 16 * 128 = 10240byte
    GLfloat Value_Pinch_Center[NUM_OF_SLOT][NUM_OF_MODULES][128][2];// 4byte * 5 * 16 * 128 * 2 = 81920byte
    GLfloat Value_Pinch_Radius[NUM_OF_SLOT][NUM_OF_MODULES][128];// 4byte * 5 * 16 * 128 = 40960byte
    GLfloat Value_Pinch_Scale[NUM_OF_SLOT][NUM_OF_MODULES][128];// 4byte * 5 * 16 * 128 = 40960byte
    GLfloat Value_Pinch_Velocity[NUM_OF_SLOT][NUM_OF_MODULES][128];// 4byte * 5 * 128 = 40960byte
    Byte isPinchHead[NUM_OF_SLOT][NUM_OF_MODULES][128];// 1byte * 5 * 16 * 128 = 10240byte
    BOOL isPinch;
    
// Gesture Drawing
    GLfloat CircleVertex[19][2];
    
    GLfloat TapVertex[19][4];
    GLfloat TapColor[4];
    GLfloat TapAnimation;

    GLfloat LongPressVertex[MAX_LONGPRESS_POINT][4][4];
    GLfloat LongPressColor[4];
    GLubyte LongPressElements[40];
    GLfloat LongPressAnimation;
    
    GLfloat last_Value_Pan[7];
    GLfloat Vertex_Pan[5][2][4];
    GLfloat Color_Pan[5][2][4];
    
    GLfloat last_Pinch_Center[2];
    GLfloat last_Pinch_Radius;
    GLfloat last_Pinch_Scale;
    GLfloat last_Pinch_Velocity;
    GLfloat act_Pinch_Scale;
    GLfloat act_Pinch_Center[2];
    GLfloat tempPinchVertex[19][4];
    GLfloat tempPinchColor[4];
    GLfloat pinchWeight;

}

@property ( readonly ) CADisplayLink* dispLink;
@property ( readonly ) enum MODE CurrentMode;

@property ( readonly ) NSMutableArray* TableViewCell_ARRAY;

@end




@interface mainController ( BUTTON_ACTION )
- (IBAction)button_start:(id)sender;
- (IBAction)button_store:(id)sender;
- (IBAction)button_returnFromStore:(id)sender;
- (IBAction)button_returnFromMain:(id)sender;
- (IBAction)button_exit:(id)sender;

- (void)fadeInStoreView:(NSString*)animationID;
- (void)storeViewFadeInFinished:(NSString*)animationID;

- (void)fadeInTitleView:(NSString*)animationID;
- (void)titleViewFadeInFinished:(NSString*)animationID;

- (void)fadeInMainView:(NSString*)animationID;
- (void)mainViewFadeInFinished:(NSString*)animationID;

- (void)backFromMainView:(NSString*)animationID;
- (void)returnFromMainViewFinished:(NSString*)animationID;
@end


@interface mainController ( DRAW )
- (void)draw:(CADisplayLink*)disp;
- (void)drawGesture;
@end


@interface mainController ( SCREEN )
- (void)screenConnected:(NSNotification*)notification;
- (void)screenDisconnected:(NSNotification*)notification;
- (void)screenModeChanged:(NSNotification*)notification;

- (void)makeExtWindow:(NSIndexPath*)indexPath;
- (void)deleteExtWindow;

- (void)updateScreenDataSource:(BOOL)yn;
@end

@interface mainController ( GESTURE )
- (void)setGestureRecognizerToGLESView;
- (void)gesture_Tapped:(UITapGestureRecognizer*)GR;
- (void)gesture_LongPressed:(UILongPressGestureRecognizer*)GR;
- (void)gesture_Pan:(UIPanGestureRecognizer*)GR;
- (void)gesture_Pinch:(UIPinchGestureRecognizer*)GR;
- (void)gesture_Rotate:(UIRotationGestureRecognizer*)GR;
- (void)gesture_Swipe:(UISwipeGestureRecognizer*)GR;

- (void)longPress_Cancel;
- (void)pan_Cancel;
- (void)pinch_Cancel;

- (void)setGestureEnabled:(BOOL)yn;
@end

@interface mainController ( GLES )
- (void)setGLESContext;
- (void)readBoardShaderSource;
- (void)setBuffers;
@end


@interface mainController ( GUI )
//- (IBAction)button_SegmentedControll:(UISegmentedControl*)sender;
- (IBAction)segment_ParamSettingTab:(UISegmentedControl*)sender;

- (IBAction)button_Cue:(UIButton*)sender;
- (IBAction)slider_BPM:(UISlider*)sender;
- (IBAction)slider_fader:(UISlider*)sender;
- (IBAction)button_SetDefault:(UIButton*)sender;

- (IBAction)segment_tempo_loop:(UISegmentedControl*)sender;
- (IBAction)segment_clear_gesture:(UISegmentedControl*)sender;
- (IBAction)segment_slot_index:(UISegmentedControl*)sender;

- (void)clearTap:(Byte)index moduleIndex:(short)M_INDEX;
- (void)clearLongPress:(Byte)index moduleIndex:(short)M_INDEX;
- (void)clearPan:(Byte)index moduleIndex:(short)M_INDEX;
- (void)clearPinch:(Byte)index moduleIndex:(short)M_INDEX;
@end

@interface mainController ( FPS )
- (IBAction)segment_FPS:(UISegmentedControl*)sender;
@end


@interface mainController ( MODULE_GUI )
- (IBAction)button_Module_Prev:(UIButton*)sender;
- (IBAction)button_Module_Next:(UIButton*)sender;
- (IBAction)button_Module_Change:(UIButton*)sender;
@end


@interface mainController ( INIT_GUI )
- (void)initGUI;
- (void)initSegmentGUI;
- (void)init_Module_GUI;
- (void)setDefault;
@end

@interface mainController ( SAVE_LOAD )
- (IBAction)button_save:(UIButton*)sender;
- (IBAction)button_load:(UIButton*)sender;
- (void)save:(Byte)num;
- (void)load:(Byte)num;

- (IBAction)button_DeleteSaveData:(UIButton*)sender;
@end

@interface mainController ( ALERT_VIEW )
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertViewCancel:(UIAlertView *)alertView;
@end

@interface mainController ( UTILITY )
- (void)stopAllUserInteraction:(BOOL)yn;

- (void)setGUI_Image;
@end