-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventEffectVisible.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventEffectVisible", package.seeall)

local FightTLEventEffectVisible = class("FightTLEventEffectVisible", FightTimelineTrackItem)

function FightTLEventEffectVisible:onTrackStart(fightStepData, duration, paramsArr)
	local magicCircleVisible = paramsArr[1]

	self:com_sendFightEvent(FightEvent.SetMagicCircleVisible, magicCircleVisible == "1", "FightTLEventEffectVisible")

	local liangYueEffectVisible = paramsArr[2]

	self:com_sendFightEvent(FightEvent.SetLiangYueEffectVisible, liangYueEffectVisible == "1")

	local buffTypeIdSceneEffect = paramsArr[3]

	self:com_sendFightEvent(FightEvent.SetBuffTypeIdSceneEffect, buffTypeIdSceneEffect == "1")
end

function FightTLEventEffectVisible:onTrackEnd()
	return
end

function FightTLEventEffectVisible:onDestructor()
	return
end

return FightTLEventEffectVisible
