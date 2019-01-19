//
//  MessageItem.swift
//  TabbedApp
//
//  Created by alan king on 2019/1/18.
//  Copyright © 2019年 Allen Lab. All rights reserved.
//

import UIKit

// 消息类型，我的还是别人的
enum ChatType{
    case Mine
    case Someone
}

class MessageItem{
    // 头像
    var logo: String!
    // 消息时间
    var date: NSDate!
    // 消息类型
    var mtype: ChatType!
    // 内容视图，标签或图片
    var view: UIView!
    // 边距
    var insets: UIEdgeInsets!
    
    // 设置我的文本消息边距
    class func getTextInsetsMine() -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 10, bottom: 11, right: 17)
    }
    
    // 设置他人的文本消息边距
    class func getTextInsetsSomeone() -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 15, bottom: 11, right: 10)
    }
    
    // 设置我的图片消息边距
    class func getImageInsetsMine() -> UIEdgeInsets{
        return UIEdgeInsets(top: 11, left: 13, bottom: 16, right: 22)
    }
    
    // 设置他人图片消息边距
    class func getImageInsetsSomeone() -> UIEdgeInsets{
        return UIEdgeInsets(top: 11, left: 13, bottom: 16, right: 22)
    }
    
    // 构造文本消息体
    convenience init(body: NSString, logo: String, date: NSDate, mtype: ChatType){
        let font = UIFont.boldSystemFont(ofSize: 12)
        let width = 225, height = 10000.0
        let atts = [NSAttributedString.Key.font: font]
        
        let size = body.boundingRect(with: CGSize(width: CGFloat(width), height: CGFloat(height)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: atts, context: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = (body.length != 0 ? body : "") as String
        label.font = font
        label.backgroundColor = UIColor.clear
        
        let insets:UIEdgeInsets = (mtype == ChatType.Mine ? MessageItem.getTextInsetsMine() : MessageItem.getTextInsetsSomeone())
        
        self.init(logo: logo, date: date, mtype: mtype, view: label, insets: insets)
    }
    
    // 可以传入更多的自定义视图
    init(logo: String, date: NSDate, mtype: ChatType, view: UIView, insets: UIEdgeInsets) {
        self.view = view
        self.logo = logo
        self.date = date
        self.mtype = mtype
        self.insets = insets
    }
    
    // 构造图片消息体
    convenience init(image: UIImage, logo: String, date: NSDate, mtype: ChatType){
        var size = image.size
        // 等比缩放
        if size.width > 220 {
            size.height /= (size.width / 220)
            size.width = 220
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.image = image
        imageView.layer.cornerRadius = 5.0
        let insets: UIEdgeInsets = (mtype == ChatType.Mine ? MessageItem.getImageInsetsMine() : MessageItem.getImageInsetsSomeone())
        
        self.init(logo: logo, date: date, mtype: mtype, view: imageView, insets: insets)
    }
}
