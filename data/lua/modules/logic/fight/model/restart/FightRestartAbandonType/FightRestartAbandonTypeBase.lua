module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonTypeBase", package.seeall)

local var_0_0 = class("FightRestartAbandonTypeBase", UserDataDispose)

function var_0_0.episodeCostIsEnough(arg_1_0)
	arg_1_0._box_type = MessageBoxIdDefine.RestartStage62

	if not string.nilorempty(arg_1_0._episode_config.failCost) then
		local var_1_0 = string.splitToNumber(arg_1_0._episode_config.failCost, "#")

		if var_1_0[3] == 0 then
			return true
		end

		local var_1_1, var_1_2 = ItemModel.instance:getItemConfigAndIcon(var_1_0[1], var_1_0[2])

		if var_1_1 then
			local var_1_3 = MessageBoxIdDefine.RestartStage62
			local var_1_4 = ItemModel.instance:getItemQuantity(var_1_0[1], var_1_0[2])
			local var_1_5 = string.splitToNumber(arg_1_0._episode_config.cost, "#")[3]
			local var_1_6 = false

			if var_1_0[1] == 2 and var_1_0[2] == 4 then
				local var_1_7 = FightModel.instance:getFightParam()
				local var_1_8 = var_1_7 and var_1_7.episodeId

				var_1_6 = true

				local var_1_9 = DungeonConfig.instance:getEpisodeCO(var_1_8)
				local var_1_10 = var_1_9 and DungeonConfig.instance:getChapterCO(var_1_9.chapterId)

				if var_1_10 and var_1_10.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_1_10.type) > 0 then
					var_1_3 = MessageBoxIdDefine.DungeonEquipRestart
					var_1_6 = true
				end
			else
				var_1_3 = MessageBoxIdDefine.RestartStage63
				var_1_6 = var_1_5 <= var_1_4 - var_1_0[3]
			end

			arg_1_0._box_type = var_1_3
			arg_1_0._cost_item_config = var_1_1

			if var_1_6 then
				return true
			else
				GameFacade.showMessageBox(arg_1_0._box_type, MsgBoxEnum.BoxType.Yes_No, function()
					GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_1_2, var_1_1.name)
				end, function()
					FightSystem.instance:cancelRestart()
				end, nil, nil, nil, nil, arg_1_0._cost_item_config.name)

				return false
			end
		end
	else
		return true
	end

	return false
end

function var_0_0.confirmNotice(arg_4_0)
	local var_4_0 = arg_4_0._cost_item_config and arg_4_0._cost_item_config.name

	GameFacade.showMessageBox(arg_4_0._box_type, MsgBoxEnum.BoxType.Yes_No, function()
		FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_4_0._onPushEndFight, arg_4_0)

		if arg_4_0.IS_DEAD then
			ToastController.instance:showToast(-80)

			return
		end

		arg_4_0:startAbandon()
	end, function()
		FightSystem.instance:cancelRestart()
	end, nil, nil, nil, nil, var_4_0)
end

function var_0_0._onPushEndFight(arg_7_0)
	arg_7_0.IS_DEAD = true

	FightSystem.instance:cancelRestart()

	if arg_7_0._box_type then
		ViewMgr.instance:closeView(ViewName.MessageBoxView)
	end
end

function var_0_0.abandon(arg_8_0)
	if arg_8_0.confirmNotice then
		FightController.instance:registerCallback(FightEvent.PushEndFight, arg_8_0._onPushEndFight, arg_8_0, LuaEventSystem.High)
		arg_8_0:confirmNotice()
	else
		arg_8_0:startAbandon()
	end
end

function var_0_0.releaseEvent(arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_9_0._onPushEndFight, arg_9_0)
end

function var_0_0.canRestart(arg_10_0)
	return
end

function var_0_0.startAbandon(arg_11_0)
	return
end

return var_0_0
