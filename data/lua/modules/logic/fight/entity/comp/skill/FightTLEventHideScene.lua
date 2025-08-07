module("modules.logic.fight.entity.comp.skill.FightTLEventHideScene", package.seeall)

local var_0_0 = class("FightTLEventHideScene", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.noRevert = arg_1_3[1] == "1"

	local var_1_0 = GameSceneMgr.instance:getCurScene().level

	if var_1_0 then
		local var_1_1 = var_1_0:getSceneGo()

		arg_1_0.sceneGO = var_1_1

		gohelper.setActive(var_1_1, false)
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	if not arg_2_0.noRevert then
		gohelper.setActive(arg_2_0.sceneGO, true)
	end
end

function var_0_0.onDestructor(arg_3_0)
	arg_3_0:onTrackEnd()
end

return var_0_0
