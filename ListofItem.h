//
//  ListofItem.h
//  TestDemo
//
//  Created by Ankit's Mac on 22/11/15.
//  Copyright (c) 2015 Ankit's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListofItemCell.h"
#import "FMDatabase.h"

@interface ListofItem : UIViewController
{
    NSMutableArray *listOfContact;
    FMDatabase *databasecheckfmdb;
}

@property (weak, nonatomic) IBOutlet UITableView *tblData;
@end
