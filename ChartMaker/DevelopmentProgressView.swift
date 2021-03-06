//
//  DevelopmentProgressView.swift
//  ChartMaker
//
//  Created by Insu Park on 2022/07/11.
//

import UIKit

class DevelopmentProgressView: UIView {
    
    // MARK: abcd
    
    enum DevProgressCategory {
        case height
        case weight
        case head
    }
    
    /* Color */
    
    let barColor: UIColor = UIColor.rgb(r: 246, g: 216, b: 255)
    let barBgColor: UIColor = .white
    let barBgBorderColor: UIColor = UIColor.rgb(r: 228, g: 228, b: 228)
    
    
    /* About Bar Drawing */
    
    let barHeight: CGFloat = 16
    let barRadius: CGFloat = 8
    
    let barTopPadding: CGFloat = 22
    let barLeftPadding: CGFloat = 76
    let barRightPadding: CGFloat = 84
    
    /* Frame */
    let fullWidth = UIScreen.main.bounds.width
    let fullHeight: CGFloat = 38
    
    /* About Keyword */
    
    let keywordLeftPadding: CGFloat = 20
    var keywordCenterY: CGFloat = .zero
    
    //
    
    /* Categories */
    var category: DevProgressCategory = .height {
        didSet {
            isCategorySet = true
        }
    }
    
    var isCategorySet: Bool = false {
        didSet {
            if isCategorySet {
                self.setNeedsDisplay()
            }
        }
    }
    
    var value: Int = 100
    
    /* Init */
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        guard isCategorySet else { return }
        
        /* Draw Order
            1. Border Line
            2. progressView
            3. averageLine
         
         */
        
//        self.backgroundColor = UIColor.orange
        
//        self.makeBorderLine(rect)
//
//        self.makeProgress(rect)
//
//        self.makeAverageDotLine(rect)
        self.keywordCenterY = fullHeight - (barHeight / 2)
        
        self.makeKeyword()
        
        self.makePercent()
    }
    
    private func makeKeyword() {
        var size: CGSize = .zero
        
        switch self.category {
        case .height:
            size = self.getLabelSize(text: "???", font: Font.poppins(type: "Bold", size: 13.0))
            
            let startPosition = CGPoint.init(x: self.keywordLeftPadding,
                                             y: self.keywordCenterY - (size.height / 2))
            self.makeItem(startPoint: startPosition, text: "???")
        case .weight:
            size = self.getLabelSize(text: "?????????", font: Font.poppins(type: "Bold", size: 13.0))
            
            let startPosition = CGPoint.init(x: self.keywordLeftPadding,
                                             y: self.keywordCenterY - (size.height / 2))
            self.makeItem(startPoint: startPosition, text: "?????????")
        case .head:
            size = self.getLabelSize(text: "????????????", font: Font.poppins(type: "Bold", size: 13.0))
            
            let startPosition = CGPoint.init(x: self.keywordLeftPadding,
                                             y: self.keywordCenterY - (size.height / 2))
//            self.makeItem(startPoint: startPosition, text: "????????????")
            
            self.makeItem(from: "????????????", at: startPosition)
        }
    }
    
    private func makePercent() {
        let text = "?????? \(value)%"
        let textSize = getLabelSize(text: text,
                                    font: Font.poppins(type: "Bold",
                                                       size: 13.0))
        
        let sPoint = CGPoint.init(x: self.fullWidth - barRightPadding + CGFloat(7),
                                  y: self.keywordCenterY - (textSize.height / 2))
        
        self.makeItem(startPoint: sPoint,
                      text: text)
    }

    // MARK: - Util
    
    /* ???????????? ?????? */
    private func makeItem(from: String, at: CGPoint) {
        let textColor = UIColor.rgb(r: 60, g: 60, b: 60)
        let textFont = Font.poppins(type: "Medium",
                                    size: 13.0)
        
        let text = from as NSString
        
        let butes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: textFont,
        ]
        
        text.draw(at: at,
                  withAttributes: butes)
    }
    
    /* ?????? ?????? For Percent  */
    func makeItem(startPoint: CGPoint, text: String) {
        let textColor = UIColor.rgb(r: 205, g: 0, b: 255)
        let textFont = Font.poppins(type: "Bold",
                                    size: 13.0)
        
        let from = text as NSString
        
        let butes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: textFont,
        ]

        from.draw(at: startPoint,
                  withAttributes: butes)
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = font
        label.sizeToFit()
        return label.frame.size
    }
    
}
