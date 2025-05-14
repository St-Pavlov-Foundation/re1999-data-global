module("modules.logic.scene.fight.comp.FightScenePreloader", package.seeall)

local var_0_0 = class("FightScenePreloader", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.startPreload(arg_2_0, arg_2_1)
	local var_2_0 = FightModel.instance:getFightParam()
	local var_2_1 = var_2_0 and var_2_0.episodeId
	local var_2_2 = var_2_0 and var_2_0.battleId or var_2_1 and DungeonConfig.instance:getEpisodeBattleId(var_2_1)

	if not arg_2_1 and FightPreloadController.instance:hasPreload(var_2_2) then
		arg_2_0:_onPreloadFinish()

		return
	end

	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = {}
	local var_2_6 = {}
	local var_2_7 = {}
	local var_2_8 = FightDataHelper.entityMgr:getMyNormalList()
	local var_2_9 = FightDataHelper.entityMgr:getEnemyNormalList()
	local var_2_10 = FightDataHelper.entityMgr:getMySubList()

	for iter_2_0, iter_2_1 in ipairs(var_2_8) do
		table.insert(var_2_3, iter_2_1.modelId)
		table.insert(var_2_4, iter_2_1.skin)
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_9) do
		table.insert(var_2_5, iter_2_3.modelId)
		table.insert(var_2_6, iter_2_3.skin)
	end

	for iter_2_4, iter_2_5 in ipairs(var_2_10) do
		table.insert(var_2_7, iter_2_5.skin)
	end

	FightController.instance:registerCallback(FightEvent.OnPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	if FightModel.instance.needFightReconnect then
		FightPreloadController.instance:preloadReconnect(var_2_2, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7)
	elseif arg_2_1 then
		FightPreloadController.instance:preloadSecond(var_2_2, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7)
	else
		FightPreloadController.instance:preloadFirst(var_2_2, var_2_3, var_2_4, var_2_5, var_2_6, var_2_7)
	end
end

function var_0_0._onPreloadFinish(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, arg_3_0._onPreloadFinish, arg_3_0)
	arg_3_0:dispatchEvent(FightSceneEvent.OnPreloadFinish)
end

function var_0_0.onSceneClose(arg_4_0)
	FightPreloadController.instance:dispose()
	FightRoundPreloadController.instance:dispose()
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, arg_4_0._onPreloadFinish, arg_4_0)
end

return var_0_0
