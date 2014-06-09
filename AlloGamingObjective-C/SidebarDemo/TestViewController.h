//
//  TestViewController.h
//  SidebarDemo
//
//  Created by louis on 09/06/2014.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *tableViewArray;
}

@property (weak, nonatomic) IBOutlet UITableView *_tableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
