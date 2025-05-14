module("modules.logic.fight.entity.comp.buff.FightBuffFrozen", package.seeall)

local var_0_0 = class("FightBuffFrozen")
local var_0_1 = 0.5
local var_0_2 = {
	buff_stone = {
		"_TempOffset3",
		"Vector4",
		"1,0,0,0",
		"-2,0,0,0"
	},
	buff_ice = {
		"_TempOffsetTwoPass",
		"Vector4",
		"1,1,1,0.7",
		"-2,1,1,0.7"
	}
}

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1
	arg_1_0.buffMO = arg_1_2

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, arg_1_0._onChangeMaterial, arg_1_0)
end

function var_0_0.onBuffEnd(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_2_0._onChangeMaterial, arg_2_0)
end

function var_0_0.reset(arg_3_0)
	arg_3_0._preMatName = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_3_0._onChangeMaterial, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayEnd, arg_3_0)

	if arg_3_0._tweenId then
		ZProj.TweenHelper.KillById(arg_3_0._tweenId)

		arg_3_0._tweenId = nil
	end
end

function var_0_0.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayEnd, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_4_0._onChangeMaterial, arg_4_0)
end

function var_0_0._onChangeMaterial(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= arg_5_0.entity.id then
		return
	end

	if arg_5_0._preMatName and arg_5_0._preMatName == arg_5_2.name then
		return
	end

	arg_5_0._preMatName = arg_5_2.name

	local var_5_0 = lua_skill_buff.configDict[arg_5_0.buffMO.buffId]
	local var_5_1 = var_0_2[var_5_0.mat]

	if not var_5_1 then
		return
	end

	local var_5_2 = "_Pow"
	local var_5_3 = "_FloorAlpha"
	local var_5_4 = "Color"
	local var_5_5 = "Vector4"
	local var_5_6 = arg_5_0.entity.spineRenderer and arg_5_0.entity.spineRenderer:getCloneOriginMat()
	local var_5_7 = var_5_6 and MaterialUtil.getPropValueFromMat(var_5_6, var_5_2, var_5_4)
	local var_5_8 = var_5_6 and MaterialUtil.getPropValueFromMat(var_5_6, var_5_3, var_5_5)

	if var_5_7 then
		MaterialUtil.setPropValue(arg_5_2, var_5_2, var_5_4, var_5_7)
	end

	if var_5_8 then
		MaterialUtil.setPropValue(arg_5_2, var_5_3, var_5_5, var_5_8)
	end

	local var_5_9 = var_5_1[1]
	local var_5_10 = var_5_1[2]
	local var_5_11 = MaterialUtil.getPropValueFromStr(var_5_10, var_5_1[3])
	local var_5_12 = MaterialUtil.getPropValueFromStr(var_5_10, var_5_1[4])

	MaterialUtil.setPropValue(arg_5_2, var_5_9, var_5_10, var_5_11)

	local var_5_13
	local var_5_14 = UnityEngine.Shader.PropertyToID(var_5_9)

	arg_5_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_0_1, function(arg_6_0)
		var_5_13 = MaterialUtil.getLerpValue(var_5_10, var_5_11, var_5_12, arg_6_0, var_5_13)

		MaterialUtil.setPropValue(arg_5_2, var_5_14, var_5_10, var_5_13)
	end)

	TaskDispatcher.runDelay(arg_5_0._delayEnd, arg_5_0, var_0_1)
end

function var_0_0._delayEnd(arg_7_0)
	arg_7_0._tweenId = nil
end

return var_0_0
