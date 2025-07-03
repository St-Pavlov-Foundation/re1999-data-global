module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateTreatmentComp", package.seeall)

local var_0_0 = class("EliminateTreatmentComp", HpCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._baseTreatment = 0
	arg_1_0._exTreatment = 0
	arg_1_0._treatmentRate = 0
	arg_1_0._eliminateTypeExTreatment = {}
end

function var_0_0.reset(arg_2_0)
	arg_2_0._baseTreatment = 0
	arg_2_0._exTreatment = 0
	arg_2_0._treatmentRate = 0
	arg_2_0._eliminateTypeExTreatment = {}
end

function var_0_0.setExTreatment(arg_3_0, arg_3_1)
	arg_3_0._exTreatment = arg_3_1
end

function var_0_0.setEliminateTypeExTreatment(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._eliminateTypeExTreatment[arg_4_1] = arg_4_2
end

function var_0_0.setTreatmentRate(arg_5_0, arg_5_1)
	arg_5_0._treatmentRate = arg_5_1 / 1000
end

local var_0_1 = "\n"

function var_0_0.treatment(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = arg_6_1:getEliminateTypeMap()

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if not string.nilorempty(iter_6_0) and iter_6_0 ~= EliminateEnum_2_7.ChessType.stone then
				local var_6_2 = iter_6_3.eliminateType
				local var_6_3 = iter_6_3.eliminateCount
				local var_6_4 = iter_6_3.spEliminateCount
				local var_6_5, var_6_6 = LengZhou6Config.instance:getHealValue(iter_6_0, var_6_2)

				if var_6_6 ~= nil and (var_6_2 == EliminateEnum_2_7.eliminateType.cross or var_6_2 == EliminateEnum_2_7.eliminateType.five) then
					var_6_6 = (var_6_3 - 5) * var_6_6
				end

				if var_6_2 == EliminateEnum_2_7.eliminateType.base then
					var_6_5 = var_6_5 * var_6_3
				end

				if var_6_4 ~= 0 and arg_6_0._eliminateTypeExTreatment[iter_6_0] ~= nil then
					var_6_6 = var_6_6 + arg_6_0._eliminateTypeExTreatment[iter_6_0] * var_6_4
				end

				if isDebugBuild then
					var_0_1 = var_0_1 .. "eliminateId = " .. iter_6_0 .. " eliminateType = " .. var_6_2 .. " eliminateCount = " .. var_6_3 .. " spEliminateCount = " .. var_6_4 .. " baseTreatment = " .. var_6_5 .. " baseExTreatment = " .. var_6_6 .. "\n"
				end

				var_6_0 = var_6_0 + (var_6_5 + arg_6_0._exTreatment + var_6_6) * (1 + arg_6_0._treatmentRate)
			end
		end
	end

	if isDebugBuild then
		logNormal("消除治疗计算详情 = " .. var_0_1)

		var_0_1 = "\n"

		logNormal("消除单次治疗 = ：" .. var_6_0)
	end

	return var_6_0
end

return var_0_0
