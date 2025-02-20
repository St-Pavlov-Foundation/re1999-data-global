module("modules.logic.tower.model.TowerAssistBossModel", package.seeall)

slot0 = class("TowerAssistBossModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.tempBossDict = {}
end

function slot0.updateAssistBossInfo(slot0, slot1)
	if not slot0:getById(slot1.id) then
		slot3 = TowerAssistBossMo.New()

		slot3:init(slot2)
		slot0:addAtLast(slot3)
	end

	slot3:updateInfo(slot1)
end

function slot0.onTowerActiveTalent(slot0, slot1)
	if slot0:getById(slot1.bossId) then
		slot3:onTowerActiveTalent(slot1)
	end
end

function slot0.onTowerResetTalent(slot0, slot1)
	if slot0:getById(slot1.bossId) then
		slot3:onTowerResetTalent(slot1)
	end
end

function slot0.getBoss(slot0, slot1)
	if not (slot0:getById(slot1) or slot0.tempBossDict[slot1]) then
		slot2 = TowerAssistBossMo.New()

		slot2:init(slot1)
		slot2:initTalentIds()

		slot0.tempBossDict[slot1] = slot2
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
