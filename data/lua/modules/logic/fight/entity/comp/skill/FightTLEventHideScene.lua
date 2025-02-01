module("modules.logic.fight.entity.comp.skill.FightTLEventHideScene", package.seeall)

slot0 = class("FightTLEventHideScene")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0:_disable()
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_enable()
end

function slot0._enable(slot0)
	slot0:_do(true)
end

function slot0._disable(slot0)
	slot0:_do(false)
end

function slot0._do(slot0, slot1)
	if GameSceneMgr.instance:getCurScene().level then
		gohelper.setActive(slot2:getSceneGo(), slot1)
	end
end

function slot0.reset(slot0)
	slot0:_enable()
end

function slot0.dispose(slot0)
end

return slot0
