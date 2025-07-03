module("modules.logic.fight.entity.comp.skill.FightTLEventSpeed", package.seeall)

local var_0_0 = class("FightTLEventSpeed", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tonumber(arg_1_3[1])

	if var_1_0 then
		GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, var_1_0)
	else
		logError("变速帧参数有误")
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_resetSpeed()
end

function var_0_0._resetSpeed(arg_3_0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightTLEventSpeed, 1)
end

function var_0_0.onDestructor(arg_4_0)
	arg_4_0:_resetSpeed()
end

return var_0_0
