module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationRangeMO", package.seeall)

local var_0_0 = class("CharacterSkillEliminationRangeMO", CharacterSkillMOBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._x = -1
	arg_1_0._y = -1
end

function var_0_0.getReleaseParam(arg_2_0)
	arg_2_0._releaseParam = string.format("%d_%d", arg_2_0._x - 1, arg_2_0._y - 1)

	return arg_2_0._releaseParam
end

function var_0_0.canRelease(arg_3_0)
	return arg_3_0._x ~= -1 and arg_3_0._y ~= -1
end

function var_0_0.playAction(arg_4_0, arg_4_1, arg_4_2)
	EliminateChessModel.instance:setRecordCurNeedShowEffectAndXY(arg_4_0._x, arg_4_0._y, EliminateEnum.EffectType.blockEliminate)
	var_0_0.super.playAction(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.setSkillParam(arg_5_0, ...)
	local var_5_0 = {
		...
	}

	arg_5_0._x = var_5_0[1]
	arg_5_0._y = var_5_0[2]
end

return var_0_0
