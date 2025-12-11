module("modules.logic.store.controller.StoreGoodsTaskController", package.seeall)

local var_0_0 = class("StoreGoodsTaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	StoreController.instance:registerCallback(StoreEvent.StoreInfoChanged, arg_3_0._onStoreInfoChanged, arg_3_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_3_0._onStoreInfoChanged, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	SummonController.instance:registerCallback(SummonEvent.onSummonProgressRewards, arg_3_0.waitUpdateRedDot, arg_3_0)
	SummonController.instance:registerCallback(SummonEvent.onReceiveSummonReply, arg_3_0._onCancelWaitRewardTask, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._isRunUdateInfo = false
	arg_4_0._waitRewardtaskIdList = nil
	arg_4_0._lockSendTaskTimeDict = nil
end

function var_0_0._onStoreInfoChanged(arg_5_0)
	if not arg_5_0._isRunUdateInfo then
		arg_5_0._isRunUdateInfo = true

		arg_5_0:requestGoodsTaskList()
	end
end

function var_0_0._onFinishTask(arg_6_0, arg_6_1)
	if StoreConfig.instance:getChargeConditionalConfig(arg_6_1) then
		arg_6_0:waitUpdateRedDot()
	end
end

function var_0_0._onCancelWaitRewardTask(arg_7_0)
	if arg_7_0._waitRewardtaskIdList then
		arg_7_0._waitRewardtaskIdList = nil

		TaskDispatcher.cancelTask(arg_7_0._onRunwaitRewardTask, arg_7_0)
	end
end

function var_0_0._onUpdateTaskList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and arg_8_1.taskInfo

	if not var_8_0 then
		return
	end

	local var_8_1 = StoreConfig.instance

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = var_8_0[iter_8_0]

		if var_8_1:getChargeConditionalConfig(var_8_2.id) then
			if var_8_2.progress > var_8_2.finishCount then
				if arg_8_0._waitRewardtaskIdList == nil then
					arg_8_0._waitRewardtaskIdList = {}

					TaskDispatcher.runDelay(arg_8_0._onRunwaitRewardTask, arg_8_0, 0.1)
				end

				if not tabletool.indexOf(arg_8_0._waitRewardtaskIdList) then
					table.insert(arg_8_0._waitRewardtaskIdList, var_8_2.id)
				end
			end

			arg_8_0:waitUpdateRedDot()
		end
	end
end

function var_0_0._onRunwaitRewardTask(arg_9_0)
	local var_9_0 = arg_9_0._waitRewardtaskIdList

	arg_9_0._waitRewardtaskIdList = nil

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_9_0:_sendFinishTaskRequest(iter_9_1)
		end
	end
end

function var_0_0._sendFinishTaskRequest(arg_10_0, arg_10_1)
	arg_10_0._lockSendTaskTimeDict = arg_10_0._lockSendTaskTimeDict or {}

	if not arg_10_0._lockSendTaskTimeDict[arg_10_1] or arg_10_0._lockSendTaskTimeDict[arg_10_1] < Time.time then
		arg_10_0._lockSendTaskTimeDict[arg_10_1] = Time.time + 3

		TaskRpc.instance:sendFinishTaskRequest(arg_10_1)
	end
end

function var_0_0._getKeyPoolId(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or 0

	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreGoodsTaskPoolNewRed .. arg_11_1)
end

function var_0_0.clearNewRedDotByPoolId(arg_12_0, arg_12_1)
	PlayerPrefsHelper.setNumber(arg_12_0:_getKeyPoolId(arg_12_1), 1)
end

function var_0_0.isHasNewRedDotByPoolId(arg_13_0, arg_13_1)
	local var_13_0 = StoreConfig.instance:getCharageGoodsCfgListByPoolId(arg_13_1)

	if var_13_0 and PlayerPrefsHelper.getNumber(arg_13_0:_getKeyPoolId(arg_13_1), 0) == 0 and not SummonModel.instance:getSummonFullExSkillHero(arg_13_1) then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			local var_13_1 = iter_13_1.id
			local var_13_2 = StoreModel.instance:getGoodsMO(var_13_1)

			if var_13_2 and var_13_2.buyCount == 0 and StoreCharageConditionalHelper.isCharageCondition(var_13_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.waitUpdateRedDot(arg_14_0)
	if not arg_14_0._isHasWaitUpdateRedDoTask then
		arg_14_0._isHasWaitUpdateRedDoTask = true

		TaskDispatcher.runDelay(arg_14_0._onWaitUpdateRedDot, arg_14_0, 0.2)
	end
end

function var_0_0._onWaitUpdateRedDot(arg_15_0)
	arg_15_0._isHasWaitUpdateRedDoTask = false

	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function var_0_0.isHasCanFinishTaskByPoolId(arg_16_0, arg_16_1)
	local var_16_0 = StoreConfig.instance:getCharageGoodsCfgListByPoolId(arg_16_1)

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(iter_16_1.id) then
				return true
			end
		end
	end

	return false
end

function var_0_0.autoFinishTaskByPoolId(arg_17_0, arg_17_1)
	local var_17_0 = false
	local var_17_1 = StoreConfig.instance:getCharageGoodsCfgListByPoolId(arg_17_1)

	if var_17_1 then
		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(iter_17_1.id) then
				var_17_0 = true

				arg_17_0:_sendFinishTaskRequest(iter_17_1.taskid)
			end
		end
	end

	if var_17_0 then
		arg_17_0:requestGoodsTaskList()
	end

	return var_17_0
end

function var_0_0.requestGoodsTaskList(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {
		TaskEnum.TaskType.StoreLinkPackage
	}

	TaskRpc.instance:sendGetTaskInfoRequest(var_18_0, arg_18_1, arg_18_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
