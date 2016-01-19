
//首页


import UIKit


public let sHeight = UIScreen.mainScreen().bounds.height;                               //屏幕高
public let sWidth  = UIScreen.mainScreen().bounds.width;                                //屏幕宽
public let themeColor = UIColor(red: 35/255, green: 176/255, blue: 74/255, alpha: 1.0); //主题色
public let tabColor   = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0); //tabbar颜色
public let contentColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0);//公司简介字体颜色
public let textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0); //字体颜色1



class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    private var navView:UIView?                                                              //导航栏
    private var tabView:UIView?                                                              //tababr
    private var scrollView:UIImageView?                                                      //图片轮播
    private var switchView:UIView?                                                           //二级页面切换条
    private var jymsView:UIScrollView!                                                       //嘉言民生主页面
    private var gzsnView:UIScrollView!                                                       //关注三农页面
    
    
    private var subTitleView:UIView!                                                         //二级页面标题
    
    private var companyDetailView:UIView!                                                    //公司概况版面
    private var newsView:UIView!                                                             //最新动态版面
    
    
    private var subBtnIndex:Int=0                                                            //二级页面激活按钮序号，0为嘉言民生，1为关注三农
    
    private var btnJYMS:UIButton?                                                            //嘉言民生按钮
    private var btnGZSN:UIButton?                                                            //关注三农按钮
    
    //tabbar五个按钮
    private var btnHome  :UIButton!                                                            //首页按钮
    private var btnPolicy:UIButton!                                                            //了解政策按钮
    private var btnHelp  :UIButton!                                                            //需要帮助按钮
    private var btnTrade:UIButton!                                                            //我要买卖按钮
    private var btnSelf  :UIButton!                                                            //个人中心按钮

    
    
    override func viewDidLoad()
    {
        
        //initNavView();     //初始化导航栏
        //initTabBar();      //初始化tabbar
        initScrollBar();   //初始化图片轮播页面
        initSwitchView();  //初始化二级页面切换按钮
        
        initJYMSView();    //嘉言民生初始化主页面
        initSubTitle();   //嘉言民生初始化二级页面标题
        initCompanyDetailView();//嘉言民生初始化公司概况页面
        initNews();
        
        
        initGZSNView()    //关注三农初始化主页面
        initGZSNNews()    //关注三农初始化最新动态子页面
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    
    }
    
    //初始化导航栏
    func initNavView()
    {
        navView = UIView(frame: CGRectMake(0,0,sWidth,sHeight*0.1))
        navView!.backgroundColor = themeColor;
        
         self.view.addSubview(navView!);
    }
    
    //初始化tabbar
    func initTabBar()
    {
        tabView = UIView(frame: CGRectMake(0,sHeight*0.923,sWidth,sHeight*0.077));
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
    
    //初始化滚动条
    func initScrollBar()
    {
        scrollView = UIImageView(frame: CGRectMake(0,0,sWidth,sHeight*0.23));
        let image:UIImage = UIImage(named: "scroller.png")!;
        scrollView?.image=image;
        
        self.view.addSubview(scrollView!);
        
    }
    
    //初始化二级页面切换按钮
    func initSwitchView()
    {
        switchView = UIView(frame: CGRectMake(0,sHeight*0.23,sWidth,sHeight*0.07));
        btnJYMS = UIButton(frame: CGRectMake(0,0,sWidth * 0.5,sHeight*0.07));          //嘉言民生按钮
        btnGZSN = UIButton(frame: CGRectMake(sWidth*0.5,0,sWidth*0.5,sHeight*0.07));   //关注三农按钮
        
        btnJYMS?.layer.borderColor=UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).CGColor;
        btnJYMS?.layer.borderWidth=0.5;
        btnGZSN?.layer.borderColor=UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).CGColor;
        btnGZSN?.layer.borderWidth=0.5;
        btnJYMS!.setImage(UIImage(named: "jyms_s"), forState: .Normal);               //嘉言民生初始化为选中，关注三农初始化为未选中
        btnJYMS!.setImage(UIImage(named: "jyms_s"),forState: .Highlighted);
        btnGZSN!.setImage(UIImage(named: "gzsn_ns"), forState: .Normal);
        btnGZSN!.setImage(UIImage(named: "gzsn_ns"), forState: .Highlighted);
        
        
        //设置二级页面切换按钮点击事件
        
        btnJYMS!.addTarget(self, action: Selector("jymsBtnTapped:"), forControlEvents: .TouchUpInside);
        btnGZSN!.addTarget(self, action: Selector("gzsnBtnTapped:"), forControlEvents: .TouchUpInside);
  
        
        switchView?.addSubview(btnJYMS!);
        switchView?.addSubview(btnGZSN!);
        
        self.view.addSubview(switchView!);
        
        
    }
    
    
    //初始化滚动主页面
    func initJYMSView()
    {
        jymsView=UIScrollView(frame:CGRectMake(0,sHeight*0.31,sWidth,sHeight*0.514))
        jymsView.scrollEnabled=true;
        jymsView.showsHorizontalScrollIndicator=true;
        jymsView.contentSize=CGSizeMake(sWidth, sHeight*1.2)
        
        self.view.addSubview(jymsView)
        
    }
    
    
    
    //初始化二级页面标题
    func initSubTitle()
    {
        subTitleView = UIView(frame: CGRectMake(0,0,sWidth,sHeight*0.025));
        subTitleView.backgroundColor = tabColor;
        let subTitle:UILabel = UILabel(frame:  CGRectMake(sWidth*0.05,sHeight*0.001,sWidth*0.135,sHeight*0.02));
        
        subTitle.text="公司概况";
        subTitle.adjustsFontSizeToFitWidth=true;
        
        
        subTitleView.addSubview(subTitle);
        
        jymsView.addSubview(subTitleView);
    }
    
    //公司概况页面
    func initCompanyDetailView()
    {
        companyDetailView = UIView(frame: CGRectMake(0,sHeight*0.025,sWidth,sHeight*0.32));
       
        //公司简介
        let companyInfoView:UIButton=UIButton(frame: CGRectMake(0,0,sWidth*0.5,sHeight*0.32));
        companyInfoView.addTarget(self, action: Selector("CompanyInfoBtnTapped:"), forControlEvents: .TouchUpInside)
        
        companyInfoView.backgroundColor=UIColor.whiteColor();
        
        //公司简介标题
        let companyInfoTitle:UILabel=UILabel(frame: CGRectMake(sWidth*0.05,0,sWidth*0.4,sHeight*0.06) );
        companyInfoTitle.text="嘉言民生事务服务有限公司";
        companyInfoTitle.adjustsFontSizeToFitWidth=true;
        
        //公司简介内容
        
        let companyInfoContent:UILabel=UILabel(frame: CGRectMake(sWidth*0.03,sHeight*0.06,sWidth*0.45,sHeight*0.25) );
        companyInfoContent.text="　遂昌嘉言民生事务服务有限公司（以下简称“嘉言民生”）县便民服务中心运营总部于2012年成立，2014年由北京东方财星国际资本管理有限公司进一步投资，现有员工196人，系农业部“信息进村入户”试点县项目承担单位。嘉言民生作为第三方机构，与现有县、乡镇、村级便民服务中心相融合，形成农村公共服务的网络体系，采取“政企社共建村级便民服务中心”项目运营模式，提供一站式服务，以专人、专业方式处理日常民生事务。村级便民服务中心是党群、干群、企群之间的连心桥，是方便百姓、服务百姓的民心工程，是转变政府职能、提高行政效率的示范工程，是招商引资、对外开放的窗口工程和遏制腐败、树立形象的阳光工程。";
        companyInfoContent.lineBreakMode = .ByWordWrapping;
        companyInfoContent.numberOfLines=0;
        companyInfoContent.font=UIFont(name: "HelveticaNeue", size: 13);
        companyInfoContent.textColor=contentColor;
        
        companyInfoView.addSubview(companyInfoTitle);
        companyInfoView.addSubview(companyInfoContent);
        
        
        //发展历程，合作伙伴，领导关怀,资质荣誉按钮
        let companyButtonView:UIView=UIView(frame: CGRectMake(sWidth*0.5,0,sWidth*0.5,sHeight*0.32));
        
        let developmentBtn:UIButton=UIButton(frame: CGRectMake(0,0,sWidth*0.5,sHeight*0.08));
        developmentBtn.setImage(UIImage(named: "development"), forState: .Normal);
        developmentBtn.addTarget(self, action: Selector("btnDevTapped:"), forControlEvents: .TouchUpInside)
        
        let partnerBtn:UIButton=UIButton(frame: CGRectMake(0,sHeight*0.08,sWidth*0.5,sHeight*0.08));
        partnerBtn.setImage(UIImage(named: "partner"), forState: .Normal);
        partnerBtn.addTarget(self, action: Selector("btnPartnerTapped:"), forControlEvents: .TouchUpInside)
        
        let loveBtn:UIButton=UIButton(frame: CGRectMake(0,sHeight*0.16,sWidth*0.5,sHeight*0.08));
        loveBtn.setImage(UIImage(named: "love"), forState: .Normal);
        loveBtn.addTarget(self, action: Selector("btnLoveTapped:"), forControlEvents:.TouchUpInside)
        
        let reputationBtn:UIButton=UIButton(frame: CGRectMake(0,sHeight*0.24,sWidth*0.5,sHeight*0.08));
        reputationBtn.setImage(UIImage(named: "reputation"), forState:.Normal);
        reputationBtn.addTarget(self, action: Selector("btnRepTapped:"), forControlEvents: .TouchUpInside)
        
        companyButtonView.addSubview(developmentBtn);
        companyButtonView.addSubview(partnerBtn);
        companyButtonView.addSubview(loveBtn);
        companyButtonView.addSubview(reputationBtn);
        
        
        companyDetailView.addSubview(companyInfoView);
        companyDetailView.addSubview(companyButtonView);
        
        jymsView.addSubview(companyDetailView);
    }
    
    
    //最新动态板块
    func initNews()
    {
        //公司动态标题
        subTitleView = UIView(frame: CGRectMake(0,sHeight*0.345,sWidth,sHeight*0.025));
        subTitleView.backgroundColor = tabColor;
        let subTitle:UILabel = UILabel(frame:  CGRectMake(sWidth*0.05,sHeight*0.001,sWidth*0.135,sHeight*0.02));
        
        subTitle.text="最新动态";
        subTitle.adjustsFontSizeToFitWidth=true;
        
        CGRectMake(sWidth*0.05,sHeight*0.001,sWidth*0.135,sHeight*0.02)
        subTitleView.addSubview(subTitle)
        jymsView.addSubview(subTitleView)
        
        //公司动态内容
        let contentView:UITableView = UITableView(frame:CGRectMake(0,sHeight*0.37,sWidth,sHeight*0.845),style:UITableViewStyle.Plain)
        contentView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.dataSource = self
        contentView.delegate   = self
        
        jymsView.addSubview(contentView)
    }
