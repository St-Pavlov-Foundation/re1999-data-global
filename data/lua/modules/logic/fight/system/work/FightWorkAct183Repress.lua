module("modules.logic.fight.system.work.FightWorkAct183Repress", package.seeall)

local var_0_0 = class("FightWorkAct183Repress", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not var_1_0 or var_1_0.type ~= DungeonEnum.EpisodeType.Act183 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = Act183Model.instance:getBattleFinishedInfo()

	if not var_1_1 or not var_1_1.win then
		arg_1_0:onDone(true)

		return
	end

	local var_1_2 = var_1_1.activityId

	if ActivityHelper.getActivityStatus(var_1_2) ~= ActivityEnum.ActivityStatus.Normal then
		arg_1_0:onDone(true)

		return
	end

	local var_1_3 = var_1_1.episodeMo

	if not Act183Helper.isLastPassEpisodeInGroup(var_1_3) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseViewFinish, arg_1_0)
		Act183Controller.instance:openAct183RepressView(var_1_1)

		return
	end

	arg_1_0:onDone(true)
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.Act183RepressView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
