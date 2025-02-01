module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillMOBase", package.seeall)

slot0 = class("CharacterSkillMOBase")

function slot0.init(slot0, slot1)
	slot0._skillId = slot1
	slot0._releaseParam = ""
end

function slot0.getSkillConfig(slot0)
	return lua_character_skill.configDict[slot0._skillId]
end

function slot0.getCost(slot0)
	return slot0:getSkillConfig().cost
end

function slot0.getReleaseParam(slot0)
	return slot0._releaseParam
end

function slot0.setSkillParam(slot0, ...)
end

function slot0.playAction(slot0, slot1, slot2)
	if slot1 then
		slot1(slot2)
	end
end

function slot0.cancelRelease(slot0)
end

function slot0.getEffectRound(slot0)
	return EliminateEnum.RoundType.Match3Chess
end

function slot0.canRelease(slot0)
	return true
end

return slot0
