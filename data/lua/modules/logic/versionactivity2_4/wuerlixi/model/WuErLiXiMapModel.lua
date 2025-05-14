module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapModel", package.seeall)

local var_0_0 = class("WuErLiXiMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._mapDict = {}
	arg_2_0._curMapId = 0
	arg_2_0._curSelectNode = {}
	arg_2_0._unlockElements = {}
end

function var_0_0._initUnlockElements(arg_3_0)
	local var_3_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, "")

	arg_3_0._unlockElements = string.splitToNumber(var_3_0, "#") or {}
end

function var_0_0.initMap(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or arg_4_0._curMapId

	if not arg_4_0._mapDict[arg_4_1] then
		arg_4_0._mapDict[arg_4_1] = WuErLiXiMapMo.New()
	end

	local var_4_0 = WuErLiXiConfig.instance:getMapCo(arg_4_1)

	arg_4_0._mapDict[arg_4_1]:init(var_4_0)
end

function var_0_0.resetMap(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or arg_5_0._curMapId

	arg_5_0:initMap(arg_5_1)
end

function var_0_0.getMap(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0._curMapId

	if not arg_6_0._mapDict[arg_6_1] then
		arg_6_0:initMap(arg_6_1)
	end

	return arg_6_0._mapDict[arg_6_1]
end

function var_0_0.setCurMapId(arg_7_0, arg_7_1)
	arg_7_0._curMapId = arg_7_1
end

function var_0_0.getCurMapId(arg_8_0)
	return arg_8_0._curMapId
end

function var_0_0.getMapLimitActUnits(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or arg_9_0._curMapId

	return arg_9_0._mapDict[arg_9_1].actUnitDict
end

function var_0_0.getMapNodes(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or arg_10_0._curMapId

	return arg_10_0._mapDict[arg_10_1].nodeDict
end

function var_0_0.getMapLineCount(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or arg_11_0._curMapId

	return arg_11_0._mapDict[arg_11_1].lineCount
end

function var_0_0.getMapRowCount(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or arg_12_0._curMapId

	return arg_12_0._mapDict[arg_12_1].rowCount
end

function var_0_0.setUnitDir(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:getNodeUnit()

	if not var_13_0 then
		return
	end

	local var_13_1 = arg_13_0:getMapNodes()

	if var_13_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_13_2 == WuErLiXiEnum.Dir.Up or arg_13_2 == WuErLiXiEnum.Dir.Down then
			if var_13_1[arg_13_1.y][arg_13_1.x - 1] then
				if var_13_1[arg_13_1.y][arg_13_1.x - 1]:getNodeUnit() then
					return
				end
			else
				return
			end

			if var_13_1[arg_13_1.y][arg_13_1.x + 1] then
				if var_13_1[arg_13_1.y][arg_13_1.x + 1]:getNodeUnit() then
					return
				end
			else
				return
			end
		else
			if var_13_1[arg_13_1.y - 1] then
				if var_13_1[arg_13_1.y - 1][arg_13_1.x]:getNodeUnit() then
					return
				end
			else
				return
			end

			if var_13_1[arg_13_1.y + 1] then
				if var_13_1[arg_13_1.y + 1][arg_13_1.x]:getNodeUnit() then
					return
				end
			else
				return
			end
		end
	end

	if var_13_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_13_3 == WuErLiXiEnum.Dir.Up or arg_13_3 == WuErLiXiEnum.Dir.Down then
			if var_13_1[arg_13_1.y][arg_13_1.x - 1] then
				var_13_1[arg_13_1.y][arg_13_1.x - 1]:clearUnit()
				arg_13_0:clearNodesRay(var_13_1[arg_13_1.y][arg_13_1.x - 1], var_13_1[arg_13_1.y][arg_13_1.x - 1].id, arg_13_1:getUnitSignalOutDir(), true)
			end

			if var_13_1[arg_13_1.y][arg_13_1.x + 1] then
				var_13_1[arg_13_1.y][arg_13_1.x + 1]:clearUnit()
				arg_13_0:clearNodesRay(var_13_1[arg_13_1.y][arg_13_1.x + 1], var_13_1[arg_13_1.y][arg_13_1.x + 1].id, arg_13_1:getUnitSignalOutDir(), true)
			end
		else
			if var_13_1[arg_13_1.y - 1] then
				var_13_1[arg_13_1.y - 1][arg_13_1.x]:clearUnit()
				arg_13_0:clearNodesRay(var_13_1[arg_13_1.y - 1][arg_13_1.x], var_13_1[arg_13_1.y - 1][arg_13_1.x].id, arg_13_1:getUnitSignalOutDir(), true)
			end

			if var_13_1[arg_13_1.y + 1] then
				var_13_1[arg_13_1.y + 1][arg_13_1.x]:clearUnit()
				arg_13_0:clearNodesRay(var_13_1[arg_13_1.y + 1][arg_13_1.x], var_13_1[arg_13_1.y + 1][arg_13_1.x].id, arg_13_1:getUnitSignalOutDir(), true)
			end
		end
	end

	local var_13_2 = arg_13_1:getNodeRay()

	if not var_13_2 then
		arg_13_1:setDir(arg_13_2)
		arg_13_0:setNodeUnitByUnitMo(arg_13_1, var_13_0)

		return
	end

	if var_13_0.unitType ~= WuErLiXiEnum.UnitType.Key then
		arg_13_0:clearNodesRay(arg_13_1, arg_13_1.id, arg_13_1:getUnitSignalOutDir(), true)
	end

	arg_13_1:setDir(arg_13_2, var_13_2.rayDir)
	arg_13_0:setNodeUnitByUnitMo(arg_13_1, var_13_0)
end

function var_0_0.clearNodeUnit(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:getNodeUnit()

	if not var_14_0 then
		return
	end

	local var_14_1
	local var_14_2 = arg_14_0:getMapNodes()

	for iter_14_0, iter_14_1 in pairs(var_14_2) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			local var_14_3 = iter_14_3:getNodeUnit()
			local var_14_4 = iter_14_3:getNodeRay()

			if var_14_3 and var_14_3.x == var_14_0.x and var_14_3.y == var_14_0.y then
				if var_14_3.unitType == WuErLiXiEnum.UnitType.Key and not arg_14_2 then
					arg_14_0:setSwitchActive(var_14_3.id, false)
				end

				arg_14_0:clearNodesRay(iter_14_3, iter_14_3.id, arg_14_1:getUnitSignalOutDir(), true)

				if var_14_4 then
					var_14_1 = var_14_4
				end
			end
		end
	end

	for iter_14_4, iter_14_5 in pairs(var_14_2) do
		for iter_14_6, iter_14_7 in pairs(iter_14_5) do
			local var_14_5 = iter_14_7:getNodeUnit()

			if var_14_5 and var_14_5.x == var_14_0.x and var_14_5.y == var_14_0.y then
				var_14_2[iter_14_7.y][iter_14_7.x]:clearUnit()
			end
		end
	end

	if var_14_1 then
		local var_14_6 = math.floor(var_14_1.rayId / 100)
		local var_14_7 = var_14_2[var_14_1.rayId % 100][var_14_6]

		arg_14_0:fillNodeRay(var_14_7, var_14_1.rayType, var_14_1.rayDir, true, var_14_1.rayParent)
	end
end

function var_0_0.setNodeUnitByUnitMo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getMapNodes()
	local var_15_1 = {}

	table.insert(var_15_1, arg_15_1)

	if arg_15_2.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_15_2.dir == WuErLiXiEnum.Dir.Up or arg_15_2.dir == WuErLiXiEnum.Dir.Down then
			if not var_15_0[arg_15_1.y][arg_15_1.x - 1] or not var_15_0[arg_15_1.y][arg_15_1.x + 1] then
				return
			end

			table.insert(var_15_1, var_15_0[arg_15_1.y][arg_15_1.x - 1])
			table.insert(var_15_1, var_15_0[arg_15_1.y][arg_15_1.x + 1])
		else
			if not var_15_0[arg_15_1.y - 1] or not var_15_0[arg_15_1.y + 1] then
				return
			end

			table.insert(var_15_1, var_15_0[arg_15_1.y - 1][arg_15_1.x])
			table.insert(var_15_1, var_15_0[arg_15_1.y + 1][arg_15_1.x])
		end
	end

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_2 = iter_15_1:getNodeRay()

		if var_15_2 then
			if arg_15_2.unitType == WuErLiXiEnum.UnitType.Key and not arg_15_3 then
				arg_15_0:setSwitchActive(arg_15_2.id, var_15_2.rayType == var_15_2.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			arg_15_0:clearNodesRay(iter_15_1, var_15_2.rayId, var_15_2.rayDir, false)
		end

		iter_15_1:setUnitByUnitMo(arg_15_2, arg_15_1.x, arg_15_1.y)
	end
end

function var_0_0.setNodeUnitByActUnitMo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getMapNodes()
	local var_16_1 = {}

	table.insert(var_16_1, arg_16_1)

	if arg_16_2.type == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_16_2.dir == WuErLiXiEnum.Dir.Up or arg_16_2.dir == WuErLiXiEnum.Dir.Down then
			if not var_16_0[arg_16_1.y][arg_16_1.x - 1] or not var_16_0[arg_16_1.y][arg_16_1.x + 1] then
				return
			end

			table.insert(var_16_1, var_16_0[arg_16_1.y][arg_16_1.x - 1])
			table.insert(var_16_1, var_16_0[arg_16_1.y][arg_16_1.x + 1])
		else
			if not var_16_0[arg_16_1.y - 1] or not var_16_0[arg_16_1.y + 1] then
				return
			end

			table.insert(var_16_1, var_16_0[arg_16_1.y - 1][arg_16_1.x])
			table.insert(var_16_1, var_16_0[arg_16_1.y + 1][arg_16_1.x])
		end
	end

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		local var_16_2 = iter_16_1:getNodeRay()

		if var_16_2 then
			if arg_16_2.type == WuErLiXiEnum.UnitType.Key then
				arg_16_0:setSwitchActive(arg_16_2.id, var_16_2.rayType == WuErLiXiEnum.RayType.SwitchSignal)
			end

			arg_16_0:clearNodesRay(iter_16_1, var_16_2.rayId, var_16_2.rayDir, false)
		end

		iter_16_1:setUnitByActUnitMo(arg_16_2, arg_16_1.x, arg_16_1.y)
	end
end

function var_0_0.setMapData(arg_17_0)
	local var_17_0 = arg_17_0:getMapNodes()
	local var_17_1 = arg_17_0:getMapLineCount()
	local var_17_2 = arg_17_0:getMapRowCount()

	for iter_17_0 = 1, var_17_2 do
		for iter_17_1 = 1, var_17_1 do
			local var_17_3 = var_17_0[iter_17_1][iter_17_0]:getNodeUnit()

			if var_17_3 then
				if var_17_3.unitType == WuErLiXiEnum.UnitType.SignalStart then
					arg_17_0:setMapSignalData(var_17_0[iter_17_1][iter_17_0], WuErLiXiEnum.RayType.NormalSignal)
				elseif var_17_3.unitType == WuErLiXiEnum.UnitType.KeyStart then
					arg_17_0:setMapSignalData(var_17_0[iter_17_1][iter_17_0], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end
end

function var_0_0.setMapSignalData(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1:getNodeUnit()

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0:getUnitSignalOutDir()

	if not var_18_1 then
		return
	end

	arg_18_0:setUnitActive(arg_18_1, true, arg_18_2, var_18_1)

	local var_18_2 = arg_18_0:getMapNodes()
	local var_18_3 = var_18_0:getUnitSignals(var_18_1)

	for iter_18_0, iter_18_1 in pairs(var_18_3) do
		arg_18_0:fillNodeRay(var_18_2[iter_18_1[2]][iter_18_1[1]], arg_18_2, var_18_0:getUnitSignalOutDir())
	end
end

function var_0_0.fillNodeRay(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = arg_19_0:getMapNodes()
	local var_19_1 = arg_19_0:getMapLineCount()
	local var_19_2 = arg_19_0:getMapRowCount()

	if arg_19_3 == WuErLiXiEnum.Dir.Up then
		if arg_19_1.y > 1 then
			for iter_19_0 = arg_19_1.y - 1, 1, -1 do
				if not var_19_0[iter_19_0][arg_19_1.x]:couldSetRay(arg_19_2) then
					return
				end

				local var_19_3 = var_19_0[iter_19_0][arg_19_1.x]:getNodeUnit()

				if var_19_3 then
					if var_19_3.unitType ~= WuErLiXiEnum.UnitType.Switch or not var_19_3:isUnitActive() then
						arg_19_0:setUnitActive(var_19_0[iter_19_0][arg_19_1.x], true, arg_19_2, arg_19_3)

						if var_19_0[iter_19_0][arg_19_1.x]:isUnitActive(arg_19_3) then
							var_19_0[iter_19_0][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
							var_19_0[iter_19_0][arg_19_1.x]:setUnitOutDirByRayDir(arg_19_3)

							local var_19_4 = var_19_3:getUnitSignals(arg_19_3)

							for iter_19_1, iter_19_2 in pairs(var_19_4) do
								arg_19_0:fillNodeRay(var_19_0[iter_19_0][iter_19_2[1]], arg_19_2, var_19_3:getUnitSignalOutDir(), false, arg_19_1.id)
							end

							if var_19_3.unitType == WuErLiXiEnum.UnitType.Key then
								arg_19_0:setSwitchActive(var_19_3.id, true)
							end
						end

						return
					elseif var_19_3.unitType == WuErLiXiEnum.UnitType.Switch then
						arg_19_0:setUnitActive(var_19_0[iter_19_0][arg_19_1.x], true, arg_19_2, arg_19_3)
					end
				end

				local var_19_5 = var_19_0[iter_19_0][arg_19_1.x]:getNodeRay()

				if not var_19_5 then
					var_19_0[iter_19_0][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				elseif arg_19_3 == WuErLiXiHelper.getOppositeDir(var_19_5.rayDir) then
					return
				elseif var_19_5.rayId == arg_19_1.id then
					var_19_0[iter_19_0][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				else
					local var_19_6 = arg_19_1.y - iter_19_0
					local var_19_7 = math.abs(arg_19_1.x + iter_19_0 - var_19_5.rayId % 100 - math.floor(var_19_5.rayId / 100))

					if ServerTime.now() - var_19_5.rayTime > 0.1 then
						return
					end

					if var_19_6 < var_19_7 then
						if arg_19_0:isRayParent(var_19_5.rayId, arg_19_1.id) then
							return
						end

						arg_19_0:clearNodesRay(var_19_0[iter_19_0][arg_19_1.x], var_19_5.rayId, var_19_5.rayDir, false)
						var_19_0[iter_19_0][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
						var_19_0[iter_19_0][arg_19_1.x]:setUnitOutDirByRayDir(arg_19_3)
					elseif var_19_6 == var_19_7 then
						arg_19_0:clearNodesRay(var_19_0[iter_19_0][arg_19_1.x], arg_19_1.id, var_19_5.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif arg_19_3 == WuErLiXiEnum.Dir.Down then
		if var_19_1 > arg_19_1.y then
			for iter_19_3 = arg_19_1.y + 1, var_19_1 do
				if not var_19_0[iter_19_3][arg_19_1.x]:couldSetRay(arg_19_2) then
					return
				end

				local var_19_8 = var_19_0[iter_19_3][arg_19_1.x]:getNodeUnit()

				if var_19_8 and (var_19_8.unitType ~= WuErLiXiEnum.UnitType.Switch or not var_19_8:isUnitActive()) then
					arg_19_0:setUnitActive(var_19_0[iter_19_3][arg_19_1.x], true, arg_19_2, arg_19_3)

					if var_19_0[iter_19_3][arg_19_1.x]:isUnitActive(arg_19_3) then
						var_19_0[iter_19_3][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
						var_19_0[iter_19_3][arg_19_1.x]:setUnitOutDirByRayDir(arg_19_3)

						local var_19_9 = var_19_8:getUnitSignals(arg_19_3)

						for iter_19_4, iter_19_5 in pairs(var_19_9) do
							arg_19_0:fillNodeRay(var_19_0[iter_19_3][iter_19_5[1]], arg_19_2, var_19_8:getUnitSignalOutDir(), false, arg_19_1.id)
						end

						if var_19_8.unitType == WuErLiXiEnum.UnitType.Key then
							arg_19_0:setSwitchActive(var_19_8.id, true)
						end
					end

					return
				end

				local var_19_10 = var_19_0[iter_19_3][arg_19_1.x]:getNodeRay()

				if not var_19_10 then
					var_19_0[iter_19_3][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				elseif arg_19_3 == WuErLiXiHelper.getOppositeDir(var_19_10.rayDir) then
					return
				elseif var_19_10.rayId == arg_19_1.id then
					var_19_0[iter_19_3][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				else
					local var_19_11 = math.abs(arg_19_1.y - iter_19_3)
					local var_19_12 = math.abs(arg_19_1.x + iter_19_3 - var_19_10.rayId % 100 - math.floor(var_19_10.rayId / 100))

					if ServerTime.now() - var_19_10.rayTime > 0.1 then
						return
					end

					if var_19_11 < var_19_12 then
						if arg_19_0:isRayParent(var_19_10.rayId, arg_19_1.id) then
							return
						end

						arg_19_0:clearNodesRay(var_19_0[iter_19_3][arg_19_1.x], var_19_10.rayId, var_19_10.rayDir, false)
						var_19_0[iter_19_3][arg_19_1.x]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
						var_19_0[iter_19_3][arg_19_1.x]:setUnitOutDirByRayDir(arg_19_3)
					elseif var_19_11 == var_19_12 then
						arg_19_0:clearNodesRay(var_19_0[iter_19_3][arg_19_1.x], arg_19_1.id, var_19_10.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif arg_19_3 == WuErLiXiEnum.Dir.Left then
		if arg_19_1.x > 1 then
			for iter_19_6 = arg_19_1.x - 1, 1, -1 do
				if not var_19_0[arg_19_1.y][iter_19_6]:couldSetRay(arg_19_2) then
					return
				end

				local var_19_13 = var_19_0[arg_19_1.y][iter_19_6]:getNodeUnit()

				if var_19_13 and (var_19_13.unitType ~= WuErLiXiEnum.UnitType.Switch or not var_19_13:isUnitActive()) then
					arg_19_0:setUnitActive(var_19_0[arg_19_1.y][iter_19_6], true, arg_19_2, arg_19_3)

					if var_19_0[arg_19_1.y][iter_19_6]:isUnitActive(arg_19_3) then
						var_19_0[arg_19_1.y][iter_19_6]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
						var_19_0[arg_19_1.y][iter_19_6]:setUnitOutDirByRayDir(arg_19_3)

						local var_19_14 = var_19_13:getUnitSignals(arg_19_3)

						for iter_19_7, iter_19_8 in pairs(var_19_14) do
							arg_19_0:fillNodeRay(var_19_0[iter_19_8[2]][iter_19_6], arg_19_2, var_19_13:getUnitSignalOutDir(), false, arg_19_1.id)
						end

						if var_19_13.unitType == WuErLiXiEnum.UnitType.Key then
							arg_19_0:setSwitchActive(var_19_13.id, true)
						end

						return
					end

					return
				end

				local var_19_15 = var_19_0[arg_19_1.y][iter_19_6]:getNodeRay()

				if not var_19_15 then
					var_19_0[arg_19_1.y][iter_19_6]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				elseif arg_19_3 == WuErLiXiHelper.getOppositeDir(var_19_15.rayDir) then
					return
				elseif var_19_15.rayId == arg_19_1.id then
					var_19_0[arg_19_1.y][iter_19_6]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
				else
					local var_19_16 = math.abs(arg_19_1.x - iter_19_6)
					local var_19_17 = math.abs(iter_19_6 + arg_19_1.y - var_19_15.rayId % 100 - math.floor(var_19_15.rayId / 100))

					if ServerTime.now() - var_19_15.rayTime > 0.1 then
						return
					end

					if var_19_16 < var_19_17 then
						if arg_19_0._curMapId == 105 and arg_19_1.id == 902 and var_19_15.rayId == 409 then
							return
						end

						if arg_19_0:isRayParent(var_19_15.rayId, arg_19_1.id) then
							return
						end

						arg_19_0:clearNodesRay(var_19_0[arg_19_1.y][iter_19_6], var_19_15.rayId, var_19_15.rayDir, false)
						var_19_0[arg_19_1.y][iter_19_6]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
						var_19_0[arg_19_1.y][iter_19_6]:setUnitOutDirByRayDir(arg_19_3)
					elseif var_19_16 == var_19_17 then
						arg_19_0:clearNodesRay(var_19_0[arg_19_1.y][iter_19_6], arg_19_1.id, var_19_15.rayDir, false)

						return
					else
						return
					end
				end
			end
		end
	elseif arg_19_3 == WuErLiXiEnum.Dir.Right and var_19_2 > arg_19_1.x then
		for iter_19_9 = arg_19_1.x + 1, var_19_2 do
			if not var_19_0[arg_19_1.y][iter_19_9]:couldSetRay(arg_19_2) then
				return
			end

			local var_19_18 = var_19_0[arg_19_1.y][iter_19_9]:getNodeUnit()

			if var_19_18 and (var_19_18.unitType ~= WuErLiXiEnum.UnitType.Switch or not var_19_18:isUnitActive()) then
				arg_19_0:setUnitActive(var_19_0[arg_19_1.y][iter_19_9], true, arg_19_2, arg_19_3)

				if var_19_0[arg_19_1.y][iter_19_9]:isUnitActive(arg_19_3) then
					var_19_0[arg_19_1.y][iter_19_9]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
					var_19_0[arg_19_1.y][iter_19_9]:setUnitOutDirByRayDir(arg_19_3)

					local var_19_19 = var_19_18:getUnitSignals(arg_19_3)

					for iter_19_10, iter_19_11 in pairs(var_19_19) do
						arg_19_0:fillNodeRay(var_19_0[iter_19_11[2]][iter_19_9], arg_19_2, var_19_18:getUnitSignalOutDir(), false, arg_19_1.id)
					end

					if var_19_18.unitType == WuErLiXiEnum.UnitType.Key then
						arg_19_0:setSwitchActive(var_19_18.id, true)
					end
				end

				return
			end

			local var_19_20 = var_19_0[arg_19_1.y][iter_19_9]:getNodeRay()

			if not var_19_20 then
				var_19_0[arg_19_1.y][iter_19_9]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
			elseif arg_19_3 == WuErLiXiHelper.getOppositeDir(var_19_20.rayDir) then
				return
			elseif var_19_20.rayId == arg_19_1.id then
				var_19_0[arg_19_1.y][iter_19_9]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
			else
				local var_19_21 = math.abs(arg_19_1.x - iter_19_9)
				local var_19_22 = math.abs(iter_19_9 + arg_19_1.y - var_19_20.rayId % 100 - math.floor(var_19_20.rayId / 100))

				if ServerTime.now() - var_19_20.rayTime > 0.1 then
					return
				end

				if var_19_21 < var_19_22 then
					if arg_19_0:isRayParent(var_19_20.rayId, arg_19_1.id) then
						return
					end

					arg_19_0:clearNodesRay(var_19_0[arg_19_1.y][iter_19_9], var_19_20.rayId, var_19_20.rayDir, false)
					var_19_0[arg_19_1.y][iter_19_9]:setNodeRay(arg_19_1.id, arg_19_2, arg_19_3, arg_19_5)
					var_19_0[arg_19_1.y][iter_19_9]:setUnitOutDirByRayDir(arg_19_3)
				elseif var_19_21 == var_19_22 then
					arg_19_0:clearNodesRay(var_19_0[arg_19_1.y][iter_19_9], arg_19_1.id, var_19_20.rayDir, false)

					return
				else
					return
				end
			end
		end
	end
end

function var_0_0.isRayParent(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getMapNodes()
	local var_20_1 = math.floor(arg_20_2 / 100)
	local var_20_2 = var_20_0[arg_20_2 % 100][var_20_1]:getNodeUnit()

	if not var_20_2 then
		return false
	end

	local var_20_3 = var_20_0[var_20_2.y][var_20_2.x]:getNodeRay()

	if not var_20_3 then
		return false
	end

	if var_20_3.rayParent == arg_20_1 then
		return true
	end

	if not var_20_3.rayParent or var_20_3.rayParent <= 0 then
		return false
	end

	local var_20_4 = math.floor(var_20_3.rayParent / 100)
	local var_20_5 = var_20_0[var_20_3.rayParent % 100][var_20_4]:getNodeRay()

	if not var_20_5 then
		return false
	end

	return arg_20_0:isRayParent(var_20_5.rayParent, var_20_3.rayParent)
end

function var_0_0.hasBlockRayUnit(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_1.x == arg_21_2.x and arg_21_1.y == arg_21_2.y then
		return false
	end

	if arg_21_2:getNodeUnit() then
		return false
	end

	local var_21_0 = arg_21_0:getMapNodes()

	if arg_21_4 == WuErLiXiEnum.Dir.Up then
		if arg_21_1.x ~= arg_21_2.x then
			return false
		end

		if arg_21_2.y >= arg_21_1.y then
			return false
		end

		for iter_21_0 = arg_21_1.y, arg_21_2.y + 1, -1 do
			local var_21_1 = var_21_0[iter_21_0][arg_21_1.x]:getNodeUnit()

			if var_21_1 and (var_21_1.unitType ~= WuErLiXiEnum.UnitType.Switch or arg_21_3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif arg_21_4 == WuErLiXiEnum.Dir.Down then
		if arg_21_1.x ~= arg_21_2.x then
			return false
		end

		if arg_21_2.y <= arg_21_1.y then
			return false
		end

		for iter_21_1 = arg_21_1.y, arg_21_2.y - 1 do
			local var_21_2 = var_21_0[iter_21_1][arg_21_1.x]:getNodeUnit()

			if var_21_2 and (var_21_2.unitType ~= WuErLiXiEnum.UnitType.Switch or arg_21_3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif arg_21_4 == WuErLiXiEnum.Dir.Left then
		if arg_21_1.y ~= arg_21_2.y then
			return false
		end

		if arg_21_2.x >= arg_21_1.x then
			return false
		end

		for iter_21_2 = arg_21_1.x, arg_21_2.x + 1, -1 do
			local var_21_3 = var_21_0[arg_21_1.y][iter_21_2]:getNodeUnit()

			if var_21_3 and (var_21_3.unitType ~= WuErLiXiEnum.UnitType.Switch or arg_21_3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	elseif arg_21_4 == WuErLiXiEnum.Dir.Right then
		if arg_21_1.y ~= arg_21_2.y then
			return false
		end

		if arg_21_2.x <= arg_21_1.x then
			return false
		end

		for iter_21_3 = arg_21_1.x, arg_21_2.x - 1 do
			local var_21_4 = var_21_0[arg_21_1.y][iter_21_3]:getNodeUnit()

			if var_21_4 and (var_21_4.unitType ~= WuErLiXiEnum.UnitType.Switch or arg_21_3 ~= WuErLiXiEnum.RayType.SwitchSignal) then
				return true
			end
		end
	end

	return false
end

function var_0_0.setUnitActive(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_1:getNodeUnit()

	if not var_22_0 then
		return
	end

	local var_22_1 = arg_22_1:getNodeRay()

	if arg_22_2 and var_22_1 then
		return
	end

	local var_22_2 = arg_22_0:getMapNodes()

	arg_22_1:setUnitActive(arg_22_2, arg_22_3, arg_22_4)

	if var_22_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if var_22_0.dir == WuErLiXiEnum.Dir.Up or var_22_0.dir == WuErLiXiEnum.Dir.Down then
			if var_22_2[arg_22_1.y][arg_22_1.x - 1] then
				var_22_2[arg_22_1.y][arg_22_1.x - 1]:setUnitActive(arg_22_1:isUnitActive())
			end

			if var_22_2[arg_22_1.y][arg_22_1.x + 1] then
				var_22_2[arg_22_1.y][arg_22_1.x + 1]:setUnitActive(arg_22_1:isUnitActive())
			end
		else
			if var_22_2[arg_22_1.y - 1] then
				var_22_2[arg_22_1.y - 1][arg_22_1.x]:setUnitActive(arg_22_1:isUnitActive())
			end

			if var_22_2[arg_22_1.y + 1] then
				var_22_2[arg_22_1.y + 1][arg_22_1.x]:setUnitActive(arg_22_1:isUnitActive())
			end
		end
	end
end

function var_0_0.setSwitchActive(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getMapNodes()

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		for iter_23_2, iter_23_3 in pairs(iter_23_1) do
			local var_23_1 = iter_23_3:getNodeUnit()

			if var_23_1 and var_23_1.id == arg_23_1 and var_23_1.unitType == WuErLiXiEnum.UnitType.Switch then
				if var_23_1:isUnitActive() == arg_23_2 then
					return
				end

				var_23_1:setUnitActive(arg_23_2)

				if arg_23_2 then
					if var_23_0[iter_23_3.y + 1] and var_23_0[iter_23_3.y + 1][iter_23_3.x] then
						local var_23_2 = var_23_0[iter_23_3.y + 1][iter_23_3.x]:getNodeRay()

						if var_23_2 and var_23_2.rayDir == WuErLiXiEnum.Dir.Up then
							local var_23_3 = math.floor(var_23_2.rayId / 100)
							local var_23_4 = math.floor(var_23_2.rayId % 100)

							arg_23_0:fillNodeRay(var_23_0[var_23_4][var_23_3], var_23_2.rayType, var_23_2.rayDir, true, var_23_2.rayParent)
						end
					end

					if var_23_0[iter_23_3.y - 1] and var_23_0[iter_23_3.y - 1][iter_23_3.x] then
						local var_23_5 = var_23_0[iter_23_3.y - 1][iter_23_3.x]:getNodeRay()

						if var_23_5 and var_23_5.rayDir == WuErLiXiEnum.Dir.Down then
							local var_23_6 = math.floor(var_23_5.rayId / 100)
							local var_23_7 = math.floor(var_23_5.rayId % 100)

							arg_23_0:fillNodeRay(var_23_0[var_23_7][var_23_6], var_23_5.rayType, var_23_5.rayDir, true, var_23_5.rayParent)
						end
					end

					if var_23_0[iter_23_3.y][iter_23_3.x + 1] then
						local var_23_8 = var_23_0[iter_23_3.y][iter_23_3.x + 1]:getNodeRay()

						if var_23_8 and var_23_8.rayDir == WuErLiXiEnum.Dir.Left then
							local var_23_9 = math.floor(var_23_8.rayId / 100)
							local var_23_10 = math.floor(var_23_8.rayId % 100)

							arg_23_0:fillNodeRay(var_23_0[var_23_10][var_23_9], var_23_8.rayType, var_23_8.rayDir, true, var_23_8.rayParent)
						end
					end

					if var_23_0[iter_23_3.y][iter_23_3.x - 1] then
						local var_23_11 = var_23_0[iter_23_3.y][iter_23_3.x - 1]:getNodeRay()

						if var_23_11 and var_23_11.rayDir == WuErLiXiEnum.Dir.Right then
							local var_23_12 = math.floor(var_23_11.rayId / 100)
							local var_23_13 = math.floor(var_23_11.rayId % 100)

							arg_23_0:fillNodeRay(var_23_0[var_23_13][var_23_12], var_23_11.rayType, var_23_11.rayDir, true, var_23_11.rayParent)
						end
					end
				else
					local var_23_14 = iter_23_3:getNodeRay()

					if var_23_14 then
						arg_23_0:clearNodesRay(iter_23_3, var_23_14.rayId, var_23_14.rayDir, false)
					end
				end
			end
		end
	end
end

function var_0_0.clearNodesRay(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0:getMapNodes()
	local var_24_1 = arg_24_0:getMapLineCount()
	local var_24_2 = arg_24_0:getMapRowCount()
	local var_24_3 = arg_24_1:getNodeRay()
	local var_24_4 = arg_24_4 and 1 or 0

	if arg_24_3 == WuErLiXiEnum.Dir.Up then
		if arg_24_1.y - var_24_4 >= 1 then
			for iter_24_0 = arg_24_1.y - var_24_4, 1, -1 do
				local var_24_5 = var_24_0[iter_24_0][arg_24_1.x]:getNodeUnit()
				local var_24_6 = var_24_0[iter_24_0][arg_24_1.x]:getNodeRay()

				if var_24_5 then
					if var_24_5.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						var_24_0[iter_24_0][arg_24_1.x]:clearNodeRay(arg_24_2)
						arg_24_0:setUnitActive(var_24_0[iter_24_0][arg_24_1.x], false)

						return
					end

					if var_24_3 then
						if var_24_3.rayType == WuErLiXiEnum.RayType.SwitchSignal and (var_24_5.unitType == WuErLiXiEnum.UnitType.Switch or var_24_5.unitType == WuErLiXiEnum.UnitType.Key) then
							arg_24_0:setUnitActive(var_24_0[iter_24_0][arg_24_1.x], false)
							arg_24_0:setSwitchActive(var_24_5.id, false)
						end
					elseif var_24_5.unitType == WuErLiXiEnum.UnitType.Switch or var_24_5.unitType == WuErLiXiEnum.UnitType.Key then
						arg_24_0:setUnitActive(var_24_0[iter_24_0][arg_24_1.x], false)
						arg_24_0:setSwitchActive(var_24_5.id, false)
					end

					if var_24_6 and var_24_6.rayId == arg_24_2 then
						local var_24_7 = var_24_5:getUnitSignals(arg_24_3)

						for iter_24_1, iter_24_2 in pairs(var_24_7) do
							arg_24_0:clearNodesRay(var_24_0[iter_24_0][iter_24_2[1]], var_24_0[iter_24_0][iter_24_2[1]].id, var_24_5:getUnitSignalOutDir(), true)
						end
					end
				end

				var_24_0[iter_24_0][arg_24_1.x]:clearNodeRay(arg_24_2)
			end
		end
	elseif arg_24_3 == WuErLiXiEnum.Dir.Down then
		if var_24_1 >= arg_24_1.y + var_24_4 then
			for iter_24_3 = arg_24_1.y + var_24_4, var_24_1 do
				local var_24_8 = var_24_0[iter_24_3][arg_24_1.x]:getNodeUnit()
				local var_24_9 = var_24_0[iter_24_3][arg_24_1.x]:getNodeRay()

				if var_24_8 then
					if var_24_8.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						var_24_0[iter_24_3][arg_24_1.x]:clearNodeRay(arg_24_2)
						arg_24_0:setUnitActive(var_24_0[iter_24_3][arg_24_1.x], false)

						return
					end

					if var_24_3 then
						if var_24_3.rayType == WuErLiXiEnum.RayType.SwitchSignal and (var_24_8.unitType == WuErLiXiEnum.UnitType.Switch or var_24_8.unitType == WuErLiXiEnum.UnitType.Key) then
							arg_24_0:setUnitActive(var_24_0[iter_24_3][arg_24_1.x], false)
							arg_24_0:setSwitchActive(var_24_8.id, false)
						end
					elseif var_24_8.unitType == WuErLiXiEnum.UnitType.Switch or var_24_8.unitType == WuErLiXiEnum.UnitType.Key then
						arg_24_0:setUnitActive(var_24_0[iter_24_3][arg_24_1.x], false)
						arg_24_0:setSwitchActive(var_24_8.id, false)
					end

					if var_24_9 and var_24_9.rayId == arg_24_2 then
						local var_24_10 = var_24_8:getUnitSignals(arg_24_3)

						for iter_24_4, iter_24_5 in pairs(var_24_10) do
							arg_24_0:clearNodesRay(var_24_0[iter_24_3][iter_24_5[1]], var_24_0[iter_24_3][iter_24_5[1]].id, var_24_8:getUnitSignalOutDir(), true)
						end
					end
				end

				var_24_0[iter_24_3][arg_24_1.x]:clearNodeRay(arg_24_2)
			end
		end
	elseif arg_24_3 == WuErLiXiEnum.Dir.Left then
		if arg_24_1.x - var_24_4 >= 1 then
			for iter_24_6 = arg_24_1.x - var_24_4, 1, -1 do
				local var_24_11 = var_24_0[arg_24_1.y][iter_24_6]:getNodeUnit()
				local var_24_12 = var_24_0[arg_24_1.y][iter_24_6]:getNodeRay()

				if var_24_11 then
					if var_24_11.unitType == WuErLiXiEnum.UnitType.SignalEnd then
						var_24_0[arg_24_1.y][iter_24_6]:clearNodeRay(arg_24_2)
						arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_6], false)

						return
					end

					if var_24_3 then
						if var_24_3.rayType == WuErLiXiEnum.RayType.SwitchSignal and (var_24_11.unitType == WuErLiXiEnum.UnitType.Switch or var_24_11.unitType == WuErLiXiEnum.UnitType.Key) then
							arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_6], false)
							arg_24_0:setSwitchActive(var_24_11.id, false)
						end
					elseif var_24_11.unitType == WuErLiXiEnum.UnitType.Switch or var_24_11.unitType == WuErLiXiEnum.UnitType.Key then
						arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_6], false)
						arg_24_0:setSwitchActive(var_24_11.id, false)
					end

					if var_24_12 and var_24_12.rayId == arg_24_2 then
						local var_24_13 = var_24_11:getUnitSignals(arg_24_3)

						for iter_24_7, iter_24_8 in pairs(var_24_13) do
							arg_24_0:clearNodesRay(var_24_0[iter_24_8[2]][iter_24_6], var_24_0[iter_24_8[2]][iter_24_6].id, var_24_11:getUnitSignalOutDir(), true)
						end
					end
				end

				var_24_0[arg_24_1.y][iter_24_6]:clearNodeRay(arg_24_2)
			end
		end
	elseif arg_24_3 == WuErLiXiEnum.Dir.Right and var_24_2 >= arg_24_1.x + var_24_4 then
		for iter_24_9 = arg_24_1.x + var_24_4, var_24_2 do
			local var_24_14 = var_24_0[arg_24_1.y][iter_24_9]:getNodeUnit()
			local var_24_15 = var_24_0[arg_24_1.y][iter_24_9]:getNodeRay()

			if var_24_14 then
				if var_24_14.unitType == WuErLiXiEnum.UnitType.SignalEnd then
					var_24_0[arg_24_1.y][iter_24_9]:clearNodeRay(arg_24_2)
					arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_9], false)

					return
				end

				if var_24_3 then
					if var_24_3.rayType == WuErLiXiEnum.RayType.SwitchSignal and (var_24_14.unitType == WuErLiXiEnum.UnitType.Switch or var_24_14.unitType == WuErLiXiEnum.UnitType.Key) then
						arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_9], false)
						arg_24_0:setSwitchActive(var_24_14.id, false)
					end
				elseif var_24_14.unitType == WuErLiXiEnum.UnitType.Switch or var_24_14.unitType == WuErLiXiEnum.UnitType.Key then
					arg_24_0:setUnitActive(var_24_0[arg_24_1.y][iter_24_9], false)
					arg_24_0:setSwitchActive(var_24_14.id, false)
				end

				if var_24_15 and var_24_15.rayId == arg_24_2 then
					local var_24_16 = var_24_14:getUnitSignals(arg_24_3)

					for iter_24_10, iter_24_11 in pairs(var_24_16) do
						arg_24_0:clearNodesRay(var_24_0[iter_24_11[2]][iter_24_9], var_24_0[iter_24_11[2]][iter_24_9].id, var_24_14:getUnitSignalOutDir(), true)
					end
				end
			end

			var_24_0[arg_24_1.y][iter_24_9]:clearNodeRay(arg_24_2)
		end
	end
end

function var_0_0.getMapRays(arg_25_0, arg_25_1)
	arg_25_0._signalDict = {}

	local var_25_0 = arg_25_0:getMapNodes(arg_25_1)
	local var_25_1 = arg_25_0:getMapLineCount(arg_25_1)
	local var_25_2 = arg_25_0:getMapRowCount(arg_25_1)

	local function var_25_3(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = arg_26_0:getNodeUnit()

		if not var_26_0 then
			return
		end

		local var_26_1 = arg_26_0:getUnitSignalOutDir()

		if not var_26_1 then
			return
		end

		if var_26_1 == WuErLiXiEnum.Dir.Up then
			local var_26_2 = var_26_0:getUnitSignals(arg_26_2)

			for iter_26_0, iter_26_1 in pairs(var_26_2) do
				if iter_26_1[2] > 1 then
					for iter_26_2 = iter_26_1[2] - 1, 1, -1 do
						local var_26_3 = var_25_0[iter_26_1[2]][iter_26_1[1]].id
						local var_26_4 = var_25_0[iter_26_2][iter_26_1[1]]:getNodeUnit()

						if var_26_4 then
							if #var_26_4:getUnitSignals(var_26_0:getUnitSignalOutDir()) > 0 then
								local var_26_5 = iter_26_1[1] .. "_" .. iter_26_2

								if arg_25_0._signalDict[var_26_5] then
									arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[iter_26_2 + 1][iter_26_1[1]])

									break
								end

								arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[iter_26_2][iter_26_1[1]])
								var_25_3(var_25_0[iter_26_2][iter_26_1[1]], arg_26_1, var_26_1)

								break
							elseif var_26_4:isUnitActive(var_26_0:getUnitSignalOutDir()) then
								if not var_26_4:isIgnoreSignal() then
									arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[iter_26_2][iter_26_1[1]])

									break
								end
							else
								arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[iter_26_2 + 1][iter_26_1[1]])

								break
							end
						end

						local var_26_6 = var_25_0[iter_26_2][iter_26_1[1]]:getNodeRay()

						if not var_26_6 or var_26_6.rayId ~= var_26_3 or var_26_6.rayType ~= arg_26_1 then
							arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[iter_26_2 + 1][iter_26_1[1]])

							break
						end

						if iter_26_2 == 1 then
							arg_25_0:_addRayDict(var_26_3, arg_26_1, var_26_1, var_25_0[iter_26_1[2]][iter_26_1[1]], var_25_0[1][iter_26_1[1]])
						end
					end
				end
			end
		elseif var_26_0.outDir == WuErLiXiEnum.Dir.Down then
			local var_26_7 = var_26_0:getUnitSignals(arg_26_2)

			for iter_26_3, iter_26_4 in pairs(var_26_7) do
				if iter_26_4[2] < var_25_1 then
					for iter_26_5 = iter_26_4[2] + 1, var_25_1 do
						local var_26_8 = var_25_0[iter_26_4[2]][iter_26_4[1]].id
						local var_26_9 = var_25_0[iter_26_5][iter_26_4[1]]:getNodeUnit()

						if var_26_9 then
							if #var_26_9:getUnitSignals(var_26_0:getUnitSignalOutDir()) > 0 then
								local var_26_10 = iter_26_4[1] .. "_" .. iter_26_5

								if arg_25_0._signalDict[var_26_10] then
									arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[iter_26_5 - 1][iter_26_4[1]])

									break
								end

								arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[iter_26_5][iter_26_4[1]])
								var_25_3(var_25_0[iter_26_5][iter_26_4[1]], arg_26_1, var_26_1)

								break
							elseif var_26_9:isUnitActive(var_26_0:getUnitSignalOutDir()) then
								if not var_26_9:isIgnoreSignal() then
									arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[iter_26_5][iter_26_4[1]])

									break
								end
							else
								arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[iter_26_5 - 1][iter_26_4[1]])

								break
							end
						end

						local var_26_11 = var_25_0[iter_26_5][iter_26_4[1]]:getNodeRay()

						if not var_26_11 or var_26_11.rayId ~= var_26_8 or var_26_11.rayType ~= arg_26_1 then
							arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[iter_26_5 - 1][iter_26_4[1]])

							break
						end

						if iter_26_5 == var_25_1 then
							arg_25_0:_addRayDict(var_26_8, arg_26_1, var_26_1, var_25_0[iter_26_4[2]][iter_26_4[1]], var_25_0[var_25_1][iter_26_4[1]])
						end
					end
				end
			end
		elseif var_26_0.outDir == WuErLiXiEnum.Dir.Left then
			local var_26_12 = var_26_0:getUnitSignals(arg_26_2)

			for iter_26_6, iter_26_7 in pairs(var_26_12) do
				if iter_26_7[1] > 1 then
					for iter_26_8 = iter_26_7[1] - 1, 1, -1 do
						local var_26_13 = var_25_0[iter_26_7[2]][iter_26_7[1]].id
						local var_26_14 = var_25_0[iter_26_7[2]][iter_26_8]:getNodeUnit()

						if var_26_14 then
							if #var_26_14:getUnitSignals(var_26_0:getUnitSignalOutDir()) > 0 then
								local var_26_15 = iter_26_8 .. "_" .. iter_26_7[2]

								if arg_25_0._signalDict[var_26_15] then
									arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][iter_26_8 + 1])

									break
								end

								arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][iter_26_8])
								var_25_3(var_25_0[iter_26_7[2]][iter_26_8], arg_26_1, var_26_1)

								break
							elseif var_26_14:isUnitActive(var_26_0:getUnitSignalOutDir()) then
								if not var_26_14:isIgnoreSignal() then
									arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][iter_26_8])

									break
								end
							else
								arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][iter_26_8 + 1])

								break
							end
						end

						local var_26_16 = var_25_0[iter_26_7[2]][iter_26_8]:getNodeRay()

						if not var_26_16 or var_26_16.rayId ~= var_26_13 or var_26_16.rayType ~= arg_26_1 then
							arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][iter_26_8 + 1])

							break
						end

						if iter_26_8 == 1 then
							arg_25_0:_addRayDict(var_26_13, arg_26_1, var_26_1, var_25_0[iter_26_7[2]][iter_26_7[1]], var_25_0[iter_26_7[2]][1])
						end
					end
				end
			end
		elseif var_26_0.outDir == WuErLiXiEnum.Dir.Right then
			local var_26_17 = var_26_0:getUnitSignals(arg_26_2)

			for iter_26_9, iter_26_10 in pairs(var_26_17) do
				if iter_26_10[1] < var_25_2 then
					for iter_26_11 = iter_26_10[1] + 1, var_25_2 do
						local var_26_18 = var_25_0[iter_26_10[2]][iter_26_10[1]].id
						local var_26_19 = var_25_0[iter_26_10[2]][iter_26_11]:getNodeUnit()

						if var_26_19 then
							if #var_26_19:getUnitSignals(var_26_0:getUnitSignalOutDir()) > 0 then
								local var_26_20 = iter_26_11 .. "_" .. iter_26_10[2]

								if arg_25_0._signalDict[var_26_20] then
									arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][iter_26_11 - 1])

									break
								end

								arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][iter_26_11])
								var_25_3(var_25_0[iter_26_10[2]][iter_26_11], arg_26_1, var_26_1)

								break
							elseif var_26_19:isUnitActive(var_26_0:getUnitSignalOutDir()) then
								if not var_26_19:isIgnoreSignal() then
									arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][iter_26_11])

									break
								end
							else
								arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][iter_26_11 - 1])

								break
							end
						end

						local var_26_21 = var_25_0[iter_26_10[2]][iter_26_11]:getNodeRay()

						if not var_26_21 or var_26_21.rayId ~= var_26_18 or var_26_21.rayType ~= arg_26_1 then
							arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][iter_26_11 - 1])

							break
						end

						if iter_26_11 == var_25_2 then
							arg_25_0:_addRayDict(var_26_18, arg_26_1, var_26_1, var_25_0[iter_26_10[2]][iter_26_10[1]], var_25_0[iter_26_10[2]][var_25_2])
						end
					end
				end
			end
		end
	end

	for iter_25_0 = 1, var_25_2 do
		for iter_25_1 = 1, var_25_1 do
			local var_25_4 = var_25_0[iter_25_1][iter_25_0]:getNodeUnit()

			if var_25_4 then
				if var_25_4.unitType == WuErLiXiEnum.UnitType.SignalStart then
					var_25_3(var_25_0[iter_25_1][iter_25_0], WuErLiXiEnum.RayType.NormalSignal)
				elseif var_25_4.unitType == WuErLiXiEnum.UnitType.KeyStart then
					var_25_3(var_25_0[iter_25_1][iter_25_0], WuErLiXiEnum.RayType.SwitchSignal)
				end
			end
		end
	end

	return arg_25_0._signalDict
