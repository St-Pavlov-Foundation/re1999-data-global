module("modules.logic.fight.entity.comp.skill.FightTLEventEntityQuit", package.seeall)

slot0 = class("FightTLEventEntityQuit")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot5 = slot1.toId
	slot6 = GameSceneMgr.instance:getCurScene().entityMgr
	slot7 = nil

	if slot3[1] == "1" then
		slot7 = slot1.fromId
	elseif slot3[1] == "2" then
		slot7 = slot5
	end

	if slot6:getEntity(slot7) then
		slot6:removeUnit(slot8:getTag(), slot8.id)
	end

	slot9 = FightDataHelper.entityMgr:getById(slot7)

	if slot3[2] == "1" then
		FightEntityModel.instance:getModel(slot9.side):remove(slot9)
		FightEntityModel.instance:getSubModel(slot9.side):remove(slot9)
	end

	if slot3[3] == "1" and slot8 and not slot8.isDead then
		slot11:addAt(slot9, slot1.subIndex or logError("找不到替补的数据下标"))
	end
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
end

function slot0.onSkillEnd(slot0)
end

return slot0
