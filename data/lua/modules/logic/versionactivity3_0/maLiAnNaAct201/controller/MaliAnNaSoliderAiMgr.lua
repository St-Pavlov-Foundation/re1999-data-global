module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaSoliderAiMgr", package.seeall)

local var_0_0 = class("MaliAnNaSoliderAiMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot] = arg_1_0._attAckSlot,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad] = arg_1_0._attackRoad,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.retreat] = arg_1_0._retreat,
		[Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot] = arg_1_0._helpSlot
	}
	arg_1_0._weights = {}

	for iter_1_0 = 1, #Activity201MaLiAnNaEnum.AllSlotAIFuncType do
		table.insert(arg_1_0._weights, 1)
	end

	arg_1_0.attackTriggerRate = 0
	arg_1_0.positiveMoveTriggerRate = 0
	arg_1_0.negativeMoveTriggerRate = 0
	arg_1_0._heroMoveRate = 0
	arg_1_0._heroOrSoldier = 0
	arg_1_0._heroGoFrontOrNot = 0
	arg_1_0._needTick = false
end

function var_0_0.initAiParamsById(arg_2_0, arg_2_1)
	arg_2_0._needTick = false
	arg_2_0._tickTime = 0
	arg_2_0._tickInterval = 10000

	arg_2_0:_changeAiParamsByIdByIndex(arg_2_1, 1)
end

