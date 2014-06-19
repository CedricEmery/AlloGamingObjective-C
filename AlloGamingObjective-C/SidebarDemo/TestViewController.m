//
//  TestViewController.m
//  SidebarDemo
//
//  Created by louis on 09/06/2014.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "TestViewController.h"
#import "SWRevealViewController.h"

@interface TestViewController ()
{
    NSMutableArray *myObject;
    // A dictionary object
    NSDictionary *dictionary;
    // Define keys
    NSString *title;
    NSString *thumbnail;
    NSString *author;
}@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"TEST";
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.10f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    title = @"title";
    thumbnail = @"thumbnail";
    author = @"author";
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://gooruism.com/?feed=json"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *title_data = [dataDict objectForKey:@"title"];
        NSString *thumbnail_data = [dataDict objectForKey:@"thumbnail"];
        NSString *author_data = [dataDict objectForKey:@"author"];
        
        NSLog(@"TITLE: %@",title_data);
        NSLog(@"THUMBNAIL: %@",thumbnail_data);
        NSLog(@"AUTHOR: %@",author_data);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      title_data, title,
                      thumbnail_data, thumbnail,
                      author_data,author,
                      nil];
        [myObject addObject:dictionary];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myObject.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:
              UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    //text = [NSString stringWithFormat:@"%@",[tmpDict objectForKey:title]];
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    
    NSMutableString *detail;
    detail = [NSMutableString stringWithFormat:@"Author: %@ ",
              [tmpDict objectForKey:author]];
    
    NSMutableString *images;
    images = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:thumbnail]];
    
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:thumbnail]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    
    cell.textLabel.text = text;
    cell.detailTextLabel.text= detail;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image =img;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
