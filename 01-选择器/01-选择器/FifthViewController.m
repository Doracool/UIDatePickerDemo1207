//
//  FifthViewController.m
//  01-选择器
//
//  Created by qingyun on 15/12/7.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "FifthViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface FifthViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *label;
//困难级别
@property (nonatomic) NSInteger hardLevel;
//图片
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickView.dataSource = self;
    _pickView.delegate = self;
    
    //让他进来的时候在第二个里边
    _segmentedControl.selectedSegmentIndex = 1;
    //级别难度
    _hardLevel = 3;
    //图片
    _images = @[@"apple",@"bar",@"cherry",@"crown",@"lemon",@"seven"];
    //点击事件
    [self start:nil];
    // Do any additional setup after loading the view.
}

//开始游戏
- (IBAction)start:(UIButton *)sender {
    _label.text = @"";
    //声明连续的个数
    int sameRowNum = 0;
    int compareRow = 100;
    BOOL isWin = NO;
    
    for (int i = 0; i < 5 ; i++) {
        //创建随机数
        int ramNum = round(arc4random()% _images.count);
        if (i == 0) {//为samRowNum、compareRow赋初值
            sameRowNum = 1;
            compareRow = ramNum;
        }else{
            if (compareRow == ramNum) {
                sameRowNum++;
            }else{
                sameRowNum = 1;
            }
            compareRow = ramNum;
        }
        //更改选中的行
        [_pickView selectRow:ramNum inComponent:i animated:YES];
        
        if (sameRowNum >= _hardLevel) {
            isWin = YES;
        }
    }
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
//    [self play:path];
    if (isWin) {
        _label.text = @"你赢了,然而并没有奖励，哈哈哈......";
//        NSString *winPath = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
//        [self play:winPath];
    }
    
}

-(void)play:(NSString *)soundPath{
#if 0
    NSURL *url = [NSURL URLWithString:soundPath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
#else
    _player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:soundPath] error:nil];
#endif
    _player.delegate = self;
    [_player prepareToPlay];
    [_player play];
}
- (IBAction)segmentContolValueChang:(UISegmentedControl *)sender {
    _hardLevel = sender.selectedSegmentIndex + 2;
}

#pragma mark -UIPickViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _images.count;
}

#pragma mark -UIPickViewDelegate每行显示图片
//设置每行显示图片
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_images[row]]];
    return imageView;
}

//设置行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
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
