module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationSpecificColorMO", package.seeall)

slot0 = class("CharacterSkillEliminationSpecificColorMO", CharacterSkillMOBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._x = -1
	slot0._y = -1
end

function slot0.getReleaseParam(slot0)
	slot0._releaseParam = string.format("%d_%d", slot0._x - 1, slot0._y - 1)

	return slot0._releaseParam
end

function slot0.canRelease(slot0)
	return slot0._x ~= -1 and slot0._y ~= -1
end

function slot0.setSkillParam(slot0, ...)
	slot1 = {
		...
	}
	slot0._x = slot1[1]
	slot0._y = slot1[2]
end

return slot0
