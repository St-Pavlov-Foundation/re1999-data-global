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
	if not ActivityModel.instance:isActOnLine(VersionActivity3_1Enum.ActivityId.NationalGift) then
		return
	end

	Activity212Rpc.instance:sendGetAct212InfoRequest(VersionActivity3_1Enum.ActivityId.NationalGift)
end

function NationalGiftController:openNationalGiftBuyTipView(param)
	ViewMgr.instance:openView(ViewName.NationalGiftBuyTipView, param)
end

NationalGiftController.instance = NationalGiftController.New()

return NationalGiftController
