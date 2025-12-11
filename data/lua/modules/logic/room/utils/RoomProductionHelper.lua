module("modules.logic.room.utils.RoomProductionHelper", package.seeall)

local var_0_0 = {
	getCanGainLineIdList = function(arg_1_0)
		local var_1_0 = {}
		local var_1_1 = RoomConfig.instance:getProductionPartConfig(arg_1_0)

		if not var_1_1 then
			return var_1_0
		end

		local var_1_2 = var_1_1.productionLines

		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			local var_1_3 = RoomProductionModel.instance:getLineMO(iter_1_1)

			if var_1_3 and var_1_3:isCanGain() then
				table.insert(var_1_0, iter_1_1)
			end
		end

		return var_1_0
	end
}

function var_0_0.hasUnlockLine(arg_2_0, arg_2_1)
	return var_0_0.getUnlockLineCount(arg_2_0, arg_2_1) > 0
end

function var_0_0.getUnlockLineCount(arg_3_0, arg_3_1)
	local var_3_0 = 0

	arg_3_1 = arg_3_1 or RoomModel.instance:getRoomLevel()

	local var_3_1 = RoomConfig.instance:getProductionPartConfig(arg_3_0).productionLines

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if var_0_0.isLineUnlock(iter_3_1, arg_3_1) then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

function var_0_0.isLineUnlock(arg_4_0, arg_4_1)
	local var_4_0 = RoomConfig.instance:getProductionLineConfig(arg_4_0)

	return var_4_0 and arg_4_1 >= var_4_0.needRoomLevel
end

function var_0_0.getFormulaMaxCount(arg_5_0)
	local var_5_0 = RoomConfig.instance:getFormulaConfig(arg_5_0)
	local var_5_1 = RoomBuildingEnum.MachineSlotMaxCount

	if string.nilorempty(var_5_0.costMaterial) then
		return RoomBuildingEnum.MachineSlotMaxCount
	end

	local var_5_2 = var_0_0.getFormulaItemParamList(var_5_0.costMaterial)
	local var_5_3 = var_0_0.getFormulaItemParamList(var_5_0.costScore)
	local var_5_4 = {}

	for iter_5_0 = 1, #var_5_2 do
		local var_5_5 = var_5_2[iter_5_0]

		var_5_4[var_5_5.type] = var_5_4[var_5_5.type] or {}
		var_5_4[var_5_5.type][var_5_5.id] = (var_5_4[var_5_5.type][var_5_5.id] or 0) + var_5_5.quantity
	end

	for iter_5_1 = 1, #var_5_3 do
		local var_5_6 = var_5_3[iter_5_1]

		var_5_4[var_5_6.type] = var_5_4[var_5_6.type] or {}
		var_5_4[var_5_6.type][var_5_6.id] = (var_5_4[var_5_6.type][var_5_6.id] or 0) + var_5_6.quantity
	end

	for iter_5_2, iter_5_3 in pairs(var_5_4) do
		for iter_5_4, iter_5_5 in pairs(iter_5_3) do
			local var_5_7 = ItemModel.instance:getItemQuantity(iter_5_2, iter_5_4)

			if iter_5_5 ~= 0 then
				local var_5_8 = math.floor(var_5_7 / iter_5_5)

				if var_5_8 < var_5_1 then
					var_5_1 = var_5_8
				end
			end
		end
	end

	return var_5_1
end

function var_0_0.isChangeFormulaUnlock(arg_6_0, arg_6_1)
	if not ItemModel.instance:getItemConfig(arg_6_0, arg_6_1) then
		return false
	end

	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(lua_formula.configList) do
		if not string.nilorempty(iter_6_1.produce) then
			local var_6_1 = var_0_0.getFormulaItemParamList(iter_6_1.produce)

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				if iter_6_3.type == arg_6_0 and iter_6_3.id == arg_6_1 and (not var_6_0 or var_6_0 > iter_6_1.needProductionLevel) then
					var_6_0 = iter_6_1.needProductionLevel
				end
			end
		end
	end

	local var_6_2 = 0
	local var_6_3 = RoomProductionModel.instance:getList()

	if LuaUtil.tableNotEmpty(var_6_3) then
		for iter_6_4, iter_6_5 in ipairs(var_6_3) do
			if iter_6_5.config.logic == RoomProductLineEnum.ProductType.Change and var_6_2 < iter_6_5.level then
				var_6_2 = iter_6_5.level
			end
		end
	end

	if var_6_2 <= 0 then
		return false, RoomEnum.Toast.RoomProductionLevelLock
	end

	if var_6_2 < var_6_0 then
		return false, RoomEnum.Toast.RoomNeedProductionLevel, var_6_0
	end

	if RoomController.instance:isEditMode() and RoomController.instance:isRoomScene() then
		return false, RoomEnum.Toast.RoomEditCanNotOpenProductionLevel
	end

	return true
end

function var_0_0.isFormulaShowTypeUnlock(arg_7_0)
	local var_7_0
	local var_7_1 = RoomFormulaModel.instance:getAllTopTreeLevelFormulaMoList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.config.showType == arg_7_0 then
			local var_7_2 = iter_7_1.config.needProductionLevel

			if not var_7_0 or var_7_2 < var_7_0 then
				var_7_0 = var_7_2
			end
		end
	end

	return var_7_0 or 0
end

