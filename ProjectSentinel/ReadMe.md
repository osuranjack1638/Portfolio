# Project Sentinel
Project Sentinel is a roblox system that checks your objects with different pre-set values and looks for bugs.

---

## Why Use Project Sentinel?
You should use Project Sentinel if you have suspicion that the object you want to test is getting an unintended value and crashing. This way, you can check the unintended values on your object to see which values they crash on and fix it.

---

## Handled Target Types And Check Types
The module can handle these target types that you want to check:
- function
- Object Oriented Programming(OOP) objects
- table
- BindableEvent
- RemoteEvent

The module checks your object with these types:
- Number
- Float
- String
- Boolean
- Instance
- Vector3
- Vector2
- CFrame
- Color3
- Table
- And any other type that you can add from the config file!

---

## How To Setup?
1. Create a `ModuleScript` named `ProjectSentinel` inside **ReplicatedStorage**.
2. Create a `ModuleScript` named `Config` inside the **ProjectSentinel** module.
3. Paste the contents of the modules.
4. Use it to test your functions, remote events etc.

---

## Extra
It is recommended that you put the function inside ServerStorage or somewhere that the client can not reach after use. Otherwise the client might try to bomb your remote events with the module and cause the server to lag.
