module("modules.logic.main.controller.work.ActivityRoleSignWorkBase", package.seeall)

local var_0_0 = class("ActivityRoleSignWorkBase", SimpleGiftWorkBase)

function var_0_0.onStart(arg_1_0)
	var_0_0.super.onStart(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_1_0._refreshNorSignActivity, arg_1_0)
end

function var_0_0.clearWork(arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0._refreshNorSignActivity, arg_2_0)
	var_0_0.super.clearWork(arg_2_0)
end

function var_0_0._refreshNorSignActivity(arg_3_0)
	local var_3_0 = arg_3_0._actId
	local var_3_1 = arg_3_0._viewName

	if not var_3_0 then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_3_0) then
		if ViewMgr.instance:isOpen(var_3_1) then
			return
		end

		arg_3_0:_work()

		return
	end

	local var_3_2 = {
		actId = var_3_0
	}

	ViewMgr.instance:openView(var_3_1, var_3_2)
end

function var_0_0.onWork(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._actId

	if ActivityType101Model.instance:isOpen(var_4_0) then
		arg_4_1.bAutoWorkNext = false

		Activity101Rpc.instance:sendGet101InfosRequest(var_4_0)
	else
		arg_4_1.bAutoWorkNext = true
	end
end

return var_0_0
