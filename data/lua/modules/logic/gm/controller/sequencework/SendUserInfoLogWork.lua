module("modules.logic.gm.controller.sequencework.SendUserInfoLogWork", package.seeall)

local var_0_0 = class("SendUserInfoLogWork", BaseWork)

function var_0_0.onStart(arg_1_0)
	ZProj.OpenSelectFileWindow.OpenExplorer(SendFightLogWork.logDirPath)
	SendWeWorkFileHelper.SendUserInfo(arg_1_0.onSendUserInfoDone, arg_1_0)
end

function var_0_0.onSendUserInfoDone(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.status ~= WorkStatus.Running then
		return
	end

	if arg_2_1 then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. tostring(arg_2_2))
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
