module("modules.logic.versionactivity1_5.sportsnews.model.SportsNewsModel", package.seeall)

local var_0_0 = class("SportsNewsModel", BaseModel)

function var_0_0.finishOrder(arg_1_0, arg_1_1, arg_1_2)
	Activity106Rpc.instance:sendGet106OrderBonusRequest(arg_1_1, arg_1_2, 1, function()
		ActivityWarmUpController.instance:dispatchEvent(ActivityWarmUpEvent.PlayOrderFinish, {
			actId = arg_1_1,
			orderId = arg_1_2
		})
	end, arg_1_0)
end

function var_0_0.onReadEnd(arg_3_0, arg_3_1, arg_3_2)
	SportsNewsRpc.instance:sendFinishReadTaskRequest(arg_3_1, arg_3_2)
	arg_3_0:finishOrder(arg_3_1, arg_3_2)
end

function var_0_0.getSelectedDayTask(arg_4_0, arg_4_1)
	return ActivityWarmUpTaskListModel.instance._taskGroup and ActivityWarmUpTaskListModel.instance._taskGroup[arg_4_1]
end

function var_0_0.getJumpToTab(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._JumpOrderId

	if not var_5_0 then
		return nil
	end

	return (var_0_0.instance:getDayByOrderId(arg_5_1, var_5_0))
end

function var_0_0.setJumpToOrderId(arg_6_0, arg_6_1)
	arg_6_0._JumpOrderId = arg_6_1
end

function var_0_0.getDayByOrderId(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = Activity106Config.instance:getActivityWarmUpOrderCo(arg_7_1, arg_7_2)

	return var_7_0 and var_7_0.openDay
end

function var_0_0.getPrefs(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getPrefsKey(arg_8_1)

	return (PlayerPrefsHelper.getNumber(var_8_0, 0))
end

function var_0_0.setPrefs(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getPrefsKey(arg_9_1)

	PlayerPrefsHelper.setNumber(var_9_0, 1)
end

function var_0_0.getPrefsKey(arg_10_0, arg_10_1)
	local var_10_0 = VersionActivity1_5Enum.ActivityId.SportsNews
	local var_10_1 = PlayerModel.instance:getPlayinfo().userId

	return string.format("%s#%s#%s", var_10_0, var_10_1, arg_10_1)
end

function var_0_0.hasCanFinishOrder(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = ActivityWarmUpModel.instance:getAllOrders()

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_2 = false

		if iter_11_1.cfg.listenerType == "ReadTask" then
			if iter_11_1.status ~= ActivityWarmUpEnum.OrderStatus.Finished then
				var_11_2 = true
			end
		elseif iter_11_1.status == ActivityWarmUpEnum.OrderStatus.Collected then
			var_11_2 = true
		end

		if var_11_2 then
			local var_11_3 = iter_11_1.cfg.openDay
			local var_11_4 = {
				iter_11_1.id
			}

			if not var_11_0[var_11_3] then
				var_11_0[var_11_3] = {}
			end

			table.insert(var_11_0[var_11_3], var_11_4)
		end
	end

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