end

function var_0_0._addRayDict(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0 = arg_27_4.x .. "_" .. arg_27_4.y

	if arg_27_4.x == arg_27_5.x and arg_27_4.y == arg_27_5.y then
		arg_27_0._signalDict[var_27_0] = nil

		return
	end

	if not arg_27_0._signalDict[var_27_0] then
		arg_27_0._signalDict[var_27_0] = WuErLiXiMapSignalItemMo.New()

		arg_27_0._signalDict[var_27_0]:init(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	else
		arg_27_0._signalDict[var_27_0]:reset(arg_27_1, arg_27_2, arg_27_3, arg_27_5)
	end
end

function var_0_0.isKeyActiveSelf(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getMapNodes()
	local var_28_1 = arg_28_2:getNodeRay()

	if var_28_1 then
		if arg_28_0:hasInteractActive(arg_28_1, arg_28_2) then
			return true
		end

		local var_28_2 = math.floor(var_28_1.rayId / 100)
		local var_28_3 = var_28_1.rayId % 100

		if arg_28_0:isHasIngnoreUnit(var_28_0[var_28_3][var_28_2], arg_28_2, arg_28_1) then
			return true
		elseif var_28_1.rayParent and var_28_1.rayParent > 0 then
			local var_28_4 = math.floor(var_28_1.rayParent / 100)
			local var_28_5 = var_28_1.rayParent % 100
			local var_28_6 = var_28_0[var_28_3][var_28_2]:getNodeUnit()
			local var_28_7 = var_28_0[var_28_6.y][var_28_6.x]

			return arg_28_0:isHasIngnoreUnit(var_28_0[var_28_5][var_28_4], var_28_7, arg_28_1)
		end
	end

	return false
end

function var_0_0.hasInteractActive(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2:getNodeRay()

	if not var_29_0 then
		return false
	end

	local var_29_1 = arg_29_0:getMapNodes()
	local var_29_2 = math.floor(var_29_0.rayId / 100)
	local var_29_3 = var_29_0.rayId % 100
	local var_29_4 = arg_29_0:getIgnoreUnits(var_29_1[var_29_3][var_29_2], arg_29_2)

	for iter_29_0, iter_29_1 in pairs(var_29_4) do
		local var_29_5 = arg_29_0:getKeyNodeByUnitId(iter_29_1)
		local var_29_6 = var_29_5:getNodeRay()

		if not var_29_6 then
			return false
		end

		local var_29_7 = math.floor(var_29_6.rayId / 100)
		local var_29_8 = var_29_6.rayId % 100
		local var_29_9 = arg_29_0:getIgnoreUnits(var_29_1[var_29_8][var_29_7], var_29_5)

		for iter_29_2, iter_29_3 in pairs(var_29_9) do
			if iter_29_3 == arg_29_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getKeyNodeByUnitId(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getMapNodes()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			local var_30_1 = iter_30_3:getNodeUnit()

			if var_30_1 and var_30_1.unitType == WuErLiXiEnum.UnitType.Key and var_30_1.id == arg_30_1 then
				return iter_30_3
			end
		end
	end
end

function var_0_0.isKeyActive(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getMapNodes()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		for iter_31_2, iter_31_3 in pairs(iter_31_1) do
			local var_31_1 = iter_31_3:getNodeUnit()

			if var_31_1 and var_31_1.unitType == WuErLiXiEnum.UnitType.Key and var_31_1.id == arg_31_1 then
				return var_31_1.isActive
			end
		end
	end

	return false
end

function var_0_0.getIgnoreUnits(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}
	local var_32_1 = arg_32_0:getMapNodes()

	local function var_32_2(arg_33_0, arg_33_1)
		if arg_33_0.x == arg_33_1.x then
			if arg_33_1.y > arg_33_0.y then
				for iter_33_0 = arg_33_0.y + 1, arg_33_1.y - 1 do
					local var_33_0 = var_32_1[iter_33_0][arg_33_0.x]:getNodeUnit()

					if var_33_0 then
						table.insert(var_32_0, var_33_0.id)
					end
				end

				local var_33_1 = arg_33_0:getNodeUnit()
				local var_33_2 = var_32_1[var_33_1.y][var_33_1.x]
				local var_33_3 = var_33_2:getNodeRay()

				if var_33_1 and var_33_3 and var_33_3.rayId and var_33_3.rayId > 0 then
					local var_33_4 = math.floor(var_33_3.rayId / 100)
					local var_33_5 = var_33_3.rayId % 100

					var_32_2(var_32_1[var_33_5][var_33_4], var_33_2)
				end
			elseif arg_33_1.y < arg_33_0.y then
				for iter_33_1 = arg_33_0.y - 1, arg_33_1.y + 1, -1 do
					local var_33_6 = var_32_1[iter_33_1][arg_33_0.x]:getNodeUnit()

					if var_33_6 then
						table.insert(var_32_0, var_33_6.id)
					end
				end

				local var_33_7 = arg_33_0:getNodeUnit()
				local var_33_8 = var_32_1[var_33_7.y][var_33_7.x]
				local var_33_9 = var_33_8:getNodeRay()

				if var_33_7 and var_33_9 and var_33_9.rayId and var_33_9.rayId > 0 then
					local var_33_10 = math.floor(var_33_9.rayId / 100)
					local var_33_11 = var_33_9.rayId % 100

					var_32_2(var_32_1[var_33_11][var_33_10], var_33_8)
				end
			end
		elseif arg_33_0.y == arg_33_1.y then
			if arg_33_1.x > arg_33_0.x then
				for iter_33_2 = arg_33_0.x + 1, arg_33_1.x - 1 do
					local var_33_12 = var_32_1[arg_33_0.y][iter_33_2]:getNodeUnit()

					if var_33_12 then
						table.insert(var_32_0, var_33_12.id)
					end
				end

				local var_33_13 = arg_33_0:getNodeUnit()
				local var_33_14 = var_32_1[var_33_13.y][var_33_13.x]
				local var_33_15 = var_33_14:getNodeRay()

				if var_33_13 and var_33_15 and var_33_15.rayId and var_33_15.rayId > 0 then
					local var_33_16 = math.floor(var_33_15.rayId / 100)
					local var_33_17 = var_33_15.rayId % 100

					var_32_2(var_32_1[var_33_17][var_33_16], var_33_14)
				end
			elseif arg_33_1.x < arg_33_0.x then
				for iter_33_3 = arg_33_0.x - 1, arg_33_1.x + 1, -1 do
					local var_33_18 = var_32_1[arg_33_0.y][iter_33_3]:getNodeUnit()

					if var_33_18 then
						table.insert(var_32_0, var_33_18.id)
					end
				end

				local var_33_19 = arg_33_0:getNodeUnit()
				local var_33_20 = var_32_1[var_33_19.y][var_33_19.x]
				local var_33_21 = var_33_20:getNodeRay()

				if var_33_19 and var_33_21 and var_33_21.rayId and var_33_21.rayId > 0 then
					local var_33_22 = math.floor(var_33_21.rayId / 100)
					local var_33_23 = var_33_21.rayId % 100

					var_32_2(var_32_1[var_33_23][var_33_22], var_33_20)
				end
			end
		end
	end

	var_32_2(arg_32_1, arg_32_2)

	return var_32_0
end

function var_0_0.isHasIngnoreUnit(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:getMapNodes()

	if arg_34_1.x == arg_34_2.x then
		if arg_34_2.y > arg_34_1.y then
			for iter_34_0 = arg_34_1.y, arg_34_2.y - 1 do
				local var_34_1 = var_34_0[iter_34_0][arg_34_1.x]:getNodeUnit()

				if var_34_1 and var_34_1.id == arg_34_3 then
					return true
				end
			end
		elseif arg_34_2.y < arg_34_1.y then
			for iter_34_1 = arg_34_1.y, arg_34_2.y + 1, -1 do
				local var_34_2 = var_34_0[iter_34_1][arg_34_1.x]:getNodeUnit()

				if var_34_2 and var_34_2.id == arg_34_3 then
					return true
				end
			end
		end
	elseif arg_34_1.y == arg_34_2.y then
		if arg_34_2.x > arg_34_1.x then
			for iter_34_2 = arg_34_1.x, arg_34_2.x - 1 do
				local var_34_3 = var_34_0[arg_34_1.y][iter_34_2]:getNodeUnit()

				if var_34_3 and var_34_3.id == arg_34_3 then
					return true
				end
			end
		elseif arg_34_2.x < arg_34_1.x then
			for iter_34_3 = arg_34_1.x, arg_34_2.x + 1, -1 do
				local var_34_4 = var_34_0[arg_34_1.y][iter_34_3]:getNodeUnit()

				if var_34_4 and var_34_4.id == arg_34_3 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.isNodeHasUnit(arg_35_0, arg_35_1)
	if arg_35_1:getNodeUnit() then
		return true
	end

	return false
end

function var_0_0.isNodeHasInitUnit(arg_36_0, arg_36_1)
	if arg_36_1:getNodeUnit() then
		return arg_36_1.initUnit > 0
	end

	return false
end

function var_0_0.isAllSignalEndActive(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or arg_37_0._curMapId

	local var_37_0 = arg_37_0:getMapNodes(arg_37_1)

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		for iter_37_2, iter_37_3 in pairs(iter_37_1) do
			local var_37_1 = iter_37_3:getNodeUnit()
			local var_37_2 = iter_37_3:getNodeRay()

			if var_37_1 and var_37_1.unitType == WuErLiXiEnum.UnitType.SignalEnd and (not var_37_1.isActive or not var_37_2) then
				return false
			end
		end
	end

	return true
end

function var_0_0.getLimitSelectUnitCount(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.count
	local var_38_1 = arg_38_0:getMapNodes(arg_38_0._curMapId)

	for iter_38_0, iter_38_1 in pairs(var_38_1) do
		for iter_38_2, iter_38_3 in pairs(iter_38_1) do
			if iter_38_3.initUnit == 0 and iter_38_3.unit and iter_38_3.unit.id == arg_38_1.id and iter_38_3.x == iter_38_3.unit.x and iter_38_3.y == iter_38_3.unit.y then
				var_38_0 = var_38_0 - 1
			end
		end
	end

	return var_38_0
end

function var_0_0.getKeyAndSwitchTagById(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getMap(arg_39_0._curMapId)
	local var_39_1 = {
		"A",
		"B",
		"C",
		"D",
		"E",
		"F",
		"G",
		"H",
		"I",
		"J",
		"K",
		"L",
		"M",
		"N",
		"O",
		"B",
		"Q",
		"R",
		"S",
		"T",
		"U",
		"V",
		"W",
		"X",
		"Y",
		"Z"
	}
	local var_39_2 = {}

	for iter_39_0, iter_39_1 in pairs(var_39_0.nodeDict) do
		for iter_39_2, iter_39_3 in pairs(iter_39_1) do
			if iter_39_3.unit and (iter_39_3.unit.unitType == WuErLiXiEnum.UnitType.Key or iter_39_3.unit.unitType == WuErLiXiEnum.UnitType.Switch) then
				var_39_2[iter_39_3.unit.id] = iter_39_3.unit.id
			end
		end
	end

	for iter_39_4, iter_39_5 in pairs(var_39_0.actUnitDict) do
		if iter_39_5.type == WuErLiXiEnum.UnitType.Key or iter_39_5.type == WuErLiXiEnum.UnitType.Switch then
			var_39_2[iter_39_5.id] = iter_39_5.id
		end
	end

	local var_39_3 = {}

	for iter_39_6, iter_39_7 in pairs(var_39_2) do
		table.insert(var_39_3, iter_39_7)
	end

	table.sort(var_39_3)

	local var_39_4 = 0

	for iter_39_8, iter_39_9 in ipairs(var_39_3) do
		if iter_39_9 == arg_39_1 then
			var_39_4 = iter_39_8
		end
	end

	return var_39_4 == 0 and "" or var_39_1[var_39_4]
end

function var_0_0.isUnitActive(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getMap(arg_40_0._curMapId)

	for iter_40_0, iter_40_1 in pairs(var_40_0.nodeDict) do
		for iter_40_2, iter_40_3 in pairs(iter_40_1) do
			if iter_40_3.unit and iter_40_3.unit.id == arg_40_1 then
				return iter_40_3.unit.isActive
			end
		end
	end

	return false
end

function var_0_0.isSetDirEnable(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = arg_41_0:getMapNodes()
	local var_41_1 = arg_41_0:getMapLineCount()
	local var_41_2 = arg_41_0:getMapRowCount()

	if arg_41_1 == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_41_2 == WuErLiXiEnum.Dir.Up or arg_41_2 == WuErLiXiEnum.Dir.Down then
			if arg_41_3 <= 1 or var_41_2 <= arg_41_3 then
				return false
			end

			return not var_41_0[arg_41_4][arg_41_3 - 1].unit and not var_41_0[arg_41_4][arg_41_3 - 1].unit
		else
			if arg_41_4 <= 1 or var_41_1 <= arg_41_4 then
				return false
			end

			return not var_41_0[arg_41_4 - 1][arg_41_3].unit and not var_41_0[arg_41_4 + 1][arg_41_3].unit
		end
	end

	return true
end

function var_0_0.setCurSelectUnit(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0._curSelectNode = {
		arg_42_1,
		arg_42_2
	}
end

function var_0_0.getCurSelectUnit(arg_43_0)
	return arg_43_0._curSelectNode
end

function var_0_0.clearSelectUnit(arg_44_0)
	arg_44_0._curSelectNode = {}
end

function var_0_0.getUnlockElements(arg_45_0)
	local var_45_0 = {}
	local var_45_1 = WuErLiXiConfig.instance:getElementList()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		if iter_45_1.episodeId == 0 or WuErLiXiModel.instance:isEpisodeUnlock(iter_45_1.episodeId) then
			table.insert(var_45_0, iter_45_1)
		end
	end

	table.sort(var_45_0, function(arg_46_0, arg_46_1)
		return arg_46_0.sequence < arg_46_1.sequence
	end)

	return var_45_0
end

function var_0_0.hasElementNew(arg_47_0)
	return #arg_47_0:getUnlockElements() > #arg_47_0._unlockElements
end

function var_0_0.setReadNewElement(arg_48_0)
	arg_48_0._unlockElements = {}

	local var_48_0 = arg_48_0:getUnlockElements()
	local var_48_1 = ""

	if #var_48_0 > 0 then
		var_48_1 = tostring(var_48_0[1].id)

		table.insert(arg_48_0._unlockElements, var_48_0[1].id)

		if #var_48_0 > 1 then
			for iter_48_0 = 1, #var_48_0 do
				var_48_1 = var_48_1 .. "#" .. var_48_0[iter_48_0].id

				table.insert(arg_48_0._unlockElements, var_48_0[iter_48_0].id)
			end
		end
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.WuErLiXiUnlockUnits, var_48_1)
end

function var_0_0.setMapStartTime(arg_49_0)
	arg_49_0._mapStartTime = ServerTime.now()
end

function var_0_0.getMapStartTime(arg_50_0)
	return arg_50_0._mapStartTime
end

function var_0_0.clearOperations(arg_51_0)
	arg_51_0._operations = {}
end

function var_0_0.addOperation(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5, arg_52_6)
	local var_52_0 = arg_52_0:getMapStartTime()

	for iter_52_0, iter_52_1 in ipairs(arg_52_0._operations) do
		var_52_0 = iter_52_1.secs + var_52_0
	end

	local var_52_1 = {
		step = #arg_52_0._operations + 1,
		secs = ServerTime.now() - var_52_0,
		id = arg_52_1,
		type = arg_52_2,
		from_x = tostring(arg_52_3),
		from_y = tostring(arg_52_4),
		to_x = tostring(arg_52_5),
		to_y = tostring(arg_52_6)
	}

	table.insert(arg_52_0._operations, var_52_1)
end

function var_0_0.getStatOperationInfos(arg_53_0)
	return arg_53_0._operations
end

function var_0_0.getStatMapInfos(arg_54_0)
	local var_54_0 = arg_54_0:getMapNodes()
	local var_54_1 = {}

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		for iter_54_2, iter_54_3 in pairs(iter_54_1) do
			local var_54_2 = iter_54_3:getNodeUnit()

			if var_54_2 then
				local var_54_3 = {
					id = var_54_2.id,
					x = iter_54_3.x,
					y = iter_54_3.y,
					type = var_54_2.unitType,
					dir = var_54_2.dir
				}

				table.insert(var_54_1, var_54_3)
			end
		end
	end

	return var_54_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
