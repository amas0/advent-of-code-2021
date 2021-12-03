from dataclasses import dataclass


@dataclass
class Vec:
    h: int
    d: int

    def __add__(x, y):
        return Vec(x.h + y.h, x.d + y.d)


def to_vec(ln):
    d, n = ln.split()
    if d[0] == 'f':
        return Vec(int(n), 0)
    else:
        return Vec(0, int(n)) if d[0] == 'd' else Vec(0, -int(n))


pos = sum((to_vec(ln) for ln in open('input_2_1.txt')), Vec(0, 0))
print(pos.h*pos.d)
