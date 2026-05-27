#include <stdio.h>
#include <cstdlib>
#include <cstdint>
#include <stdexcept>
#include <stack>

#define MEMORY_SIZE 256

class interpreter final {
private:
  uint8_t* memory_;
  const char* code_;
  bool check_closures_(void) const {
    int64_t layer = static_cast<decltype(layer)>(NULL);
    for (const char* ptr = code_; *ptr != '\0'; ++ptr) {
      if (*ptr == '[') {
        ++layer;
      } else if (*ptr == ']') {
        --layer;
      }
    }
    if (!layer) {
      return true;
    }
    return false;
  }
  [[gnu::always_inline]] inline void jump_over_(const char*& code_ptr) {
    size_t layer{static_cast<decltype(layer)>(NULL)};
    while (true) {
      ++code_ptr;
      if (*code_ptr == '[') {
        ++layer;
      } else if (*code_ptr == ']') {
        if (layer == 0b0u) {
          return;
        }
        --layer;
      }
    }
  }
public:
  interpreter(uint8_t* memory, const char* code) : memory_(memory), code_(code) {
    if (!memory_) {
      throw std::runtime_error("Null memory");
    } else if (!code) {
      throw std::runtime_error("Null code");
    }
  }
  bool interpret(void) {
    if (!check_closures_()) {
      return false;
    }
    std::stack<const char*> closures_stack;
    uint8_t* mem_ptr = memory_;
    for (const char* code_ptr = code_; *code_ptr != '\0'; ++code_ptr) {
      if (*code_ptr == '+') {
        ++(*mem_ptr);
      } else if (*code_ptr == '-') {
        --(*mem_ptr);
      } else if (*code_ptr == '>') {
        ++mem_ptr;
      } else if (*code_ptr == '<') {
        --mem_ptr;
      } else if (*code_ptr == '.') {
        putchar(*mem_ptr);
      } else if (*code_ptr == ',') {
        scanf("%c", mem_ptr); 
      } else if (*code_ptr == '[') {
        if (!*mem_ptr) {
          jump_over_(code_ptr);
          printf("%c\n", *code_ptr);
        } else {
          closures_stack.push(code_ptr);
        }
      } else if (*code_ptr == ']') {
        if (*mem_ptr) {
          code_ptr = closures_stack.top();
        } else {
          closures_stack.pop();
        }
      }
    }
    return true;
  }
  void print_mem(size_t size) {
    for (const uint8_t* ptr = memory_; ptr != memory_ + size; ++ptr) {
      printf("%X ", *ptr);
    }
  }
};



int main(void) {
  uint8_t memory[MEMORY_SIZE]{};
  char code[] = "] +++ ["; // BRUH
  interpreter itpr(memory, code);
  if (itpr.interpret()) {
    printf("\n");
    itpr.print_mem(1);
  } else {
    printf("BRUH! >_<\n");
  }
  return EXIT_SUCCESS;
}
