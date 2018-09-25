// @nogc:
// extern (C):
/*
  https://defuse.ca/online-x86-assembler.htm
  http://herumi.in.coocan.jp/prog/x64.html
 */
import std.stdio;
import core.stdc.stdio;
import core.stdc.string;

/// https://linuxjm.osdn.jp/html/LDP_man-pages/man2/mmap.2.html
struct ExecutableMemory {
    import core.sys.posix.sys.mman;

    private ubyte* _ptr; // disable assign
    const size_t length;

    @disable this(this);
    @disable new(size_t);

    this(size_t len) {
        this._ptr = cast(ubyte*) mmap(null, len,
                                      PROT_EXEC | PROT_READ | PROT_WRITE,
                                      MAP_PRIVATE | MAP_ANON, -1, 0);
        this.length = len;
    }

    this(ubyte[] bytes) {
        this(bytes.length);
        this.ptr[0..bytes.length] = bytes;
    }

    this(size_t N)(uint[N] bytes...) {
        this(bytes.length);
        static foreach (n; 0 .. N) {
            this.ptr[n] = cast(ubyte) bytes[n];
        }
    }

    auto ptr() {
        return this._ptr;
    }

    ~this() {
        munmap(this._ptr, this.length);
    }
}

extern(C)
ulong test_f(ulong a, ulong b) {
    return a + b;
}

/// test add function
unittest {
    // https://docs.oracle.com/cd/E19253-01/819-0389/fcowb/index.html
    // https://ja.wikipedia.org/wiki/%E5%91%BC%E5%87%BA%E8%A6%8F%E7%B4%84#cdecl
    auto mem = ExecutableMemory(
        0x48, 0x89, 0xF8, // mov rax, rdi
        0x48, 0x01, 0xF0, // add rax, rsi
        0xC3              // ret
        );
    auto fun = cast(ulong function(ulong, ulong)) mem.ptr;
    assert(fun(11, 31) == 42);
}

void main() {
    
}
