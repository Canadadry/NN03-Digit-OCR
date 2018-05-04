Decode = {}


function Decode.uint8 (str, ofs)
    ofs = ofs or 0
    return string.byte(str, ofs + 1)
end

function Decode.uint16(str, ofs)
    ofs = ofs or 0
    local a, b = string.byte(str, ofs + 1, ofs + 2)
    return b + a * 0x100
end

function Decode.uint32(str, ofs)
    ofs = ofs or 0
    local a, b, c, d = string.byte(str, ofs + 1, ofs + 4)
    return d + c * 0x100 + b * 0x10000 + a * 0x1000000
end

