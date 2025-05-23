﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.ActivityModule_pb", package.seeall)

local var_0_1 = {
	ACTIVITYINFO_MSG = var_0_0.Descriptor(),
	ACTIVITYINFOIDFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOSTARTTIMEFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOENDTIMEFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOONLINEFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOISNEWSTAGEFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOCURRENTSTAGEFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOISUNLOCKFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYINFOISRECEIVEALLBONUSFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYNEWSTAGEREADREQUEST_MSG = var_0_0.Descriptor(),
	ACTIVITYNEWSTAGEREADREQUESTIDFIELD = var_0_0.FieldDescriptor(),
	UNLOCKPERMANENTREPLY_MSG = var_0_0.Descriptor(),
	UNLOCKPERMANENTREPLYIDFIELD = var_0_0.FieldDescriptor(),
	ACTIVITYNEWSTAGEREADREPLY_MSG = var_0_0.Descriptor(),
	ACTIVITYNEWSTAGEREADREPLYIDFIELD = var_0_0.FieldDescriptor(),
	GETACTIVITYINFOSREQUEST_MSG = var_0_0.Descriptor(),
	GETACTIVITYINFOSWITHPARAMREPLY_MSG = var_0_0.Descriptor(),
	GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD = var_0_0.FieldDescriptor(),
	ENDACTIVITYPUSH_MSG = var_0_0.Descriptor(),
	ENDACTIVITYPUSHIDFIELD = var_0_0.FieldDescriptor(),
	GETACTIVITYINFOSREPLY_MSG = var_0_0.Descriptor(),
	GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD = var_0_0.FieldDescriptor(),
	GETACTIVITYINFOSWITHPARAMREQUEST_MSG = var_0_0.Descriptor(),
	GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD = var_0_0.FieldDescriptor(),
	UPDATEACTIVITYPUSH_MSG = var_0_0.Descriptor(),
	UPDATEACTIVITYPUSHACTIVITYINFOFIELD = var_0_0.FieldDescriptor(),
	UPDATEACTIVITYPUSHTIMEFIELD = var_0_0.FieldDescriptor(),
	UNLOCKPERMANENTREQUEST_MSG = var_0_0.Descriptor(),
	UNLOCKPERMANENTREQUESTIDFIELD = var_0_0.FieldDescriptor()
}

