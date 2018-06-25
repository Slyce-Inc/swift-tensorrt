#include <NvInfer.h>
#include <stdio.h>

using namespace nvinfer1;

extern "C" {

void ExecutionContext_destroy(IExecutionContext* executionContext) {
  executionContext->destroy();
}

bool ExecutionContext_execute(IExecutionContext* executionContext, int batchSize, void** bindings) {
  return executionContext->execute(batchSize, bindings);
}

}
