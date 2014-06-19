//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableViewArray;
}

@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (nonatomic, retain) NSArray *tableViewArray;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
