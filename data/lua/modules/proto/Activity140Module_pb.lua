slot1 = require("protobuf.protobuf")

module("modules.proto.Activity140Module_pb", package.seeall)

slot2 = {
	ACT140BUILDREQUEST_MSG = slot1.Descriptor(),
	ACT140BUILDREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140BUILDREQUESTIDFIELD = slot1.FieldDescriptor(),
	ACT140BUILDINGINFO_MSG = slot1.Descriptor(),
	ACT140BUILDINGINFOSELECTIDSFIELD = slot1.FieldDescriptor(),
	ACT140BUILDINGINFOOWNBUILDINGIDSFIELD = slot1.FieldDescriptor(),
	ACT140BUILDINGINFOGAINEDREWARDFIELD = slot1.FieldDescriptor(),
	ACT140SELECTBUILDREPLY_MSG = slot1.Descriptor(),
	ACT140SELECTBUILDREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140SELECTBUILDREPLYIDSFIELD = slot1.FieldDescriptor(),
	GET140INFOSREPLY_MSG = slot1.Descriptor(),
	GET140INFOSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET140INFOSREPLYINFOFIELD = slot1.FieldDescriptor(),
	ACT140SELECTBUILDREQUEST_MSG = slot1.Descriptor(),
	ACT140SELECTBUILDREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140SELECTBUILDREQUESTIDSFIELD = slot1.FieldDescriptor(),
	GET140INFOSREQUEST_MSG = slot1.Descriptor(),
	GET140INFOSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140GAINPROGRESSREWARDREPLY_MSG = slot1.Descriptor(),
	ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140GAINPROGRESSREWARDREQUEST_MSG = slot1.Descriptor(),
	ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140BUILDREPLY_MSG = slot1.Descriptor(),
	ACT140BUILDREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT140BUILDREPLYIDFIELD = slot1.FieldDescriptor()
}
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.full_name = ".Act140BuildRequest.activityId"
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT140BUILDREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140BUILDREQUESTIDFIELD.name = "id"
slot2.ACT140BUILDREQUESTIDFIELD.full_name = ".Act140BuildRequest.id"
slot2.ACT140BUILDREQUESTIDFIELD.number = 2
slot2.ACT140BUILDREQUESTIDFIELD.index = 1
slot2.ACT140BUILDREQUESTIDFIELD.label = 1
slot2.ACT140BUILDREQUESTIDFIELD.has_default_value = false
slot2.ACT140BUILDREQUESTIDFIELD.default_value = 0
slot2.ACT140BUILDREQUESTIDFIELD.type = 5
slot2.ACT140BUILDREQUESTIDFIELD.cpp_type = 1
slot2.ACT140BUILDREQUEST_MSG.name = "Act140BuildRequest"
slot2.ACT140BUILDREQUEST_MSG.full_name = ".Act140BuildRequest"
slot2.ACT140BUILDREQUEST_MSG.nested_types = {}
slot2.ACT140BUILDREQUEST_MSG.enum_types = {}
slot2.ACT140BUILDREQUEST_MSG.fields = {
	slot2.ACT140BUILDREQUESTACTIVITYIDFIELD,
	slot2.ACT140BUILDREQUESTIDFIELD
}
slot2.ACT140BUILDREQUEST_MSG.is_extendable = false
slot2.ACT140BUILDREQUEST_MSG.extensions = {}
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.name = "selectIds"
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.full_name = ".Act140BuildingInfo.selectIds"
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.number = 1
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.index = 0
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.label = 3
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.has_default_value = false
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.default_value = {}
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.type = 5
slot2.ACT140BUILDINGINFOSELECTIDSFIELD.cpp_type = 1
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.name = "ownBuildingIds"
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.full_name = ".Act140BuildingInfo.ownBuildingIds"
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.number = 2
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.index = 1
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.label = 3
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.has_default_value = false
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.default_value = {}
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.type = 5
slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD.cpp_type = 1
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.name = "gainedReward"
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.full_name = ".Act140BuildingInfo.gainedReward"
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.number = 3
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.index = 2
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.label = 1
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.has_default_value = false
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.default_value = false
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.type = 8
slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD.cpp_type = 7
slot2.ACT140BUILDINGINFO_MSG.name = "Act140BuildingInfo"
slot2.ACT140BUILDINGINFO_MSG.full_name = ".Act140BuildingInfo"
slot2.ACT140BUILDINGINFO_MSG.nested_types = {}
slot2.ACT140BUILDINGINFO_MSG.enum_types = {}
slot2.ACT140BUILDINGINFO_MSG.fields = {
	slot2.ACT140BUILDINGINFOSELECTIDSFIELD,
	slot2.ACT140BUILDINGINFOOWNBUILDINGIDSFIELD,
	slot2.ACT140BUILDINGINFOGAINEDREWARDFIELD
}
slot2.ACT140BUILDINGINFO_MSG.is_extendable = false
slot2.ACT140BUILDINGINFO_MSG.extensions = {}
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.full_name = ".Act140SelectBuildReply.activityId"
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.number = 1
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.index = 0
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.label = 1
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.type = 5
slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140SELECTBUILDREPLYIDSFIELD.name = "ids"
slot2.ACT140SELECTBUILDREPLYIDSFIELD.full_name = ".Act140SelectBuildReply.ids"
slot2.ACT140SELECTBUILDREPLYIDSFIELD.number = 2
slot2.ACT140SELECTBUILDREPLYIDSFIELD.index = 1
slot2.ACT140SELECTBUILDREPLYIDSFIELD.label = 3
slot2.ACT140SELECTBUILDREPLYIDSFIELD.has_default_value = false
slot2.ACT140SELECTBUILDREPLYIDSFIELD.default_value = {}
slot2.ACT140SELECTBUILDREPLYIDSFIELD.type = 5
slot2.ACT140SELECTBUILDREPLYIDSFIELD.cpp_type = 1
slot2.ACT140SELECTBUILDREPLY_MSG.name = "Act140SelectBuildReply"
slot2.ACT140SELECTBUILDREPLY_MSG.full_name = ".Act140SelectBuildReply"
slot2.ACT140SELECTBUILDREPLY_MSG.nested_types = {}
slot2.ACT140SELECTBUILDREPLY_MSG.enum_types = {}
slot2.ACT140SELECTBUILDREPLY_MSG.fields = {
	slot2.ACT140SELECTBUILDREPLYACTIVITYIDFIELD,
	slot2.ACT140SELECTBUILDREPLYIDSFIELD
}
slot2.ACT140SELECTBUILDREPLY_MSG.is_extendable = false
slot2.ACT140SELECTBUILDREPLY_MSG.extensions = {}
slot2.GET140INFOSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GET140INFOSREPLYACTIVITYIDFIELD.full_name = ".Get140InfosReply.activityId"
slot2.GET140INFOSREPLYACTIVITYIDFIELD.number = 1
slot2.GET140INFOSREPLYACTIVITYIDFIELD.index = 0
slot2.GET140INFOSREPLYACTIVITYIDFIELD.label = 1
slot2.GET140INFOSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GET140INFOSREPLYACTIVITYIDFIELD.default_value = 0
slot2.GET140INFOSREPLYACTIVITYIDFIELD.type = 5
slot2.GET140INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GET140INFOSREPLYINFOFIELD.name = "info"
slot2.GET140INFOSREPLYINFOFIELD.full_name = ".Get140InfosReply.info"
slot2.GET140INFOSREPLYINFOFIELD.number = 2
slot2.GET140INFOSREPLYINFOFIELD.index = 1
slot2.GET140INFOSREPLYINFOFIELD.label = 1
slot2.GET140INFOSREPLYINFOFIELD.has_default_value = false
slot2.GET140INFOSREPLYINFOFIELD.default_value = nil
slot2.GET140INFOSREPLYINFOFIELD.message_type = slot2.ACT140BUILDINGINFO_MSG
slot2.GET140INFOSREPLYINFOFIELD.type = 11
slot2.GET140INFOSREPLYINFOFIELD.cpp_type = 10
slot2.GET140INFOSREPLY_MSG.name = "Get140InfosReply"
slot2.GET140INFOSREPLY_MSG.full_name = ".Get140InfosReply"
slot2.GET140INFOSREPLY_MSG.nested_types = {}
slot2.GET140INFOSREPLY_MSG.enum_types = {}
slot2.GET140INFOSREPLY_MSG.fields = {
	slot2.GET140INFOSREPLYACTIVITYIDFIELD,
	slot2.GET140INFOSREPLYINFOFIELD
}
slot2.GET140INFOSREPLY_MSG.is_extendable = false
slot2.GET140INFOSREPLY_MSG.extensions = {}
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.full_name = ".Act140SelectBuildRequest.activityId"
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.name = "ids"
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.full_name = ".Act140SelectBuildRequest.ids"
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.number = 2
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.index = 1
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.label = 3
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.has_default_value = false
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.default_value = {}
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.type = 5
slot2.ACT140SELECTBUILDREQUESTIDSFIELD.cpp_type = 1
slot2.ACT140SELECTBUILDREQUEST_MSG.name = "Act140SelectBuildRequest"
slot2.ACT140SELECTBUILDREQUEST_MSG.full_name = ".Act140SelectBuildRequest"
slot2.ACT140SELECTBUILDREQUEST_MSG.nested_types = {}
slot2.ACT140SELECTBUILDREQUEST_MSG.enum_types = {}
slot2.ACT140SELECTBUILDREQUEST_MSG.fields = {
	slot2.ACT140SELECTBUILDREQUESTACTIVITYIDFIELD,
	slot2.ACT140SELECTBUILDREQUESTIDSFIELD
}
slot2.ACT140SELECTBUILDREQUEST_MSG.is_extendable = false
slot2.ACT140SELECTBUILDREQUEST_MSG.extensions = {}
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get140InfosRequest.activityId"
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.number = 1
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.index = 0
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.label = 1
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.type = 5
slot2.GET140INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GET140INFOSREQUEST_MSG.name = "Get140InfosRequest"
slot2.GET140INFOSREQUEST_MSG.full_name = ".Get140InfosRequest"
slot2.GET140INFOSREQUEST_MSG.nested_types = {}
slot2.GET140INFOSREQUEST_MSG.enum_types = {}
slot2.GET140INFOSREQUEST_MSG.fields = {
	slot2.GET140INFOSREQUESTACTIVITYIDFIELD
}
slot2.GET140INFOSREQUEST_MSG.is_extendable = false
slot2.GET140INFOSREQUEST_MSG.extensions = {}
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.full_name = ".Act140GainProgressRewardReply.activityId"
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.number = 1
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.index = 0
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.label = 1
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.type = 5
slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.name = "Act140GainProgressRewardReply"
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.full_name = ".Act140GainProgressRewardReply"
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.nested_types = {}
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.enum_types = {}
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.fields = {
	slot2.ACT140GAINPROGRESSREWARDREPLYACTIVITYIDFIELD
}
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.is_extendable = false
slot2.ACT140GAINPROGRESSREWARDREPLY_MSG.extensions = {}
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.full_name = ".Act140GainProgressRewardRequest.activityId"
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.name = "Act140GainProgressRewardRequest"
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.full_name = ".Act140GainProgressRewardRequest"
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.nested_types = {}
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.enum_types = {}
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.fields = {
	slot2.ACT140GAINPROGRESSREWARDREQUESTACTIVITYIDFIELD
}
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.is_extendable = false
slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG.extensions = {}
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.full_name = ".Act140BuildReply.activityId"
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.number = 1
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.index = 0
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.label = 1
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.type = 5
slot2.ACT140BUILDREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT140BUILDREPLYIDFIELD.name = "id"
slot2.ACT140BUILDREPLYIDFIELD.full_name = ".Act140BuildReply.id"
slot2.ACT140BUILDREPLYIDFIELD.number = 2
slot2.ACT140BUILDREPLYIDFIELD.index = 1
slot2.ACT140BUILDREPLYIDFIELD.label = 1
slot2.ACT140BUILDREPLYIDFIELD.has_default_value = false
slot2.ACT140BUILDREPLYIDFIELD.default_value = 0
slot2.ACT140BUILDREPLYIDFIELD.type = 5
slot2.ACT140BUILDREPLYIDFIELD.cpp_type = 1
slot2.ACT140BUILDREPLY_MSG.name = "Act140BuildReply"
slot2.ACT140BUILDREPLY_MSG.full_name = ".Act140BuildReply"
slot2.ACT140BUILDREPLY_MSG.nested_types = {}
slot2.ACT140BUILDREPLY_MSG.enum_types = {}
slot2.ACT140BUILDREPLY_MSG.fields = {
	slot2.ACT140BUILDREPLYACTIVITYIDFIELD,
	slot2.ACT140BUILDREPLYIDFIELD
}
slot2.ACT140BUILDREPLY_MSG.is_extendable = false
slot2.ACT140BUILDREPLY_MSG.extensions = {}
slot2.Act140BuildReply = slot1.Message(slot2.ACT140BUILDREPLY_MSG)
slot2.Act140BuildRequest = slot1.Message(slot2.ACT140BUILDREQUEST_MSG)
slot2.Act140BuildingInfo = slot1.Message(slot2.ACT140BUILDINGINFO_MSG)
slot2.Act140GainProgressRewardReply = slot1.Message(slot2.ACT140GAINPROGRESSREWARDREPLY_MSG)
slot2.Act140GainProgressRewardRequest = slot1.Message(slot2.ACT140GAINPROGRESSREWARDREQUEST_MSG)
slot2.Act140SelectBuildReply = slot1.Message(slot2.ACT140SELECTBUILDREPLY_MSG)
slot2.Act140SelectBuildRequest = slot1.Message(slot2.ACT140SELECTBUILDREQUEST_MSG)
slot2.Get140InfosReply = slot1.Message(slot2.GET140INFOSREPLY_MSG)
slot2.Get140InfosRequest = slot1.Message(slot2.GET140INFOSREQUEST_MSG)

return slot2
