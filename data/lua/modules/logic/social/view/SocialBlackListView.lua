module("modules.logic.social.view.SocialBlackListView", package.seeall)

local var_0_0 = class("SocialBlackListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._gono = gohelper.findChild(arg_1_0.viewGO, "#go_no")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(SocialController.instance, SocialEvent.AddUnknownBlackList, arg_2_0._onAddUnknownBlackList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(SocialController.instance, SocialEvent.AddUnknownBlackList, arg_3_0._onAddUnknownBlackList, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	FriendRpc.instance:sendGetBlacklistRequest()

	if arg_5_0._notFirst then
		arg_5_0:_refreshUI()
	else
		arg_5_0:_refreshUI(true)
	end

	arg_5_0._notFirst = true
end

function var_0_0._onAddUnknownBlackList(arg_6_0)
	FriendRpc.instance:sendGetBlacklistRequest()
end

function var_0_0._refreshUI(arg_7_0, arg_7_1)
	local var_7_0 = SocialModel.instance:getBlackListCount()

	if not arg_7_1 then
		gohelper.setActive(arg_7_0._gohas, var_7_0 > 0)
		gohelper.setActive(arg_7_0._gono, var_7_0 <= 0)
	else
		gohelper.setActive(arg_7_0._gohas, var_7_0 > 0)
		gohelper.setActive(arg_7_0._gono, false)
	end
end

return var_0_0
