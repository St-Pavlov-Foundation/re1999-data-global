module("modules.logic.fight.entity.comp.skill.FightTLEventPlayVideo", package.seeall)

local var_0_0 = class("FightTLEventPlayVideo")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._resName = arg_1_3[1]

	if not string.nilorempty(arg_1_0._resName) then
		if arg_1_3[2] ~= "1" and FightVideoMgr.instance:isSameVideo(arg_1_0._resName) and FightVideoMgr.instance:isPause() then
			FightVideoMgr.instance:continue(arg_1_0._resName)

			return
		end

		FightVideoMgr.instance:play(arg_1_0._resName)

		if arg_1_3[2] == "1" then
			FightVideoMgr.instance:pause()
		end
	end
end

function var_0_0.handleSkillEventEnd(arg_2_0)
	arg_2_0:_onFinish()
end

function var_0_0._onFinish(arg_3_0)
	FightVideoMgr.instance:stop()
end

function var_0_0.reset(arg_4_0)
	arg_4_0:_clear()
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:_clear()
end

function var_0_0._clear(arg_6_0)
	FightVideoMgr.instance:stop()
end

return var_0_0
