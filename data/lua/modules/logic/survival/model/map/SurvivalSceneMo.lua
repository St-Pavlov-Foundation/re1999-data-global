module("modules.logic.survival.model.map.SurvivalSceneMo", package.seeall)

local var_0_0 = pureTable("SurvivalSceneMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._mapInfo = GameUtil.rpcInfoToMo(arg_1_1.mapInfo, SurvivalMapInfoMo)
	arg_1_0.mapId = arg_1_0._mapInfo.mapId
	arg_1_0.player = GameUtil.rpcInfoToMo(arg_1_1.player, SurvivalPlayerMo, arg_1_0.player)
	arg_1_0.units = {}
	arg_1_0.unitsById = arg_1_0.unitsById or {}
	arg_1_0.blocks = {}
	arg_1_0.blocksById = arg_1_0.blocksById or {}
	arg_1_0.allDestroyPos = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.unit) do
		if iter_1_1.unitType == SurvivalEnum.UnitType.Born then
			-- block empty
		elseif iter_1_1.unitType == SurvivalEnum.UnitType.Block then
			local var_1_0 = arg_1_0.blocksById[iter_1_1.id] or SurvivalUnitMo.New()

			var_1_0:init(iter_1_1)

			if var_1_0:isDestory() then
				SurvivalHelper.instance:addNodeToDict(arg_1_0.allDestroyPos, var_1_0.pos)

				for iter_1_2, iter_1_3 in ipairs(var_1_0.exPoints) do
					SurvivalHelper.instance:addNodeToDict(arg_1_0.allDestroyPos, iter_1_3)
				end
			else
				table.insert(arg_1_0.blocks, var_1_0)

				arg_1_0.blocksById[iter_1_1.id] = var_1_0
			end
		else
			local var_1_1 = arg_1_0.unitsById[iter_1_1.id] or SurvivalUnitMo.New()

			var_1_1:init(iter_1_1)
			table.insert(arg_1_0.units, var_1_1)

			arg_1_0.unitsById[iter_1_1.id] = var_1_1
		end
	end

	arg_1_0.groupId = arg_1_0._mapInfo.groupId
	arg_1_0.mapType = arg_1_0._mapInfo.mapType
	arg_1_0.sceneCo = SurvivalConfig.instance:getMapConfig(arg_1_0.mapId)

	arg_1_0.sceneCo:resetWalkables()

	arg_1_0.exitPos = arg_1_0.sceneCo.exitPos
	arg_1_0.unitsById = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_0.units) do
		arg_1_0.unitsById[iter_1_5.id] = iter_1_5
	end

	arg_1_0.blocksById = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_0.blocks) do
		arg_1_0.blocksById[iter_1_7.id] = iter_1_7
	end

	arg_1_0.gameTime = arg_1_1.gameTime
	arg_1_0.currMaxGameTime = arg_1_1.currMaxGameTime
	arg_1_0.circle = arg_1_1.circle
	arg_1_0.addTime = arg_1_0.currMaxGameTime - tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TotalTime)))
	arg_1_0.panel = nil

	if arg_1_1.panel.type ~= SurvivalEnum.PanelType.None then
		arg_1_0.panel = SurvivalPanelMo.New()

		arg_1_0.panel:init(arg_1_1.panel)
	end

	arg_1_0.teamInfo = GameUtil.rpcInfoToMo(arg_1_1.teamInfo, SurvivalTeamInfoMo)
	arg_1_0.safeZone = GameUtil.rpcInfosToList(arg_1_1.safeZone.shrinkInfo, SurvivalShrinkInfoMo)

	arg_1_0:initUnitPosDict()
	arg_1_0:initSpBlockPosDict()

	arg_1_0.battleInfo = GameUtil.rpcInfoToMo(arg_1_1.battleInfo, SurvivalExploreBattleInfoMo)
	arg_1_0.mainTask = SurvivalFollowTaskMo.New()
	arg_1_0.followTask = SurvivalFollowTaskMo.New()

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.followTask) do
		if iter_1_9.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
			arg_1_0.mainTask:init(iter_1_9)
		elseif iter_1_9.moduleId == SurvivalEnum.TaskModule.NormalTask then
			arg_1_0.followTask:init(iter_1_9)
		end
	end

	arg_1_0.extraBlock = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.cells) do
		local var_1_2 = SurvivalHexCellMo.New()

		var_1_2:init(iter_1_11, arg_1_0.mapType)
		table.insert(arg_1_0.extraBlock, var_1_2)
	end

	arg_1_0.sceneProp = GameUtil.rpcInfoToMo(arg_1_1.sceneProp, SurvivalScenePropMo)
