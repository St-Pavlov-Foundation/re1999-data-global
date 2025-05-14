module("modules.logic.fight.system.work.FightWorkAct183Ending", package.seeall)

local var_0_0 = class("FightWorkAct183Ending", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if not var_1_0 or var_1_0.type ~= DungeonEnum.EpisodeType.Act183 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = Act183Model.instance:getBattleFinishedInfo()
	local var_1_2 = var_1_1 and var_1_1.record ~= nil
	local var_1_3 = var_1_1 and var_1_1.episodeMo

	if (var_1_3 and var_1_3:getGroupType()) ~= Act183Enum.GroupType.Daily and var_1_2 then
		local var_1_4 = var_1_1.activityId
		local var_1_5 = {
			activityId = var_1_4,
			groupRecordMo = var_1_1.record
		}

		arg_1_0._flow = FlowSequence.New()

		arg_1_0._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183FinishView, var_1_5))
		arg_1_0._flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Act183SettlementView, var_1_5))
		arg_1_0._flow:addWork(FunctionWork.New(arg_1_0.onDone, arg_1_0, true))
		arg_1_0._flow:start()
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
