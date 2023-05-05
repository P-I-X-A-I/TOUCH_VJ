//
//  touchVJ_ProjectAppDelegate.h
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainController.h"
@interface touchVJ_ProjectAppDelegate : NSObject <UIApplicationDelegate> {

    IBOutlet mainController* mainController_OBJ;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
