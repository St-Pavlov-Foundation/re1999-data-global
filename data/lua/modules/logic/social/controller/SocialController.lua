module("modules.logic.social.controller.SocialController", package.seeall)

local var_0_0 = class("SocialController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openSocialView(arg_5_0, arg_5_1)
	if SDKNativeUtil.isGamePad() then
		GameFacade.showToast(ToastEnum.ClassShow)
	else
		ViewMgr.instance:openView(ViewName.SocialView, arg_5_1)
	end
end

function var_0_0.AddFriend(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if PlayerModel.instance:getMyUserId() == arg_6_1 then
		GameFacade.showToast(ToastEnum.SocialIsMyFriend)

		return false
	end

	if SocialModel.instance:isMyFriendByUserId(arg_6_1) then
		GameFacade.showToast(ToastEnum.SocialIsMaxFriend)

		return false
	end

	if SocialModel.instance:getFriendsCount() >= SocialConfig.instance:getMaxFriendsCount() then
		GameFacade.showToast(ToastEnum.SocialRequest1)

		return false
	end

	FriendRpc.instance:sendApplyRequest(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.openInformPlayerTipView(arg_7_0, arg_7_1)
	if not ReportTypeListModel.instance:initDone() then
		arg_7_0.informPlayerTipViewParam = arg_7_1

		ChatRpc.instance:sendGetReportTypeRequest(arg_7_0.onReceiveGetReportTypeReplay, arg_7_0)

		return
	end

	ViewMgr.instance:openView(ViewName.InformPlayerTipView, arg_7_1)
end

function var_0_0.onReceiveGetReportTypeReplay(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	ReportTypeListModel.instance:initType(arg_8_3.reportTypes)
	ViewMgr.instance:openView(ViewName.InformPlayerTipView, arg_8_0.informPlayerTipViewParam)

	arg_8_0.informPlayerTipViewParam = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
