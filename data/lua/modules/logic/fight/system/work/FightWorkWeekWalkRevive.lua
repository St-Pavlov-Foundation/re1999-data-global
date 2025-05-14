module("modules.logic.fight.system.work.FightWorkWeekWalkRevive", package.seeall)

local var_0_0 = class("FightWorkWeekWalkRevive", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = DungeonModel.instance.curSendEpisodeId
	local var_1_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not (var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.WeekWalk) then
		arg_1_0:_done()

		return
	end

	local var_1_2 = WeekWalkModel.instance:getCurMapInfo()

	if not var_1_2 or not var_1_2.isShowSelectCd then
		arg_1_0:_done()

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	WeekWalkController.instance:openWeekWalkReviveView()
end

function var_0_0._onCloseView(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.WeekWalkReviveView then
		arg_2_0:_done()
	end
end

function var_0_0._done(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
end

return var_0_0