//--------------------------------------------------------------------------------------------------
    //嘉言民生按钮点击触发
    func jymsBtnTapped(button:UIButton)
    {
        if(subBtnIndex==1)
        {
            btnJYMS!.setImage(UIImage(named: "jyms_s"), forState: .Normal);
            btnJYMS!.setImage(UIImage(named: "jyms_s"),forState: .Highlighted);
            btnGZSN!.setImage(UIImage(named: "gzsn_ns"), forState: .Normal);
            btnGZSN!.setImage(UIImage(named: "gzsn_ns"), forState: .Highlighted);
            
            removeGZMSFromView() //移除关注三农页面内容
            addJYMSFromView() //添加嘉言民生页面内容
            
            subBtnIndex=0
        }
    }
    
    
    //关注三农按钮点击触发
    func gzsnBtnTapped(button:UIButton)
    {
        if(subBtnIndex==0)
        {
            btnJYMS!.setImage(UIImage(named: "jyms_ns"), forState: .Normal);
            btnJYMS!.setImage(UIImage(named: "jyms_ns"),forState: .Highlighted);
            btnGZSN!.setImage(UIImage(named: "gzsn_s"), forState: .Normal);
            btnGZSN!.setImage(UIImage(named: "gzsn_s"), forState: .Highlighted);
            
            removeJYMSFromView()//移除嘉言民生页面内容
            addGZMSFromView() //添加关注三农页面内容
            
             subBtnIndex=1
        }
    }
    
    //--------------------------------------------------------------------------
    
    func btnHomeTapped(button:UIButton)
    {
        print("111")
    }
    
    func btnPolicyTapped (button:UIButton)
    {
        //跳至政策页面
//        let policyVC:PolicyVC = PolicyVC();
        
//        self.presentViewController(policyVC, animated: true, completion: nil)
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
//---------------------------------------------------------------------------------
    func CompanyInfoBtnTapped(button:UIButton)
    {
        //跳入公司信息页面
        let companyInfoVC:CompanyInfoVC=CompanyInfoVC();
        companyInfoVC.switchIndex=0
        self.presentViewController(companyInfoVC, animated: true, completion: nil);
    }
    
    func btnDevTapped(button:UIButton)
    {
        //跳入发展历程页面
        
        let companyInfoVC:CompanyInfoVC=CompanyInfoVC()
        companyInfoVC.switchIndex=1
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.pushViewController(companyInfoVC, animated: true)
        //self.presentViewController(companyInfoVC, animated: true, completion: nil)
    }
    
    func btnPartnerTapped(button:UIButton)
    {
        //跳入合作伙伴页面
        let companyInfoVC:CompanyInfoVC=CompanyInfoVC()
        companyInfoVC.switchIndex=2
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.pushViewController(companyInfoVC, animated: true)
        //self.presentViewController(companyInfoVC, animated: true, completion: nil)
    }
    
    func btnLoveTapped(button:UIButton)
    {
        let companyInfoVC:CompanyInfoVC=CompanyInfoVC()
        companyInfoVC.switchIndex=3
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.pushViewController(companyInfoVC, animated: true)
        //self.presentViewController(companyInfoVC, animated: true, completion: nil)
    }
    
    func btnRepTapped(button:UIButton)
    {
        let companyInfoVC:CompanyInfoVC=CompanyInfoVC()
        companyInfoVC.switchIndex=4
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
         self.navigationController?.pushViewController(companyInfoVC, animated: true)
        //self.presentViewController(companyInfoVC, animated: true, completion: nil)
        
    }
    
//---------------------------------------------------------------------------------
    
    //主页面tableview
    //总行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    //加载数据
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
        
        //点击量图标
        
        let eyeView:UIImageView=UIImageView(frame: CGRectMake(sWidth*0.8, sHeight*0.12, sWidth*0.05, sHeight*0.02));
        let eyeImage:UIImage=UIImage(named: "eye")!
        eyeView.image=eyeImage;
        
        //点击量数字
        let numView:UILabel=UILabel(frame:CGRectMake(sWidth*0.86, sHeight*0.12, sWidth*0.08, sHeight*0.02))
        numView.text="1000"
        numView.font=UIFont(name: "HelveticaNeue", size: 10)


        
        
        
        cell.addSubview(imageView);
        cell.addSubview(titleLabel);
        cell.addSubview(sumLabel)
        cell.addSubview(eyeView)
        cell.addSubview(numView)
        
        
        return cell;
    }
    
    
    //行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return sHeight*0.169
    }
    
    /*
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    {
        return nil;
    }

    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let newsVC:NewsVC = NewsVC()
        self.presentViewController(newsVC, animated: true, completion: nil)
        
        
    }
//--------------------------------------------------------------------------
    //关注三农页面
    
    func initGZSNView()
    {
        gzsnView=UIScrollView(frame:CGRectMake(0,sHeight*0.41,sWidth,sHeight*0.514))
        gzsnView.scrollEnabled=true;
        gzsnView.showsHorizontalScrollIndicator=true;
        gzsnView.contentSize=CGSizeMake(sWidth, sHeight*0.845)
        
    }
    
    func initGZSNNews()
    {
        subTitleView = UIView(frame: CGRectMake(0,0,sWidth,sHeight*0.025));
        subTitleView.backgroundColor = tabColor;
        let subTitle:UILabel = UILabel(frame:  CGRectMake(sWidth*0.05,sHeight*0.001,sWidth*0.135,sHeight*0.02));
        
        subTitle.text="最新动态";
        subTitle.adjustsFontSizeToFitWidth=true;
        
        
        subTitleView.addSubview(subTitle);

        
        gzsnView.addSubview(subTitleView);
        
        //公司动态内容
        let contentView:UITableView = UITableView(frame:CGRectMake(0,sHeight*0.025,sWidth,sHeight*0.845),style:UITableViewStyle.Plain)
        contentView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        contentView.scrollEnabled=false;
        contentView.dataSource = self
        contentView.delegate   = self
        
        gzsnView.addSubview(contentView);
    }
    
    
    
    
//--------------------------------------------------------------------------
    //移除嘉言民生页面内容
    func removeJYMSFromView()
    {
        jymsView.removeFromSuperview();
    }
    
    //添加嘉言民生页面内容
    
    func addJYMSFromView()
    {
        self.view.addSubview(jymsView)
    }
    
    //移除关注关注三农页面内容内容
    func removeGZMSFromView()
    {
        gzsnView.removeFromSuperview();
    }
    
    //添加关注关注三农页面内容
    func addGZMSFromView()
    {
        self.view.addSubview(gzsnView);
    }


}

