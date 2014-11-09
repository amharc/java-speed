Object subclass: Node [
	| key children |

	init [
		<category: 'initialization'>
		children := OrderedCollection new.
	]

	set: k [
		key := k.
		^key
	]

	top [
		^key
	]

	linkTo: other [
		(other = nil)
		ifTrue: [
			^self
		]
		ifFalse: [
			((self top) <= (other top))
			ifTrue: [
				children add: other.
				^self
			]
			ifFalse: [
				^other linkTo: self
			]
		]
	]

	mergeChildren [
		| tmp |

		tmp := OrderedCollection new.

		[ children size > 1 ]
			whileTrue: [
				| a b |
				a := children removeFirst.
				b := children removeFirst.
				tmp add: (a linkTo: b)
			].

		(children size > 0)
			ifTrue: [
				tmp add: (children first)
			].

		[ tmp size > 1 ]
			whileTrue: [
				| a b |
				a := tmp removeLast.
				b := tmp removeLast.
				tmp add: (a linkTo: b)
			].

		(tmp size = 0)
			ifTrue:
				[ ^nil ]
			ifFalse:
			  [ ^tmp first ]
	]

	printOn: stream [
		<category: 'printing'>
		super printOn: stream.
		stream nextPutAll: '('.
		key printOn: stream.
		stream nextPutAll: ', {'.
		children do: [ :each |
			each printOn: stream.
			stream nextPutAll: ' ' ].
		stream nextPutAll: '}) '
	]
]

Node class extend [
	new [
		| node |
		node := (super new).
		node init.
		^node
	]
]

Object subclass: Heap [
	| root |

	push: key [
		| n |
		n := Node new.
		n set: key.
		root := n linkTo: root
	]

	top [
		^root top
	]

	pop [
		root := root mergeChildren
	]

	printOn: stream [
		<category: 'printing'>
		super printOn: stream.
		stream nextPutAll: '('.
		(root = nil)
			ifFalse:
				[ root printOn: stream ].
		stream nextPutAll: ')'
	]
]


| line heap |
line := stdin nextLine.
heap := Heap new.
[ line = nil ]
	whileFalse:
		[ | cmds cmd |

			cmds := line subStrings: $ .
			cmd := cmds at: 1.
			(cmd = '0')
				ifTrue: [
					heap push: ((cmds at: 2) asNumber)
				]
				ifFalse: [
					(cmd = '1')
					ifTrue: [
						Transcript show: (heap top asString) ; nl
					]
					ifFalse: [
						heap pop
					]
				].
			line := stdin nextLine
		]
