//
//  YQLineView.swift
//  Pods-YQLineView_Example
//
//  Created by 王叶庆 on 2019/5/14.
//

import UIKit

public struct YQLinePositions: OptionSet {
 
    public typealias RawValue = Int
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    public static let top = YQLinePositions(rawValue: 1)
    public static let left = YQLinePositions(rawValue: 1 << 1)
    public static let bottom = YQLinePositions(rawValue: 1 << 2)
    public static let right = YQLinePositions(rawValue: 1 << 3)
    
    public static let all: [YQLinePositions] = [.top, .left, .bottom, .right]
}

let SINGLE_LINE_WIDTH = 1 / UIScreen.main.scale
let SINGLE_LINE_ADJUST_OFFSET = SINGLE_LINE_WIDTH / 2


@IBDesignable open class YQLineView: UIView {

    @IBInspectable public var color: UIColor? = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    public var positions:YQLinePositions = [.bottom] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
    }
    
    public init(size: CGSize = CGSize(width: 100, height: 1), color: UIColor? = UIColor.gray, positions: YQLinePositions = [.bottom]) {
        self.color = color
        self.positions = positions
        super.init(frame: CGRect(origin: CGPoint.zero, size: size))
        self.backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.beginPath()
        if let color = self.color {
            color.setStroke()
        }
        context.setLineWidth(SINGLE_LINE_WIDTH)
        for position in YQLinePositions.all {
            guard positions.contains(position) else {continue}
            switch position {
            case .top:
                print("top")
                context.move(to: CGPoint(x: 0, y: SINGLE_LINE_ADJUST_OFFSET))
                context.addLine(to: CGPoint(x: bounds.width, y: SINGLE_LINE_ADJUST_OFFSET))
            case .right:
                print("right")
                context.move(to: CGPoint(x: bounds.width - SINGLE_LINE_ADJUST_OFFSET, y: 0))
                context.addLine(to: CGPoint(x: bounds.width - SINGLE_LINE_ADJUST_OFFSET, y: bounds.height))
            case .bottom:
                print("bottom")
                context.move(to: CGPoint(x: 0, y: bounds.height -  SINGLE_LINE_ADJUST_OFFSET))
                context.addLine(to: CGPoint(x: bounds.width, y: bounds.height - SINGLE_LINE_ADJUST_OFFSET))
            case .left:
                print("left")
                context.move(to: CGPoint(x: SINGLE_LINE_ADJUST_OFFSET, y: 0))
                context.addLine(to: CGPoint(x: SINGLE_LINE_ADJUST_OFFSET, y: bounds.height))
            default:
                break
            }
        }
        context.strokePath()
    }

}
