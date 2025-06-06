﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.TaskModule_pb", package.seeall)

local var_0_1 = {
	TASK_MSG = var_0_0.Descriptor(),
	TASKIDFIELD = var_0_0.FieldDescriptor(),
	TASKPROGRESSFIELD = var_0_0.FieldDescriptor(),
	TASKHASFINISHEDFIELD = var_0_0.FieldDescriptor(),
	TASKFINISHCOUNTFIELD = var_0_0.FieldDescriptor(),
	TASKTYPEFIELD = var_0_0.FieldDescriptor(),
	TASKEXPIRYTIMEFIELD = var_0_0.FieldDescriptor(),
	TASKACTIVITYINFO_MSG = var_0_0.Descriptor(),
	TASKACTIVITYINFOTYPEIDFIELD = var_0_0.FieldDescriptor(),
	TASKACTIVITYINFODEFINEIDFIELD = var_0_0.FieldDescriptor(),
	TASKACTIVITYINFOVALUEFIELD = var_0_0.FieldDescriptor(),
	TASKACTIVITYINFOGAINVALUEFIELD = var_0_0.FieldDescriptor(),
	TASKACTIVITYINFOEXPIRYTIMEFIELD = var_0_0.FieldDescriptor(),
	FINISHREADTASKREQUEST_MSG = var_0_0.Descriptor(),
	FINISHREADTASKREQUESTTASKIDFIELD = var_0_0.FieldDescriptor(),
	GETTASKINFOREQUEST_MSG = var_0_0.Descriptor(),
	GETTASKINFOREQUESTTYPEIDSFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREQUEST_MSG = var_0_0.Descriptor(),
	FINISHALLTASKREQUESTTYPEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREQUESTMINTYPEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREQUESTTASKIDSFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	GETTASKACTIVITYBONUSREPLY_MSG = var_0_0.Descriptor(),
	GETTASKACTIVITYBONUSREPLYTYPEIDFIELD = var_0_0.FieldDescriptor(),
	GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREPLY_MSG = var_0_0.Descriptor(),
	FINISHALLTASKREPLYTYPEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREPLYMINTYPEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREPLYTASKIDSFIELD = var_0_0.FieldDescriptor(),
	FINISHALLTASKREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	GETTASKACTIVITYBONUSREQUEST_MSG = var_0_0.Descriptor(),
	GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD = var_0_0.FieldDescriptor(),
	GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD = var_0_0.FieldDescriptor(),
	FINISHREADTASKREPLY_MSG = var_0_0.Descriptor(),
	FINISHREADTASKREPLYTASKIDFIELD = var_0_0.FieldDescriptor(),
	UPDATETASKPUSH_MSG = var_0_0.Descriptor(),
	UPDATETASKPUSHTASKINFOFIELD = var_0_0.FieldDescriptor(),
	UPDATETASKPUSHACTIVITYINFOFIELD = var_0_0.FieldDescriptor(),
	FINISHTASKREQUEST_MSG = var_0_0.Descriptor(),
	FINISHTASKREQUESTIDFIELD = var_0_0.FieldDescriptor(),
	FINISHTASKREPLY_MSG = var_0_0.Descriptor(),
	FINISHTASKREPLYIDFIELD = var_0_0.FieldDescriptor(),
	FINISHTASKREPLYFINISHCOUNTFIELD = var_0_0.FieldDescriptor(),
	DELETETASKPUSH_MSG = var_0_0.Descriptor(),
	DELETETASKPUSHTASKIDSFIELD = var_0_0.FieldDescriptor(),
	GETTASKINFOREPLY_MSG = var_0_0.Descriptor(),
	GETTASKINFOREPLYTASKINFOFIELD = var_0_0.FieldDescriptor(),
	GETTASKINFOREPLYACTIVITYINFOFIELD = var_0_0.FieldDescriptor(),
	GETTASKINFOREPLYTYPEIDSFIELD = var_0_0.FieldDescriptor()
}

