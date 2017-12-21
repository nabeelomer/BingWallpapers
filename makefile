macos:
	clang++ app/Cocoa-Calls.m -framework Cocoa -fobjc-arc -fmodules -mmacosx-version-min=10.13 -o Cocoa-Calls.o -c
	stack build --ghc-options Cocoa-Calls.o

ubuntu:
	stack build