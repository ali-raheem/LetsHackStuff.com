#!/usr/bin/python
import hashlib
hash = hashlib.sha512()
hash.update(raw_input('Username: '))
hash.update(raw_input('Password: '))
key = hash.hexdigest()
print key

hash = hashlib.sha512()
hash.update(key)
hash.update(raw_input('challenge: '))
print hash.hexdigest()[0:10]
