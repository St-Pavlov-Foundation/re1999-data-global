module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateDamageComp", package.seeall)

local var_0_0 = class("EliminateDamageComp", HpCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._baseDamage = 0
	arg_1_0._exDamage = 0
	arg_1_0._damageRate = 0
	arg_1_0._normalEliminateDamageRate = 0
	arg_1_0._FourEliminateDamageRate = 0
	arg_1_0._FiveEliminateDamageRate = 0
	arg_1_0._CrossEliminateDamageRate = 0
	arg_1_0._eliminateTypeExDamage = {}
end

function var_0_0.reset(arg_2_0)
	arg_2_0._baseDamage = 0
	arg_2_0._exDamage = 0
	arg_2_0._damageRate = 0
	arg_2_0._normalEliminateDamageRate = 0
	arg_2_0._FourEliminateDamageRate = 0
	arg_2_0._FiveEliminateDamageRate = 0
	arg_2_0._CrossEliminateDamageRate = 0
	arg_2_0._eliminateTypeExDamage = {}
end

function var_0_0.setSpEliminateRate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._FourEliminateDamageRate = arg_3_1 / 1000
	arg_3_0._CrossEliminateDamageRate = arg_3_2 / 1000
	arg_3_0._FiveEliminateDamageRate = arg_3_3 / 1000
end

function var_0_0.setEliminateTypeExDamage(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._eliminateTypeExDamage[arg_4_1] = arg_4_2
end

function var_0_0.setExDamage(arg_5_0, arg_5_1)
	arg_5_0._exDamage = arg_5_1
end

function var_0_0.setDamageRate(arg_6_0, arg_6_1)
	arg_6_0._damageRate = arg_6_1 / 1000
end

local var_0_1 = "\n"

function var_0_0.damage(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = arg_7_1:getEliminateTypeMap()

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		local var_7_2 = 0

		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if not string.nilorempty(iter_7_0) and iter_7_0 ~= EliminateEnum_2_7.ChessType.stone then
				local var_7_3 = iter_7_3.eliminateType
				local var_7_4 = iter_7_3.eliminateCount
				local var_7_5 = iter_7_3.spEliminateCount
				local var_7_6, var_7_7 = LengZhou6Config.instance:getDamageValue(iter_7_0, var_7_3)
				local var_7_8 = arg_7_0._exDamage

				if var_7_7 ~= nil and (var_7_3 == EliminateEnum_2_7.eliminateType.cross or var_7_3 == EliminateEnum_2_7.eliminateType.five) then
					var_7_7 = (var_7_4 - 5) * var_7_7
				end

				if var_7_3 == EliminateEnum_2_7.eliminateType.four then
					var_7_2 = arg_7_0._FourEliminateDamageRate
				end

				if var_7_3 == EliminateEnum_2_7.eliminateType.five then
					var_7_2 = arg_7_0._FiveEliminateDamageRate
				end

				if var_7_3 == EliminateEnum_2_7.eliminateType.cross then
					var_7_2 = arg_7_0._CrossEliminateDamageRate
				end

				if var_7_3 == EliminateEnum_2_7.eliminateType.base then
					var_7_6 = var_7_6 * var_7_4
					var_7_8 = 0
				end

				if var_7_5 ~= 0 and arg_7_0._eliminateTypeExDamage[iter_7_0] ~= nil then
					var_7_7 = var_7_7 + arg_7_0._eliminateTypeExDamage[iter_7_0] * var_7_5
				end

				if var_7_6 ~= 0 then
					if isDebugBuild then
						var_0_1 = var_0_1 .. "eliminateId = " .. iter_7_0 .. " eliminateType = " .. var_7_3 .. " eliminateCount = " .. var_7_4 .. " spEliminateCount = " .. var_7_5 .. " baseDamage = " .. var_7_6 .. " baseExDamage = " .. var_7_7 .. " exDamage = " .. var_7_8 .. " damageRate = " .. var_7_2 .. "\n"
					end

					var_7_0 = var_7_0 + (var_7_6 + var_7_7 + var_7_8) * (1 + var_7_2)
				end
			end
		end
	end

	if isDebugBuild then
		logNormal("消除伤害详情 = " .. var_0_1)

		var_0_1 = "\n"

		logNormal("消除单次伤害 = " .. var_7_0)
	end

	return var_7_0
end

return var_0_0
