module("modules.logic.social.view.SocialMessageItem", package.seeall)

local var_0_0 = class("SocialMessageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._txtnameleft = gohelper.findChildText(arg_1_0.viewGO, "#go_left/textcontainer/#txt_nameleft")
	arg_1_0._txtcontentleft = gohelper.findChildText(arg_1_0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft")
	arg_1_0._goplayericonleft = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_playericonleft")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._goplayericonright = gohelper.findChild(arg_1_0.viewGO, "#go_right/#go_playericonright")
	arg_1_0._txtnameright = gohelper.findChildText(arg_1_0.viewGO, "#go_right/textcontainer/#txt_nameright")
	arg_1_0._txtcontentright = gohelper.findChildText(arg_1_0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright")
	arg_1_0._gochattime = gohelper.findChild(arg_1_0.viewGO, "#go_chattime")
	arg_1_0._txtchattime = gohelper.findChildText(arg_1_0.viewGO, "#go_chattime/#txt_chattime")
	arg_1_0._btnopright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright/#btn_opright")
	arg_1_0._txtopright = gohelper.findChildText(arg_1_0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright/#btn_opright/#txt_opright")
	arg_1_0._btnopleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft")
	arg_1_0._txtopleft = gohelper.findChildText(arg_1_0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft/#txt_opleft")
	arg_1_0._gowarm = gohelper.findChild(arg_1_0.viewGO, "#go_warm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_2_0.updateDesc, arg_2_0)
	arg_2_0._btnopleft:AddClickListener(arg_2_0._btnopleftOnClick, arg_2_0)
	arg_2_0._btnopright:AddClickListener(arg_2_0._btnoprightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_3_0.updateDesc, arg_3_0)
	arg_3_0._btnopleft:RemoveClickListener()
	arg_3_0._btnopright:RemoveClickListener()
end

function var_0_0._btnopleftOnClick(arg_4_0)
	SocialMessageController.instance:opMessageOnClick(arg_4_0._mo)
end

function var_0_0._btnoprightOnClick(arg_5_0)
	SocialMessageController.instance:opMessageOnClick(arg_5_0._mo)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._refreshUI(arg_7_0)
	if arg_7_0._mo.chattime then
		gohelper.setActive(arg_7_0._gochattime, true)
		gohelper.setActive(arg_7_0._goright, false)
		gohelper.setActive(arg_7_0._goleft, false)

		arg_7_0._txtchattime.text = arg_7_0._mo.chattime

		gohelper.setActive(arg_7_0._gowarm, false)

		return
	end

	if arg_7_0._mo.showWarm then
		gohelper.setActive(arg_7_0._gochattime, false)
		gohelper.setActive(arg_7_0._goright, false)
		gohelper.setActive(arg_7_0._goleft, false)
		gohelper.setActive(arg_7_0._gowarm, true)

		return
	end

	gohelper.setActive(arg_7_0._gowarm, false)
	gohelper.setActive(arg_7_0._gochattime, false)

	local var_7_0 = PlayerModel.instance:getMyUserId()
	local var_7_1 = SocialModel.instance:getPlayerMO(arg_7_0._mo.senderId)

	gohelper.setActive(arg_7_0._goright, var_7_0 == arg_7_0._mo.senderId)
	gohelper.setActive(arg_7_0._goleft, var_7_0 ~= arg_7_0._mo.senderId)

	local var_7_2 = arg_7_0._mo:isHasOp()

	if var_7_0 == arg_7_0._mo.senderId then
		if not arg_7_0._playericonright then
			arg_7_0._playericonright = IconMgr.instance:getCommonPlayerIcon(arg_7_0._goplayericonright)

			arg_7_0._playericonright:setScale(1.1)
		end

		if var_7_1 then
			arg_7_0._playericonright:onUpdateMO(var_7_1)
		else
			arg_7_0._playericonright:setMOValue(arg_7_0._mo.senderId, arg_7_0._mo.senderName, arg_7_0._mo.level, arg_7_0._mo.portrait, 0)
		end

		arg_7_0._playericonright:setShowLevel(false)

		arg_7_0._txtnameright.text = arg_7_0._mo:getSenderName()
		arg_7_0._txtcontentright.text = LuaUtil.replaceSpace(arg_7_0._mo.content, true)

		gohelper.setActive(arg_7_0._btnopright, var_7_2)

		if var_7_2 then
			arg_7_0._txtopright.text = arg_7_0:_getOpTetStr(arg_7_0._mo.msgType)
		end
	else
		if not arg_7_0._playericonleft then
			arg_7_0._playericonleft = IconMgr.instance:getCommonPlayerIcon(arg_7_0._goplayericonleft)

			arg_7_0._playericonleft:setScale(1.1)
		end

		if var_7_1 then
			arg_7_0._playericonleft:onUpdateMO(var_7_1)
		else
			arg_7_0._playericonleft:setMOValue(arg_7_0._mo.senderId, arg_7_0._mo.senderName, arg_7_0._mo.level, arg_7_0._mo.portrait, 0)
		end

		arg_7_0._playericonleft:setShowLevel(false)

		local var_7_3 = arg_7_0._mo:getSenderName()

		if var_7_1 and not string.nilorempty(var_7_1.desc) then
			var_7_3 = var_7_1.desc
		end

		arg_7_0._txtnameleft.text = var_7_3
		arg_7_0._txtcontentleft.text = LuaUtil.replaceSpace(arg_7_0._mo.content, true)

		gohelper.setActive(arg_7_0._btnopleft, var_7_2)

		if var_7_2 then
			arg_7_0._txtopleft.text = arg_7_0:_getOpTetStr(arg_7_0._mo.msgType)
		end
	end
end

function var_0_0._getOpTetStr(arg_8_0, arg_8_1)
	if ChatEnum.MsgTypeOPLang[arg_8_1] then
		return luaLang(ChatEnum.MsgTypeOPLang[arg_8_1])
	end

	return ""
end

function var_0_0.updateDesc(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0._mo.senderId then
		arg_9_0:_refreshUI()
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	arg_10_0:_refreshUI()
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
