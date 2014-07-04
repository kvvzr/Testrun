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

@interface TWRViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *plusButton;
@property (nonatomic, strong) NSMutableArray *randomCells, *orderCells;
@property (nonatomic, strong) NSDictionary *defaultValues;
@property (nonatomic, strong) NSMutableDictionary *settings;
@property (nonatomic, copy) RedrawTarget defaultFormat, timeFormat;

- (IBAction)modeChanged:(id)sender;
- (IBAction)touchPlusButton:(id)sender;

@end

@implementation TWRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.defaultValues = @{
                           @"Pink": @{@"color": [UIColor twinkrunPink], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3},
                           @"Red": @{@"color": [UIColor twinkrunRed], @"tintColor": [UIColor twinkrunBlack], @"count": @4, @"time": @3},
                           @"Orange": @{@"color": [UIColor twinkrunOrange], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3},
                           @"Yellow": @{@"color": [UIColor twinkrunYellow], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3},
                           @"Green": @{@"color": [UIColor twinkrunGreen], @"tintColor": [UIColor twinkrunBlack], @"count": @3, @"time": @3},
                           @"Cyan": @{@"color": [UIColor twinkrunCyan], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3},
                           @"Blue": @{@"color": [UIColor twinkrunBlue], @"tintColor": [UIColor twinkrunWhite], @"count": @0, @"time": @3},
                           @"Violet": @{@"color": [UIColor twinkrunViolet], @"tintColor": [UIColor twinkrunWhite], @"count": @0, @"time": @3},
                           @"Black": @{@"color": [UIColor twinkrunBlack], @"tintColor": [UIColor twinkrunWhite], @"count": @3, @"time": @3},
                           @"White": @{@"color": [UIColor twinkrunWhite], @"tintColor": [UIColor twinkrunBlack], @"count": @0, @"time": @3},
                           };
    
    self.settings = [NSMutableDictionary dictionary];
    self.settings[@"mode"] = @"random";
    
    self.defaultFormat = ^(NSMutableDictionary *target, double value){
        target[@"data"][@"value"] = @(value);
        [target[@"label"] setText:[NSString stringWithFormat:@"%d", (int)value]];
    };
    
    self.timeFormat = ^(NSMutableDictionary *target, double value){
        target[@"data"][@"value"] = @(value);
        
        int m = (int) value / 60;
        int s = (int) value % 60;
        [target[@"label"] setText:[NSString stringWithFormat:@"%02d:%02d", m, s]];
    };
    
    self.randomCells = [NSMutableArray array];
    for (NSString *key in [self.defaultValues allKeys]) {
        NSDictionary *color = self.defaultValues[key];
        [self.randomCells addObject:@{@"identifier": @"upDownCell", @"name": key, @"value": color[@"count"],
                                         @"min": @0, @"max": @10, @"step": @1,
                                         @"color": [(UIColor *)color[@"color"] colorWithAlphaComponent:0.5],
                                         @"tintColor": (UIColor *)color[@"tintColor"],
                                         @"redrawTarget": self.defaultFormat,
                                         }.mutableCopy];
        [self.randomCells addObject:@{@"identifier": @"upDownCell", @"name": [NSString stringWithFormat:@"%@ Time", key], @"value": color[@"time"],
                                         @"min": @1, @"max": @30, @"step": @1,
                                         @"color": [(UIColor *)color[@"color"] colorWithAlphaComponent:0.5],
                                         @"tintColor": (UIColor *)color[@"tintColor"],
                                         @"redrawTarget": self.timeFormat,
                                         }.mutableCopy];
    }
    
    self.orderCells = [NSMutableArray array];
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
    if ([self.settings[@"mode"] isEqualToString:@"random"]) {
        return self.randomCells.count;
    } else {
        return self.orderCells.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *content;
    
    if ([indexPath row] < 0) {
        return [tableView dequeueReusableCellWithIdentifier:content[@"identifier"]];
    }
    
    if ([self.settings[@"mode"] isEqualToString:@"random"]) {
        content = self.randomCells[indexPath.row];
    } else {
        content = self.orderCells[indexPath.row];
    }
    
    UIColor *tintColor = content[@"tintColor"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:content[@"identifier"]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
    [nameLabel setText:content[@"name"]];
    [nameLabel setTextColor:tintColor];
    
    UILabel *valueLabel = (UILabel *)[cell viewWithTag:3];
    NSString *value = [NSString stringWithFormat:@"%@", content[@"value"]];
    [valueLabel setText:value];
    [valueLabel setTextColor:tintColor];
    
    UIStepper *stepper = (UIStepper * )[cell viewWithTag:1];
    
    [stepper setTintColor:tintColor];
    [stepper setMinimumValue:[(NSNumber *)content[@"min"] doubleValue]];
    [stepper setMaximumValue:[(NSNumber *)content[@"max"] doubleValue]];
    [stepper setValue:[(NSNumber *)content[@"value"] doubleValue]];
    [stepper setStepValue:[(NSNumber *)content[@"step"] doubleValue]];
    [stepper addTarget:self action:@selector(stepped:) forControlEvents:UIControlEventValueChanged];
    [stepper setTarget:@{@"data": content, @"label": valueLabel}];
    [stepper setBlock:content[@"redrawTarget"]];
    [stepper redrawTarget];
    
    [cell setBackgroundColor:content[@"color"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSDictionary *cell = [self.orderCells objectAtIndex:sourceIndexPath.row];
    [self.orderCells removeObject:cell];
    [self.orderCells insertObject:cell atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.orderCells removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:YES];
    }
    [tableView endUpdates];
}

- (void)stepped:(UIStepper *)sender
{
    [sender redrawTarget];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goMatchSegue"]) {
        [self cellsToSettings];
        TWRMatchViewController *controller = (TWRMatchViewController *)segue.destinationViewController;
        controller.settings = self.settings;
    }
}

- (IBAction)modeChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.settings[@"mode"] = @"random";
            [self.plusButton setEnabled:NO];
            [self.tableView setEditing:NO animated:YES];
            
            break;
        case 1:
            self.settings[@"mode"] = @"order";
            [self.plusButton setEnabled:YES];
            [self.tableView setEditing:YES animated:YES];
            
            break;
    }
    [self.tableView reloadData];
}

