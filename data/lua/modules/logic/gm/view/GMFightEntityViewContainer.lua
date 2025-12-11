module("modules.logic.gm.view.GMFightEntityViewContainer", package.seeall)

local var_0_0 = class("GMFightEntityViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "entitys"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "entitys/item"
	var_1_0.cellClass = GMFightEntityItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 430
	var_1_0.cellHeight = 142

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "buff/buffs"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "buff/buffs/item"
	var_1_1.cellClass = GMFightEntityBuffItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 746
	var_1_1.cellHeight = 43

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "skill/skills"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "skill/skills/item"
	var_1_2.cellClass = GMFightEntitySkillItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	var_1_2.lineCount = 1
	var_1_2.cellWidth = 746
	var_1_2.cellHeight = 43

	local var_1_3 = ListScrollParam.New()

	var_1_3.scrollGOPath = "attr"
	var_1_3.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_3.prefabUrl = "attr/item"
	var_1_3.cellClass = GMFightEntityAttrItem
	var_1_3.scrollDir = ScrollEnum.ScrollDirV
	var_1_3.lineCount = 2
	var_1_3.cellWidth = 299
	var_1_3.cellHeight = 258

	local var_1_4 = {}

	arg_1_0.entityListView = LuaListScrollView.New(GMFightEntityModel.instance, var_1_0)

	table.insert(var_1_4, arg_1_0.entityListView)

	arg_1_0.buffListView = LuaListScrollView.New(GMFightEntityModel.instance.buffModel, var_1_1)

	table.insert(var_1_4, arg_1_0.buffListView)

	arg_1_0.skillListView = LuaListScrollView.New(GMFightEntityModel.instance.skillModel, var_1_2)

	table.insert(var_1_4, arg_1_0.skillListView)

	arg_1_0.attrListView = LuaListScrollView.New(GMFightEntityModel.instance.attrModel, var_1_3)

	table.insert(var_1_4, arg_1_0.attrListView)
	table.insert(var_1_4, GMFightEntityView.New())
	table.insert(var_1_4, GMFightEntityInfoView.New())
	table.insert(var_1_4, GMFightEntityBuffView.New())
	table.insert(var_1_4, GMFightEntitySkillView.New())

	return var_1_4
end

function var_0_0.onContainerOpen(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_2_0._onGetEntityInfo, arg_2_0)
end

function var_0_0.onContainerClose(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_3_0._onGetEntityInfo, arg_3_0)
end

function var_0_0._onGetEntityInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.entityInfo
	local var_4_1 = var_4_0.uid
	local var_4_2 = var_4_0 and FightDataHelper.entityMgr:getById(var_4_1)

	if var_4_2 then
		FightDataHelper.entityMgr:addEntityMOByProto(var_4_0)
	end

	local var_4_3 = FightLocalDataMgr.instance.entityMgr:getById(var_4_1)

	if var_4_3 then
		FightEntityDataHelper.copyEntityMO(var_4_2, var_4_3)
	end

	GMFightEntityModel.instance:onGetSingleEntityInfo(arg_4_1)
	FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, var_4_1)
end

function var_0_0.onContainerInit(arg_5_0)
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function var_0_0.onContainerClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

return var_0_0
