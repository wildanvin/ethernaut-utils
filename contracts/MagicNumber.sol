// SPDX-License-Identifier: GPL-3.0

object "Simple" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))        
    }

    object "runtime" {
        
        code {
            mstore(0x00, 42)
            return(0x00, 0x20)
        }
    }
}
