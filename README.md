# UNITY TIPS, TRICKS AND BEST PRACTICES

Tips, tricks and best practices for working with Unity.

## Good references of Unity best practices
* [Unity C# Coding Convention](https://github.com/minhhh/unity-tips/blob/master/unity-coding-convention.md)
* [Better Unity workflow with command line](http://minhhh.github.io/posts/better-unity-workflow-with-command-line)
* [Best Practices in Persisting Player Data on Mobile](http://minhhh.github.io/posts/best-practices-in-persisting-player-data-on-mobile)

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

## Extensions and MonoBehaviourBase
**Extend your own base mono behaviour, and derive all your components from it.** This allows you to implement some general functionality, such as type safe Invoke, and more complicated Invokes (such as random, etc.).

<br/>

**Use extensions to make syntax more convenient.**

## Idioms
**Avoid using different idioms to do the same thing**. In many cases there are more than one idiomatic way to do things. In such cases, choose one to use throughout the project. Here is why:

* Some idioms don’t work well together. Using one idiom well forces design in one direction that is not suitable for another idiom.
* Using the same idiom throughout makes it easier for team members to understand what is going on. It makes structure and code easier to understand. It makes mistakes harder to make.


## Time
**Maintain your own time class to make pausing easier**. Wrap `Time.DeltaTime` and `Time.TimeSinceLevelLoad` to account for pausing and time scale. It requires discipline to use it, but will make things a lot easier, especially when running things of different clocks (such as interface animations and game animations).


## Spawning Objects
**Don’t let spawned objects clutter your hierarchy when the game runs** Set their parents to a scene object to make it easier to find stuff when the game is running. You could use a empty game object, or even a singleton with no behaviour to make it easier to access from code.

## Class Design
**Use singletons for convenience**

<br/>

**For components, never make variables public that should not be tweaked in the inspector.** Otherwise it will be tweaked by a designer, especially if it is not clear what it does. If it seems unavoidable, use [HideInInspector] tag. Don’t set things to public to make them appear in the inspector. Only properties or members that you want to alter from outside your class should be public. Instead use the [SerializeField] (@SerializeField) attribute to make variables show in the inspector. If you have something that needs to be public but not designer editor then use [HideInInspector] (@HideInInspector). On the same note, don’t make things public just for the fun of it. The more public functions and member variables you have in a class, the more stuff shows up in the drop-down list when you try to access it. Keep it clean.

<br/>

**Separate interface from game logic. This is essentially the MVC pattern.**

Any input controller should only give commands to the appropriate components to let them know the controller has been invoked. For example in controller logic, the controller could decide which commands to give based on the player state. But this is bad (for example, it will lead to duplicate logic if more controllers are added). Instead, the Player object should be notified of the intent of moving forward, and then based on the current state (slowed or stunned, for example) set the speed and update the player facing direction. Controllers should only do things that relate to their own state (the controller does not change state if the player changes state; therefore, the controller should not know of the player state at all). Another example is the changing of weapons. The right way to do it is with a method on PlayerSwitchWeapon(Weapon newWeapon), which the GUI can call. The GUI should not manipulate transforms and parents and all that stuff.

Any interface component should only maintain data and do processing related to it’s own state. For example, to display a map, the GUI could compute what to display based on the player’s movements. However, this is game state data, and does not belong in the GUI. The GUI should merely display game state data, which should be maintained elsewhere. The map data should be maintained elsewhere (in the GameManager, for example).

Gameplay objects should know virtually nothing of the GUI. The one exception is the pause behaviour, which is may be controlled globally through Time.timeScale (which is not a good idea as well… see ). Gameplay objects should know if the game is paused. But that is all. Therefore, no links to GUI components from gameplay objects.

In general, if you delete all the GUI classes, the game should still compile.

You should also be able to re-implement the GUI and input without needing to write any new game logic.

<br/>

**Separate state and bookkeeping.** Bookkeeping variables are used for speed or convenience, and can be recovered from the state. By separating these, you make it easier to

* save the game state, and
* debug the game state.

One way to do it is to define a SaveData class for each game logic class. The

```
[Serializable]
PlayerSaveData
{
   public float health; //public for serialisation, not exposed in inspector
}

Player
{
   //... bookkeeping variables

   //Don’t expose state in inspector. State is not tweakable.
   private PlayerSaveData playerSaveData;
}
```

<br/>

**Don’t use strings for anything other than displayed text.** In particular, do not use strings for identifying objects or prefabs etc. One unfortunate exception is animations, which generally are accessed with their string names.

<br/>

**Avoid using public index-coupled arrays.** For instance, do not define an array of weapons, an array of bullets, and an array of particles , so that your code looks like this:

```
public void SelectWeapon(int index)
{
   currentWeaponIndex = index;
   Player.SwitchWeapon(weapons[currentWeapon]);
}

public void Shoot()
{
   Fire(bullets[currentWeapon]);
   FireParticles(particles[currentWeapon]);
}
```

The problem for this is not so much in the code, but rather setting it up in the inspector without making mistakes.

Rather, define a class that encapsulates the three variables, and make an array of that:

```
[Serializable]
public class Weapon
{
   public GameObject prefab;
   public ParticleSystem particles;
   public Bullet bullet;
}
```

The code looks neater, but most importantly, it is harder to make mistakes in setting up the data in the inspector.

<br/>

**Avoid using arrays for structure other than sequences.** For example, a player may have three types of attacks. Each uses the current weapon, but generates different bullets and different behaviour.

You may be tempted to dump the three bullets in an array, and then use this kind of logic:

```
public void FireAttack()
{
   /// behaviour
   Fire(bullets[0]);
}

public void IceAttack()
{
   /// behaviour
   Fire(bullets[1]);
}

public void WindAttack()
{
   /// behaviour
   Fire(bullets[2]);
}
```

Enums can make things look better in code

```
public void WindAttack()
{
   /// behaviour
   Fire(bullets[WeaponType.Wind]);
}
```

but not in the inspector.

It’s better to use separate variables so that the names help show which content to put in. Use a class to make it neat.

```
[Serializable]
public class Bullets
{
   public Bullet FireBullet;
   public Bullet IceBullet;
   public Bullet WindBullet;
}
```

This assumes there is no other Fire, Ice and Wind data.

<br/>

**Group data in serializable classes to make things neater in the inspector.** Some entities may have dozens of tweakables. It can become a nightmare to find the right variable in the inspector. To make things easier, follow these steps:

* Define separate classes for groups of variables. Make them public and serializable.
* In the primary class, define public variables of each type defined as above.
* Do not initialize these variables in Awake or Start; since they are serializable, Unity will take care of that.
* You can specify defaults as before by assigning values in the definition;

This will group variables in collapsible units in the inspector, which is easier to manage.

```
[Serializable]
public class MovementProperties //Not a MonoBehaviour!
{
   public float movementSpeed;
   public float turnSpeed = 1; //default provided
}

public class HealthProperties //Not a MonoBehaviour!
{
   public float maxHealth;
   public float regenerationRate;
}

public class Player : MonoBehaviour
{
   public MovementProperties movementProeprties;
   public HealthPorperties healthProeprties;
}
```

<br/>

**Tag/Layer**: One of the first things you should do is to create two static classes with your Tags and Classes so you don’t mess things up with upper/lower case problematic or use stuff like that from memory.

<br/>

**Tag/Layer**: When checking a tag use the method CompareTag on Component or GameObject.

## Text
**If you have a lot of story text, put it in a file**. Don’t put it in fields for editing in the inspector. Make it easy to change without having to open the Unity editor, and especially without having to save the scene.

<br/>

**If you plan to localise, separate all your strings to one location**. There are many ways to do this. One way is to define a Text class with a public string field for each string, with defaults set to English, for example. Other languages subclass this and re-initialize the fields with the language equivalents.

More sophisticated techniques (appropriate when the body of text is large and / or the number of languages is high) will read in a spread sheet and provide logic for selecting the right string based on the chosen language.

## Testing and Debugging
 **Implement a graphical logger to debug physics, animation, and AI**. This can make debugging considerably faster. See [here](http://devmag.org.za/2011/01/25/make-your-logs-interactive-and-squash-bugs-faster/)

<br/>

**Implement your own FPS counter**. Yup. No one knows what Unity’s FPS counter really measures, but it is not frame rate. Implement your own so that the number can correspond with intuition and visual inspection.

<br/>

**Implement shortcuts for taking screen shots**. Many bugs are visual, and are much easier to report when you can take a picture. The ideal system should maintain a counter in PlayerPrefs so that successive screenshots are not overwritten. The screenshots should be saved outside the project folder to avoid people from accidentally committing them to the repository.

<br/>

**Implement shortcuts for printing the player’s world position**. This makes it easy to report the position of bugs that occur in specific places in the world, which in turns makes it easier to debug.

<br/>

**Implement debug options for making testing easier**. Some examples:

* Unlock all items.
* Disable enemies.
* Disable GUI.
* Make player invincible.
* Disable all gameplay.

<br/>

**For teams that are small enough, make a prefab for each team member with debug options**. Put a user identifier in a file that is not committed, and is read when the game is run. This why:

* Team members do not commit their debug options by accident and affect everyone.
* Changing debug options don’t change the scene.

<br/>

**Maintain a scene with all gameplay elements**. For instance, a scene with all enemies, all objects you can interact with, etc. This makes it easy to test functionality without having to play too long.

<br/>

**Define constants for debug shortcut keys, and keep them in one place**. Debug keys are not normally (or conveniently) processed in a single location like the rest of the game input. To avoid shortcut key collisions, define constants in a central place. An alternative is to process all keys in one place regardless of whether it is a debug function or not. (The downside is that this class may need extra references to objects just for this).

## Documentation
**Document your setup**. Most documentation should be in the code, but certain things should be documented outside code. Making designers sift through code for setup is time-wasting. Documented setups improved efficiency (if the documents are current).

Document the following:

Layer uses (for collision, culling, and raycasting – essentially, what should be in what layer).
Tag uses.
GUI depths for layers (what should display over what).
Scene setup.
Idiom preferences.
Prefab structure.
Animation layers.

## Optimization
**Use object pool**

## Editor Setting
* `Edit > Project Settings > Editor`
    * `Asset Serialization` > `Force Text`




# REFERENCES
* http://www.glenstevens.ca/unity3d-best-practices/#Process
* http://devmag.org.za/2012/07/12/50-tips-for-working-with-unity-best-practices/
* http://unitytip.com/
