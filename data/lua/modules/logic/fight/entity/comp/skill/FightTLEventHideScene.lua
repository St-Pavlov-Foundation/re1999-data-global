module("modules.logic.fight.entity.comp.skill.FightTLEventHideScene", package.seeall)

local var_0_0 = class("FightTLEventHideScene")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:_disable()
end

function var_0_0.handleSkillEventEnd(arg_2_0)
	arg_2_0:_enable()
end

function var_0_0._enable(arg_3_0)
	arg_3_0:_do(true)
end

function var_0_0._disable(arg_4_0)
	arg_4_0:_do(false)
end

function var_0_0._do(arg_5_0, arg_5_1)
	local var_5_0 = GameSceneMgr.instance:getCurScene().level

	if var_5_0 then
		local var_5_1 = var_5_0:getSceneGo()

		gohelper.setActive(var_5_1, arg_5_1)
	end
end

function var_0_0.reset(arg_6_0)
	arg_6_0:_enable()
end

function var_0_0.dispose(arg_7_0)
	return
end

return var_0_0
