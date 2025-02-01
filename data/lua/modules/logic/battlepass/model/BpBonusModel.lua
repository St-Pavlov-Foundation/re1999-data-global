module("modules.logic.battlepass.model.BpBonusModel", package.seeall)

slot0 = class("BpBonusModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._getBonus = {}
	slot0.serverBonusModel = BaseModel.New()
end

function slot0.reInit(slot0)
	slot0._getBonus = {}

	slot0.serverBonusModel:clear()
end

function slot0.onGetInfo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = BpBonusMO.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	slot0.serverBonusModel:setList(slot2)
end

function slot0.initGetSelectBonus(slot0, slot1)
	slot0._getBonus = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._getBonus[slot6.level] = slot6.index + 1
	end
end

function slot0.markSelectBonus(slot0, slot1, slot2)
	slot0._getBonus[slot1] = slot2 + 1
end

function slot0.isGetSelectBonus(slot0, slot1)
	return slot0._getBonus[slot1] or nil
end

function slot0.updateInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.serverBonusModel:getById(slot6.level) then
			slot7:updateServerInfo(slot6)
		else
			slot8 = BpBonusMO.New()

			slot8:init(slot6)
			slot0.serverBonusModel:addAtLast(slot8)
		end
	end
end

function slot0.refreshListView(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(BpConfig.instance:getBonusCOList(BpModel.instance.id)) do
		if slot0.serverBonusModel:getById(slot7.level) then
			table.insert(slot1, slot8)
		else
			if not slot0:getById(slot7.level) then
				BpBonusMO.New():init({
					hasGetfreeBonus = false,
					hasGetPayBonus = false,
					hasGetSpPayBonus = false,
					hasGetSpfreeBonus = false,
					level = slot7.level
				})
			end

			table.insert(slot1, slot9)
		end
	end

	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
