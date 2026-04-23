import UIKit
import XCTest
@testable import YQLineView

final class YQLineViewTests: XCTestCase {

    func testLinePositionsCanCombineMultipleEdges() {
        // 验证 OptionSet 可以正确表达多条边线，避免 SPM 集成后基础类型行为退化。
        let positions: YQLinePositions = [.top, .left, .bottom, .right]

        XCTAssertTrue(positions.contains(.top))
        XCTAssertTrue(positions.contains(.left))
        XCTAssertTrue(positions.contains(.bottom))
        XCTAssertTrue(positions.contains(.right))
        XCTAssertEqual(Set(YQLinePositions.all), Set([.top, .left, .bottom, .right]))
    }

    func testLineMarginInitializersKeepHeadAndTailValues() {
        // 验证两种初始化方式都保留头尾边距，保证调用方设置绘制留白时数据可靠。
        let namedMargin = YQLineMargin(head: 8, tail: 12)
        let shorthandMargin = YQLineMargin(3, 5)

        XCTAssertEqual(namedMargin.head, 8)
        XCTAssertEqual(namedMargin.tail, 12)
        XCTAssertEqual(shorthandMargin.head, 3)
        XCTAssertEqual(shorthandMargin.tail, 5)
    }

    func testDefaultInitializerUsesSafeDefaults() {
        // 验证默认初始化保持原有外观约定：白色背景、浅灰色线条、底部单边线。
        let view = YQLineView()

        XCTAssertTrue(view.color?.isEqual(UIColor.lightGray) == true)
        XCTAssertTrue(view.backgroundColor?.isEqual(UIColor.white) == true)
        XCTAssertEqual(view.positions, [.bottom])
    }

    func testConvenienceInitializerAppliesConfiguration() {
        // 验证便捷初始化能正确应用尺寸、颜色和边线位置。
        let size = CGSize(width: 120, height: 44)
        let view = YQLineView(size: size, color: .red, positions: [.top, .left])

        XCTAssertEqual(view.bounds.size, size)
        XCTAssertTrue(view.color?.isEqual(UIColor.red) == true)
        XCTAssertTrue(view.positions.contains(.top))
        XCTAssertTrue(view.positions.contains(.left))
        XCTAssertFalse(view.positions.contains(.bottom))
        XCTAssertFalse(view.positions.contains(.right))
    }

    func testSetLineMarginHandlesNilAndMultiplePositions() {
        // 验证公开 API 能安全处理多位置和 nil 清除场景，不抛出异常或破坏绘制刷新流程。
        let view = YQLineView()

        XCTAssertNoThrow(view.setLineMargin(YQLineMargin(4, 6), at: [.top, .right]))
        XCTAssertNoThrow(view.setLineMargin(nil, at: [.top, .right]))
    }
}
