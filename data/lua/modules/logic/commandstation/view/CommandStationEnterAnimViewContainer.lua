-- chunkname: @modules/logic/commandstation/view/CommandStationEnterAnimViewContainer.lua

module("modules.logic.commandstation.view.CommandStationEnterAnimViewContainer", package.seeall)

local CommandStationEnterAnimViewContainer = class("CommandStationEnterAnimViewContainer", BaseViewContainer)

function CommandStationEnterAnimViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationEnterAnimView.New())

	return views
end

function CommandStationEnterAnimViewContainer:playOpenTransition(paramTable)
	self:_cancelBlock()
	self:_stopOpenCloseAnim()

	if not self._viewSetting.anim or self._viewSetting.anim ~= ViewAnim.Default then
		if not string.nilorempty(self._viewSetting.anim) then
			self:_setAnimatorRes()

			if not paramTable or not paramTable.noBlock then
				self:startViewOpenBlock()
			end

			local animatorPlayer = self.viewGO:GetComponent("Animator")

			if not gohelper.isNil(animatorPlayer) then
				local animName = paramTable and paramTable.anim or "open"

				animatorPlayer:Play(animName, 0, 0)
			end

			local duration = 1.033

			TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, duration)
		else
			self:onPlayOpenTransitionFinish()
		end

		return
	end

	if not self._canvasGroup then
		self:onPlayOpenTransitionFinish()

		return
	end

	if not paramTable or not paramTable.noBlock then
		self:startViewOpenBlock()
	end

	self:_animSetAlpha(0.01, true)

	local openViewTime = self._viewSetting.customAnimFadeTime and self._viewSetting.customAnimFadeTime[1] or BaseViewContainer.openViewTime
	local openViewEase = BaseViewContainer.openViewEase

	self._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0.01, 1, openViewTime, self._onOpenTweenFrameCallback, self._onOpenTweenFinishCallback, self, nil, openViewEase)

	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 2)
end

return CommandStationEnterAnimViewContainer
