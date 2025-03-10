slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.SummonModule_pb", package.seeall)

slot2 = {
	MATERIALMODULE_PB = slot0("modules.proto.MaterialModule_pb"),
	SUMMONQUERYTOKENREPLY_MSG = slot1.Descriptor(),
	SUMMONQUERYTOKENREPLYTOKENFIELD = slot1.FieldDescriptor(),
	CHOOSEMULTIUPHEROREPLY_MSG = slot1.Descriptor(),
	CHOOSEMULTIUPHEROREPLYPOOLIDFIELD = slot1.FieldDescriptor(),
	CHOOSEMULTIUPHEROREPLYHEROIDSFIELD = slot1.FieldDescriptor(),
	SUMMONREQUEST_MSG = slot1.Descriptor(),
	SUMMONREQUESTPOOLIDFIELD = slot1.FieldDescriptor(),
	SUMMONREQUESTGUIDEIDFIELD = slot1.FieldDescriptor(),
	SUMMONREQUESTSTEPIDFIELD = slot1.FieldDescriptor(),
	SUMMONREQUESTCOUNTFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREQUEST_MSG = slot1.Descriptor(),
	OPENLUCKYBAGREPLY_MSG = slot1.Descriptor(),
	OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD = slot1.FieldDescriptor(),
	LUCKYBAGINFO_MSG = slot1.Descriptor(),
	LUCKYBAGINFOCOUNTFIELD = slot1.FieldDescriptor(),
	LUCKYBAGINFOLUCKYBAGIDFIELD = slot1.FieldDescriptor(),
	LUCKYBAGINFOOPENLBTIMESFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREPLY_MSG = slot1.Descriptor(),
	GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREPLYPOOLINFOSFIELD = slot1.FieldDescriptor(),
	GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFO_MSG = slot1.Descriptor(),
	SUMMONPOOLINFOPOOLIDFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOONLINETIMEFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOOFFLINETIMEFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOHAVEFREEFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOUSEDFREECOUNTFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOLUCKYBAGINFOFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOSPPOOLINFOFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFODISCOUNTTIMEFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD = slot1.FieldDescriptor(),
	SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD = slot1.FieldDescriptor(),
	SUMMONRESULT_MSG = slot1.Descriptor(),
	SUMMONRESULTHEROIDFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTISNEWFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTDUPLICATECOUNTFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTEQUIPIDFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTRETURNMATERIALSFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTLUCKYBAGIDFIELD = slot1.FieldDescriptor(),
	SUMMONRESULTLIMITEDTICKETIDFIELD = slot1.FieldDescriptor(),
	SPPOOLINFO_MSG = slot1.Descriptor(),
	SPPOOLINFOTYPEFIELD = slot1.FieldDescriptor(),
	SPPOOLINFOUPHEROIDSFIELD = slot1.FieldDescriptor(),
	SPPOOLINFOLIMITEDTICKETIDFIELD = slot1.FieldDescriptor(),
	SPPOOLINFOLIMITEDTICKETNUMFIELD = slot1.FieldDescriptor(),
	SPPOOLINFOOPENTIMEFIELD = slot1.FieldDescriptor(),
	SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD = slot1.FieldDescriptor(),
	CHOOSEENHANCEDPOOLHEROREQUEST_MSG = slot1.Descriptor(),
	CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD = slot1.FieldDescriptor(),
	CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD = slot1.FieldDescriptor(),
	LUCKYBAGRESULT_MSG = slot1.Descriptor(),
	LUCKYBAGRESULTHEROIDFIELD = slot1.FieldDescriptor(),
	LUCKYBAGRESULTISNEWFIELD = slot1.FieldDescriptor(),
	LUCKYBAGRESULTCURCOUNTFIELD = slot1.FieldDescriptor(),
	LUCKYBAGRESULTRETURNMATERIALSFIELD = slot1.FieldDescriptor(),
	CHOOSEMULTIUPHEROREQUEST_MSG = slot1.Descriptor(),
	CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD = slot1.FieldDescriptor(),
	CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD = slot1.FieldDescriptor(),
	CHOOSEENHANCEDPOOLHEROREPLY_MSG = slot1.Descriptor(),
	CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD = slot1.FieldDescriptor(),
	CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD = slot1.FieldDescriptor(),
	SUMMONQUERYTOKENREQUEST_MSG = slot1.Descriptor(),
	SUMMONREPLY_MSG = slot1.Descriptor(),
	SUMMONREPLYSUMMONRESULTFIELD = slot1.FieldDescriptor(),
	OPENLUCKYBAGREQUEST_MSG = slot1.Descriptor(),
	OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD = slot1.FieldDescriptor(),
	OPENLUCKYBAGREQUESTHEROIDFIELD = slot1.FieldDescriptor()
}
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.name = "token"
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.full_name = ".SummonQueryTokenReply.token"
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.number = 1
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.index = 0
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.label = 1
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.has_default_value = false
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.default_value = ""
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.type = 9
slot2.SUMMONQUERYTOKENREPLYTOKENFIELD.cpp_type = 9
slot2.SUMMONQUERYTOKENREPLY_MSG.name = "SummonQueryTokenReply"
slot2.SUMMONQUERYTOKENREPLY_MSG.full_name = ".SummonQueryTokenReply"
slot2.SUMMONQUERYTOKENREPLY_MSG.nested_types = {}
slot2.SUMMONQUERYTOKENREPLY_MSG.enum_types = {}
slot2.SUMMONQUERYTOKENREPLY_MSG.fields = {
	slot2.SUMMONQUERYTOKENREPLYTOKENFIELD
}
slot2.SUMMONQUERYTOKENREPLY_MSG.is_extendable = false
slot2.SUMMONQUERYTOKENREPLY_MSG.extensions = {}
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.name = "poolId"
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.full_name = ".ChooseMultiUpHeroReply.poolId"
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.number = 1
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.index = 0
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.label = 1
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.has_default_value = false
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.default_value = 0
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.type = 5
slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD.cpp_type = 1
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.name = "heroIds"
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.full_name = ".ChooseMultiUpHeroReply.heroIds"
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.number = 2
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.index = 1
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.label = 3
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.has_default_value = false
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.default_value = {}
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.type = 5
slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD.cpp_type = 1
slot2.CHOOSEMULTIUPHEROREPLY_MSG.name = "ChooseMultiUpHeroReply"
slot2.CHOOSEMULTIUPHEROREPLY_MSG.full_name = ".ChooseMultiUpHeroReply"
slot2.CHOOSEMULTIUPHEROREPLY_MSG.nested_types = {}
slot2.CHOOSEMULTIUPHEROREPLY_MSG.enum_types = {}
slot2.CHOOSEMULTIUPHEROREPLY_MSG.fields = {
	slot2.CHOOSEMULTIUPHEROREPLYPOOLIDFIELD,
	slot2.CHOOSEMULTIUPHEROREPLYHEROIDSFIELD
}
slot2.CHOOSEMULTIUPHEROREPLY_MSG.is_extendable = false
slot2.CHOOSEMULTIUPHEROREPLY_MSG.extensions = {}
slot2.SUMMONREQUESTPOOLIDFIELD.name = "poolId"
slot2.SUMMONREQUESTPOOLIDFIELD.full_name = ".SummonRequest.poolId"
slot2.SUMMONREQUESTPOOLIDFIELD.number = 1
slot2.SUMMONREQUESTPOOLIDFIELD.index = 0
slot2.SUMMONREQUESTPOOLIDFIELD.label = 1
slot2.SUMMONREQUESTPOOLIDFIELD.has_default_value = false
slot2.SUMMONREQUESTPOOLIDFIELD.default_value = 0
slot2.SUMMONREQUESTPOOLIDFIELD.type = 5
slot2.SUMMONREQUESTPOOLIDFIELD.cpp_type = 1
slot2.SUMMONREQUESTGUIDEIDFIELD.name = "guideId"
slot2.SUMMONREQUESTGUIDEIDFIELD.full_name = ".SummonRequest.guideId"
slot2.SUMMONREQUESTGUIDEIDFIELD.number = 2
slot2.SUMMONREQUESTGUIDEIDFIELD.index = 1
slot2.SUMMONREQUESTGUIDEIDFIELD.label = 1
slot2.SUMMONREQUESTGUIDEIDFIELD.has_default_value = false
slot2.SUMMONREQUESTGUIDEIDFIELD.default_value = 0
slot2.SUMMONREQUESTGUIDEIDFIELD.type = 5
slot2.SUMMONREQUESTGUIDEIDFIELD.cpp_type = 1
slot2.SUMMONREQUESTSTEPIDFIELD.name = "stepId"
slot2.SUMMONREQUESTSTEPIDFIELD.full_name = ".SummonRequest.stepId"
slot2.SUMMONREQUESTSTEPIDFIELD.number = 3
slot2.SUMMONREQUESTSTEPIDFIELD.index = 2
slot2.SUMMONREQUESTSTEPIDFIELD.label = 1
slot2.SUMMONREQUESTSTEPIDFIELD.has_default_value = false
slot2.SUMMONREQUESTSTEPIDFIELD.default_value = 0
slot2.SUMMONREQUESTSTEPIDFIELD.type = 5
slot2.SUMMONREQUESTSTEPIDFIELD.cpp_type = 1
slot2.SUMMONREQUESTCOUNTFIELD.name = "count"
slot2.SUMMONREQUESTCOUNTFIELD.full_name = ".SummonRequest.count"
slot2.SUMMONREQUESTCOUNTFIELD.number = 4
slot2.SUMMONREQUESTCOUNTFIELD.index = 3
slot2.SUMMONREQUESTCOUNTFIELD.label = 1
slot2.SUMMONREQUESTCOUNTFIELD.has_default_value = false
slot2.SUMMONREQUESTCOUNTFIELD.default_value = 0
slot2.SUMMONREQUESTCOUNTFIELD.type = 5
slot2.SUMMONREQUESTCOUNTFIELD.cpp_type = 1
slot2.SUMMONREQUEST_MSG.name = "SummonRequest"
slot2.SUMMONREQUEST_MSG.full_name = ".SummonRequest"
slot2.SUMMONREQUEST_MSG.nested_types = {}
slot2.SUMMONREQUEST_MSG.enum_types = {}
slot2.SUMMONREQUEST_MSG.fields = {
	slot2.SUMMONREQUESTPOOLIDFIELD,
	slot2.SUMMONREQUESTGUIDEIDFIELD,
	slot2.SUMMONREQUESTSTEPIDFIELD,
	slot2.SUMMONREQUESTCOUNTFIELD
}
slot2.SUMMONREQUEST_MSG.is_extendable = false
slot2.SUMMONREQUEST_MSG.extensions = {}
slot2.GETSUMMONINFOREQUEST_MSG.name = "GetSummonInfoRequest"
slot2.GETSUMMONINFOREQUEST_MSG.full_name = ".GetSummonInfoRequest"
slot2.GETSUMMONINFOREQUEST_MSG.nested_types = {}
slot2.GETSUMMONINFOREQUEST_MSG.enum_types = {}
slot2.GETSUMMONINFOREQUEST_MSG.fields = {}
slot2.GETSUMMONINFOREQUEST_MSG.is_extendable = false
slot2.GETSUMMONINFOREQUEST_MSG.extensions = {}
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.name = "luckyBagResults"
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.full_name = ".OpenLuckyBagReply.luckyBagResults"
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.number = 1
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.index = 0
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.label = 3
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.has_default_value = false
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.default_value = {}
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.message_type = slot2.LUCKYBAGRESULT_MSG
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.type = 11
slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD.cpp_type = 10
slot2.OPENLUCKYBAGREPLY_MSG.name = "OpenLuckyBagReply"
slot2.OPENLUCKYBAGREPLY_MSG.full_name = ".OpenLuckyBagReply"
slot2.OPENLUCKYBAGREPLY_MSG.nested_types = {}
slot2.OPENLUCKYBAGREPLY_MSG.enum_types = {}
slot2.OPENLUCKYBAGREPLY_MSG.fields = {
	slot2.OPENLUCKYBAGREPLYLUCKYBAGRESULTSFIELD
}
slot2.OPENLUCKYBAGREPLY_MSG.is_extendable = false
slot2.OPENLUCKYBAGREPLY_MSG.extensions = {}
slot2.LUCKYBAGINFOCOUNTFIELD.name = "count"
slot2.LUCKYBAGINFOCOUNTFIELD.full_name = ".LuckyBagInfo.count"
slot2.LUCKYBAGINFOCOUNTFIELD.number = 1
slot2.LUCKYBAGINFOCOUNTFIELD.index = 0
slot2.LUCKYBAGINFOCOUNTFIELD.label = 1
slot2.LUCKYBAGINFOCOUNTFIELD.has_default_value = false
slot2.LUCKYBAGINFOCOUNTFIELD.default_value = 0
slot2.LUCKYBAGINFOCOUNTFIELD.type = 5
slot2.LUCKYBAGINFOCOUNTFIELD.cpp_type = 1
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.name = "luckyBagId"
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.full_name = ".LuckyBagInfo.luckyBagId"
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.number = 2
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.index = 1
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.label = 1
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.has_default_value = false
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.default_value = 0
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.type = 5
slot2.LUCKYBAGINFOLUCKYBAGIDFIELD.cpp_type = 1
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.name = "openLBTimes"
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.full_name = ".LuckyBagInfo.openLBTimes"
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.number = 3
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.index = 2
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.label = 1
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.has_default_value = false
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.default_value = 0
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.type = 5
slot2.LUCKYBAGINFOOPENLBTIMESFIELD.cpp_type = 1
slot2.LUCKYBAGINFO_MSG.name = "LuckyBagInfo"
slot2.LUCKYBAGINFO_MSG.full_name = ".LuckyBagInfo"
slot2.LUCKYBAGINFO_MSG.nested_types = {}
slot2.LUCKYBAGINFO_MSG.enum_types = {}
slot2.LUCKYBAGINFO_MSG.fields = {
	slot2.LUCKYBAGINFOCOUNTFIELD,
	slot2.LUCKYBAGINFOLUCKYBAGIDFIELD,
	slot2.LUCKYBAGINFOOPENLBTIMESFIELD
}
slot2.LUCKYBAGINFO_MSG.is_extendable = false
slot2.LUCKYBAGINFO_MSG.extensions = {}
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.name = "freeEquipSummon"
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.full_name = ".GetSummonInfoReply.freeEquipSummon"
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.number = 1
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.index = 0
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.label = 1
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.has_default_value = false
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.default_value = false
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.type = 8
slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD.cpp_type = 7
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.name = "isShowNewSummon"
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.full_name = ".GetSummonInfoReply.isShowNewSummon"
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.number = 2
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.index = 1
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.label = 1
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.has_default_value = false
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.default_value = false
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.type = 8
slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD.cpp_type = 7
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.name = "newSummonCount"
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.full_name = ".GetSummonInfoReply.newSummonCount"
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.number = 3
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.index = 2
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.label = 1
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.has_default_value = false
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.default_value = 0
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.type = 5
slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD.cpp_type = 1
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.name = "poolInfos"
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.full_name = ".GetSummonInfoReply.poolInfos"
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.number = 4
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.index = 3
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.label = 3
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.has_default_value = false
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.default_value = {}
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.message_type = slot2.SUMMONPOOLINFO_MSG
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.type = 11
slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD.cpp_type = 10
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.name = "totalSummonCount"
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.full_name = ".GetSummonInfoReply.totalSummonCount"
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.number = 5
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.index = 4
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.label = 1
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.has_default_value = false
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.default_value = 0
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.type = 5
slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD.cpp_type = 1
slot2.GETSUMMONINFOREPLY_MSG.name = "GetSummonInfoReply"
slot2.GETSUMMONINFOREPLY_MSG.full_name = ".GetSummonInfoReply"
slot2.GETSUMMONINFOREPLY_MSG.nested_types = {}
slot2.GETSUMMONINFOREPLY_MSG.enum_types = {}
slot2.GETSUMMONINFOREPLY_MSG.fields = {
	slot2.GETSUMMONINFOREPLYFREEEQUIPSUMMONFIELD,
	slot2.GETSUMMONINFOREPLYISSHOWNEWSUMMONFIELD,
	slot2.GETSUMMONINFOREPLYNEWSUMMONCOUNTFIELD,
	slot2.GETSUMMONINFOREPLYPOOLINFOSFIELD,
	slot2.GETSUMMONINFOREPLYTOTALSUMMONCOUNTFIELD
}
slot2.GETSUMMONINFOREPLY_MSG.is_extendable = false
slot2.GETSUMMONINFOREPLY_MSG.extensions = {}
slot2.SUMMONPOOLINFOPOOLIDFIELD.name = "poolId"
slot2.SUMMONPOOLINFOPOOLIDFIELD.full_name = ".SummonPoolInfo.poolId"
slot2.SUMMONPOOLINFOPOOLIDFIELD.number = 1
slot2.SUMMONPOOLINFOPOOLIDFIELD.index = 0
slot2.SUMMONPOOLINFOPOOLIDFIELD.label = 1
slot2.SUMMONPOOLINFOPOOLIDFIELD.has_default_value = false
slot2.SUMMONPOOLINFOPOOLIDFIELD.default_value = 0
slot2.SUMMONPOOLINFOPOOLIDFIELD.type = 5
slot2.SUMMONPOOLINFOPOOLIDFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOONLINETIMEFIELD.name = "onlineTime"
slot2.SUMMONPOOLINFOONLINETIMEFIELD.full_name = ".SummonPoolInfo.onlineTime"
slot2.SUMMONPOOLINFOONLINETIMEFIELD.number = 2
slot2.SUMMONPOOLINFOONLINETIMEFIELD.index = 1
slot2.SUMMONPOOLINFOONLINETIMEFIELD.label = 1
slot2.SUMMONPOOLINFOONLINETIMEFIELD.has_default_value = false
slot2.SUMMONPOOLINFOONLINETIMEFIELD.default_value = 0
slot2.SUMMONPOOLINFOONLINETIMEFIELD.type = 5
slot2.SUMMONPOOLINFOONLINETIMEFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.name = "offlineTime"
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.full_name = ".SummonPoolInfo.offlineTime"
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.number = 3
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.index = 2
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.label = 1
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.has_default_value = false
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.default_value = 0
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.type = 5
slot2.SUMMONPOOLINFOOFFLINETIMEFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOHAVEFREEFIELD.name = "haveFree"
slot2.SUMMONPOOLINFOHAVEFREEFIELD.full_name = ".SummonPoolInfo.haveFree"
slot2.SUMMONPOOLINFOHAVEFREEFIELD.number = 4
slot2.SUMMONPOOLINFOHAVEFREEFIELD.index = 3
slot2.SUMMONPOOLINFOHAVEFREEFIELD.label = 1
slot2.SUMMONPOOLINFOHAVEFREEFIELD.has_default_value = false
slot2.SUMMONPOOLINFOHAVEFREEFIELD.default_value = false
slot2.SUMMONPOOLINFOHAVEFREEFIELD.type = 8
slot2.SUMMONPOOLINFOHAVEFREEFIELD.cpp_type = 7
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.name = "usedFreeCount"
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.full_name = ".SummonPoolInfo.usedFreeCount"
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.number = 5
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.index = 4
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.label = 1
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.has_default_value = false
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.default_value = 0
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.type = 5
slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.name = "luckyBagInfo"
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.full_name = ".SummonPoolInfo.luckyBagInfo"
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.number = 6
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.index = 5
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.label = 1
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.has_default_value = false
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.default_value = nil
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.message_type = slot2.LUCKYBAGINFO_MSG
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.type = 11
slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD.cpp_type = 10
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.name = "spPoolInfo"
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.full_name = ".SummonPoolInfo.spPoolInfo"
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.number = 7
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.index = 6
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.label = 1
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.has_default_value = false
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.default_value = nil
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.message_type = slot2.SPPOOLINFO_MSG
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.type = 11
slot2.SUMMONPOOLINFOSPPOOLINFOFIELD.cpp_type = 10
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.name = "discountTime"
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.full_name = ".SummonPoolInfo.discountTime"
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.number = 8
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.index = 7
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.label = 1
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.has_default_value = false
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.default_value = 0
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.type = 5
slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.name = "canGetGuaranteeSRCount"
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.full_name = ".SummonPoolInfo.canGetGuaranteeSRCount"
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.number = 9
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.index = 8
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.label = 1
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.has_default_value = false
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.default_value = 0
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.type = 5
slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD.cpp_type = 1
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.name = "guaranteeSRCountDown"
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.full_name = ".SummonPoolInfo.guaranteeSRCountDown"
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.number = 10
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.index = 9
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.label = 1
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.has_default_value = false
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.default_value = 0
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.type = 5
slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD.cpp_type = 1
slot2.SUMMONPOOLINFO_MSG.name = "SummonPoolInfo"
slot2.SUMMONPOOLINFO_MSG.full_name = ".SummonPoolInfo"
slot2.SUMMONPOOLINFO_MSG.nested_types = {}
slot2.SUMMONPOOLINFO_MSG.enum_types = {}
slot2.SUMMONPOOLINFO_MSG.fields = {
	slot2.SUMMONPOOLINFOPOOLIDFIELD,
	slot2.SUMMONPOOLINFOONLINETIMEFIELD,
	slot2.SUMMONPOOLINFOOFFLINETIMEFIELD,
	slot2.SUMMONPOOLINFOHAVEFREEFIELD,
	slot2.SUMMONPOOLINFOUSEDFREECOUNTFIELD,
	slot2.SUMMONPOOLINFOLUCKYBAGINFOFIELD,
	slot2.SUMMONPOOLINFOSPPOOLINFOFIELD,
	slot2.SUMMONPOOLINFODISCOUNTTIMEFIELD,
	slot2.SUMMONPOOLINFOCANGETGUARANTEESRCOUNTFIELD,
	slot2.SUMMONPOOLINFOGUARANTEESRCOUNTDOWNFIELD
}
slot2.SUMMONPOOLINFO_MSG.is_extendable = false
slot2.SUMMONPOOLINFO_MSG.extensions = {}
slot2.SUMMONRESULTHEROIDFIELD.name = "heroId"
slot2.SUMMONRESULTHEROIDFIELD.full_name = ".SummonResult.heroId"
slot2.SUMMONRESULTHEROIDFIELD.number = 1
slot2.SUMMONRESULTHEROIDFIELD.index = 0
slot2.SUMMONRESULTHEROIDFIELD.label = 1
slot2.SUMMONRESULTHEROIDFIELD.has_default_value = false
slot2.SUMMONRESULTHEROIDFIELD.default_value = 0
slot2.SUMMONRESULTHEROIDFIELD.type = 5
slot2.SUMMONRESULTHEROIDFIELD.cpp_type = 1
slot2.SUMMONRESULTISNEWFIELD.name = "isNew"
slot2.SUMMONRESULTISNEWFIELD.full_name = ".SummonResult.isNew"
slot2.SUMMONRESULTISNEWFIELD.number = 2
slot2.SUMMONRESULTISNEWFIELD.index = 1
slot2.SUMMONRESULTISNEWFIELD.label = 1
slot2.SUMMONRESULTISNEWFIELD.has_default_value = false
slot2.SUMMONRESULTISNEWFIELD.default_value = false
slot2.SUMMONRESULTISNEWFIELD.type = 8
slot2.SUMMONRESULTISNEWFIELD.cpp_type = 7
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.name = "duplicateCount"
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.full_name = ".SummonResult.duplicateCount"
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.number = 3
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.index = 2
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.label = 1
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.has_default_value = false
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.default_value = 0
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.type = 5
slot2.SUMMONRESULTDUPLICATECOUNTFIELD.cpp_type = 1
slot2.SUMMONRESULTEQUIPIDFIELD.name = "equipId"
slot2.SUMMONRESULTEQUIPIDFIELD.full_name = ".SummonResult.equipId"
slot2.SUMMONRESULTEQUIPIDFIELD.number = 4
slot2.SUMMONRESULTEQUIPIDFIELD.index = 3
slot2.SUMMONRESULTEQUIPIDFIELD.label = 1
slot2.SUMMONRESULTEQUIPIDFIELD.has_default_value = false
slot2.SUMMONRESULTEQUIPIDFIELD.default_value = 0
slot2.SUMMONRESULTEQUIPIDFIELD.type = 5
slot2.SUMMONRESULTEQUIPIDFIELD.cpp_type = 1
slot2.SUMMONRESULTRETURNMATERIALSFIELD.name = "returnMaterials"
slot2.SUMMONRESULTRETURNMATERIALSFIELD.full_name = ".SummonResult.returnMaterials"
slot2.SUMMONRESULTRETURNMATERIALSFIELD.number = 5
slot2.SUMMONRESULTRETURNMATERIALSFIELD.index = 4
slot2.SUMMONRESULTRETURNMATERIALSFIELD.label = 3
slot2.SUMMONRESULTRETURNMATERIALSFIELD.has_default_value = false
slot2.SUMMONRESULTRETURNMATERIALSFIELD.default_value = {}
slot2.SUMMONRESULTRETURNMATERIALSFIELD.message_type = slot2.MATERIALMODULE_PB.MATERIALDATA_MSG
slot2.SUMMONRESULTRETURNMATERIALSFIELD.type = 11
slot2.SUMMONRESULTRETURNMATERIALSFIELD.cpp_type = 10
slot2.SUMMONRESULTLUCKYBAGIDFIELD.name = "luckyBagId"
slot2.SUMMONRESULTLUCKYBAGIDFIELD.full_name = ".SummonResult.luckyBagId"
slot2.SUMMONRESULTLUCKYBAGIDFIELD.number = 6
slot2.SUMMONRESULTLUCKYBAGIDFIELD.index = 5
slot2.SUMMONRESULTLUCKYBAGIDFIELD.label = 1
slot2.SUMMONRESULTLUCKYBAGIDFIELD.has_default_value = false
slot2.SUMMONRESULTLUCKYBAGIDFIELD.default_value = 0
slot2.SUMMONRESULTLUCKYBAGIDFIELD.type = 5
slot2.SUMMONRESULTLUCKYBAGIDFIELD.cpp_type = 1
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.name = "limitedTicketId"
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.full_name = ".SummonResult.limitedTicketId"
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.number = 7
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.index = 6
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.label = 1
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.has_default_value = false
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.default_value = 0
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.type = 5
slot2.SUMMONRESULTLIMITEDTICKETIDFIELD.cpp_type = 1
slot2.SUMMONRESULT_MSG.name = "SummonResult"
slot2.SUMMONRESULT_MSG.full_name = ".SummonResult"
slot2.SUMMONRESULT_MSG.nested_types = {}
slot2.SUMMONRESULT_MSG.enum_types = {}
slot2.SUMMONRESULT_MSG.fields = {
	slot2.SUMMONRESULTHEROIDFIELD,
	slot2.SUMMONRESULTISNEWFIELD,
	slot2.SUMMONRESULTDUPLICATECOUNTFIELD,
	slot2.SUMMONRESULTEQUIPIDFIELD,
	slot2.SUMMONRESULTRETURNMATERIALSFIELD,
	slot2.SUMMONRESULTLUCKYBAGIDFIELD,
	slot2.SUMMONRESULTLIMITEDTICKETIDFIELD
}
slot2.SUMMONRESULT_MSG.is_extendable = false
slot2.SUMMONRESULT_MSG.extensions = {}
slot2.SPPOOLINFOTYPEFIELD.name = "type"
slot2.SPPOOLINFOTYPEFIELD.full_name = ".SpPoolInfo.type"
slot2.SPPOOLINFOTYPEFIELD.number = 1
slot2.SPPOOLINFOTYPEFIELD.index = 0
slot2.SPPOOLINFOTYPEFIELD.label = 1
slot2.SPPOOLINFOTYPEFIELD.has_default_value = false
slot2.SPPOOLINFOTYPEFIELD.default_value = 0
slot2.SPPOOLINFOTYPEFIELD.type = 5
slot2.SPPOOLINFOTYPEFIELD.cpp_type = 1
slot2.SPPOOLINFOUPHEROIDSFIELD.name = "UpHeroIds"
slot2.SPPOOLINFOUPHEROIDSFIELD.full_name = ".SpPoolInfo.UpHeroIds"
slot2.SPPOOLINFOUPHEROIDSFIELD.number = 2
slot2.SPPOOLINFOUPHEROIDSFIELD.index = 1
slot2.SPPOOLINFOUPHEROIDSFIELD.label = 3
slot2.SPPOOLINFOUPHEROIDSFIELD.has_default_value = false
slot2.SPPOOLINFOUPHEROIDSFIELD.default_value = {}
slot2.SPPOOLINFOUPHEROIDSFIELD.type = 5
slot2.SPPOOLINFOUPHEROIDSFIELD.cpp_type = 1
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.name = "limitedTicketId"
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.full_name = ".SpPoolInfo.limitedTicketId"
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.number = 3
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.index = 2
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.label = 1
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.has_default_value = false
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.default_value = 0
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.type = 5
slot2.SPPOOLINFOLIMITEDTICKETIDFIELD.cpp_type = 1
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.name = "limitedTicketNum"
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.full_name = ".SpPoolInfo.limitedTicketNum"
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.number = 4
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.index = 3
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.label = 1
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.has_default_value = false
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.default_value = 0
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.type = 5
slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD.cpp_type = 1
slot2.SPPOOLINFOOPENTIMEFIELD.name = "openTime"
slot2.SPPOOLINFOOPENTIMEFIELD.full_name = ".SpPoolInfo.openTime"
slot2.SPPOOLINFOOPENTIMEFIELD.number = 5
slot2.SPPOOLINFOOPENTIMEFIELD.index = 4
slot2.SPPOOLINFOOPENTIMEFIELD.label = 1
slot2.SPPOOLINFOOPENTIMEFIELD.has_default_value = false
slot2.SPPOOLINFOOPENTIMEFIELD.default_value = 0
slot2.SPPOOLINFOOPENTIMEFIELD.type = 4
slot2.SPPOOLINFOOPENTIMEFIELD.cpp_type = 4
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.name = "usedFirstSSRGuarantee"
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.full_name = ".SpPoolInfo.usedFirstSSRGuarantee"
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.number = 6
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.index = 5
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.label = 1
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.has_default_value = false
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.default_value = false
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.type = 8
slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD.cpp_type = 7
slot2.SPPOOLINFO_MSG.name = "SpPoolInfo"
slot2.SPPOOLINFO_MSG.full_name = ".SpPoolInfo"
slot2.SPPOOLINFO_MSG.nested_types = {}
slot2.SPPOOLINFO_MSG.enum_types = {}
slot2.SPPOOLINFO_MSG.fields = {
	slot2.SPPOOLINFOTYPEFIELD,
	slot2.SPPOOLINFOUPHEROIDSFIELD,
	slot2.SPPOOLINFOLIMITEDTICKETIDFIELD,
	slot2.SPPOOLINFOLIMITEDTICKETNUMFIELD,
	slot2.SPPOOLINFOOPENTIMEFIELD,
	slot2.SPPOOLINFOUSEDFIRSTSSRGUARANTEEFIELD
}
slot2.SPPOOLINFO_MSG.is_extendable = false
slot2.SPPOOLINFO_MSG.extensions = {}
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.name = "poolId"
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.full_name = ".ChooseEnhancedPoolHeroRequest.poolId"
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.number = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.index = 0
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.label = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.has_default_value = false
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.default_value = 0
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.type = 5
slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD.cpp_type = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.name = "heroId"
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.full_name = ".ChooseEnhancedPoolHeroRequest.heroId"
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.number = 2
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.index = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.label = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.has_default_value = false
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.default_value = 0
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.type = 5
slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD.cpp_type = 1
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.name = "ChooseEnhancedPoolHeroRequest"
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.full_name = ".ChooseEnhancedPoolHeroRequest"
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.nested_types = {}
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.enum_types = {}
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.fields = {
	slot2.CHOOSEENHANCEDPOOLHEROREQUESTPOOLIDFIELD,
	slot2.CHOOSEENHANCEDPOOLHEROREQUESTHEROIDFIELD
}
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.is_extendable = false
slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG.extensions = {}
slot2.LUCKYBAGRESULTHEROIDFIELD.name = "heroId"
slot2.LUCKYBAGRESULTHEROIDFIELD.full_name = ".LuckyBagResult.heroId"
slot2.LUCKYBAGRESULTHEROIDFIELD.number = 1
slot2.LUCKYBAGRESULTHEROIDFIELD.index = 0
slot2.LUCKYBAGRESULTHEROIDFIELD.label = 1
slot2.LUCKYBAGRESULTHEROIDFIELD.has_default_value = false
slot2.LUCKYBAGRESULTHEROIDFIELD.default_value = 0
slot2.LUCKYBAGRESULTHEROIDFIELD.type = 5
slot2.LUCKYBAGRESULTHEROIDFIELD.cpp_type = 1
slot2.LUCKYBAGRESULTISNEWFIELD.name = "isNew"
slot2.LUCKYBAGRESULTISNEWFIELD.full_name = ".LuckyBagResult.isNew"
slot2.LUCKYBAGRESULTISNEWFIELD.number = 2
slot2.LUCKYBAGRESULTISNEWFIELD.index = 1
slot2.LUCKYBAGRESULTISNEWFIELD.label = 1
slot2.LUCKYBAGRESULTISNEWFIELD.has_default_value = false
slot2.LUCKYBAGRESULTISNEWFIELD.default_value = false
slot2.LUCKYBAGRESULTISNEWFIELD.type = 8
slot2.LUCKYBAGRESULTISNEWFIELD.cpp_type = 7
slot2.LUCKYBAGRESULTCURCOUNTFIELD.name = "curCount"
slot2.LUCKYBAGRESULTCURCOUNTFIELD.full_name = ".LuckyBagResult.curCount"
slot2.LUCKYBAGRESULTCURCOUNTFIELD.number = 3
slot2.LUCKYBAGRESULTCURCOUNTFIELD.index = 2
slot2.LUCKYBAGRESULTCURCOUNTFIELD.label = 1
slot2.LUCKYBAGRESULTCURCOUNTFIELD.has_default_value = false
slot2.LUCKYBAGRESULTCURCOUNTFIELD.default_value = 0
slot2.LUCKYBAGRESULTCURCOUNTFIELD.type = 5
slot2.LUCKYBAGRESULTCURCOUNTFIELD.cpp_type = 1
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.name = "returnMaterials"
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.full_name = ".LuckyBagResult.returnMaterials"
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.number = 4
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.index = 3
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.label = 3
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.has_default_value = false
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.default_value = {}
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.message_type = slot2.MATERIALMODULE_PB.MATERIALDATA_MSG
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.type = 11
slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD.cpp_type = 10
slot2.LUCKYBAGRESULT_MSG.name = "LuckyBagResult"
slot2.LUCKYBAGRESULT_MSG.full_name = ".LuckyBagResult"
slot2.LUCKYBAGRESULT_MSG.nested_types = {}
slot2.LUCKYBAGRESULT_MSG.enum_types = {}
slot2.LUCKYBAGRESULT_MSG.fields = {
	slot2.LUCKYBAGRESULTHEROIDFIELD,
	slot2.LUCKYBAGRESULTISNEWFIELD,
	slot2.LUCKYBAGRESULTCURCOUNTFIELD,
	slot2.LUCKYBAGRESULTRETURNMATERIALSFIELD
}
slot2.LUCKYBAGRESULT_MSG.is_extendable = false
slot2.LUCKYBAGRESULT_MSG.extensions = {}
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.name = "poolId"
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.full_name = ".ChooseMultiUpHeroRequest.poolId"
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.number = 1
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.index = 0
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.label = 1
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.has_default_value = false
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.default_value = 0
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.type = 5
slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD.cpp_type = 1
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.name = "heroIds"
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.full_name = ".ChooseMultiUpHeroRequest.heroIds"
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.number = 2
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.index = 1
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.label = 3
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.has_default_value = false
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.default_value = {}
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.type = 5
slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD.cpp_type = 1
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.name = "ChooseMultiUpHeroRequest"
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.full_name = ".ChooseMultiUpHeroRequest"
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.nested_types = {}
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.enum_types = {}
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.fields = {
	slot2.CHOOSEMULTIUPHEROREQUESTPOOLIDFIELD,
	slot2.CHOOSEMULTIUPHEROREQUESTHEROIDSFIELD
}
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.is_extendable = false
slot2.CHOOSEMULTIUPHEROREQUEST_MSG.extensions = {}
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.name = "poolId"
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.full_name = ".ChooseEnhancedPoolHeroReply.poolId"
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.number = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.index = 0
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.label = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.has_default_value = false
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.default_value = 0
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.type = 5
slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD.cpp_type = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.name = "heroId"
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.full_name = ".ChooseEnhancedPoolHeroReply.heroId"
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.number = 2
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.index = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.label = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.has_default_value = false
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.default_value = 0
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.type = 5
slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD.cpp_type = 1
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.name = "ChooseEnhancedPoolHeroReply"
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.full_name = ".ChooseEnhancedPoolHeroReply"
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.nested_types = {}
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.enum_types = {}
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.fields = {
	slot2.CHOOSEENHANCEDPOOLHEROREPLYPOOLIDFIELD,
	slot2.CHOOSEENHANCEDPOOLHEROREPLYHEROIDFIELD
}
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.is_extendable = false
slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG.extensions = {}
slot2.SUMMONQUERYTOKENREQUEST_MSG.name = "SummonQueryTokenRequest"
slot2.SUMMONQUERYTOKENREQUEST_MSG.full_name = ".SummonQueryTokenRequest"
slot2.SUMMONQUERYTOKENREQUEST_MSG.nested_types = {}
slot2.SUMMONQUERYTOKENREQUEST_MSG.enum_types = {}
slot2.SUMMONQUERYTOKENREQUEST_MSG.fields = {}
slot2.SUMMONQUERYTOKENREQUEST_MSG.is_extendable = false
slot2.SUMMONQUERYTOKENREQUEST_MSG.extensions = {}
slot2.SUMMONREPLYSUMMONRESULTFIELD.name = "summonResult"
slot2.SUMMONREPLYSUMMONRESULTFIELD.full_name = ".SummonReply.summonResult"
slot2.SUMMONREPLYSUMMONRESULTFIELD.number = 1
slot2.SUMMONREPLYSUMMONRESULTFIELD.index = 0
slot2.SUMMONREPLYSUMMONRESULTFIELD.label = 3
slot2.SUMMONREPLYSUMMONRESULTFIELD.has_default_value = false
slot2.SUMMONREPLYSUMMONRESULTFIELD.default_value = {}
slot2.SUMMONREPLYSUMMONRESULTFIELD.message_type = slot2.SUMMONRESULT_MSG
slot2.SUMMONREPLYSUMMONRESULTFIELD.type = 11
slot2.SUMMONREPLYSUMMONRESULTFIELD.cpp_type = 10
slot2.SUMMONREPLY_MSG.name = "SummonReply"
slot2.SUMMONREPLY_MSG.full_name = ".SummonReply"
slot2.SUMMONREPLY_MSG.nested_types = {}
slot2.SUMMONREPLY_MSG.enum_types = {}
slot2.SUMMONREPLY_MSG.fields = {
	slot2.SUMMONREPLYSUMMONRESULTFIELD
}
slot2.SUMMONREPLY_MSG.is_extendable = false
slot2.SUMMONREPLY_MSG.extensions = {}
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.name = "luckyBagId"
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.full_name = ".OpenLuckyBagRequest.luckyBagId"
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.number = 1
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.index = 0
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.label = 1
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.has_default_value = false
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.default_value = 0
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.type = 5
slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD.cpp_type = 1
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.name = "heroId"
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.full_name = ".OpenLuckyBagRequest.heroId"
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.number = 2
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.index = 1
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.label = 1
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.has_default_value = false
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.default_value = 0
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.type = 5
slot2.OPENLUCKYBAGREQUESTHEROIDFIELD.cpp_type = 1
slot2.OPENLUCKYBAGREQUEST_MSG.name = "OpenLuckyBagRequest"
slot2.OPENLUCKYBAGREQUEST_MSG.full_name = ".OpenLuckyBagRequest"
slot2.OPENLUCKYBAGREQUEST_MSG.nested_types = {}
slot2.OPENLUCKYBAGREQUEST_MSG.enum_types = {}
slot2.OPENLUCKYBAGREQUEST_MSG.fields = {
	slot2.OPENLUCKYBAGREQUESTLUCKYBAGIDFIELD,
	slot2.OPENLUCKYBAGREQUESTHEROIDFIELD
}
slot2.OPENLUCKYBAGREQUEST_MSG.is_extendable = false
slot2.OPENLUCKYBAGREQUEST_MSG.extensions = {}
slot2.ChooseEnhancedPoolHeroReply = slot1.Message(slot2.CHOOSEENHANCEDPOOLHEROREPLY_MSG)
slot2.ChooseEnhancedPoolHeroRequest = slot1.Message(slot2.CHOOSEENHANCEDPOOLHEROREQUEST_MSG)
slot2.ChooseMultiUpHeroReply = slot1.Message(slot2.CHOOSEMULTIUPHEROREPLY_MSG)
slot2.ChooseMultiUpHeroRequest = slot1.Message(slot2.CHOOSEMULTIUPHEROREQUEST_MSG)
slot2.GetSummonInfoReply = slot1.Message(slot2.GETSUMMONINFOREPLY_MSG)
slot2.GetSummonInfoRequest = slot1.Message(slot2.GETSUMMONINFOREQUEST_MSG)
slot2.LuckyBagInfo = slot1.Message(slot2.LUCKYBAGINFO_MSG)
slot2.LuckyBagResult = slot1.Message(slot2.LUCKYBAGRESULT_MSG)
slot2.OpenLuckyBagReply = slot1.Message(slot2.OPENLUCKYBAGREPLY_MSG)
slot2.OpenLuckyBagRequest = slot1.Message(slot2.OPENLUCKYBAGREQUEST_MSG)
slot2.SpPoolInfo = slot1.Message(slot2.SPPOOLINFO_MSG)
slot2.SummonPoolInfo = slot1.Message(slot2.SUMMONPOOLINFO_MSG)
slot2.SummonQueryTokenReply = slot1.Message(slot2.SUMMONQUERYTOKENREPLY_MSG)
slot2.SummonQueryTokenRequest = slot1.Message(slot2.SUMMONQUERYTOKENREQUEST_MSG)
slot2.SummonReply = slot1.Message(slot2.SUMMONREPLY_MSG)
slot2.SummonRequest = slot1.Message(slot2.SUMMONREQUEST_MSG)
slot2.SummonResult = slot1.Message(slot2.SUMMONRESULT_MSG)

return slot2
