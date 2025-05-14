module("modules.logic.versionactivity1_7.lantern.controller.LanternFestivalController", package.seeall)

local var_0_0 = class("LanternFestivalController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0._checkActivityInfo, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._checkActivityInfo, arg_3_0)
end

function var_0_0._checkActivityInfo(arg_4_0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.LanternFestival) then
		Activity154Rpc.instance:sendGet154InfosRequest(ActivityEnum.Activity.LanternFestival)
	end
end

function var_0_0.openQuestionTipView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.LanternFestivalQuestionTipView, arg_5_1)
end

function var_0_0.openLanternFestivalView(arg_6_0)
	ViewMgr.instance:openView(ViewName.LanternFestivalView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
