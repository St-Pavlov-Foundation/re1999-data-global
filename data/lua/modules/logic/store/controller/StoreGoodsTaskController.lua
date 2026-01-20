-- chunkname: @modules/logic/store/controller/StoreGoodsTaskController.lua

module("modules.logic.store.controller.StoreGoodsTaskController", package.seeall)

local StoreGoodsTaskController = class("StoreGoodsTaskController", BaseController)

function StoreGoodsTaskController:onInit()
	return
end

function StoreGoodsTaskController:onInitFinish()
	return
end

function StoreGoodsTaskController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	StoreController.instance:registerCallback(StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onStoreInfoChanged, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	SummonController.instance:registerCallback(SummonEvent.onSummonProgressRewards, self.waitUpdateRedDot, self)
	SummonController.instance:registerCallback(SummonEvent.onReceiveSummonReply, self._onCancelWaitRewardTask, self)
end

function StoreGoodsTaskController:reInit()
	self._isRunUdateInfo = false
	self._waitRewardtaskIdList = nil
	self._lockSendTaskTimeDict = nil
end

function StoreGoodsTaskController:_onStoreInfoChanged()
	if not self._isRunUdateInfo then
		self._isRunUdateInfo = true

		self:requestGoodsTaskList()
	end
end

function StoreGoodsTaskController:_onFinishTask(taskId)
	if StoreConfig.instance:getChargeConditionalConfig(taskId) then
		self:waitUpdateRedDot()
	end
end

function StoreGoodsTaskController:_onCancelWaitRewardTask()
	if self._waitRewardtaskIdList then
		self._waitRewardtaskIdList = nil

		TaskDispatcher.cancelTask(self._onRunwaitRewardTask, self)
	end
end

function StoreGoodsTaskController:_onUpdateTaskList(msg)
	local taskInfoList = msg and msg.taskInfo

	if not taskInfoList then
		return
	end

	local tStoreConfig = StoreConfig.instance

	for i = 1, #taskInfoList do
		local taskInfo = taskInfoList[i]

		if tStoreConfig:getChargeConditionalConfig(taskInfo.id) then
			if taskInfo.progress > taskInfo.finishCount then
				if self._waitRewardtaskIdList == nil then
					self._waitRewardtaskIdList = {}

					TaskDispatcher.runDelay(self._onRunwaitRewardTask, self, 0.1)
				end

				if not tabletool.indexOf(self._waitRewardtaskIdList) then
					table.insert(self._waitRewardtaskIdList, taskInfo.id)
				end
			end

			self:waitUpdateRedDot()
		end
	end
end

function StoreGoodsTaskController:_onRunwaitRewardTask()
	local taskIdList = self._waitRewardtaskIdList

	self._waitRewardtaskIdList = nil

	if taskIdList then
		for _, taskid in ipairs(taskIdList) do
			self:_sendFinishTaskRequest(taskid)
		end
	end
end

function StoreGoodsTaskController:_sendFinishTaskRequest(taskid)
	self._lockSendTaskTimeDict = self._lockSendTaskTimeDict or {}

	if not self._lockSendTaskTimeDict[taskid] or self._lockSendTaskTimeDict[taskid] < Time.time then
		self._lockSendTaskTimeDict[taskid] = Time.time + 3

		TaskRpc.instance:sendFinishTaskRequest(taskid)
	end
end

function StoreGoodsTaskController:_getKeyPoolId(poolId)
	poolId = poolId or 0

	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreGoodsTaskPoolNewRed .. poolId)
end

function StoreGoodsTaskController:clearNewRedDotByPoolId(poolId)
	PlayerPrefsHelper.setNumber(self:_getKeyPoolId(poolId), 1)
end

function StoreGoodsTaskController:isHasNewRedDotByPoolId(poolId)
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList and PlayerPrefsHelper.getNumber(self:_getKeyPoolId(poolId), 0) == 0 and not SummonModel.instance:getSummonFullExSkillHero(poolId) then
		for _, goodsCfg in ipairs(goodsCfgList) do
			local goodsId = goodsCfg.id
			local storePackageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

			if storePackageGoodsMO and storePackageGoodsMO.buyCount == 0 and StoreCharageConditionalHelper.isCharageCondition(goodsId) then
				return true
			end
		end
	end

	return false
end

function StoreGoodsTaskController:waitUpdateRedDot()
	if not self._isHasWaitUpdateRedDoTask then
		self._isHasWaitUpdateRedDoTask = true

		TaskDispatcher.runDelay(self._onWaitUpdateRedDot, self, 0.2)
	end
end

function StoreGoodsTaskController:_onWaitUpdateRedDot()
	self._isHasWaitUpdateRedDoTask = false

	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function StoreGoodsTaskController:isHasCanFinishTaskByPoolId(poolId)
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsCfg.id) then
				return true
			end
		end
	end

	return false
end

function StoreGoodsTaskController:autoFinishTaskByPoolId(poolId)
	local flag = false
	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(poolId)

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			if StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsCfg.id) then
				flag = true

				self:_sendFinishTaskRequest(goodsCfg.taskid)
			end
		end
	end

	if flag then
		self:requestGoodsTaskList()
	end

	return flag
end

function StoreGoodsTaskController:requestGoodsTaskList(callback, callbackObj)
	local typeIds = {
		TaskEnum.TaskType.StoreLinkPackage
	}

	TaskRpc.instance:sendGetTaskInfoRequest(typeIds, callback, callbackObj)
end

StoreGoodsTaskController.instance = StoreGoodsTaskController.New()

return StoreGoodsTaskController
