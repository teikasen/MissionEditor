//
//  AddEnumTypeViewController.m
//  MissionEditor
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import "AddEnumTypeViewController.h"

@interface AddEnumTypeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *parameterNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *parameterValueTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddEnumTypeViewController

- (IBAction)checkInputContent:(UIButton *)sender {
    if ([self checkValueIsError]) {
        [self showAlert];
        return;
    }else {
        self.isFromSaveButton = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
      [self performSegueWithIdentifier:@"backFromAddEnum" sender:self];
    }

}

- (IBAction)back:(UIButton *)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFromSaveButton = FALSE;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//验证输入的值是否有误
- (BOOL)checkValueIsError {
    BOOL isError = false;
    
    if (self.parameterNameTextField.text.length == 0 || self.parameterValueTextField.text.length == 0) {
        isError = true;
    }
    
    return isError;
}



-(void)showAlert{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"输入有误"
                              message:@"输入内容有误,请重新输入"
                              delegate:self
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil];
    [alertView show];
    
    
    
}


#pragma mark-- 实现UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if (self.isFromSaveButton) {
        self.parameterItem = [[ParameterItem alloc] init];
        self.parameterItem.isEnumType = YES;
        self.parameterItem.name = self.parameterNameTextField.text;
        self.parameterItem.value = self.parameterValueTextField.text;
           }
    
   
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
