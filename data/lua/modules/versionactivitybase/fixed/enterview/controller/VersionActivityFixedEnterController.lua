-- chunkname: @modules/versionactivitybase/fixed/enterview/controller/VersionActivityFixedEnterController.lua

module("modules.versionactivitybase.fixed.enterview.controller.VersionActivityFixedEnterController", package.seeall)

local VersionActivityFixedEnterController = class("VersionActivityFixedEnterController", BaseController)

function VersionActivityFixedEnterController:_internalOpenView(viewName, actId, customerOpenFunc, customerOpenFuncObj, viewParams, openCb, openCbObj)
	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	if customerOpenFunc then
		customerOpenFunc(customerOpenFuncObj, viewName, actId, viewParams)
	else
		ViewMgr.instance:openView(viewName, viewParams)

		if openCb then
			openCb(openCbObj)
		end
	end
end

function VersionActivityFixedEnterController:_internalOpenEnterView(viewName, actId, viewParams)
	local hasPlayedVideo = VersionActivityBaseController.instance:isPlayedActivityVideo(actId)

	if hasPlayedVideo then
		ViewMgr.instance:openView(viewName, viewParams)

		if self.openEnterViewCb then
			self.openEnterViewCb(self.openEnterViewCbObj)

			self.openEnterViewCb = nil
			self.openEnterViewCbObj = nil
		end
	else
		local activityMo = ActivityModel.instance:getActMO(actId)
		local storyId = activityMo and activityMo.config and activityMo.config.storyId

		if not storyId then
			storyId = 100010

			logError(string.format("act id %s dot config story id", storyId))
		end

		local storyParam = {
			isVersionActivityPV = true
		}
		local storyFinishParams = {
			actId = actId,
			viewName = viewName,
			viewParams = viewParams
		}

		StoryController.instance:playStory(storyId, storyParam, self._onFinishEnterStory, self, storyFinishParams)
	end
end

function VersionActivityFixedEnterController:_onFinishEnterStory(storyFinishParams)
	local enterViewActId = storyFinishParams.actId

	if not VersionActivityEnterHelper.checkCanOpen(enterViewActId) then
		return
	end

	self:_internalOpenEnterView(storyFinishParams.viewName, enterViewActId, storyFinishParams.viewParams)
end

function VersionActivityFixedEnterController:openVersionActivityEnterViewIfNotOpened(openCb, openCbObj, jumpActId, isDirectOpen)
	local viewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if ViewMgr.instance:isOpen(viewName) then
		if openCb then
			openCb(openCbObj)
		end
	else
		self:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen)
	end
end

function VersionActivityFixedEnterController:directOpenVersionActivityEnterView(jumpActId)
	self:openVersionActivityEnterView(nil, nil, jumpActId, true)
end

function VersionActivityFixedEnterController:exitFightEnterView(jumpActId)
	self:openVersionActivityEnterView(nil, nil, jumpActId, true, true)
end

function VersionActivityFixedEnterController:openVersionActivityEnterView(openCb, openCbObj, jumpActId, isDirectOpen, isExitFight)
	self.openEnterViewCb = openCb
	self.openEnterViewCbObj = openCbObj

	local actId = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.EnterView
	local activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivityFixedHelper.getVersionActivityEnum().EnterViewActSetting)
	local viewParams = {
		actId = actId,
		jumpActId = jumpActId,
		activityIdList = activityIdList,
		activitySettingList = VersionActivityFixedHelper.getVersionActivityEnum().EnterViewActSetting,
		isExitFight = isExitFight
	}
	local openFunc

	if isDirectOpen then
		viewParams.isDirectOpen = true
	else
		openFunc = self._internalOpenEnterView
	end

	local viewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	self:_internalOpenView(viewName, actId, openFunc, self, viewParams, self.openEnterViewCb, self.openEnterViewCbObj)
end

VersionActivityFixedEnterController.instance = VersionActivityFixedEnterController.New()

return VersionActivityFixedEnterController
