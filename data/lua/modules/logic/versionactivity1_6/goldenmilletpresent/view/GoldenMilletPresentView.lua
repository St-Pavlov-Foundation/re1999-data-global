-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/view/GoldenMilletPresentView.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentView", package.seeall)

local GoldenMilletPresentView = class("GoldenMilletPresentView", BaseViewExtended)

function GoldenMilletPresentView:onInitView()
	self._goReceiveView = gohelper.findChild(self.viewGO, "#go_ReceiveView")
	self._goDisplayView = gohelper.findChild(self.viewGO, "#go_DisplayView")

	gohelper.setActive(self._goReceiveView, false)
	gohelper.setActive(self._goDisplayView, false)
end

function GoldenMilletPresentView:onOpen()
	local isDisplayView = self.viewParam and self.viewParam.isDisplayView or false

	self:switchExclusiveView(isDisplayView)
end

function GoldenMilletPresentView:switchExclusiveView(isDisplayView)
	self._showingReceiveView = true

	local exclusiveViewIndex = self.viewContainer.ExclusiveView.ReceiveView
	local exclusiveView = GoldenMilletPresentReceiveView
	local exclusiveViewGO = self._goReceiveView

	if isDisplayView then
		exclusiveViewIndex = self.viewContainer.ExclusiveView.DisplayView
		exclusiveView = GoldenMilletPresentDisplayView
		exclusiveViewGO = self._goDisplayView
		self._showingReceiveView = false
	end

	self:openExclusiveView(nil, exclusiveViewIndex, exclusiveView, exclusiveViewGO)
end

function GoldenMilletPresentView:onClickModalMask()
	if self._showingReceiveView then
		self:switchExclusiveView(true)
	else
		self:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return GoldenMilletPresentView
