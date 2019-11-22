import ClibTensorRT
import Clibcudart


public class Tensor<T> where T:Numeric {
  public let dimensions: [Dimensions]
  public let numberOfElements: Int
  let numberOfBytes: Int
  let reference: UnsafeMutableRawPointer

  public init?(dimensions: [Dimensions]) {
    let numberOfElements = dimensions.reduce(1) { $0 * $1.extent }
    let numberOfBytes = numberOfElements * MemoryLayout<T>.size

    var ptr: UnsafeMutableRawPointer? = nil
    guard cudaSuccess == cudaMalloc(&ptr, numberOfBytes), let reference = ptr else {
      return nil
    }

    self.dimensions = dimensions
    self.numberOfElements = numberOfElements
    self.numberOfBytes = numberOfBytes
    self.reference = reference
  }

  deinit {
    cudaFree(self.reference)
  }

  @discardableResult
  public func copy(into v: inout [T]) -> Bool {
    assert(v.count == numberOfElements)
    return v.withUnsafeMutableBufferPointer { buffer in
      guard cudaSuccess == cudaMemcpy(buffer.baseAddress, self.reference, self.numberOfBytes, cudaMemcpyDeviceToHost) else {
        return false
      }
      return true
    }
  }

  @discardableResult
  public func copy(from v: [T]) -> Bool {
    assert(v.count == numberOfElements)
    return v.withUnsafeBufferPointer { buffer in
      guard cudaSuccess == cudaMemcpy(self.reference, UnsafeMutableRawPointer(mutating: buffer.baseAddress), self.numberOfBytes, cudaMemcpyHostToDevice) else {
        return false
      }
      return true
    }
  }
}