var_0_1.TASKIDFIELD.name = "id"
var_0_1.TASKIDFIELD.full_name = ".Task.id"
var_0_1.TASKIDFIELD.number = 1
var_0_1.TASKIDFIELD.index = 0
var_0_1.TASKIDFIELD.label = 2
var_0_1.TASKIDFIELD.has_default_value = false
var_0_1.TASKIDFIELD.default_value = 0
var_0_1.TASKIDFIELD.type = 5
var_0_1.TASKIDFIELD.cpp_type = 1
var_0_1.TASKPROGRESSFIELD.name = "progress"
var_0_1.TASKPROGRESSFIELD.full_name = ".Task.progress"
var_0_1.TASKPROGRESSFIELD.number = 2
var_0_1.TASKPROGRESSFIELD.index = 1
var_0_1.TASKPROGRESSFIELD.label = 2
var_0_1.TASKPROGRESSFIELD.has_default_value = false
var_0_1.TASKPROGRESSFIELD.default_value = 0
var_0_1.TASKPROGRESSFIELD.type = 5
var_0_1.TASKPROGRESSFIELD.cpp_type = 1
var_0_1.TASKHASFINISHEDFIELD.name = "hasFinished"
var_0_1.TASKHASFINISHEDFIELD.full_name = ".Task.hasFinished"
var_0_1.TASKHASFINISHEDFIELD.number = 3
var_0_1.TASKHASFINISHEDFIELD.index = 2
var_0_1.TASKHASFINISHEDFIELD.label = 2
var_0_1.TASKHASFINISHEDFIELD.has_default_value = false
var_0_1.TASKHASFINISHEDFIELD.default_value = false
var_0_1.TASKHASFINISHEDFIELD.type = 8
var_0_1.TASKHASFINISHEDFIELD.cpp_type = 7
var_0_1.TASKFINISHCOUNTFIELD.name = "finishCount"
var_0_1.TASKFINISHCOUNTFIELD.full_name = ".Task.finishCount"
var_0_1.TASKFINISHCOUNTFIELD.number = 4
var_0_1.TASKFINISHCOUNTFIELD.index = 3
var_0_1.TASKFINISHCOUNTFIELD.label = 1
var_0_1.TASKFINISHCOUNTFIELD.has_default_value = false
var_0_1.TASKFINISHCOUNTFIELD.default_value = 0
var_0_1.TASKFINISHCOUNTFIELD.type = 5
var_0_1.TASKFINISHCOUNTFIELD.cpp_type = 1
var_0_1.TASKTYPEFIELD.name = "type"
var_0_1.TASKTYPEFIELD.full_name = ".Task.type"
var_0_1.TASKTYPEFIELD.number = 5
var_0_1.TASKTYPEFIELD.index = 4
var_0_1.TASKTYPEFIELD.label = 1
var_0_1.TASKTYPEFIELD.has_default_value = false
var_0_1.TASKTYPEFIELD.default_value = 0
var_0_1.TASKTYPEFIELD.type = 5
var_0_1.TASKTYPEFIELD.cpp_type = 1
var_0_1.TASKEXPIRYTIMEFIELD.name = "expiryTime"
var_0_1.TASKEXPIRYTIMEFIELD.full_name = ".Task.expiryTime"
var_0_1.TASKEXPIRYTIMEFIELD.number = 6
var_0_1.TASKEXPIRYTIMEFIELD.index = 5
var_0_1.TASKEXPIRYTIMEFIELD.label = 1
var_0_1.TASKEXPIRYTIMEFIELD.has_default_value = false
var_0_1.TASKEXPIRYTIMEFIELD.default_value = 0
var_0_1.TASKEXPIRYTIMEFIELD.type = 5
var_0_1.TASKEXPIRYTIMEFIELD.cpp_type = 1
var_0_1.TASK_MSG.name = "Task"
var_0_1.TASK_MSG.full_name = ".Task"
var_0_1.TASK_MSG.nested_types = {}
var_0_1.TASK_MSG.enum_types = {}
var_0_1.TASK_MSG.fields = {
	var_0_1.TASKIDFIELD,
	var_0_1.TASKPROGRESSFIELD,
	var_0_1.TASKHASFINISHEDFIELD,
	var_0_1.TASKFINISHCOUNTFIELD,
	var_0_1.TASKTYPEFIELD,
	var_0_1.TASKEXPIRYTIMEFIELD
}
var_0_1.TASK_MSG.is_extendable = false
var_0_1.TASK_MSG.extensions = {}
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.name = "typeId"
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.full_name = ".TaskActivityInfo.typeId"
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.number = 1
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.index = 0
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.label = 2
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.has_default_value = false
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.default_value = 0
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.type = 5
var_0_1.TASKACTIVITYINFOTYPEIDFIELD.cpp_type = 1
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.name = "defineId"
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.full_name = ".TaskActivityInfo.defineId"
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.number = 2
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.index = 1
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.label = 2
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.has_default_value = false
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.default_value = 0
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.type = 5
var_0_1.TASKACTIVITYINFODEFINEIDFIELD.cpp_type = 1
var_0_1.TASKACTIVITYINFOVALUEFIELD.name = "value"
var_0_1.TASKACTIVITYINFOVALUEFIELD.full_name = ".TaskActivityInfo.value"
var_0_1.TASKACTIVITYINFOVALUEFIELD.number = 3
var_0_1.TASKACTIVITYINFOVALUEFIELD.index = 2
var_0_1.TASKACTIVITYINFOVALUEFIELD.label = 2
var_0_1.TASKACTIVITYINFOVALUEFIELD.has_default_value = false
var_0_1.TASKACTIVITYINFOVALUEFIELD.default_value = 0
var_0_1.TASKACTIVITYINFOVALUEFIELD.type = 5
var_0_1.TASKACTIVITYINFOVALUEFIELD.cpp_type = 1
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.name = "gainValue"
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.full_name = ".TaskActivityInfo.gainValue"
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.number = 4
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.index = 3
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.label = 1
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.has_default_value = false
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.default_value = 0
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.type = 5
var_0_1.TASKACTIVITYINFOGAINVALUEFIELD.cpp_type = 1
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.name = "expiryTime"
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.full_name = ".TaskActivityInfo.expiryTime"
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.number = 5
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.index = 4
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.label = 2
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.has_default_value = false
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.default_value = 0
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.type = 5
var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD.cpp_type = 1
var_0_1.TASKACTIVITYINFO_MSG.name = "TaskActivityInfo"
var_0_1.TASKACTIVITYINFO_MSG.full_name = ".TaskActivityInfo"
var_0_1.TASKACTIVITYINFO_MSG.nested_types = {}
var_0_1.TASKACTIVITYINFO_MSG.enum_types = {}
var_0_1.TASKACTIVITYINFO_MSG.fields = {
	var_0_1.TASKACTIVITYINFOTYPEIDFIELD,
	var_0_1.TASKACTIVITYINFODEFINEIDFIELD,
	var_0_1.TASKACTIVITYINFOVALUEFIELD,
	var_0_1.TASKACTIVITYINFOGAINVALUEFIELD,
	var_0_1.TASKACTIVITYINFOEXPIRYTIMEFIELD
}
var_0_1.TASKACTIVITYINFO_MSG.is_extendable = false
var_0_1.TASKACTIVITYINFO_MSG.extensions = {}
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.name = "taskId"
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.full_name = ".FinishReadTaskRequest.taskId"
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.number = 1
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.index = 0
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.label = 1
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.has_default_value = false
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.default_value = 0
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.type = 5
var_0_1.FINISHREADTASKREQUESTTASKIDFIELD.cpp_type = 1
var_0_1.FINISHREADTASKREQUEST_MSG.name = "FinishReadTaskRequest"
var_0_1.FINISHREADTASKREQUEST_MSG.full_name = ".FinishReadTaskRequest"
var_0_1.FINISHREADTASKREQUEST_MSG.nested_types = {}
var_0_1.FINISHREADTASKREQUEST_MSG.enum_types = {}
var_0_1.FINISHREADTASKREQUEST_MSG.fields = {
	var_0_1.FINISHREADTASKREQUESTTASKIDFIELD
}
var_0_1.FINISHREADTASKREQUEST_MSG.is_extendable = false
var_0_1.FINISHREADTASKREQUEST_MSG.extensions = {}
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.name = "typeIds"
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.full_name = ".GetTaskInfoRequest.typeIds"
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.number = 1
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.index = 0
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.label = 3
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.has_default_value = false
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.default_value = {}
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.type = 13
var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD.cpp_type = 3
var_0_1.GETTASKINFOREQUEST_MSG.name = "GetTaskInfoRequest"
var_0_1.GETTASKINFOREQUEST_MSG.full_name = ".GetTaskInfoRequest"
var_0_1.GETTASKINFOREQUEST_MSG.nested_types = {}
var_0_1.GETTASKINFOREQUEST_MSG.enum_types = {}
var_0_1.GETTASKINFOREQUEST_MSG.fields = {
	var_0_1.GETTASKINFOREQUESTTYPEIDSFIELD
}
var_0_1.GETTASKINFOREQUEST_MSG.is_extendable = false
var_0_1.GETTASKINFOREQUEST_MSG.extensions = {}
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.name = "typeId"
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.full_name = ".FinishAllTaskRequest.typeId"
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.number = 1
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.index = 0
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.label = 1
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.type = 5
var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.name = "minTypeId"
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.full_name = ".FinishAllTaskRequest.minTypeId"
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.number = 2
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.index = 1
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.label = 1
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.type = 5
var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.name = "taskIds"
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.full_name = ".FinishAllTaskRequest.taskIds"
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.number = 3
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.index = 2
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.label = 3
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.has_default_value = false
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.default_value = {}
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.type = 5
var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.full_name = ".FinishAllTaskRequest.activityId"
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.number = 4
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.index = 3
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.label = 1
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.type = 5
var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREQUEST_MSG.name = "FinishAllTaskRequest"
var_0_1.FINISHALLTASKREQUEST_MSG.full_name = ".FinishAllTaskRequest"
var_0_1.FINISHALLTASKREQUEST_MSG.nested_types = {}
var_0_1.FINISHALLTASKREQUEST_MSG.enum_types = {}
var_0_1.FINISHALLTASKREQUEST_MSG.fields = {
	var_0_1.FINISHALLTASKREQUESTTYPEIDFIELD,
	var_0_1.FINISHALLTASKREQUESTMINTYPEIDFIELD,
	var_0_1.FINISHALLTASKREQUESTTASKIDSFIELD,
	var_0_1.FINISHALLTASKREQUESTACTIVITYIDFIELD
}
var_0_1.FINISHALLTASKREQUEST_MSG.is_extendable = false
var_0_1.FINISHALLTASKREQUEST_MSG.extensions = {}
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.name = "typeId"
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.full_name = ".GetTaskActivityBonusReply.typeId"
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.number = 1
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.index = 0
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.label = 1
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.has_default_value = false
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.default_value = 0
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.type = 5
var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.cpp_type = 1
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.name = "defineId"
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.full_name = ".GetTaskActivityBonusReply.defineId"
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.number = 2
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.index = 1
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.label = 1
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.has_default_value = false
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.default_value = 0
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.type = 5
var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.cpp_type = 1
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.name = "GetTaskActivityBonusReply"
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.full_name = ".GetTaskActivityBonusReply"
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.nested_types = {}
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.enum_types = {}
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.fields = {
	var_0_1.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD,
	var_0_1.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD
}
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.is_extendable = false
var_0_1.GETTASKACTIVITYBONUSREPLY_MSG.extensions = {}
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.name = "typeId"
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.full_name = ".FinishAllTaskReply.typeId"
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.number = 1
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.index = 0
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.label = 1
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.type = 5
var_0_1.FINISHALLTASKREPLYTYPEIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.name = "minTypeId"
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.full_name = ".FinishAllTaskReply.minTypeId"
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.number = 2
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.index = 1
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.label = 1
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.type = 5
var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.name = "taskIds"
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.full_name = ".FinishAllTaskReply.taskIds"
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.number = 3
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.index = 2
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.label = 3
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.has_default_value = false
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.default_value = {}
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.type = 5
var_0_1.FINISHALLTASKREPLYTASKIDSFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.full_name = ".FinishAllTaskReply.activityId"
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.number = 4
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.index = 3
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.label = 1
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.type = 5
var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.FINISHALLTASKREPLY_MSG.name = "FinishAllTaskReply"
var_0_1.FINISHALLTASKREPLY_MSG.full_name = ".FinishAllTaskReply"
var_0_1.FINISHALLTASKREPLY_MSG.nested_types = {}
var_0_1.FINISHALLTASKREPLY_MSG.enum_types = {}
var_0_1.FINISHALLTASKREPLY_MSG.fields = {
	var_0_1.FINISHALLTASKREPLYTYPEIDFIELD,
	var_0_1.FINISHALLTASKREPLYMINTYPEIDFIELD,
	var_0_1.FINISHALLTASKREPLYTASKIDSFIELD,
	var_0_1.FINISHALLTASKREPLYACTIVITYIDFIELD
}
var_0_1.FINISHALLTASKREPLY_MSG.is_extendable = false
var_0_1.FINISHALLTASKREPLY_MSG.extensions = {}
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.name = "typeId"
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.full_name = ".GetTaskActivityBonusRequest.typeId"
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.number = 1
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.index = 0
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.label = 1
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.has_default_value = false
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.default_value = 0
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.type = 5
var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.cpp_type = 1
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.name = "defineId"
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.full_name = ".GetTaskActivityBonusRequest.defineId"
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.number = 2
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.index = 1
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.label = 1
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.has_default_value = false
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.default_value = 0
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.type = 5
var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.cpp_type = 1
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.name = "GetTaskActivityBonusRequest"
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.full_name = ".GetTaskActivityBonusRequest"
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.nested_types = {}
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.enum_types = {}
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.fields = {
	var_0_1.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD,
	var_0_1.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD
}
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.is_extendable = false
var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG.extensions = {}
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.name = "taskId"
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.full_name = ".FinishReadTaskReply.taskId"
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.number = 1
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.index = 0
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.label = 1
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.has_default_value = false
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.default_value = 0
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.type = 5
var_0_1.FINISHREADTASKREPLYTASKIDFIELD.cpp_type = 1
var_0_1.FINISHREADTASKREPLY_MSG.name = "FinishReadTaskReply"
var_0_1.FINISHREADTASKREPLY_MSG.full_name = ".FinishReadTaskReply"
var_0_1.FINISHREADTASKREPLY_MSG.nested_types = {}
var_0_1.FINISHREADTASKREPLY_MSG.enum_types = {}
var_0_1.FINISHREADTASKREPLY_MSG.fields = {
	var_0_1.FINISHREADTASKREPLYTASKIDFIELD
}
var_0_1.FINISHREADTASKREPLY_MSG.is_extendable = false
var_0_1.FINISHREADTASKREPLY_MSG.extensions = {}
var_0_1.UPDATETASKPUSHTASKINFOFIELD.name = "taskInfo"
var_0_1.UPDATETASKPUSHTASKINFOFIELD.full_name = ".UpdateTaskPush.taskInfo"
var_0_1.UPDATETASKPUSHTASKINFOFIELD.number = 1
var_0_1.UPDATETASKPUSHTASKINFOFIELD.index = 0
var_0_1.UPDATETASKPUSHTASKINFOFIELD.label = 3
var_0_1.UPDATETASKPUSHTASKINFOFIELD.has_default_value = false
var_0_1.UPDATETASKPUSHTASKINFOFIELD.default_value = {}
var_0_1.UPDATETASKPUSHTASKINFOFIELD.message_type = var_0_1.TASK_MSG
var_0_1.UPDATETASKPUSHTASKINFOFIELD.type = 11
var_0_1.UPDATETASKPUSHTASKINFOFIELD.cpp_type = 10
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.name = "activityInfo"
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.full_name = ".UpdateTaskPush.activityInfo"
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.number = 2
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.index = 1
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.label = 3
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.has_default_value = false
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.default_value = {}
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.message_type = var_0_1.TASKACTIVITYINFO_MSG
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.type = 11
var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD.cpp_type = 10
var_0_1.UPDATETASKPUSH_MSG.name = "UpdateTaskPush"
var_0_1.UPDATETASKPUSH_MSG.full_name = ".UpdateTaskPush"
var_0_1.UPDATETASKPUSH_MSG.nested_types = {}
var_0_1.UPDATETASKPUSH_MSG.enum_types = {}
var_0_1.UPDATETASKPUSH_MSG.fields = {
	var_0_1.UPDATETASKPUSHTASKINFOFIELD,
	var_0_1.UPDATETASKPUSHACTIVITYINFOFIELD
}
var_0_1.UPDATETASKPUSH_MSG.is_extendable = false
var_0_1.UPDATETASKPUSH_MSG.extensions = {}
var_0_1.FINISHTASKREQUESTIDFIELD.name = "id"
var_0_1.FINISHTASKREQUESTIDFIELD.full_name = ".FinishTaskRequest.id"
var_0_1.FINISHTASKREQUESTIDFIELD.number = 1
var_0_1.FINISHTASKREQUESTIDFIELD.index = 0
var_0_1.FINISHTASKREQUESTIDFIELD.label = 2
var_0_1.FINISHTASKREQUESTIDFIELD.has_default_value = false
var_0_1.FINISHTASKREQUESTIDFIELD.default_value = 0
var_0_1.FINISHTASKREQUESTIDFIELD.type = 5
var_0_1.FINISHTASKREQUESTIDFIELD.cpp_type = 1
var_0_1.FINISHTASKREQUEST_MSG.name = "FinishTaskRequest"
var_0_1.FINISHTASKREQUEST_MSG.full_name = ".FinishTaskRequest"
var_0_1.FINISHTASKREQUEST_MSG.nested_types = {}
var_0_1.FINISHTASKREQUEST_MSG.enum_types = {}
var_0_1.FINISHTASKREQUEST_MSG.fields = {
	var_0_1.FINISHTASKREQUESTIDFIELD
}
var_0_1.FINISHTASKREQUEST_MSG.is_extendable = false
var_0_1.FINISHTASKREQUEST_MSG.extensions = {}
var_0_1.FINISHTASKREPLYIDFIELD.name = "id"
var_0_1.FINISHTASKREPLYIDFIELD.full_name = ".FinishTaskReply.id"
var_0_1.FINISHTASKREPLYIDFIELD.number = 1
var_0_1.FINISHTASKREPLYIDFIELD.index = 0
var_0_1.FINISHTASKREPLYIDFIELD.label = 1
var_0_1.FINISHTASKREPLYIDFIELD.has_default_value = false
var_0_1.FINISHTASKREPLYIDFIELD.default_value = 0
var_0_1.FINISHTASKREPLYIDFIELD.type = 5
var_0_1.FINISHTASKREPLYIDFIELD.cpp_type = 1
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.name = "finishCount"
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.full_name = ".FinishTaskReply.finishCount"
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.number = 2
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.index = 1
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.label = 1
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.has_default_value = false
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.default_value = 0
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.type = 5
var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD.cpp_type = 1
var_0_1.FINISHTASKREPLY_MSG.name = "FinishTaskReply"
var_0_1.FINISHTASKREPLY_MSG.full_name = ".FinishTaskReply"
var_0_1.FINISHTASKREPLY_MSG.nested_types = {}
var_0_1.FINISHTASKREPLY_MSG.enum_types = {}
var_0_1.FINISHTASKREPLY_MSG.fields = {
	var_0_1.FINISHTASKREPLYIDFIELD,
	var_0_1.FINISHTASKREPLYFINISHCOUNTFIELD
}
var_0_1.FINISHTASKREPLY_MSG.is_extendable = false
var_0_1.FINISHTASKREPLY_MSG.extensions = {}
var_0_1.DELETETASKPUSHTASKIDSFIELD.name = "taskIds"
var_0_1.DELETETASKPUSHTASKIDSFIELD.full_name = ".DeleteTaskPush.taskIds"
var_0_1.DELETETASKPUSHTASKIDSFIELD.number = 1
var_0_1.DELETETASKPUSHTASKIDSFIELD.index = 0
var_0_1.DELETETASKPUSHTASKIDSFIELD.label = 3
var_0_1.DELETETASKPUSHTASKIDSFIELD.has_default_value = false
var_0_1.DELETETASKPUSHTASKIDSFIELD.default_value = {}
var_0_1.DELETETASKPUSHTASKIDSFIELD.type = 5
var_0_1.DELETETASKPUSHTASKIDSFIELD.cpp_type = 1
var_0_1.DELETETASKPUSH_MSG.name = "DeleteTaskPush"
var_0_1.DELETETASKPUSH_MSG.full_name = ".DeleteTaskPush"
var_0_1.DELETETASKPUSH_MSG.nested_types = {}
var_0_1.DELETETASKPUSH_MSG.enum_types = {}
var_0_1.DELETETASKPUSH_MSG.fields = {
	var_0_1.DELETETASKPUSHTASKIDSFIELD
}
var_0_1.DELETETASKPUSH_MSG.is_extendable = false
var_0_1.DELETETASKPUSH_MSG.extensions = {}
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.name = "taskInfo"
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.full_name = ".GetTaskInfoReply.taskInfo"
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.number = 1
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.index = 0
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.label = 3
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.has_default_value = false
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.default_value = {}
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.message_type = var_0_1.TASK_MSG
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.type = 11
var_0_1.GETTASKINFOREPLYTASKINFOFIELD.cpp_type = 10
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.name = "activityInfo"
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.full_name = ".GetTaskInfoReply.activityInfo"
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.number = 2
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.index = 1
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.label = 3
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.has_default_value = false
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.default_value = {}
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.message_type = var_0_1.TASKACTIVITYINFO_MSG
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.type = 11
var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD.cpp_type = 10
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.name = "typeIds"
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.full_name = ".GetTaskInfoReply.typeIds"
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.number = 3
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.index = 2
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.label = 3
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.has_default_value = false
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.default_value = {}
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.type = 13
var_0_1.GETTASKINFOREPLYTYPEIDSFIELD.cpp_type = 3
var_0_1.GETTASKINFOREPLY_MSG.name = "GetTaskInfoReply"
var_0_1.GETTASKINFOREPLY_MSG.full_name = ".GetTaskInfoReply"
var_0_1.GETTASKINFOREPLY_MSG.nested_types = {}
var_0_1.GETTASKINFOREPLY_MSG.enum_types = {}
var_0_1.GETTASKINFOREPLY_MSG.fields = {
	var_0_1.GETTASKINFOREPLYTASKINFOFIELD,
	var_0_1.GETTASKINFOREPLYACTIVITYINFOFIELD,
	var_0_1.GETTASKINFOREPLYTYPEIDSFIELD
}
var_0_1.GETTASKINFOREPLY_MSG.is_extendable = false
var_0_1.GETTASKINFOREPLY_MSG.extensions = {}
var_0_1.DeleteTaskPush = var_0_0.Message(var_0_1.DELETETASKPUSH_MSG)
var_0_1.FinishAllTaskReply = var_0_0.Message(var_0_1.FINISHALLTASKREPLY_MSG)
var_0_1.FinishAllTaskRequest = var_0_0.Message(var_0_1.FINISHALLTASKREQUEST_MSG)
var_0_1.FinishReadTaskReply = var_0_0.Message(var_0_1.FINISHREADTASKREPLY_MSG)
var_0_1.FinishReadTaskRequest = var_0_0.Message(var_0_1.FINISHREADTASKREQUEST_MSG)
var_0_1.FinishTaskReply = var_0_0.Message(var_0_1.FINISHTASKREPLY_MSG)
var_0_1.FinishTaskRequest = var_0_0.Message(var_0_1.FINISHTASKREQUEST_MSG)
var_0_1.GetTaskActivityBonusReply = var_0_0.Message(var_0_1.GETTASKACTIVITYBONUSREPLY_MSG)
var_0_1.GetTaskActivityBonusRequest = var_0_0.Message(var_0_1.GETTASKACTIVITYBONUSREQUEST_MSG)
var_0_1.GetTaskInfoReply = var_0_0.Message(var_0_1.GETTASKINFOREPLY_MSG)
var_0_1.GetTaskInfoRequest = var_0_0.Message(var_0_1.GETTASKINFOREQUEST_MSG)
var_0_1.Task = var_0_0.Message(var_0_1.TASK_MSG)
var_0_1.TaskActivityInfo = var_0_0.Message(var_0_1.TASKACTIVITYINFO_MSG)
var_0_1.UpdateTaskPush = var_0_0.Message(var_0_1.UPDATETASKPUSH_MSG)

return var_0_1
