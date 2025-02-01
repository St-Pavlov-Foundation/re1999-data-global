module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonTypeBase", package.seeall)

slot0 = class("FightRestartAbandonTypeBase", UserDataDispose)

function slot0.episodeCostIsEnough(slot0)
	slot0._box_type = MessageBoxIdDefine.RestartStage62

	if not string.nilorempty(slot0._episode_config.failCost) then
		if string.splitToNumber(slot0._episode_config.failCost, "#")[3] == 0 then
			return true
		end

		slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

		if slot2 then
			slot4 = MessageBoxIdDefine.RestartStage62
			slot5 = ItemModel.instance:getItemQuantity(slot1[1], slot1[2])
			slot6 = string.splitToNumber(slot0._episode_config.cost, "#")[3]
			slot7 = false

			if slot1[1] == 2 and slot1[2] == 4 then
				slot7 = true

				if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam() and slot8.episodeId) and DungeonConfig.instance:getChapterCO(slot10.chapterId) and slot11.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot11.type) > 0 then
					slot4 = MessageBoxIdDefine.DungeonEquipRestart
					slot7 = true
				end
			else
				slot4 = MessageBoxIdDefine.RestartStage63
				slot7 = slot6 <= slot5 - slot1[3]
			end

			slot0._box_type = slot4
			slot0._cost_item_config = slot2

			if slot7 then
				return true
			else
				GameFacade.showMessageBox(slot0._box_type, MsgBoxEnum.BoxType.Yes_No, function ()
					GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, uv0, uv1.name)
				end, function ()
					FightSystem.instance:cancelRestart()
				end, nil, , , , slot0._cost_item_config.name)

				return false
			end
		end
	else
		return true
	end

	return false
end

function slot0.confirmNotice(slot0)
	GameFacade.showMessageBox(slot0._box_type, MsgBoxEnum.BoxType.Yes_No, function ()
		FightController.instance:unregisterCallback(FightEvent.PushEndFight, uv0._onPushEndFight, uv0)

		if uv0.IS_DEAD then
			ToastController.instance:showToast(-80)

			return
		end

		uv0:startAbandon()
	end, function ()
		FightSystem.instance:cancelRestart()
	end, nil, , , , slot0._cost_item_config and slot0._cost_item_config.name)
end

function slot0._onPushEndFight(slot0)
	slot0.IS_DEAD = true

	FightSystem.instance:cancelRestart()

	if slot0._box_type then
		ViewMgr.instance:closeView(ViewName.MessageBoxView)
	end
end

function slot0.abandon(slot0)
	if slot0.confirmNotice then
		FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0, LuaEventSystem.High)
		slot0:confirmNotice()
	else
		slot0:startAbandon()
	end
end

function slot0.releaseEvent(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0)
end

function slot0.canRestart(slot0)
end

function slot0.startAbandon(slot0)
end

return slot0
