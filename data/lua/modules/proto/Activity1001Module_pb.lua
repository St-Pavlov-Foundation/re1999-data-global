﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.Activity1001Module_pb", package.seeall)

local var_0_1 = {
	ACT1001UPDATEPUSH_MSG = var_0_0.Descriptor(),
	ACT1001UPDATEPUSHACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT1001UPDATEPUSHIDFIELD = var_0_0.FieldDescriptor(),
	ACT1001UPDATEPUSHSTATEFIELD = var_0_0.FieldDescriptor(),
	ACT1001GETINFOREQUEST_MSG = var_0_0.Descriptor(),
	ACT1001GETINFOREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT1001GETINFOREPLY_MSG = var_0_0.Descriptor(),
	ACT1001GETINFOREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT1001GETINFOREPLYACT1001INFOSFIELD = var_0_0.FieldDescriptor(),
	ACT1001INFO_MSG = var_0_0.Descriptor(),
	ACT1001INFOIDFIELD = var_0_0.FieldDescriptor(),
	ACT1001INFOSTATEFIELD = var_0_0.FieldDescriptor()
}

var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.full_name = ".Act1001UpdatePush.activityId"
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.number = 1
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.index = 0
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.label = 1
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.default_value = 0
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.type = 5
var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT1001UPDATEPUSHIDFIELD.name = "id"
var_0_1.ACT1001UPDATEPUSHIDFIELD.full_name = ".Act1001UpdatePush.id"
var_0_1.ACT1001UPDATEPUSHIDFIELD.number = 2
var_0_1.ACT1001UPDATEPUSHIDFIELD.index = 1
var_0_1.ACT1001UPDATEPUSHIDFIELD.label = 1
var_0_1.ACT1001UPDATEPUSHIDFIELD.has_default_value = false
var_0_1.ACT1001UPDATEPUSHIDFIELD.default_value = 0
var_0_1.ACT1001UPDATEPUSHIDFIELD.type = 5
var_0_1.ACT1001UPDATEPUSHIDFIELD.cpp_type = 1
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.name = "state"
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.full_name = ".Act1001UpdatePush.state"
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.number = 3
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.index = 2
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.label = 1
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.has_default_value = false
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.default_value = 0
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.type = 5
var_0_1.ACT1001UPDATEPUSHSTATEFIELD.cpp_type = 1
var_0_1.ACT1001UPDATEPUSH_MSG.name = "Act1001UpdatePush"
var_0_1.ACT1001UPDATEPUSH_MSG.full_name = ".Act1001UpdatePush"
var_0_1.ACT1001UPDATEPUSH_MSG.nested_types = {}
var_0_1.ACT1001UPDATEPUSH_MSG.enum_types = {}
var_0_1.ACT1001UPDATEPUSH_MSG.fields = {
	var_0_1.ACT1001UPDATEPUSHACTIVITYIDFIELD,
	var_0_1.ACT1001UPDATEPUSHIDFIELD,
	var_0_1.ACT1001UPDATEPUSHSTATEFIELD
}
var_0_1.ACT1001UPDATEPUSH_MSG.is_extendable = false
var_0_1.ACT1001UPDATEPUSH_MSG.extensions = {}
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.full_name = ".Act1001GetInfoRequest.activityId"
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.number = 1
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.index = 0
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.label = 1
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.type = 5
var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT1001GETINFOREQUEST_MSG.name = "Act1001GetInfoRequest"
var_0_1.ACT1001GETINFOREQUEST_MSG.full_name = ".Act1001GetInfoRequest"
var_0_1.ACT1001GETINFOREQUEST_MSG.nested_types = {}
var_0_1.ACT1001GETINFOREQUEST_MSG.enum_types = {}
var_0_1.ACT1001GETINFOREQUEST_MSG.fields = {
	var_0_1.ACT1001GETINFOREQUESTACTIVITYIDFIELD
}
var_0_1.ACT1001GETINFOREQUEST_MSG.is_extendable = false
var_0_1.ACT1001GETINFOREQUEST_MSG.extensions = {}
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.full_name = ".Act1001GetInfoReply.activityId"
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.number = 1
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.index = 0
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.label = 1
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.type = 5
var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.name = "act1001Infos"
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.full_name = ".Act1001GetInfoReply.act1001Infos"
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.number = 2
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.index = 1
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.label = 3
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.has_default_value = false
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.default_value = {}
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.message_type = var_0_1.ACT1001INFO_MSG
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.type = 11
var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD.cpp_type = 10
var_0_1.ACT1001GETINFOREPLY_MSG.name = "Act1001GetInfoReply"
var_0_1.ACT1001GETINFOREPLY_MSG.full_name = ".Act1001GetInfoReply"
var_0_1.ACT1001GETINFOREPLY_MSG.nested_types = {}
var_0_1.ACT1001GETINFOREPLY_MSG.enum_types = {}
var_0_1.ACT1001GETINFOREPLY_MSG.fields = {
	var_0_1.ACT1001GETINFOREPLYACTIVITYIDFIELD,
	var_0_1.ACT1001GETINFOREPLYACT1001INFOSFIELD
}
var_0_1.ACT1001GETINFOREPLY_MSG.is_extendable = false
var_0_1.ACT1001GETINFOREPLY_MSG.extensions = {}
var_0_1.ACT1001INFOIDFIELD.name = "id"
var_0_1.ACT1001INFOIDFIELD.full_name = ".Act1001Info.id"
var_0_1.ACT1001INFOIDFIELD.number = 1
var_0_1.ACT1001INFOIDFIELD.index = 0
var_0_1.ACT1001INFOIDFIELD.label = 1
var_0_1.ACT1001INFOIDFIELD.has_default_value = false
var_0_1.ACT1001INFOIDFIELD.default_value = 0
var_0_1.ACT1001INFOIDFIELD.type = 5
var_0_1.ACT1001INFOIDFIELD.cpp_type = 1
var_0_1.ACT1001INFOSTATEFIELD.name = "state"
var_0_1.ACT1001INFOSTATEFIELD.full_name = ".Act1001Info.state"
var_0_1.ACT1001INFOSTATEFIELD.number = 2
var_0_1.ACT1001INFOSTATEFIELD.index = 1
var_0_1.ACT1001INFOSTATEFIELD.label = 1
var_0_1.ACT1001INFOSTATEFIELD.has_default_value = false
var_0_1.ACT1001INFOSTATEFIELD.default_value = 0
var_0_1.ACT1001INFOSTATEFIELD.type = 5
var_0_1.ACT1001INFOSTATEFIELD.cpp_type = 1
var_0_1.ACT1001INFO_MSG.name = "Act1001Info"
var_0_1.ACT1001INFO_MSG.full_name = ".Act1001Info"
var_0_1.ACT1001INFO_MSG.nested_types = {}
var_0_1.ACT1001INFO_MSG.enum_types = {}
var_0_1.ACT1001INFO_MSG.fields = {
	var_0_1.ACT1001INFOIDFIELD,
	var_0_1.ACT1001INFOSTATEFIELD
}
var_0_1.ACT1001INFO_MSG.is_extendable = false
var_0_1.ACT1001INFO_MSG.extensions = {}
var_0_1.Act1001GetInfoReply = var_0_0.Message(var_0_1.ACT1001GETINFOREPLY_MSG)
var_0_1.Act1001GetInfoRequest = var_0_0.Message(var_0_1.ACT1001GETINFOREQUEST_MSG)
var_0_1.Act1001Info = var_0_0.Message(var_0_1.ACT1001INFO_MSG)
var_0_1.Act1001UpdatePush = var_0_0.Message(var_0_1.ACT1001UPDATEPUSH_MSG)

return var_0_1
