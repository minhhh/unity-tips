# UNITY TIPS, TRICKS AND BEST PRACTICES
Tips, tricks and best practices for working with Unity.

## Process
**Avoid branching assets**. There should always only ever be one version of any asset. If you absolutely have to branch a prefab, scene, or mesh, follow a process that makes it very clear which is the right version. The "wrong" branch should have a funky name, for example, use a double underscore prefix: `__MainScene_Backup`.


**Each team member should have a second copy of the project checked out for testing** if you are using version control. After changes, this second copy, the clean copy, should be updated and tested. No-one should make any changes to their clean copies. This is especially useful to catch missing assets.


**Consider saving levels in data instead of in scenes**. If you have many levels, it makes senses to have a standard text format for those level data. You might want to use external level tools or create your own in Unity. The advantages are:

* It makes it unnecessary to re-setup each scene.
* It makes it easier to merge scenes
* It makes it easier to change all levels according to specific rules.


**Consider writing generic custom inspector code**. To write custom inspectors is fairly straightforward, but Unity’s system has many drawbacks:

* It does not support taking advantage of inheritance.
* It does not let you define inspector components on a field-type level, only a class-type level. For instance, if every game object has a field of type SomeCoolType, which you want rendered differently in the inspector, you have to write inspectors for all your classes.


## Scene Organization
**Use named empty game objects as scene folders**. Carefully organize your scenes to make it easy to find objects.



## Optimization
**Use object pool**

## Editor Setting
* `Edit > Project Settings > Editor`
    * `Asset Serialization` > `Force Text`

# REFERENCES
* http://www.glenstevens.ca/unity3d-best-practices/#Process
* http://devmag.org.za/2012/07/12/50-tips-for-working-with-unity-best-practices/
* http://unitytip.com/
