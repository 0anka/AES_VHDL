-----------------------------------------------------------------------------------                 
Introduction                                                                                     
-----------------------------------------------------------------------------------
AES is the implementation of AES-128, 192, and 256 general encryption standards
based on the Rijndael papers from NIST, which is essentially encryption into 
ciphertext. Yeah, I spent too much time on this—honestly, as a lazy math nerd.
So one day I decided, why not write the program itself based on these papers?
As a math nerd, my brain was astonished as I explored how AES is implemented
according to the Rijndael papers. Right now, it works only for big-endian systems.

-----------------------------------------------------------------------------------                  
Maths behind it !                                                                                     
-----------------------------------------------------------------------------------
Well its interesting to find that how GALOIS FIELD work. I spend hours that how
its working. Ok, now its gonna be interesting that how in computers we implement
the GALOIS FIELD magic. Ok, lets think about a BYTE which is consist of 8 bits.
A BYTE 0 <= BYTE <= 255 can be fall in this range like BYTE [0,255] included.
Since BYTE is 8 bit, so number of posible element is like 2^8 which is 256.
So 0..255 is the number of possible element.

Lets take an example. Suppose BYTE is a sample space which contain any of the
value between 0..255 like BYTE range would be [0,255].

BYTE(s)={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
21,22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103,
104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154,
155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171,
172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188,
189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222,
223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255}

s -> sample space

Now in GALOIS FIELD we denote GF(P^n) -> for any prime number p and positive integer
n, there exist a GALOIS FIELD which has the same possible number of elements, which
is P^n. For example, if s is the sample space and p = 2, n = 1, then required is 
GF(2^1) and 2^1. Then the range of s is [0,1] or s = {0,1}. And in GALOIS FIELD, we
have our own rules of Addition, Subtraction, Multiplication, and Division, which we
will talk about later in this README.txt.

Now you are thinking, ok we understood the GALOIS FIELD, now what’s up with computers?
That’s why it’s taken on RIJNDAEL Papers. What’s the logic behind it? I was thinking,
unless I read the docs. As you remember, earlier we talked about BYTES, that 8-bit unit
in computers. Now listen carefully — here’s the interesting path: what if I tell you 
that GF(2^8) has the same possible number of elements that a BYTE could! Oh lord yes,
it is. Now the range is defined as BYTE [0,255], and GF(2^8) range is the same [0..255].

GF(2^8)(s)={0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
21,22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103,
104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154,
155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171,
172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188,
189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222,
223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255}

Now we understand that the BYTE we were taking in the RIJNDAEL papers is that part 
of GALOIS FIELD.
=========================================================================================
Now begin with the third part. Ok, now we know BYTE are one of the elements of GALOIS
FIELD. It means we were in the world of GF, and GF is the creator of the maths universe
with their rules like addition, subtraction, etc. Ok, fine, let’s tackle this. Ok, we
know individual bits make a BYTE, so what’s the number of bits in a BYTE? Is it 8? It is.

Let’s take B as a BYTE and {b7, b6, b5, b4, b3, b2, b1, b0} be bits of BYTE, with MSB = b7
and LSB = b0, such that there is a polynomial:
p(x)=b7·x^7 + b6·x^6 + b5·x^5 + b4·x^4 + b3·x^3 + b2·x^2 + b1·x^1 + b0.x^0
where each bit is the coefficient of the respective power of x, and all bits belong to the
sample space s, such that s = GF(2). Therefore, s = {0,1}. It means a bit is either 0 or 1.
In other words, in computers it makes sense, so that’s why each coefficient belongs to GF(2).
For example, let’s take {0x53}. Now if I want to express it as a polynomial p(x) according 
to the rule then: p(x)=x^5+x^4+x^2+1; According to the polynomial, b0 = 1, b1 = 0, b2 = 1, 
b3 = 0, b4 = 1, b5 = 1, b6 = 0, b7 = 0, which is {00110101}.

------------------------------------------------------------------------------------------
Mathematical operation
------------------------------------------------------------------------------------------

So for addition (+) in GALOIS FIELD, if two polynomials p(x) and h(x) represent a BYTE,
then addition would be XOR (^) — do not just add the polynomials, since GF is the boss.
Now its rule is applied in his world, so we have to think in that way. And yeah, as a
maths nerd, you will ask: ok, why would XOR be chosen for addition, why not (& or |)
? So hear me out.

Certain rules in a Galois Field GF(2): addition has to satisfy field properties:

Closure: a + b ∈ {0,1}
Associativity: (a + b) + c = a + (b + c)
Commutativity: a + b = b + a
Additive identity: a + 0 = a
Additive inverse: a + a = 0

Now you can get it.

So for example:
{0x53}^{0xca}={0x99}
============================================================================================
Now, think — it works differently in multiplication. So for multiplication in GALOIS FIELD,
let two BYTEs A and B have a product P such that:
              A.B=P modj(x) and J(x)= x^8+x^4+x^3+x^1+1
And in Multipicative inverse if A.B=1mod j(x) then A is B^-1
              so B^-1.B=1 mod j(x)
HOW do we find the multiplication in GALOIS FIELD? So here’s the catch: we need to use a 
famous algorithm called the Russian Peasant Algorithm. With this algorithm, we can find P,
and in the special case if P = 1, then you can find the multiplicative inverse. So it is
the most important part of the algorithm. You can check out the Wikipedia link.
=============================================================================================
LRM - IEEE 1076 2000 IEEE std_logic_1164 IEEE 1076.6 TI-EXPLANATION OF SYMBOLS AES-DOCS
=============================================================================================

--------------------------------------------------------------------------------------------- 
https://edg.uchicago.edu/~tang/VHDLref.pdf
---------------------------------------------------------------------------------------------
https://0x04.net/~mwk/vstd/ieee-1164-1993.pdf
---------------------------------------------------------------------------------------------
http://mems.ece.dal.ca/eced4260/IEEE1076.pdf
---------------------------------------------------------------------------------------------
https://www.ti.com/lit/ml/sdyz001a/sdyz001a.pdf
--------------------------------------------------------------------------------------------
https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf
--------------------------------------------------------------------------------------------
https://en.wikipedia.org/wiki/Finite_field_arithmetic
--------------------------------------------------------------------------------------------

=============================================================================================
