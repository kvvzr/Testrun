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

@property (nonatomic, strong) NSArray *cells;

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
    
    self.cells = @[ // sections
                    @[ // rows
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Pink",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunPink] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunPink] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Red",
                           @"default": @4,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunRed] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunRed] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Orange",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunOrange] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunOrange] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Yellow",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunYellow] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunYellow] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Green",
                           @"default": @3,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunGreen] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunGreen] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Cyan",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunCyan] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunCyan] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Blue",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunBlue] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunBlue] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": timeFormat,
                           },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Violet",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunViolet] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunViolet] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Black",
                           @"default": @3,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunBlack] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunBlack] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunWhite],
                           @"redrawTarget": timeFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"White",
                           @"default": @0,
                           @"min": @0,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunWhite] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": defaultFormat,
                        },
                       @{
                           @"identifier": @"upDownCell",
                           @"name": @"Time",
                           @"default": @3,
                           @"min": @1,
                           @"max": @10,
                           @"step": @1,
                           @"color": [[UIColor twinkrunWhite] colorWithAlphaComponent:0.5],
                           @"tintColor": [UIColor twinkrunBlack],
                           @"redrawTarget": timeFormat,
                        },
                    ]
                ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    for (NSArray *array in self.cells) {
        count += array.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *content = self.cells[indexPath.section][indexPath.row];
    UIColor *tintColor = content[@"tintColor"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:content[@"identifier"]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    [nameLabel setText:content[@"name"]];
    [nameLabel setTextColor:tintColor];
    
    UILabel *valueLabel = (UILabel *)[cell viewWithTag:3];
    NSString *value = [NSString stringWithFormat:@"%@", content[@"default"]];
    [valueLabel setText:value];
    [valueLabel setTextColor:tintColor];
    
    UIStepper *stepper = (UIStepper * )[cell viewWithTag:1];
    [stepper setValue:[(NSNumber *)content[@"default"] doubleValue]];
    [stepper setTintColor:tintColor];
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
