module("modules.logic.versionactivity1_5.act146.controller.Activity146Controller", package.seeall)

local var_0_0 = class("Activity146Controller", BaseController)

function var_0_0.getAct146InfoFromServer(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or ActivityEnum.Activity.Activity1_5WarmUp

	Activity146Rpc.instance:sendGetAct146InfosRequest(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	Activity146Model.instance:setCurSelectedEpisode(nil)
end

function var_0_0.onFinishActEpisode(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or ActivityEnum.Activity.Activity1_5WarmUpId

	local var_3_0 = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Rpc.instance:sendFinishAct146EpisodeRequest(arg_3_1, var_3_0)
end

function var_0_0.tryReceiveEpisodeRewards(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or ActivityEnum.Activity.Activity1_5WarmUpId

	local var_4_0 = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Rpc.instance:sendAct146EpisodeBonusRequest(arg_4_1, var_4_0)
end

local var_0_1 = "Activity146"

function var_0_0.isActFirstEnterToday(arg_5_0)
	return TimeUtil.getDayFirstLoginRed(var_0_1)
end

function var_0_0.saveEnterActDateInfo(arg_6_0)
	TimeUtil.setDayFirstLoginRed(var_0_1)
end

function var_0_0.setCurSelectedEpisode(arg_7_0, arg_7_1)
	if arg_7_1 ~= Activity146Model.instance:getCurSelectedEpisode() then
		if Activity146Model.instance:isEpisodeUnLock(arg_7_1) then
			Activity146Model.instance:setCurSelectedEpisode(arg_7_1)
			arg_7_0:notifyUpdateView()
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function var_0_0.onActModelUpdate(arg_8_0)
	local var_8_0 = arg_8_0:computeCurNeedSelectEpisode()

	Activity146Model.instance:setCurSelectedEpisode(var_8_0)
	arg_8_0:notifyUpdateView()
end

function var_0_0.computeCurNeedSelectEpisode(arg_9_0)
	local var_9_0 = Activity146Model.instance:getCurSelectedEpisode()

	if var_9_0 then
		return var_9_0
	end

	local var_9_1 = Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp)

	if var_9_1 then
		local var_9_2 = #var_9_1
		local var_9_3

		for iter_9_0 = 1, var_9_2 do
			local var_9_4 = var_9_1[iter_9_0].id
			local var_9_5 = Activity146Model.instance:isEpisodeFinishedButUnReceive(var_9_4)
			local var_9_6 = Activity146Model.instance:isEpisodeUnLockAndUnFinish(var_9_4)

			if Activity146Model.instance:isEpisodeUnLock(var_9_4) then
				var_9_3 = var_9_4
			end

			if var_9_5 or var_9_6 then
				return var_9_4
			end
		end

		return var_9_3
	end
end

function var_0_0.markHasEnterEpisode(arg_10_0)
	local var_10_0 = Activity146Model.instance:getCurSelectedEpisode()

	Activity146Model.instance:markHasEnterEpisode(var_10_0)
end

function var_0_0.notifyUpdateView(arg_11_0)
	var_0_0.instance:dispatchEvent(Activity146Event.DataUpdate)
end

var_0_0.instance = var_0_0.New()

return var_0_0
