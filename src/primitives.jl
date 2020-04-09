"""
    ror(x, k)
    
rotate x to the right (msbs toward lsb) by k bits (lsbs wrap to msbs)
""" ror

"""
    rol(x, k)
    
rotate x to the left (lsbs toward msb) by k bits (msbs wrap to lsbs)
""" rol

ror(x::UInt32, k::Int) = (x >>> (0x1f & k)) | (x <<  (0x1f & -k))
rol(x::UInt32, k::Int) = (x <<  (0x1f & k)) | (x >>> (0x1f & -k))
ror(x::UInt64, k::Int) = (x >>> (0x3f & k)) | (x <<  (0x3f & -k))
rol(x::UInt64, k::Int) = (x <<  (0x3f & k)) | (x >>> (0x3f & -k))

ror(x::Int32, k::Int) = (x >>> (0x1f & k)) | (x <<  (0x1f & -k))
rol(x::Int32, k::Int) = (x <<  (0x1f & k)) | (x >>> (0x1f & -k))
ror(x::Int64, k::Int) = (x >>> (0x3f & k)) | (x <<  (0x3f & -k))
rol(x::Int64, k::Int) = (x <<  (0x3f & k)) | (x >>> (0x3f & -k))
