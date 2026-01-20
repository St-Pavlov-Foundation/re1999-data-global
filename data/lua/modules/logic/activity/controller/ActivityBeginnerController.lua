-- chunkname: @modules/logic/activity/controller/ActivityBeginnerController.lua

module("modules.logic.activity.controller.ActivityBeginnerController", package.seeall)

local ActivityBeginnerController = class("ActivityBeginnerController", BaseController)

function ActivityBeginnerController:onInit()
	self:_initHandlers()
end

function ActivityBeginnerController:reInit()
	return
end

function ActivityBeginnerController:_initHandlers()
	if self._handlerList then
		return
	end

	self._actTypeIdFirstEndterMap = {
		[ActivityEnum.ActivityTypeID.Act201] = true,
		[ActivityEnum.ActivityTypeID.Act209] = true,
		[ActivityEnum.ActivityTypeID.Act212] = true,
		[ActivityEnum.ActivityTypeID.Act214] = true,
		[ActivityEnum.ActivityTypeID.Act100] = true
	}
	self._actIdFirstEndterMap = {
		[ActivityEnum.Activity.DreamShow] = true,
		[ActivityEnum.Activity.V2a2_TurnBack_H5] = true,
		[VersionActivity2_2Enum.ActivityId.LimitDecorate] = true,
		[VersionActivity3_2Enum.ActivityId.ActivityCollect] = true,
		[VersionActivity3_2Enum.ActivityId.CruiseTripleDrop] = true
	}
	self._handlerList = {
		[ActivityEnum.Activity.StoryShow] = {
			self.checkRedDotWithActivityId,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.DreamShow] = {
			self.checkRedDot,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.ClassShow] = {
			self.checkRedDotWithActivityId,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.V2a4_WarmUp] = {
			self.checkRedDotWithActivityId,
			Activity125Controller.checkRed_Task
		}
	}
	self._defaultHandler = {
		self.checkRedDotWithActivityId
	}
end

function ActivityBeginnerController:showRedDot(activityId)
	local handlers = self._handlerList[activityId]

	if not handlers then
		if activityId == DoubleDropModel.instance:getActId() then
			handlers = self._handlerList[ActivityEnum.Activity.ClassShow]
		else
			handlers = self._defaultHandler
		end
	end

	for i, handler in ipairs(handlers) do
		local result = handler(self, activityId)

		if result then
			return true
		end
	end

	if (self._actIdFirstEndterMap[activityId] or activityId == DoubleDropModel.instance:getActId()) and self:checkFirstEnter(activityId) then
		return true
	end

	local actCo = ActivityConfig.instance:getActivityCo(activityId)

	if actCo and self._actTypeIdFirstEndterMap[actCo.typeId] and self:checkFirstEnter(activityId) then
		return true
	end

	return false
end

function ActivityBeginnerController:_getRedDotId(activityId)
	local config = ActivityConfig.instance:getActivityCo(activityId)

	if not config then
		return 0
	end

	local reddotid = config.redDotId

	if reddotid > 0 then
		return reddotid
	end

	local center = config.showCenter

	config = ActivityConfig.instance:getActivityCenterCo(center)

	if not config then
		return 0
	end

	reddotid = config.reddotid

	return reddotid
end

function ActivityBeginnerController:checkRedDot(activityId)
	local reddotid = self:_getRedDotId(activityId)

	if reddotid > 0 then
		return RedDotModel.instance:isDotShow(reddotid)
	end

	return false
end

function ActivityBeginnerController:checkRedDotWithActivityId(activityId)
	local reddotid = self:_getRedDotId(activityId)

	if reddotid > 0 then
		return RedDotModel.instance:isDotShow(reddotid, activityId)
	end

	return false
end

function ActivityBeginnerController:checkFirstEnter(activityId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local data = PlayerPrefsHelper.getString(key, "")

	return string.nilorempty(data)
end

function ActivityBeginnerController:setFirstEnter(activityId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")
end

function ActivityBeginnerController:checkActivityNewStage(activityId)
	return ActivityModel.instance:getActivityInfo()[activityId]:isNewStageOpen()
end

ActivityBeginnerController.instance = ActivityBeginnerController.New()

return ActivityBeginnerController
