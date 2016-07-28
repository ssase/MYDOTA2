//
//  SearchFunctionHeroCDTVC.m
//  MYDOTA2
//
//  Created by SASE on 7/27/16.
//  Copyright © 2016 SASE. All rights reserved.
//

#import "SearchFunctionHeroCDTVC.h"
#import "HeroDetailViewController.h"

@interface  SearchFunctionHeroCDTVC () <UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

// our secondary search results table view
@property (nonatomic, strong) HeroCDTVC *searchResultsTableController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end

@implementation SearchFunctionHeroCDTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchResultsTableController = [[HeroCDTVC alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.searchResultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    self.searchController.searchBar.placeholder = @"输入英雄中文名或英文简称";
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HeroDetailViewController"];
   // detailViewController.product = selectedProduct; // hand off the current product to the detail view controller
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    // note: should not be necessary but current iOS 8.0 bug (seed 4) requires it
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    char* p = (char*)[searchText cStringUsingEncoding:NSUnicodeStringEncoding];

    NSString *predicateString1 = @"((name like '*') ";
    NSString *predicateString2 = @"((name like '*') ";
    NSString *predicateString3 = @"((name like '*') ";

    if ([searchText length]) {
       
        for (int i = 0 ; i < ([searchText length]*2-1) ; i++) {
            if (!(i%2)) {
                NSString *tempString1 = [NSString stringWithFormat:@"AND (name CONTAINS[cd] '%c') ",p[i]];
                predicateString1 = [predicateString1 stringByAppendingString:tempString1];
                
                NSString *tempString2 = [NSString stringWithFormat:@"AND (namePinyin CONTAINS[cd] '%c') ",p[i]];
                predicateString2 = [predicateString2 stringByAppendingString:tempString2];
                
                NSString *tempString3 = [NSString stringWithFormat:@"AND (localizedName CONTAINS[cd] '%c') ",p[i]];
                predicateString3 = [predicateString3 stringByAppendingString:tempString3];

            }
        }
    predicateString1 = [predicateString1 stringByAppendingString:@") OR "];
    predicateString2 = [predicateString2 stringByAppendingString:@") OR "];
    predicateString3 = [predicateString3 stringByAppendingString:@")"];

    NSString *predicateString = [predicateString1 stringByAppendingString:predicateString2];
    predicateString = [predicateString stringByAppendingString:predicateString3];
        
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hero"];
    request.predicate = [NSPredicate predicateWithFormat:predicateString];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"namePinyin" ascending:YES]];
    self.searchResultsTableController.fetchedResultsController = [[NSFetchedResultsController alloc]
            initWithFetchRequest:request
            managedObjectContext:self.managedObjectContect
            sectionNameKeyPath:nil
            cacheName:nil];
    
    // hand over the filtered results to our search results table
    [self.searchResultsTableController.tableView reloadData];
        
    }else {
        //deal with null ...
        //such as adding some buttons named "敏捷" "远程" and so on
    }
    
}


@end