end

function var_0_0.getBlockTypeByPos(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getBlockCoByPos(arg_2_1)

	return var_2_0 and var_2_0.subType or -1
end

function var_0_0.getBlockCoByPos(arg_3_0, arg_3_1)
	if not arg_3_0._spBlockTypeDict[arg_3_1.q] then
		return
	end

	return arg_3_0._spBlockTypeDict[arg_3_1.q][arg_3_1.r]
end

function var_0_0.initSpBlockPosDict(arg_4_0)
	arg_4_0._spBlockTypeDict = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.blocksById) do
		local var_4_0 = iter_4_1.pos

		arg_4_0:setPosSubType(var_4_0, iter_4_1.co)

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.exPoints) do
			arg_4_0:setPosSubType(iter_4_3, iter_4_1.co)
		end
	end
end

function var_0_0.setPosSubType(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._spBlockTypeDict[arg_5_1.q] then
		arg_5_0._spBlockTypeDict[arg_5_1.q] = {}
	end

	arg_5_0._spBlockTypeDict[arg_5_1.q][arg_5_1.r] = arg_5_2
end

function var_0_0.initUnitPosDict(arg_6_0)
	arg_6_0._unitsByPos = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.units) do
		local var_6_0 = iter_6_1.pos

		arg_6_0:_addUnitPos(var_6_0, iter_6_1)

		for iter_6_2, iter_6_3 in ipairs(iter_6_1.exPoints) do
			arg_6_0:_addUnitPos(iter_6_3, iter_6_1)
		end
	end

	for iter_6_4, iter_6_5 in pairs(arg_6_0._unitsByPos) do
		for iter_6_6, iter_6_7 in pairs(iter_6_5) do
			if #iter_6_7 > 1 then
				table.sort(iter_6_7, var_0_0.sortUnitMo)
			end
		end
	end
end

local var_0_1

function var_0_0.isNoShowIcon(arg_7_0, arg_7_1)
	if not var_0_1 then
		var_0_1 = {}

		local var_7_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.NoShowIconUnitSubType)

		if not string.nilorempty(var_7_0) then
			for iter_7_0, iter_7_1 in ipairs(string.splitToNumber(var_7_0, "#")) do
				var_0_1[iter_7_1] = true
			end
		end
	end

	local var_7_1 = arg_7_1 and arg_7_1.co and arg_7_1.co.subType

	if not var_7_1 or var_0_1[var_7_1] then
		return true
	end

	if var_7_1 == SurvivalEnum.UnitSubType.BlockEvent then
		return true
	end

	return false
end

function var_0_0.getUnitIconListByPos(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.units) do
		if iter_8_1.pos == arg_8_1 and not iter_8_1:isBlock() and not iter_8_1:isBlockEvent() and not arg_8_0:isNoShowIcon(iter_8_1) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	if #var_8_0 > 1 then
		table.sort(var_8_0, var_0_0.sortUnitMo)
	end

	return var_8_0
end

