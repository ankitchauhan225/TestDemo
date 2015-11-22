//
//  BaseView.h
//  TestDemo
//
//  Created by Ankit's Mac on 22/11/15.
//  Copyright (c) 2015 Ankit's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface BaseView : UIViewController
{
    FMDatabase *databasecheckfmdb;
}

@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtLastName;
@property (retain, nonatomic) IBOutlet UITextField *txtPhoneNo;
@property (retain, nonatomic) IBOutlet UITextField *txtDate;


- (IBAction)BtnSavePress:(id)sender;

@end
