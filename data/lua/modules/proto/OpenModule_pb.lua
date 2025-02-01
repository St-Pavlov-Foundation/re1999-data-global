slot1 = require("protobuf.protobuf")

module("modules.proto.OpenModule_pb", package.seeall)

slot2 = {
	OPENINFO_MSG = slot1.Descriptor(),
	OPENINFOIDFIELD = slot1.FieldDescriptor(),
	OPENINFOISOPENFIELD = slot1.FieldDescriptor(),
	UPDATEOPENPUSH_MSG = slot1.Descriptor(),
	UPDATEOPENPUSHOPENINFOSFIELD = slot1.FieldDescriptor()
}
slot2.OPENINFOIDFIELD.name = "id"
slot2.OPENINFOIDFIELD.full_name = ".OpenInfo.id"
slot2.OPENINFOIDFIELD.number = 1
slot2.OPENINFOIDFIELD.index = 0
slot2.OPENINFOIDFIELD.label = 2
slot2.OPENINFOIDFIELD.has_default_value = false
slot2.OPENINFOIDFIELD.default_value = 0
slot2.OPENINFOIDFIELD.type = 5
slot2.OPENINFOIDFIELD.cpp_type = 1
slot2.OPENINFOISOPENFIELD.name = "isOpen"
slot2.OPENINFOISOPENFIELD.full_name = ".OpenInfo.isOpen"
slot2.OPENINFOISOPENFIELD.number = 2
slot2.OPENINFOISOPENFIELD.index = 1
slot2.OPENINFOISOPENFIELD.label = 2
slot2.OPENINFOISOPENFIELD.has_default_value = false
slot2.OPENINFOISOPENFIELD.default_value = false
slot2.OPENINFOISOPENFIELD.type = 8
slot2.OPENINFOISOPENFIELD.cpp_type = 7
slot2.OPENINFO_MSG.name = "OpenInfo"
slot2.OPENINFO_MSG.full_name = ".OpenInfo"
slot2.OPENINFO_MSG.nested_types = {}
slot2.OPENINFO_MSG.enum_types = {}
slot2.OPENINFO_MSG.fields = {
	slot2.OPENINFOIDFIELD,
	slot2.OPENINFOISOPENFIELD
}
slot2.OPENINFO_MSG.is_extendable = false
slot2.OPENINFO_MSG.extensions = {}
slot2.UPDATEOPENPUSHOPENINFOSFIELD.name = "openInfos"
slot2.UPDATEOPENPUSHOPENINFOSFIELD.full_name = ".UpdateOpenPush.openInfos"
slot2.UPDATEOPENPUSHOPENINFOSFIELD.number = 1
slot2.UPDATEOPENPUSHOPENINFOSFIELD.index = 0
slot2.UPDATEOPENPUSHOPENINFOSFIELD.label = 3
slot2.UPDATEOPENPUSHOPENINFOSFIELD.has_default_value = false
slot2.UPDATEOPENPUSHOPENINFOSFIELD.default_value = {}
slot2.UPDATEOPENPUSHOPENINFOSFIELD.message_type = slot2.OPENINFO_MSG
slot2.UPDATEOPENPUSHOPENINFOSFIELD.type = 11
slot2.UPDATEOPENPUSHOPENINFOSFIELD.cpp_type = 10
slot2.UPDATEOPENPUSH_MSG.name = "UpdateOpenPush"
slot2.UPDATEOPENPUSH_MSG.full_name = ".UpdateOpenPush"
slot2.UPDATEOPENPUSH_MSG.nested_types = {}
slot2.UPDATEOPENPUSH_MSG.enum_types = {}
slot2.UPDATEOPENPUSH_MSG.fields = {
	slot2.UPDATEOPENPUSHOPENINFOSFIELD
}
slot2.UPDATEOPENPUSH_MSG.is_extendable = false
slot2.UPDATEOPENPUSH_MSG.extensions = {}
slot2.OpenInfo = slot1.Message(slot2.OPENINFO_MSG)
slot2.UpdateOpenPush = slot1.Message(slot2.UPDATEOPENPUSH_MSG)

return slot2
