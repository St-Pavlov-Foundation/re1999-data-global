module("modules.logic.fight.entity.comp.skill.FightTLEventPlayVideo", package.seeall)

local var_0_0 = class("FightTLEventPlayVideo", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
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

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_clear()
end

function var_0_0.onDestructor(arg_3_0)
	arg_3_0:_clear()
end

function var_0_0._clear(arg_4_0)
	FightVideoMgr.instance:stop()
end

return var_0_0
