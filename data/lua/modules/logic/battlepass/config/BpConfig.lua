module("modules.logic.battlepass.config.BpConfig", package.seeall)

local var_0_0 = class("BpConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskBpId2List = {}
	arg_1_0._taskBpId2Dict = {}
	arg_1_0._bonusBpId2List = {}
	arg_1_0._desDict = {}
	arg_1_0._skinDict = {}
	arg_1_0._headDict = {}
	arg_1_0.taskPreposeIds = {}
	arg_1_0._newItems = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"bp",
		"bp_lv_bonus",
		"bp_task",
		"bp_des"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "bp_task" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			local var_3_0 = iter_3_1.bpId
			local var_3_1 = iter_3_1.loopType

			arg_3_0._taskBpId2List[var_3_0] = arg_3_0._taskBpId2List[var_3_0] or {}
			arg_3_0._taskBpId2Dict[var_3_0] = arg_3_0._taskBpId2Dict[var_3_0] or {}

			table.insert(arg_3_0._taskBpId2List[var_3_0], iter_3_1)

			arg_3_0._taskBpId2Dict[var_3_0][var_3_1] = arg_3_0._taskBpId2Dict[var_3_0][var_3_1] or {}

			table.insert(arg_3_0._taskBpId2Dict[var_3_0][var_3_1], iter_3_1)

			if not string.nilorempty(iter_3_1.prepose) then
				local var_3_2 = string.splitToNumber(iter_3_1.prepose, "#")
				local var_3_3 = {}

				for iter_3_2, iter_3_3 in pairs(var_3_2) do
					var_3_3[iter_3_3] = true
				end

				arg_3_0.taskPreposeIds[iter_3_1.id] = var_3_3
			end
		end

		local var_3_4

		local function var_3_5(arg_4_0, arg_4_1, arg_4_2)
			if arg_4_0 == arg_4_2 then
				return
			end

			arg_4_1[arg_4_2] = true

			local var_4_0 = arg_3_0.taskPreposeIds[arg_4_2]

			if not var_4_0 then
				return
			end

			for iter_4_0 in pairs(var_4_0) do
				if not arg_4_1[iter_4_0] then
					var_3_5(arg_4_0, arg_4_1, iter_4_0)
				end
			end
		end

		for iter_3_4, iter_3_5 in pairs(arg_3_0.taskPreposeIds) do
			for iter_3_6 in pairs(iter_3_5) do
				var_3_5(iter_3_4, iter_3_5, iter_3_6)
			end
		end
	elseif arg_3_1 == "bp_lv_bonus" then
		for iter_3_7, iter_3_8 in ipairs(arg_3_2.configList) do
			local var_3_6 = iter_3_8.bpId

			arg_3_0._bonusBpId2List[var_3_6] = arg_3_0._bonusBpId2List[var_3_6] or {}

			table.insert(arg_3_0._bonusBpId2List[var_3_6], iter_3_8)
			arg_3_0:_processBonus(var_3_6, iter_3_8.freeBonus)
			arg_3_0:_processBonus(var_3_6, iter_3_8.payBonus)
		end
	elseif arg_3_1 == "bp_des" then
		for iter_3_9, iter_3_10 in ipairs(arg_3_2.configList) do
			local var_3_7 = iter_3_10.bpId
			local var_3_8 = iter_3_10.type

			arg_3_0._desDict[var_3_7] = arg_3_0._desDict[var_3_7] or {}
			arg_3_0._desDict[var_3_7][var_3_8] = arg_3_0._desDict[var_3_7][var_3_8] or {}

			table.insert(arg_3_0._desDict[var_3_7][var_3_8], iter_3_10)
			arg_3_0:_processBonus(var_3_7, iter_3_10.items)
		end
	end
end

function var_0_0._processBonus(arg_5_0, arg_5_1, arg_5_2)
	if string.nilorempty(arg_5_2) then
		return
	end

	arg_5_0._newItems[arg_5_1] = arg_5_0._newItems[arg_5_1] or {}

	local var_5_0 = GameUtil.splitString2(arg_5_2, true)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1[1] == MaterialEnum.MaterialType.HeroSkin then
			arg_5_0._skinDict[arg_5_1] = iter_5_1[2]
		elseif iter_5_1[1] == MaterialEnum.MaterialType.Item then
			local var_5_1 = lua_item.configDict[iter_5_1[2]]

			if not var_5_1 then
				logError("道具配置不存在" .. tostring(iter_5_1[2]))
			end

			if var_5_1 and var_5_1.subType == ItemEnum.SubType.Portrait then
				arg_5_0._headDict[arg_5_1] = iter_5_1[2]
			end
		end

		if iter_5_1[5] == 1 then
			table.insert(arg_5_0._newItems[arg_5_1], iter_5_1)
		end
	end
end

function var_0_0.getNewItems(arg_6_0, arg_6_1)
	return arg_6_0._newItems[arg_6_1] or {}
end

function var_0_0.getBpCO(arg_7_0, arg_7_1)
	return lua_bp.configDict[arg_7_1]
end

function var_0_0.getTaskCO(arg_8_0, arg_8_1)
	return lua_bp_task.configDict[arg_8_1]
end

function var_0_0.getTaskCOList(arg_9_0, arg_9_1)
	return arg_9_0._taskBpId2List[arg_9_1]
end

function var_0_0.getDesConfig(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._desDict[arg_10_1] then
		return {}
	end

	return arg_10_0._desDict[arg_10_1][arg_10_2]
end

function var_0_0.getCurSkinId(arg_11_0, arg_11_1)
	if not arg_11_0._skinDict[arg_11_1] then
		return 301703
	end

	return arg_11_0._skinDict[arg_11_1]
end

function var_0_0.getBpSkinBonusId(arg_12_0, arg_12_1)
	return arg_12_0._skinDict[arg_12_1]
end

function var_0_0.getCurHeadItemName(arg_13_0, arg_13_1)
	if not arg_13_0._headDict[arg_13_1] then
		return ""
	end

	local var_13_0 = arg_13_0._headDict[arg_13_1]

	return lua_item.configDict[var_13_0].name, var_13_0
end

function var_0_0.getTaskCOListByLoopType(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._taskBpId2Dict[arg_14_1]

	if var_14_0 then
		return var_14_0[arg_14_2]
	end
end

function var_0_0.getBonusCO(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = lua_bp_lv_bonus.configDict[arg_15_1]

	if var_15_0 then
		return var_15_0[arg_15_2]
	end
end

function var_0_0.getBonusCOList(arg_16_0, arg_16_1)
	return arg_16_0._bonusBpId2List[arg_16_1]
end

function var_0_0.getLevelScore(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getBpCO(arg_17_1)

	if not var_17_0 then
		return 1000
	end

	return var_17_0.expLevelUp
end

function var_0_0.getItemShowSize(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._itemSizeCo then
		local var_18_0 = lua_const.configDict[ConstEnum.BpItemSize]
		local var_18_1 = var_18_0 and var_18_0.value

		arg_18_0._itemSizeCo = {}

		if not string.nilorempty(var_18_1) then
			local var_18_2 = GameUtil.splitString2(var_18_1, true)

			for iter_18_0, iter_18_1 in pairs(var_18_2) do
				if not arg_18_0._itemSizeCo[iter_18_1[1]] then
					arg_18_0._itemSizeCo[iter_18_1[1]] = {}
				end

				arg_18_0._itemSizeCo[iter_18_1[1]][iter_18_1[2]] = {
					itemSize = iter_18_1[3],
					x = iter_18_1[4],
					y = iter_18_1[5]
				}
			end
		end
	end

	local var_18_3 = arg_18_0._itemSizeCo[arg_18_1] and arg_18_0._itemSizeCo[arg_18_1][arg_18_2]

	if var_18_3 then
		return var_18_3.itemSize, var_18_3.x, var_18_3.y
	end

	return 1.2
end

var_0_0.instance = var_0_0.New()

return var_0_0
