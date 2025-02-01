module("modules.logic.fight.entity.comp.skill.FightTLEventMarkSceneDefaultRoot", package.seeall)

slot0 = class("FightTLEventMarkSceneDefaultRoot")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	uv0.sceneId = GameSceneMgr.instance:getCurSceneId()
	uv0.levelId = GameSceneMgr.instance:getCurLevelId()
	uv0.rootName = slot3[1]
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