var_0_1.ACTIVITYINFOIDFIELD.name = "id"
var_0_1.ACTIVITYINFOIDFIELD.full_name = ".ActivityInfo.id"
var_0_1.ACTIVITYINFOIDFIELD.number = 1
var_0_1.ACTIVITYINFOIDFIELD.index = 0
var_0_1.ACTIVITYINFOIDFIELD.label = 1
var_0_1.ACTIVITYINFOIDFIELD.has_default_value = false
var_0_1.ACTIVITYINFOIDFIELD.default_value = 0
var_0_1.ACTIVITYINFOIDFIELD.type = 13
var_0_1.ACTIVITYINFOIDFIELD.cpp_type = 3
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.name = "startTime"
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.full_name = ".ActivityInfo.startTime"
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.number = 2
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.index = 1
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.label = 1
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.has_default_value = false
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.default_value = 0
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.type = 4
var_0_1.ACTIVITYINFOSTARTTIMEFIELD.cpp_type = 4
var_0_1.ACTIVITYINFOENDTIMEFIELD.name = "endTime"
var_0_1.ACTIVITYINFOENDTIMEFIELD.full_name = ".ActivityInfo.endTime"
var_0_1.ACTIVITYINFOENDTIMEFIELD.number = 3
var_0_1.ACTIVITYINFOENDTIMEFIELD.index = 2
var_0_1.ACTIVITYINFOENDTIMEFIELD.label = 1
var_0_1.ACTIVITYINFOENDTIMEFIELD.has_default_value = false
var_0_1.ACTIVITYINFOENDTIMEFIELD.default_value = 0
var_0_1.ACTIVITYINFOENDTIMEFIELD.type = 4
var_0_1.ACTIVITYINFOENDTIMEFIELD.cpp_type = 4
var_0_1.ACTIVITYINFOONLINEFIELD.name = "online"
var_0_1.ACTIVITYINFOONLINEFIELD.full_name = ".ActivityInfo.online"
var_0_1.ACTIVITYINFOONLINEFIELD.number = 4
var_0_1.ACTIVITYINFOONLINEFIELD.index = 3
var_0_1.ACTIVITYINFOONLINEFIELD.label = 1
var_0_1.ACTIVITYINFOONLINEFIELD.has_default_value = false
var_0_1.ACTIVITYINFOONLINEFIELD.default_value = false
var_0_1.ACTIVITYINFOONLINEFIELD.type = 8
var_0_1.ACTIVITYINFOONLINEFIELD.cpp_type = 7
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.name = "isNewStage"
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.full_name = ".ActivityInfo.isNewStage"
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.number = 5
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.index = 4
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.label = 1
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.has_default_value = false
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.default_value = false
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.type = 8
var_0_1.ACTIVITYINFOISNEWSTAGEFIELD.cpp_type = 7
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.name = "currentStage"
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.full_name = ".ActivityInfo.currentStage"
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.number = 6
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.index = 5
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.label = 1
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.has_default_value = false
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.default_value = 0
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.type = 5
var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD.cpp_type = 1
var_0_1.ACTIVITYINFOISUNLOCKFIELD.name = "isUnlock"
var_0_1.ACTIVITYINFOISUNLOCKFIELD.full_name = ".ActivityInfo.isUnlock"
var_0_1.ACTIVITYINFOISUNLOCKFIELD.number = 7
var_0_1.ACTIVITYINFOISUNLOCKFIELD.index = 6
var_0_1.ACTIVITYINFOISUNLOCKFIELD.label = 1
var_0_1.ACTIVITYINFOISUNLOCKFIELD.has_default_value = false
var_0_1.ACTIVITYINFOISUNLOCKFIELD.default_value = false
var_0_1.ACTIVITYINFOISUNLOCKFIELD.type = 8
var_0_1.ACTIVITYINFOISUNLOCKFIELD.cpp_type = 7
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.name = "isReceiveAllBonus"
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.full_name = ".ActivityInfo.isReceiveAllBonus"
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.number = 8
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.index = 7
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.label = 1
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.has_default_value = false
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.default_value = false
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.type = 8
var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD.cpp_type = 7
var_0_1.ACTIVITYINFO_MSG.name = "ActivityInfo"
var_0_1.ACTIVITYINFO_MSG.full_name = ".ActivityInfo"
var_0_1.ACTIVITYINFO_MSG.nested_types = {}
var_0_1.ACTIVITYINFO_MSG.enum_types = {}
var_0_1.ACTIVITYINFO_MSG.fields = {
	var_0_1.ACTIVITYINFOIDFIELD,
	var_0_1.ACTIVITYINFOSTARTTIMEFIELD,
	var_0_1.ACTIVITYINFOENDTIMEFIELD,
	var_0_1.ACTIVITYINFOONLINEFIELD,
	var_0_1.ACTIVITYINFOISNEWSTAGEFIELD,
	var_0_1.ACTIVITYINFOCURRENTSTAGEFIELD,
	var_0_1.ACTIVITYINFOISUNLOCKFIELD,
	var_0_1.ACTIVITYINFOISRECEIVEALLBONUSFIELD
}
var_0_1.ACTIVITYINFO_MSG.is_extendable = false
var_0_1.ACTIVITYINFO_MSG.extensions = {}
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.name = "id"
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.full_name = ".ActivityNewStageReadRequest.id"
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.number = 1
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.index = 0
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.label = 3
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.has_default_value = false
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.default_value = {}
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.type = 13
var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD.cpp_type = 3
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.name = "ActivityNewStageReadRequest"
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.full_name = ".ActivityNewStageReadRequest"
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.nested_types = {}
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.enum_types = {}
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.fields = {
	var_0_1.ACTIVITYNEWSTAGEREADREQUESTIDFIELD
}
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.is_extendable = false
var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG.extensions = {}
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.name = "id"
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.full_name = ".UnlockPermanentReply.id"
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.number = 1
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.index = 0
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.label = 1
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.has_default_value = false
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.default_value = 0
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.type = 13
var_0_1.UNLOCKPERMANENTREPLYIDFIELD.cpp_type = 3
var_0_1.UNLOCKPERMANENTREPLY_MSG.name = "UnlockPermanentReply"
var_0_1.UNLOCKPERMANENTREPLY_MSG.full_name = ".UnlockPermanentReply"
var_0_1.UNLOCKPERMANENTREPLY_MSG.nested_types = {}
var_0_1.UNLOCKPERMANENTREPLY_MSG.enum_types = {}
var_0_1.UNLOCKPERMANENTREPLY_MSG.fields = {
	var_0_1.UNLOCKPERMANENTREPLYIDFIELD
}
var_0_1.UNLOCKPERMANENTREPLY_MSG.is_extendable = false
var_0_1.UNLOCKPERMANENTREPLY_MSG.extensions = {}
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.name = "id"
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.full_name = ".ActivityNewStageReadReply.id"
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.number = 1
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.index = 0
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.label = 3
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.has_default_value = false
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.default_value = {}
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.type = 13
var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD.cpp_type = 3
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.name = "ActivityNewStageReadReply"
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.full_name = ".ActivityNewStageReadReply"
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.nested_types = {}
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.enum_types = {}
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.fields = {
	var_0_1.ACTIVITYNEWSTAGEREADREPLYIDFIELD
}
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.is_extendable = false
var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG.extensions = {}
var_0_1.GETACTIVITYINFOSREQUEST_MSG.name = "GetActivityInfosRequest"
var_0_1.GETACTIVITYINFOSREQUEST_MSG.full_name = ".GetActivityInfosRequest"
var_0_1.GETACTIVITYINFOSREQUEST_MSG.nested_types = {}
var_0_1.GETACTIVITYINFOSREQUEST_MSG.enum_types = {}
var_0_1.GETACTIVITYINFOSREQUEST_MSG.fields = {}
var_0_1.GETACTIVITYINFOSREQUEST_MSG.is_extendable = false
var_0_1.GETACTIVITYINFOSREQUEST_MSG.extensions = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.name = "activityInfos"
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.full_name = ".GetActivityInfosWithParamReply.activityInfos"
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.number = 1
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.index = 0
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.label = 3
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.has_default_value = false
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.default_value = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.message_type = var_0_1.ACTIVITYINFO_MSG
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.type = 11
var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD.cpp_type = 10
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.name = "GetActivityInfosWithParamReply"
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.full_name = ".GetActivityInfosWithParamReply"
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.nested_types = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.enum_types = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.fields = {
	var_0_1.GETACTIVITYINFOSWITHPARAMREPLYACTIVITYINFOSFIELD
}
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.is_extendable = false
var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG.extensions = {}
var_0_1.ENDACTIVITYPUSHIDFIELD.name = "id"
var_0_1.ENDACTIVITYPUSHIDFIELD.full_name = ".EndActivityPush.id"
var_0_1.ENDACTIVITYPUSHIDFIELD.number = 1
var_0_1.ENDACTIVITYPUSHIDFIELD.index = 0
var_0_1.ENDACTIVITYPUSHIDFIELD.label = 1
var_0_1.ENDACTIVITYPUSHIDFIELD.has_default_value = false
var_0_1.ENDACTIVITYPUSHIDFIELD.default_value = 0
var_0_1.ENDACTIVITYPUSHIDFIELD.type = 13
var_0_1.ENDACTIVITYPUSHIDFIELD.cpp_type = 3
var_0_1.ENDACTIVITYPUSH_MSG.name = "EndActivityPush"
var_0_1.ENDACTIVITYPUSH_MSG.full_name = ".EndActivityPush"
var_0_1.ENDACTIVITYPUSH_MSG.nested_types = {}
var_0_1.ENDACTIVITYPUSH_MSG.enum_types = {}
var_0_1.ENDACTIVITYPUSH_MSG.fields = {
	var_0_1.ENDACTIVITYPUSHIDFIELD
}
var_0_1.ENDACTIVITYPUSH_MSG.is_extendable = false
var_0_1.ENDACTIVITYPUSH_MSG.extensions = {}
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.name = "activityInfos"
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.full_name = ".GetActivityInfosReply.activityInfos"
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.number = 1
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.index = 0
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.label = 3
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.has_default_value = false
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.default_value = {}
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.message_type = var_0_1.ACTIVITYINFO_MSG
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.type = 11
var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD.cpp_type = 10
var_0_1.GETACTIVITYINFOSREPLY_MSG.name = "GetActivityInfosReply"
var_0_1.GETACTIVITYINFOSREPLY_MSG.full_name = ".GetActivityInfosReply"
var_0_1.GETACTIVITYINFOSREPLY_MSG.nested_types = {}
var_0_1.GETACTIVITYINFOSREPLY_MSG.enum_types = {}
var_0_1.GETACTIVITYINFOSREPLY_MSG.fields = {
	var_0_1.GETACTIVITYINFOSREPLYACTIVITYINFOSFIELD
}
var_0_1.GETACTIVITYINFOSREPLY_MSG.is_extendable = false
var_0_1.GETACTIVITYINFOSREPLY_MSG.extensions = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.name = "activityIds"
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.full_name = ".GetActivityInfosWithParamRequest.activityIds"
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.number = 1
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.index = 0
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.label = 3
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.has_default_value = false
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.default_value = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.type = 5
var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD.cpp_type = 1
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.name = "GetActivityInfosWithParamRequest"
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.full_name = ".GetActivityInfosWithParamRequest"
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.nested_types = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.enum_types = {}
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.fields = {
	var_0_1.GETACTIVITYINFOSWITHPARAMREQUESTACTIVITYIDSFIELD
}
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.is_extendable = false
var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG.extensions = {}
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.name = "activityInfo"
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.full_name = ".UpdateActivityPush.activityInfo"
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.number = 1
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.index = 0
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.label = 1
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.has_default_value = false
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.default_value = nil
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.message_type = var_0_1.ACTIVITYINFO_MSG
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.type = 11
var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD.cpp_type = 10
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.name = "time"
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.full_name = ".UpdateActivityPush.time"
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.number = 2
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.index = 1
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.label = 1
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.has_default_value = false
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.default_value = 0
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.type = 5
var_0_1.UPDATEACTIVITYPUSHTIMEFIELD.cpp_type = 1
var_0_1.UPDATEACTIVITYPUSH_MSG.name = "UpdateActivityPush"
var_0_1.UPDATEACTIVITYPUSH_MSG.full_name = ".UpdateActivityPush"
var_0_1.UPDATEACTIVITYPUSH_MSG.nested_types = {}
var_0_1.UPDATEACTIVITYPUSH_MSG.enum_types = {}
var_0_1.UPDATEACTIVITYPUSH_MSG.fields = {
	var_0_1.UPDATEACTIVITYPUSHACTIVITYINFOFIELD,
	var_0_1.UPDATEACTIVITYPUSHTIMEFIELD
}
var_0_1.UPDATEACTIVITYPUSH_MSG.is_extendable = false
var_0_1.UPDATEACTIVITYPUSH_MSG.extensions = {}
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.name = "id"
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.full_name = ".UnlockPermanentRequest.id"
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.number = 1
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.index = 0
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.label = 1
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.has_default_value = false
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.default_value = 0
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.type = 13
var_0_1.UNLOCKPERMANENTREQUESTIDFIELD.cpp_type = 3
var_0_1.UNLOCKPERMANENTREQUEST_MSG.name = "UnlockPermanentRequest"
var_0_1.UNLOCKPERMANENTREQUEST_MSG.full_name = ".UnlockPermanentRequest"
var_0_1.UNLOCKPERMANENTREQUEST_MSG.nested_types = {}
var_0_1.UNLOCKPERMANENTREQUEST_MSG.enum_types = {}
var_0_1.UNLOCKPERMANENTREQUEST_MSG.fields = {
	var_0_1.UNLOCKPERMANENTREQUESTIDFIELD
}
var_0_1.UNLOCKPERMANENTREQUEST_MSG.is_extendable = false
var_0_1.UNLOCKPERMANENTREQUEST_MSG.extensions = {}
var_0_1.ActivityInfo = var_0_0.Message(var_0_1.ACTIVITYINFO_MSG)
var_0_1.ActivityNewStageReadReply = var_0_0.Message(var_0_1.ACTIVITYNEWSTAGEREADREPLY_MSG)
var_0_1.ActivityNewStageReadRequest = var_0_0.Message(var_0_1.ACTIVITYNEWSTAGEREADREQUEST_MSG)
var_0_1.EndActivityPush = var_0_0.Message(var_0_1.ENDACTIVITYPUSH_MSG)
var_0_1.GetActivityInfosReply = var_0_0.Message(var_0_1.GETACTIVITYINFOSREPLY_MSG)
var_0_1.GetActivityInfosRequest = var_0_0.Message(var_0_1.GETACTIVITYINFOSREQUEST_MSG)
var_0_1.GetActivityInfosWithParamReply = var_0_0.Message(var_0_1.GETACTIVITYINFOSWITHPARAMREPLY_MSG)
var_0_1.GetActivityInfosWithParamRequest = var_0_0.Message(var_0_1.GETACTIVITYINFOSWITHPARAMREQUEST_MSG)
var_0_1.UnlockPermanentReply = var_0_0.Message(var_0_1.UNLOCKPERMANENTREPLY_MSG)
var_0_1.UnlockPermanentRequest = var_0_0.Message(var_0_1.UNLOCKPERMANENTREQUEST_MSG)
var_0_1.UpdateActivityPush = var_0_0.Message(var_0_1.UPDATEACTIVITYPUSH_MSG)

return var_0_1
