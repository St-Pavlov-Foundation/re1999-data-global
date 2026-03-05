-- chunkname: @modules/logic/versionactivity3_1/nationalgift/controller/NationalGiftController.lua

module("modules.logic.versionactivity3_1.nationalgift.controller.NationalGiftController", package.seeall)

local NationalGiftController = class("NationalGiftController", BaseController)

function NationalGiftController:onInit()
	return
end

function NationalGiftController:reInit()
	return
end

function NationalGiftController:onInitFinish()
	return
end

function NationalGiftController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.checkActivity, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.checkActivity, self)
end

function NationalGiftController:checkActivity()
	local actId = NationalGiftModel.instance:getCurVersionActId()

	if not ActivityModel.instance:isActOnLine(actId) then
		return
	end

	Activity212Rpc.instance:sendGetAct212InfoRequest(actId)
end

function NationalGiftController:openNationalGiftBuyTipView(param)
	ViewMgr.instance:openView(ViewName.NationalGiftBuyTipView, param)
end

NationalGiftController.instance = NationalGiftController.New()

return NationalGiftController
