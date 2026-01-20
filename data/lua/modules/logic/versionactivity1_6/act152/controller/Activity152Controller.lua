-- chunkname: @modules/logic/versionactivity1_6/act152/controller/Activity152Controller.lua

module("modules.logic.versionactivity1_6.act152.controller.Activity152Controller", package.seeall)

local Activity152Controller = class("Activity152Controller", BaseController)

function Activity152Controller:_getJoinConditionEpisodeId()
	if self._joinConditionEpisodeId then
		return self._joinConditionEpisodeId
	end

	local activityCO = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve)
	local joinCondition = activityCO.joinCondition

	if string.nilorempty(joinCondition) then
		return nil
	end

	local episodeId = tonumber((string.gsub(joinCondition, "EpisodeFinish=", "")))

	self._joinConditionEpisodeId = episodeId

	return episodeId
end

function Activity152Controller:_unexpectError()
	self:_unregisterListenCheckActUnlock()

	local activityCO = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve)
	local joinCondition = activityCO.joinCondition

	logError("Activity152Controller _unexpectError actId=" .. tostring(ActivityEnum.Activity.NewYearEve) .. " joinCondition=" .. tostring(joinCondition))
end

function Activity152Controller:_unregisterListenCheckActUnlock()
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function Activity152Controller:_onUpdateDungeonInfo()
	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.NewYearEve, true) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local episodeId = self:_getJoinConditionEpisodeId()

	if not episodeId then
		self:_unexpectError()

		return
	end

	if DungeonModel.instance:hasPassLevel(episodeId) then
		ActivityRpc.instance:sendGetActivityInfosRequest(function(_, rc)
			if rc ~= 0 then
				return
			end

			self:_unregisterListenCheckActUnlock()
			self:_startCheckGiftUnlock()
		end)
	end
end

function Activity152Controller:onInit()
	return
end

function Activity152Controller:reInit()
	self._joinConditionEpisodeId = nil

	self:_unregisterListenCheckActUnlock()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	TaskDispatcher.cancelTask(self._checkGiftUnlock, self)
end

function Activity152Controller:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._startCheckGiftUnlock, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
end

function Activity152Controller:_checkActivityInfo()
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		Activity152Rpc.instance:sendGet152InfoRequest(ActivityEnum.Activity.NewYearEve)
	end
end

function Activity152Controller:_onApplicationPause(isFront)
	if isFront then
		self:_startCheckGiftUnlock()
	end
end

function Activity152Controller:_startCheckGiftUnlock()
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		return
	end

	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	local unacceptPresents = Activity152Model.instance:getPresentUnaccepted()

	TaskDispatcher.cancelTask(self._checkGiftUnlock, self)

	local delay = #unacceptPresents > 0 and 0.5 or Activity152Model.instance:getNextUnlockLimitTime() + 0.5

	if delay > 0 then
		TaskDispatcher.runDelay(self._checkGiftUnlock, self, delay)
	end
end

function Activity152Controller:_checkGiftUnlock()
	self._popupFlow = FlowSequence.New()

	self._popupFlow:addWork(Activity152PatFaceWork.New())
	self._popupFlow:registerDoneListener(self._stopShowSequence, self)
	self._popupFlow:start()
end

function Activity152Controller:_stopShowSequence()
	if self._popupFlow then
		self._popupFlow:destroy()

		self._popupFlow = nil
	end

	self:_startCheckGiftUnlock()
end

function Activity152Controller:openNewYearGiftView(giftId)
	ViewMgr.instance:openView(ViewName.NewYearEveGiftView, giftId)
end

Activity152Controller.instance = Activity152Controller.New()

return Activity152Controller
