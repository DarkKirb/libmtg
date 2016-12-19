#pragma once
#include "base_exception.hpp"
namespace mtg {
class OutOfMemoryException: public Exception {
  public:
    OutOfMemoryException(): Exception() {} //TODO Add text
    ~OutOfMemoryException() {}
};
}
