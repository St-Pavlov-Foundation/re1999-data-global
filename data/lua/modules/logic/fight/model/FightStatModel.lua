module("modules.logic.fight.model.FightStatModel", package.seeall)

slot0 = class("FightStatModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._totalHarm = 0
	slot0._totalHurt = 0
	slot0._totalHeal = 0
end

function slot0.setAtkStatInfo(slot0, slot1)
	slot0._totalHarm = 0
	slot0._totalHurt = 0
	slot0._totalHeal = 0
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if not slot0:checkShield(slot7) and (slot7.entityMO or FightDataHelper.entityMgr:getById(slot7.heroUid)) then
			slot9 = FightStatMO.New()

			slot9:init(slot7)

			slot9.entityMO = slot7.entityMO
			slot9.fromOtherFight = slot7.entityMO and true or false

			table.insert(slot2, slot9)

			slot0._totalHarm = slot0._totalHarm + slot9.harm
			slot0._totalHurt = slot0._totalHurt + slot9.hurt
			slot0._totalHeal = slot0._totalHeal + slot9.heal
		end
	end

	table.sort(slot2, function (slot0, slot1)
		if slot0.harm ~= slot1.harm then
			return slot1.harm < slot0.harm
		else
			return slot0.entityId < slot1.entityId
		end
	end)
	slot0:setList(slot2)
end

function slot0.checkShield(slot0, slot1)
	if not slot1 then
		return true
	end

	if slot1.heroUid == FightEntityScene.MySideId or slot1.heroUid == FightEntityScene.EnemySideId then
		return true
	end

	return false
end

function slot0.getTotalHarm(slot0)
	return slot0._totalHarm
end

function slot0.getTotalHurt(slot0)
	return slot0._totalHurt
end

function slot0.getTotalHeal(slot0)
	return slot0._totalHeal
end

slot0.instance = slot0.New()

return slot0