function var_0_0.isFormulaUnlock(arg_8_0, arg_8_1)
	local var_8_0 = true
	local var_8_1
	local var_8_2
	local var_8_3
	local var_8_4 = RoomConfig.instance:getFormulaConfig(arg_8_0)

	if not var_8_4 then
		return
	end

	if RoomModel.instance:getRoomLevel() < var_8_4.needRoomLevel then
		var_8_0 = false
		var_8_1 = var_8_4.needRoomLevel
	end

	if arg_8_1 < var_8_4.needProductionLevel then
		var_8_0 = false
		var_8_2 = var_8_4.needProductionLevel
	end

	if var_8_4.needEpisodeId ~= 0 and not DungeonModel.instance:hasPassLevelAndStory(var_8_4.needEpisodeId) then
		var_8_0 = false
		var_8_3 = var_8_4.needEpisodeId
	end

	return var_8_0, var_8_1, var_8_2, var_8_3
end

function var_0_0.getFormulaCostTime(arg_9_0, arg_9_1)
	local var_9_0 = RoomConfig.instance:getFormulaConfig(arg_9_0)

	if not var_9_0 then
		return 0
	end

	local var_9_1 = var_9_0.costTime

	if not arg_9_1 then
		return var_9_1
	end

	local var_9_2 = 0

	if arg_9_1.levelCO then
		local var_9_3 = GameUtil.splitString2(arg_9_1.levelCO.effect, true)

		if var_9_3 then
			for iter_9_0, iter_9_1 in ipairs(var_9_3) do
				if iter_9_1[1] == RoomBuildingEnum.EffectType.Time then
					var_9_2 = var_9_2 + iter_9_1[2]
				end
			end
		end
	end

	local var_9_4 = math.max(0, 1000 - var_9_2)

	return math.floor(var_9_1 * var_9_4 / 1000)
end

function var_0_0.isPartWorking(arg_10_0)
	local var_10_0 = RoomConfig.instance:getProductionPartConfig(arg_10_0)

	if var_0_0.getPartType(arg_10_0) == RoomProductLineEnum.ProductType.Change then
		return true
	end

	local var_10_1 = var_10_0.productionLines

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if RoomController.instance:isDebugMode() then
			return false
		elseif RoomController.instance:isVisitMode() then
			return false
		else
			local var_10_2 = RoomProductionModel.instance:getLineMO(iter_10_1)

			if var_10_2 and not var_10_2:isLock() and not var_10_2:isFull() and not var_10_2:isPause() then
				return true
			end
		end
	end

	return false
end

function var_0_0.canLevelUp(arg_11_0)
	if arg_11_0.level == arg_11_0.maxConfigLevel or arg_11_0:isLock() then
		return false
	end

	if arg_11_0.level >= arg_11_0.maxLevel then
		return false
	end

	local var_11_0 = math.min(arg_11_0.maxConfigLevel, arg_11_0.level + 1)
	local var_11_1 = RoomConfig.instance:getProductionLineLevelConfig(arg_11_0.config.levelGroup, var_11_0).cost
	local var_11_2 = GameUtil.splitString2(var_11_1, true)

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = iter_11_1[1]
		local var_11_4 = iter_11_1[2]

		if iter_11_1[3] > ItemModel.instance:getItemQuantity(var_11_3, var_11_4) then
			return false
		end
	end

	return true
end

function var_0_0.getPartType(arg_12_0)
	local var_12_0 = RoomConfig.instance:getProductionPartConfig(arg_12_0).productionLines[1]
	local var_12_1 = RoomConfig.instance:getProductionLineConfig(var_12_0)

	return var_12_1.logic, var_12_1.type
end

function var_0_0.getPartMaxLineLevel(arg_13_0)
	local var_13_0 = RoomConfig.instance:getProductionPartConfig(arg_13_0)
	local var_13_1 = 0
	local var_13_2 = var_13_0.productionLines

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		local var_13_3 = RoomProductionModel.instance:getLineMO(iter_13_1)
		local var_13_4 = var_13_3 and var_13_3.level or 0

		if var_13_1 < var_13_4 then
			var_13_1 = var_13_4
		end
	end

	return var_13_1
end

function var_0_0.getChangePartLineMO(arg_14_0)
	local var_14_0 = RoomConfig.instance:getProductionPartConfig(arg_14_0).productionLines

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		return (RoomProductionModel.instance:getLineMO(iter_14_1))
	end
end

function var_0_0.getFormulaRewardInfo(arg_15_0)
	local var_15_0 = RoomConfig.instance:getFormulaConfig(arg_15_0)

	if not var_15_0 then
		return nil
	end

	local var_15_1 = var_0_0.getFormulaItemParamList(var_15_0.produce)[1]

	if not var_15_1 then
		return
	end

	var_15_1.quantity = ItemModel.instance:getItemQuantity(var_15_1.type, var_15_1.id)

	return var_15_1
end

function var_0_0.getSkinLevel(arg_16_0, arg_16_1)
	local var_16_0 = RoomConfig.instance:getProductionPartConfig(arg_16_0)

	if not var_16_0 then
		return 0
	end

	local var_16_1 = var_16_0.productionLines[1]

	if not var_16_1 then
		return 0
	end

	local var_16_2 = RoomConfig.instance:getProductionLineConfig(var_16_1)

	if not var_16_2 then
		return 0
	end

	local var_16_3 = 0
	local var_16_4
	local var_16_5 = RoomConfig.instance:getProductionLineLevelConfigList(var_16_2.levelGroup)

	for iter_16_0, iter_16_1 in ipairs(var_16_5) do
		if arg_16_1 < iter_16_1.id then
			break
		end

		if not string.nilorempty(iter_16_1.modulePart) and iter_16_1.modulePart ~= var_16_4 then
			var_16_3 = var_16_3 + 1
			var_16_4 = iter_16_1.modulePart
		end
	end

	return var_16_3
end

