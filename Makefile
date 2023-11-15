all:
	ghc -dynamic ./sources/notify.hs -o notify
	cd sources && _cleaner haskell

	# ocamlopt ./sources/hesitate.ml -o hesitate
	# cd sources && _cleaner ocaml
