#include <iostream>
#include <fstream>
#include <unistd.h>
#include <NvInfer.h>


using namespace std;
using namespace nvinfer1;


class Logger : public ILogger
{
  void log(Severity severity, const char * msg) override
  {
    if (severity != Severity::kINFO) {
      cout << "TensorRT: " << msg << endl;
    }
  }
};

Logger gLogger;

extern "C" {

IRuntime* Runtime_create() {
  return createInferRuntime(gLogger);
}

void Runtime_destroy(IRuntime* runtime) {
  runtime->destroy();
}

ICudaEngine* Runtime_createEngine(IRuntime* runtime, const void* plan, size_t size) {
  return runtime->deserializeCudaEngine(plan, size, nullptr);
}

}
