//
//  DirectoryViewController.h
//  FileMenegerTest
//
//  Created by MacUser on 14.04.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryViewController : UITableViewController

@property (strong, nonatomic) NSArray* contents;

- (id) initWhithFolderPath:(NSString*) path;

@end