function var_0_0.getRoomLevelUpParams(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = RoomConfig.instance:getRoomLevelConfig(arg_17_0)
	local var_17_2 = RoomConfig.instance:getRoomLevelConfig(arg_17_1)

	if not arg_17_2 then
		table.insert(var_17_0, {
			desc = luaLang("room_levelup_init_title"),
			currentDesc = string.format("Lv.%d", arg_17_0),
			nextDesc = string.format("Lv.%d", arg_17_1)
		})
	end

	local var_17_3 = {}

	for iter_17_0, iter_17_1 in ipairs(lua_production_part.configList) do
		local var_17_4 = iter_17_1.id

		if var_0_0.hasUnlockLine(var_17_4, arg_17_1) and not var_0_0.hasUnlockLine(var_17_4, arg_17_0) then
			table.insert(var_17_3, string.format(luaLang("room_levelup_init_name1"), iter_17_1.name))
		end
	end

	if #var_17_3 > 0 then
		local var_17_5 = var_0_0.combineNames(var_17_3, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
		local var_17_6 = {}

		if arg_17_2 then
			var_17_6.desc = string.format(luaLang("room_levelup_init_unlock"), var_17_5)
		else
			var_17_6.desc = string.format(luaLang("room_levelupresult_init_unlock"), var_17_5)
			var_17_6.currentDesc = tostring(0)
			var_17_6.nextDesc = tostring(1)
		end

		table.insert(var_17_0, var_17_6)
	end

	local var_17_7 = {}
	local var_17_8 = {}

	for iter_17_2, iter_17_3 in ipairs(lua_production_part.configList) do
		local var_17_9 = iter_17_3.id
		local var_17_10 = var_0_0.getUnlockLineCount(var_17_9, arg_17_0)
		local var_17_11 = var_0_0.getUnlockLineCount(var_17_9, arg_17_1)

		if var_17_10 < 1 then
			var_17_10 = 1
		end

		if var_17_10 < var_17_11 and var_17_10 > 0 then
			var_17_7[var_17_10] = var_17_7[var_17_10] or {}

			if not var_17_7[var_17_10][var_17_11] then
				var_17_7[var_17_10][var_17_11] = {}

				table.insert(var_17_8, {
					curCount = var_17_10,
					nextCount = var_17_11
				})
			end

			table.insert(var_17_7[var_17_10][var_17_11], string.format(luaLang("room_levelup_init_name2"), iter_17_3.name))
		end
	end

	if #var_17_8 > 0 then
		for iter_17_4, iter_17_5 in ipairs(var_17_8) do
			local var_17_12 = iter_17_5.curCount
			local var_17_13 = iter_17_5.nextCount
			local var_17_14 = var_17_7[var_17_12][var_17_13]
			local var_17_15 = var_0_0.combineNames(var_17_14, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
			local var_17_16 = {}

			if arg_17_2 then
				local var_17_17 = {}

				for iter_17_6 = var_17_12 + 1, var_17_13 do
					table.insert(var_17_17, string.format(luaLang("room_levelupresult_init_count_number"), iter_17_6))
				end

				local var_17_18 = var_0_0.combineNames(var_17_17, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
				local var_17_19 = {
					var_17_15,
					var_17_18
				}

				var_17_16.desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_count"), var_17_19)
			else
				var_17_16.desc = string.format(luaLang("room_levelup_init_count"), var_17_15)
				var_17_16.currentDesc = tostring(var_17_12)
				var_17_16.nextDesc = tostring(var_17_13)
			end

			table.insert(var_17_0, var_17_16)
		end
	end

	local var_17_20 = {}
	local var_17_21 = {}
	local var_17_22 = {}

	for iter_17_7, iter_17_8 in ipairs(lua_production_part.configList) do
		local var_17_23 = iter_17_8.id
		local var_17_24 = var_0_0.getLineMaxLevel(var_17_23, arg_17_0)
		local var_17_25 = var_0_0.getLineMaxLevel(var_17_23, arg_17_1)

		if var_17_25 > 0 and var_17_24 == 0 then
			var_17_24 = 1
		end

		if var_17_24 < var_17_25 and var_17_24 > 0 then
			if not var_17_20[var_17_25] then
				var_17_20[var_17_25] = {}

				table.insert(var_17_22, var_17_25)
			end

			if not var_17_20[var_17_25][var_17_24] then
				var_17_20[var_17_25][var_17_24] = {}

				table.insert(var_17_21, {
					curMaxLevel = var_17_24,
					nextMaxLevel = var_17_25
				})
			end

			table.insert(var_17_20[var_17_25][var_17_24], string.format(luaLang("room_levelup_init_name2"), iter_17_8.name))
		end
	end

	if arg_17_2 then
		if #var_17_22 > 0 then
			for iter_17_9, iter_17_10 in ipairs(var_17_22) do
				local var_17_26 = var_17_20[iter_17_10]
				local var_17_27 = {}

				for iter_17_11, iter_17_12 in pairs(var_17_26) do
					tabletool.addValues(var_17_27, iter_17_12)
				end

				local var_17_28 = var_0_0.combineNames(var_17_27, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
				local var_17_29 = {
					var_17_28,
					iter_17_10
				}
				local var_17_30 = {
					desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_maxlevel"), var_17_29)
				}

				table.insert(var_17_0, var_17_30)
			end
		end
	elseif #var_17_21 > 0 then
		for iter_17_13, iter_17_14 in ipairs(var_17_21) do
			local var_17_31 = iter_17_14.nextMaxLevel
			local var_17_32 = iter_17_14.curMaxLevel
			local var_17_33 = var_17_20[var_17_31][var_17_32]
			local var_17_34 = var_0_0.combineNames(var_17_33, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
			local var_17_35 = {
				desc = string.format(luaLang("room_levelup_init_maxlevel"), var_17_34),
				currentDesc = tostring(var_17_32),
				nextDesc = tostring(var_17_31)
			}

			table.insert(var_17_0, var_17_35)
		end
	end

	local var_17_36 = RoomMapBlockModel.instance:getMaxBlockCount(arg_17_0)
	local var_17_37 = RoomMapBlockModel.instance:getMaxBlockCount(arg_17_1)

	if var_17_36 < var_17_37 then
		local var_17_38 = {}

		if arg_17_2 then
			var_17_38.desc = string.format(luaLang("room_levelupresult_init_block"), var_17_37 - var_17_36)
		else
			var_17_38.desc = luaLang("room_levelup_init_block")
			var_17_38.currentDesc = tostring(var_17_36)
			var_17_38.nextDesc = tostring(var_17_37)
		end

		table.insert(var_17_0, var_17_38)
	end

	local var_17_39 = var_17_1.characterLimit
	local var_17_40 = var_17_2.characterLimit

	if var_17_39 < var_17_40 then
		local var_17_41 = {}

		if arg_17_2 then
			var_17_41.desc = string.format(luaLang("room_levelupresult_init_character"), var_17_40 - var_17_39)
		else
			var_17_41.desc = luaLang("room_levelup_init_character")
			var_17_41.currentDesc = tostring(var_17_39)
			var_17_41.nextDesc = tostring(var_17_40)
		end

		table.insert(var_17_0, var_17_41)
	end

	if arg_17_2 and arg_17_1 and CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) == arg_17_1 then
		table.insert(var_17_0, {
			desc = luaLang("room_levelupresult_init_layoutplan_open")
		})
	end

	return var_17_0
end

function var_0_0.combineNames(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ""

	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		if iter_18_0 > 1 then
			if iter_18_0 == #arg_18_0 then
				var_18_0 = var_18_0 .. arg_18_2
			else
				var_18_0 = var_18_0 .. arg_18_1
			end
		end

		var_18_0 = var_18_0 .. iter_18_1
	end

	return var_18_0
end

function var_0_0.getLineMaxLevel(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1 or RoomModel.instance:getRoomLevel()
	local var_19_1 = RoomConfig.instance:getProductionPartConfig(arg_19_0).productionLines[1]
	local var_19_2 = RoomConfig.instance:getProductionLineConfig(var_19_1)
	local var_19_3 = var_19_2 and RoomConfig.instance:getProductionLineLevelGroupIdConfig(var_19_2.levelGroup)
	local var_19_4 = 0

	if var_19_3 then
		for iter_19_0, iter_19_1 in ipairs(var_19_3) do
			if var_19_0 >= iter_19_1.needRoomLevel then
				var_19_4 = math.max(iter_19_1.id, var_19_4)
			end
		end
	end

	return var_19_4
end

function var_0_0.getProductLineLevelUpParams(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}
	local var_20_1 = RoomConfig.instance:getProductionLineConfig(arg_20_0)

	if not arg_20_3 then
		table.insert(var_20_0, {
			desc = luaLang("roomproductlinelevelup_level"),
			currentDesc = string.format("Lv.%d", arg_20_1),
			nextDesc = string.format("Lv.%d", arg_20_2)
		})
	end

	if var_20_1.logic == RoomProductLineEnum.ProductType.Change then
		for iter_20_0 = 1, 4 do
			local var_20_2 = 300 + iter_20_0

			if var_0_0.getFormulaLevelUpCount(var_20_2, arg_20_2) == 1 then
				local var_20_3 = {}

				if arg_20_3 then
					var_20_3.desc = luaLang("room_levelupresult_line_change" .. iter_20_0)
				else
					var_20_3.desc = luaLang("room_levelup_line_change" .. iter_20_0)
					var_20_3.currentDesc = tostring("0")
					var_20_3.nextDesc = tostring("1")
				end

				table.insert(var_20_0, var_20_3)
			end
		end

		for iter_20_1 = 1, 4 do
			local var_20_4 = 300 + iter_20_1
			local var_20_5 = var_0_0.getFormulaLevelUpCount(var_20_4, arg_20_2)

			if var_20_5 > 1 then
				local var_20_6 = {}

				if arg_20_3 then
					if var_20_5 > 2 then
						var_20_6.desc = string.format(luaLang("room_levelupresult_line_formula" .. iter_20_1), luaLang("room_levelup_line_formula_high"))
					else
						var_20_6.desc = string.format(luaLang("room_levelupresult_line_formula" .. iter_20_1), luaLang("room_levelup_line_formula_middle"))
					end
				else
					var_20_6.desc = luaLang("room_levelup_line_formula" .. iter_20_1)

					if var_20_5 > 2 then
						var_20_6.currentDesc = luaLang("room_levelup_line_formula_middle")
						var_20_6.nextDesc = luaLang("room_levelup_line_formula_high")
					else
						var_20_6.currentDesc = luaLang("room_levelup_line_formula_low")
						var_20_6.nextDesc = luaLang("room_levelup_line_formula_middle")
					end
				end

				table.insert(var_20_0, var_20_6)
			end
		end
	elseif var_20_1.logic == RoomProductLineEnum.ProductType.Product then
		local var_20_7 = var_0_0.getProductLineReserve(arg_20_0, arg_20_1)
		local var_20_8 = var_0_0.getProductLineReserve(arg_20_0, arg_20_2)

		if var_20_7 < var_20_8 then
			local var_20_9 = {}

			if arg_20_3 then
				var_20_9.desc = string.format(luaLang("room_levelupresult_line_reserve"), var_20_8)
			else
				var_20_9.desc = luaLang("room_levelup_line_reserve")
				var_20_9.currentDesc = tostring(var_20_7)
				var_20_9.nextDesc = tostring(var_20_8)
			end

			table.insert(var_20_0, var_20_9)
		end

		local var_20_10, var_20_11 = var_0_0.getProductLineCostTimeReduceRate(arg_20_0, arg_20_1)
		local var_20_12, var_20_13 = var_0_0.getProductLineCostTimeReduceRate(arg_20_0, arg_20_2)

		if var_20_10 < var_20_12 then
			local var_20_14 = {}

			if arg_20_3 then
				var_20_14.desc = string.format(luaLang("room_levelupresult_line_costtime"), math.floor(var_20_13 / 60))
			else
				var_20_14.desc = luaLang("room_levelup_line_costtime")
				var_20_14.currentDesc = string.format("%d%%", math.floor((1 - var_20_10) * 100 + 0.5))
				var_20_14.nextDesc = string.format("%d%%", math.floor((1 - var_20_12) * 100 + 0.5))
			end

			table.insert(var_20_0, var_20_14)
		end

		local var_20_15 = var_0_0.getProductLineProductionAddRate(arg_20_0, arg_20_1)
		local var_20_16 = var_0_0.getProductLineProductionAddRate(arg_20_0, arg_20_2)

		if var_20_15 < var_20_16 then
			local var_20_17 = {}

			if arg_20_3 then
				var_20_17.desc = string.format(luaLang("room_levelupresult_line_product"), math.floor((var_20_16 - 1) * 100 + 0.5))
			else
				var_20_17.desc = luaLang("room_levelup_line_product")
				var_20_17.currentDesc = string.format("%d%%", math.floor(var_20_15 * 100 + 0.5))
				var_20_17.nextDesc = string.format("%d%%", math.floor(var_20_16 * 100 + 0.5))
			end

			table.insert(var_20_0, var_20_17)
		end
	end

	return var_20_0
end

function var_0_0.getProductLineReserve(arg_21_0, arg_21_1)
	local var_21_0 = RoomConfig.instance:getProductionLineConfig(arg_21_0)
	local var_21_1 = var_21_0.reserve

	if var_21_0.levelGroup > 0 then
		local var_21_2 = RoomConfig.instance:getProductionLineLevelConfig(var_21_0.levelGroup, arg_21_1)
		local var_21_3 = GameUtil.splitString2(var_21_2.effect, true)

		if var_21_3 then
			for iter_21_0, iter_21_1 in ipairs(var_21_3) do
				if iter_21_1[1] == RoomBuildingEnum.EffectType.Reserve then
					var_21_1 = var_21_1 + iter_21_1[2]
				end
			end
		end
	end

	return var_21_1
end

function var_0_0.getProductLineCostTimeReduceRate(arg_22_0, arg_22_1)
	if arg_22_1 <= 1 then
		return 0, 0
	end

	local var_22_0 = RoomConfig.instance:getProductionLineConfig(arg_22_0)
	local var_22_1 = var_22_0.initFormula
	local var_22_2 = RoomConfig.instance:getFormulaConfig(var_22_1)
	local var_22_3 = var_22_1

	if var_22_0.levelGroup > 0 then
		for iter_22_0 = arg_22_1, 1, -1 do
			local var_22_4 = RoomConfig.instance:getProductionLineLevelConfig(var_22_0.levelGroup, arg_22_1)

			if not string.nilorempty(var_22_4.changeFormulaId) then
				var_22_3 = tonumber(var_22_4.changeFormulaId)

				break
			end
		end
	end

	local var_22_5 = RoomConfig.instance:getFormulaConfig(var_22_3)

	if var_22_2.costTime <= 0 then
		return 0, 0
	end

	return 1 - var_22_5.costTime / var_22_2.costTime, var_22_2.costTime - var_22_5.costTime
end

function var_0_0.getProductLineProductionAddRate(arg_23_0, arg_23_1)
	if arg_23_1 <= 1 then
		return 1
	end

	local var_23_0 = RoomConfig.instance:getProductionLineConfig(arg_23_0)
	local var_23_1 = var_23_0.initFormula
	local var_23_2 = RoomConfig.instance:getFormulaConfig(var_23_1)
	local var_23_3 = var_23_1

	if var_23_0.levelGroup > 0 then
		for iter_23_0 = arg_23_1, 1, -1 do
			local var_23_4 = RoomConfig.instance:getProductionLineLevelConfig(var_23_0.levelGroup, arg_23_1)

			if not string.nilorempty(var_23_4.changeFormulaId) then
				var_23_3 = tonumber(var_23_4.changeFormulaId)

				break
			end
		end
	end

	local var_23_5 = RoomConfig.instance:getFormulaConfig(var_23_3)
	local var_23_6 = var_0_0.getFormulaItemParamList(var_23_5.produce)[1]
	local var_23_7 = var_0_0.getFormulaItemParamList(var_23_2.produce)[1]

	if var_23_7.quantity <= 0 then
		return 1
	end

	return var_23_6.quantity / var_23_7.quantity
end

function var_0_0.getFormulaLevelUpCount(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0._formulaLevelUpInfo

	if not var_24_0 then
		var_24_0 = {}
		var_0_0._formulaLevelUpInfo = var_24_0

		local var_24_1 = {}

		for iter_24_0 = 0, 4 do
			for iter_24_1, iter_24_2 in ipairs(lua_formula.configList) do
				if iter_24_2.needProductionLevel == iter_24_0 then
					local var_24_2 = iter_24_2.showType

					if not var_24_0[var_24_2] then
						var_24_0[var_24_2] = {}
					end

					if not var_24_0[var_24_2][iter_24_0] then
						local var_24_3 = var_24_1[var_24_2]
						local var_24_4 = var_24_3 and var_24_3 + 1 or 1

						var_24_1[var_24_2] = var_24_4
						var_24_0[var_24_2][iter_24_0] = var_24_4
					end
				end
			end
		end
	end

	return var_24_0[arg_24_0] and var_24_0[arg_24_0][arg_24_1] or 0
end

function var_0_0.getPartIdByLineId(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(lua_production_part.configList) do
		local var_25_0 = iter_25_1.productionLines

		for iter_25_2, iter_25_3 in ipairs(var_25_0) do
			if iter_25_3 == arg_25_0 then
				return iter_25_1.id
			end
		end
	end
end

function var_0_0.getFormulaItemParamList(arg_26_0)
	local var_26_0 = {}

	if string.nilorempty(arg_26_0) then
		return var_26_0
	end

	local var_26_1 = GameUtil.splitString2(arg_26_0, true)

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		table.insert(var_26_0, {
			type = iter_26_1[1],
			id = iter_26_1[2],
			quantity = iter_26_1[3]
		})
	end

	return var_26_0
end

function var_0_0.getFormulaStrUID(arg_27_0, arg_27_1)
	return string.format("%s#%s", arg_27_0, arg_27_1)
end

function var_0_0.getFormulaConfig(arg_28_0)
	local var_28_0 = RoomConfig.instance:getFormulaConfig(arg_28_0)

	if not var_28_0 then
		logError("RoomProductionHelper:getFormulaConfig Error! config not found: " .. (arg_28_0 or nil))
	end

	return var_28_0
end

function var_0_0.getCostCoinItemList(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = var_0_0.getFormulaConfig(arg_29_0)

	if var_29_1 then
		if string.nilorempty(var_29_1.costScore) then
			logWarn("RoomProductionHelper.getCostCoinItemList Warn, formulaConfig.costScore is empty")
		end

		var_29_0 = var_0_0.getFormulaItemParamList(var_29_1.costScore)
	end

	return var_29_0
end

function var_0_0.getCostMaterialItemList(arg_30_0)
	local var_30_0 = {}
	local var_30_1 = var_0_0.getFormulaConfig(arg_30_0)

	if var_30_1 then
		local var_30_2 = var_30_1.costMaterial

		if not string.nilorempty(var_30_1.costMaterial) then
			var_30_0 = var_0_0.getFormulaItemParamList(var_30_2)
		end
	end

	return var_30_0
end

function var_0_0.getCostMaterialFormulaList(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = var_0_0.getCostMaterialItemList(arg_31_0)

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		local var_31_2 = RoomConfig.instance:getItemFormulaId(iter_31_1.type, iter_31_1.id)

		table.insert(var_31_0, var_31_2)
	end

	return var_31_0
end

function var_0_0.getCostItemListWithFormulaId(arg_32_0, arg_32_1)
	local var_32_0 = {}
	local var_32_1 = var_0_0.getCostMaterialItemList(arg_32_0)

	if arg_32_1 then
		local var_32_2 = var_0_0.getCostCoinItemList(arg_32_0)

		for iter_32_0, iter_32_1 in pairs(var_32_2) do
			table.insert(var_32_1, iter_32_1)
		end
	end

	for iter_32_2, iter_32_3 in ipairs(var_32_1) do
		local var_32_3 = RoomConfig.instance:getItemFormulaId(iter_32_3.type, iter_32_3.id)
		local var_32_4 = {
			formulaId = var_32_3,
			type = iter_32_3.type,
			id = iter_32_3.id,
			quantity = iter_32_3.quantity
		}

		table.insert(var_32_0, var_32_4)
	end

	return var_32_0
end

function var_0_0.isEnoughCoin(arg_33_0, arg_33_1)
	local var_33_0 = true

	if not arg_33_1 or arg_33_1 <= 0 then
		arg_33_1 = 1
	end

	local var_33_1 = var_0_0.getCostCoinItemList(arg_33_0)

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		if (iter_33_1.quantity or 0) * arg_33_1 > ItemModel.instance:getItemQuantity(iter_33_1.type, iter_33_1.id) then
			var_33_0 = false

			break
		end
	end

	return var_33_0
end

function var_0_0.isEnoughMaterial(arg_34_0, arg_34_1)
	local var_34_0 = true

	if not arg_34_1 or arg_34_1 <= 0 then
		arg_34_1 = 1
	end

	local var_34_1 = var_0_0.getCostMaterialItemList(arg_34_0)

	for iter_34_0, iter_34_1 in ipairs(var_34_1) do
		if iter_34_1.quantity * arg_34_1 > ItemModel.instance:getItemQuantity(iter_34_1.type, iter_34_1.id) then
			var_34_0 = false

			break
		end
	end

	return var_34_0
end

function var_0_0.getTopLevelFormulaStrId(arg_35_0)
	local var_35_0, var_35_1 = var_0_0.changeStrUID2FormulaIdAndTreeLevel(arg_35_0)

	if var_35_0 and var_35_0 ~= 0 and var_35_1 then
		if var_35_1 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			return arg_35_0
		else
			return (var_0_0.getFormulaStrUID(var_35_0, RoomFormulaModel.DEFAULT_TREE_LEVEL))
		end
	end
end

function var_0_0.getFormulaProduceItem(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1 or var_0_0.getFormulaConfig(arg_36_0)

	if var_36_0 then
		local var_36_1 = var_0_0.getFormulaItemParamList(var_36_0.produce)

		if var_36_1[1] then
			return var_36_1[1]
		else
			logError("RoomProductionHelper.getFormulaProduceItem error, can't find produce")
		end
	end
end

function var_0_0.getFormulaNeedQuantity(arg_37_0)
	local var_37_0 = 0
	local var_37_1 = RoomFormulaModel.instance:getFormulaMo(arg_37_0)

	if not var_37_1 then
		return var_37_0
	end

	local var_37_2 = var_37_1:getFormulaId()
	local var_37_3 = var_0_0.getFormulaProduceItem(var_37_2)

	if not var_37_3 then
		return var_37_0
	end

	if var_37_1:isTreeFormula() then
		local var_37_4 = var_37_1:getParentStrId()
		local var_37_5 = RoomFormulaModel.instance:getFormulaMo(var_37_4)

		if var_37_5 then
			local var_37_6 = 0
			local var_37_7 = var_37_5:getFormulaId()
			local var_37_8 = var_0_0.getCostMaterialItemList(var_37_7)

			for iter_37_0, iter_37_1 in ipairs(var_37_8) do
				if iter_37_1.id == var_37_3.id then
					var_37_6 = iter_37_1.quantity

					break
				end
			end

			var_37_0 = var_37_5:getFormulaCombineCount() * var_37_6
		end
	else
		local var_37_9 = JumpModel.instance:getRecordFarmItem()

		if var_37_9 and var_37_9.quantity and var_37_9.id == var_37_3.id then
			var_37_0 = var_37_9.quantity
		end
	end

	return var_37_0
end

function var_0_0.getNeedFormulaShowTypeAndFormulaStrId(arg_38_0)
	local var_38_0
	local var_38_1
	local var_38_2 = JumpModel.instance:getRecordFarmItem()

	if not var_38_2 or not var_38_2.type or not var_38_2.id then
		return var_38_0, var_38_1
	end

	local var_38_3 = RoomConfig.instance:getItemFormulaId(var_38_2.type, var_38_2.id)

	if not var_38_3 or var_38_3 == 0 then
		return var_38_0, var_38_1
	end

	local var_38_4 = RoomConfig.instance:getFormulaConfig(var_38_3).showType

	if var_38_4 and var_38_4 ~= 0 then
		local var_38_5 = var_0_0.isFormulaShowTypeUnlock(var_38_4)

		if var_38_5 > arg_38_0.level then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, arg_38_0.config.name, var_38_5)
		else
			var_38_0 = var_38_4
		end
	end

	if var_38_0 then
		local var_38_6, var_38_7, var_38_8, var_38_9 = var_0_0.isFormulaUnlock(var_38_3, arg_38_0.level)

		if var_38_6 then
			var_38_1 = var_0_0.getFormulaStrUID(var_38_3, RoomFormulaModel.DEFAULT_TREE_LEVEL)
		elseif var_38_7 then
			GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, var_38_7)
		elseif var_38_8 then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, arg_38_0.config.name, var_38_8)
		elseif var_38_9 then
			GameFacade.showToast(ToastEnum.ClickRoomFormula)
		end
	end

	if not var_38_1 then
		var_38_0 = nil
	end

	return var_38_0, var_38_1
end

function var_0_0.getTotalCanCombineNum(arg_39_0)
	local var_39_0 = 1

	while var_0_0._canCombineQuantityTimeFormula(nil, arg_39_0, var_39_0) do
		var_39_0 = var_39_0 * 2
	end

	local var_39_1 = 0

	while var_39_1 <= var_39_0 do
		local var_39_2 = math.floor(var_39_1 + (var_39_0 - var_39_1) / 2)
		local var_39_3 = var_0_0._canCombineQuantityTimeFormula(nil, arg_39_0, var_39_2)
		local var_39_4 = var_0_0._canCombineQuantityTimeFormula(nil, arg_39_0, var_39_2 + 1)

		if var_39_3 and not var_39_4 then
			return var_39_2
		elseif var_39_3 then
			var_39_1 = var_39_2 + 1
		else
			var_39_0 = var_39_2 - 1
		end
	end

	logError("RoomProductionHelper.getTotalCanCombineNum verify error, result:" .. var_39_0 .. " formulaId:" .. arg_39_0)

	return 0
end

function var_0_0.getEasyCombineFormulaAndCostItemList(arg_40_0, arg_40_1, arg_40_2)
	if not var_0_0.getFormulaProduceItem(arg_40_0) then
		return false
	end

	local var_40_0 = {
		formulaIdList = {},
		itemTypeDic = {}
	}
	local var_40_1 = var_0_0._canCombineQuantityTimeFormula(var_40_0, arg_40_0, arg_40_1, arg_40_2)

	table.insert(var_40_0.formulaIdList, {
		formulaId = arg_40_0,
		count = arg_40_1
	})

	return var_40_1, var_40_0
end

local function var_0_1(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if not arg_41_0 then
		return
	end

	if not arg_41_0[arg_41_1] then
		arg_41_0[arg_41_1] = {}
	end

	arg_41_0[arg_41_1][arg_41_2] = (arg_41_0[arg_41_1][arg_41_2] or 0) + (arg_41_3 or 0)
end

function var_0_0._canCombineQuantityTimeFormula(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_3 = arg_42_3 or {}

	local var_42_0 = var_0_0.getCostItemListWithFormulaId(arg_42_1, true)

	if #var_42_0 <= 0 then
		return false
	end

	local var_42_1
	local var_42_2

	if arg_42_0 then
		var_42_1 = arg_42_0.itemTypeDic
		var_42_2 = arg_42_0.formulaIdList
	end

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		local var_42_3 = iter_42_1.id
		local var_42_4 = iter_42_1.type

		var_0_1(arg_42_3, var_42_4, var_42_3)

		local var_42_5 = ItemModel.instance:getItemQuantity(var_42_4, var_42_3) - arg_42_3[var_42_4][var_42_3]

		if var_42_5 < 0 then
			logError("RoomProductionHelper._canCombineQuantityTimeFormula error, remainOwnQuantity is negative:" .. var_42_5)

			var_42_5 = 0
		end

		local var_42_6 = 0
		local var_42_7 = iter_42_1.quantity * arg_42_2
		local var_42_8 = var_42_5 - var_42_7

		if var_42_8 < 0 then
			local var_42_9 = iter_42_1.formulaId

			if not var_42_9 or var_42_9 == 0 then
				return false
			end

			local var_42_10 = math.abs(var_42_8)

			if not var_0_0._canCombineQuantityTimeFormula(arg_42_0, iter_42_1.formulaId, var_42_10, arg_42_3) then
				return false
			end

			if var_42_2 then
				table.insert(var_42_2, {
					formulaId = var_42_9,
					count = var_42_10
				})
			end

			var_42_6 = var_42_5
		else
			var_42_6 = var_42_7
		end

		var_0_1(var_42_1, var_42_4, var_42_3, var_42_6)
		var_0_1(arg_42_3, var_42_4, var_42_3, var_42_6)
	end

	return true
end

function var_0_0.canEasyCombineItems(arg_43_0, arg_43_1)
	if not arg_43_0 then
		return false
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		return false
	end

	if not var_0_0.hasUnlockLine(RoomProductLineEnum.ProductItemType.Change) then
		return false
	end

	local var_43_0 = false
	local var_43_1
	local var_43_2 = {}
	local var_43_3 = RoomProductionModel.instance:getLineMO(RoomProductLineEnum.Line.Spring).level

	for iter_43_0, iter_43_1 in ipairs(arg_43_0) do
		local var_43_4 = RoomConfig.instance:getItemFormulaId(iter_43_1.type, iter_43_1.id)

		if not var_0_0.isFormulaUnlock(var_43_4, var_43_3) then
			return var_43_0
		end

		var_43_2[#var_43_2 + 1] = {
			formulaId = var_43_4,
			count = iter_43_1.quantity
		}
	end

	local var_43_5, var_43_6 = var_0_0.getEasyCombineFormulaListAndCostItemList(var_43_2, arg_43_1)
	local var_43_7 = var_43_6

	return var_43_5, var_43_7
end

function var_0_0.getEasyCombineFormulaListAndCostItemList(arg_44_0, arg_44_1)
	if not arg_44_0 or #arg_44_0 <= 0 then
		return false
	end

	local var_44_0 = true
	local var_44_1 = {}
	local var_44_2 = {}
	local var_44_3 = {}

	arg_44_1 = arg_44_1 or {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
		local var_44_4 = iter_44_1.formulaId
		local var_44_5 = iter_44_1.count
		local var_44_6, var_44_7 = var_0_0.getEasyCombineFormulaAndCostItemList(var_44_4, var_44_5, arg_44_1)

		if not var_44_6 then
			var_44_0 = false

			break
		end

		for iter_44_2, iter_44_3 in ipairs(var_44_7.formulaIdList) do
			local var_44_8 = iter_44_3.formulaId
			local var_44_9 = iter_44_3.count

			var_44_1[var_44_8] = (var_44_1[var_44_8] or 0) + (var_44_9 or 0)

			if not var_44_2[var_44_8] or iter_44_2 < var_44_2[var_44_8] then
				var_44_2[var_44_8] = iter_44_2
			end
		end

		for iter_44_4, iter_44_5 in pairs(var_44_7.itemTypeDic) do
			for iter_44_6, iter_44_7 in pairs(iter_44_5) do
				var_0_1(var_44_3, iter_44_4, iter_44_6, iter_44_7)
			end
		end
	end

	local var_44_10

	if var_44_0 then
		local var_44_11 = {}

		for iter_44_8, iter_44_9 in pairs(var_44_1) do
			var_44_11[#var_44_11 + 1] = {
				formulaId = iter_44_8,
				count = iter_44_9
			}
		end

		table.sort(var_44_11, function(arg_45_0, arg_45_1)
			local var_45_0 = RoomConfig.instance:getFormulaConfig(arg_45_0.formulaId)
			local var_45_1 = RoomConfig.instance:getFormulaConfig(arg_45_1.formulaId)
			local var_45_2 = var_45_0 and var_45_0.rare
			local var_45_3 = var_45_1 and var_45_1.rare

			if var_45_2 ~= var_45_3 then
				return var_45_2 < var_45_3
			end

			return var_44_2[arg_45_0.formulaId] < var_44_2[arg_45_1.formulaId]
		end)

		var_44_10 = {
			formulaIdList = var_44_11,
			itemTypeDic = var_44_3
		}
	end

	return var_44_0, var_44_10
end

function var_0_0.changeStrUID2FormulaIdAndTreeLevel(arg_46_0)
	local var_46_0 = 0
	local var_46_1 = RoomFormulaModel.DEFAULT_TREE_LEVEL

	if not arg_46_0 then
		logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel error, strId nil")

		return var_46_0, var_46_1
	end

	local var_46_2 = string.splitToNumber(arg_46_0, "#")

	if not var_46_2[1] or not var_46_2[2] then
		logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel format error,id:" .. arg_46_0 .. " must be formulaId#treeLevel")

		return var_46_0, var_46_1
	end

	local var_46_3 = var_46_2[1]
	local var_46_4 = var_46_2[2]

	return var_46_3, var_46_4
end

function var_0_0.formatItemNum(arg_47_0)
	return arg_47_0 > 99 and "99+" or tostring(arg_47_0)
end

function var_0_0.openRoomFormulaMsgBoxView(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6)
	local var_48_0 = {
		costItemAndFormulaIdList = arg_48_0,
		produceDataList = arg_48_1,
		lineId = arg_48_2,
		callback = arg_48_3,
		callbackObj = arg_48_4,
		combineCb = arg_48_5,
		combineCbObj = arg_48_6
	}

	ViewMgr.instance:openView(ViewName.RoomFormulaMsgBoxView, var_48_0)
end

return var_0_0
