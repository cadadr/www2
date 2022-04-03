title="cadadr‽"
language="en"

# What even is `cadadr`?

`cadadr` is a function/macro found in many so-called "dialects" of the
[Lisp programming language][lisp]. It's documentation in the [Common
Lisp][cl] [standard (termed the *HyperSpec*][cls] can be found
[here][cxr], with even more details in [the section 14.1.1 of the
*HyperSpec*][1411].

[lisp]: https://en.wikipedia.org/wiki/Lisp_(programming_language)
[cl]: https://en.wikipedia.org/wiki/Common_Lisp
[cls]: https://en.wikipedia.org/wiki/Common_Lisp_HyperSpec
[cxr]: http://www.lispworks.com/documentation/HyperSpec/Body/f_car_c.htm#cadadr
[1411]: http://www.lispworks.com/documentation/HyperSpec/Body/14_aa.htm

# Pronunciation

I pronounce it approximately as *kadadır* in Turkish and as
*kuh-DAHDR* in English.

# Details and history

Explained simply, in most Lisps, `car` is an operator that returns the
first element on a list, and `cdr` is the complementary operator which
returns the rest of the list. Then, there are a bunch of related
operators that start with the letter `c`, continues with a mixed string
of `a`s and `d`s, and ends with an `r`. Each `a` or `d` stands for an
instance of a `car` or a `cdr` respectively, so `cadadr` in particular
is equivalent to `(car (cdr (car (cdr <some-list>))))`, which means *the
car of the cdr of the car of the cdr* of a list.

It is not very useful practically, and in general it's not very
advisable to use these `cxx+r` family of functions, as they are somewhat
cryptic; but they are relevant as part of what we can call the Lisp
culture. I personally like Lisps, [Emacs Lisp][el] and Common Lisp in
particular, so I picked one of these operators which were easier to
pronounce as an internet nickname.

# Other users

Another user of the same name seems to be [Alexey
Beshenov](https://cadadr.org/), with whom I have no contact. At the time
I picked the nickname I didn't know they used it as a domain name, and
when I found out, it was too late. Fortunately, they don't seem to use
it as a handle, so there's no conflict. Hey Alexey, if you ever happen
to encounter this page, sorry if I caused any inconveniences to you
regarding the name.

[el]: https://en.wikipedia.org/wiki/Emacs_Lisp
