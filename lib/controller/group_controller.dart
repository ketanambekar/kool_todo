import 'package:get/get.dart';
import 'package:kool_todo/models/group_model.dart';
import 'package:kool_todo/service/group_service.dart';

class GroupController extends GetxController {
  var groups = <Group>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadGroups();
  }

  void loadGroups() async {
    List<Group> groupList = await GroupService.getGroups();
    groups.assignAll(groupList);
  }

  void addGroup(Group group) async {
    await GroupService.addGroup(group);
    loadGroups();
  }

  void updateGroup(Group group) async {
    await GroupService.updateGroup(group);
    loadGroups();
  }

  void deleteGroup(int groupId) async {
    await GroupService.deleteGroup(groupId);
    loadGroups();
  }
}
