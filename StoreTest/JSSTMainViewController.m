//
//  JSSTMainViewController.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTMainViewController.h"

@interface JSSTMainViewController ()
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *resultIcons;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSURLSessionDataTask *searchTask;
@property (nonatomic, strong) NSURLSessionDataTask *iconsTask;

@end

@implementation JSSTMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //don't show original tableview
//    self.tableView.hidden = YES;
    
    self.title = @"App Store";
    self.searchResults = [[NSMutableArray alloc] init];
    self.resultIcons = [[NSMutableArray alloc] init];
    
    self.searchBar = [[UISearchBar alloc] init];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.displaysSearchBarInNavigationBar = YES;
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.searchController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.searchBar.delegate = self;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *result = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = [result objectForKey:@"trackName"];
    UIImage *iconImage = [self.resultIcons objectAtIndex:indexPath.row];
    if (iconImage)
    {
        cell.imageView.image = [self.resultIcons objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSSTDetailViewController *detailVC = [[JSSTDetailViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    NSDictionary *result =[self.searchResults objectAtIndex:indexPath.row];
    detailVC.resultScreenShots = [result objectForKey:@"screenshotUrls"];
    detailVC.resultDescription = [result objectForKey:@"description"];
    [self.navigationController pushViewController:detailVC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    self.searchResults = [[NSMutableArray alloc] init];
//    [self.searchController.searchResultsTableView reloadData];
//    NSLog(@"did begin");
//}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchResults = [[NSMutableArray alloc] init];
    [self doSearch];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self doSearch];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self doSearch];
}

-(void)doSearch
{
    NSLog(@"did end");
    
    if (self.searchTask)
    {
        [self.searchTask cancel];
        [self.iconsTask cancel];
    }
    
    NSString *baseURL = @"https://itunes.apple.com/search?media=software&term=";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURL, [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    NSURLSession *session = [NSURLSession sharedSession];
    self.searchTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          NSDictionary *resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
          self.searchResults = [resultsDictionary objectForKey:@"results"];
          self.resultIcons = [[NSMutableArray alloc] initWithCapacity:[self.searchResults count]];
          [self loadIcons];
          [self.searchController.searchResultsTableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
          
      }];
    [self.searchTask resume];
}

-(void)loadIcons
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    for (int i = 0; i<[self.searchResults count]; i++)
    {
        [self.resultIcons insertObject:[[UIImage alloc] init] atIndex:i];
        NSDictionary *result = [self.searchResults objectAtIndex:i];
        NSURL *iconURL = [NSURL URLWithString:[result objectForKey:@"artworkUrl60"]];
        self.iconsTask = [session dataTaskWithURL:iconURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (i < [self.resultIcons count]) {
                [self.resultIcons replaceObjectAtIndex:i withObject:[UIImage imageWithData:data]];
                [self.searchController.searchResultsTableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
            }
        }];
        
        [self.iconsTask resume];
    }
    
}

@end
