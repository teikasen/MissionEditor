//
//  AddNumberTypeViewController.h
//  MissionEditor
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParameterItem.h"

@interface AddNumberTypeViewController : UIViewController<UIAlertViewDelegate>
@property ParameterItem *parameterItem;
@property (nonatomic) BOOL isFromSaveButton;
@end
