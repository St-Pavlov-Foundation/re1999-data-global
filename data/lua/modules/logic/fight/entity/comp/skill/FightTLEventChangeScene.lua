module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

slot0 = class("FightTLEventChangeScene")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not string.nilorempty(slot3[1]) then
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelNoEffect(tonumber(slot3[1]))
	end
end

function slot0.onSkillEnd(slot0)
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
