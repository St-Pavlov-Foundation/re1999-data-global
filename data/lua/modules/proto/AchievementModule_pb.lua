﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.AchievementModule_pb", package.seeall)

local var_0_1 = {
	ACHIEVEMENTTASKINFO_MSG = var_0_0.Descriptor(),
	ACHIEVEMENTTASKINFOIDFIELD = var_0_0.FieldDescriptor(),
	ACHIEVEMENTTASKINFOPROGRESSFIELD = var_0_0.FieldDescriptor(),
	ACHIEVEMENTTASKINFOHASFINISHFIELD = var_0_0.FieldDescriptor(),
	ACHIEVEMENTTASKINFONEWFIELD = var_0_0.FieldDescriptor(),
	ACHIEVEMENTTASKINFOFINISHTIMEFIELD = var_0_0.FieldDescriptor(),
	SHOWACHIEVEMENTREPLY_MSG = var_0_0.Descriptor(),
	SHOWACHIEVEMENTREPLYIDSFIELD = var_0_0.FieldDescriptor(),
	SHOWACHIEVEMENTREPLYGROUPIDFIELD = var_0_0.FieldDescriptor(),
	GETACHIEVEMENTINFOREQUEST_MSG = var_0_0.Descriptor(),
	READNEWACHIEVEMENTREQUEST_MSG = var_0_0.Descriptor(),
	READNEWACHIEVEMENTREQUESTIDSFIELD = var_0_0.FieldDescriptor(),
	READNEWACHIEVEMENTREPLY_MSG = var_0_0.Descriptor(),
	READNEWACHIEVEMENTREPLYIDSFIELD = var_0_0.FieldDescriptor(),
	SHOWACHIEVEMENTREQUEST_MSG = var_0_0.Descriptor(),
	SHOWACHIEVEMENTREQUESTIDSFIELD = var_0_0.FieldDescriptor(),
	SHOWACHIEVEMENTREQUESTGROUPIDFIELD = var_0_0.FieldDescriptor(),
	GETACHIEVEMENTINFOREPLY_MSG = var_0_0.Descriptor(),
	GETACHIEVEMENTINFOREPLYINFOSFIELD = var_0_0.FieldDescriptor(),
	UPDATEACHIEVEMENTPUSH_MSG = var_0_0.Descriptor(),
	UPDATEACHIEVEMENTPUSHINFOSFIELD = var_0_0.FieldDescriptor()
}

