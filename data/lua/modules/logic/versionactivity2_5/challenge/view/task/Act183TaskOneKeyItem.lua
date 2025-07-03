module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskOneKeyItem", package.seeall)

local var_0_0 = class("Act183TaskOneKeyItem", Act183TaskBaseItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_getall")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.go, "txt_desc")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	arg_3_0._btngetall:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_0.super.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3)

	arg_4_0._canGetRewardTasks = arg_4_1.data
end

function var_0_0._btngetallOnClick(arg_5_0)
	if not arg_5_0._canGetRewardTasks or #arg_5_0._canGetRewardTasks <= 0 then
		return
	end

	arg_5_0:setBlock(true)
	arg_5_0._animatorPlayer:Play("finish", arg_5_0._sendRpcToFinishTask, arg_5_0)

	arg_5_0._canGetRewardTaskIds = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._canGetRewardTasks) do
		table.insert(arg_5_0._canGetRewardTaskIds, iter_5_1.id)
		Act183Controller.instance:dispatchEvent(Act183Event.ClickToGetReward, iter_5_1.id)
	end
end

function var_0_0._sendRpcToFinishTask(arg_6_0)
	local var_6_0 = Act183Model.instance:getActivityId()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity183, 0, arg_6_0._canGetRewardTaskIds, function(arg_7_0, arg_7_1)
		if arg_7_1 ~= 0 then
			return
		end

		Act183Helper.showToastWhileGetTaskRewards(arg_6_0._canGetRewardTaskIds)
	end, nil, var_6_0)
	arg_6_0:setBlock(false)
end

return var_0_0
