module("modules.logic.signin.controller.work.ActivityDoubleFestivalSignWork_1_3", package.seeall)

local var_0_0 = class("ActivityDoubleFestivalSignWork_1_3", BaseWork)
local var_0_1 = ActivityEnum.Activity.DoubleFestivalSign_1_3

function var_0_0.onStart(arg_1_0)
	if not ActivityModel.instance:isActOnLine(var_0_1) then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenViewFinish, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_1_0._refreshNorSignActivity, arg_1_0)
	Activity101Rpc.instance:sendGet101InfosRequest(var_0_1)
end

function var_0_0._refreshNorSignActivity(arg_2_0)
	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_0_1) then
		arg_2_0:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.ActivityDoubleFestivalSignPaiLianView_1_3)
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		arg_3_0:onDone(true)
	end
end

function var_0_0._onOpenViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 ~= ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		return
	end

	arg_4_0:_endBlock()
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_5_0._refreshNorSignActivity, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
end

function var_0_0._endBlock(arg_6_0)
	if not arg_6_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._isBlock(arg_7_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return var_0_0
