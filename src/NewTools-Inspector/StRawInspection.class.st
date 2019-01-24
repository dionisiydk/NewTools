Class {
	#name : #StRawInspection,
	#superclass : #StInspection,
	#instVars : [
		'attributeTable'
	],
	#category : #'NewTools-Inspector-View'
}

{ #category : #specs }
StRawInspection class >> defaultSpec [

	^ SpecBoxLayout newVertical 
		add: #attributeTable;
		yourself
]

{ #category : #initialization }
StRawInspection >> initialize [ 

	super initialize.
	self title: 'Raw'
]

{ #category : #initialization }
StRawInspection >> initializeWidgets [
	
	attributeTable := self newTreeTable.
	attributeTable
		addColumn: (CompositeTableColumn new  
			title: 'Variable';
			width: 170;
			addColumn: (ImageTableColumn new
				width: 20;
				evaluated: #icon;
				yourself);
			addColumn: (StringTableColumn new
				evaluated: #label;
				yourself);
			yourself);
		addColumn: (StringTableColumn new
			title: 'Value';
			evaluated: #stringValue;
			beEditable;
			onAcceptEdition: [ :node :value | self inform: node label, '=', value asString "node value: value" ];
			yourself).
			
	attributeTable 
		roots: self model allInspectorNodes;
		children: [ :node | node children ]
]