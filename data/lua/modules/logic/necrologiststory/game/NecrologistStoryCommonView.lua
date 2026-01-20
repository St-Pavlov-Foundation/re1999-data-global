-- chunkname: @modules/logic/necrologiststory/game/NecrologistStoryCommonView.lua

module("modules.logic.necrologiststory.game.NecrologistStoryCommonView", package.seeall)

local NecrologistStoryCommonView = class("NecrologistStoryCommonView", BaseView)

function NecrologistStoryCommonView:onInitView()
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self.goRewardRed = gohelper.findChild(self.viewGO, "#btn_reward/#go_reddot")
	self.goRewardTime = gohelper.findChild(self.viewGO, "#btn_reward/#go_time")
	self.txtRewardTime = gohelper.findChildTextMesh(self.viewGO, "#btn_reward/#go_time/#txt_time")
	self.txtRewardTimeFormat = gohelper.findChildTextMesh(self.viewGO, "#btn_reward/#go_time/#txt_time/#txt_format")
	self.btnReview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_review")
	self.animReward = self.btnReward.gameObject:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryCommonView:addEvents()
	self:addClickCb(self.btnReward, self.onClickBtnReward, self)
	self:addClickCb(self.btnReview, self.onClickBtnReview, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryCommonView:removeEvents()
	self:removeClickCb(self.btnReward)
	self:removeClickCb(self.btnReview)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryCommonView:_editableInitView()
	return
end

function NecrologistStoryCommonView:onClickBtnReward()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openTaskView(self.gameBaseMO.id)
end

function NecrologistStoryCommonView:onClickBtnReview()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openReviewView(self.gameBaseMO.id)
end

function NecrologistStoryCommonView:_onCloseViewFinish(viewName)
	self:refreshView()
end

function NecrologistStoryCommonView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function NecrologistStoryCommonView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function NecrologistStoryCommonView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)

	RedDotController.instance:addRedDot(self.goRewardRed, RedDotEnum.DotNode.NecrologistStoryTask, storyId, self.refreshRed, self)
end

function NecrologistStoryCommonView:refreshView()
	self:refreshRewardTime()
	self:refreshButton()
end

function NecrologistStoryCommonView:refreshRed(redDot)
	redDot:defaultRefreshDot()

	if redDot.show then
		self.animReward:Play("lingqu")
	else
		self.animReward:Play("idle")
	end
end

function NecrologistStoryCommonView:refreshRewardTime()
	local hasLimitTaskNotFinish = NecrologistStoryTaskListModel.instance:hasLimitTaskNotFinish(self.gameBaseMO.id)

	gohelper.setActive(self.goRewardTime, hasLimitTaskNotFinish)

	if not hasLimitTaskNotFinish then
		return
	end

	self:_frameRefreshRewardTime()
	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	TaskDispatcher.runDelay(self._frameRefreshRewardTime, self, 1)
end

function NecrologistStoryCommonView:_frameRefreshRewardTime()
	if not self.gameBaseMO then
		return
	end

	local cfg = RoleStoryConfig.instance:getStoryById(self.gameBaseMO.id)
	local activityId = cfg.activityId
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local time, timeFormat = TimeUtil.secondToRoughTime2(offsetSecond, true)

		self.txtRewardTime.text = time
		self.txtRewardTimeFormat.text = timeFormat
	else
		gohelper.setActive(self.goRewardTime, false)
		TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	end
end

function NecrologistStoryCommonView:refreshButton()
	local hasPlotFinish = NecrologistStoryModel.instance:isReviewCanShow(self.gameBaseMO.id)

	gohelper.setActive(self.btnReview, hasPlotFinish)
end

function NecrologistStoryCommonView:onDestroyView()
	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
end

return NecrologistStoryCommonView
