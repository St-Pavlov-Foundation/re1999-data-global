module("modules.logic.room.utils.RoomProductionHelper", package.seeall)

function slot1(slot0, slot1, slot2, slot3)
	if not slot0 then
		return
	end

	if not slot0[slot1] then
		slot0[slot1] = {}
	end

	slot0[slot1][slot2] = (slot0[slot1][slot2] or 0) + (slot3 or 0)
end

return {
	getCanGainLineIdList = function (slot0)
		if not RoomConfig.instance:getProductionPartConfig(slot0) then
			return {}
		end

		for slot7, slot8 in ipairs(slot2.productionLines) do
			if RoomProductionModel.instance:getLineMO(slot8) and slot9:isCanGain() then
				table.insert(slot1, slot8)
			end
		end

		return slot1
	end,
	hasUnlockLine = function (slot0, slot1)
		return uv0.getUnlockLineCount(slot0, slot1) > 0
	end,
	getUnlockLineCount = function (slot0, slot1)
		for slot8, slot9 in ipairs(RoomConfig.instance:getProductionPartConfig(slot0).productionLines) do
			if uv0.isLineUnlock(slot9, slot1 or RoomModel.instance:getRoomLevel()) then
				slot2 = 0 + 1
			end
		end

		return slot2
	end,
	isLineUnlock = function (slot0, slot1)
		return RoomConfig.instance:getProductionLineConfig(slot0) and slot2.needRoomLevel <= slot1
	end,
	getFormulaMaxCount = function (slot0)
		slot2 = RoomBuildingEnum.MachineSlotMaxCount

		if string.nilorempty(RoomConfig.instance:getFormulaConfig(slot0).costMaterial) then
			return RoomBuildingEnum.MachineSlotMaxCount
		end

		slot4 = uv0.getFormulaItemParamList(slot1.costScore)
		slot5 = {}

		for slot9 = 1, #uv0.getFormulaItemParamList(slot1.costMaterial) do
			slot10 = slot3[slot9]
			slot5[slot10.type] = slot5[slot10.type] or {}
			slot5[slot10.type][slot10.id] = (slot5[slot10.type][slot10.id] or 0) + slot10.quantity
		end

		for slot9 = 1, #slot4 do
			slot10 = slot4[slot9]
			slot5[slot10.type] = slot5[slot10.type] or {}
			slot5[slot10.type][slot10.id] = (slot5[slot10.type][slot10.id] or 0) + slot10.quantity
		end

		for slot9, slot10 in pairs(slot5) do
			for slot14, slot15 in pairs(slot10) do
				if slot15 ~= 0 and math.floor(ItemModel.instance:getItemQuantity(slot9, slot14) / slot15) < slot2 then
					slot2 = slot17
				end
			end
		end

		return slot2
	end,
	isChangeFormulaUnlock = function (slot0, slot1)
		if not ItemModel.instance:getItemConfig(slot0, slot1) then
			return false
		end

		slot3 = nil

		for slot7, slot8 in ipairs(lua_formula.configList) do
			if not string.nilorempty(slot8.produce) then
				for slot13, slot14 in ipairs(uv0.getFormulaItemParamList(slot8.produce)) do
					if slot14.type == slot0 and slot14.id == slot1 and (not slot3 or slot8.needProductionLevel < slot3) then
						slot3 = slot8.needProductionLevel
					end
				end
			end
		end

		slot4 = 0

		if LuaUtil.tableNotEmpty(RoomProductionModel.instance:getList()) then
			for slot9, slot10 in ipairs(slot5) do
				if slot10.config.logic == RoomProductLineEnum.ProductType.Change and slot4 < slot10.level then
					slot4 = slot10.level
				end
			end
		end

		if slot4 <= 0 then
			return false, RoomEnum.Toast.RoomProductionLevelLock
		end

		if slot4 < slot3 then
			return false, RoomEnum.Toast.RoomNeedProductionLevel, slot3
		end

		if RoomController.instance:isEditMode() and RoomController.instance:isRoomScene() then
			return false, RoomEnum.Toast.RoomEditCanNotOpenProductionLevel
		end

		return true
	end,
	isFormulaShowTypeUnlock = function (slot0)
		slot1 = nil

		for slot6, slot7 in ipairs(RoomFormulaModel.instance:getAllTopTreeLevelFormulaMoList()) do
			if slot7.config.showType == slot0 then
				slot8 = slot7.config.needProductionLevel

				if not slot1 or slot8 < slot1 then
					slot1 = slot8
				end
			end
		end

		return slot1 or 0
	end,
	isFormulaUnlock = function (slot0, slot1)
		slot2 = true
		slot3, slot4, slot5 = nil

		if RoomModel.instance:getRoomLevel() < RoomConfig.instance:getFormulaConfig(slot0).needRoomLevel then
			slot2 = false
			slot3 = slot6.needRoomLevel
		end

		if slot1 < slot6.needProductionLevel then
			slot2 = false
			slot4 = slot6.needProductionLevel
		end

		if slot6.needEpisodeId ~= 0 and not DungeonModel.instance:hasPassLevelAndStory(slot6.needEpisodeId) then
			slot2 = false
			slot5 = slot6.needEpisodeId
		end

		return slot2, slot3, slot4, slot5
	end,
	getFormulaCostTime = function (slot0, slot1)
		if not RoomConfig.instance:getFormulaConfig(slot0) then
			return 0
		end

		if not slot1 then
			return slot2.costTime
		end

		slot4 = 0

		if slot1.levelCO and GameUtil.splitString2(slot1.levelCO.effect, true) then
			for slot9, slot10 in ipairs(slot5) do
				if slot10[1] == RoomBuildingEnum.EffectType.Time then
					slot4 = slot4 + slot10[2]
				end
			end
		end

		return math.floor(slot3 * math.max(0, 1000 - slot4) / 1000)
	end,
	isPartWorking = function (slot0)
		slot1 = RoomConfig.instance:getProductionPartConfig(slot0)

		if uv0.getPartType(slot0) == RoomProductLineEnum.ProductType.Change then
			return true
		end

		for slot7, slot8 in ipairs(slot1.productionLines) do
			if RoomController.instance:isDebugMode() then
				return false
			elseif RoomController.instance:isVisitMode() then
				return false
			elseif RoomProductionModel.instance:getLineMO(slot8) and not slot9:isLock() and not slot9:isFull() and not slot9:isPause() then
				return true
			end
		end

		return false
	end,
	canLevelUp = function (slot0)
		if slot0.level == slot0.maxConfigLevel or slot0:isLock() then
			return false
		end

		if slot0.maxLevel <= slot0.level then
			return false
		end

		for slot8, slot9 in ipairs(GameUtil.splitString2(RoomConfig.instance:getProductionLineLevelConfig(slot0.config.levelGroup, math.min(slot0.maxConfigLevel, slot0.level + 1)).cost, true)) do
			if ItemModel.instance:getItemQuantity(slot9[1], slot9[2]) < slot9[3] then
				return false
			end
		end

		return true
	end,
	getPartType = function (slot0)
		slot4 = RoomConfig.instance:getProductionLineConfig(RoomConfig.instance:getProductionPartConfig(slot0).productionLines[1])

		return slot4.logic, slot4.type
	end,
	getPartMaxLineLevel = function (slot0)
		for slot7, slot8 in ipairs(RoomConfig.instance:getProductionPartConfig(slot0).productionLines) do
			if 0 < (RoomProductionModel.instance:getLineMO(slot8) and slot9.level or 0) then
				slot2 = slot10
			end
		end

		return slot2
	end,
	getChangePartLineMO = function (slot0)
		for slot6, slot7 in ipairs(RoomConfig.instance:getProductionPartConfig(slot0).productionLines) do
			return RoomProductionModel.instance:getLineMO(slot7)
		end
	end,
	getFormulaRewardInfo = function (slot0)
		if not RoomConfig.instance:getFormulaConfig(slot0) then
			return nil
		end

		if not uv0.getFormulaItemParamList(slot1.produce)[1] then
			return
		end

		slot3.quantity = ItemModel.instance:getItemQuantity(slot3.type, slot3.id)

		return slot3
	end,
	getSkinLevel = function (slot0, slot1)
		if not RoomConfig.instance:getProductionPartConfig(slot0) then
			return 0
		end

		if not slot2.productionLines[1] then
			return 0
		end

		if not RoomConfig.instance:getProductionLineConfig(slot4) then
			return 0
		end

		slot6 = 0
		slot7 = nil

		for slot12, slot13 in ipairs(RoomConfig.instance:getProductionLineLevelConfigList(slot5.levelGroup)) do
			if slot1 < slot13.id then
				break
			end

			if not string.nilorempty(slot13.modulePart) and slot13.modulePart ~= slot7 then
				slot6 = slot6 + 1
				slot7 = slot13.modulePart
			end
		end

		return slot6
	end,
	getRoomLevelUpParams = function (slot0, slot1, slot2)
		slot4 = RoomConfig.instance:getRoomLevelConfig(slot0)
		slot5 = RoomConfig.instance:getRoomLevelConfig(slot1)

		if not slot2 then
			table.insert({}, {
				desc = luaLang("room_levelup_init_title"),
				currentDesc = string.format("Lv.%d", slot0),
				nextDesc = string.format("Lv.%d", slot1)
			})
		end

		slot6 = {}

		for slot10, slot11 in ipairs(lua_production_part.configList) do
			if uv0.hasUnlockLine(slot11.id, slot1) and not uv0.hasUnlockLine(slot12, slot0) then
				table.insert(slot6, string.format(luaLang("room_levelup_init_name1"), slot11.name))
			end
		end

		if #slot6 > 0 then
			if slot2 then
				-- Nothing
			else
				slot8.desc = string.format(luaLang("room_levelupresult_init_unlock"), slot7)
				slot8.currentDesc = tostring(0)
				slot8.nextDesc = tostring(1)
			end

			table.insert(slot3, {
				desc = string.format(luaLang("room_levelup_init_unlock"), uv0.combineNames(slot6, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2")))
			})
		end

		slot7 = {}
		slot8 = {}

		for slot12, slot13 in ipairs(lua_production_part.configList) do
			slot14 = slot13.id
			slot16 = uv0.getUnlockLineCount(slot14, slot1)

			if uv0.getUnlockLineCount(slot14, slot0) < 1 then
				slot15 = 1
			end

			if slot16 > slot15 and slot15 > 0 then
				slot7[slot15] = slot7[slot15] or {}

				if not slot7[slot15][slot16] then
					slot7[slot15][slot16] = {}

					table.insert(slot8, {
						curCount = slot15,
						nextCount = slot16
					})
				end

				table.insert(slot7[slot15][slot16], string.format(luaLang("room_levelup_init_name2"), slot13.name))
			end
		end

		if #slot8 > 0 then
			for slot12, slot13 in ipairs(slot8) do
				slot17 = uv0.combineNames(slot7[slot13.curCount][slot13.nextCount], luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
				slot18 = {}

				if slot2 then
					slot19 = {}

					for slot23 = slot14 + 1, slot15 do
						table.insert(slot19, string.format(luaLang("room_levelupresult_init_count_number"), slot23))
					end

					slot18.desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_count"), {
						slot17,
						uv0.combineNames(slot19, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))
					})
				else
					slot18.desc = string.format(luaLang("room_levelup_init_count"), slot17)
					slot18.currentDesc = tostring(slot14)
					slot18.nextDesc = tostring(slot15)
				end

				table.insert(slot3, slot18)
			end
		end

		slot9 = {}
		slot10 = {}
		slot11 = {}

		for slot15, slot16 in ipairs(lua_production_part.configList) do
			slot17 = slot16.id

			if uv0.getLineMaxLevel(slot17, slot1) > 0 and uv0.getLineMaxLevel(slot17, slot0) == 0 then
				slot18 = 1
			end

			if slot19 > slot18 and slot18 > 0 then
				if not slot9[slot19] then
					slot9[slot19] = {}

					table.insert(slot11, slot19)
				end

				if not slot9[slot19][slot18] then
					slot9[slot19][slot18] = {}

					table.insert(slot10, {
						curMaxLevel = slot18,
						nextMaxLevel = slot19
					})
				end

				table.insert(slot9[slot19][slot18], string.format(luaLang("room_levelup_init_name2"), slot16.name))
			end
		end

		if slot2 then
			if #slot11 > 0 then
				for slot15, slot16 in ipairs(slot11) do
					slot18 = {}

					for slot22, slot23 in pairs(slot9[slot16]) do
						tabletool.addValues(slot18, slot23)
					end

					table.insert(slot3, {
						desc = GameUtil.getSubPlaceholderLuaLang(luaLang("room_levelupresult_init_maxlevel"), {
							uv0.combineNames(slot18, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2")),
							slot16
						})
					})
				end
			end
		elseif #slot10 > 0 then
			for slot15, slot16 in ipairs(slot10) do
				slot17 = slot16.nextMaxLevel
				slot18 = slot16.curMaxLevel

				table.insert(slot3, {
					desc = string.format(luaLang("room_levelup_init_maxlevel"), uv0.combineNames(slot9[slot17][slot18], luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))),
					currentDesc = tostring(slot18),
					nextDesc = tostring(slot17)
				})
			end
		end

		if RoomMapBlockModel.instance:getMaxBlockCount(slot0) < RoomMapBlockModel.instance:getMaxBlockCount(slot1) then
			if slot2 then
				-- Nothing
			else
				slot14.desc = luaLang("room_levelup_init_block")
				slot14.currentDesc = tostring(slot12)
				slot14.nextDesc = tostring(slot13)
			end

			table.insert(slot3, {
				desc = string.format(luaLang("room_levelupresult_init_block"), slot13 - slot12)
			})
		end

		if slot4.characterLimit < slot5.characterLimit then
			if slot2 then
				-- Nothing
			else
				slot16.desc = luaLang("room_levelup_init_character")
				slot16.currentDesc = tostring(slot14)
				slot16.nextDesc = tostring(slot15)
			end

			table.insert(slot3, {
				desc = string.format(luaLang("room_levelupresult_init_character"), slot15 - slot14)
			})
		end

		if slot2 and slot1 and CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanOpen) == slot1 then
			table.insert(slot3, {
				desc = luaLang("room_levelupresult_init_layoutplan_open")
			})
		end

		return slot3
	end,
	combineNames = function (slot0, slot1, slot2)
		slot3 = ""

		for slot7, slot8 in ipairs(slot0) do
			if slot7 > 1 then
				slot3 = slot7 == #slot0 and slot3 .. slot2 or slot3 .. slot2 .. slot1
			end

			slot3 = slot3 .. slot8
		end

		return slot3
	end,
	getLineMaxLevel = function (slot0, slot1)
		slot2 = slot1 or RoomModel.instance:getRoomLevel()
		slot8 = 0

		if RoomConfig.instance:getProductionLineConfig(RoomConfig.instance:getProductionPartConfig(slot0).productionLines[1]) and RoomConfig.instance:getProductionLineLevelGroupIdConfig(slot6.levelGroup) then
			for slot12, slot13 in ipairs(slot7) do
				if slot13.needRoomLevel <= slot2 then
					slot8 = math.max(slot13.id, slot8)
				end
			end
		end

		return slot8
	end,
	getProductLineLevelUpParams = function (slot0, slot1, slot2, slot3)
		slot5 = RoomConfig.instance:getProductionLineConfig(slot0)

		if not slot3 then
			table.insert({}, {
				desc = luaLang("roomproductlinelevelup_level"),
				currentDesc = string.format("Lv.%d", slot1),
				nextDesc = string.format("Lv.%d", slot2)
			})
		end

		if slot5.logic == RoomProductLineEnum.ProductType.Change then
			for slot9 = 1, 4 do
				if uv0.getFormulaLevelUpCount(300 + slot9, slot2) == 1 then
					if slot3 then
						-- Nothing
					else
						slot12.desc = luaLang("room_levelup_line_change" .. slot9)
						slot12.currentDesc = tostring("0")
						slot12.nextDesc = tostring("1")
					end

					table.insert(slot4, {
						desc = luaLang("room_levelupresult_line_change" .. slot9)
					})
				end
			end

			for slot9 = 1, 4 do
				if uv0.getFormulaLevelUpCount(300 + slot9, slot2) > 1 then
					if slot3 then
						if slot11 > 2 then
							-- Nothing
						else
							slot12.desc = string.format(luaLang("room_levelupresult_line_formula" .. slot9), luaLang("room_levelup_line_formula_middle"))
						end
					else
						slot12.desc = luaLang("room_levelup_line_formula" .. slot9)

						if slot11 > 2 then
							slot12.currentDesc = luaLang("room_levelup_line_formula_middle")
							slot12.nextDesc = luaLang("room_levelup_line_formula_high")
						else
							slot12.currentDesc = luaLang("room_levelup_line_formula_low")
							slot12.nextDesc = luaLang("room_levelup_line_formula_middle")
						end
					end

					table.insert(slot4, {
						desc = string.format(luaLang("room_levelupresult_line_formula" .. slot9), luaLang("room_levelup_line_formula_high"))
					})
				end
			end
		elseif slot5.logic == RoomProductLineEnum.ProductType.Product then
			if uv0.getProductLineReserve(slot0, slot1) < uv0.getProductLineReserve(slot0, slot2) then
				if slot3 then
					-- Nothing
				else
					slot8.desc = luaLang("room_levelup_line_reserve")
					slot8.currentDesc = tostring(slot6)
					slot8.nextDesc = tostring(slot7)
				end

				table.insert(slot4, {
					desc = string.format(luaLang("room_levelupresult_line_reserve"), slot7)
				})
			end

			slot8, slot9 = uv0.getProductLineCostTimeReduceRate(slot0, slot1)
			slot10, slot11 = uv0.getProductLineCostTimeReduceRate(slot0, slot2)

			if slot8 < slot10 then
				if slot3 then
					-- Nothing
				else
					slot12.desc = luaLang("room_levelup_line_costtime")
					slot12.currentDesc = string.format("%d%%", math.floor((1 - slot8) * 100 + 0.5))
					slot12.nextDesc = string.format("%d%%", math.floor((1 - slot10) * 100 + 0.5))
				end

				table.insert(slot4, {
					desc = string.format(luaLang("room_levelupresult_line_costtime"), math.floor(slot11 / 60))
				})
			end

			if uv0.getProductLineProductionAddRate(slot0, slot1) < uv0.getProductLineProductionAddRate(slot0, slot2) then
				if slot3 then
					-- Nothing
				else
					slot14.desc = luaLang("room_levelup_line_product")
					slot14.currentDesc = string.format("%d%%", math.floor(slot12 * 100 + 0.5))
					slot14.nextDesc = string.format("%d%%", math.floor(slot13 * 100 + 0.5))
				end

				table.insert(slot4, {
					desc = string.format(luaLang("room_levelupresult_line_product"), math.floor((slot13 - 1) * 100 + 0.5))
				})
			end
		end

		return slot4
	end,
	getProductLineReserve = function (slot0, slot1)
		slot2 = RoomConfig.instance:getProductionLineConfig(slot0)
		slot3 = slot2.reserve

		if slot2.levelGroup > 0 and GameUtil.splitString2(RoomConfig.instance:getProductionLineLevelConfig(slot2.levelGroup, slot1).effect, true) then
			for slot9, slot10 in ipairs(slot5) do
				if slot10[1] == RoomBuildingEnum.EffectType.Reserve then
					slot3 = slot3 + slot10[2]
				end
			end
		end

		return slot3
	end,
	getProductLineCostTimeReduceRate = function (slot0, slot1)
		if slot1 <= 1 then
			return 0, 0
		end

		slot2 = RoomConfig.instance:getProductionLineConfig(slot0)
		slot3 = slot2.initFormula
		slot4 = RoomConfig.instance:getFormulaConfig(slot3)
		slot5 = slot3

		if slot2.levelGroup > 0 then
			for slot9 = slot1, 1, -1 do
				if not string.nilorempty(RoomConfig.instance:getProductionLineLevelConfig(slot2.levelGroup, slot1).changeFormulaId) then
					slot5 = tonumber(slot10.changeFormulaId)

					break
				end
			end
		end

		slot6 = RoomConfig.instance:getFormulaConfig(slot5)

		if slot4.costTime <= 0 then
			return 0, 0
		end

		return 1 - slot6.costTime / slot4.costTime, slot4.costTime - slot6.costTime
	end,
	getProductLineProductionAddRate = function (slot0, slot1)
		if slot1 <= 1 then
			return 1
		end

		slot2 = RoomConfig.instance:getProductionLineConfig(slot0)
		slot3 = slot2.initFormula
		slot4 = RoomConfig.instance:getFormulaConfig(slot3)
		slot5 = slot3

		if slot2.levelGroup > 0 then
			for slot9 = slot1, 1, -1 do
				if not string.nilorempty(RoomConfig.instance:getProductionLineLevelConfig(slot2.levelGroup, slot1).changeFormulaId) then
					slot5 = tonumber(slot10.changeFormulaId)

					break
				end
			end
		end

		slot7 = uv0.getFormulaItemParamList(RoomConfig.instance:getFormulaConfig(slot5).produce)[1]

		if uv0.getFormulaItemParamList(slot4.produce)[1].quantity <= 0 then
			return 1
		end

		return slot7.quantity / slot8.quantity
	end,
	getFormulaLevelUpCount = function (slot0, slot1)
		if not uv0._formulaLevelUpInfo then
			uv0._formulaLevelUpInfo = {}
			slot3 = {}

			for slot7 = 0, 4 do
				for slot11, slot12 in ipairs(lua_formula.configList) do
					if slot12.needProductionLevel == slot7 then
						if not slot2[slot12.showType] then
							slot2[slot13] = {}
						end

						if not slot2[slot13][slot7] then
							slot15 = slot3[slot13] and slot14 + 1 or 1
							slot3[slot13] = slot15
							slot2[slot13][slot7] = slot15
						end
					end
				end
			end
		end

		return slot2[slot0] and slot2[slot0][slot1] or 0
	end,
	getPartIdByLineId = function (slot0)
		for slot4, slot5 in ipairs(lua_production_part.configList) do
			for slot10, slot11 in ipairs(slot5.productionLines) do
				if slot11 == slot0 then
					return slot5.id
				end
			end
		end
	end,
	getFormulaItemParamList = function (slot0)
		if string.nilorempty(slot0) then
			return {}
		end

		for slot6, slot7 in ipairs(GameUtil.splitString2(slot0, true)) do
			table.insert(slot1, {
				type = slot7[1],
				id = slot7[2],
				quantity = slot7[3]
			})
		end

		return slot1
	end,
	getFormulaStrUID = function (slot0, slot1)
		return string.format("%s#%s", slot0, slot1)
	end,
	getFormulaConfig = function (slot0)
		if not RoomConfig.instance:getFormulaConfig(slot0) then
			logError("RoomProductionHelper:getFormulaConfig Error! config not found: " .. (slot0 or nil))
		end

		return slot1
	end,
	getCostCoinItemList = function (slot0)
		slot1 = {}

		if uv0.getFormulaConfig(slot0) then
			if string.nilorempty(slot2.costScore) then
				logWarn("RoomProductionHelper.getCostCoinItemList Warn, formulaConfig.costScore is empty")
			end

			slot1 = uv0.getFormulaItemParamList(slot2.costScore)
		end

		return slot1
	end,
	getCostMaterialItemList = function (slot0)
		slot1 = {}

		if uv0.getFormulaConfig(slot0) then
			if not string.nilorempty(slot2.costMaterial) then
				slot1 = uv0.getFormulaItemParamList(slot2.costMaterial)
			end
		end

		return slot1
	end,
	getCostMaterialFormulaList = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(uv0.getCostMaterialItemList(slot0)) do
			table.insert(slot1, RoomConfig.instance:getItemFormulaId(slot7.type, slot7.id))
		end

		return slot1
	end,
	getCostItemListWithFormulaId = function (slot0, slot1)
		slot2 = {}
		slot3 = uv0.getCostMaterialItemList(slot0)

		if slot1 then
			for slot8, slot9 in pairs(uv0.getCostCoinItemList(slot0)) do
				table.insert(slot3, slot9)
			end
		end

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot2, {
				formulaId = RoomConfig.instance:getItemFormulaId(slot8.type, slot8.id),
				type = slot8.type,
				id = slot8.id,
				quantity = slot8.quantity
			})
		end

		return slot2
	end,
	isEnoughCoin = function (slot0, slot1)
		slot2 = true

		if not slot1 or slot1 <= 0 then
			slot1 = 1
		end

		for slot7, slot8 in ipairs(uv0.getCostCoinItemList(slot0)) do
			if ItemModel.instance:getItemQuantity(slot8.type, slot8.id) < (slot8.quantity or 0) * slot1 then
				slot2 = false

				break
			end
		end

		return slot2
	end,
	isEnoughMaterial = function (slot0, slot1)
		slot2 = true

		if not slot1 or slot1 <= 0 then
			slot1 = 1
		end

		for slot7, slot8 in ipairs(uv0.getCostMaterialItemList(slot0)) do
			if ItemModel.instance:getItemQuantity(slot8.type, slot8.id) < slot8.quantity * slot1 then
				slot2 = false

				break
			end
		end

		return slot2
	end,
	getTopLevelFormulaStrId = function (slot0)
		slot1, slot2 = uv0.changeStrUID2FormulaIdAndTreeLevel(slot0)

		if slot1 and slot1 ~= 0 and slot2 then
			if slot2 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
				return slot0
			else
				return uv0.getFormulaStrUID(slot1, RoomFormulaModel.DEFAULT_TREE_LEVEL)
			end
		end
	end,
	getFormulaProduceItem = function (slot0, slot1)
		if slot1 or uv0.getFormulaConfig(slot0) then
			if uv0.getFormulaItemParamList(slot2.produce)[1] then
				return slot3[1]
			else
				logError("RoomProductionHelper.getFormulaProduceItem error, can't find produce")
			end
		end
	end,
	getFormulaNeedQuantity = function (slot0)
		if not RoomFormulaModel.instance:getFormulaMo(slot0) then
			return 0
		end

		if not uv0.getFormulaProduceItem(slot2:getFormulaId()) then
			return slot1
		end

		if slot2:isTreeFormula() then
			if RoomFormulaModel.instance:getFormulaMo(slot2:getParentStrId()) then
				slot8 = 0

				for slot14, slot15 in ipairs(uv0.getCostMaterialItemList(slot7:getFormulaId())) do
					if slot15.id == slot4.id then
						slot8 = slot15.quantity

						break
					end
				end

				slot1 = slot7:getFormulaCombineCount() * slot8
			end
		elseif JumpModel.instance:getRecordFarmItem() and slot6.quantity and slot6.id == slot4.id then
			slot1 = slot6.quantity
		end

		return slot1
	end,
	getNeedFormulaShowTypeAndFormulaStrId = function (slot0)
		if not JumpModel.instance:getRecordFarmItem() or not slot3.type or not slot3.id then
			return slot1, nil
		end

		if not RoomConfig.instance:getItemFormulaId(slot3.type, slot3.id) or slot4 == 0 then
			return slot1, slot2
		end

		if RoomConfig.instance:getFormulaConfig(slot4).showType and slot6 ~= 0 then
			if slot0.level < uv0.isFormulaShowTypeUnlock(slot6) then
				GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, slot0.config.name, slot7)
			else
				slot1 = slot6
			end
		end

		if slot1 then
			slot7, slot8, slot9, slot10 = uv0.isFormulaUnlock(slot4, slot0.level)

			if slot7 then
				slot2 = uv0.getFormulaStrUID(slot4, RoomFormulaModel.DEFAULT_TREE_LEVEL)
			elseif slot8 then
				GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, slot8)
			elseif slot9 then
				GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, slot0.config.name, slot9)
			elseif slot10 then
				GameFacade.showToast(ToastEnum.ClickRoomFormula)
			end
		end

		if not slot2 then
			slot1 = nil
		end

		return slot1, slot2
	end,
	getTotalCanCombineNum = function (slot0)
		slot1 = 1

		while uv0._canCombineQuantityTimeFormula(nil, slot0, slot1) do
			slot1 = slot1 * 2
		end

		slot2 = 0

		while slot1 >= slot2 do
			slot3 = math.floor(slot2 + (slot1 - slot2) / 2)

			if uv0._canCombineQuantityTimeFormula(nil, slot0, slot3) and not uv0._canCombineQuantityTimeFormula(nil, slot0, slot3 + 1) then
				return slot3
			elseif slot4 then
				slot2 = slot3 + 1
			else
				slot1 = slot3 - 1
			end
		end

		logError("RoomProductionHelper.getTotalCanCombineNum verify error, result:" .. slot1 .. " formulaId:" .. slot0)

		return 0
	end,
	getEasyCombineFormulaAndCostItemList = function (slot0, slot1)
		slot2 = {
			formulaIdList = {},
			itemTypeDic = {}
		}

		if not uv0.getFormulaProduceItem(slot0) then
			return false, slot2
		end

		table.insert(slot2.formulaIdList, {
			formulaId = slot0,
			count = slot1
		})

		return uv0._canCombineQuantityTimeFormula(slot2, slot0, slot1), slot2
	end,
	_canCombineQuantityTimeFormula = function (slot0, slot1, slot2, slot3)
		slot3 = slot3 or {}

		if #uv0.getCostItemListWithFormulaId(slot1, true) <= 0 then
			return false
		end

		slot5, slot6 = nil

		if slot0 then
			slot5 = slot0.itemTypeDic
			slot6 = slot0.formulaIdList
		end

		for slot10, slot11 in ipairs(slot4) do
			slot12 = slot11.id
			slot13 = slot11.type

			uv1(slot3, slot13, slot12)

			if ItemModel.instance:getItemQuantity(slot13, slot12) - slot3[slot13][slot12] < 0 then
				logError("RoomProductionHelper._canCombineQuantityTimeFormula error, remainOwnQuantity is negative:" .. slot15)

				slot15 = 0
			end

			slot16 = 0

			if slot15 - slot11.quantity * slot2 < 0 then
				if not slot11.formulaId or slot19 == 0 then
					return false
				end

				if not uv0._canCombineQuantityTimeFormula(slot0, slot11.formulaId, math.abs(slot18), slot3) then
					return false
				end

				if slot6 then
					table.insert(slot6, {
						formulaId = slot19,
						count = slot20
					})
				end

				slot16 = slot15
			else
				slot16 = slot17
			end

			uv1(slot5, slot13, slot12, slot16)
			uv1(slot3, slot13, slot12, slot16)
		end

		return true
	end,
	changeStrUID2FormulaIdAndTreeLevel = function (slot0)
		if not slot0 then
			logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel error, strId nil")

			return 0, RoomFormulaModel.DEFAULT_TREE_LEVEL
		end

		if not string.splitToNumber(slot0, "#")[1] or not slot3[2] then
			logError("RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel format error,id:" .. slot0 .. " must be formulaId#treeLevel")

			return slot1, slot2
		end

		return slot3[1], slot3[2]
	end,
	formatItemNum = function (slot0)
		return slot0 > 99 and "99+" or tostring(slot0)
	end
}
