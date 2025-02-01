import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/provider/lost_and_found_provider.dart';
import '../../components/image_tile.dart';
import '../../constants/constants.dart';
import '../../models/admin.dart';
import '../../models/faculty.dart';
import '../../models/student.dart';
import '../../provider/auth_provider.dart';

class LostAndFound extends ConsumerWidget {
  LostAndFound({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(authProvider.notifier).tokenCheckProgress != LoadingState.progress) {
        ref.read(authProvider.notifier).verifyAuthTokenExistence(context, AuthConstants.generalAuthLabel.toLowerCase());
      }
    });
    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lost & Found'),
          actions: [
            BorderlessButton(
              backgroundColor: Colors.greenAccent.shade100,
              splashColor: Colors.green.shade700,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Add Listing',
                            style: TextStyle(fontSize: 30),
                          ),
                          const SizedBox(height: 20),
                          Consumer(
                            builder: (_, ref, __) {
                              if (ref.watch(lostAndFoundProvider).selectedImage == null) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => ref.read(lostAndFoundProvider.notifier).pickImageFromCamera(),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(Icons.camera_alt),
                                    ),
                                    const Text("OR"),
                                    ElevatedButton(
                                      onPressed: () => ref.watch(lostAndFoundProvider.notifier).pickImageFromGallery(),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(Icons.photo),
                                    ),
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text("Remove image?"),
                                            const SizedBox(height: 20),
                                            BorderlessButton(
                                              onPressed: () {
                                                ref.read(lostAndFoundProvider.notifier).resetImageSelection();
                                                Navigator.pop(context);
                                              },
                                              backgroundColor: Colors.redAccent.shade100.withOpacity(0.5),
                                              splashColor: Colors.red.shade700,
                                              label: const Text('Remove Image'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    height: 150,
                                    child: Image.file(ref.watch(lostAndFoundProvider).selectedImage!),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MaterialTextFormField(
                                  hintText: "Item Name",
                                  controller: ref.read(lostAndFoundProvider).itemNameController,
                                  validator: (value) => Validators.nameValidator(value),
                                ),
                                const SizedBox(height: 20),
                                MaterialTextFormField(
                                  hintText: "Item Description",
                                  controller: ref.read(lostAndFoundProvider).itemDescriptionController,
                                  validator: (value) => Validators.descriptionValidator(value),
                                ),
                                const SizedBox(height: 20),
                                MaterialTextFormField(
                                  hintText: "Contact Number",
                                  controller: ref.read(lostAndFoundProvider).contactNumberController,
                                  validator: (value) => Validators.contactNumberValidator(value),
                                ),
                                const SizedBox(height: 20),
                                MaterialTextFormField(
                                  hintText: "Last seen at location",
                                  controller: ref.read(lostAndFoundProvider).lastSeenLocationController,
                                  validator: (value) => Validators.nonEmptyValidator(value),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Consumer(
                              builder: (_, ref, __) {
                                return AnimatedToggleSwitch.dual(
                                  height: 45,
                                  spacing: 20,
                                  current: ref.watch(lostAndFoundProvider).listingStatus,
                                  first: LostAndFoundConstants.lostState,
                                  second: LostAndFoundConstants.foundState,
                                  textBuilder: (value) => Text(value),
                                  onChanged: (value) =>
                                      ref.read(lostAndFoundProvider.notifier).updateListingStatus(value),
                                  styleBuilder: (value) => value == LostAndFoundConstants.lostState
                                      ? ToggleStyle(
                                          indicatorColor: Colors.redAccent,
                                          backgroundColor: Colors.redAccent.shade100,
                                          borderColor: Colors.transparent,
                                        )
                                      : ToggleStyle(
                                          indicatorColor: Colors.teal,
                                          backgroundColor: Colors.tealAccent.shade100,
                                          borderColor: Colors.transparent,
                                        ),
                                  iconBuilder: (value) => value == LostAndFoundConstants.lostState
                                      ? const Icon(
                                          Icons.search_outlined,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              BorderlessButton(
                                onPressed: () => context.pop(),
                                backgroundColor: Colors.redAccent.shade100.withOpacity(0.5),
                                splashColor: Colors.red.shade700,
                                label: const Text('Cancel'),
                              ),
                              const Spacer(),
                              BorderlessButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ref.read(lostAndFoundProvider.notifier).addItem();
                                    ref.read(lostAndFoundProvider.notifier).clearControllers();
                                    context.pop();
                                  }
                                },
                                label: const Text('Add'),
                                backgroundColor: Colors.blueAccent.shade100.withOpacity(0.5),
                                splashColor: Colors.blue.shade700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              label: const Text('Add Listing'),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: ref.watch(lostAndFoundProvider).loadingState == LoadingState.success
            ? (ref.read(lostAndFoundProvider).lostAndFoundItemList.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    children: <Widget>[
                      for (var item in ref.watch(lostAndFoundProvider).lostAndFoundItemList)
                        ImageTile(
                          image: item.imagePath != null
                              ? ref.read(lostAndFoundProvider.notifier).imageFromBase64String(item.imagePath!)
                              : null,
                          body: [
                            Text(
                              "Item : ${item.name}",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Last Seen at : ${item.lastSeenLocation}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              item.isLost ? " Status : Lost" : "Status : Found",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                          primaryColor: item.isLost ? Colors.redAccent.shade100 : Colors.tealAccent.shade100,
                          secondaryColor: item.isLost ? Colors.redAccent.shade200 : Colors.tealAccent.shade200,
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Item Name", style: TextStyle(fontSize: 20)),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.tealAccent.withOpacity(0.4),
                                        ),
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          item.name,
                                          style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text("Item Description", style: TextStyle(fontSize: 20)),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.tealAccent.withOpacity(0.4),
                                        ),
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          item.description,
                                          style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text("Last seen at", style: TextStyle(fontSize: 20)),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.tealAccent.withOpacity(0.4),
                                        ),
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          item.lastSeenLocation,
                                          style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text("Contact", style: TextStyle(fontSize: 20)),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.tealAccent.withOpacity(0.4),
                                            ),
                                            width: 185,
                                            child: AutoSizeText(
                                              item.contactNumber,
                                              style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.orangeAccent.withOpacity(0.5),
                                            ),
                                            child: GestureDetector(
                                              onTap: () => ref
                                                  .read(lostAndFoundProvider.notifier)
                                                  .launchCaller(item.contactNumber),
                                              child: const Icon(
                                                Icons.call,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      Consumer(
                                        builder: (_, ref, __) {
                                          String userId;
                                          final authState = ref.watch(authProvider);
                                          if (ref.read(authProvider).currentUserRole == 'student') {
                                            userId = (authState.currentUser as Student).id;
                                          } else if (authState.currentUserRole == 'faculty') {
                                            userId = (authState.currentUser as Faculty).id;
                                          } else if (authState.currentUserRole == 'admin') {
                                            userId = (authState.currentUser as Admin).id;
                                          } else {
                                            return const SizedBox.shrink();
                                          }

                                          if (userId == item.listerId) {
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  height: 55,
                                                  width: 100,
                                                  child: BorderlessButton(
                                                    onPressed: () => context.pop(),
                                                    backgroundColor: Colors.blueAccent.shade100.withOpacity(0.5),
                                                    splashColor: Colors.blue.shade700,
                                                    label: const Text('Close'),
                                                  ),
                                                ),
                                                Container(
                                                  width: 55,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.redAccent.withOpacity(0.5),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                        ref.read(lostAndFoundProvider.notifier).deleteItem(item.id!);
                                                        context.pop();
                                                        },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: SizedBox(
                                                height: 55,
                                                width: 100,
                                                child: BorderlessButton(
                                                  onPressed: () => context.pop(),
                                                  backgroundColor: Colors.blueAccent.shade100.withOpacity(0.5),
                                                  splashColor: Colors.blue.shade700,
                                                  label: const Text('Close'),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'No lost items :)',
                      style: TextStyle(fontSize: 30, color: Colors.black38),
                    ),
                  ))
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
