//
//  AddGameModuleViewController.h
//  MissionEditor
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGameModuleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate>

- (IBAction)unwindToAddGameModuleViewController:(UIStoryboardSegue *)segue;
@end
