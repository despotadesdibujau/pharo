"
This class collects simple demos for Reflectivity.

each method contains a small, self-contained demo.
"
Class {
	#name : #ReflectivityDemos,
	#superclass : #Object,
	#classVars : [
		'Link'
	],
	#category : #Reflectivity-Examples
}

{ #category : #cleanup }
ReflectivityDemos >> cleanUp [
	<script: 'self new cleanUp'>
	Link ifNotNil: [ :link | link uninstall. Link := nil ]
]

{ #category : #demos }
ReflectivityDemos >> demoSelfSendLogging [
	<script: 'self new demoSelfSendLogging'>
	
	"Running this method, Open first a Transcript and then the TabsExample.	
		
	Transcript open.
	TabsExample open.
	
	To clean up, run the #cleanUp script of this class.
	
	We use option #optionCompileOnLinkInstallation because we analyse the sender context
	and do not want to have the code generation be interering.
	"
	
	| theClass |
	theClass := TabsExample.
	Link := MetaLink new
		metaObject: [ :context :object | context sender receiver == object
				ifTrue: [ context crLog ] ];
		selector: #value:value:;
		option: #(+optionCompileOnLinkInstallation);
		arguments: #(context object);
		control: #before.
		
	theClass methods do: [ :each | each ast link: Link ].

]
