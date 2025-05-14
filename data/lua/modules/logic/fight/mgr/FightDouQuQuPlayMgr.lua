module("modules.logic.fight.mgr.FightDouQuQuPlayMgr", package.seeall)

local var_0_0 = class("FightDouQuQuPlayMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registMsg(FightMsgId.MaybeCrashed, arg_1_0._onMaybeCrashed)
end

function var_0_0._onMaybeCrashed(arg_2_0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

function var_0_0._onPlayDouQuQu(arg_3_0, arg_3_1)
	local var_3_0 = FightDataModel.instance.douQuQuMgr

	if var_3_0.isGM then
		local var_3_1 = var_3_0.gmProto
		local var_3_2 = arg_3_0:com_registFlowSequence()

		var_3_2:registWork(FightWorkDouQuQuGMEnter, var_3_1.fight, var_3_1.startRound, var_3_1.index)

		for iter_3_0, iter_3_1 in ipairs(var_3_1.round) do
			var_3_2:registWork(FightWorkDouQuQuOneRound, iter_3_1)
			var_3_2:registWork(FightWorkDelayTimer, 0.1)
		end

		var_3_2:registWork(FightWorkDouQuQuGMEnd)
		var_3_2:start()
	elseif var_3_0.isGMStartIndex then
		local var_3_3 = var_3_0.playIndexTab
		local var_3_4 = {}

		for iter_3_2, iter_3_3 in ipairs(var_3_3) do
			table.insert(var_3_4, iter_3_3)
		end

		arg_3_0._douQuQuFlow = arg_3_0:com_registFlowSequence()

		local var_3_5 = arg_3_0._douQuQuFlow

		for iter_3_4, iter_3_5 in ipairs(var_3_4) do
			var_3_5:registWork(FightWorkDouQuQuGMForceIndexEnter, iter_3_5, iter_3_4 ~= 1 or arg_3_1)
			var_3_5:registWork(FightWorkDouQuQuRound)
			var_3_5:registWork(FightWorkDelayTimer, 0.1)
			var_3_5:registWork(FightWorkRecordDouQuQuData)
			var_3_5:registWork(FightWorkDouQuQuClear)
		end

		var_3_5:registWork(FightWorkDouQuQuEnd)
		var_3_5:start()
	else
		local var_3_6 = var_3_0.playIndexTab
		local var_3_7 = {}

		for iter_3_6, iter_3_7 in ipairs(var_3_6) do
			table.insert(var_3_7, iter_3_7)
		end

		arg_3_0._douQuQuFlow = arg_3_0:com_registFlowSequence()

		local var_3_8 = arg_3_0._douQuQuFlow

		for iter_3_8, iter_3_9 in ipairs(var_3_7) do
			var_3_8:registWork(FightWorkDouQuQuEnter, iter_3_9, iter_3_8 ~= 1 or arg_3_1)
			var_3_8:registWork(FightWorkDouQuQuRound)
			var_3_8:registWork(FightWorkDelayTimer, 0.1)
			var_3_8:registWork(FightWorkRecordDouQuQuData)
			var_3_8:registWork(FightWorkDouQuQuClear)
			var_3_8:registWork(FightWorkDouQuQuStat)
		end

		var_3_8:registWork(FightWorkDouQuQuEnd)
		var_3_8:start()
	end
end

function var_0_0._onGMDouQuQuSkip2IndexRound(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._douQuQuFlow then
		arg_4_0._douQuQuFlow:disposeSelf()
	end

	local var_4_0 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	local var_4_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_4_0)
	local var_4_2 = var_4_1[math.random(1, #var_4_1)]
	local var_4_3 = var_4_2.id
	local var_4_4 = var_4_2.battleId

	FightMgr.instance:playGMDouQuQuStart(var_4_0, var_4_3, var_4_4, arg_4_1, arg_4_2)
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
