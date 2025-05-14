module("modules.logic.fight.system.work.FightWorkCachotResult", package.seeall)

local var_0_0 = class("FightWorkCachotResult", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = FightModel.instance:getRecordMO()
	local var_1_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_1_0 and var_1_0.fightResult == FightEnum.FightResult.Succ and var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.Cachot then
		local var_1_2 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

		if var_1_2 and var_1_2:isBattleSuccess() and not ViewMgr.instance:isOpen(ViewName.V1a6_CachotRewardView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseViewFinish, arg_1_0)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, var_1_2)
		else
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0)
	if PopupController.instance:getPopupCount() > 0 then
		return
	end

	local var_2_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if var_2_0 then
		local var_2_1 = var_2_0:getEventCo()

		if var_2_1 and (var_2_1.type ~= V1a6_CachotEnum.EventType.Battle or var_2_1.type == V1a6_CachotEnum.EventType.Battle and var_2_0:isBattleSuccess()) then
			return
		end
	end

	local var_2_2 = {
		ViewName.V1a6_CachotTipsView,
		ViewName.V1a6_CachotRewardView
	}

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		if ViewMgr.instance:isOpen(iter_2_1) then
			return
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
