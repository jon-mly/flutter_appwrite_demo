# AppWrite & Riverpod demo

Project to experiment around Flutter on all available platforms, Riverpod as state-management method and AppWrite as a BaaS solution.

### Content

Simple ToDo-list app made with Flutter to run on all currently stable platforms (iOS, Android, macOS, web).

This project is made to experiment around multiple features and tech :

On the app/Flutter side :
- Riverpod as a state-management principle on the app/Flutter side
- Freezed and StateNotifier as complements of Riverpod for improving the state-management 
- Handling of all platforms in a single project, taking account of the singularities of each one of them, especially regarding the UX experience

On the server side :
- AppWrite as a BaaS solution to work with a self-hosted Firebase alternative system
- Experimenting around back-end dev, Docker, hosting solutions, etc...

### Next steps

Among the leads to improve and go beyond, the project might evolve with multiple features :
- Auth system, which might be handled through a different service (ex. Firebase Auth and working on how to handle it alongside AppWrite)
- Messaging with assets handling like pics, GIFs, etc... (based on my previous project `flutter_firechat` to see how it can be reimplemented differently)
- Handling of groups of people, etc...
