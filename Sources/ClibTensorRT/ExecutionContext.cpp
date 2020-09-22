#include <NvInfer.h>
#include <stdio.h>

using namespace nvinfer1;

extern "C" {

void ExecutionContext_destroy(IExecutionContext* executionContext) {
  executionContext->destroy();
}

void ExecutionContext_setDebugSync(IExecutionContext* executionContext, bool value) {
  executionContext->setDebugSync(value);
}

bool ExecutionContext_getDebugSync(IExecutionContext* executionContext) {
  executionContext->getDebugSync();
}

bool ExecutionContext_execute(IExecutionContext* executionContext, int batchSize, void** bindings) {
  return executionContext->execute(batchSize, bindings);
}

}
