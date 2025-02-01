module("modules.logic.rouge.dlc.101.model.RougeLimiterBuffListModel", package.seeall)

slot0 = class("RougeLimiterBuffListModel", ListScrollModel)

function slot0.onInit(slot0, slot1)
	slot0:setList(slot0:getBuffCosByType(slot1))
	slot0:try2SelectEquipedBuff()
end

function slot0.getBuffCosByType(slot0, slot1)
	slot4 = {}

	if RougeDLCConfig101.instance:getAllLimiterBuffCosByType(RougeModel.instance:getVersion(), slot1) then
		for slot8, slot9 in ipairs(slot3) do
			table.insert(slot4, slot9)
		end
	end

	table.sort(slot4, slot0._buffSortFunc)

	return slot4
end

function slot0._buffSortFunc(slot0, slot1)
	if slot0.blank == 1 ~= (slot1.blank == 1) then
		return slot2
	end

	return slot0.id < slot1.id
end

function slot0.try2SelectEquipedBuff(slot0)
	slot1, slot2 = slot0:getEquipedBuffId()

	slot0:selectCell(slot1, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, slot2, true)
end

function slot0.getEquipedBuffId(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if RougeDLCModel101.instance:getLimiterBuffState(slot6.id) == RougeDLCEnum101.BuffState.Equiped then
			return slot5, slot6.id
		end
	end
end

slot0.instance = slot0.New()

return slot0
