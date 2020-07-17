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

/// 线两边的边距，从上到下、从左到右原则
public struct YQLineMargin {
    let head: CGFloat
    let tail: CGFloat
    public init(head: CGFloat = 0, tail: CGFloat = 0) {
        self.head = head
        self.tail = tail
    }
    public init(_ head: CGFloat, _ tail: CGFloat) {
        self.head = head
        self.tail = tail
    }
    
}

extension YQLinePositions: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

let SINGLE_LINE_WIDTH = 1 / UIScreen.main.scale
let SINGLE_LINE_ADJUST_OFFSET = SINGLE_LINE_WIDTH / 2


@IBDesignable open class YQLineView: UIControl {

    @IBInspectable public var color: UIColor? = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    public var positions:YQLinePositions = [.bottom] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    /// 边线的偏移量
    public var edgeInsets = UIEdgeInsets.zero
    private var lineMargins: [YQLinePositions : YQLineMargin] = [:]

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
    
    public func setLineMargin(_ margin: YQLineMargin?, at positions: YQLinePositions) {
        for position in YQLinePositions.all {
            guard positions.contains(position) else {continue}
            lineMargins[position] = margin
        }
        setNeedsDisplay()
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
            let margin = lineMargins[position] ?? YQLineMargin(0, 0)
            switch position {
            case .top:
                context.move(to: CGPoint(x: edgeInsets.left + margin.head, y: SINGLE_LINE_ADJUST_OFFSET + edgeInsets.top))
                context.addLine(to: CGPoint(x: bounds.width - edgeInsets.right - margin.tail, y: SINGLE_LINE_ADJUST_OFFSET + edgeInsets.top))
            case .right:
                context.move(to: CGPoint(x: bounds.width - edgeInsets.right - SINGLE_LINE_ADJUST_OFFSET, y: edgeInsets.top + margin.head))
                context.addLine(to: CGPoint(x: bounds.width - edgeInsets.right - SINGLE_LINE_ADJUST_OFFSET, y: bounds.height - edgeInsets.bottom - margin.tail))
            case .bottom:
                context.move(to: CGPoint(x: edgeInsets.left + margin.head, y: bounds.height - edgeInsets.bottom - SINGLE_LINE_ADJUST_OFFSET))
                context.addLine(to: CGPoint(x: bounds.width - edgeInsets.right - margin.tail, y: bounds.height - edgeInsets.bottom - SINGLE_LINE_ADJUST_OFFSET))
            case .left:
                context.move(to: CGPoint(x: edgeInsets.left + SINGLE_LINE_ADJUST_OFFSET, y: edgeInsets.top + margin.head))
                context.addLine(to: CGPoint(x: edgeInsets.left + SINGLE_LINE_ADJUST_OFFSET, y: bounds.height - edgeInsets.bottom - margin.tail))
            default:
                break
            }
        }
        context.strokePath()
    }

}
