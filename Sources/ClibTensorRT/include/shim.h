#ifndef __TensorRT_shim_h
#define __TensorRT_shim_h

#include <unistd.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#include <types.h>

extern const void* Runtime_create();
extern void Runtime_destroy(const void* runtime);
extern const void* Runtime_createEngine(const void* runtime, const void* plan, size_t size);

extern void Engine_destroy(const void* engine);
extern int Engine_getNbBindings(const void* engine);
extern int Engine_getBindingIndex(const void* engine, const char* name);
extern const char* Engine_getBindingName(const void* engine, int index);
extern int Engine_getBindingDimensions(const void* engine, int index, TensorRT_Dimensions* dims, int maxDims);
extern const void* Engine_createExecutionContext(const void* engine);

extern void ExecutionContext_destroy(const void* executionContext);
extern void ExecutionContext_setDebugSync(const void* executionContext, bool value);
extern bool ExecutionContext_getDebugSync(const void* executionContext);
extern bool ExecutionContext_execute(const void* executionContext, int batchSize, void** bindings);

#ifdef __cplusplus
}
#endif

#endif
