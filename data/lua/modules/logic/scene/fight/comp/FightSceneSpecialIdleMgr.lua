module("modules.logic.scene.fight.comp.FightSceneSpecialIdleMgr", package.seeall)

local var_0_0 = class("FightSceneSpecialIdleMgr", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.PlaySpecialIdle, arg_1_0._onPlaySpecialIdle, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, arg_1_0._releaseEntity, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._releaseAllEntity, arg_1_0)

	arg_1_0._entity_dic = {}
	arg_1_0._play_dic = {}
end

function var_0_0.onSceneClose(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_2_0._onStageChange, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.PlaySpecialIdle, arg_2_0._onPlaySpecialIdle, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnEntityDead, arg_2_0._releaseEntity, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_2_0._releaseAllEntity, arg_2_0)
	arg_2_0:_releaseAllEntity()

	arg_2_0._entity_dic = nil
	arg_2_0._play_dic = nil
end

function var_0_0._onStageChange(arg_3_0, arg_3_1)
	if arg_3_1 == FightEnum.Stage.Card then
		local var_3_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.spine then
				local var_3_1 = iter_3_1:getMO()

				if var_0_0.Condition[var_3_1.modelId] then
					if not arg_3_0._entity_dic[var_3_1.id] then
						arg_3_0._entity_dic[var_3_1.id] = _G["EntitySpecialIdle" .. var_0_0.Condition[var_3_1.modelId]].New(iter_3_1)
					end

					if arg_3_0._entity_dic[var_3_1.id].detectState then
						arg_3_0._entity_dic[var_3_1.id]:detectState()
					end
				end
			end
		end

		arg_3_0:_detectCanPlay()
	end
end

function var_0_0._detectCanPlay(arg_4_0)
	if arg_4_0._play_dic then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._play_dic) do
			local var_4_0 = FightHelper.getEntity(iter_4_1)

			if var_4_0 then
				local var_4_1 = lua_skin_special_act.configDict[var_4_0:getMO().modelId]

				if var_4_1 and math.random(0, 100) <= var_4_1.probability and var_4_0.spine.tryPlay and var_4_0.spine:tryPlay(SpineAnimState.idle_special1, var_4_1.loop == 1 and true) then
					arg_4_0._entityPlayActName = arg_4_0._entityPlayActName or {}
					arg_4_0._entityPlayActName[var_4_0.id] = FightHelper.processEntityActionName(var_4_0, SpineAnimState.idle_special1)

					var_4_0.spine:addAnimEventCallback(arg_4_0._onAnimEvent, arg_4_0, var_4_0)
				end
			end
		end
	end

	arg_4_0._play_dic = {}
end

function var_0_0._onAnimEvent(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0._entityPlayActName and arg_5_2 == SpineAnimEvent.ActionComplete and arg_5_1 == arg_5_0._entityPlayActName[arg_5_4.id] then
		arg_5_4.spine:removeAnimEventCallback(arg_5_0._onAnimEvent, arg_5_0)
		arg_5_4:resetAnimState()
	end
end

function var_0_0._onPlaySpecialIdle(arg_6_0, arg_6_1)
	arg_6_0._play_dic[arg_6_1] = arg_6_1
end

function var_0_0._releaseEntity(arg_7_0, arg_7_1)
	if arg_7_0._entity_dic and arg_7_0._entity_dic[arg_7_1] then
		if arg_7_0._entityPlayActName then
			arg_7_0._entityPlayActName[arg_7_1] = nil
		end

		arg_7_0._entity_dic[arg_7_1]:releaseSelf()

		arg_7_0._entity_dic[arg_7_1] = nil

		local var_7_0 = FightHelper.getEntity(arg_7_1)

		if var_7_0 and var_7_0.spine then
			var_7_0.spine:removeAnimEventCallback(arg_7_0._onAnimEvent, arg_7_0)
		end
	end
end

function var_0_0._releaseAllEntity(arg_8_0)
	if arg_8_0._entity_dic then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._entity_dic) do
			arg_8_0:_releaseEntity(iter_8_1.id)
		end
	end

	arg_8_0._play_dic = {}
end

var_0_0.Condition = {
	[3003] = 2,
	[3025] = 6,
	[3039] = 8,
	[3009] = 5,
	[3032] = 7,
	[3004] = 3,
	[3052] = 3,
	[3047] = 9,
	[3051] = 1,
	[3007] = 4
}

return var_0_0
