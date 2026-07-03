-- chunkname: @modules/logic/abyss/controller/AbyssController.lua

module("modules.logic.abyss.controller.AbyssController", package.seeall)

local AbyssController = class("AbyssController", BaseController)

function AbyssController:onInit()
	logNormal("AbyssController init")
end

function AbyssController:onInitFinish()
	return
end

function AbyssController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._refreshTaskData, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._refreshTaskData, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
end

function AbyssController:reInit()
	self._requestTask = false
end

function AbyssController:_refreshTaskData()
	self:dispatchEvent(AbyssEvent.OnAbyssTaskUpdate)
end

function AbyssController:_onDailyRefresh()
	if not AbyssModel.instance:isFunctionUnlock() then
		return
	end

	if AbyssModel.instance:isCurActOpen(false) then
		self:getTaskInfo()
	end
end

function AbyssController:getTaskInfo(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Abyss
	}, callback, callbackObj)
end

function AbyssController:openTaskView()
	self:getTaskInfo(self._openTaskView, self)
end

function AbyssController:_openTaskView()
	ViewMgr.instance:openView(ViewName.AbyssTaskView)
end

function AbyssController:getActivityInfo(actId, callback, callbackObj)
	if actId then
		AbyssRpc.instance:sendGetAct229InfoRequest(actId, callback, callbackObj)
	end
end

function AbyssController:openMainView(actId, refreshInfo)
	if actId then
		AbyssModel.instance:setCurActId(actId)
	else
		actId = AbyssModel.instance:getCurActId()
	end

	if refreshInfo then
		self:getActivityInfo(actId, self._openMainView, self)
	else
		self:_openMainView()
	end
end

function AbyssController:_openMainView()
	ViewMgr.instance:openView(ViewName.AbyssMainView)
end

function AbyssController:startFight()
	if AbyssModel.instance:getCurStageMo() == nil then
		return
	end

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Abyss

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._startFight, self)
end

function AbyssController:_startFight()
	local stageId = AbyssModel.instance:getCurStageId()
	local actId = AbyssModel.instance:getCurActId()
	local stageConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(stageConfig.episodeId)

	DungeonFightController.instance:enterFight(episodeConfig.chapterId, stageConfig.episodeId, nil)
end

function AbyssController:enterFight(param, callback, callbackObj)
	AbyssRpc.instance:sendStartAct229BattleRequest(param, callback, callbackObj)
end

function AbyssController:tryResetCurStage()
	local stageInfoMo = AbyssModel.instance:getCurStageMo()
	local isLock = stageInfoMo and stageInfoMo:isChallenged()

	if isLock then
		GameFacade.showMessageBox(MessageBoxIdDefine.AbyssRestTeamTip, MsgBoxEnum.BoxType.Yes_No, self.realResetCurStage, nil, nil, self)
	end
end

function AbyssController:realResetCurStage()
	local actId = AbyssModel.instance:getCurActId()
	local stageId = AbyssModel.instance:getCurStageId()

	self:resetStage(actId, stageId)
end

function AbyssController:resetStage(actId, stageId)
	AbyssRpc.instance:sendAct229ResetStageRequest(actId, stageId)
end

function AbyssController:openFightSuccView()
	ViewMgr.instance:openView(ViewName.AbyssFightSuccView)
end

function AbyssController:onReconnectFight(param)
	local episodeId = param.episodeId
	local actId = AbyssConfig.instance:getActIdByEpisodeId(episodeId)
	local stageId = param.stageId

	AbyssModel.instance:setCurActId(actId)
	AbyssModel.instance:setCurStageId(stageId)
end

function AbyssController:statCheckInformation(entrance, episodeId)
	StatController.instance:track(StatEnum.EventName.CheckLevelInformation, {
		[StatEnum.EventProperties.AbyssEntrance] = entrance or StatEnum.AbyssEntranceEnum.Conditions,
		[StatEnum.EventProperties.AbyssEpisodeId] = tostring(episodeId) or "0"
	})
end

AbyssController.instance = AbyssController.New()

return AbyssController
