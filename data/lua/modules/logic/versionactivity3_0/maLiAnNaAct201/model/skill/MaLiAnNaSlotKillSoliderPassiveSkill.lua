module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSlotKillSoliderPassiveSkill", package.seeall)

local var_0_0 = class("MaLiAnNaSlotKillSoliderPassiveSkill", MaLiAnNaSkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, nil)

	arg_1_0._skillType = Activity201MaLiAnNaEnum.SkillType.passive
	arg_1_0._effect = arg_1_2
end

function var_0_0._initCdTime(arg_2_0)
	arg_2_0._cdTime = arg_2_0._effect[3]
end

function var_0_0.update(arg_3_0, arg_3_1)
	if var_0_0.super.update(arg_3_0, arg_3_1) then
		arg_3_0:execute()
		arg_3_0:_initCdTime()
	end
end

function var_0_0.setParams(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._params == nil then
		arg_4_0._params = {}
	end

	table.insert(arg_4_0._params, arg_4_1)
	table.insert(arg_4_0._params, arg_4_2)
	table.insert(arg_4_0._params, arg_4_3)
end

function var_0_0.execute(arg_5_0)
	Activity201MaLiAnNaGameController.instance:addAction(arg_5_0:getEffect(), arg_5_0._params)
end

return var_0_0
