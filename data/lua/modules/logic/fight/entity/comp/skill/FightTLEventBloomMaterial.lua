module("modules.logic.fight.entity.comp.skill.FightTLEventBloomMaterial", package.seeall)

slot0 = class("FightTLEventBloomMaterial")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot4 = slot3[1]

	if string.nilorempty(slot3[2]) then
		return
	end

	slot0._passNameList = string.split(slot5, "#")
	slot0._targetEntitys = nil

	if slot4 == "1" then
		slot0._targetEntitys = {}

		table.insert(slot0._targetEntitys, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot0._targetEntitys = FightHelper.getSkillTargetEntitys(slot1)
	elseif slot4 == "3" then
		slot0._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)
	elseif slot4 == "4" then
		slot0._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	elseif slot4 == "5" then
		slot0._targetEntitys = FightHelper.getAllEntitys()
	end

	slot0:_setPassEnable(true)
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_clear()
end

function slot0._setPassEnable(slot0, slot1)
	slot2 = GameSceneMgr.instance:getCurScene().bloom

	if slot0._targetEntitys then
		for slot6, slot7 in ipairs(slot0._targetEntitys) do
			for slot11, slot12 in ipairs(slot0._passNameList) do
				slot2:setSingleEntityPass(slot12, slot1, slot7, "timeline_bloom")
			end
		end
	end
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	slot0:_setPassEnable(false)

	slot0._targetEntitys = nil
end

return slot0
