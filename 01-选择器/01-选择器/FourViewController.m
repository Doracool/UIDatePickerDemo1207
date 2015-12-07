//
//  FourViewController.m
//  01-选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic, strong) NSDictionary *dict;

//左列数据
@property (nonatomic, strong) NSArray *leftDatas;

//右列数据
@property (nonatomic,strong) NSArray *rightDatas;

@end

@implementation FourViewController


//加载数据
-(void)loadDataFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //排列
    _leftDatas = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    //右视图
    _rightDatas = _dict[_leftDatas.firstObject];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromFile];
    // Do any additional setup after loading the view.
}


#pragma mark -UIPickViewDataSource
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _leftDatas.count;
    }
    //右列行数
    return _rightDatas.count;
}

//行内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _leftDatas[row];
    }
    return _rightDatas[row];
}

//选中行数在左列修改的时候更改右列的值
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//操作左列
        //更改右列数据
        NSString *key = _leftDatas[row];
        _rightDatas = _dict[key];
        
        //刷新右列
        [pickerView reloadComponent:1];
        //更改右列数据为0
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
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
