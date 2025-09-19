module("modules.logic.versionactivity3_1.nationalgift.controller.NationalGiftController", package.seeall)

local var_0_0 = class("NationalGiftController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0.checkActivity, arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_4_0.checkActivity, arg_4_0)
end

function var_0_0.checkActivity(arg_5_0)
	if not ActivityModel.instance:isActOnLine(VersionActivity3_1Enum.ActivityId.NationalGift) then
		return
	end

	Activity212Rpc.instance:sendGetAct212InfoRequest(VersionActivity3_1Enum.ActivityId.NationalGift)
end

function var_0_0.openNationalGiftBuyTipView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.NationalGiftBuyTipView, arg_6_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
