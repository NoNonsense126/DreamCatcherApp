//
//  DescriptionViewController.m
//  DreamCatcher
//
//  Created by Wong You jing on 03/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.dreamDescription;
    self.title = self.dreamTitle;
}



@end
