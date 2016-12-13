# UNITY TIPS, TRICKS AND BEST PRACTICES
Tips, tricks and best practices for working with Unity.

## Process
**Avoid branching assets**. There should always only ever be one version of any asset. If you absolutely have to branch a prefab, scene, or mesh, follow a process that makes it very clear which is the right version. The "wrong" branch should have a funky name, for example, use a double underscore prefix: `__MainScene_Backup`.

<br/>

**Each team member should have a second copy of the project checked out for testing** if you are using version control. After changes, this second copy, the clean copy, should be updated and tested. No-one should make any changes to their clean copies. This is especially useful to catch missing assets.

<br/>

**Consider saving levels in data instead of in scenes**. If you have many levels, it makes senses to have a standard text format for those level data. You might want to use external level tools or create your own in Unity. The advantages are:

* It makes it unnecessary to re-setup each scene.
* It makes it easier to merge scenes
* It makes it easier to change all levels according to specific rules.

<br/>

**Consider writing generic custom inspector code**. To write custom inspectors is fairly straightforward, but Unity’s system has many drawbacks:

* It does not support taking advantage of inheritance.
* It does not let you define inspector components on a field-type level, only a class-type level. For instance, if every game object has a field of type SomeCoolType, which you want rendered differently in the inspector, you have to write inspectors for all your classes.


## Scene Organization
**Use named empty game objects as scene folders**. Carefully organize your scenes to make it easy to find objects.

<br/>

**Put maintenance prefabs and folders (empty game objects) at 0 0 0**. If a transform is not specifically used to position an object, it should be at the origin. That way, there is less danger of running into problems with local and world space, and code is generally simpler.

<br/>

**Minimise using offsets for GUI components**. Offsets should always be used to layout components in their parent component only; they should not rely on the positioning of their grandparents. Offsets should not cancel each other out to display correctly. It is basically to prevent this kind of thing:

<br/>

**Put your world floor at y = 0**. This makes it easier to put objects on the floor, and treat the world as a 2D space (when appropriate) for game logic, AI, and physics.

<br/>

**Make the game runnable from every scene**. This drastically reduces testing time. To make all scenes runnable you need to do two things:

* First, provide a way to mock up any data that is required from previously loaded scenes if it is not available.
* Second, spawn objects that must persist between scene loads with the following idiom:

```
myObject = FindMyObjectInScene();

if (myObjet == null)
{
    myObject = SpawnMyObject();
}
```

## Art
**Put character and standing object pivots at the base, not in the centre**. This makes it easy to put characters and objects on the floor precisely. It also makes it easier to work with 3D as if it is 2D for game logic, AI, and even physics when appropriate.

<br/>

**Make all meshes face in the same direction (positive or negative z axis)**. This applies to meshes such as characters and other objects that have a concept of facing direction. Many algorithms are simplified if everything have the same facing direction

<br/>

**Get the scale right from the beginning**. Make art so that they can all be imported at a scale factor of 1, and that their transforms can be scaled 1, 1, 1. Use a reference object (a Unity cube) to make scale comparisons easy. Choose a world to Unity units ratio suitable for your game, and stick to it.

<br/>

**Make a two-poly plane to use for GUI components and manually created particles**. Make the plane face the positive z-axis for easy billboarding and easy GUI building.

<br/>

**Make and use test art**

* Squares labelled for skyboxes.
* A grid.
* Various flat colours for shader testing: white, black, 50% grey, red, green, blue, magenta, yellow, cyan.
Gradients for shader testing: black to white, red to green, red to blue, green to blue.
* Black and white checkerboard.
* Smooth and rugged normal maps.
* A lighting rig (as prefab) for quickly setting up test scenes.

## Prefabs

**Use prefabs for everything**. The only game objects in your scene that should not be prefabs should be folders. Even unique objects that are used only once should be prefabs. This makes it easier to make changes that don’t require the scene to change. (An additional benefit is that it makes building sprite atlases reliable when using EZGUI).

<br/>

**Use separate prefabs for specialisation; do not specialise instances**. If you have two enemy types, and they only differ by their properties, make separate prefabs for the properties, and link them in. This makes it possible to

* make changes to each type in one place
* make changes without having to change the scene.

If you have too many enemy types, specialisation should still not be made in instances in the editor. One alternative is to do it procedurally, or using a central file / prefab for all enemies. A single drop down could be used to differentiate enemies, or an algorithm based on enemy position or player progress.

<br/>

**Link prefabs to prefabs; do not link instances to instances.** Links to prefabs are maintained when dropping a prefab into a scene; links to instances are not. Linking to prefabs whenever possible reduces scene setup, and reduce the need to change scenes.

<br/>

**As far as possible, establish links between instances automatically.** If you need to link instances, establish the links programmatically. For example, the player prefab can register itself with the GameManager when it starts, or the GameManager can find the Player prefab instance when it starts.

<br/>

**Don’t put meshes at the roots of prefabs if you want to add other scripts.** When you make the prefab from a mesh, first parent the mesh to an empty game object, and make that the root. Put scripts on the root, not on the mesh node. That way it is much easier to replace the mesh with another mesh without loosing any values that you set up in the inspector.

<br/>

**Use linked prefabs as an alternative to nested prefabs.** Unity does not support nested prefabs, and existing third-party solutions can be dangerous when working in a team because the relationship between nested prefabs is not obvious.

<br/>

**Use safe processes to branch prefabs**. The explanation use the Player prefab as an example.

Make a risky change to the Player prefab is as follows:

1. Duplicate the Player prefab.
1. Rename the duplicate to `__Player_Backup`.
1. Make changes to the Player prefab.
1. If everything works, delete `__Player_Backup`.

Do not name the duplicate `Player_New`, and make changes to it!

Some situations are more complicated. For example, a certain change may involve two people, and following the above process may break the working scene for everyone until person two finished. If it is quick enough, still follow the process above. For changes that take longer, the following process can be followed:

1. Person 1:
    1. Duplicate the Player prefab.
    1. Rename it to `__Player_WithNewFeature` or `__Player_ForPerson2`.
    1. Make changes on the duplicate, and commit/give to Person 2.
1. Person 2:
    1. Make changes to new prefab.
    1. Duplicate Player prefab, and call it `__Player_Backup`.
    1. Drag an instance of `__Player_WithNewFeature` into the scene.
    1. Drag the instance onto the original Player prefab.
    1. If everything works, delete `__Player_Backup` and `__Player_WithNewFeature`.

## Time
**Maintain your own time class to make pausing easier**. Wrap `Time.DeltaTime` and `Time.TimeSinceLevelLoad` to account for pausing and time scale. It requires discipline to use it, but will make things a lot easier, especially when running things of different clocks (such as interface animations and game animations).

## Optimization
**Use object pool**

## Editor Setting
* `Edit > Project Settings > Editor`
    * `Asset Serialization` > `Force Text`


# REFERENCES
* http://www.glenstevens.ca/unity3d-best-practices/#Process
* http://devmag.org.za/2012/07/12/50-tips-for-working-with-unity-best-practices/
* http://unitytip.com/
