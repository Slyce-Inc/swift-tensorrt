#include <NvInfer.h>
#include <cuda_runtime.h>

#include <types.h>
#include <algorithm>


using namespace nvinfer1;

extern "C" {

void Engine_destroy(ICudaEngine* engine) {
  engine->destroy();
}

int Engine_getNbBindings(ICudaEngine* engine) {
  return engine->getNbBindings();
}

int Engine_getBindingIndex(ICudaEngine* engine, const char* name) {
  return engine->getBindingIndex(name);
}

const char* Engine_getBindingName(ICudaEngine* engine, int index) {
  return engine->getBindingName(index);
}

int Engine_getBindingDimensions(ICudaEngine* engine, int index, TensorRT_Dimensions* dims, int maxDims) {
  Dims d = engine->getBindingDimensions(index);
  int numberOfDimensions = d.nbDims;
  for (int i = 0; i < std::min(maxDims, numberOfDimensions); i++) {
    dims[i].type = static_cast<std::underlying_type<DimensionType>::type>(d.type[i]);
    dims[i].extent = d.d[i];
  }
  return numberOfDimensions;
}

const void* Engine_createExecutionContext(ICudaEngine* engine) {
  IExecutionContext* executionContext = engine->createExecutionContext();
  if (executionContext) {
    executionContext->setDebugSync(true);
  }
  return executionContext;
}

}
