//
//  ListofItem.m
//  TestDemo
//
//  Created by Ankit's Mac on 22/11/15.
//  Copyright (c) 2015 Ankit's Mac. All rights reserved.
//

#import "ListofItem.h"
#import "BaseView.h"

@interface ListofItem ()

@end

@implementation ListofItem

@synthesize tblData;

- (void)viewDidLoad {
    
    UIBarButtonItem *AddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(BtnAddPress:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = AddButton;
    
    
    listOfContact = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) databaseOpen {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TestDB.sqlite"];
    databasecheckfmdb = [FMDatabase databaseWithPath:writableDBPath];
    
    [databasecheckfmdb open];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self LoadAllData];
    [tblData reloadData];
}

- (IBAction)BtnAddPress:(id)sender
{
    BaseView *Basedata = [[BaseView alloc]initWithNibName:@"BaseView" bundle:nil];
    Basedata.comefrompage = @"new";
    [self.navigationController pushViewController:Basedata animated:YES];
}

-(void)LoadAllData
{
    [listOfContact removeAllObjects];
    
    [self databaseOpen];
    
    FMResultSet *resultsdata;
    
    NSString *StrQuery = [NSString stringWithFormat:@"select * from ContactList"];
    NSLog(@"StrQuery:%@",StrQuery);
    
    resultsdata = [databasecheckfmdb executeQuery:StrQuery];
    
    while([resultsdata next]) {
       [listOfContact addObject:[resultsdata resultDictionary]];
    }
    
    [databasecheckfmdb close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // Return the number of rows in the section
        return [listOfContact count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    ListofItemCell *cell = (ListofItemCell *)[tblData dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListofItemCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblContactName.text = [[listOfContact objectAtIndex:indexPath.row]valueForKey:@"Name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseView *Basedata = [[BaseView alloc]initWithNibName:@"BaseView" bundle:nil];
    Basedata.comefrompage = @"edit";
    Basedata.listofdata = [listOfContact objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:Basedata animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
