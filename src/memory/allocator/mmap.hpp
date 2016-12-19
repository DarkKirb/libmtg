#pragma once
#include <exception/outOfMemory.hpp>
#include <sys/mman.h>
// Thin wrapper around mmap(2)
namespace mtg {
class MMAP {
public:
  MMAP();
  ~MMAP();
  auto map(void *addr, size_t length) -> void; //Throws OutOfMemoryException
  auto free(void *addr, size_t length) -> void;
  auto alloc(size_t length) -> void *; //Throws OutOfMemoryException
};
}
