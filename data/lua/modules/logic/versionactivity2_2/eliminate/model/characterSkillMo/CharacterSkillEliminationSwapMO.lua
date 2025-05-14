module("modules.logic.versionactivity2_2.eliminate.model.characterSkillMo.CharacterSkillEliminationSwapMO", package.seeall)

local var_0_0 = class("CharacterSkillEliminationSwapMO", CharacterSkillMOBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._x1 = -1
	arg_1_0._x2 = -1
	arg_1_0._y1 = -1
	arg_1_0._y2 = -1
end

function var_0_0.getReleaseParam(arg_2_0)
	arg_2_0._releaseParam = string.format("%d_%d_%d_%d", arg_2_0._x1 - 1, arg_2_0._y1 - 1, arg_2_0._x2 - 1, arg_2_0._y2 - 1)

	return arg_2_0._releaseParam
end

function var_0_0.canRelease(arg_3_0)
	return arg_3_0._x1 ~= -1 and arg_3_0._y1 ~= -1 and arg_3_0._x2 ~= -1 and arg_3_0._y2 ~= -1
end

function var_0_0.playAction(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._cb = arg_4_1
	arg_4_0._cbTarget = arg_4_2

	local var_4_0 = EliminateChessItemController.instance:getChessItem(arg_4_0._x1, arg_4_0._y1)
	local var_4_1 = EliminateChessItemController.instance:getChessItem(arg_4_0._x2, arg_4_0._y2)
	local var_4_2, var_4_3 = var_4_0:getGoPos()
	local var_4_4, var_4_5 = var_4_1:getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, arg_4_0._x1, arg_4_0._y1, var_4_2, var_4_3, true, nil, nil)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, arg_4_0._x2, arg_4_0._y2, var_4_4, var_4_5, true, arg_4_0.playActionEnd, arg_4_0)
end

function var_0_0.playActionEnd(arg_5_0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_1, nil, nil, nil, nil, false, nil, nil)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, EliminateEnum.EffectType.exchange_2, nil, nil, nil, nil, false, nil, nil)
	EliminateChessController.instance:exchangeCellShow(arg_5_0._x1, arg_5_0._y1, arg_5_0._x2, arg_5_0._y2, 0)

	if arg_5_0._cb ~= nil then
		arg_5_0._cb(arg_5_0._cbTarget)
	else
		EliminateChessController.instance:exchangeCellShow(arg_5_0._x2, arg_5_0._y2, arg_5_0._x1, arg_5_0._y1, 0)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillCancel, false)
	end

	arg_5_0._cb = nil
end

function var_0_0.cancelRelease(arg_6_0)
	arg_6_0._cb = nil
end

function var_0_0.setSkillParam(arg_7_0, ...)
	local var_7_0 = {
		...
	}

	if arg_7_0._x1 == -1 then
		arg_7_0._x1 = var_7_0[1]
		arg_7_0._y1 = var_7_0[2]
	else
		arg_7_0._x2 = var_7_0[1]
		arg_7_0._y2 = var_7_0[2]
	end
end

return var_0_0