function var_0_0._addUnitPos(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1.q
	local var_9_1 = arg_9_1.r

	if not arg_9_0._unitsByPos[var_9_0] then
		arg_9_0._unitsByPos[var_9_0] = {}
	end

	local var_9_2 = arg_9_0._unitsByPos[var_9_0][var_9_1]

	if not var_9_2 then
		var_9_2 = {}
		arg_9_0._unitsByPos[var_9_0][var_9_1] = var_9_2
	end

	local var_9_3 = false

	if not tabletool.indexOf(var_9_2, arg_9_2) then
		table.insert(var_9_2, arg_9_2)

		var_9_3 = true
	end

	return var_9_2, var_9_3
end

function var_0_0.addUnit(arg_10_0, arg_10_1)
	if arg_10_1.unitType == SurvivalEnum.UnitType.Born then
		return
	end

	local var_10_0 = arg_10_1.unitType == SurvivalEnum.UnitType.Block
	local var_10_1 = var_10_0 and arg_10_0.blocksById or arg_10_0.unitsById
	local var_10_2 = var_10_0 and arg_10_0.blocks or arg_10_0.units
	local var_10_3 = var_10_1[arg_10_1.id]

	if var_10_3 then
		local var_10_4 = var_10_3.cfgId
		local var_10_5 = var_10_3.pos

		var_10_3:copyFrom(arg_10_1)

		if var_10_0 then
			if arg_10_1:isDestory() then
				SurvivalHelper.instance:addNodeToDict(arg_10_0.allDestroyPos, arg_10_1.pos)

				for iter_10_0, iter_10_1 in ipairs(arg_10_1.exPoints) do
					SurvivalHelper.instance:addNodeToDict(arg_10_0.allDestroyPos, iter_10_1)
				end

				arg_10_0:deleteUnit(arg_10_1.id)
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapDestoryPosAdd, arg_10_1)
			end
		else
			if var_10_3.pos ~= var_10_5 then
				local var_10_6 = var_10_3.pos

				var_10_3.pos = var_10_3

				arg_10_0:onUnitUpdatePos(var_10_3, var_10_6)
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitChange, arg_10_1.id)

			if var_10_4 ~= arg_10_1.cfgId then
				arg_10_0:fixUnitExPos(arg_10_1)
			end
		end

		return
	end

	if var_10_0 and arg_10_1:isDestory() then
		logError("直接新增一个被摧毁的障碍？？？" .. tostring(arg_10_1.id))

		return
	end

	var_10_1[arg_10_1.id] = arg_10_1

	table.insert(var_10_2, arg_10_1)

	if not var_10_0 then
		arg_10_0:_addUnitPos(arg_10_1.pos, arg_10_1)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitAdd, arg_10_1)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_10_1.pos, arg_10_1)

		for iter_10_2, iter_10_3 in ipairs(arg_10_1.exPoints) do
			arg_10_0:_addUnitPos(iter_10_3, arg_10_1)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_10_3, arg_10_1)
		end
	else
		arg_10_0:setPosSubType(arg_10_1.pos, arg_10_1.co)

		for iter_10_4, iter_10_5 in ipairs(arg_10_1.exPoints) do
			arg_10_0:setPosSubType(iter_10_5, arg_10_1.co)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSpBlockUpdate, arg_10_1.pos)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapSpBlockAdd, arg_10_1)
	end
end

function var_0_0.fixUnitExPos(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_0:_addUnitPos(arg_11_1.pos, arg_11_1)

	if var_11_1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_11_1.pos, arg_11_1)
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.exPoints) do
		local var_11_2

		iter_11_0, var_11_2 = arg_11_0:_addUnitPos(iter_11_1, arg_11_1)

		if var_11_2 then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_11_1, arg_11_1)
		end
	end
end

