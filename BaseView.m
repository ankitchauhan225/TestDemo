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
@synthesize comefrompage,listofdata,btnSave;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"listofdata:%@",listofdata);
    
    if ([comefrompage isEqualToString:@"edit"]) {
        txtDate.text = [listofdata valueForKey:@"Date"];
        txtName.text = [listofdata valueForKey:@"Name"];
        txtLastName.text = [listofdata valueForKey:@"LastName"];
        txtPhoneNo.text = [listofdata valueForKey:@"PhoneNo"];
        idlist = [listofdata valueForKey:@"id"];
        [btnSave setTitle: @"UPDATE" forState: UIControlStateNormal];
    }
    else
    {
        [btnSave setTitle: @"SAVE" forState: UIControlStateNormal];
    }
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height -200,10, 500)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.date=[NSDate date];
    [datePicker addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventValueChanged];
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAllKeyboards)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)hideAllKeyboards {
    NSLog(@"hideAllKeyboards");
    [txtName resignFirstResponder];
    [txtDate resignFirstResponder];
    [txtLastName resignFirstResponder];
    datePicker.hidden = YES;
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
    
    if ([comefrompage isEqualToString:@"edit"]) {
        
     // update studentsDetail SET name='%@', department='%@', year='%@' where regno='%@'",@"name",@"dept",@"year",@"regno"
       
        NSString *InsertQuery = [NSString stringWithFormat:@"UPDATE ContactList SET Name = '%@', LastName = '%@', PhoneNo = '%@',Date= '%@' where id = %@",txtName.text,txtLastName.text,txtPhoneNo.text,txtDate.text,idlist];
        
        BOOL Checkval = [databasecheckfmdb executeUpdate:InsertQuery];
        
        if (Checkval == YES) {
            UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Data updated sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Alertdata show];
        }
        
        [databasecheckfmdb close];
    }
    else
    {
        NSString *InsertQuery = [NSString stringWithFormat:@"INSERT INTO ContactList (Name,LastName,PhoneNo,Date) VALUES ('%@','%@','%@','%@')",txtName.text,txtLastName.text,txtPhoneNo.text,txtDate.text];
        
        BOOL Checkval = [databasecheckfmdb executeUpdate:InsertQuery];
        
        if (Checkval == YES) {
            UIAlertView *Alertdata = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Data saved sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [Alertdata show];
        }
        
        [databasecheckfmdb close];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BtnDatePicker:(id)sender {
    [txtName resignFirstResponder];
    [txtDate resignFirstResponder];
    [txtLastName resignFirstResponder];
    
    datePicker.hidden=NO;
}

-(void)LabelTitle:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    //assign text to label
    txtDate.text=str;
}

@end
