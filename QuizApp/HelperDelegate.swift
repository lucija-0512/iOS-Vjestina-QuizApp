
import Foundation
@objc protocol AppWalkThroughDelegate {
  @objc optional func goNextPage(forwardTo position: Int)
}
