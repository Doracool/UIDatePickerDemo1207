//
//  SecondViewController.m
//  01-选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) NSArray *datas;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置pickView的数据源和代理
    _pickView.dataSource = self;
    _pickView.delegate = self;
    
    //设置数据
    _datas = [[NSArray alloc] initWithObjects:@"Luke", @"Leia", @"Han", @"Chewbacca", @"Artoo", @"Threepio", @"Lando", nil];
    
    //设置默认文本
    _label.text = _datas.firstObject;
    // Do any additional setup after loading the view.
}


#pragma mark -UIPickViewDataSource
//设置列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//设置每列中的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datas.count;
}

#pragma mark -UIPickViewDelegate
//设置文本
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _datas[row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置属性文本
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]}];
        
        return attributedString;
    }
    return nil;
}


//设置行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

//选中row
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_datas[row] attributes:@{NSUnderlineStyleAttributeName:@2,NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    _label.attributedText = attributedString;
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
