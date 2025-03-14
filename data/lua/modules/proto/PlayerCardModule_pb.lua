slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.PlayerCardModule_pb", package.seeall)

slot2 = {
	PLAYERDEF_PB = slot0("modules.proto.PlayerDef_pb"),
	GETOTHERPLAYERCARDINFOREQUEST_MSG = slot1.Descriptor(),
	GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD = slot1.FieldDescriptor(),
	SETPLAYERCARDHEROCOVERREPLY_MSG = slot1.Descriptor(),
	SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD = slot1.FieldDescriptor(),
	PLAYERCARDINFOPUSH_MSG = slot1.Descriptor(),
	PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD = slot1.FieldDescriptor(),
	SETPLAYERCARDTHEMEREPLY_MSG = slot1.Descriptor(),
	SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD = slot1.FieldDescriptor(),
	GETPLAYERCARDINFOREQUEST_MSG = slot1.Descriptor(),
	SETPLAYERCARDHEROCOVERREQUEST_MSG = slot1.Descriptor(),
	SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD = slot1.FieldDescriptor(),
	SETPLAYERCARDTHEMEREQUEST_MSG = slot1.Descriptor(),
	SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD = slot1.FieldDescriptor(),
	GETPLAYERCARDINFOREPLY_MSG = slot1.Descriptor(),
	GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD = slot1.FieldDescriptor(),
	SETPLAYERCARDSHOWSETTINGREQUEST_MSG = slot1.Descriptor(),
	SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD = slot1.FieldDescriptor(),
	GETOTHERPLAYERCARDINFOREPLY_MSG = slot1.Descriptor(),
	GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD = slot1.FieldDescriptor(),
	GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD = slot1.FieldDescriptor(),
	SETPLAYERCARDSHOWSETTINGREPLY_MSG = slot1.Descriptor(),
	SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD = slot1.FieldDescriptor()
}
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.name = "userId"
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.full_name = ".GetOtherPlayerCardInfoRequest.userId"
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.number = 1
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.index = 0
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.label = 1
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.has_default_value = false
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.default_value = 0
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.type = 3
slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD.cpp_type = 2
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.name = "GetOtherPlayerCardInfoRequest"
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.full_name = ".GetOtherPlayerCardInfoRequest"
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.nested_types = {}
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.enum_types = {}
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.fields = {
	slot2.GETOTHERPLAYERCARDINFOREQUESTUSERIDFIELD
}
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.is_extendable = false
slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG.extensions = {}
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.name = "heroCover"
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.full_name = ".SetPlayerCardHeroCoverReply.heroCover"
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.number = 1
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.index = 0
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.label = 1
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.has_default_value = false
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.default_value = ""
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.type = 9
slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD.cpp_type = 9
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.name = "SetPlayerCardHeroCoverReply"
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.full_name = ".SetPlayerCardHeroCoverReply"
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.nested_types = {}
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.enum_types = {}
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.fields = {
	slot2.SETPLAYERCARDHEROCOVERREPLYHEROCOVERFIELD
}
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.is_extendable = false
slot2.SETPLAYERCARDHEROCOVERREPLY_MSG.extensions = {}
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.name = "playerCardInfo"
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.full_name = ".PlayerCardInfoPush.playerCardInfo"
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.number = 1
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.index = 0
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.label = 1
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.has_default_value = false
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.default_value = nil
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.message_type = slot2.PLAYERDEF_PB.PLAYERCARDINFO_MSG
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.type = 11
slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD.cpp_type = 10
slot2.PLAYERCARDINFOPUSH_MSG.name = "PlayerCardInfoPush"
slot2.PLAYERCARDINFOPUSH_MSG.full_name = ".PlayerCardInfoPush"
slot2.PLAYERCARDINFOPUSH_MSG.nested_types = {}
slot2.PLAYERCARDINFOPUSH_MSG.enum_types = {}
slot2.PLAYERCARDINFOPUSH_MSG.fields = {
	slot2.PLAYERCARDINFOPUSHPLAYERCARDINFOFIELD
}
slot2.PLAYERCARDINFOPUSH_MSG.is_extendable = false
slot2.PLAYERCARDINFOPUSH_MSG.extensions = {}
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.name = "themeId"
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.full_name = ".SetPlayerCardThemeReply.themeId"
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.number = 1
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.index = 0
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.label = 1
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.has_default_value = false
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.default_value = 0
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.type = 5
slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD.cpp_type = 1
slot2.SETPLAYERCARDTHEMEREPLY_MSG.name = "SetPlayerCardThemeReply"
slot2.SETPLAYERCARDTHEMEREPLY_MSG.full_name = ".SetPlayerCardThemeReply"
slot2.SETPLAYERCARDTHEMEREPLY_MSG.nested_types = {}
slot2.SETPLAYERCARDTHEMEREPLY_MSG.enum_types = {}
slot2.SETPLAYERCARDTHEMEREPLY_MSG.fields = {
	slot2.SETPLAYERCARDTHEMEREPLYTHEMEIDFIELD
}
slot2.SETPLAYERCARDTHEMEREPLY_MSG.is_extendable = false
slot2.SETPLAYERCARDTHEMEREPLY_MSG.extensions = {}
slot2.GETPLAYERCARDINFOREQUEST_MSG.name = "GetPlayerCardInfoRequest"
slot2.GETPLAYERCARDINFOREQUEST_MSG.full_name = ".GetPlayerCardInfoRequest"
slot2.GETPLAYERCARDINFOREQUEST_MSG.nested_types = {}
slot2.GETPLAYERCARDINFOREQUEST_MSG.enum_types = {}
slot2.GETPLAYERCARDINFOREQUEST_MSG.fields = {}
slot2.GETPLAYERCARDINFOREQUEST_MSG.is_extendable = false
slot2.GETPLAYERCARDINFOREQUEST_MSG.extensions = {}
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.name = "heroCover"
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.full_name = ".SetPlayerCardHeroCoverRequest.heroCover"
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.number = 1
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.index = 0
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.label = 1
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.has_default_value = false
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.default_value = ""
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.type = 9
slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD.cpp_type = 9
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.name = "SetPlayerCardHeroCoverRequest"
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.full_name = ".SetPlayerCardHeroCoverRequest"
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.nested_types = {}
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.enum_types = {}
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.fields = {
	slot2.SETPLAYERCARDHEROCOVERREQUESTHEROCOVERFIELD
}
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.is_extendable = false
slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG.extensions = {}
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.name = "themeId"
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.full_name = ".SetPlayerCardThemeRequest.themeId"
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.number = 1
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.index = 0
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.label = 1
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.has_default_value = false
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.default_value = 0
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.type = 5
slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD.cpp_type = 1
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.name = "SetPlayerCardThemeRequest"
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.full_name = ".SetPlayerCardThemeRequest"
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.nested_types = {}
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.enum_types = {}
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.fields = {
	slot2.SETPLAYERCARDTHEMEREQUESTTHEMEIDFIELD
}
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.is_extendable = false
slot2.SETPLAYERCARDTHEMEREQUEST_MSG.extensions = {}
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.name = "playerCardInfo"
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.full_name = ".GetPlayerCardInfoReply.playerCardInfo"
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.number = 1
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.index = 0
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.label = 1
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.has_default_value = false
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.default_value = nil
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.message_type = slot2.PLAYERDEF_PB.PLAYERCARDINFO_MSG
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.type = 11
slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.cpp_type = 10
slot2.GETPLAYERCARDINFOREPLY_MSG.name = "GetPlayerCardInfoReply"
slot2.GETPLAYERCARDINFOREPLY_MSG.full_name = ".GetPlayerCardInfoReply"
slot2.GETPLAYERCARDINFOREPLY_MSG.nested_types = {}
slot2.GETPLAYERCARDINFOREPLY_MSG.enum_types = {}
slot2.GETPLAYERCARDINFOREPLY_MSG.fields = {
	slot2.GETPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD
}
slot2.GETPLAYERCARDINFOREPLY_MSG.is_extendable = false
slot2.GETPLAYERCARDINFOREPLY_MSG.extensions = {}
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.name = "showSettings"
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.full_name = ".SetPlayerCardShowSettingRequest.showSettings"
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.number = 1
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.index = 0
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.label = 3
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.has_default_value = false
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.default_value = {}
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.type = 9
slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD.cpp_type = 9
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.name = "SetPlayerCardShowSettingRequest"
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.full_name = ".SetPlayerCardShowSettingRequest"
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.nested_types = {}
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.enum_types = {}
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.fields = {
	slot2.SETPLAYERCARDSHOWSETTINGREQUESTSHOWSETTINGSFIELD
}
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.is_extendable = false
slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG.extensions = {}
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.name = "playerInfo"
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.full_name = ".GetOtherPlayerCardInfoReply.playerInfo"
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.number = 1
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.index = 0
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.label = 1
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.has_default_value = false
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.default_value = nil
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.message_type = slot2.PLAYERDEF_PB.PLAYERINFO_MSG
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.type = 11
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD.cpp_type = 10
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.name = "playerCardInfo"
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.full_name = ".GetOtherPlayerCardInfoReply.playerCardInfo"
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.number = 2
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.index = 1
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.label = 1
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.has_default_value = false
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.default_value = nil
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.message_type = slot2.PLAYERDEF_PB.PLAYERCARDINFO_MSG
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.type = 11
slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD.cpp_type = 10
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.name = "GetOtherPlayerCardInfoReply"
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.full_name = ".GetOtherPlayerCardInfoReply"
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.nested_types = {}
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.enum_types = {}
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.fields = {
	slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERINFOFIELD,
	slot2.GETOTHERPLAYERCARDINFOREPLYPLAYERCARDINFOFIELD
}
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.is_extendable = false
slot2.GETOTHERPLAYERCARDINFOREPLY_MSG.extensions = {}
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.name = "showSettings"
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.full_name = ".SetPlayerCardShowSettingReply.showSettings"
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.number = 1
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.index = 0
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.label = 3
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.has_default_value = false
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.default_value = {}
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.type = 9
slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD.cpp_type = 9
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.name = "SetPlayerCardShowSettingReply"
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.full_name = ".SetPlayerCardShowSettingReply"
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.nested_types = {}
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.enum_types = {}
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.fields = {
	slot2.SETPLAYERCARDSHOWSETTINGREPLYSHOWSETTINGSFIELD
}
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.is_extendable = false
slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG.extensions = {}
slot2.GetOtherPlayerCardInfoReply = slot1.Message(slot2.GETOTHERPLAYERCARDINFOREPLY_MSG)
slot2.GetOtherPlayerCardInfoRequest = slot1.Message(slot2.GETOTHERPLAYERCARDINFOREQUEST_MSG)
slot2.GetPlayerCardInfoReply = slot1.Message(slot2.GETPLAYERCARDINFOREPLY_MSG)
slot2.GetPlayerCardInfoRequest = slot1.Message(slot2.GETPLAYERCARDINFOREQUEST_MSG)
slot2.PlayerCardInfoPush = slot1.Message(slot2.PLAYERCARDINFOPUSH_MSG)
slot2.SetPlayerCardHeroCoverReply = slot1.Message(slot2.SETPLAYERCARDHEROCOVERREPLY_MSG)
slot2.SetPlayerCardHeroCoverRequest = slot1.Message(slot2.SETPLAYERCARDHEROCOVERREQUEST_MSG)
slot2.SetPlayerCardShowSettingReply = slot1.Message(slot2.SETPLAYERCARDSHOWSETTINGREPLY_MSG)
slot2.SetPlayerCardShowSettingRequest = slot1.Message(slot2.SETPLAYERCARDSHOWSETTINGREQUEST_MSG)
slot2.SetPlayerCardThemeReply = slot1.Message(slot2.SETPLAYERCARDTHEMEREPLY_MSG)
slot2.SetPlayerCardThemeRequest = slot1.Message(slot2.SETPLAYERCARDTHEMEREQUEST_MSG)

return slot2
