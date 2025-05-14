module("modules.logic.versionactivity1_6.v1a6_warmup.controller.Activity156Controller", package.seeall)

local var_0_0 = class("Activity156Controller", BaseController)

function var_0_0.getAct125InfoFromServer(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or ActivityEnum.Activity.Activity1_6WarmUp

	Activity156Rpc.instance:sendGetAct125InfosRequest(arg_1_1)
end

function var_0_0.onFinishActEpisode(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	Activity156Rpc.instance:sendFinishAct125EpisodeRequest(arg_2_1, arg_2_2, arg_2_3)
end

local var_0_1 = PlayerPrefsKey.FirstEnterAct125Today .. "#" .. ActivityEnum.Activity.Activity1_6WarmUp .. "#"

function var_0_0.isActFirstEnterToday(arg_3_0)
	local var_3_0 = var_0_1 .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_3_1 = ServerTime.nowInLocal()
	local var_3_2 = os.date("*t", var_3_1)

	if PlayerPrefsHelper.hasKey(var_3_0) then
		local var_3_3 = tonumber(PlayerPrefsHelper.getString(var_3_0, var_3_1))

		var_3_2.hour = 5
		var_3_2.min = 0
		var_3_2.sec = 0

		local var_3_4 = os.time(var_3_2)

		if var_3_3 and TimeUtil.getDiffDay(var_3_1, var_3_3) < 1 and (var_3_1 - var_3_4) * (var_3_3 - var_3_4) > 0 then
			return false
		end
	end

	return true
end

function var_0_0.saveEnterActDateInfo(arg_4_0)
	local var_4_0 = var_0_1 .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_4_1 = ServerTime.nowInLocal()

	PlayerPrefsHelper.setString(var_4_0, tostring(var_4_1))
end

function var_0_0.setCurSelectedEpisode(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= Activity156Model.instance:getCurSelectedEpisode() then
		if Activity156Model.instance:isEpisodeUnLock(arg_5_1) then
			Activity156Model.instance:setCurSelectedEpisode(arg_5_1)

			if not arg_5_2 then
				arg_5_0:notifyUpdateView()
			end
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function var_0_0.tryReceiveEpisodeRewards(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or ActivityEnum.Activity.Activity1_6WarmUp

	local var_6_0 = Activity156Model.instance:getCurSelectedEpisode()

	if not Activity156Model.instance:isEpisodeHasReceivedReward(var_6_0) then
		Activity156Rpc.instance:sendFinishAct125EpisodeRequest(arg_6_1, var_6_0)
	end
end

function var_0_0.notifyUpdateView(arg_7_0)
	var_0_0.instance:dispatchEvent(Activity156Event.DataUpdate)
end

var_0_0.instance = var_0_0.New()

return var_0_0
