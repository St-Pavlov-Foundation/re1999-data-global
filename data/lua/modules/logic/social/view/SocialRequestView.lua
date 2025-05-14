module("modules.logic.social.view.SocialRequestView", package.seeall)

local var_0_0 = class("SocialRequestView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonorequest = gohelper.findChild(arg_1_0.viewGO, "#go_norequest")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._txtfriendscount = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_friendscount")
	arg_1_0._txtfriends = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_friends")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	FriendRpc.instance:sendGetApplyListRequest()
	arg_4_0:_refreshUI()
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = SocialModel.instance:getRequestCount()

	gohelper.setActive(arg_5_0._gonorequest, var_5_0 <= 0)
	gohelper.setActive(arg_5_0._gobottom, var_5_0 > 0)

	if var_5_0 > 0 then
		local var_5_1 = SocialModel.instance:getRequestCount()

		arg_5_0._txtfriendscount.text = string.format("%d/%d", var_5_1, SocialConfig.instance:getMaxRequestCount())
		arg_5_0._txtfriends.text = luaLang("social_tabviewinfo_request")
	end
end

return var_0_0
