slot1 = require("protobuf.protobuf")

module("modules.proto.UserModule_pb", package.seeall)

slot2 = {
	LOGOUTREQUEST_MSG = slot1.Descriptor(),
	DEBUGLOGOUTREQUEST_MSG = slot1.Descriptor(),
	DEBUGLOGOUTREPLY_MSG = slot1.Descriptor(),
	LOGOUTREPLY_MSG = slot1.Descriptor()
}
slot2.LOGOUTREQUEST_MSG.name = "LogoutRequest"
slot2.LOGOUTREQUEST_MSG.full_name = ".LogoutRequest"
slot2.LOGOUTREQUEST_MSG.nested_types = {}
slot2.LOGOUTREQUEST_MSG.enum_types = {}
slot2.LOGOUTREQUEST_MSG.fields = {}
slot2.LOGOUTREQUEST_MSG.is_extendable = false
slot2.LOGOUTREQUEST_MSG.extensions = {}
slot2.DEBUGLOGOUTREQUEST_MSG.name = "DebugLogoutRequest"
slot2.DEBUGLOGOUTREQUEST_MSG.full_name = ".DebugLogoutRequest"
slot2.DEBUGLOGOUTREQUEST_MSG.nested_types = {}
slot2.DEBUGLOGOUTREQUEST_MSG.enum_types = {}
slot2.DEBUGLOGOUTREQUEST_MSG.fields = {}
slot2.DEBUGLOGOUTREQUEST_MSG.is_extendable = false
slot2.DEBUGLOGOUTREQUEST_MSG.extensions = {}
slot2.DEBUGLOGOUTREPLY_MSG.name = "DebugLogoutReply"
slot2.DEBUGLOGOUTREPLY_MSG.full_name = ".DebugLogoutReply"
slot2.DEBUGLOGOUTREPLY_MSG.nested_types = {}
slot2.DEBUGLOGOUTREPLY_MSG.enum_types = {}
slot2.DEBUGLOGOUTREPLY_MSG.fields = {}
slot2.DEBUGLOGOUTREPLY_MSG.is_extendable = false
slot2.DEBUGLOGOUTREPLY_MSG.extensions = {}
slot2.LOGOUTREPLY_MSG.name = "LogoutReply"
slot2.LOGOUTREPLY_MSG.full_name = ".LogoutReply"
slot2.LOGOUTREPLY_MSG.nested_types = {}
slot2.LOGOUTREPLY_MSG.enum_types = {}
slot2.LOGOUTREPLY_MSG.fields = {}
slot2.LOGOUTREPLY_MSG.is_extendable = false
slot2.LOGOUTREPLY_MSG.extensions = {}
slot2.DebugLogoutReply = slot1.Message(slot2.DEBUGLOGOUTREPLY_MSG)
slot2.DebugLogoutRequest = slot1.Message(slot2.DEBUGLOGOUTREQUEST_MSG)
slot2.LogoutReply = slot1.Message(slot2.LOGOUTREPLY_MSG)
slot2.LogoutRequest = slot1.Message(slot2.LOGOUTREQUEST_MSG)

return slot2
