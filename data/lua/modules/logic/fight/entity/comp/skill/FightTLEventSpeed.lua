module("modules.logic.fight.entity.comp.skill.FightTLEventSpeed", package.seeall)

slot0 = class("FightTLEventSpeed")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if tonumber(slot3[1]) then
		GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, slot4)
	else
		logError("变速帧参数有误")
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_resetSpeed()
end

function slot0._resetSpeed(slot0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, 1)
end

function slot0.reset(slot0)
	slot0:_resetSpeed()
end

function slot0.dispose(slot0)
	slot0:_resetSpeed()
end

return slot0
