//了解政策

import UIKit

var policyNewsView:UITableView!               //政策新闻内容

class PolicyVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
  //－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
    //成员变量
    private var navView:UIView?                                                                //导航栏
    private var tabView:UIView?                                                              //tababr
    
    //tabbar五个按钮
    private var btnHome  :UIButton!                                                            //首页按钮
    private var btnPolicy:UIButton!                                                            //了解政策按钮
    private var btnHelp  :UIButton!                                                            //需要帮助按钮
    private var btnTrade:UIButton!                                                             //我要买卖按钮
    private var btnSelf  :UIButton!                                                            //个人中心按钮
//-------------------------------------------------------------------------------------------------
    
    override func viewDidLoad()
    {
//        initNavView();     //初始化导航栏
//        initTabBar();      //初始化tabbar
        initPolicyNews();  //初始化政策新闻内容
    }
    
    func initNavView()
    {
        navView = UIView(frame: CGRectMake(0,0,sWidth,sHeight*0.1))
        navView!.backgroundColor = themeColor;
        
        self.view.addSubview(navView!);
    }
    
    //初始化tabbar
    func initTabBar()
    {
        tabView = UIView(frame: CGRectMake(0,sHeight*0.923,sWidth,sHeight*0.076));
        tabView!.backgroundColor = tabColor;
        
        //首页按钮
        btnHome=UIButton(frame: CGRectMake(0,0,sWidth*0.2,sHeight*0.076))
        btnHome.addTarget(self, action: Selector("btnHomeTapped:"), forControlEvents: .TouchUpInside)
        btnHome.setImage(UIImage(named: "logo_01"),forState: .Normal)
        tabView?.addSubview(btnHome)
        
        //了解政策按钮
        btnPolicy=UIButton(frame: CGRectMake(sWidth*0.2,0,sWidth*0.2,sHeight*0.076))
        btnPolicy.addTarget(self, action: Selector("btnPolicyTapped:"), forControlEvents: .TouchUpInside)
        btnPolicy.setImage(UIImage(named: "logo_02"),forState: .Normal)
        tabView?.addSubview(btnPolicy)
        
        //需要帮助按钮
        btnHelp=UIButton(frame: CGRectMake(sWidth*0.4,0,sWidth*0.2,sHeight*0.076))
        btnHelp.addTarget(self, action: Selector("btnHelpTapped:"), forControlEvents: .TouchUpInside)
        btnHelp.setImage(UIImage(named: "logo_03"),forState: .Normal)
        tabView?.addSubview(btnHelp)
        
        //我要买卖按钮
        btnTrade=UIButton(frame: CGRectMake(sWidth*0.6,0,sWidth*0.2,sHeight*0.076))
        btnTrade.addTarget(self, action: Selector("btnTradeTapped:"), forControlEvents: .TouchUpInside)
        btnTrade.setImage(UIImage(named: "logo_04"),forState: .Normal)
        tabView?.addSubview(btnTrade)
        
        
        //个人中心按钮
        btnSelf=UIButton(frame:CGRectMake(sWidth*0.8,0,sWidth*0.2,sHeight*0.076))
        btnSelf.addTarget(self, action: Selector("btnSelfTapped:"), forControlEvents: .TouchUpInside)
        btnSelf.setImage(UIImage(named: "logo_05"),forState: .Normal)
        tabView?.addSubview(btnSelf)
        
        
        self.view.addSubview(tabView!)
        
    }
    
    //初始化政策新闻内容
    func initPolicyNews()
    {
        policyNewsView=UITableView(frame:CGRectMake(0,0,sWidth,sHeight*0.924),style:UITableViewStyle.Plain)
        policyNewsView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        policyNewsView.dataSource = self
        policyNewsView.delegate   = self
        
        self.view.addSubview(policyNewsView);
    }
    
    //政策新闻tableview，数据加载
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var row=indexPath.row as Int
        
        //图片
        let imageView:UIImageView=UIImageView(frame: CGRectMake(sWidth*0.05,sHeight*0.02,sWidth*0.3,sHeight*0.12));
        let image:UIImage=UIImage(named: "news_pic")!;
        imageView.image=image;
        
        //标题
        let titleLabel:UILabel=UILabel(frame: CGRectMake(sWidth*0.38,sHeight*0.03,sWidth*0.6,sHeight*0.05));
        titleLabel.text="全区粮食生产合作社横县飘香水稻种植专业合作社";
        titleLabel.numberOfLines=0;
        titleLabel.lineBreakMode = .ByWordWrapping;
        
        
        //内容概要
        let sumLabel:UILabel=UILabel(frame: CGRectMake(sWidth*0.37,sHeight*0.055,sWidth*0.6,sHeight*0.08));
        sumLabel.text="       深秋时节，走进横县飘香水稻种植专业合作社";
        sumLabel.font=UIFont(name: "HelveticaNeue", size: 12);
        sumLabel.numberOfLines=0;
        sumLabel.lineBreakMode = .ByWordWrapping
        sumLabel.textColor = contentColor;
        
        //发送日期
        
        let dataLabel:UILabel=UILabel(frame:CGRectMake(sWidth*0.37,sHeight*0.12,sWidth*0.15,sHeight*0.02));
        dataLabel.text="2015-10-28"
        dataLabel.font=UIFont(name: "HelveticaNeue", size: 10)
        dataLabel.textColor=contentColor
        
        //点击量图标
        
        let eyeView:UIImageView=UIImageView(frame: CGRectMake(sWidth*0.8, sHeight*0.12, sWidth*0.05, sHeight*0.02));
        let eyeImage:UIImage=UIImage(named: "eye")!
        eyeView.image=eyeImage;
        
        //点击量数字
        let numView:UILabel=UILabel(frame:CGRectMake(sWidth*0.86, sHeight*0.12, sWidth*0.08, sHeight*0.02))
        numView.text="1000"
        numView.font=UIFont(name: "HelveticaNeue", size: 10)
        numView.textColor=contentColor
        
        
        
        
        cell.addSubview(imageView)
        cell.addSubview(titleLabel)
        cell.addSubview(sumLabel)
        cell.addSubview(dataLabel)
        cell.addSubview(eyeView)
        cell.addSubview(numView)
        
        
        return cell;

    }
    
    //新闻条数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return sHeight*0.169
    }
    
    //--------------------------------------------------------------------------
    
    func btnHomeTapped(button:UIButton)
    {
        let homeVC:HomeVC = HomeVC();
        
        self.presentViewController(homeVC, animated: true, completion: nil)
    }
    
    func btnPolicyTapped (button:UIButton)
    {
        print("222")
    }
    
    func btnHelpTapped(button:UIButton)
    {
        print("333")
    }
    
    func btnTradeTapped(button:UIButton)
    {
        print("444")
    }
    
    func btnSelfTapped(button:UIButton)
    {
        print("555")
    }



}

