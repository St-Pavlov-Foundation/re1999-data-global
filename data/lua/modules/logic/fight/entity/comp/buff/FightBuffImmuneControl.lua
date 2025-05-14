module("modules.logic.fight.entity.comp.buff.FightBuffImmuneControl", package.seeall)

local var_0_0 = class("FightBuffImmuneControl")
local var_0_1 = {
	buff_immune = {
		"_TempOffsetTwoPass",
		"Vector4",
		"-0.2,4.2,-0.4,-0.2",
		"_OutlineColor",
		"Color",
		"12,9.55,5.83,1",
		"_NoiseMap4_ST",
		"Vector4",
		"0.1,0.1,0,0"
	}
}
local var_0_2 = {
	["304901_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
	},
	["304902_kachakacha"] = {
		"_AlphaRange",
		"Vector4",
		"0,1,0,-1.78"
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
end

function var_0_0.dispose(arg_4_0)
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
	local var_5_1 = var_0_1[var_5_0.mat]

	if not var_5_1 then
		return
	end

	for iter_5_0 = 1, 9, 3 do
		local var_5_2 = var_5_1[iter_5_0]
		local var_5_3 = var_5_1[iter_5_0 + 1]
		local var_5_4 = var_5_1[iter_5_0 + 2]

		MaterialUtil.setPropValue(arg_5_2, var_5_2, var_5_3, MaterialUtil.getPropValueFromStr(var_5_3, var_5_4))
	end

	local var_5_5 = arg_5_0.entity:getMO()
	local var_5_6 = var_5_5 and var_5_5:getSpineSkinCO()
	local var_5_7 = var_5_6 and var_5_6.spine
	local var_5_8 = not string.nilorempty(var_5_7) and var_0_2[var_5_7]

	if var_5_8 then
		for iter_5_1 = 1, 9, 3 do
			local var_5_9 = var_5_8[iter_5_1]
			local var_5_10 = var_5_8[iter_5_1 + 1]
			local var_5_11 = var_5_8[iter_5_1 + 2]

			MaterialUtil.setPropValue(arg_5_2, var_5_9, var_5_10, MaterialUtil.getPropValueFromStr(var_5_10, var_5_11))
		end
	end
end

return var_0_0
