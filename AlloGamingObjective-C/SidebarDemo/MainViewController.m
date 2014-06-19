//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"

#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableViewArray;


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"News";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.10f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL   URLWithString:@"http://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    NSDictionary *feed = [jsonObjects objectForKey:@"feed"];
    NSArray *entries = [feed objectForKey:@"entry"];
    
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:[entries count]];
    
    
    for (NSDictionary *item in entries)
    {
        NSArray *keys = [item allKeys];
        
        // values in foreach loop
        for (NSString *key in keys)
        {
            NSLog(@"%@ is %@",key, [item objectForKey:key]);
        }
        
        [titles addObject:[[item objectForKey:@"title"] objectForKey:@"$t"]];
        
    }
    self.tableViewArray = titles;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableIdentifier"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SimpleTableIdentifier"];
    }
    
    cell.textLabel.text = [tableViewArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
   
    
}
@end
