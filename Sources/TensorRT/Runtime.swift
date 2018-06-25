import ClibTensorRT
import Foundation


public class Runtime {
  let reference: UnsafeRawPointer

  public init?() {
    guard let reference = Runtime_create() else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    Runtime_destroy(self.reference)
  }

  public func createEngine(fromPlan plan: Data) -> Engine? {
    return plan.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Engine? in
      guard let reference = Runtime_createEngine(self.reference, bytes, plan.count) else {
        return nil
      }
      return Engine(reference: reference)
    }
  }
}
