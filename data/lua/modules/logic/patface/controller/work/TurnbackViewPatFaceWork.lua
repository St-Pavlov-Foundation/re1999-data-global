-- chunkname: @modules/logic/patface/controller/work/TurnbackViewPatFaceWork.lua

module("modules.logic.patface.controller.work.TurnbackViewPatFaceWork", package.seeall)

local TurnbackViewPatFaceWork = class("TurnbackViewPatFaceWork", PatFaceWorkBase)

function TurnbackViewPatFaceWork:checkCanPat()
	local canShowPop = false

	if TurnbackModel.instance:getCurTurnbackId() > 2 then
		canShowPop = TurnbackModel.instance:haveOnceBonusReward()
	else
		canShowPop = TurnbackModel.instance:canShowTurnbackPop()
	end

	local isInOpenTime = TurnbackModel.instance:isInOpenTime()
	local result = canShowPop and isInOpenTime

	return result
end

function TurnbackViewPatFaceWork:startPat()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)

	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:_openView()
	TurnbackRpc.instance:sendTurnbackFirstShowRequest(self.turnbackId)
end

function TurnbackViewPatFaceWork:_openView()
	local isNewType = TurnbackModel.instance:isNewType()

	if isNewType then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView)
	else
		ViewMgr.instance:openView(self._patViewName)
	end
end

function TurnbackViewPatFaceWork:onCloseViewFinish(viewName)
	if string.nilorempty(self._patViewName) or self._patViewName == viewName or viewName == ViewName.TurnbackNewLatterView then
		self:patComplete()
		TurnbackRpc.instance:sendTurnbackFirstShowRequest(self.turnbackId)
	end
end

function TurnbackViewPatFaceWork:customerClearWork()
	self.turnbackId = nil
end

return TurnbackViewPatFaceWork
