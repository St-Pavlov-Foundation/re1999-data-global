module("modules.logic.battlepass.model.BpBonusModel", package.seeall)

local var_0_0 = class("BpBonusModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._getBonus = {}
	arg_1_0.serverBonusModel = BaseModel.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._getBonus = {}

	arg_2_0.serverBonusModel:clear()
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_1 = BpBonusMO.New()

		var_3_1:init(iter_3_1)
		table.insert(var_3_0, var_3_1)
	end

	arg_3_0.serverBonusModel:setList(var_3_0)
end

function var_0_0.initGetSelectBonus(arg_4_0, arg_4_1)
	arg_4_0._getBonus = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0._getBonus[iter_4_1.level] = iter_4_1.index + 1
	end
end

function var_0_0.markSelectBonus(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._getBonus[arg_5_1] = arg_5_2 + 1
end

function var_0_0.isGetSelectBonus(arg_6_0, arg_6_1)
	return arg_6_0._getBonus[arg_6_1] or nil
end

function var_0_0.updateInfo(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = arg_7_0.serverBonusModel:getById(iter_7_1.level)

		if var_7_0 then
			var_7_0:updateServerInfo(iter_7_1)
		else
			local var_7_1 = BpBonusMO.New()

			var_7_1:init(iter_7_1)
			arg_7_0.serverBonusModel:addAtLast(var_7_1)
		end
	end
end

function var_0_0.refreshListView(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = BpConfig.instance:getBonusCOList(BpModel.instance.id)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = arg_8_0.serverBonusModel:getById(iter_8_1.level)

		if var_8_2 then
			table.insert(var_8_0, var_8_2)
		else
			local var_8_3 = arg_8_0:getById(iter_8_1.level)

			if not var_8_3 then
				var_8_3 = BpBonusMO.New()

				var_8_3:init({
					hasGetfreeBonus = false,
					hasGetPayBonus = false,
					hasGetSpPayBonus = false,
					hasGetSpfreeBonus = false,
					level = iter_8_1.level
				})
			end

			table.insert(var_8_0, var_8_3)
		end
	end

	arg_8_0:setList(var_8_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
