module("modules.logic.main.controller.work.Activity125SimpleGiftWorkBase", package.seeall)

local var_0_0 = class("Activity125SimpleGiftWorkBase", SimpleGiftWorkBase)

function var_0_0.onStart(arg_1_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_1_0._onDataUpdate, arg_1_0)
	var_0_0.super.onStart(arg_1_0)
end

function var_0_0.clearWork(arg_2_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_2_0._onDataUpdate, arg_2_0)
	var_0_0.super.clearWork(arg_2_0)
end

function var_0_0._onDataUpdate(arg_3_0)
	local var_3_0 = arg_3_0._actId
	local var_3_1 = arg_3_0._viewName

	if not var_3_0 then
		return
	end

	local var_3_2 = Activity125Model.instance:getById(var_3_0)

	if not var_3_2 then
		return
	end

	if var_3_2:isEpisodeFinished(1) then
		if ViewMgr.instance:isOpen(var_3_1) then
			return
		end

		arg_3_0:_work()

		return
	end

	local var_3_3 = {
		actId = var_3_0
	}

	ViewMgr.instance:openView(var_3_1, var_3_3)
end

function var_0_0.onWork(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._actId

	if ActivityHelper.getActivityStatus(var_4_0, true) == ActivityEnum.ActivityStatus.Normal then
		arg_4_1.bAutoWorkNext = false

		Activity125Rpc.instance:sendGetAct125InfosRequest(var_4_0)
	else
		arg_4_1.bAutoWorkNext = true
	end
end

return var_0_0
