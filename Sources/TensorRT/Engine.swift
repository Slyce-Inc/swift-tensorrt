import ClibTensorRT
import Clibcudart


public struct Dimensions {
  public let extent: Int
  public let type: DimensionType
}

public enum DimensionType {
case Spatial
case Channel
case Index
case Sequence
}

public class Engine {
  let reference: UnsafeRawPointer

  init(reference: UnsafeRawPointer) {
    self.reference = reference
  }

  deinit {
    Engine_destroy(self.reference)
  }

  public func index(ofBinding name: String) -> Int? {
    guard case let index = Engine_getBindingIndex(self.reference, name), index > -1 else {
      return nil
    }
    return Int(index)
  }

  public lazy var bindings: [Binding] = {
    let numberOfBindings = Int(Engine_getNbBindings(self.reference))
    var result: [Binding] = []
    for index in 0..<numberOfBindings {
      var dims = [TensorRT_Dimensions](repeating: TensorRT_Dimensions(), count: 8)
      let numberOfValidDimensions = Int(Engine_getBindingDimensions(self.reference, Int32(index), &dims, Int32(dims.count)))
      var dimensions: [Dimensions] = []
      for i in 0 ..< numberOfValidDimensions {
        let type: DimensionType
        switch dims[i].type {
          case 0: type = .Spatial
          case 1: type = .Channel
          case 2: type = .Index
          case 3: type = .Sequence
          default:
            preconditionFailure("dims[\(i)].type has an unexpected value: \(dims[i].type)")
        }
        dimensions.append(Dimensions(extent: Int(dims[i].extent), type: type))
      }
      let name = String(cString:Engine_getBindingName(self.reference, Int32(index))!)
      result.append(Binding(name:name, index:index, dimensions:dimensions))
    }
    return result
  }()

  public func createExecutionContext() -> ExecutionContext? {
    guard let reference = Engine_createExecutionContext(self.reference) else {
      return nil
    }
    return ExecutionContext(reference:reference)
  }

  public class Binding {
    public let name: String
    public let index: Int
    public let dimensions: [Dimensions]

    init(name:String, index:Int, dimensions:[Dimensions]) {
      self.name = name
      self.index = index
      self.dimensions = dimensions
    }
  }
}
