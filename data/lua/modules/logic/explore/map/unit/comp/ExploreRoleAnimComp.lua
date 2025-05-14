module("modules.logic.explore.map.unit.comp.ExploreRoleAnimComp", package.seeall)

local var_0_0 = class("ExploreRoleAnimComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0._curAnim = nil
	arg_1_0._checkTime = 0
	arg_1_0._lastSetIntValue = {}
	arg_1_0._lastSetBoolValue = {}
	arg_1_0._lastSetFloatValue = {}
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0.animator = arg_2_1:GetComponent(typeof(UnityEngine.Animator))

	if arg_2_0._curAnim then
		arg_2_0:playAnim(arg_2_0._curAnim)
	else
		arg_2_0:playIdleAnim()
	end
end

function var_0_0.playIdleAnim(arg_3_0)
	arg_3_0:playAnim(ExploreAnimEnum.RoleAnimName.idle)
end

function var_0_0.onUpdate(arg_4_0)
	if not arg_4_0.animator then
		return
	end

	if arg_4_0:isIdleAnim() then
		return
	end

	arg_4_0._checkTime = arg_4_0._checkTime + UnityEngine.Time.deltaTime

	if arg_4_0._checkTime < 0.1 then
		return
	end

	arg_4_0._checkTime = 0

	local var_4_0 = arg_4_0.animator:GetCurrentAnimatorStateInfo(0)

	if not var_4_0:IsName(arg_4_0._curAnim) or var_4_0.normalizedTime >= 1 then
		arg_4_0:onAnimPlayEnd()
	end
end

function var_0_0.onAnimPlayEnd(arg_5_0)
	return
end

function var_0_0.isIdleAnim(arg_6_0)
	return arg_6_0._curAnim == ExploreAnimEnum.RoleAnimName.idle
end

function var_0_0.onEnable(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._lastSetBoolValue) do
		arg_7_0:setBool(iter_7_0, iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._lastSetFloatValue) do
		arg_7_0:setFloat(iter_7_2, iter_7_3)
	end

	for iter_7_4, iter_7_5 in pairs(arg_7_0._lastSetIntValue) do
		arg_7_0:setInteger(iter_7_4, iter_7_5)
	end
end

function var_0_0.setBool(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.animator then
		arg_8_0.animator:SetBool(arg_8_1, arg_8_2)
	end

	arg_8_0._lastSetBoolValue[arg_8_1] = arg_8_2
end

function var_0_0.getBool(arg_9_0, arg_9_1)
	return arg_9_0._lastSetBoolValue[arg_9_1] or false
end

function var_0_0.setFloat(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.animator then
		arg_10_0.animator:SetFloat(arg_10_1, arg_10_2)
	end

	arg_10_0._lastSetFloatValue[arg_10_1] = arg_10_2
end

function var_0_0.setInteger(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.animator then
		arg_11_0.animator:SetInteger(arg_11_1, arg_11_2)
	end

	arg_11_0._lastSetIntValue[arg_11_1] = arg_11_2
end

function var_0_0.playAnim(arg_12_0, arg_12_1)
	if arg_12_0._curAnim ~= arg_12_1 then
		arg_12_0._curAnim = arg_12_1
		arg_12_0._checkTime = 0

		if not arg_12_0.animator then
			return
		end

		arg_12_0.animator:Play(arg_12_1, 0, 0)
	end
end

function var_0_0.clear(arg_13_0)
	arg_13_0._curAnim = nil
	arg_13_0.animator = nil
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0:clear()

	arg_14_0._lastSetIntValue = {}
	arg_14_0._lastSetBoolValue = {}
	arg_14_0._lastSetFloatValue = {}
end

return var_0_0
