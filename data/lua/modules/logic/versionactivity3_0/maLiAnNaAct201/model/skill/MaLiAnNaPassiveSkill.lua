module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaPassiveSkill", package.seeall)

local var_0_0 = class("MaLiAnNaPassiveSkill", MaLiAnNaSkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._config = Activity201MaLiAnNaConfig.instance:getPassiveSkillConfig(arg_1_2)

	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._skillType = Activity201MaLiAnNaEnum.SkillType.passive

	arg_1_0:_initCdTime()
end

function var_0_0._initCdTime(arg_2_0)
	arg_2_0._cdTime = 0

	if arg_2_0:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.releaseBullet then
		arg_2_0._cdTime = arg_2_0:getEffect()[2] or 0
	end
end

function var_0_0.update(arg_3_0, arg_3_1)
	if var_0_0.super.update(arg_3_0, arg_3_1) then
		arg_3_0:execute()
		arg_3_0:_initCdTime()
	end
end

function var_0_0.setUseSoliderId(arg_4_0, arg_4_1)
	if arg_4_0._params == nil then
		arg_4_0._params = {}
	end

	table.insert(arg_4_0._params, arg_4_1)
end

function var_0_0.execute(arg_5_0)
	if arg_5_0:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.releaseBullet then
		if arg_5_0._params == nil or #arg_5_0._params == 0 then
			return
		end

		Activity201MaLiAnNaGameController.instance:addAction(arg_5_0:getEffect(), arg_5_0._params)
	end
end

function var_0_0.destroy(arg_6_0)
	arg_6_0._soliderId = nil
	arg_6_0._config = nil
end

return var_0_0