function var_0_0._changeAiParamsByIdByIndex(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = lua_activity203_ai.configDict[arg_3_1]

	if var_3_0 and var_3_0[arg_3_2] then
		local var_3_1 = var_3_0[arg_3_2]

		arg_3_0._tickInterval = var_3_1.gaptime or 10000
		arg_3_0._weights[1] = var_3_1.attack_weight or 1
		arg_3_0._weights[2] = var_3_1.positive_move_weight or 1
		arg_3_0._weights[3] = var_3_1.negative_move_weight or 1
		arg_3_0._weights[4] = var_3_1.assist_weight or 1
		arg_3_0.attackTriggerRate = var_3_1.attack_trigger_rate
		arg_3_0.positiveMoveTriggerRate = var_3_1.positive_move_trigger_rate
		arg_3_0.negativeMoveTriggerRate = var_3_1.negative_move_trigger_rate
		arg_3_0._heroMoveRate = var_3_1.hero_move_rate or 0
		arg_3_0._heroOrSoldier = var_3_1.hero_or_soldier or false
		arg_3_0._heroGoFrontOrNot = var_3_1.hero_go_front_ornot or false
		arg_3_0._needTick = true

		math.randomseed(os.time())
	end
end

function var_0_0.clear(arg_4_0)
	arg_4_0._tickTime = 0
end

function var_0_0.getHandleFunc(arg_5_0, arg_5_1)
	return arg_5_0._defineList[arg_5_1]
end

function var_0_0.update(arg_6_0, arg_6_1)
	if not arg_6_0._needTick then
		return
	end

	arg_6_0._tickTime = arg_6_0._tickTime + arg_6_1 * 1000

	if arg_6_0._tickTime < arg_6_0._tickInterval then
		return
	end

	arg_6_0._tickTime = 0

	local var_6_0 = EliminateModelUtils.getRandomNumberByWeight(arg_6_0._weights)
	local var_6_1 = Activity201MaLiAnNaEnum.AllSlotAIFuncType[var_6_0]

	arg_6_0._typeKey = var_6_1

	local var_6_2 = arg_6_0:getHandleFunc(var_6_1)

	if isDebugBuild then
		local var_6_3 = var_0_0.instance.getName(var_6_1)

		logNormal("AI本次tick: " .. var_6_3)
	end

	if var_6_2 then
		var_6_2(arg_6_0)
	end
end

function var_0_0._attAckSlot(arg_7_0)
	local var_7_0 = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local var_7_1 = {}

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1 and iter_7_1:canAI() and iter_7_1:getSoliderPercent() >= arg_7_0.attackTriggerRate then
				local var_7_2 = arg_7_0._shortestPaths(iter_7_1:getId())

				for iter_7_2 = 1, #var_7_2 do
					local var_7_3 = var_7_2[iter_7_2]

					if var_7_3 ~= nil and #var_7_3 >= 2 then
						table.insert(var_7_1, var_7_3)
					end
				end
			end
		end
	end

	table.sort(var_7_1, function(arg_8_0, arg_8_1)
		local var_8_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_8_0[1])
		local var_8_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_8_1[1])

		if var_8_0:getSoliderPercent() == var_8_1:getSoliderPercent() then
			local var_8_2 = arg_7_0.getPathAllLength(arg_8_0)
			local var_8_3 = arg_7_0.getPathAllLength(arg_8_1)

			if var_8_2 == var_8_3 then
				local var_8_4 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_8_0[#arg_8_0])
				local var_8_5 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_8_1[#arg_8_1])

				return var_8_4:getSoliderCount() < var_8_5:getSoliderCount()
			end

			return var_8_2 < var_8_3
		end

		return var_8_0:getSoliderPercent() > var_8_1:getSoliderPercent()
	end)

	local var_7_4, var_7_5 = arg_7_0:getDisPatchPath(var_7_1, Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot)

	return arg_7_0._disPatch(var_7_4, var_7_5)
end

function var_0_0._attackRoad(arg_9_0)
	local var_9_0 = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local var_9_1 = {}

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			if iter_9_1 and iter_9_1:canAI() and iter_9_1:getSoliderPercent() >= arg_9_0.positiveMoveTriggerRate then
				local var_9_2 = arg_9_0._shortestPaths(iter_9_1:getId())

				for iter_9_2 = 1, #var_9_2 do
					local var_9_3 = var_9_2[iter_9_2]

					table.remove(var_9_3, #var_9_3)

					if var_9_3 ~= nil and #var_9_3 >= 2 then
						table.insert(var_9_1, var_9_3)
					end
				end
			end
		end
	end

	table.sort(var_9_1, function(arg_10_0, arg_10_1)
		local var_10_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_10_0[1])
		local var_10_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_10_1[1])

		if var_10_0:getSoliderPercent() == var_10_1:getSoliderPercent() then
			local var_10_2 = arg_9_0.getPathAllLength(arg_10_0)
			local var_10_3 = arg_9_0.getPathAllLength(arg_10_1)

			if var_10_2 == var_10_3 then
				local var_10_4 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_10_0[#arg_10_0])
				local var_10_5 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_10_1[#arg_10_1])

				return var_10_4:getSoliderCount() < var_10_5:getSoliderCount()
			end

			return var_10_2 < var_10_3
		end

		return var_10_0:getSoliderPercent() > var_10_1:getSoliderPercent()
	end)

	local var_9_4, var_9_5 = arg_9_0:getDisPatchPath(var_9_1, Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad)

	return arg_9_0._disPatch(var_9_4, var_9_5)
end

function var_0_0._retreat(arg_11_0)
	local var_11_0 = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			if iter_11_1 and iter_11_1:canAI() then
				local var_11_2 = arg_11_0._shortestPathsToEnemyMain(iter_11_1:getId())

				for iter_11_2 = 1, #var_11_2 do
					local var_11_3 = var_11_2[iter_11_2]

					if var_11_3 ~= nil and #var_11_3 >= 2 then
						local var_11_4 = #var_11_3 - 2

						for iter_11_3 = 1, var_11_4 do
							local var_11_5 = tabletool.copy(var_11_3)

							for iter_11_4 = 1, iter_11_3 do
								table.remove(var_11_5, #var_11_5)
							end

							table.insert(var_11_1, var_11_3)
						end
					end
				end
			end
		end
	end

	table.sort(var_11_1, function(arg_12_0, arg_12_1)
		local var_12_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_12_0[1])
		local var_12_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_12_1[1])

		if var_12_0:getSoliderPercent() == var_12_1:getSoliderPercent() then
			if var_12_0:getSoliderCount() == var_12_0:getSoliderCount() then
				local var_12_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_12_0[#arg_12_0])
				local var_12_3 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_12_1[#arg_12_1])

				return var_12_2:getSoliderCount() > var_12_3:getSoliderCount()
			end

			return var_12_0:getSoliderCount() < var_12_0:getSoliderCount()
		end

		return var_12_0:getSoliderPercent() < var_12_1:getSoliderPercent()
	end)

	local var_11_6, var_11_7 = arg_11_0:getDisPatchPath(var_11_1, Activity201MaLiAnNaEnum.SlotAIFuncType.retreat)

	return arg_11_0._disPatch(var_11_6, var_11_7)
end

function var_0_0._helpSlot(arg_13_0)
	local var_13_0 = Activity201MaLiAnNaGameModel.instance:getAllSlot()
	local var_13_1 = {}

	if var_13_0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			if iter_13_1 and iter_13_1:canAI() and Activity201MaLiAnNaGameModel.instance:isInAttackState(iter_13_1) then
				local var_13_2 = arg_13_0._findTargetCampPaths(iter_13_1:getId(), Activity201MaLiAnNaEnum.CampType.Enemy)

				for iter_13_2 = 1, #var_13_2 do
					local var_13_3 = var_13_2[iter_13_2]

					if var_13_3 ~= nil and #var_13_3 >= 2 then
						tabletool.revert(var_13_3)
						table.insert(var_13_1, var_13_3)
					end
				end
			end
		end
	end

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		local var_14_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_14_0[#arg_14_0])
		local var_14_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_14_1[#arg_14_1])

		if var_14_0:getSoliderPercent() == var_14_1:getSoliderPercent() then
			if var_14_0:getSoliderCount() == var_14_1:getSoliderCount() then
				return arg_13_0.getPathAllLength(arg_14_0) < arg_13_0.getPathAllLength(arg_14_1)
			end

			return var_14_0:getSoliderCount() > var_14_1:getSoliderCount()
		end

		return var_14_0:getSoliderPercent() > var_14_1:getSoliderPercent()
	end)

	local var_13_4, var_13_5 = arg_13_0:getDisPatchPath(var_13_1, Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot)

	return arg_13_0._disPatch(var_13_4, var_13_5)
end

function var_0_0.getDisPatchPath(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		return nil, false
	end

	if arg_15_2 == Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot and not arg_15_0._heroGoFrontOrNot then
		return table.remove(arg_15_1, 1), false
	end

	if var_0_0.simpleProbabilityTrigger(arg_15_0._heroMoveRate) then
		local var_15_0 = #arg_15_1

		for iter_15_0 = 1, var_15_0 do
			local var_15_1 = arg_15_1[iter_15_0]
			local var_15_2 = var_15_1[1]
			local var_15_3 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_15_2)

			if var_15_3 and var_15_3:getHeroSoliderList() ~= 0 then
				return var_15_1, true
			end
		end
	else
		return table.remove(arg_15_1, 1), false
	end
end

function var_0_0._disPatch(arg_16_0, arg_16_1)
	if arg_16_0 == nil or #arg_16_0 < 2 then
		return false
	end

	local var_16_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_16_0[1])

	if var_16_0:canDispatch() then
		local var_16_1 = Activity201MaLiAnNaGameModel.instance:getNextDisPatchId()

		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowDisPatchPath, var_16_1, Activity201MaLiAnNaEnum.CampType.Enemy, arg_16_0)
		var_16_0:setDispatchSoldierInfo(var_16_1, arg_16_0, arg_16_1)

		if isDebugBuild then
			local var_16_2 = var_0_0.instance._typeKey
			local var_16_3 = var_0_0.instance.getName(var_16_2)

			logNormal("AI本次tick: [执行]" .. var_16_3 .. " slotId: " .. var_16_0:getConfig().baseId .. " 剩余派遣数量：" .. var_16_0._dispatchValue .. "当前时间：" .. os.time())
		end

		return true
	end

	return false
end

function var_0_0._shortestPathToEnemyMainBFS(arg_17_0)
	return var_0_0._shortestPathBFSFuncCheck(arg_17_0, function(arg_18_0)
		local var_18_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_18_0)
		local var_18_1 = var_18_0:getSlotCamp()
		local var_18_2 = var_18_0:getConfig()

		return var_18_1 == Activity201MaLiAnNaEnum.CampType.Enemy and var_18_2.isHQ
	end)
end

function var_0_0._shortestPathBFS(arg_19_0)
	return var_0_0._shortestPathBFSFuncCheck(arg_19_0, function(arg_20_0)
		local var_20_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_20_0):getSlotCamp()

		return var_20_0 == Activity201MaLiAnNaEnum.CampType.Player or var_20_0 == Activity201MaLiAnNaEnum.CampType.Middle
	end)
