-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandCompleteView.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteView", package.seeall)

local FairyLandCompleteView = class("FairyLandCompleteView", BaseView)

function FairyLandCompleteView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FairyLandCompleteView:addEvents()
	self:addClickCb(self.btnClose, self.onClickClose, self)
end

function FairyLandCompleteView:removeEvents()
	return
end

function FairyLandCompleteView:onClickClose()
	if self.canClose then
		self:closeThis()
	end
end

function FairyLandCompleteView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_decrypt_succeed)
	TaskDispatcher.runDelay(self.setCanClose, self, 2)

	local param = self.viewParam or {}
	local shapeType = param.shapeType or 1

	self.callback = param.callback
	self.callbackObj = param.callbackObj

	local go = gohelper.findChild(self.viewGO, "#go_Complete/#go_Shape" .. tostring(shapeType))

	gohelper.setActive(go, true)
end

function FairyLandCompleteView:setCanClose()
	self.canClose = true
end

function FairyLandCompleteView:onClose()
	TaskDispatcher.cancelTask(self.setCanClose, self)

	if self.callback then
		self.callback(self.callbackObj)
	end
end

return FairyLandCompleteView
