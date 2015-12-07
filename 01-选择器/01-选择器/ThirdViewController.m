//
//  ThirdViewController.m
//  01-选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIView *showView;

//存储每列中险种的行代表的rgb值
@property (nonatomic) CGFloat redColorNum;
@property (nonatomic) CGFloat greenColorNum;
@property (nonatomic) CGFloat blueColorNum;

@end

@implementation ThirdViewController
#define QYRGBMax 255   //rgb取值
#define QYStepValue 5  //间隔
#define QYComponents 3  //列数
#define QYRowNum QYRGBMax/QYStepValue + 1 //行数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger selectedRedrow = round(arc4random()%52);
    [self selectPicker:_pickView forRow:selectedRedrow inComponent:QYRGBComponentTypeRed];
    
    NSInteger selectedGreenRow = round(arc4random()%52);
    [self selectPicker:_pickView forRow:selectedGreenRow inComponent:QYRGBComponentTypeGreen];
    
    NSInteger seletedBlueRow = round(arc4random()%52);
    [self selectPicker:_pickView forRow:seletedBlueRow inComponent:QYRGBComponentTypeBlue];
    // Do any additional setup after loading the view.
}

//重写的方法设置
-(void)selectPicker:(UIPickerView *)pickerView forRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [pickerView selectRow:row inComponent:component animated:YES];
    [self pickerView:pickerView didSelectRow:row inComponent:component];
}

//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return QYComponents;
}

//行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return QYRowNum;
}

#pragma mark -UIPickerViewDelegate

//属性文本
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CGFloat redNum = 0;
    CGFloat greenNum = 0;
    CGFloat blueNum = 0;
    
    NSInteger currentNum = row * QYStepValue;
    //随机设置rgb值确定颜色
    switch (component) {
        case QYRGBComponentTypeRed:
            redNum = currentNum;
            break;
        case QYRGBComponentTypeGreen:
            greenNum = currentNum;
            break;
        case QYRGBComponentTypeBlue:
            blueNum = currentNum;
            break;
        default:
            break;
    }
    NSAttributedString *attibutedString = [[NSAttributedString alloc] initWithString:[@(currentNum) stringValue] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1.0]}];
    return attibutedString;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    CGFloat value = row * QYStepValue / 255.0;
    
    switch (component) {
        case QYRGBComponentTypeRed:
            _redColorNum = value;
            break;
        case QYRGBComponentTypeGreen:
            _greenColorNum = value;
            break;
        case QYRGBComponentTypeBlue:
            _blueColorNum = value;
            break;
            
        default:
            break;
    }
    _showView.backgroundColor = [UIColor colorWithRed:_redColorNum green:_greenColorNum blue:_blueColorNum alpha:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
