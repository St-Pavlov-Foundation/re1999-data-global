module("modules.logic.fight.entity.comp.skill.FightTLEventSetSceneObjVisible", package.seeall)

local var_0_0 = class("FightTLEventSetSceneObjVisible")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fightStepMO = arg_1_1
	arg_1_0._paramsArr = arg_1_3

	if arg_1_0._paramsArr[3] == "1" then
		return
	end

	arg_1_0:_setVisible()
end

function var_0_0._setVisible(arg_2_0)
	if arg_2_0._paramsArr[4] == "1" then
		local var_2_0 = FightHelper.getEntity(arg_2_0._fightStepMO.fromId)

		if var_2_0 and var_2_0.skinSpineEffect then
			if arg_2_0._paramsArr[2] == "1" then
				var_2_0.skinSpineEffect:showEffects()
			else
				var_2_0.skinSpineEffect:hideEffects()
			end
		end

		return
	end

	local var_2_1 = GameSceneMgr.instance:getCurScene()

	if var_2_1 then
		local var_2_2 = var_2_1.level:getSceneGo()

		if var_2_2 then
			local var_2_3 = gohelper.findChild(var_2_2, arg_2_0._paramsArr[1])

			if var_2_3 then
				gohelper.setActive(var_2_3, arg_2_0._paramsArr[2] == "1")
			end
		end
	end
end

function var_0_0.handleSkillEventEnd(arg_3_0)
	return
end

function var_0_0.onSkillEnd(arg_4_0)
	if arg_4_0._paramsArr and arg_4_0._paramsArr[3] == "1" then
		arg_4_0:_setVisible()
	end
end

function var_0_0.reset(arg_5_0)
	return
end

function var_0_0.dispose(arg_6_0)
	return
end

return var_0_0
