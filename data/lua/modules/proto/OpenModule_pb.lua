local var_0_0 = require("protobuf.protobuf")

module("modules.proto.OpenModule_pb", package.seeall)

local var_0_1 = {
	OPENINFO_MSG = var_0_0.Descriptor(),
	OPENINFOIDFIELD = var_0_0.FieldDescriptor(),
	OPENINFOISOPENFIELD = var_0_0.FieldDescriptor(),
	UPDATEOPENPUSH_MSG = var_0_0.Descriptor(),
	UPDATEOPENPUSHOPENINFOSFIELD = var_0_0.FieldDescriptor()
}

var_0_1.OPENINFOIDFIELD.name = "id"
var_0_1.OPENINFOIDFIELD.full_name = ".OpenInfo.id"
var_0_1.OPENINFOIDFIELD.number = 1
var_0_1.OPENINFOIDFIELD.index = 0
var_0_1.OPENINFOIDFIELD.label = 2
var_0_1.OPENINFOIDFIELD.has_default_value = false
var_0_1.OPENINFOIDFIELD.default_value = 0
var_0_1.OPENINFOIDFIELD.type = 5
var_0_1.OPENINFOIDFIELD.cpp_type = 1
var_0_1.OPENINFOISOPENFIELD.name = "isOpen"
var_0_1.OPENINFOISOPENFIELD.full_name = ".OpenInfo.isOpen"
var_0_1.OPENINFOISOPENFIELD.number = 2
var_0_1.OPENINFOISOPENFIELD.index = 1
var_0_1.OPENINFOISOPENFIELD.label = 2
var_0_1.OPENINFOISOPENFIELD.has_default_value = false
var_0_1.OPENINFOISOPENFIELD.default_value = false
var_0_1.OPENINFOISOPENFIELD.type = 8
var_0_1.OPENINFOISOPENFIELD.cpp_type = 7
var_0_1.OPENINFO_MSG.name = "OpenInfo"
var_0_1.OPENINFO_MSG.full_name = ".OpenInfo"
var_0_1.OPENINFO_MSG.nested_types = {}
var_0_1.OPENINFO_MSG.enum_types = {}
var_0_1.OPENINFO_MSG.fields = {
	var_0_1.OPENINFOIDFIELD,
	var_0_1.OPENINFOISOPENFIELD
}
var_0_1.OPENINFO_MSG.is_extendable = false
var_0_1.OPENINFO_MSG.extensions = {}
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.name = "openInfos"
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.full_name = ".UpdateOpenPush.openInfos"
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.number = 1
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.index = 0
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.label = 3
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.has_default_value = false
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.default_value = {}
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.message_type = var_0_1.OPENINFO_MSG
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.type = 11
var_0_1.UPDATEOPENPUSHOPENINFOSFIELD.cpp_type = 10
var_0_1.UPDATEOPENPUSH_MSG.name = "UpdateOpenPush"
var_0_1.UPDATEOPENPUSH_MSG.full_name = ".UpdateOpenPush"
var_0_1.UPDATEOPENPUSH_MSG.nested_types = {}
var_0_1.UPDATEOPENPUSH_MSG.enum_types = {}
var_0_1.UPDATEOPENPUSH_MSG.fields = {
	var_0_1.UPDATEOPENPUSHOPENINFOSFIELD
}
var_0_1.UPDATEOPENPUSH_MSG.is_extendable = false
var_0_1.UPDATEOPENPUSH_MSG.extensions = {}
var_0_1.OpenInfo = var_0_0.Message(var_0_1.OPENINFO_MSG)
var_0_1.UpdateOpenPush = var_0_0.Message(var_0_1.UPDATEOPENPUSH_MSG)

return var_0_1
