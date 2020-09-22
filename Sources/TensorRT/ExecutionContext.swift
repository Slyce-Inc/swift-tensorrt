import ClibTensorRT


public class ExecutionContext {
  private let reference: UnsafeRawPointer

  init(reference:UnsafeRawPointer) {
    self.reference = reference
  }

  deinit {
    ExecutionContext_destroy(self.reference)
  }

  public var debugSync: Bool {
    get { 
      return ExecutionContext_getDebugSync(self.reference)
    }
    set {
      ExecutionContext_setDebugSync(self.reference, newValue)
    }
  }

  public func execute(batchSize:Int, tensors:[Tensor<Float>]) -> Bool {
    var ptrs = tensors.map { (tensor:Tensor<Float>) -> UnsafeMutableRawPointer? in tensor.reference }
    return ExecutionContext_execute(self.reference, Int32(batchSize), &ptrs)
  }
}
