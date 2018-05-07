//数据和控件都可以懒加载;strong:防止消失，

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *zjpTextF;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIToolbar *toobar;

@end

@implementation ViewController
//懒加载
-(UIDatePicker*)datePicker{
    if(!_datePicker){
        //不需要设置frame 自动占据键盘位置
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker. datePickerMode =  UIDatePickerModeDate;
        _datePicker.locale =  [[NSLocale alloc ]initWithLocaleIdentifier:@"zh-Hans"];//本地化
        
    }
    return _datePicker;
}
-(UIToolbar*)toobar{
    if(!_toobar){
        //Frame可以不设置 但是一定要告诉高度
        _toobar =[[UIToolbar alloc]init];
            _toobar.bounds= CGRectMake(0,0,0,44);
   //创建按钮放到工具条里
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(calcel:)];
    //弹簧center
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
     //加载
        _toobar.items= @[cancelItem,flexItem,doneItem];
        
    }
    return _toobar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置文本框的输入界面为datePicker
    self.zjpTextF.inputView = self.datePicker;
    //设置工具条
    self.zjpTextF.inputAccessoryView = self.toobar;
}


-(void)calcel:(UIBarButtonItem*)cancel{
    [self.view endEditing:YES];
}
-(void)done{
    //1获取选择的日期
   NSDate *date =  _datePicker.date;
    
   //
    //2将日期设置为文本框
    //2.1日期转字符串

    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    f.dateFormat = @"yyyy年MM月dd日 HH:mm:ss"; //HH:mm:ss时分秒
    NSString *str  =[f stringFromDate:date];\
    self.zjpTextF.text = str;
    //3关闭键盘
    [self.view endEditing:YES];
}


@end
