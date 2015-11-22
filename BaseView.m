//
//  BaseView.m
//  TestDemo
//
//  Created by Ankit's Mac on 22/11/15.
//  Copyright (c) 2015 Ankit's Mac. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

@synthesize txtDate,txtLastName,txtName,txtPhoneNo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) databaseOpen {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TestDB.sqlite"];
    databasecheckfmdb = [FMDatabase databaseWithPath:writableDBPath];
    
    [databasecheckfmdb open];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BtnSavePress:(id)sender {
    
    if ([txtName.text length]==0) {
        UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Name" message:@"Please enter valid name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alertdata show];
        return;
    }
    else if ([txtLastName.text length] ==0)
    {
        UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Last Name" message:@"Please enter valid Last name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alertdata show];
        return;
    }
    else if ([txtDate.text length] ==0)
    {
        UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Date" message:@"Please enter valid Date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alertdata show];
        return;
    }
    else if ([txtPhoneNo.text length] ==0)
    {
        UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Phone No" message:@"Please enter valid Phone no" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alertdata show];
        return;
    }
    
    [self databaseOpen];
    
    NSString *InsertQuery = [NSString stringWithFormat:@"INSERT INTO ContactList (Name,LastName,PhoneNo,Date) VALUES ('%@','%@','%@','%@')",txtName.text,txtLastName.text,txtPhoneNo.text,txtDate.text];
    
    BOOL Checkval = [databasecheckfmdb executeUpdate:InsertQuery];
    
    if (Checkval == YES) {
        UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Data saved sucessfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Alertdata show];
    }
    
    [databasecheckfmdb close];
}

@end
