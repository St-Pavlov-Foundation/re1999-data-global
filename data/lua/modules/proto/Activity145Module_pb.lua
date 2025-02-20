slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.Activity145Module_pb", package.seeall)

slot2 = {
	TASKMODULE_PB = slot0("modules.proto.TaskModule_pb"),
	ACT145INFOUPDATEPUSH_MSG = slot1.Descriptor(),
	ACT145INFOUPDATEPUSHACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145INFOUPDATEPUSHACT145INFOFIELD = slot1.FieldDescriptor(),
	ACT145CLEARGAMERECORDREQUEST_MSG = slot1.Descriptor(),
	ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET145INFOSREQUEST_MSG = slot1.Descriptor(),
	GET145INFOSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREQUEST_MSG = slot1.Descriptor(),
	ACT145GAMEREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREQUESTCONTENTFIELD = slot1.FieldDescriptor(),
	ACT145CLEARGAMERECORDREPLY_MSG = slot1.Descriptor(),
	ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145CLEARGAMERECORDREPLYACT145INFOFIELD = slot1.FieldDescriptor(),
	ACT145INFO_MSG = slot1.Descriptor(),
	ACT145INFOREMOVENUMFIELD = slot1.FieldDescriptor(),
	ACT145INFOGAMENUMFIELD = slot1.FieldDescriptor(),
	ACT145INFOHASGETBONUSIDSFIELD = slot1.FieldDescriptor(),
	ACT145INFOLASTGAMERECORDFIELD = slot1.FieldDescriptor(),
	ACT145INFOTASKSFIELD = slot1.FieldDescriptor(),
	ACT145GETREWARDSREPLY_MSG = slot1.Descriptor(),
	ACT145GETREWARDSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145GETREWARDSREPLYBONUSIDSFIELD = slot1.FieldDescriptor(),
	ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD = slot1.FieldDescriptor(),
	ACT145GETREWARDSREQUEST_MSG = slot1.Descriptor(),
	ACT145GETREWARDSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREQUEST_MSG = slot1.Descriptor(),
	ACT145REMOVETASKREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREQUESTTASKIDFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREPLY_MSG = slot1.Descriptor(),
	ACT145REMOVETASKREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREPLYTASKIDFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREPLYREMOVENUMFIELD = slot1.FieldDescriptor(),
	ACT145REMOVETASKREPLYTASKSFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREPLY_MSG = slot1.Descriptor(),
	ACT145GAMEREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREPLYGAMERESFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREPLYREMOVENUMFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREPLYGAMENUMFIELD = slot1.FieldDescriptor(),
	ACT145GAMEREPLYCONTENTFIELD = slot1.FieldDescriptor(),
	GET145INFOSREPLY_MSG = slot1.Descriptor(),
	GET145INFOSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET145INFOSREPLYACT145INFOFIELD = slot1.FieldDescriptor()
}
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.name = "activityId"
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.full_name = ".Act145InfoUpdatePush.activityId"
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.number = 1
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.index = 0
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.label = 1
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.has_default_value = false
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.default_value = 0
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.type = 5
slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.name = "act145Info"
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.full_name = ".Act145InfoUpdatePush.act145Info"
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.number = 2
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.index = 1
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.label = 1
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.has_default_value = false
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.default_value = nil
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.message_type = slot2.ACT145INFO_MSG
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.type = 11
slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD.cpp_type = 10
slot2.ACT145INFOUPDATEPUSH_MSG.name = "Act145InfoUpdatePush"
slot2.ACT145INFOUPDATEPUSH_MSG.full_name = ".Act145InfoUpdatePush"
slot2.ACT145INFOUPDATEPUSH_MSG.nested_types = {}
slot2.ACT145INFOUPDATEPUSH_MSG.enum_types = {}
slot2.ACT145INFOUPDATEPUSH_MSG.fields = {
	slot2.ACT145INFOUPDATEPUSHACTIVITYIDFIELD,
	slot2.ACT145INFOUPDATEPUSHACT145INFOFIELD
}
slot2.ACT145INFOUPDATEPUSH_MSG.is_extendable = false
slot2.ACT145INFOUPDATEPUSH_MSG.extensions = {}
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.full_name = ".Act145ClearGameRecordRequest.activityId"
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.name = "Act145ClearGameRecordRequest"
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.full_name = ".Act145ClearGameRecordRequest"
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.nested_types = {}
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.enum_types = {}
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.fields = {
	slot2.ACT145CLEARGAMERECORDREQUESTACTIVITYIDFIELD
}
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.is_extendable = false
slot2.ACT145CLEARGAMERECORDREQUEST_MSG.extensions = {}
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get145InfosRequest.activityId"
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.number = 1
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.index = 0
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.label = 1
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.type = 5
slot2.GET145INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GET145INFOSREQUEST_MSG.name = "Get145InfosRequest"
slot2.GET145INFOSREQUEST_MSG.full_name = ".Get145InfosRequest"
slot2.GET145INFOSREQUEST_MSG.nested_types = {}
slot2.GET145INFOSREQUEST_MSG.enum_types = {}
slot2.GET145INFOSREQUEST_MSG.fields = {
	slot2.GET145INFOSREQUESTACTIVITYIDFIELD
}
slot2.GET145INFOSREQUEST_MSG.is_extendable = false
slot2.GET145INFOSREQUEST_MSG.extensions = {}
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.full_name = ".Act145GameRequest.activityId"
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT145GAMEREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145GAMEREQUESTCONTENTFIELD.name = "content"
slot2.ACT145GAMEREQUESTCONTENTFIELD.full_name = ".Act145GameRequest.content"
slot2.ACT145GAMEREQUESTCONTENTFIELD.number = 2
slot2.ACT145GAMEREQUESTCONTENTFIELD.index = 1
slot2.ACT145GAMEREQUESTCONTENTFIELD.label = 1
slot2.ACT145GAMEREQUESTCONTENTFIELD.has_default_value = false
slot2.ACT145GAMEREQUESTCONTENTFIELD.default_value = 0
slot2.ACT145GAMEREQUESTCONTENTFIELD.type = 5
slot2.ACT145GAMEREQUESTCONTENTFIELD.cpp_type = 1
slot2.ACT145GAMEREQUEST_MSG.name = "Act145GameRequest"
slot2.ACT145GAMEREQUEST_MSG.full_name = ".Act145GameRequest"
slot2.ACT145GAMEREQUEST_MSG.nested_types = {}
slot2.ACT145GAMEREQUEST_MSG.enum_types = {}
slot2.ACT145GAMEREQUEST_MSG.fields = {
	slot2.ACT145GAMEREQUESTACTIVITYIDFIELD,
	slot2.ACT145GAMEREQUESTCONTENTFIELD
}
slot2.ACT145GAMEREQUEST_MSG.is_extendable = false
slot2.ACT145GAMEREQUEST_MSG.extensions = {}
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.full_name = ".Act145ClearGameRecordReply.activityId"
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.number = 1
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.index = 0
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.label = 1
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.type = 5
slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.name = "act145Info"
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.full_name = ".Act145ClearGameRecordReply.act145Info"
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.number = 2
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.index = 1
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.label = 1
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.has_default_value = false
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.default_value = nil
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.message_type = slot2.ACT145INFO_MSG
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.type = 11
slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD.cpp_type = 10
slot2.ACT145CLEARGAMERECORDREPLY_MSG.name = "Act145ClearGameRecordReply"
slot2.ACT145CLEARGAMERECORDREPLY_MSG.full_name = ".Act145ClearGameRecordReply"
slot2.ACT145CLEARGAMERECORDREPLY_MSG.nested_types = {}
slot2.ACT145CLEARGAMERECORDREPLY_MSG.enum_types = {}
slot2.ACT145CLEARGAMERECORDREPLY_MSG.fields = {
	slot2.ACT145CLEARGAMERECORDREPLYACTIVITYIDFIELD,
	slot2.ACT145CLEARGAMERECORDREPLYACT145INFOFIELD
}
slot2.ACT145CLEARGAMERECORDREPLY_MSG.is_extendable = false
slot2.ACT145CLEARGAMERECORDREPLY_MSG.extensions = {}
slot2.ACT145INFOREMOVENUMFIELD.name = "removeNum"
slot2.ACT145INFOREMOVENUMFIELD.full_name = ".Act145Info.removeNum"
slot2.ACT145INFOREMOVENUMFIELD.number = 1
slot2.ACT145INFOREMOVENUMFIELD.index = 0
slot2.ACT145INFOREMOVENUMFIELD.label = 1
slot2.ACT145INFOREMOVENUMFIELD.has_default_value = false
slot2.ACT145INFOREMOVENUMFIELD.default_value = 0
slot2.ACT145INFOREMOVENUMFIELD.type = 5
slot2.ACT145INFOREMOVENUMFIELD.cpp_type = 1
slot2.ACT145INFOGAMENUMFIELD.name = "gameNum"
slot2.ACT145INFOGAMENUMFIELD.full_name = ".Act145Info.gameNum"
slot2.ACT145INFOGAMENUMFIELD.number = 2
slot2.ACT145INFOGAMENUMFIELD.index = 1
slot2.ACT145INFOGAMENUMFIELD.label = 1
slot2.ACT145INFOGAMENUMFIELD.has_default_value = false
slot2.ACT145INFOGAMENUMFIELD.default_value = 0
slot2.ACT145INFOGAMENUMFIELD.type = 5
slot2.ACT145INFOGAMENUMFIELD.cpp_type = 1
slot2.ACT145INFOHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
slot2.ACT145INFOHASGETBONUSIDSFIELD.full_name = ".Act145Info.hasGetBonusIds"
slot2.ACT145INFOHASGETBONUSIDSFIELD.number = 3
slot2.ACT145INFOHASGETBONUSIDSFIELD.index = 2
slot2.ACT145INFOHASGETBONUSIDSFIELD.label = 3
slot2.ACT145INFOHASGETBONUSIDSFIELD.has_default_value = false
slot2.ACT145INFOHASGETBONUSIDSFIELD.default_value = {}
slot2.ACT145INFOHASGETBONUSIDSFIELD.type = 5
slot2.ACT145INFOHASGETBONUSIDSFIELD.cpp_type = 1
slot2.ACT145INFOLASTGAMERECORDFIELD.name = "lastGameRecord"
slot2.ACT145INFOLASTGAMERECORDFIELD.full_name = ".Act145Info.lastGameRecord"
slot2.ACT145INFOLASTGAMERECORDFIELD.number = 4
slot2.ACT145INFOLASTGAMERECORDFIELD.index = 3
slot2.ACT145INFOLASTGAMERECORDFIELD.label = 1
slot2.ACT145INFOLASTGAMERECORDFIELD.has_default_value = false
slot2.ACT145INFOLASTGAMERECORDFIELD.default_value = ""
slot2.ACT145INFOLASTGAMERECORDFIELD.type = 9
slot2.ACT145INFOLASTGAMERECORDFIELD.cpp_type = 9
slot2.ACT145INFOTASKSFIELD.name = "tasks"
slot2.ACT145INFOTASKSFIELD.full_name = ".Act145Info.tasks"
slot2.ACT145INFOTASKSFIELD.number = 5
slot2.ACT145INFOTASKSFIELD.index = 4
slot2.ACT145INFOTASKSFIELD.label = 3
slot2.ACT145INFOTASKSFIELD.has_default_value = false
slot2.ACT145INFOTASKSFIELD.default_value = {}
slot2.ACT145INFOTASKSFIELD.message_type = slot2.TASKMODULE_PB.TASK_MSG
slot2.ACT145INFOTASKSFIELD.type = 11
slot2.ACT145INFOTASKSFIELD.cpp_type = 10
slot2.ACT145INFO_MSG.name = "Act145Info"
slot2.ACT145INFO_MSG.full_name = ".Act145Info"
slot2.ACT145INFO_MSG.nested_types = {}
slot2.ACT145INFO_MSG.enum_types = {}
slot2.ACT145INFO_MSG.fields = {
	slot2.ACT145INFOREMOVENUMFIELD,
	slot2.ACT145INFOGAMENUMFIELD,
	slot2.ACT145INFOHASGETBONUSIDSFIELD,
	slot2.ACT145INFOLASTGAMERECORDFIELD,
	slot2.ACT145INFOTASKSFIELD
}
slot2.ACT145INFO_MSG.is_extendable = false
slot2.ACT145INFO_MSG.extensions = {}
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.full_name = ".Act145GetRewardsReply.activityId"
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.number = 1
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.index = 0
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.label = 1
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.type = 5
slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.name = "bonusIds"
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.full_name = ".Act145GetRewardsReply.bonusIds"
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.number = 2
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.index = 1
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.label = 1
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.has_default_value = false
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.default_value = ""
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.type = 9
slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD.cpp_type = 9
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.full_name = ".Act145GetRewardsReply.hasGetBonusIds"
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.number = 3
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.index = 2
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.label = 3
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.has_default_value = false
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.default_value = {}
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.type = 5
slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD.cpp_type = 1
slot2.ACT145GETREWARDSREPLY_MSG.name = "Act145GetRewardsReply"
slot2.ACT145GETREWARDSREPLY_MSG.full_name = ".Act145GetRewardsReply"
slot2.ACT145GETREWARDSREPLY_MSG.nested_types = {}
slot2.ACT145GETREWARDSREPLY_MSG.enum_types = {}
slot2.ACT145GETREWARDSREPLY_MSG.fields = {
	slot2.ACT145GETREWARDSREPLYACTIVITYIDFIELD,
	slot2.ACT145GETREWARDSREPLYBONUSIDSFIELD,
	slot2.ACT145GETREWARDSREPLYHASGETBONUSIDSFIELD
}
slot2.ACT145GETREWARDSREPLY_MSG.is_extendable = false
slot2.ACT145GETREWARDSREPLY_MSG.extensions = {}
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.full_name = ".Act145GetRewardsRequest.activityId"
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145GETREWARDSREQUEST_MSG.name = "Act145GetRewardsRequest"
slot2.ACT145GETREWARDSREQUEST_MSG.full_name = ".Act145GetRewardsRequest"
slot2.ACT145GETREWARDSREQUEST_MSG.nested_types = {}
slot2.ACT145GETREWARDSREQUEST_MSG.enum_types = {}
slot2.ACT145GETREWARDSREQUEST_MSG.fields = {
	slot2.ACT145GETREWARDSREQUESTACTIVITYIDFIELD
}
slot2.ACT145GETREWARDSREQUEST_MSG.is_extendable = false
slot2.ACT145GETREWARDSREQUEST_MSG.extensions = {}
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.full_name = ".Act145RemoveTaskRequest.activityId"
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.name = "taskId"
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.full_name = ".Act145RemoveTaskRequest.taskId"
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.number = 2
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.index = 1
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.label = 1
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.has_default_value = false
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.default_value = 0
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.type = 5
slot2.ACT145REMOVETASKREQUESTTASKIDFIELD.cpp_type = 1
slot2.ACT145REMOVETASKREQUEST_MSG.name = "Act145RemoveTaskRequest"
slot2.ACT145REMOVETASKREQUEST_MSG.full_name = ".Act145RemoveTaskRequest"
slot2.ACT145REMOVETASKREQUEST_MSG.nested_types = {}
slot2.ACT145REMOVETASKREQUEST_MSG.enum_types = {}
slot2.ACT145REMOVETASKREQUEST_MSG.fields = {
	slot2.ACT145REMOVETASKREQUESTACTIVITYIDFIELD,
	slot2.ACT145REMOVETASKREQUESTTASKIDFIELD
}
slot2.ACT145REMOVETASKREQUEST_MSG.is_extendable = false
slot2.ACT145REMOVETASKREQUEST_MSG.extensions = {}
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.full_name = ".Act145RemoveTaskReply.activityId"
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.number = 1
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.index = 0
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.label = 1
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.type = 5
slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.name = "taskId"
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.full_name = ".Act145RemoveTaskReply.taskId"
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.number = 2
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.index = 1
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.label = 1
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.has_default_value = false
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.default_value = 0
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.type = 5
slot2.ACT145REMOVETASKREPLYTASKIDFIELD.cpp_type = 1
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.name = "removeNum"
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.full_name = ".Act145RemoveTaskReply.removeNum"
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.number = 3
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.index = 2
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.label = 1
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.has_default_value = false
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.default_value = 0
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.type = 5
slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD.cpp_type = 1
slot2.ACT145REMOVETASKREPLYTASKSFIELD.name = "tasks"
slot2.ACT145REMOVETASKREPLYTASKSFIELD.full_name = ".Act145RemoveTaskReply.tasks"
slot2.ACT145REMOVETASKREPLYTASKSFIELD.number = 4
slot2.ACT145REMOVETASKREPLYTASKSFIELD.index = 3
slot2.ACT145REMOVETASKREPLYTASKSFIELD.label = 3
slot2.ACT145REMOVETASKREPLYTASKSFIELD.has_default_value = false
slot2.ACT145REMOVETASKREPLYTASKSFIELD.default_value = {}
slot2.ACT145REMOVETASKREPLYTASKSFIELD.message_type = slot2.TASKMODULE_PB.TASK_MSG
slot2.ACT145REMOVETASKREPLYTASKSFIELD.type = 11
slot2.ACT145REMOVETASKREPLYTASKSFIELD.cpp_type = 10
slot2.ACT145REMOVETASKREPLY_MSG.name = "Act145RemoveTaskReply"
slot2.ACT145REMOVETASKREPLY_MSG.full_name = ".Act145RemoveTaskReply"
slot2.ACT145REMOVETASKREPLY_MSG.nested_types = {}
slot2.ACT145REMOVETASKREPLY_MSG.enum_types = {}
slot2.ACT145REMOVETASKREPLY_MSG.fields = {
	slot2.ACT145REMOVETASKREPLYACTIVITYIDFIELD,
	slot2.ACT145REMOVETASKREPLYTASKIDFIELD,
	slot2.ACT145REMOVETASKREPLYREMOVENUMFIELD,
	slot2.ACT145REMOVETASKREPLYTASKSFIELD
}
slot2.ACT145REMOVETASKREPLY_MSG.is_extendable = false
slot2.ACT145REMOVETASKREPLY_MSG.extensions = {}
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.full_name = ".Act145GameReply.activityId"
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.number = 1
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.index = 0
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.label = 1
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.type = 5
slot2.ACT145GAMEREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT145GAMEREPLYGAMERESFIELD.name = "gameRes"
slot2.ACT145GAMEREPLYGAMERESFIELD.full_name = ".Act145GameReply.gameRes"
slot2.ACT145GAMEREPLYGAMERESFIELD.number = 2
slot2.ACT145GAMEREPLYGAMERESFIELD.index = 1
slot2.ACT145GAMEREPLYGAMERESFIELD.label = 1
slot2.ACT145GAMEREPLYGAMERESFIELD.has_default_value = false
slot2.ACT145GAMEREPLYGAMERESFIELD.default_value = 0
slot2.ACT145GAMEREPLYGAMERESFIELD.type = 5
slot2.ACT145GAMEREPLYGAMERESFIELD.cpp_type = 1
slot2.ACT145GAMEREPLYREMOVENUMFIELD.name = "removeNum"
slot2.ACT145GAMEREPLYREMOVENUMFIELD.full_name = ".Act145GameReply.removeNum"
slot2.ACT145GAMEREPLYREMOVENUMFIELD.number = 3
slot2.ACT145GAMEREPLYREMOVENUMFIELD.index = 2
slot2.ACT145GAMEREPLYREMOVENUMFIELD.label = 1
slot2.ACT145GAMEREPLYREMOVENUMFIELD.has_default_value = false
slot2.ACT145GAMEREPLYREMOVENUMFIELD.default_value = 0
slot2.ACT145GAMEREPLYREMOVENUMFIELD.type = 5
slot2.ACT145GAMEREPLYREMOVENUMFIELD.cpp_type = 1
slot2.ACT145GAMEREPLYGAMENUMFIELD.name = "gameNum"
slot2.ACT145GAMEREPLYGAMENUMFIELD.full_name = ".Act145GameReply.gameNum"
slot2.ACT145GAMEREPLYGAMENUMFIELD.number = 4
slot2.ACT145GAMEREPLYGAMENUMFIELD.index = 3
slot2.ACT145GAMEREPLYGAMENUMFIELD.label = 1
slot2.ACT145GAMEREPLYGAMENUMFIELD.has_default_value = false
slot2.ACT145GAMEREPLYGAMENUMFIELD.default_value = 0
slot2.ACT145GAMEREPLYGAMENUMFIELD.type = 5
slot2.ACT145GAMEREPLYGAMENUMFIELD.cpp_type = 1
slot2.ACT145GAMEREPLYCONTENTFIELD.name = "content"
slot2.ACT145GAMEREPLYCONTENTFIELD.full_name = ".Act145GameReply.content"
slot2.ACT145GAMEREPLYCONTENTFIELD.number = 5
slot2.ACT145GAMEREPLYCONTENTFIELD.index = 4
slot2.ACT145GAMEREPLYCONTENTFIELD.label = 1
slot2.ACT145GAMEREPLYCONTENTFIELD.has_default_value = false
slot2.ACT145GAMEREPLYCONTENTFIELD.default_value = 0
slot2.ACT145GAMEREPLYCONTENTFIELD.type = 5
slot2.ACT145GAMEREPLYCONTENTFIELD.cpp_type = 1
slot2.ACT145GAMEREPLY_MSG.name = "Act145GameReply"
slot2.ACT145GAMEREPLY_MSG.full_name = ".Act145GameReply"
slot2.ACT145GAMEREPLY_MSG.nested_types = {}
slot2.ACT145GAMEREPLY_MSG.enum_types = {}
slot2.ACT145GAMEREPLY_MSG.fields = {
	slot2.ACT145GAMEREPLYACTIVITYIDFIELD,
	slot2.ACT145GAMEREPLYGAMERESFIELD,
	slot2.ACT145GAMEREPLYREMOVENUMFIELD,
	slot2.ACT145GAMEREPLYGAMENUMFIELD,
	slot2.ACT145GAMEREPLYCONTENTFIELD
}
slot2.ACT145GAMEREPLY_MSG.is_extendable = false
slot2.ACT145GAMEREPLY_MSG.extensions = {}
slot2.GET145INFOSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GET145INFOSREPLYACTIVITYIDFIELD.full_name = ".Get145InfosReply.activityId"
slot2.GET145INFOSREPLYACTIVITYIDFIELD.number = 1
slot2.GET145INFOSREPLYACTIVITYIDFIELD.index = 0
slot2.GET145INFOSREPLYACTIVITYIDFIELD.label = 1
slot2.GET145INFOSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GET145INFOSREPLYACTIVITYIDFIELD.default_value = 0
slot2.GET145INFOSREPLYACTIVITYIDFIELD.type = 5
slot2.GET145INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GET145INFOSREPLYACT145INFOFIELD.name = "act145Info"
slot2.GET145INFOSREPLYACT145INFOFIELD.full_name = ".Get145InfosReply.act145Info"
slot2.GET145INFOSREPLYACT145INFOFIELD.number = 2
slot2.GET145INFOSREPLYACT145INFOFIELD.index = 1
slot2.GET145INFOSREPLYACT145INFOFIELD.label = 1
slot2.GET145INFOSREPLYACT145INFOFIELD.has_default_value = false
slot2.GET145INFOSREPLYACT145INFOFIELD.default_value = nil
slot2.GET145INFOSREPLYACT145INFOFIELD.message_type = slot2.ACT145INFO_MSG
slot2.GET145INFOSREPLYACT145INFOFIELD.type = 11
slot2.GET145INFOSREPLYACT145INFOFIELD.cpp_type = 10
slot2.GET145INFOSREPLY_MSG.name = "Get145InfosReply"
slot2.GET145INFOSREPLY_MSG.full_name = ".Get145InfosReply"
slot2.GET145INFOSREPLY_MSG.nested_types = {}
slot2.GET145INFOSREPLY_MSG.enum_types = {}
slot2.GET145INFOSREPLY_MSG.fields = {
	slot2.GET145INFOSREPLYACTIVITYIDFIELD,
	slot2.GET145INFOSREPLYACT145INFOFIELD
}
slot2.GET145INFOSREPLY_MSG.is_extendable = false
slot2.GET145INFOSREPLY_MSG.extensions = {}
slot2.Act145ClearGameRecordReply = slot1.Message(slot2.ACT145CLEARGAMERECORDREPLY_MSG)
slot2.Act145ClearGameRecordRequest = slot1.Message(slot2.ACT145CLEARGAMERECORDREQUEST_MSG)
slot2.Act145GameReply = slot1.Message(slot2.ACT145GAMEREPLY_MSG)
slot2.Act145GameRequest = slot1.Message(slot2.ACT145GAMEREQUEST_MSG)
slot2.Act145GetRewardsReply = slot1.Message(slot2.ACT145GETREWARDSREPLY_MSG)
slot2.Act145GetRewardsRequest = slot1.Message(slot2.ACT145GETREWARDSREQUEST_MSG)
slot2.Act145Info = slot1.Message(slot2.ACT145INFO_MSG)
slot2.Act145InfoUpdatePush = slot1.Message(slot2.ACT145INFOUPDATEPUSH_MSG)
slot2.Act145RemoveTaskReply = slot1.Message(slot2.ACT145REMOVETASKREPLY_MSG)
slot2.Act145RemoveTaskRequest = slot1.Message(slot2.ACT145REMOVETASKREQUEST_MSG)
slot2.Get145InfosReply = slot1.Message(slot2.GET145INFOSREPLY_MSG)
slot2.Get145InfosRequest = slot1.Message(slot2.GET145INFOSREQUEST_MSG)

return slot2
