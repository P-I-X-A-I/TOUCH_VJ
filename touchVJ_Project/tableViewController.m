//
//  tableViewController.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/05/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "tableViewController.h"


@implementation tableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];

    
    
    return self;
}


- (void)awakeFromNib
{
    NSLog(@"tableViewController AFN");
    
    TableViewCell_ARRAY = mainController_OBJ.TableViewCell_ARRAY;

}

//required
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* tempCell;
    NSLog(@"TVC * cell For Row at IndexPath %d", [indexPath indexAtPosition:1]);
    
    tempCell = [TableViewCell_ARRAY objectAtIndex:[indexPath indexAtPosition:1]];
    
    return tempCell;
}
// required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"TVC * number of rows in section");
    
    return [TableViewCell_ARRAY count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"TVC * number of sections in table view");
    
    return (NSInteger)1;
}
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSLog(@"TVC * section index titles for table view");
    
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"section for section index title");
    
    return (NSInteger)0;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"footer desu";
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Video Out Resolutions";
}





// insert or delete table row
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TVC * commit editiong style for row at indexpath");
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"can Edit row at indexpath");
    return  NO;
}

// reordering table rows
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"can move row at index path");
    
    return NO;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"move row at index path");
}



// Delegate Method
// configuring rows for the tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"height for row at indexpath");
    
    return (CGFloat)25.0f;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"identation level for row at indexpath");
    
    return (NSInteger)0;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will display cell");
}

// managing accesorry views
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"accessory button tapped");
}

// managing selections
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will select row");
    
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select row %d", [indexPath indexAtPosition:1]);
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    // make Ext window
    UITableViewCell* didSelect_Cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell* mirror_Cell = [TableViewCell_ARRAY lastObject];
    
    if( [didSelect_Cell isEqual:mirror_Cell] ) // selected cell is equal to mirror cell
    {
        [mainController_OBJ stopAllUserInteraction:YES];
        [mainController_OBJ deleteExtWindow];
        [mainController_OBJ stopAllUserInteraction:NO];
    }
    else
    {
        [mainController_OBJ stopAllUserInteraction:YES];
        [mainController_OBJ makeExtWindow:indexPath];
        [mainController_OBJ stopAllUserInteraction:NO];
    }
}


- (NSIndexPath*)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will deselect row");
    
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    NSLog(@"did deselect row");
}

// modifying the header and footer of sectons
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    NSLog(@"view for header in section");
    
//    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
//                                                                     0.0f,
//                                                                     tableView.frame.size.width, 
//                                                                     25.0f)];
//    headerLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
//    headerLabel.backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
//    headerLabel.font = [UIFont systemFontOfSize:13.0f];
//    headerLabel.text = @" Video Out Resolutions ";
//    return headerLabel;

    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSLog(@"view for footer in section");
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSLog(@"height for header");
    
    return (CGFloat)0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSLog(@"height for footer");
    
    return (CGFloat)0.0f;
}

// editing table rows
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"will begin editing row");
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did end editing row");
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"editing style");
    
    return UITableViewCellEditingStyleNone;
}
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"title for delete confirmation button");
    
    return @"kesuyo";
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"should indent while editing row");
    return YES;
}

// Reordering table rows
- (NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSLog(@"target indexpath for move from row ");
    return proposedDestinationIndexPath;
}


@end
