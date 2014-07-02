//
//  TWRViewController.m
//  Testrun
//
//  Created by Kawazure on 2014/06/30.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import "TWRViewController.h"
#import "UIColor+Twinkrun.h"
#import "UIStepper+Block.h"

@interface TWRViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *cells;

@end

@implementation TWRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    RedrawTarget defaultFormat = ^(UILabel *target, double value){
        [target setText:[NSString stringWithFormat:@"%d", (int)value]];
    };
    
    RedrawTarget timeFormat = ^(UILabel *target, double value){
        int m = (int) value / 60;
        int s = (int) value % 60;
        [target setText:[NSString stringWithFormat:@"%02d:%02d", m, s]];
    };
    
    self.cells = @{
       [NSIndexPath indexPathForRow:0 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Time",
            @"default": @30,
            @"min": @10,
            @"max": @180,
            @"step": @10,
            @"redrawTarget": timeFormat,
        },
        [NSIndexPath indexPathForRow:0 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Pink",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:1 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Red",
            @"default": @4,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"color": [[UIColor twinkrunRed] colorWithAlphaComponent:0.5],
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:2 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Orange",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:3 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Yellow",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:4 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Green",
            @"default": @3,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"color": [[UIColor twinkrunGreen] colorWithAlphaComponent:0.5],
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:5 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Cyan",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:6 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Blue",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:7 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Violet",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:8 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"Black",
            @"default": @3,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"color": [[UIColor twinkrunBlack] colorWithAlphaComponent:0.5],
            @"redrawTarget": defaultFormat,
        },
        [NSIndexPath indexPathForRow:9 inSection:0]: @{
            @"identifier": @"upDownCell",
            @"name": @"White",
            @"default": @0,
            @"min": @0,
            @"max": @10,
            @"step": @1,
            @"color": [[UIColor twinkrunWhite] colorWithAlphaComponent:0.5],
            @"redrawTarget": defaultFormat,
        },
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *content = self.cells[indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:content[@"identifier"]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    [nameLabel setText:content[@"name"]];
    
    UILabel *valueLabel = (UILabel *)[cell viewWithTag:3];
    NSString *value = [NSString stringWithFormat:@"%@", content[@"default"]];
    [valueLabel setText:value];
    
    UIStepper *stepper = (UIStepper * )[cell viewWithTag:1];
    [stepper setValue:[(NSNumber *)content[@"default"] doubleValue]];
    [stepper setMinimumValue:[(NSNumber *)content[@"min"] doubleValue]];
    [stepper setMaximumValue:[(NSNumber *)content[@"max"] doubleValue]];
    [stepper setStepValue:[(NSNumber *)content[@"step"] doubleValue]];
    [stepper addTarget:self action:@selector(stepped:) forControlEvents:UIControlEventValueChanged];
    [stepper setTarget:valueLabel];
    [stepper setBlock:content[@"redrawTarget"]];
    [stepper redrawTarget];
    
    [cell setBackgroundColor:content[@"color"]];
    
    return cell;
}

- (void)stepped:(UIStepper *)sender
{
    [sender redrawTarget];
}

@end
