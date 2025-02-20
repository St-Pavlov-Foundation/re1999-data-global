module("modules.logic.gm.view.GMFightEntityViewContainer", package.seeall)

slot0 = class("GMFightEntityViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "entitys"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "entitys/item"
	slot1.cellClass = GMFightEntityItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 430
	slot1.cellHeight = 142
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "buff/buffs"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "buff/buffs/item"
	slot2.cellClass = GMFightEntityBuffItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 746
	slot2.cellHeight = 43
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "skill/skills"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "skill/skills/item"
	slot3.cellClass = GMFightEntitySkillItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 1
	slot3.cellWidth = 746
	slot3.cellHeight = 43
	slot4 = ListScrollParam.New()
	slot4.scrollGOPath = "attr"
	slot4.prefabType = ScrollEnum.ScrollPrefabFromView
	slot4.prefabUrl = "attr/item"
	slot4.cellClass = GMFightEntityAttrItem
	slot4.scrollDir = ScrollEnum.ScrollDirV
	slot4.lineCount = 2
	slot4.cellWidth = 299
	slot4.cellHeight = 258
	slot5 = {}
	slot0.entityListView = LuaListScrollView.New(GMFightEntityModel.instance, slot1)

	table.insert(slot5, slot0.entityListView)

	slot0.buffListView = LuaListScrollView.New(GMFightEntityModel.instance.buffModel, slot2)

	table.insert(slot5, slot0.buffListView)

	slot0.skillListView = LuaListScrollView.New(GMFightEntityModel.instance.skillModel, slot3)

	table.insert(slot5, slot0.skillListView)

	slot0.attrListView = LuaListScrollView.New(GMFightEntityModel.instance.attrModel, slot4)

	table.insert(slot5, slot0.attrListView)
	table.insert(slot5, GMFightEntityView.New())
	table.insert(slot5, GMFightEntityInfoView.New())
	table.insert(slot5, GMFightEntityBuffView.New())
	table.insert(slot5, GMFightEntitySkillView.New())

	return slot5
end

function slot0.onContainerOpen(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onGetEntityInfo, slot0)
end

function slot0.onContainerClose(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onGetEntityInfo, slot0)
end

function slot0._onGetEntityInfo(slot0, slot1)
	FightRpc.instance:refreshEntityMO(slot1)

	if slot1.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(slot1.entityInfo.uid) then
		FightEntityDataHelper.copyEntityMO(FightDataHelper.entityMgr:getById(slot2.id), slot2)
	end

	GMFightEntityModel.instance:onGetSingleEntityInfo(slot1)
end

function slot0.onContainerInit(slot0)
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
