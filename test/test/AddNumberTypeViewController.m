//
//  AddNumberTypeViewController.m
//  MissionEditor
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import "AddNumberTypeViewController.h"

@interface AddNumberTypeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *parameterNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *MaxValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *MinValueTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation AddNumberTypeViewController
- (IBAction)checkInput:(UIButton *)sender {
    
    if ([self checkValueIsError]) {
        
        [self showAlert];
        return;
    }else{
        self.isFromSaveButton = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"backFromAddNumber" sender:self];
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
    
    if (self.parameterNameTextField.text.length == 0 || self.MaxValueTextField.text.length == 0 || self.MinValueTextField.text.length == 0) {
        isError = true;
    }else if(self.MaxValueTextField.text.floatValue <= self.MinValueTextField.text.floatValue) {
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
        
        NSString *value = [NSString stringWithFormat:@"%@%@%@", self.MinValueTextField.text, @"-", self.MaxValueTextField.text];
        self.parameterItem.value = value;
        
    }
    
    
    
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
