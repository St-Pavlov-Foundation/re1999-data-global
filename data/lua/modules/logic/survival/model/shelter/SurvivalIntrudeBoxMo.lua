module("modules.logic.survival.model.shelter.SurvivalIntrudeBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.templateId = arg_1_1.templateId
	arg_1_0.fight = SurvivalIntrudeFightMo.New()

	arg_1_0.fight:init(arg_1_1.fight)
end

function var_0_0.getNextBossCreateDay(arg_2_0, arg_2_1)
	local var_2_0 = lua_survival_shelter_intrude.configDict[arg_2_0.templateId]

	if var_2_0 == nil then
		logError("SurvivalIntrudeBoxMo:getNextBossCreateDay config is nil, templateId = " .. tostring(arg_2_0.templateId))

		return arg_2_1
	end

	if not string.nilorempty(var_2_0.stage) then
		local var_2_1 = {}
		local var_2_2 = string.split(var_2_0.stage, "|")

		for iter_2_0 = 1, #var_2_2 do
			local var_2_3 = string.splitToNumber(var_2_2[iter_2_0], "#")

			if var_2_3 then
				table.insert(var_2_1, var_2_3[1])
			end
		end

		for iter_2_1 = 1, #var_2_1 do
			if arg_2_1 <= var_2_1[iter_2_1] then
				return var_2_1[iter_2_1]
			end
		end
	end

	return arg_2_1
end

return var_0_0
