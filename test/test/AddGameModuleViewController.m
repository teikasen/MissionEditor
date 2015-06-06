//  AddGameModuleViewController.m
//  MissionEditor
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 moreChinese. All rights reserved.
//

#import "AddGameModuleViewController.h"
#import "ParameterItem.h"
#import "AddEnumTypeViewController.h"
#import "AddNumberTypeViewController.h"

@interface AddGameModuleViewController ()

@property (strong,nonatomic) NSMutableArray *parameterList;
@property (weak, nonatomic) IBOutlet UITableView *parameterTable;
@property (weak, nonatomic) IBOutlet UIImageView *gameIcon;

@property (nonatomic) UIImagePickerController *imagePickerController;

@property (nonatomic) NSMutableArray *capturedImages;

@end

@implementation AddGameModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self parameterTable] setDelegate:self];
    [[self parameterTable] setDataSource:self];
    
    self.parameterList = [[NSMutableArray alloc] init];
    
    self.capturedImages = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showImagePickerForPhotoPicker:(UIButton *)sender {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}



- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType{
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


- (void)unwindToAddGameModuleViewController:(UIStoryboardSegue *)segue{
    
    
    if ([[segue sourceViewController] isKindOfClass: [AddEnumTypeViewController class]]) {
        
        ParameterItem *enumTypeParameter = [[segue sourceViewController] parameterItem];
        if (enumTypeParameter != nil && [[segue sourceViewController] isFromSaveButton]) {
             [[segue sourceViewController] setIsFromSaveButton:FALSE];
             [[self parameterList] addObject:enumTypeParameter];
        }
        
    }
    
    if ([[segue sourceViewController] isKindOfClass:[AddNumberTypeViewController class]]) {
        ParameterItem *numberTypeParameter = [[segue sourceViewController] parameterItem];
        if (numberTypeParameter != nil && [[segue sourceViewController] isFromSaveButton]) {
             [[segue sourceViewController] setIsFromSaveButton:FALSE];
            [[self parameterList] addObject:numberTypeParameter];

        }
    }
    [self.parameterTable reloadData];
}


- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
     if ([self.capturedImages count] == 1)
    {
        [self.gameIcon setImage:[self.capturedImages objectAtIndex:0]];
    }
    
    // To be ready to start again, clear the captured images array.
    [self.capturedImages removeAllObjects];
    
    self.imagePickerController = nil;
}


#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
   [self.capturedImages addObject:image];
    
    [self finishAndUpdate];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [self.parameterList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"parameterCell" forIndexPath:indexPath];
    ParameterItem *item = [self.parameterList objectAtIndex:indexPath.row];
   
    NSString *title = [NSString stringWithFormat:@"  %@ :  %@", item.name, item.value];
    cell.textLabel.text = title;
    
    return cell;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.parameterList removeObjectAtIndex:[indexPath row]];
         [self.parameterTable  deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
