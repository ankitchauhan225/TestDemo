//
//  BaseView.h
//  TestDemo
//
//  Created by Ankit's Mac on 22/11/15.
//  Copyright (c) 2015 Ankit's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface BaseView : UIViewController<UIAlertViewDelegate>
{
    FMDatabase *databasecheckfmdb;
    UIDatePicker *datePicker;
    NSString *idlist;
}

@property (retain, nonatomic) IBOutlet UITextField *txtName;
@property (retain, nonatomic) IBOutlet UITextField *txtLastName;
@property (retain, nonatomic) IBOutlet UITextField *txtPhoneNo;
@property (retain, nonatomic) IBOutlet UITextField *txtDate;
@property (retain, nonatomic) NSString *comefrompage;
@property (retain, nonatomic) NSMutableArray *listofdata;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)BtnSavePress:(id)sender;
- (IBAction)BtnDatePicker:(id)sender;


@end
