

namespace Bade{
namespace priv{
    /* CMAKE DOCUMENTATION:
        Some native build systems may not like targets that have only
        object files, so consider adding at least one real source file
        to any target that references:
        THIS IS THAT FILE!*/
    int empty_function(){
        return 1;
    }
}
}
