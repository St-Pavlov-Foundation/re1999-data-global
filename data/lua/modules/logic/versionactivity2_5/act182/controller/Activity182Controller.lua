module("modules.logic.versionactivity2_5.act182.controller.Activity182Controller", package.seeall)

local var_0_0 = class("Activity182Controller", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	arg_1_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_1_0.onRefreshActivity, arg_1_0)
end

function var_0_0.getCrazyActId(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(Activity182Enum.CrazyActId) do
		if ActivityModel.instance:isActOnLine(iter_2_1) then
			return iter_2_1
		end
	end
end

function var_0_0.onRefreshActivity(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = Activity182Model.instance:getCurActId()

		if not var_3_0 then
			return
		end

		local var_3_1 = false

		for iter_3_0, iter_3_1 in pairs(Activity182Enum.CrazyActId) do
			if arg_3_1 == iter_3_1 then
				var_3_1 = true

				break
			end
		end

		if var_3_1 then
			if not ActivityModel.instance:isActOnLine(arg_3_1) and AutoChessModel.instance.actId == arg_3_1 then
				GameFacade.showMessageBox(MessageBoxIdDefine.AutoChessCrazyEnd, MsgBoxEnum.BoxType.Yes, arg_3_0.yesCallback, nil, nil, arg_3_0)
			end

			Activity182Rpc.instance:sendGetAct182InfoRequest(var_3_0)
		end
	end
end

function var_0_0.yesCallback(arg_4_0)
	AutoChessModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.AutoChessForcePickView)
	ViewMgr.instance:closeView(ViewName.AutoChessMallView)
	ViewMgr.instance:closeView(ViewName.AutoChessGameView)
	AutoChessGameModel.instance:setUsingLeaderSkill(false)
end

var_0_0.instance = var_0_0.New()

return var_0_0
