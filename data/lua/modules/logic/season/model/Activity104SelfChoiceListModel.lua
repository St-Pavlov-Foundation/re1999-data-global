module("modules.logic.season.model.Activity104SelfChoiceListModel", package.seeall)

slot0 = class("Activity104SelfChoiceListModel", ListScrollModel)

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.activityId = nil
	slot0.costItemUid = nil
	slot0.curSelectedItemId = nil
	slot0.targetRare = nil
	slot0.tagModel = nil
end

function slot0.initDatas(slot0, slot1, slot2)
	logNormal("Activity104SelfChoiceListModel initDatas")
	slot0:clear()

	slot0.activityId = slot1
	slot0.costItemUid = slot2
	slot0.curSelectedItemId = nil
	slot4 = SeasonConfig.instance:getSeasonEquipCo(Activity104Model.instance:getAllItemMo(slot0.activityId)[slot0.costItemUid].itemId)
	slot0.itemId = slot4.equipId
	slot0.targetRare = slot4.rare

	slot0:initList()
end

function slot0.initList(slot0)
	slot0.curSelectedItemId = nil
	slot2 = {}

	for slot6, slot7 in ipairs(SeasonConfig.instance:getEquipCoByCondition(uv0.filterSameRare)) do
		slot8 = Activity104SelfChoiceMo.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)

		if not slot0.curSelectedItemId then
			slot0.curSelectedItemId = slot7.equipId
		end
	end

	slot0:setList(slot2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, slot0.curSelectedItemId)
end

function slot0.filterSameRare(slot0)
	if slot0.rare == uv0.instance.targetRare and not SeasonConfig.instance:getEquipIsOptional(slot0.equipId) and not SeasonEquipMetaUtils.isBanActivity(slot0, uv0.instance.activityId) and uv0.instance:isCardCanShowByTag(slot0.tag) then
		return true
	end

	return false
end

function slot0.setSelectEquip(slot0, slot1)
	slot0.curSelectedItemId = slot1

	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectSelfChoiceCard, slot1)
	slot0:onModelUpdate()
end

function slot0.initSubModel(slot0)
	slot0.tagModel = Activity104EquipTagModel.New()

	slot0.tagModel:init(slot0.activityId)
end

function slot0.isCardCanShowByTag(slot0, slot1)
	return slot0:getTagModel():isCardNeedShow(slot1)
end

function slot0.getTagModel(slot0)
	if not slot0.tagModel then
		slot0:initSubModel()
	end

	return slot0.tagModel
end

slot0.instance = slot0.New()

return slot0
