-- chunkname: @modules/proto/Activity1001Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity1001Module_pb", package.seeall)

local Activity1001Module_pb = {}

Activity1001Module_pb.ACT1001UPDATEPUSH_MSG = protobuf.Descriptor()
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG = protobuf.Descriptor()
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG = protobuf.Descriptor()
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001INFO_MSG = protobuf.Descriptor()
Activity1001Module_pb.ACT1001INFOIDFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001INFOSTATEFIELD = protobuf.FieldDescriptor()
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.name = "activityId"
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.full_name = ".Act1001UpdatePush.activityId"
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.number = 1
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.index = 0
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.label = 1
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.has_default_value = false
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.default_value = 0
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.type = 5
Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.name = "id"
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.full_name = ".Act1001UpdatePush.id"
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.number = 2
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.index = 1
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.label = 1
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.has_default_value = false
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.default_value = 0
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.type = 5
Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.name = "state"
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.full_name = ".Act1001UpdatePush.state"
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.number = 3
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.index = 2
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.label = 1
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.has_default_value = false
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.default_value = 0
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.type = 5
Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.name = "Act1001UpdatePush"
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.full_name = ".Act1001UpdatePush"
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.nested_types = {}
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.enum_types = {}
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.fields = {
	Activity1001Module_pb.ACT1001UPDATEPUSHACTIVITYIDFIELD,
	Activity1001Module_pb.ACT1001UPDATEPUSHIDFIELD,
	Activity1001Module_pb.ACT1001UPDATEPUSHSTATEFIELD
}
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.is_extendable = false
Activity1001Module_pb.ACT1001UPDATEPUSH_MSG.extensions = {}
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.full_name = ".Act1001GetInfoRequest.activityId"
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.number = 1
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.index = 0
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.label = 1
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.type = 5
Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.name = "Act1001GetInfoRequest"
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.full_name = ".Act1001GetInfoRequest"
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.nested_types = {}
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.enum_types = {}
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.fields = {
	Activity1001Module_pb.ACT1001GETINFOREQUESTACTIVITYIDFIELD
}
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.is_extendable = false
Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG.extensions = {}
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.full_name = ".Act1001GetInfoReply.activityId"
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.number = 1
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.index = 0
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.label = 1
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.default_value = 0
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.type = 5
Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.name = "act1001Infos"
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.full_name = ".Act1001GetInfoReply.act1001Infos"
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.number = 2
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.index = 1
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.label = 3
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.has_default_value = false
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.default_value = {}
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.message_type = Activity1001Module_pb.ACT1001INFO_MSG
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.type = 11
Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD.cpp_type = 10
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.name = "Act1001GetInfoReply"
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.full_name = ".Act1001GetInfoReply"
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.nested_types = {}
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.enum_types = {}
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.fields = {
	Activity1001Module_pb.ACT1001GETINFOREPLYACTIVITYIDFIELD,
	Activity1001Module_pb.ACT1001GETINFOREPLYACT1001INFOSFIELD
}
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.is_extendable = false
Activity1001Module_pb.ACT1001GETINFOREPLY_MSG.extensions = {}
Activity1001Module_pb.ACT1001INFOIDFIELD.name = "id"
Activity1001Module_pb.ACT1001INFOIDFIELD.full_name = ".Act1001Info.id"
Activity1001Module_pb.ACT1001INFOIDFIELD.number = 1
Activity1001Module_pb.ACT1001INFOIDFIELD.index = 0
Activity1001Module_pb.ACT1001INFOIDFIELD.label = 1
Activity1001Module_pb.ACT1001INFOIDFIELD.has_default_value = false
Activity1001Module_pb.ACT1001INFOIDFIELD.default_value = 0
Activity1001Module_pb.ACT1001INFOIDFIELD.type = 5
Activity1001Module_pb.ACT1001INFOIDFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001INFOSTATEFIELD.name = "state"
Activity1001Module_pb.ACT1001INFOSTATEFIELD.full_name = ".Act1001Info.state"
Activity1001Module_pb.ACT1001INFOSTATEFIELD.number = 2
Activity1001Module_pb.ACT1001INFOSTATEFIELD.index = 1
Activity1001Module_pb.ACT1001INFOSTATEFIELD.label = 1
Activity1001Module_pb.ACT1001INFOSTATEFIELD.has_default_value = false
Activity1001Module_pb.ACT1001INFOSTATEFIELD.default_value = 0
Activity1001Module_pb.ACT1001INFOSTATEFIELD.type = 5
Activity1001Module_pb.ACT1001INFOSTATEFIELD.cpp_type = 1
Activity1001Module_pb.ACT1001INFO_MSG.name = "Act1001Info"
Activity1001Module_pb.ACT1001INFO_MSG.full_name = ".Act1001Info"
Activity1001Module_pb.ACT1001INFO_MSG.nested_types = {}
Activity1001Module_pb.ACT1001INFO_MSG.enum_types = {}
Activity1001Module_pb.ACT1001INFO_MSG.fields = {
	Activity1001Module_pb.ACT1001INFOIDFIELD,
	Activity1001Module_pb.ACT1001INFOSTATEFIELD
}
Activity1001Module_pb.ACT1001INFO_MSG.is_extendable = false
Activity1001Module_pb.ACT1001INFO_MSG.extensions = {}
Activity1001Module_pb.Act1001GetInfoReply = protobuf.Message(Activity1001Module_pb.ACT1001GETINFOREPLY_MSG)
Activity1001Module_pb.Act1001GetInfoRequest = protobuf.Message(Activity1001Module_pb.ACT1001GETINFOREQUEST_MSG)
Activity1001Module_pb.Act1001Info = protobuf.Message(Activity1001Module_pb.ACT1001INFO_MSG)
Activity1001Module_pb.Act1001UpdatePush = protobuf.Message(Activity1001Module_pb.ACT1001UPDATEPUSH_MSG)

return Activity1001Module_pb
