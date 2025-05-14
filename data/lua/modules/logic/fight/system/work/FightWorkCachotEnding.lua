module("modules.logic.fight.system.work.FightWorkCachotEnding", package.seeall)

local var_0_0 = class("FightWorkCachotEnding", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not var_1_0 or var_1_0.type ~= DungeonEnum.EpisodeType.Cachot then
		arg_1_0:onDone(true)

		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() ~= nil then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseViewFinish, arg_1_0)
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.V1a6_CachotResultView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