function var_0_0.deleteUnit(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = true
	local var_12_1 = arg_12_0.blocksById
	local var_12_2 = arg_12_0.blocks
	local var_12_3 = var_12_1[arg_12_1]

	if not var_12_3 then
		var_12_0 = false
		var_12_1 = arg_12_0.unitsById
		var_12_2 = arg_12_0.units
		var_12_3 = var_12_1[arg_12_1]
	end

	if not var_12_3 then
		logError("元件id不存在" .. tostring(arg_12_1))

		return
	end

	var_12_1[arg_12_1] = nil

	tabletool.removeValue(var_12_2, var_12_3)

	if not var_12_0 then
		local var_12_4 = arg_12_0:getListByPos(var_12_3.pos)

		if var_12_4 then
			tabletool.removeValue(var_12_4, var_12_3)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitDel, var_12_3, arg_12_2)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, var_12_3.pos, var_12_3, true)

		for iter_12_0, iter_12_1 in ipairs(var_12_3.exPoints) do
			local var_12_5 = arg_12_0:getListByPos(iter_12_1)

			if var_12_5 then
				tabletool.removeValue(var_12_5, var_12_3)
			end

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_12_1, var_12_3, true)
		end
	else
		arg_12_0:setPosSubType(var_12_3.pos, nil)

		for iter_12_2, iter_12_3 in ipairs(var_12_3.exPoints) do
			arg_12_0:setPosSubType(iter_12_3, nil)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSpBlockUpdate, var_12_3.pos)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapSpBlockDel, var_12_3)
	end
end

function var_0_0.onUnitUpdatePos(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1.pos == arg_13_2 then
		return
	end

	local var_13_0 = arg_13_1.pos
	local var_13_1 = arg_13_0:getListByPos(arg_13_1.pos)

	if not var_13_1 then
		return
	end

	tabletool.removeValue(var_13_1, arg_13_1)

	arg_13_1.pos = arg_13_2

	local var_13_2 = arg_13_0:_addUnitPos(arg_13_2, arg_13_1)

	if #var_13_2 > 1 then
		table.sort(var_13_2, var_0_0.sortUnitMo)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, var_13_0, arg_13_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_13_2, arg_13_1)
end

function var_0_0.sortUnitMo(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.getUnitPriority(arg_14_0)
	local var_14_1 = var_0_0.getUnitPriority(arg_14_1)

	if var_14_0 ~= var_14_1 then
		return var_14_1 < var_14_0
	end

	return arg_14_0.id < arg_14_1.id
end

function var_0_0.getUnitPriority(arg_15_0)
	local var_15_0 = 0

	if arg_15_0.co then
		var_15_0 = arg_15_0.exPoints[1] and 1000 or arg_15_0.co.priority
	end

	return var_15_0
end

function var_0_0.getListByPos(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._unitsByPos[arg_16_1.q]

	if not var_16_0 then
		return
	end

	return var_16_0[arg_16_1.r]
end

function var_0_0.isInTop(arg_17_0, arg_17_1)
	if arg_17_1.co and arg_17_1.co.subType == SurvivalEnum.UnitSubType.BlockEvent then
		return true
	end

	local var_17_0 = arg_17_0:getListByPos(arg_17_1.pos)

	if not var_17_0 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1 == arg_17_1 then
			return true
		elseif not iter_17_1.co or iter_17_1.co.subType ~= SurvivalEnum.UnitSubType.BlockEvent then
			return false
		end
	end

	return false
end

function var_0_0.getUnitByPos(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0

	if arg_18_2 then
		var_18_0 = {}
	end

	local var_18_1 = arg_18_0:getListByPos(arg_18_1)

	if not var_18_1 then
		if arg_18_2 then
			return var_18_0
		else
			return
		end
	end

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		if arg_18_3 or iter_18_1:canTrigger() then
			if not arg_18_2 then
				return iter_18_1
			else
				table.insert(var_18_0, iter_18_1)
			end
		end
	end

	return var_18_0
end

function var_0_0.isHaveIceEvent(arg_19_0)
	if not arg_19_0.panel or arg_19_0.panel.type ~= SurvivalEnum.PanelType.TreeEvent then
		return
	end

	local var_19_0 = arg_19_0.unitsById[arg_19_0.panel.unitId]
	local var_19_1 = var_19_0 and var_19_0.cfgId
	local var_19_2 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.IceSpEvent)
	local var_19_3

	var_19_3 = tonumber(var_19_2) or 0

	return var_19_1 == var_19_3
end

return var_0_0
