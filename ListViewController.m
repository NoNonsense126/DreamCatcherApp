//
//  ListViewController.m
//  DreamCatcher
//
//  Created by Wong You jing on 02/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "ListViewController.h"
#import "DescriptionViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *titleArray;
@property NSMutableArray *descriptionArray;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = [NSMutableArray new];
    self.descriptionArray = [NSMutableArray new];
    self.editing = false;
}

- (void)presentAddDreamBox
{
    UIAlertController *dreamController = [UIAlertController alertControllerWithTitle:@"Add Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [dreamController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Your Dream here";
    }];
    
    [dreamController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Your description here";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *title = dreamController.textFields[0].text;
        NSString *description = dreamController.textFields[1].text;
        [self.titleArray addObject:title];
        [self.descriptionArray addObject:description];
        [self.tableView reloadData];
    }];
    
    [dreamController addAction:cancelAction];
    [dreamController addAction:saveAction];
    
    [self presentViewController:dreamController animated:true completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.titleArray removeObjectAtIndex:indexPath.row];
    [self.descriptionArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}



- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
    [self presentAddDreamBox];
}

- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender
{
    if(self.editing == true){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        [sender setTitle:@"Edit"];
    }
    else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        NSLog(@"%@", sender.title);
        [sender setTitle:@"Done"];
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *titleItem = [self.titleArray objectAtIndex:sourceIndexPath.row];
    [self.titleArray removeObject:titleItem];
    [self.titleArray insertObject:titleItem atIndex:destinationIndexPath.row];
    
    NSString *descriptionItem = [self.descriptionArray objectAtIndex:sourceIndexPath.row];
    [self.descriptionArray removeObject:descriptionItem];
    [self.descriptionArray insertObject:descriptionItem atIndex:destinationIndexPath.row];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DescriptionViewController *descriptionController = segue.destinationViewController;
    descriptionController.dreamTitle = [self.titleArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    descriptionController.dreamDescription = [self.descriptionArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}
@end
