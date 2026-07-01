Project Events

Project Events is a module that handles remote event usage and server script-to-server script communication for you using a simple unified API and software engineering principles.

* Memory Management: The module handles memory management for you and automatically prevents memory leaks.
* Toggleable Debugging: You can easily enable/disable debugging for your specific development needs.
* Version Control: The module automatically checks for new versions, but this can be disabled in the config.

How to setup?
1. Create a `ModuleScript` named **ProjectEvents** inside `ReplicatedStorage`.
2. Create a `ModuleScript` named **Config** inside the `ProjectEvents` module.
3. Copy and paste the content of the modules to where they belong.
4. Use it anywhere you want!

Functions:

ProjectEvents.Connect(EventName, CallbackFunction):


Connects the given CallbackFunction to the event named EventName.
Returns a connection object that you can easily disconnect using the ":Disconnect()" function.

ProjectEvents.Fire(EventName, SendToClient, Player, ...):


If called from the server, the following things happen:

If SendToClient is enabled and Player is given as an argument then the event with name EventName is fired to the Player client with the arguments (...).


If SendToClient is enabled but Player is not given, then the event with name EventName is fired to all clients that are listening with the arguments (...).


If SendToClient is not enabled then the event with name EventName is fired to all server scripts that are listening with the arguments (...).

If called from the client, the following thing happens:


(SendToClient and Player arguments don't have to be filled. They aren't used.)

The client fires the event named EventName to the server scripts that are listening to the event. It gives the Player that fired the event and (...) as the arguments.
