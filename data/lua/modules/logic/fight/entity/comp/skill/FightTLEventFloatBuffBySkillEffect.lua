module("modules.logic.fight.entity.comp.skill.FightTLEventFloatBuffBySkillEffect", package.seeall)

slot0 = class("FightTLEventFloatBuffBySkillEffect")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0.fightStepMO = slot1
	slot0.buffId = FightTLHelper.getNumberParam(slot3[1])
	slot5 = slot1.actId and lua_skill.configDict[slot4]

	if not (slot5 and lua_skill_effect.configDict[slot5.skillEffect]) then
		return
	end

	slot7 = 0

	for slot11 = 1, FightEnum.MaxBehavior do
		if string.nilorempty(slot6["behavior" .. slot11]) then
			break
		end

		if slot0:getHandle(lua_skill_behavior.configDict[FightStrUtil.instance:getSplitToNumberCache(slot12, "#")[1]] and slot14.type) then
			slot7 = slot16(slot0, slot13)

			break
		end
	end

	if slot7 < 1 then
		return
	end

	slot0:floatBuff(slot7)
end

function slot0.getHandle(slot0, slot1)
	if not uv0.SkillEffectHandleDict then
		uv0.SkillEffectHandleDict = {
			AddBuff = slot0.getAddBuffFloatCount
		}
	end

	return slot1 and uv0.SkillEffectHandleDict[slot1]
end

function slot0.floatBuff(slot0, slot1)
	for slot8, slot9 in ipairs(slot0.fightStepMO.actEffectMOs) do
		if not slot9:isDone() and slot0.fightStepMO.toId == slot9.targetId and slot9.effectType == FightEnum.EffectType.BUFFADD and slot9.effectNum == slot0.buffId then
			FightSkillBuffMgr.instance:playSkillBuff(slot0.fightStepMO, slot9)
			FightDataHelper.playEffectData(slot9)

			if slot1 <= 0 + 1 then
				return
			end
		end
	end
end

function slot0.getAddBuffFloatCount(slot0, slot1)
	return slot1 and slot1[3] or 1
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
end

function slot0.clear(slot0)
end

function slot0.dispose(slot0)
end

return slot0
