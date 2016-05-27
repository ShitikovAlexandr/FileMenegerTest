//
//  DirectoryViewController.m
//  FileMenegerTest
//
//  Created by MacUser on 14.04.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@property (strong, nonatomic) NSString* path;

@end

@implementation DirectoryViewController

- (id) initWhithFolderPath:(NSString *)path {
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.path = path;
    }
    
    return self;
}

-(void) setPath:(NSString *)path {
    
    _path = path;
    NSError* error = nil;
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    [self.tableView reloadData];
    
    self.navigationItem.title = [self.path lastPathComponent];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if (!self.path) {
        self.path = @"/";
    }
    
  }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Back to Root"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionBackToRoot:)];
        
        self.navigationItem.rightBarButtonItem = item;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL) isDirectoryAtIndexPath: (NSIndexPath*) indexPath {
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    BOOL isDirectory = NO;
    
    NSString* filePath = [self.path  stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
    
}

#pragma mark - Action

- (void) actionBackToRoot: (UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIndetifire;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifire ];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifire];
    }
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fileName;
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"file.png"];

    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
         [self performSegueWithIdentifier:@"navigateDeep" sender:nil];
    }
}

#pragma - mark Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}


@end
