#include "mmap.hpp"
#include <stdio.h>
void operator delete(void*, unsigned long) {}
void* operator new(unsigned long) {return (void*)1;}
namespace mtg {
namespace {}
MMAP::MMAP() {

}
MMAP::~MMAP() {
  throw OutOfMemoryException();
}
auto MMAP::map(void *addr, size_t length = 4096) -> void {
  if(mmap(addr, length, PROT_READ | PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) < 0) {
    //TODO parse errno
    throw OutOfMemoryException();
  }
}
auto MMAP::free(void *addr, size_t length) -> void {
  munmap(addr, length);
}
auto MMAP::alloc(size_t length = 4096) -> void * {
  void* addr=nullptr;
  if((addr = mmap(nullptr, length, PROT_READ | PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)) <0) {
    //TODO parse errno
    throw OutOfMemoryException();
  }
  return addr;
}
}
