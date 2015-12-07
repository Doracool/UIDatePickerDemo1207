//
//  ViewController.m
//  01-选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置范文
    //设置最小时间
    //设置时间的组成部分
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    //设置日期

    //获取当前的日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *mindate = [calendar dateFromComponents:components];
    
    _datePicker.minimumDate = mindate;
    
    //最大日期
    NSDate *maxDate = [[NSDate alloc] initWithTimeIntervalSinceNow:10 * 24 * 60 *60 ];
    _datePicker.maximumDate = maxDate;
    
    //把时间转换为当前时区的时间
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    
//    NSInteger intral = [timeZone secondsFromGMTForDate:_datePicker.date];
//    
//    NSDate *localDate = [_datePicker.date dateByAddingTimeInterval:intral];
//    NSString *dateString = [_datePicker.date descriptionWithLocale:_datePicker.locale];
//    
//    
    //添加事件的监听
    [_datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)datePickerValueChange:(UIDatePicker *)datePicker{
    NSLog(@"%@",[datePicker.date descriptionWithLocale:datePicker.locale]);
}

//点击事件
- (IBAction)seleted:(UIButton *)sender {
    
    NSString *selected = [_datePicker.date descriptionWithLocale:_datePicker.locale];
    
    UIAlertController *alertVliew = [UIAlertController alertControllerWithTitle:@"你选择的时间是" message:selected preferredStyle:UIAlertControllerStyleAlert];
    
    //添加action
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    
    [alertVliew addAction:action];
    [self presentViewController:alertVliew animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