var_0_1.ACHIEVEMENTTASKINFOIDFIELD.name = "id"
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.full_name = ".AchievementTaskInfo.id"
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.number = 1
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.index = 0
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.label = 1
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.has_default_value = false
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.default_value = 0
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.type = 5
var_0_1.ACHIEVEMENTTASKINFOIDFIELD.cpp_type = 1
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.name = "progress"
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.full_name = ".AchievementTaskInfo.progress"
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.number = 2
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.index = 1
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.label = 1
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.has_default_value = false
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.default_value = 0
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.type = 5
var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD.cpp_type = 1
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.name = "hasFinish"
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.full_name = ".AchievementTaskInfo.hasFinish"
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.number = 3
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.index = 2
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.label = 1
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.has_default_value = false
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.default_value = false
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.type = 8
var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD.cpp_type = 7
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.name = "new"
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.full_name = ".AchievementTaskInfo.new"
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.number = 4
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.index = 3
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.label = 1
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.has_default_value = false
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.default_value = false
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.type = 8
var_0_1.ACHIEVEMENTTASKINFONEWFIELD.cpp_type = 7
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.name = "finishTime"
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.full_name = ".AchievementTaskInfo.finishTime"
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.number = 5
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.index = 4
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.label = 1
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.has_default_value = false
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.default_value = 0
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.type = 5
var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD.cpp_type = 1
var_0_1.ACHIEVEMENTTASKINFO_MSG.name = "AchievementTaskInfo"
var_0_1.ACHIEVEMENTTASKINFO_MSG.full_name = ".AchievementTaskInfo"
var_0_1.ACHIEVEMENTTASKINFO_MSG.nested_types = {}
var_0_1.ACHIEVEMENTTASKINFO_MSG.enum_types = {}
var_0_1.ACHIEVEMENTTASKINFO_MSG.fields = {
	var_0_1.ACHIEVEMENTTASKINFOIDFIELD,
	var_0_1.ACHIEVEMENTTASKINFOPROGRESSFIELD,
	var_0_1.ACHIEVEMENTTASKINFOHASFINISHFIELD,
	var_0_1.ACHIEVEMENTTASKINFONEWFIELD,
	var_0_1.ACHIEVEMENTTASKINFOFINISHTIMEFIELD
}
var_0_1.ACHIEVEMENTTASKINFO_MSG.is_extendable = false
var_0_1.ACHIEVEMENTTASKINFO_MSG.extensions = {}
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.name = "ids"
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.full_name = ".ShowAchievementReply.ids"
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.number = 1
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.index = 0
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.label = 3
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.has_default_value = false
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.default_value = {}
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.type = 5
var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD.cpp_type = 1
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.name = "groupId"
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.full_name = ".ShowAchievementReply.groupId"
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.number = 2
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.index = 1
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.label = 1
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.has_default_value = false
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.default_value = 0
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.type = 5
var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD.cpp_type = 1
var_0_1.SHOWACHIEVEMENTREPLY_MSG.name = "ShowAchievementReply"
var_0_1.SHOWACHIEVEMENTREPLY_MSG.full_name = ".ShowAchievementReply"
var_0_1.SHOWACHIEVEMENTREPLY_MSG.nested_types = {}
var_0_1.SHOWACHIEVEMENTREPLY_MSG.enum_types = {}
var_0_1.SHOWACHIEVEMENTREPLY_MSG.fields = {
	var_0_1.SHOWACHIEVEMENTREPLYIDSFIELD,
	var_0_1.SHOWACHIEVEMENTREPLYGROUPIDFIELD
}
var_0_1.SHOWACHIEVEMENTREPLY_MSG.is_extendable = false
var_0_1.SHOWACHIEVEMENTREPLY_MSG.extensions = {}
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.name = "GetAchievementInfoRequest"
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.full_name = ".GetAchievementInfoRequest"
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.nested_types = {}
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.enum_types = {}
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.fields = {}
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.is_extendable = false
var_0_1.GETACHIEVEMENTINFOREQUEST_MSG.extensions = {}
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.name = "ids"
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.full_name = ".ReadNewAchievementRequest.ids"
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.number = 1
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.index = 0
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.label = 3
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.has_default_value = false
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.default_value = {}
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.type = 5
var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD.cpp_type = 1
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.name = "ReadNewAchievementRequest"
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.full_name = ".ReadNewAchievementRequest"
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.nested_types = {}
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.enum_types = {}
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.fields = {
	var_0_1.READNEWACHIEVEMENTREQUESTIDSFIELD
}
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.is_extendable = false
var_0_1.READNEWACHIEVEMENTREQUEST_MSG.extensions = {}
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.name = "ids"
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.full_name = ".ReadNewAchievementReply.ids"
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.number = 1
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.index = 0
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.label = 3
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.has_default_value = false
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.default_value = {}
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.type = 5
var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD.cpp_type = 1
var_0_1.READNEWACHIEVEMENTREPLY_MSG.name = "ReadNewAchievementReply"
var_0_1.READNEWACHIEVEMENTREPLY_MSG.full_name = ".ReadNewAchievementReply"
var_0_1.READNEWACHIEVEMENTREPLY_MSG.nested_types = {}
var_0_1.READNEWACHIEVEMENTREPLY_MSG.enum_types = {}
var_0_1.READNEWACHIEVEMENTREPLY_MSG.fields = {
	var_0_1.READNEWACHIEVEMENTREPLYIDSFIELD
}
var_0_1.READNEWACHIEVEMENTREPLY_MSG.is_extendable = false
var_0_1.READNEWACHIEVEMENTREPLY_MSG.extensions = {}
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.name = "ids"
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.full_name = ".ShowAchievementRequest.ids"
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.number = 1
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.index = 0
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.label = 3
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.has_default_value = false
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.default_value = {}
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.type = 5
var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD.cpp_type = 1
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.name = "groupId"
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.full_name = ".ShowAchievementRequest.groupId"
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.number = 2
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.index = 1
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.label = 1
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.has_default_value = false
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.default_value = 0
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.type = 5
var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD.cpp_type = 1
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.name = "ShowAchievementRequest"
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.full_name = ".ShowAchievementRequest"
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.nested_types = {}
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.enum_types = {}
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.fields = {
	var_0_1.SHOWACHIEVEMENTREQUESTIDSFIELD,
	var_0_1.SHOWACHIEVEMENTREQUESTGROUPIDFIELD
}
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.is_extendable = false
var_0_1.SHOWACHIEVEMENTREQUEST_MSG.extensions = {}
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.name = "infos"
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.full_name = ".GetAchievementInfoReply.infos"
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.number = 1
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.index = 0
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.label = 3
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.has_default_value = false
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.default_value = {}
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.message_type = var_0_1.ACHIEVEMENTTASKINFO_MSG
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.type = 11
var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD.cpp_type = 10
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.name = "GetAchievementInfoReply"
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.full_name = ".GetAchievementInfoReply"
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.nested_types = {}
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.enum_types = {}
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.fields = {
	var_0_1.GETACHIEVEMENTINFOREPLYINFOSFIELD
}
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.is_extendable = false
var_0_1.GETACHIEVEMENTINFOREPLY_MSG.extensions = {}
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.name = "infos"
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.full_name = ".UpdateAchievementPush.infos"
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.number = 1
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.index = 0
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.label = 3
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.has_default_value = false
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.default_value = {}
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.message_type = var_0_1.ACHIEVEMENTTASKINFO_MSG
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.type = 11
var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD.cpp_type = 10
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.name = "UpdateAchievementPush"
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.full_name = ".UpdateAchievementPush"
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.nested_types = {}
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.enum_types = {}
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.fields = {
	var_0_1.UPDATEACHIEVEMENTPUSHINFOSFIELD
}
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.is_extendable = false
var_0_1.UPDATEACHIEVEMENTPUSH_MSG.extensions = {}
var_0_1.AchievementTaskInfo = var_0_0.Message(var_0_1.ACHIEVEMENTTASKINFO_MSG)
var_0_1.GetAchievementInfoReply = var_0_0.Message(var_0_1.GETACHIEVEMENTINFOREPLY_MSG)
var_0_1.GetAchievementInfoRequest = var_0_0.Message(var_0_1.GETACHIEVEMENTINFOREQUEST_MSG)
var_0_1.ReadNewAchievementReply = var_0_0.Message(var_0_1.READNEWACHIEVEMENTREPLY_MSG)
var_0_1.ReadNewAchievementRequest = var_0_0.Message(var_0_1.READNEWACHIEVEMENTREQUEST_MSG)
var_0_1.ShowAchievementReply = var_0_0.Message(var_0_1.SHOWACHIEVEMENTREPLY_MSG)
var_0_1.ShowAchievementRequest = var_0_0.Message(var_0_1.SHOWACHIEVEMENTREQUEST_MSG)
var_0_1.UpdateAchievementPush = var_0_0.Message(var_0_1.UPDATEACHIEVEMENTPUSH_MSG)

return var_0_1
