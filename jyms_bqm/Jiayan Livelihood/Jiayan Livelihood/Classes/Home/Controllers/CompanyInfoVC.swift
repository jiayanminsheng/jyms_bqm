//
//  CompanyInfo.swift
//  JYMS
//
//  Created by Lance on 1/12/16.
//  Copyright © 2016 Lance. All rights reserved.
//

import UIKit



class CompanyInfoVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    public var switchIndex:Int=0            //当前页面切换条序数，0为公司简介，1为发展历程，2为合作伙伴，3为领导关怀，4为资质荣誉
    
    private var btnReturn:UIButton!          //返回按钮
    private var navView:UIView!              //导航栏
    private var switchView:UIView!           //切换条
    private var contentView:UIView!          //内容
    
    private var arrDevContent:[String]=["截至2015年7月，已有十余个县市与嘉言民生签署战略协议，并已进入紧锣密鼓的落地进程",
        "2015年5月嘉言民生成为农业部与商业部全国会议主推样板",
        "被纳入“2015年遂昌县10件民生实事”",
        "“全国美丽乡村标准化”试点承担单位",
        "“农业信息进村入户“试点承包单位"
        
    ]
    
    private var companyBtn:    UIButton!
    private var developmentBtn:UIButton!
    private var partnerBtn:UIButton!
    private var leaderBtn:UIButton!
    private var reputationBtn:UIButton!
    
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool)
        
    {
         self.edgesForExtendedLayout = .None;
        
        initNav()
        initSwitch()      //初始化切换条
        initContent()    //初始化内容
        
        
        
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        self.contentView.removeFromSuperview()
    }
    
    func initNav()
    {
        self.parentViewController?.rdv_tabBarController.tabBarHidden=true
        self.navigationItem.hidesBackButton=true;
        
        
        //添加返回按钮
        
        self.btnReturn = UIButton(frame:CGRectMake(sWidth*0.05,sHeight*0.01,sWidth*0.06,sHeight*0.04))
        btnReturn.setImage(UIImage(named: "return"), forState: .Normal)
        btnReturn.addTarget(self, action: Selector("btnReturnTapped:"), forControlEvents: .TouchUpInside)
        self.navigationController?.navigationBar.addSubview(btnReturn)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //初始化切换条
    func initSwitch()
    {
        switchView = UIView(frame:CGRectMake(0,0,sWidth,sHeight*0.043))
        switchView.backgroundColor=tabColor
        switchView.layer.borderWidth=0.5
        switchView.layer.borderColor=UIColor.lightGrayColor().CGColor
        
        //公司简介按钮
        companyBtn     = UIButton(frame:CGRectMake(sWidth*0.0,sHeight*0.01,sWidth*0.2,sHeight*0.025))
        companyBtn.setTitle     ("公司简介", forState:.Normal)
        companyBtn.setTitleColor(textColor, forState: .Normal)
        //公司按钮点击事件
        companyBtn.addTarget(self, action: Selector("companyBtnTapped:"), forControlEvents: .TouchUpInside)
        
        if(IS_IPHONE_4_OR_LESS)
        {
           companyBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 14.0)
        }
        else
        {
            companyBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 16.0)
        }
        
        developmentBtn = UIButton(frame:CGRectMake(sWidth*0.2,sHeight*0.01,sWidth*0.2,sHeight*0.025))
        developmentBtn.setTitle     ("发展历程", forState: .Normal)
        developmentBtn.setTitleColor(textColor, forState: .Normal)
        //发展按钮点击事件
        developmentBtn.addTarget(self, action: Selector("developmentBtnTapped:"), forControlEvents: .TouchUpInside)
        
        if(IS_IPHONE_4_OR_LESS)
        {
           developmentBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 14.0)
        }
        else
        {
             developmentBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 16.0)
        }
        
        
        partnerBtn     = UIButton(frame:CGRectMake(sWidth*0.4,sHeight*0.01,sWidth*0.2,sHeight*0.025))
        partnerBtn.setTitle     ("合作伙伴", forState: .Normal)
        partnerBtn.setTitleColor(textColor, forState: .Normal)
        partnerBtn.addTarget(self, action: Selector("partnerBtnTapped:"), forControlEvents: .TouchUpInside)
        if(IS_IPHONE_4_OR_LESS)
        {
          partnerBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 14.0)
        }
        else
        {
            partnerBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 16.0)
        }
        
        leaderBtn      = UIButton(frame:CGRectMake(sWidth*0.6,sHeight*0.01,sWidth*0.2,sHeight*0.025))
        leaderBtn.setTitle     ("领导关怀", forState: .Normal)
        leaderBtn.setTitleColor(textColor, forState: .Normal)
        leaderBtn.addTarget(self, action: Selector("leaderBtnTapped:"), forControlEvents: .TouchUpInside)
        
        if(IS_IPHONE_4_OR_LESS)
        {
            leaderBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 14.0)
        }
        else
        {
              leaderBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 16.0)
        }
        
        reputationBtn  = UIButton(frame:CGRectMake(sWidth*0.8,sHeight*0.01,sWidth*0.2,sHeight*0.025))
        reputationBtn.setTitle     ("资质荣誉", forState: .Normal)
        reputationBtn.setTitleColor(textColor, forState: .Normal)
        reputationBtn.addTarget(self, action: Selector("reputationBtnTapped:"), forControlEvents: .TouchUpInside)
        
        if(IS_IPHONE_4_OR_LESS)
        {
            reputationBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 14.0)
        }
        else
        {
            reputationBtn.titleLabel?.font=UIFont(name: "HelveticaNeue", size: 16.0)
        }

        
        switch switchIndex
        {
            
        case  0: companyBtn.setTitleColor( themeColor, forState: .Normal)
        case  1: developmentBtn.setTitleColor( themeColor, forState: .Normal)
        case  2: partnerBtn.setTitleColor( themeColor, forState: .Normal)
        case  3: leaderBtn.setTitleColor( themeColor, forState: .Normal)
        case  4: reputationBtn.setTitleColor( themeColor, forState: .Normal)
            
        default:print("error")
        }

        
        switchView.addSubview(companyBtn)
        switchView.addSubview(developmentBtn)
        switchView.addSubview(partnerBtn)
        switchView.addSubview(leaderBtn)
        switchView.addSubview(reputationBtn)
        
        self.view.addSubview(switchView)
    }
    
    //初始化内容
    func initContent()
    {
        //具体内容页面
        self.contentView = UIView(frame:CGRectMake(0,sHeight*0.043,sWidth,sHeight*0.957))
        self.contentView.backgroundColor=UIColor.whiteColor()
        self.view.bringSubviewToFront(self.contentView)
        //contentView.backgroundColor=UIColor.whiteColor()
        
        switch switchIndex
        {
        case  0: loadCompanyInfoView()
            
        case  1: loadDevView()
            
        case  2: loadPartnerView()
            
        case  3: loadLoveView()
            
        case  4: loadReputationView()
        default:print("error")
        }
        
        self.view.addSubview(contentView)
    }
    
    func btnReturnTapped(button:UIButton)
    {
        //返回主页面
        self.parentViewController?.rdv_tabBarController.tabBarHidden=false
        self.navigationController?.navigationBar.hidden=false
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        self.btnReturn.removeFromSuperview()
    }
    
    //--------------------------------------------------------------------------------------------------
    //发展历程页面tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as UITableViewCell
        let row=indexPath.row as Int
        
        cell.textLabel?.text=self.arrDevContent[row]
         if(IS_IPHONE_4_OR_LESS)
         {
           cell.textLabel?.font=UIFont(name: "HelveticaNeue", size: 14)
         }
         else
         {
            cell.textLabel?.font=UIFont(name: "HelveticaNeue", size: 16)
         }
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.textColor=contentColor;
        
        return cell;
        
    }
    
    //行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrDevContent.count
    }
    //--------------------------------------------------------------------------------------------------
    
    func loadCompanyInfoView()
    {
        //公司简介页面
        
        //公司简介页面标题
        let abstractTitle=UILabel(frame: CGRectMake(sWidth*0.05,sHeight*0.05,sWidth*0.9,sHeight*0.043))
        abstractTitle.text="嘉言民生事务服务有限公司"
         if(IS_IPHONE_4_OR_LESS)
         {
           abstractTitle.font=UIFont(name: "HelveticaNeue", size: 22.0)
         }
        else
         {
            abstractTitle.font=UIFont(name: "HelveticaNeue", size: 20.0)
         }
        abstractTitle.textAlignment = .Center//居中显示
        contentView.addSubview(abstractTitle)
        
        let abstarctContent=UILabel(frame:CGRectMake(sWidth*0.05,sHeight*0.07,sWidth*0.9,sHeight*0.48));
        abstarctContent.text="　    遂昌嘉言民生事务服务有限公司（以下简称“嘉言民生”）县便民服务中心运营总部于2012年成立，2014年由北京东方财星国际资本管理有限公司进一步投资，现有员工196人，系农业部“信息进村入户”试点县项目承担单位。\n　    嘉言民生作为第三方机构，与现有县、乡镇、村级便民服务中心相融合，形成农村公共服务的网络体系，采取“政企社共建村级便民服务中心”项目运营模式，提供一站式服务，以专人、专业方式处理日常民生事务。村级便民服务中心是党群、干群、企群之间的连心桥，是方便百姓、服务百姓的民心工程，是转变政府职能、提高行政效率的示范工程，是招商引资、对外开放的窗口工程和遏制腐败、树立形象的阳光工程。"
        abstarctContent.numberOfLines=0
        if(IS_IPHONE_4_OR_LESS)
        {
          abstarctContent.font=UIFont(name: "HelveticaNeue", size: 18.0)
        }
        else
        {
            abstarctContent.font=UIFont(name: "HelveticaNeue", size: 16.0)

        }
        abstarctContent.textColor=contentColor
        contentView.addSubview(abstarctContent)
    }
    
    
    func loadDevView()
    {
        //发展历程页面
        let developmentTitle=UILabel(frame: CGRectMake(sWidth*0.05,sHeight*0.05,sWidth*0.9,sHeight*0.043))
        developmentTitle.backgroundColor=UIColor.whiteColor()
        developmentTitle.text="公司发展历程"
         if(IS_IPHONE_4_OR_LESS)
         {
           developmentTitle.font=UIFont(name: "HelveticaNeue", size: 20.0)
         }
         else
         {
            developmentTitle.font=UIFont(name: "HelveticaNeue", size: 22.0)
         }
        developmentTitle.textAlignment = .Center//居中显示
        contentView.addSubview(developmentTitle)
        
        let developmentContent=UITableView(frame: CGRectMake(0,sHeight*0.1,sWidth,sHeight*0.58), style: .Plain);
        developmentContent.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell2" )
        developmentContent.delegate=self
        developmentContent.dataSource=self
        contentView.addSubview(developmentContent)
        
    }
    
    func loadPartnerView()
    {
        //合作伙伴
        let innerPartnerTitle=UILabel(frame: CGRectMake(sWidth*0.05,sHeight*0.05,sWidth*0.9,sHeight*0.043));
        innerPartnerTitle.backgroundColor=UIColor.whiteColor()
        innerPartnerTitle.text="内部合作单位"
        if(IS_IPHONE_4_OR_LESS)
        {
            innerPartnerTitle.font=UIFont(name: "HelveticaNeue", size: 20.0)
        }
        else
        {
            innerPartnerTitle.font=UIFont(name: "HelveticaNeue", size: 22.0)
        }
        innerPartnerTitle.textAlignment = .Center
        contentView.addSubview(innerPartnerTitle)
        
        let partnerImage1 = UIImageView(frame:CGRectMake(sWidth*0.05,sHeight*0.13,sWidth*0.9,sHeight*0.23))
        partnerImage1.image=UIImage(named: "partner1")
        contentView.addSubview(partnerImage1)
        
        
        let outerPartnerTitle=UILabel(frame: CGRectMake(sWidth*0.05,sHeight*0.4,sWidth*0.9,sHeight*0.043));
        outerPartnerTitle.text="外部合作单位"
        if(IS_IPHONE_4_OR_LESS)
        {
          outerPartnerTitle.font=UIFont(name: "HelveticaNeue", size: 20.0)
        }
        else
        {
            outerPartnerTitle.font=UIFont(name: "HelveticaNeue", size: 22.0)
        }
        outerPartnerTitle.textAlignment = .Center
        contentView.addSubview(outerPartnerTitle)
        
        let partnerImage2 = UIImageView(frame:CGRectMake(sWidth*0.05,sHeight*0.48,sWidth*0.9,sHeight*0.35))
        partnerImage2.image=UIImage(named: "partner2")
        contentView.addSubview(partnerImage2)
        
    }
    
    func loadLoveView()
    {
        //领导关怀页面
        let leaderImageView1:UIImageView=UIImageView(frame:CGRectMake(sWidth*0.05,sHeight*0.02,sWidth*0.9,sHeight*0.25))
        leaderImageView1.image=UIImage(named: "leader1")
        
        let leaderImageView2:UIImageView=UIImageView(frame:CGRectMake(sWidth*0.05,sHeight*0.29,sWidth*0.9,sHeight*0.25))
        leaderImageView2.image=UIImage(named: "leader2")
        
        let leaderImageView3:UIImageView=UIImageView(frame:CGRectMake(sWidth*0.05,sHeight*0.56,sWidth*0.9,sHeight*0.25))
        leaderImageView3.image=UIImage(named: "leader3")
        
        contentView.addSubview(leaderImageView1)
        contentView.addSubview(leaderImageView2)
        contentView.addSubview(leaderImageView3)
    }
    
    func loadReputationView()
    {
        let reputationView:UIImageView=UIImageView(frame: CGRectMake(sWidth*0.05, sHeight*0.05, sWidth*0.9, sHeight*0.7))
        reputationView.image=UIImage(named: "fame")
        contentView.addSubview(reputationView)
    }
    //------------------------------------------------------------------------------------------------
    
    func addGreenUnderline(button:UIButton)
    {
        let underLine:UIView=UIView(frame: CGRectMake(0,0,sWidth*0.1,sHeight*0.1));
        underLine.backgroundColor=UIColor.redColor()
        switchView.addSubview(underLine)
    }
    
    
    //------------------------------------------------------------------------------------------------
    //切换按钮
    func companyBtnTapped(button:UIButton)
    {
        switchIndex=0
        viewWillAppear(false)
    }
    
    func developmentBtnTapped(button:UIButton)
    {
        switchIndex=1
        viewWillAppear(false)
    }
    
    func partnerBtnTapped(button:UIButton)
    {
        switchIndex=2
        viewWillAppear(false)
    }
    
    func leaderBtnTapped(button:UIButton)
    {
        switchIndex=3
        viewWillAppear(false)
    }
    
    func reputationBtnTapped(button:UIButton)
    {
        switchIndex=4
         viewWillAppear(false)
    }
    
    
    
}

