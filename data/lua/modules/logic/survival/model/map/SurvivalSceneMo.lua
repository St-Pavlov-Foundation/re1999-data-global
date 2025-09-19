module("modules.logic.survival.model.map.SurvivalSceneMo", package.seeall)

local var_0_0 = pureTable("SurvivalSceneMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.player = arg_1_0.player or SurvivalPlayerMo.New()

	arg_1_0.player:init(arg_1_1.player)

	arg_1_0.units = {}
	arg_1_0.unitsById = arg_1_0.unitsById or {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.unit) do
		if iter_1_1.unitType ~= SurvivalEnum.UnitType.Born then
			local var_1_0 = arg_1_0.unitsById[iter_1_1.id] or SurvivalUnitMo.New()

			var_1_0:init(iter_1_1)
			table.insert(arg_1_0.units, var_1_0)

			arg_1_0.unitsById[iter_1_1.id] = var_1_0
		end
	end

	arg_1_0.sceneCo = SurvivalConfig.instance:getMapConfig(arg_1_0.mapId)
	arg_1_0.exitPos = arg_1_0.sceneCo.exitPos
	arg_1_0.unitsById = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.units) do
		arg_1_0.unitsById[iter_1_3.id] = iter_1_3
	end

	arg_1_0.gameTime = arg_1_1.gameTime
	arg_1_0.currMaxGameTime = arg_1_1.currMaxGameTime
	arg_1_0.circle = arg_1_1.circle
	arg_1_0.addTime = arg_1_0.currMaxGameTime - tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TotalTime)))
	arg_1_0.bag = arg_1_0.bag or SurvivalBagMo.New()

	arg_1_0.bag:init(arg_1_1.bag)

	arg_1_0.panel = nil

	if arg_1_1.panel.type ~= SurvivalEnum.PanelType.None then
		arg_1_0.panel = SurvivalPanelMo.New()

		arg_1_0.panel:init(arg_1_1.panel)
	end

	arg_1_0.teamInfo = SurvivalTeamInfoMo.New()

	arg_1_0.teamInfo:init(arg_1_1.teamInfo)

	arg_1_0.safeZone = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.safeZone.shrinkInfo) do
		local var_1_1 = SurvivalShrinkInfoMo.New()

		var_1_1:init(iter_1_5)
		table.insert(arg_1_0.safeZone, var_1_1)
	end

	arg_1_0:initUnitPosDict()

	arg_1_0.battleInfo = SurvivalExploreBattleInfoMo.New()

	arg_1_0.battleInfo:init(arg_1_1.battleInfo)

	arg_1_0.followTask = SurvivalFollowTaskMo.New()

	arg_1_0.followTask:init(arg_1_1.followTask)

	arg_1_0.gainTalentNum = arg_1_1.gainTalentNum
	arg_1_0.needNpcTags = SurvivalShelterModel.instance:getWeekInfo().decreesBox:getCurPolicyNeedTags()
end

function var_0_0.initUnitPosDict(arg_2_0)
	arg_2_0._unitsByPos = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.units) do
		local var_2_0 = iter_2_1.pos

		arg_2_0:_addUnitPos(var_2_0, iter_2_1)

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.exPoints) do
			arg_2_0:_addUnitPos(iter_2_3, iter_2_1)
		end
	end

	for iter_2_4, iter_2_5 in pairs(arg_2_0._unitsByPos) do
		for iter_2_6, iter_2_7 in pairs(iter_2_5) do
			if #iter_2_7 > 1 then
				table.sort(iter_2_7, var_0_0.sortUnitMo)
			end
		end
	end
end

function var_0_0.getUnitListByPos(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.units) do
		if iter_3_1.pos == arg_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	if #var_3_0 > 1 then
		table.sort(var_3_0, var_0_0.sortUnitMo)
	end

	return var_3_0
end