end

function var_0_0._findTargetCampPathBFS(arg_21_0, arg_21_1)
	return var_0_0._shortestPathBFSFuncCheck(arg_21_0, function(arg_22_0)
		return Activity201MaLiAnNaGameModel.instance:getSlotById(arg_22_0):getSlotCamp() == arg_21_1
	end)
end

function var_0_0._shortestPathBFSFuncCheck(arg_23_0, arg_23_1)
	local var_23_0 = Activity201MaLiAnNaGameModel.instance:getRoadGraph()
	local var_23_1 = {
		{
			arg_23_0
		}
	}
	local var_23_2 = {
		[arg_23_0] = true
	}

	while #var_23_1 > 0 do
		local var_23_3 = table.remove(var_23_1, 1)
		local var_23_4 = var_23_3[#var_23_3]

		if arg_23_1 and arg_23_1(var_23_4) then
			return var_23_3
		end

		for iter_23_0, iter_23_1 in ipairs(var_23_0[var_23_4] or {}) do
			if not var_23_2[iter_23_1] then
				var_23_2[iter_23_1] = true

				local var_23_5 = tabletool.copy(var_23_3)

				table.insert(var_23_5, iter_23_1)
				table.insert(var_23_1, var_23_5)
			end
		end
	end

	return nil
end

function var_0_0.getPathAllLength(arg_24_0)
	if not arg_24_0 or #arg_24_0 < 2 then
		return 0
	end

	local var_24_0 = 0

	for iter_24_0 = 1, #arg_24_0 - 1 do
		local var_24_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_24_0[iter_24_0])
		local var_24_2 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_24_0[iter_24_0 + 1])

		if var_24_1 and var_24_2 then
			var_24_0 = var_24_0 + var_24_1:getDistanceTo(var_24_2)
		end
	end

	return var_24_0
