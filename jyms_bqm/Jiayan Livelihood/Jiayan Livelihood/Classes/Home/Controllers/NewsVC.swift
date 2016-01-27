//
//  NewsVC.swift
//  JYMS
//
//  Created by Lance on 1/13/16.
//  Copyright © 2016 Lance. All rights reserved.
//

import UIKit
//新闻详细页面
class NewsVC: UIViewController
{
    private var newsView:UIView!
    private var toolBar:UIView!
    
    override func viewWillAppear(animated: Bool) {
        initToolBar()
        initNews()
        
    }
    
    func initNews()
    {
        //新闻主页面
        newsView = UIView(frame:CGRectMake(0,0,sWidth,sHeight*0.923))
        newsView.backgroundColor=UIColor.whiteColor()
        
        //标题
        let newsTitle=UILabel(frame:CGRectMake(sWidth*0.05,sHeight*0.03,sWidth*0.9,sHeight*0.05))
        
        newsTitle.text="人民日报社领导考察指导嘉言民生"
        newsView.addSubview(newsTitle)
        
        //日期
        let dateView=UILabel(frame:CGRectMake(sWidth*0.05,sHeight*0.10,sWidth*0.2,sHeight*0.03))
        dateView.text="2015-10-28"
        if(IS_IPHONE_4_OR_LESS)
        {
           dateView.font=UIFont(name: "HelveticaNeue", size: 11)
        }
        else
        {
            dateView.font=UIFont(name: "HelveticaNeue", size: 13)
        }
        dateView.textColor=contentColor
        newsView.addSubview(dateView)
        
        //文章来源
        let sourceView=UILabel(frame:CGRectMake(sWidth*0.35,sHeight*0.10,sWidth*0.45,sHeight*0.03))
        sourceView.text="文章来源：人民日报"
        if(IS_IPHONE_4_OR_LESS)
        {
            sourceView.font=UIFont(name: "HelveticaNeue", size: 11)
        }
        else
        {
             sourceView.font=UIFont(name: "HelveticaNeue", size: 13)
        }
        
        sourceView.textColor=contentColor
        newsView.addSubview(sourceView)
        
        //点击量图标
        
        let eyeView:UIImageView=UIImageView(frame: CGRectMake(sWidth*0.81, sHeight*0.10, sWidth*0.05, sHeight*0.03))
        let eyeImage:UIImage=UIImage(named: "eye")!
        eyeView.image=eyeImage;
        newsView.addSubview(eyeView)
        
        //点击量数字
        let numView:UILabel=UILabel(frame:CGRectMake(sWidth*0.86, sHeight*0.10, sWidth*0.1, sHeight*0.03))
        numView.text="10000"
        numView.textColor=contentColor
        
        if(IS_IPHONE_4_OR_LESS)
        {
           numView.font=UIFont(name: "HelveticaNeue", size: 11)
        }
        else
        {
            numView.font=UIFont(name: "HelveticaNeue", size: 13)
        }
        
        newsView.addSubview(numView)
        
        
        let lineView=UIView(frame: CGRectMake(sWidth*0.05,sHeight*0.13,sWidth*0.9,sHeight*0.0015))
        lineView.backgroundColor=UIColor.whiteColor()
        newsView.addSubview(lineView)
        
        self.view.addSubview(newsView)
        
        //新闻内容
        let newsContent=UIWebView(frame:CGRectMake(sWidth*0.05,sHeight*0.15,sWidth*0.9,sHeight*0.772))
        let res = NSBundle.mainBundle().pathForResource("demo", ofType:"html")
        let url=NSURL.fileURLWithPath(res!)
        print(url)
        let request=NSURLRequest(URL: url)
        newsContent.loadRequest(request)
        
        newsView.addSubview(newsContent)
        
        
        
    }
    
    func initToolBar()
    {
        //新闻页面工作栏
        toolBar = UIView(frame:CGRectMake(0,sHeight*0.923,sWidth,sHeight*0.077))
        toolBar.backgroundColor = UIColor.whiteColor()
        
        //返回按钮
        let logo1=UIButton(frame:CGRectMake(0,0,sWidth*0.33,sHeight*0.077))
        logo1.setImage(UIImage(named: "news_01"), forState: .Normal)
        logo1.addTarget(self, action: Selector("returnBtnTapped:"), forControlEvents: .TouchUpInside)
        
        //分享按钮
        let logo2=UIButton(frame:CGRectMake(sWidth*0.33,0,sWidth*0.33,sHeight*0.077))
        logo2.setImage(UIImage(named: "news_02"), forState: .Normal)
        logo2.addTarget(self, action: Selector("shareBtnTapped:"), forControlEvents: .TouchUpInside)
        
        //收藏按钮
        let logo3=UIButton(frame:CGRectMake(sWidth*0.66,0,sWidth*0.33,sHeight*0.077))
        logo3.setImage(UIImage(named: "news_03"), forState: .Normal)
        
        toolBar.addSubview(logo1)
        toolBar.addSubview(logo2)
        toolBar.addSubview(logo3)
        
        self.view.addSubview(toolBar);
    }
    
     //返回主页面
    func returnBtnTapped(button:UIButton)
    {
       
        self.parentViewController?.rdv_tabBarController.tabBarHidden=false
        self.navigationController?.navigationBar.hidden=false
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //分享至社交平台
    func shareBtnTapped(button:UIButton)
    {
        let imageArr:[UIImage]=[UIImage(named: "news_01")!]
        
        if(!imageArr.isEmpty)
        {
            var shareParams=NSMutableDictionary();
            shareParams.SSDKSetupShareParamsByText("分享内容",
                                                  images:imageArr,
                                                  url:NSURL(string: "http://mob.com"),
                                                  title: "分享标题",
                                                  type: SSDKContentType.Auto)
            
            
            
            //2.进行分享
            let handler:SSUIShareStateChangedHandler = {(state:SSDKResponseState, type:SSDKPlatformType, userdate:[NSObject : AnyObject]!, contentEntity:SSDKContentEntity!,error:NSError!, end:Bool) -> Void in
                
                switch state{
                    
                case SSDKResponseState.Success:
                    print("分享成功")
                    let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
                    alert.show()
                case SSDKResponseState.Fail:    print("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  print("分享取消")
                    
                default:
                    break
                }
            
            }
            ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParams, onShareStateChanged:handler);

        }
    }

}
