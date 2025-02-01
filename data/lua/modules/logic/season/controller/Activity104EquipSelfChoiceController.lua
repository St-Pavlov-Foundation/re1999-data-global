module("modules.logic.season.controller.Activity104EquipSelfChoiceController", package.seeall)

slot0 = class("Activity104EquipSelfChoiceController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

function slot0.checkOpenParam(slot0, slot1, slot2)
	if not (Activity104Model.instance:getAllItemMo(slot1) or {})[slot2] then
		logNormal(string.format("ItemMO not found ! itemUid = [%s]", slot2))

		return false
	elseif not SeasonConfig.instance:getEquipIsOptional(slot4.itemId) then
		logNormal(string.format("it't not optional card! itemUid = [%s], itemId = [%s]", slot2, slot4.itemId))

		return false
	end

	return true
end

function slot0.onOpenView(slot0, slot1, slot2)
	Activity104SelfChoiceListModel.instance:initDatas(slot1, slot2)
end

function slot0.onCloseView(slot0)
	Activity104SelfChoiceListModel.instance:clear()
end

function slot0.changeSelectCard(slot0, slot1)
	Activity104SelfChoiceListModel.instance:setSelectEquip(slot1)
end

function slot0.sendSelectCard(slot0, slot1, slot2)
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= nil then
		Activity104Rpc.instance:sendOptionalActivity104EquipRequest(Activity104SelfChoiceListModel.instance.activityId, Activity104SelfChoiceListModel.instance.costItemUid, slot3, slot1, slot2)
	end
end

function slot0.setSelectTag(slot0, slot1)
	if slot0:getFilterModel() then
		slot0:getFilterModel():selectTagIndex(slot1)
		Activity104SelfChoiceListModel.instance:initList()
	end
end

function slot0.getFilterModel(slot0)
	return Activity104SelfChoiceListModel.instance:getTagModel()
end

slot0.instance = slot0.New()

return slot0
