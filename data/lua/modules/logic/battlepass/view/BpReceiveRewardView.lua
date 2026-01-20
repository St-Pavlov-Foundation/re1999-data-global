-- chunkname: @modules/logic/battlepass/view/BpReceiveRewardView.lua

module("modules.logic.battlepass.view.BpReceiveRewardView", package.seeall)

local BpReceiveRewardView = class("BpReceiveRewardView", BaseView)

function BpReceiveRewardView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "mask")
end

function BpReceiveRewardView:addEvents()
	self:addClickCb(self.btnClose, self.closeThis, self)
end

function BpReceiveRewardView:onOpen()
	self:refresh()
end

function BpReceiveRewardView:onClose()
	return
end

function BpReceiveRewardView:onDestroyView()
	return
end

function BpReceiveRewardView:refresh()
	return
end

return BpReceiveRewardView
