local var_0_0 = require("protobuf.protobuf")

module("modules.proto.UserModule_pb", package.seeall)

local var_0_1 = {
	LOGOUTREQUEST_MSG = var_0_0.Descriptor(),
	DEBUGLOGOUTREQUEST_MSG = var_0_0.Descriptor(),
	DEBUGLOGOUTREPLY_MSG = var_0_0.Descriptor(),
	LOGOUTREPLY_MSG = var_0_0.Descriptor()
}

var_0_1.LOGOUTREQUEST_MSG.name = "LogoutRequest"
var_0_1.LOGOUTREQUEST_MSG.full_name = ".LogoutRequest"
var_0_1.LOGOUTREQUEST_MSG.nested_types = {}
var_0_1.LOGOUTREQUEST_MSG.enum_types = {}
var_0_1.LOGOUTREQUEST_MSG.fields = {}
var_0_1.LOGOUTREQUEST_MSG.is_extendable = false
var_0_1.LOGOUTREQUEST_MSG.extensions = {}
var_0_1.DEBUGLOGOUTREQUEST_MSG.name = "DebugLogoutRequest"
var_0_1.DEBUGLOGOUTREQUEST_MSG.full_name = ".DebugLogoutRequest"
var_0_1.DEBUGLOGOUTREQUEST_MSG.nested_types = {}
var_0_1.DEBUGLOGOUTREQUEST_MSG.enum_types = {}
var_0_1.DEBUGLOGOUTREQUEST_MSG.fields = {}
var_0_1.DEBUGLOGOUTREQUEST_MSG.is_extendable = false
var_0_1.DEBUGLOGOUTREQUEST_MSG.extensions = {}
var_0_1.DEBUGLOGOUTREPLY_MSG.name = "DebugLogoutReply"
var_0_1.DEBUGLOGOUTREPLY_MSG.full_name = ".DebugLogoutReply"
var_0_1.DEBUGLOGOUTREPLY_MSG.nested_types = {}
var_0_1.DEBUGLOGOUTREPLY_MSG.enum_types = {}
var_0_1.DEBUGLOGOUTREPLY_MSG.fields = {}
var_0_1.DEBUGLOGOUTREPLY_MSG.is_extendable = false
var_0_1.DEBUGLOGOUTREPLY_MSG.extensions = {}
var_0_1.LOGOUTREPLY_MSG.name = "LogoutReply"
var_0_1.LOGOUTREPLY_MSG.full_name = ".LogoutReply"
var_0_1.LOGOUTREPLY_MSG.nested_types = {}
var_0_1.LOGOUTREPLY_MSG.enum_types = {}
var_0_1.LOGOUTREPLY_MSG.fields = {}
var_0_1.LOGOUTREPLY_MSG.is_extendable = false
var_0_1.LOGOUTREPLY_MSG.extensions = {}
var_0_1.DebugLogoutReply = var_0_0.Message(var_0_1.DEBUGLOGOUTREPLY_MSG)
var_0_1.DebugLogoutRequest = var_0_0.Message(var_0_1.DEBUGLOGOUTREQUEST_MSG)
var_0_1.LogoutReply = var_0_0.Message(var_0_1.LOGOUTREPLY_MSG)
var_0_1.LogoutRequest = var_0_0.Message(var_0_1.LOGOUTREQUEST_MSG)

return var_0_1
