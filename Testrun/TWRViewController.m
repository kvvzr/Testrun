//
//  TWRViewController.m
//  Testrun
//
//  Created by Kawazure on 2014/06/30.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import "TWRViewController.h"
#import "TWRMatchViewController.h"
#import "UIColor+Twinkrun.h"
#import "UIStepper+Block.h"

@interface TWRViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) NSMutableDictionary *settings;

@end

@implementation TWRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.settings = [NSMutableDictionary dictionary];
    self.settings[@"mode"] = @"random";
    self.settings[@"colors"] = [NSMutableDictionary dictionary];
    self.settings[@"colors"][@"Pink"] = @{@"color": [UIColor twinkrunPink], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Red"] = @{@"color": [UIColor twinkrunRed], @"tintColor": [UIColor twinkrunBlack], @"count": @4, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Orange"] = @{@"color": [UIColor twinkrunOrange], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Yellow"] = @{@"color": [UIColor twinkrunYellow], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Green"] = @{@"color": [UIColor twinkrunGreen], @"tintColor": [UIColor twinkrunBlack], @"count": @3, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Cyan"] = @{@"color": [UIColor twinkrunCyan], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Blue"] = @{@"color": [UIColor twinkrunBlue], @"tintColor": [UIColor twinkrunWhite], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Violet"] = @{@"color": [UIColor twinkrunViolet], @"tintColor": [UIColor twinkrunWhite], @"count": @0, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"Black"] = @{@"color": [UIColor twinkrunBlack], @"tintColor": [UIColor twinkrunWhite], @"count": @3, @"time": @3}.mutableCopy;
    self.settings[@"colors"][@"White"] = @{@"color": [UIColor twinkrunWhite], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3}.mutableCopy;
    
    RedrawTarget defaultFormat = ^(NSDictionary *target, double value){
        target[@"color"][@"count"] = @(value);
        [target[@"label"] setText:[NSString stringWithFormat:@"%d", (int)value]];
    };
    
    RedrawTarget timeFormat = ^(NSDictionary *target, double value){
        target[@"color"][@"time"] = @(value);
        
        int m = (int) value / 60;
        int s = (int) value % 60;
        [target[@"label"] setText:[NSString stringWithFormat:@"%02d:%02d", m, s]];
    };
    
    self.cells = [NSMutableArray array];
    [self.cells addObject:[NSMutableArray array]];
    for (NSString *key in [self.settings[@"colors"] allKeys]) {
        NSDictionary *color = self.settings[@"colors"][key];
        [self.cells[0] addObject:@{@"identifier": @"upDownCell", @"name": key, @"default": color[@"count"],
                                   @"min": @0, @"max": @10, @"step": @1,
                                   @"color": [(UIColor *)color[@"color"] colorWithAlphaComponent:0.5],
                                   @"tintColor": (UIColor *)color[@"tintColor"],
                                   @"redrawTarget": defaultFormat,
                                   }];
        [self.cells[0] addObject:@{@"identifier": @"upDownCell", @"name": [NSString stringWithFormat:@"%@ Time", key], @"default": color[@"time"],
                                   @"min": @1, @"max": @10, @"step": @1,
                                   @"color": [(UIColor *)color[@"color"] colorWithAlphaComponent:0.5],
                                   @"tintColor": (UIColor *)color[@"tintColor"],
                                   @"redrawTarget": timeFormat,
                                   }];
    }
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
    
    NSArray *names = [content[@"name"] componentsSeparatedByString:@" "];
    NSMutableDictionary *targetColor = self.settings[@"colors"][names[0]];
    
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
    [stepper setTarget:@{@"color": targetColor, @"label": valueLabel}];
    [stepper setBlock:content[@"redrawTarget"]];
    [stepper redrawTarget];
    
    [cell setBackgroundColor:content[@"color"]];
    
    return cell;
}

- (void)stepped:(UIStepper *)sender
{
    [sender redrawTarget];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goMatchSegue"]) {
        TWRMatchViewController *controller = (TWRMatchViewController *)segue.destinationViewController;
        controller.settings = self.settings;
    }
}

@end
