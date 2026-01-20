-- chunkname: @modules/logic/commandstation/view/CommandStationPaperViewContainer.lua

module("modules.logic.commandstation.view.CommandStationPaperViewContainer", package.seeall)

local CommandStationPaperViewContainer = class("CommandStationPaperViewContainer", BaseViewContainer)

function CommandStationPaperViewContainer:buildViews()
	return {
		CommandStationPaperView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function CommandStationPaperViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function CommandStationPaperViewContainer:playOpenTransition()
	local animatorPlayer = self:__getAnimatorPlayer()

	if not animatorPlayer or not animatorPlayer.isActiveAndEnabled then
		self:onPlayOpenTransitionFinish()

		return
	end

	local anim = "open1"
	local sec = 2
	local paperList = CommandStationConfig.instance:getPaperList()
	local prePaperCo = paperList[CommandStationModel.instance.paper]
	local nowPaperCo = paperList[CommandStationModel.instance.paper + 1]
	local preTotalNum = prePaperCo and CommandStationConfig.instance:getCurTotalPaperCount(prePaperCo.versionId) or 0
	local nowNum = CommandStationConfig.instance:getCurPaperCount() - preTotalNum

	if nowPaperCo and nowNum >= nowPaperCo.allNum then
		anim = "open2"
	end

	CommandStationPaperViewContainer.super.playOpenTransition(self, {
		anim = anim,
		duration = sec
	})
end

return CommandStationPaperViewContainer
