module("modules.logic.equip.model.EquipModel", package.seeall)

local var_0_0 = class("EquipModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.strengthenPrompt = nil
	arg_1_0._equipQualityDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._equipList = nil
	arg_2_0._equipDic = nil
	arg_2_0._equipQualityDic = {}
	arg_2_0.strengthenPrompt = nil
end

function var_0_0.getEquips(arg_3_0)
	return arg_3_0._equipList
end

function var_0_0.getEquip(arg_4_0, arg_4_1)
	return arg_4_1 and arg_4_0._equipDic[arg_4_1]
end

function var_0_0.haveEquip(arg_5_0, arg_5_1)
	return arg_5_0._equipQualityDic[arg_5_1] and arg_5_0._equipQualityDic[arg_5_1] > 0
end

function var_0_0.getEquipQuantity(arg_6_0, arg_6_1)
	return arg_6_0._equipQualityDic[arg_6_1] or 0
end

function var_0_0.addEquips(arg_7_0, arg_7_1)
	arg_7_0._equipList = arg_7_0._equipList or {}
	arg_7_0._equipDic = arg_7_0._equipDic or {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = arg_7_0._equipDic[iter_7_1.uid]
		local var_7_1 = false

		if not var_7_0 then
			var_7_0 = EquipMO.New()

			table.insert(arg_7_0._equipList, var_7_0)

			arg_7_0._equipDic[iter_7_1.uid] = var_7_0
			var_7_1 = true
		end

		var_7_0:init(iter_7_1)

		if not var_7_0.config then
			logError("equipId " .. var_7_0.equipId .. " not found config")
		else
			arg_7_0._equipQualityDic[var_7_0.config.id] = arg_7_0._equipQualityDic[var_7_0.config.id] or 0

			if var_7_0.config.isExpEquip == 1 then
				arg_7_0._equipQualityDic[var_7_0.config.id] = var_7_0.count
			elseif var_7_1 then
				arg_7_0._equipQualityDic[var_7_0.config.id] = arg_7_0._equipQualityDic[var_7_0.config.id] + 1
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.onUpdateEquip)
end

function var_0_0.removeEquips(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = arg_8_0._equipDic[iter_8_1]

		if var_8_0.config.isExpEquip == 1 then
			arg_8_0._equipQualityDic[var_8_0.config.id] = 0
		else
			arg_8_0._equipQualityDic[var_8_0.config.id] = arg_8_0._equipQualityDic[var_8_0.config.id] - 1
		end

		arg_8_0._equipDic[iter_8_1] = nil
	end

	local var_8_1 = 1
	local var_8_2 = #arg_8_0._equipList

	for iter_8_2, iter_8_3 in pairs(arg_8_0._equipDic) do
		arg_8_0._equipList[var_8_1] = iter_8_3
		var_8_1 = var_8_1 + 1
	end

	for iter_8_4 = var_8_1, var_8_2 do
		arg_8_0._equipList[iter_8_4] = nil
	end

	EquipController.instance:dispatchEvent(EquipEvent.onDeleteEquip, arg_8_1)
end

function var_0_0.canShowVfx(arg_9_0)
	return arg_9_0 ~= nil and arg_9_0.rare >= 4
end

function var_0_0.isLimit(arg_10_0, arg_10_1)
	return EquipConfig.instance:getEquipCo(arg_10_1).upperLimit >= 1
end

function var_0_0.isLimitAndAlreadyHas(arg_11_0, arg_11_1)
	local var_11_0 = EquipConfig.instance:getEquipCo(arg_11_1)

	if var_11_0.upperLimit == 0 then
		return false
	end

	return arg_11_0:getEquipQuantity(arg_11_1) >= var_11_0.upperLimit
end

var_0_0.instance = var_0_0.New()

return var_0_0