- (IBAction)touchPlusButton:(id)sender {
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self
                                           cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    for (NSString *key in self.defaultValues) {
        [dialog addButtonWithTitle:key];
    }
    [dialog show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    
    NSArray *keys = [self.defaultValues allKeys];
    NSString *name = [keys objectAtIndex:buttonIndex - 1];
    NSDictionary *value = [self.defaultValues objectForKey:name];
    
    [self.orderCells addObject:@{@"identifier": @"orderUpDownCell", @"name": name, @"value": @3,
                                 @"min": @1, @"max": @30, @"step": @1,
                                 @"color": [value[@"color"] colorWithAlphaComponent:0.5],
                                 @"tintColor": value[@"tintColor"],
                                 @"redrawTarget": self.timeFormat,
                                 }.mutableCopy];
    
    [self.tableView reloadData];
}

- (void)cellsToSettings
{
    if ([self.settings[@"mode"] isEqualToString:@"random"]) {
        NSMutableDictionary *colors = [NSMutableDictionary dictionary];
        for (NSDictionary *cell in self.randomCells) {
            NSArray *names = [(NSString *)cell[@"name"] componentsSeparatedByString:@" "];
            NSString *name = names[0]; // ex. Pink Time => Pink
            
            if (!colors[name]) {
                colors[name] = [NSMutableDictionary dictionary];
                colors[name][@"color"] = [(UIColor *)cell[@"color"] colorWithAlphaComponent:1.0];
            }
            
            if (names.count > 1 && [names[1] isEqualToString:@"Time"]) {
                colors[name][@"time"] = cell[@"value"];
            } else {
                colors[name][@"count"] = cell[@"value"];
            }
        }
        self.settings[@"colors"] = colors;
    } else {
        NSMutableArray *colors = [NSMutableArray array];
        for (NSDictionary *cell in self.orderCells) {
            [colors addObject:@{@"color": [(UIColor *)cell[@"color"] colorWithAlphaComponent:1.0], @"time": cell[@"value"]}];
        }
        self.settings[@"colors"] = colors;
    }
}

@end
