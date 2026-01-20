-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_AchievementView.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_AchievementView", package.seeall)

local V1a6_BossRush_AchievementView = class("V1a6_BossRush_AchievementView", BaseView)

function V1a6_BossRush_AchievementView:onInitView()
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/#go_AssessIcon")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/#txt_ScoreNum")
	self._scrollScoreList = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_ScoreList")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isFirstOpen = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_AchievementView:addEvents()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self:addEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
end

function V1a6_BossRush_AchievementView:removeEvents()
	self:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._refresh, self)
	self:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._refresh, self)
	self:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._refresh, self)
	self:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, self._refresh, self)
end

function V1a6_BossRush_AchievementView:_editableInitView()
	return
end

function V1a6_BossRush_AchievementView:onUpdateParam()
	return
end

function V1a6_BossRush_AchievementView:onOpen()
	self.stage = self.viewParam.stage

	self:_initAssessIcon()
	gohelper.setActive(self._goRight, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	local anim = self._isFirstOpen and BossRushEnum.V1a6_BonusViewAnimName.Open or BossRushEnum.V1a6_BonusViewAnimName.In

	self:playAnim(anim)

	self._isFirstOpen = nil
	self._scrollScoreList.verticalNormalizedPosition = 1

	self:_refresh()
end

function V1a6_BossRush_AchievementView:onClose()
	gohelper.setActive(self._goRight, false)

	if self._assessIcon then
		self._assessIcon:onClose()
	end

	self:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
end

function V1a6_BossRush_AchievementView:onDestroyView()
	if self._assessIcon then
		self._assessIcon:onDestroyView()
	end
end

function V1a6_BossRush_AchievementView:_initAssessIcon()
	if not self._assessIcon then
		local itemClass = V1a4_BossRush_Task_AssessIcon
		local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, self._goAssessIcon, itemClass.__cname)

		self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
	end

	local bonusTab = BossRushModel.instance:getActivityBonus()
	local tab = bonusTab and bonusTab[V1a6_BossRush_BonusModel.instance:getTab()]
	local highestPoint = BossRushModel.instance:getHighestPoint(self.stage)

	if tab.SpModel and tab.SpModel.instance.getHighestPoint then
		highestPoint = tab.SpModel.instance:getHighestPoint(self.stage)
	end

	self._assessIcon:setData(self.stage, highestPoint, false)

	self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
end

function V1a6_BossRush_AchievementView:_refresh()
	self:_refreshRight()
end

function V1a6_BossRush_AchievementView:_refreshRight()
	V1a6_BossRush_BonusModel.instance:selecAchievementTab(self.stage)
end

function V1a6_BossRush_AchievementView:playAnim(name, callback, callbackobj)
	if self._animatorPlayer then
		self._animatorPlayer:Play(name, callback, callbackobj)
	end
end

return V1a6_BossRush_AchievementView
