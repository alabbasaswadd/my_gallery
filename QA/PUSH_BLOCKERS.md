# PUSH_BLOCKERS.md

**Status: PUSH HELD.** Per the mission rule ("run flutter analyze / flutter test … if anything fails, create QA/PUSH_BLOCKERS.md and do NOT push"), the Flutter verification gate cannot be executed in this environment, so the branch was **committed locally but NOT pushed**.

## What passed
- ✅ **Backend `dotnet build`** — clean (0 warnings / 0 errors) on .NET 10 after every commit.
- ✅ **EF migration** generated (`AddOccasionSlugAndIcon`).
- ➖ **`dotnet test`** — no test project exists in the solution (nothing to run).

## The blocker: Flutter cannot be verified here
- Installed **Flutter 3.38.4 / Dart 3.10.3**; the project requires **Dart `^3.12.2` (Flutter ~3.44.9)**. `flutter pub get` fails version resolution, so `flutter analyze` and `flutter test` **cannot run**.
- The new Occasions feature adds `@freezed` models (`occasion_models.dart`) and cubit state unions (`occasions_cubit`, `occasion_form_cubit`) whose generated `*.freezed.dart` / `*.g.dart` files **do not exist yet** — `build_runner` must be run. Without it the app will not compile.

Because these are hard failures of the required verification steps, the push is withheld pending a machine that can run them.

## What the reviewer must run (on Flutter ~3.44.9)
```bash
cd "D:/المعرض/my_gallery"
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs   # generates occasion codegen
flutter analyze                                                    # must be clean
flutter test                                                       # if/when tests exist
```
And, for the backend, apply the migration against SQL Server:
```bash
cd "D:/MyGallery project"
dotnet ef database update --project MyGallery.Infrastructure --startup-project MyGallery.Api
```

## Manual verification scenarios (once building)
Admin: Profile → إدارة المناسبات → create occasion (upload image) → assign products (product form → المناسبات chips) → edit → reorder → activate/deactivate → delete.
Customer: storefront home → "مناسبات مميّزة" strip → open occasion → browse products → open product → see "مناسب لـ" chips.

## To push after a clean verification
Once `flutter analyze` is clean and the flows pass:
```bash
cd "D:/المعرض/my_gallery" && git push -u origin feature/qa-implementation
cd "D:/MyGallery project" && git push -u origin feature/qa-implementation
```
(No merge, no PR — per instructions. Note the frontend push previously required collaborator access to `alabbasaswadd/my_gallery`, now granted; the backend remote is `abomajid20012024/MyGallery`.)

## Also outstanding (pre-existing, not introduced here)
- Backend `appsettings.json` still contains a committed production DB password (QA #S2) — rotate before any public push.
