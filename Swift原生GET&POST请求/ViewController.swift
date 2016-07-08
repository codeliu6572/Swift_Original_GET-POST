//
//  ViewController.swift
//  Swift原生GET&POST请求
//
//  Created by 刘浩浩 on 16/7/8.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let getBtn = UIButton(type: .System)
        getBtn.frame = CGRectMake(50, 100, 100, 100)
        getBtn.setTitle("GET", forState: .Normal)
        getBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        getBtn.addTarget(self, action: #selector(self.GETACtion), forControlEvents: .TouchUpInside)
        self.view.addSubview(getBtn)
        
        
        let postBtn = UIButton(type: .System)
        postBtn.frame = CGRectMake(self.view.frame.size.width - 150, 100, 100, 100)
        postBtn.setTitle("POST", forState: .Normal)
        postBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        postBtn.addTarget(self, action: #selector(self.POSTACtion), forControlEvents: .TouchUpInside)
        self.view.addSubview(postBtn)
        
    }
    
    /**
     往下看你会发现其实GET和POST差不多是一样的，一般我们认为GET方法是不用上传参数的，所有的参数都在请求链接中或者索性直接没参数，在这里GET方法中你看到参数是可以放在请求体中的，而大多数搜索到的区别都认为GET的参数在请求链接上，这种说法是不对的，GET参数完全可以放在请求体中，并不是因为GET连接长度有限制，起到限制的不是http协议，而是服务器和浏览器，所以乍一看这里GET和POST几乎一样，但它们在HTTPMethod是有着本质区别的，不再说本质区别，有兴趣的自己了解。
     
     
     另外需要注意的是，这里的字典，如果你想封装的话一定要考虑字典为空的情况，如果为空，请不要使用            request.HTTPMethod = "XXX"，否则会报错，所以，如你所见，当字典为空时，POST和GET没有任何区别，但至于它属于什么方法，我并没有从网上找到答案，留待大家补充

     */
    
    
    
    
    
    /**
     GET请求
     */
    func GETACtion() {
        //请求URL
        let url:NSURL! = NSURL(string: "http://iappfree.candou.com:8080/free/applications/limited")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let list  = NSMutableArray()
        var paramDic = [String: String]()
        
        if paramDic.count > 0 {
            //设置为GET请求
            request.HTTPMethod = "GET"
            //拆分字典,subDic是其中一项，将key与value变成字符串
            for subDic in paramDic {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.addObject(tmpStr)
            }
            //用&拼接变成字符串的字典各项
            let paramStr = list.componentsJoinedByString("&")
            //UTF8转码，防止汉字符号引起的非法网址
            let paraData = paramStr.dataUsingEncoding(NSUTF8StringEncoding)
            //设置请求体
            request.HTTPBody = paraData
        }
        //默认session配置
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        //发起请求
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            //            let str:String! = String(data: data!, encoding: NSUTF8StringEncoding)
            //            print("str:\(str)")
            //转Json
            let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            print(jsonData)
            
        }
        //请求开始
        dataTask.resume()

    }
    /**
     POST请求
     */
    func POSTACtion() {
        //请求URL
        let url:NSURL! = NSURL(string: "http://iappfree.candou.com:8080/free/applications/limited")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let list  = NSMutableArray()
        var paramDic = [String: String]()
        
        if paramDic.count > 0 {
            //设置为POST请求
            request.HTTPMethod = "POST"
            //拆分字典,subDic是其中一项，将key与value变成字符串
            for subDic in paramDic {
                let tmpStr = "\(subDic.0)=\(subDic.1)"
                list.addObject(tmpStr)
            }
            //用&拼接变成字符串的字典各项
            let paramStr = list.componentsJoinedByString("&")
            //UTF8转码，防止汉字符号引起的非法网址
            let paraData = paramStr.dataUsingEncoding(NSUTF8StringEncoding)
            //设置请求体
            request.HTTPBody = paraData
        }
        //默认session配置
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        //发起请求
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            //            let str:String! = String(data: data!, encoding: NSUTF8StringEncoding)
            //            print("str:\(str)")
            //转Json
            let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            print(jsonData)
            
        }
        //请求开始
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