function var_0_0._addUnitPos(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.q
	local var_4_1 = arg_4_1.r

	if not arg_4_0._unitsByPos[var_4_0] then
		arg_4_0._unitsByPos[var_4_0] = {}
	end

	local var_4_2 = arg_4_0._unitsByPos[var_4_0][var_4_1]

	if not var_4_2 then
		var_4_2 = {}
		arg_4_0._unitsByPos[var_4_0][var_4_1] = var_4_2
	end

	local var_4_3 = false

	if not tabletool.indexOf(var_4_2, arg_4_2) then
		table.insert(var_4_2, arg_4_2)

		var_4_3 = true
	end

	return var_4_2, var_4_3
end

function var_0_0.addUnit(arg_5_0, arg_5_1)
	if arg_5_1.unitType == SurvivalEnum.UnitType.Born then
		return
	end

	local var_5_0 = arg_5_0.unitsById[arg_5_1.id]

	if var_5_0 then
		local var_5_1 = var_5_0.cfgId
		local var_5_2 = var_5_0.pos

		var_5_0:copyFrom(arg_5_1)

		if var_5_0.pos ~= var_5_2 then
			local var_5_3 = var_5_0.pos

			var_5_0.pos = var_5_0

			arg_5_0:onUnitUpdatePos(var_5_0, var_5_3)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitChange, arg_5_1.id)

		if var_5_1 ~= arg_5_1.cfgId then
			arg_5_0:fixUnitExPos(arg_5_1)
		end

		return
	end

	arg_5_0.unitsById[arg_5_1.id] = arg_5_1

	table.insert(arg_5_0.units, arg_5_1)
	arg_5_0:_addUnitPos(arg_5_1.pos, arg_5_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitAdd, arg_5_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_5_1.pos, arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.exPoints) do
		arg_5_0:_addUnitPos(iter_5_1, arg_5_1)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_5_1, arg_5_1)
	end
end

function var_0_0.fixUnitExPos(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = arg_6_0:_addUnitPos(arg_6_1.pos, arg_6_1)

	if var_6_1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_6_1.pos, arg_6_1)
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.exPoints) do
		local var_6_2

		iter_6_0, var_6_2 = arg_6_0:_addUnitPos(iter_6_1, arg_6_1)

		if var_6_2 then
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_6_1, arg_6_1)
		end
	end
end

function var_0_0.deleteUnit(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.unitsById[arg_7_1]

	if not var_7_0 then
		logError("元件id不存在" .. tostring(arg_7_1))

		return
	end

	arg_7_0.unitsById[arg_7_1] = nil

	tabletool.removeValue(arg_7_0.units, var_7_0)

	local var_7_1 = arg_7_0:getListByPos(var_7_0.pos)

	if var_7_1 then
		tabletool.removeValue(var_7_1, var_7_0)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitDel, var_7_0, arg_7_2)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, var_7_0.pos, var_7_0, true)

	for iter_7_0, iter_7_1 in ipairs(var_7_0.exPoints) do
		local var_7_2 = arg_7_0:getListByPos(iter_7_1)

		if var_7_2 then
			tabletool.removeValue(var_7_2, var_7_0)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, iter_7_1, var_7_0, true)
	end
end

function var_0_0.onUnitUpdatePos(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1.pos == arg_8_2 then
		return
	end

	local var_8_0 = arg_8_1.pos
	local var_8_1 = arg_8_0:getListByPos(arg_8_1.pos)

	if not var_8_1 then
		return
	end

	tabletool.removeValue(var_8_1, arg_8_1)

	arg_8_1.pos = arg_8_2

	local var_8_2 = arg_8_0:_addUnitPos(arg_8_2, arg_8_1)

	if #var_8_2 > 1 then
		table.sort(var_8_2, var_0_0.sortUnitMo)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, var_8_0, arg_8_1)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapUnitPosChange, arg_8_2, arg_8_1)
end

function var_0_0.sortUnitMo(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.co and arg_9_0.co.priority or 0
	local var_9_1 = arg_9_1.co and arg_9_1.co.priority or 0

	if var_9_0 ~= var_9_1 then
		return var_9_1 < var_9_0
	end

	return arg_9_0.id < arg_9_1.id
end

function var_0_0.getListByPos(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._unitsByPos[arg_10_1.q]

	if not var_10_0 then
		return
	end

	return var_10_0[arg_10_1.r]
end

function var_0_0.isInTop(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getListByPos(arg_11_1.pos)

	if not var_11_0 then
		return false
	end

	return var_11_0[1] == arg_11_1
end

function var_0_0.getUnitByPos(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0

	if arg_12_2 then
		var_12_0 = {}
	end

	local var_12_1 = arg_12_0:getListByPos(arg_12_1)

	if not var_12_1 then
		if arg_12_2 then
			return var_12_0
		else
			return
		end
	end

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if arg_12_3 or iter_12_1:canTrigger() then
			if not arg_12_2 then
				return iter_12_1
			else
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

return var_0_0
