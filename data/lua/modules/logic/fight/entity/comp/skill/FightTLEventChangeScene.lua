module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

local var_0_0 = class("FightTLEventChangeScene")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not string.nilorempty(arg_1_3[1]) then
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelNoEffect(tonumber(arg_1_3[1]))
	end
end

function var_0_0.onSkillEnd(arg_2_0)
	return
end

function var_0_0.handleSkillEventEnd(arg_3_0)
	return
end

function var_0_0.reset(arg_4_0)
	return
end

function var_0_0.dispose(arg_5_0)
	return
end

return var_0_0