end

function var_0_0._shortestPathsToEnemyMain(arg_25_0)
	return var_0_0.findAllPaths(arg_25_0, function(arg_26_0)
		if arg_26_0 == nil then
			return false
		end

		local var_26_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_26_0)
		local var_26_1 = var_26_0:getSlotCamp()
		local var_26_2 = var_26_0:getConfig()

		return var_26_1 == Activity201MaLiAnNaEnum.CampType.Enemy and var_26_2.isHQ
	end)
end

function var_0_0._shortestPaths(arg_27_0)
	return var_0_0.findAllPaths(arg_27_0, function(arg_28_0)
		if arg_28_0 == nil then
			return false
		end

		local var_28_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_28_0):getSlotCamp()

		return var_28_0 == Activity201MaLiAnNaEnum.CampType.Player or var_28_0 == Activity201MaLiAnNaEnum.CampType.Middle
	end)
end

function var_0_0._findTargetCampPaths(arg_29_0, arg_29_1)
	return var_0_0.findAllPaths(arg_29_0, function(arg_30_0)
		return Activity201MaLiAnNaGameModel.instance:getSlotById(arg_30_0):getSlotCamp() == arg_29_1
	end)
end

function var_0_0.findAllPaths(arg_31_0, arg_31_1)
	local var_31_0 = Activity201MaLiAnNaGameModel.instance:getRoadGraph()
	local var_31_1 = {}
	local var_31_2 = {}

	local function var_31_3(arg_32_0, arg_32_1)
		var_31_1[arg_32_0] = true

		table.insert(arg_32_1, arg_32_0)

		if arg_31_1 and arg_31_1(arg_32_0) and arg_32_0 ~= arg_31_0 then
			table.insert(var_31_2, tabletool.copy(arg_32_1))
		else
			for iter_32_0, iter_32_1 in pairs(var_31_0[arg_32_0] or {}) do
				local var_32_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_31_0)
				local var_32_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_32_0)

				if not var_31_1[iter_32_1] and var_32_1:getSlotCamp() == var_32_0:getSlotCamp() then
					var_31_3(iter_32_1, arg_32_1)
				end
			end
		end

		var_31_1[arg_32_0] = false

		table.remove(arg_32_1)
	end

	var_31_3(arg_31_0, {})

	local var_31_4 = 0

	for iter_31_0 = 1, #var_31_2 do
		local var_31_5 = var_31_2[iter_31_0]

		if var_31_4 > #var_31_5 or var_31_4 == 0 then
			var_31_4 = #var_31_5
		end
	end

	if var_31_4 ~= 0 then
		for iter_31_1 = #var_31_2, 1, -1 do
			if #var_31_2[iter_31_1] ~= var_31_4 then
				table.remove(var_31_2, iter_31_1)
			end
		end
	end

	return var_31_2
end

function var_0_0.simpleProbabilityTrigger(arg_33_0)
	return arg_33_0 > math.random()
end

function var_0_0.guaranteedTrigger(arg_34_0, arg_34_1)
	local var_34_0 = 0

	return function()
		var_34_0 = var_34_0 + 1

		if var_34_0 >= arg_34_1 then
			var_34_0 = 0

			return true
		end

		return math.random() < arg_34_0
	end
end

function var_0_0.getName(arg_36_0)
	local var_36_0 = ""

	if Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot == arg_36_0 then
		var_36_0 = "攻击"
	end

	if Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad == arg_36_0 then
		var_36_0 = "有效调兵"
	end

	if Activity201MaLiAnNaEnum.SlotAIFuncType.retreat == arg_36_0 then
		var_36_0 = "无效调兵"
	end

	if Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot == arg_36_0 then
		var_36_0 = "支援"
	end

	return var_36_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
