# Brainfuck-on-CMake - CMake Brainfuck Interpreter

An advanced **Brainfuck** interpreter written entirely in the declarative **CMake** scripting language

> Made just for fun, don't take it too seriously - the entire codebase is pure spaghetti! :3

![](https://github.com/zamirdefis/Brainfuck-on-CMake/blob/main/res/imgs/screenshot.png)

---

## ✨ Features

* **Debugger** - Breakpoint-based debugging support
* **Memory Viewer** - Visualization of the memory tape
* **Code Execution Viewer** - Tracks currently executing code instructions
* **Cell Trace** - Smart highlighting of recently accessed memory cells

---

## ⚙️ Launch Parameters

Control the interpreter by passing configuration flags (`-DParameter=Value`) when invoking the CMake

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `code` | `string` | The Brainfuck code string to execute. Used by default if `source` is not specified |
| `source` | `path` | Path to the file containing the source code. If specified, the `code` parameter is completely ignored |
| `input` | `string` | Input buffer (data for the `,` command). If the buffer size is less than the number of input requests, the program terminates with an `Input overflow` error |
| `size` | `number` | The size of the allocated memory tape (number of cells). Default: `256` |
| `memory_view` | `string`/`OFF` | Configures the memory visualization window<br>• `dynamic` - show only accessed cells<br>• `123` (number) - static display of exactly the specified number of cells<br>• `OFF` - completely disable memory visualization |
| `code_view` | `ON`/`OFF` | Enables/disables the display of the currently executed code |
| `cell_trace` | `ON`/`OFF` | Enables smart highlighting of the last 4 memory cells |
| `debug` | `string` | Enables breakpoint debugging mode (using the `B` character)<br>• If set to `drop`, the very first `B` breakpoint encountered completely halts execution and prints a dump<br>• **Auto-settings:** If `debug` is enabled but `memory_view`, `code_view`, or `cell_trace` are not explicitly defined, they automatically switch to `dynamic`, `ON`, and `ON` modes, respectively |

---

## 🚀 How to Use

Navigate to the `src/` directory and run the `./make.sh` script, providing your required launch parameters

If you prefer to run it without the helper script, you can invoke CMake directly:
```sh
cmake -G "Ninja Multi-Config" -S <path_to_interpreter_src> -B <path_to_build_dir> <your_parameters>
# Note: You can omit -B, but CMake will dump all of its build files into the current directory
# Note 2 : Also, your path to -Dsource="" will be relative to the interpreter's directory
```

### Examples
```sh
./make.sh -Dcode="+>++>+++>++++>+B-->++B+,.>,.>,.>-" -Ddebug=ON -Dmemory_view=dynamic -Dsize=17 -Dinput=">w< owo" -Dcell_trace=ON
```

```sh
cmake -G "Ninja Multi-Config" -S src/ -B build/ -Dsource="../examples/char.bf" -Dmemory_view=20
```

_You can also try running the demonstration scripts located in the `examples/` directory_

---

## 💡 Important Notes & Quirks

* **Memory Pointer:** In the memory viewer, the `>` and `<` symbols point to the currently active cell
* **Code View Execution:** The `code_view` tool displays the last 20 characters of the code. The number at the end indicates the current execution index (which factors in special characters)
* **Cell Tracing Colors:** The cell tracer uses distinct colors to highlight only the last 4 cells:
  * Yellow - most recent cell
  * Green - second most recent cell
  * Cyan - third most recent cell
  * Gray - fourth most recent cell
* **Breakpoints:** Don't forget that in debug mode, the `B` character is treated as an explicit breakpoint
* **Performance:** Do *not* try running heavy or complex Brainfuck programs. You will likely grow old before they finish executing - this interpreter is absolutely not optimized for high-speed execution! :P
* **Portability:** The interpreter relies heavily on its modular structure. Aside from `CMakeLists.txt`, it requires the accompanying `*.cmake` modules to function properly. Keep this in mind if you decide to move files around

---

## 🛠 Requirements

* **CMake 3.25** or higher 
* **Skirt** and **fluffy tail** _(optional)_
