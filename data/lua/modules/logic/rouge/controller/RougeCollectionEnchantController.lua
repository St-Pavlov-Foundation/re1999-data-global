module("modules.logic.rouge.controller.RougeCollectionEnchantController", package.seeall)

slot0 = class("RougeCollectionEnchantController", BaseController)
slot1 = 1

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	slot0:onInit(slot1, slot2, slot3, true)
end

function slot0.onCloseView(slot0)
	RougeCollectionUnEnchantListModel.instance:reInit()
	RougeCollectionEnchantListModel.instance:reInit()
end

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	RougeCollectionUnEnchantListModel.instance:onInitData(slot2)
	RougeCollectionEnchantListModel.instance:onInitData(slot4)
	slot0:onSelectBagItem(RougeCollectionUnEnchantListModel.instance:getById(slot1) and RougeCollectionUnEnchantListModel.instance:getIndex(slot5), slot3)
end

function slot0.onSelectBagItem(slot0, slot1, slot2)
	slot3 = nil

	if not RougeCollectionUnEnchantListModel.instance:getByIndex(slot1) then
		return
	end

	slot2 = slot2 or uv0

	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(slot2)
	RougeCollectionUnEnchantListModel.instance:switchSelectCollection(slot4.id)
	slot0:onSelectEnchantItem(slot4.id, slot4:getEnchantIdAndCfgId(slot2), slot2)
end

function slot0.onSelectEnchantItem(slot0, slot1, slot2, slot3)
	slot2 = slot2 or 0
	slot3 = slot3 or 0

	if not slot1 or slot2 <= 0 or slot3 <= 0 then
		RougeCollectionEnchantListModel.instance:selectCell(nil, false)
		uv0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, slot1)

		return
	end

	if (RougeCollectionModel.instance:getCollectionByUid(slot1) and slot4:getEnchantIdAndCfgId(slot3)) ~= slot2 then
		slot0:trySendRogueCollectionEnchantRequest(slot1, slot2, slot3)
	elseif RougeCollectionEnchantListModel.instance:getCurSelectEnchantId() ~= slot2 then
		RougeCollectionEnchantListModel.instance:selectCell(slot2, true)
		uv0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, slot1)
	end
end

function slot0.trySendRogueCollectionEnchantRequest(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot3 then
		return
	end

	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(slot4.id))

		return
	end

	if slot2 ~= RougeEnum.EmptyEnchantId and not (RougeCollectionModel.instance:getCollectionByUid(slot2) or RougeCollectionEnchantListModel.instance:getById(slot2)) then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该附魔软盘,软盘uid = " .. tostring(slot2))

		return
	end

	if (RougeCollectionConfig.instance:getCollectionCfg(slot4.cfgId).holeNum or 0) <= 0 then
		return
	end

	if slot6 < slot3 then
		logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", slot3, slot4.id, slot4.cfgId, slot6))

		return
	end

	RougeRpc.instance:sendRougeInlayRequest(slot1, slot2, slot3)
end

function slot0.trySendRemoveCollectionEnchantRequest(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(slot1))

		return
	end

	if not slot3:getEnchantIdAndCfgId(slot2) or slot4 <= 0 then
		return
	end

	if slot2 > (RougeCollectionConfig.instance:getCollectionCfg(slot3.cfgId).holeNum or 0) then
		logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", slot2, slot3.id, slot3.cfgId, slot6))

		return
	end

	RougeRpc.instance:sendRougeDemountRequest(slot1, slot2)
end

function slot0.onSelectHoleGrid(slot0, slot1)
	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(slot1)

	if RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId() then
		slot0:onSelectEnchantItem(slot2, RougeCollectionUnEnchantListModel.instance:getById(slot2) and slot3:getEnchantIdAndCfgId(slot1), slot1)
	end
end

function slot0.switchCollection(slot0, slot1)
	slot2 = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex()
	slot3 = RougeCollectionUnEnchantListModel.instance:getCount()
	slot4 = nil

	if ((not slot1 or Mathf.Clamp(slot2 + 1, 1, slot3)) and Mathf.Clamp(slot2 - 1, 1, slot3)) ~= slot2 and RougeCollectionUnEnchantListModel.instance:getByIndex(slot4) then
		RougeCollectionEnchantListModel.instance:executeSortFunc()
		slot0:onSelectBagItem(slot4, uv0)
	end
end

function slot0.removeEnchant(slot0, slot1, slot2)
	if RougeCollectionModel.instance:getCollectionByUid(slot1) and slot3:getEnchantIdAndCfgId(slot2) and slot4 > 0 then
		RougeCollectionEnchantListModel.instance:selectCell(slot4, false)
	end

	slot0:trySendRemoveCollectionEnchantRequest(slot1, slot2)
end

function slot0.onRougeInlayInfoUpdate(slot0, slot1, slot2)
	if RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId() == slot1 then
		RougeCollectionEnchantListModel.instance:selectCell(RougeCollectionModel.instance:getCollectionByUid(slot1):getEnchantIdAndCfgId(RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()), true)
	end

	if slot2 and slot2 > 0 then
		uv0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, slot2)
	end

	uv0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, slot1)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
