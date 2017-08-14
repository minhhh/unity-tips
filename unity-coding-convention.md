# Unity C# Coding Convention

This is a coding convention for the C# language targeting Unity platform. When there is conflicting style between C# and Unity's, then Unity's C# will take precedence.

## Table of Contents
- [Nomenclature](#nomenclature)
  + [Namespaces](#namespaces)
  + [Classes & Interfaces](#classes--interfaces)
  + [Methods](#methods)
  + [Fields](#fields)
  + [Parameters](#parameters--parameters)
  + [Delegates](#delegates--delegates)
  + [Events](#events--events)
  + [Misc](#misc)
- [Declarations](#declarations)
  + [Access Level Modifiers](#access-level-modifiers)
  + [Fields & Variables](#fields--variables)
  + [Classes](#classes)
  + [Interfaces](#interfaces)
- [Spacing](#spacing)
  + [Indentation](#indentation)
  + [Line Length](#line-length)
- [Brace Style](#brace-style)
- [Switch Statements](#switch-statements)
- [Language](#language)

## Nomenclature

On the whole, naming should follow C# standards with references taken from the Unity framework itself.

### Namespaces

Namespaces are all __UpperCamelCase__, multiple words concatenated together, without hypens or underscores:

__BAD__:

```c#
unityengine.scenemanagement
```

__GOOD__:

```c#
UnityEngine.SceneManagement
```

### Classes & Interfaces

Written in __UpperCamelCase__. For example `OnDemandResourcesRequest`.

### Methods

Public methods are written in __UpperCamelCase__. For example `LoadAsset`.

Private methods are written in __the same way as Public Methods__. Private method should always have `private` modifier instead of no modifier.

### Fields

Written in __lowerCamelCase__.

Static fields should be written in __UpperCamelCase__:

```c#
public static bool HasAction = false;
```

All non-static fields are written __lowerCamelCase__. Per Unity convention, this includes __public fields__ as well.

For example:

```C#
public class RemoteNotification {
    public string alertBody;
    private int applicationIconBadgeNumber;
    protected bool hasAction;
}
```

### Parameters

Parameters are written in __lowerCamelCase__.

__BAD:__

```c#
public bool CompareTag(string Tag);
```

__GOOD:__

```c#
public bool CompareTag(string tag);
```

Single character values to be avoided except for temporary looping variables.

### Delegates

Delegats are written in __UpperCamelCase__.

When declaring delegates, DO add the suffix __EventHandler__ to names of delegates that are used in events.

__BAD:__

```c#
public delegate void Click()
```
__GOOD:__

```c#
public delegate void ClickEventHandler()
```

DO add the suffix __Callback__ to names of delegates used as callback.

__BAD:__

```c#
public delegate void Render()
```
__GOOD:__

```c#
public delegate void RenderCallback()
```

Other delegates can have names like a normal function.

### Events

Prefix event methods with the prefix __On__.

__BAD:__

```c#
public static event CloseCallback Close;
```
__GOOD:__

```c#
public static event CloseCallback OnClose;
```

### Misc

In code, acronyms should be kept intact in most cases.

__BAD:__

```c#
WWW.EscapeUrl
GetInstanceId
```

__GOOD:__

```c#
WWW.EscapeURL
GetInstanceID
```

## Declarations

### Access Level Modifiers

Access level modifiers should be explicitly defined for classes, methods and member variables.

### Fields & Variables

Prefer single declaration per line.

__BAD:__

```c#

string hideFlags, name;
```

__GOOD:__

```c#
string hideFlags;
string name;
```

### Classes

Exactly one class per source file, although inner classes are encouraged where scoping appropriate.

### Interfaces

All interfaces should be prefaced with the letter __I__.

__BAD:__

```c#
Clippable
```

__GOOD:__

```c#
IClippable
```

## Spacing

### Indentation

Indentation is 4 spaces. Never tabs.

#### Line Wraps

Indentation for line wraps should use 4 spaces too.

DO NOT align arguments at the far right side of the line. It's not a sustainable way since it depends on the left part of the statement such as method names, variables names

__BAD:__

```c#
public int AMethod (int firstArgument,
                    int secondArgument)

public int AMethod (int firstArgument,
    int secondArgument)

int result = Calculate (firstArgument,
                        secondArgument);

int result = Calculate (
    firstArgument,
    secondArgument);
```

__GOOD:__

```c#
public int AMethod (
    int firstArgument,
    int secondArgument)

public int AMethod (
    int firstArgument, int secondArgument)

int result =
    Calculate (
        firstArgument,
        secondArgument);

int result =
    Calculate (
        firstArgument,
        secondArgument
    );
```

### Line Length

Lines should not be too long, ideally shorter than 100 characters.


## Brace Style

Use a convention and stick to it, do not need to invent your own.

Use a linter such as `astyle` and use its automatic code format so you don't need to format code manually.

## Switch Statements

Do not use fall-through behavior. Always include the `default` case.

## Language

Use US English spelling.

__BAD:__

```c#
string colour = "red";
```

__GOOD:__

```c#
string color = "red";
```

## Reference
* [C# Style Guide](https://github.com/raywenderlich/c-sharp-style-guide)
* [Internal Coding Guidelines](https://blogs.msdn.microsoft.com/brada/2005/01/26/internal-coding-guidelines/)

