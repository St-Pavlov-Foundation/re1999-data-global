module("modules.logic.versionactivity1_9.matildagift.controller.V1a9_MatildaGiftController", package.seeall)

local var_0_0 = class("V1a9_MatildaGiftController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._checkActivityInfo(arg_3_0, arg_3_1)
	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.V1a9_Matildagift) == ActivityEnum.ActivityStatus.Normal then
		arg_3_0:sendGet101InfosRequest()
	end
end

function var_0_0.openMatildaGiftView(arg_4_0)
	if not V1a9_MatildaGiftModel.instance:isMatildaGiftOpen(true) then
		return
	end

	arg_4_0:sendGet101InfosRequest(arg_4_0._realOpenMatildaGiftView)
end

function var_0_0._realOpenMatildaGiftView(arg_5_0)
	local var_5_0 = V1a9_MatildaGiftModel.instance:isShowRedDot()

	ViewMgr.instance:openView(ViewName.V1a9_MatildagiftView, {
		isDisplayView = not var_5_0
	})
end

function var_0_0.sendGet101InfosRequest(arg_6_0, arg_6_1)
	local var_6_0 = V1a9_MatildaGiftModel.instance:getMatildagiftActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_6_0, arg_6_1, arg_6_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
