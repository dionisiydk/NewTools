"
I am a StDebugger extension for scripting the developer's debugging session.
I provides ways to:
- write a live script directly in the debugger (and affecting the debug session)
- save/load scripts
- create debugging commands from scripts

My owner must be a spec debugger
"
Class {
	#name : #StSindarinDebuggerScriptingPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'code',
		'resultInspection',
		'toolbar',
		'sindarinDebugger',
		'stDebugger'
	],
	#category : #'NewTools-Sindarin-Tools'
}

{ #category : #specs }
StSindarinDebuggerScriptingPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolbar expand: false fill: false padding: 0;
		add: #code;
		add: 'Result (right click to see more...)' expand: false fill: false padding: 5;
		add: #resultInspection;
		yourself
]

{ #category : #specs }
StSindarinDebuggerScriptingPresenter class >> extendedDebuggingToolTitle [
	<debuggerExtensionPresentationOrder: -1>
	^ 'Sindarin'
]

{ #category : #actions }
StSindarinDebuggerScriptingPresenter >> createCommandFromScript [
	self flag: 'todo'
]

{ #category : #accessing }
StSindarinDebuggerScriptingPresenter >> debugger [ 
	^stDebugger
]

{ #category : #actions }
StSindarinDebuggerScriptingPresenter >> executeScript [
	|scriptString|
	scriptString := code text.
	self debugger removeSessionHolderSubscriptions.
	
	OpalCompiler new
		bindings: { #sindarin -> (self sindarin) }	asDictionary;
		evaluate: scriptString.
		
	self debugger setSessionHolderSubscriptions. 
	self debugger forceSessionUpdate
	
]

{ #category : #initialization }
StSindarinDebuggerScriptingPresenter >> initializePresenters [
	code := self newCode.
	code syntaxHighlight: true.
	code autoAccept: true.
	code acceptBlock: [ :txt |  ].
	"code contextMenu: [  ]."
	code text: 'sindarin stepOver'.
	resultInspection := nil rawInspection.
	self initializeToolbar
]

{ #category : #initialization }
StSindarinDebuggerScriptingPresenter >> initializeToolbar [
	toolbar := self newToolBar.
	toolbar beIcons.
	SpToolBarPresenterBuilder new
		toolbarPresenter: toolbar;
		visit: self toolbarActions
]

{ #category : #actions }
StSindarinDebuggerScriptingPresenter >> loadScript [
	self flag: 'todo'
]

{ #category : #actions }
StSindarinDebuggerScriptingPresenter >> removeScriptCommand [
	self flag: 'todo'
]

{ #category : #actions }
StSindarinDebuggerScriptingPresenter >> saveScript [
	self flag: 'todo'
]

{ #category : #accessing }
StSindarinDebuggerScriptingPresenter >> setModelBeforeInitialization: aStDebugger [
	"My original model is the debugger presenter that I extend"
	stDebugger := aStDebugger.
	sindarinDebugger := aStDebugger sindarinDebugger
]

{ #category : #accessing }
StSindarinDebuggerScriptingPresenter >> sindarin [
	^sindarinDebugger 
]

{ #category : #building }
StSindarinDebuggerScriptingPresenter >> toolbarActions [
	| group |
	group := (CmCommandGroup named: 'Toolbar') asSpecGroup.
	
	group register: (SindarinRunScriptCommand forSpecContext: self).
	group register: (SindarinSaveScriptCommand forSpecContext: self).
	group register: (SindarinLoadScriptCommand forSpecContext: self).
	group register: (SindarinCreateCommandFromScriptCommand forSpecContext: self).
	group register: (SindarinRemoveCommandCommand forSpecContext: self).
	group register: (StInspectorHelpCommand forSpecContext: self).

	
	^ group
]