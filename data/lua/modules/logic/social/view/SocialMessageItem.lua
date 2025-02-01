module("modules.logic.social.view.SocialMessageItem", package.seeall)

slot0 = class("SocialMessageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._txtnameleft = gohelper.findChildText(slot0.viewGO, "#go_left/textcontainer/#txt_nameleft")
	slot0._txtcontentleft = gohelper.findChildText(slot0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft")
	slot0._goplayericonleft = gohelper.findChild(slot0.viewGO, "#go_left/#go_playericonleft")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._goplayericonright = gohelper.findChild(slot0.viewGO, "#go_right/#go_playericonright")
	slot0._txtnameright = gohelper.findChildText(slot0.viewGO, "#go_right/textcontainer/#txt_nameright")
	slot0._txtcontentright = gohelper.findChildText(slot0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright")
	slot0._gochattime = gohelper.findChild(slot0.viewGO, "#go_chattime")
	slot0._txtchattime = gohelper.findChildText(slot0.viewGO, "#go_chattime/#txt_chattime")
	slot0._btnopright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright/#btn_opright")
	slot0._txtopright = gohelper.findChildText(slot0.viewGO, "#go_right/textcontainer/content/contentbg/#txt_contentright/#btn_opright/#txt_opright")
	slot0._btnopleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft")
	slot0._txtopleft = gohelper.findChildText(slot0.viewGO, "#go_left/textcontainer/content/contentbg/#txt_contentleft/#btn_opleft/#txt_opleft")
	slot0._gowarm = gohelper.findChild(slot0.viewGO, "#go_warm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0.updateDesc, slot0)
	slot0._btnopleft:AddClickListener(slot0._btnopleftOnClick, slot0)
	slot0._btnopright:AddClickListener(slot0._btnoprightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0.updateDesc, slot0)
	slot0._btnopleft:RemoveClickListener()
	slot0._btnopright:RemoveClickListener()
end

function slot0._btnopleftOnClick(slot0)
	SocialMessageController.instance:opMessageOnClick(slot0._mo)
end

function slot0._btnoprightOnClick(slot0)
	SocialMessageController.instance:opMessageOnClick(slot0._mo)
end

function slot0._editableInitView(slot0)
end

function slot0._refreshUI(slot0)
	if slot0._mo.chattime then
		gohelper.setActive(slot0._gochattime, true)
		gohelper.setActive(slot0._goright, false)
		gohelper.setActive(slot0._goleft, false)

		slot0._txtchattime.text = slot0._mo.chattime

		gohelper.setActive(slot0._gowarm, false)

		return
	end

	if slot0._mo.showWarm then
		gohelper.setActive(slot0._gochattime, false)
		gohelper.setActive(slot0._goright, false)
		gohelper.setActive(slot0._goleft, false)
		gohelper.setActive(slot0._gowarm, true)

		return
	end

	gohelper.setActive(slot0._gowarm, false)
	gohelper.setActive(slot0._gochattime, false)

	slot2 = SocialModel.instance:getPlayerMO(slot0._mo.senderId)

	gohelper.setActive(slot0._goright, PlayerModel.instance:getMyUserId() == slot0._mo.senderId)
	gohelper.setActive(slot0._goleft, slot1 ~= slot0._mo.senderId)

	slot3 = slot0._mo:isHasOp()

	if slot1 == slot0._mo.senderId then
		if not slot0._playericonright then
			slot0._playericonright = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericonright)

			slot0._playericonright:setScale(1.1)
		end

		if slot2 then
			slot0._playericonright:onUpdateMO(slot2)
		else
			slot0._playericonright:setMOValue(slot0._mo.senderId, slot0._mo.senderName, slot0._mo.level, slot0._mo.portrait, 0)
		end

		slot0._playericonright:setShowLevel(false)

		slot0._txtnameright.text = slot0._mo:getSenderName()
		slot0._txtcontentright.text = LuaUtil.replaceSpace(slot0._mo.content)

		gohelper.setActive(slot0._btnopright, slot3)

		if slot3 then
			slot0._txtopright.text = slot0:_getOpTetStr(slot0._mo.msgType)
		end
	else
		if not slot0._playericonleft then
			slot0._playericonleft = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericonleft)

			slot0._playericonleft:setScale(1.1)
		end

		if slot2 then
			slot0._playericonleft:onUpdateMO(slot2)
		else
			slot0._playericonleft:setMOValue(slot0._mo.senderId, slot0._mo.senderName, slot0._mo.level, slot0._mo.portrait, 0)
		end

		slot0._playericonleft:setShowLevel(false)

		slot4 = slot0._mo:getSenderName()

		if slot2 and not string.nilorempty(slot2.desc) then
			slot4 = slot2.desc
		end

		slot0._txtnameleft.text = slot4
		slot0._txtcontentleft.text = LuaUtil.replaceSpace(slot0._mo.content)

		gohelper.setActive(slot0._btnopleft, slot3)

		if slot3 then
			slot0._txtopleft.text = slot0:_getOpTetStr(slot0._mo.msgType)
		end
	end
end

function slot0._getOpTetStr(slot0, slot1)
	if ChatEnum.MsgTypeOPLang[slot1] then
		return luaLang(ChatEnum.MsgTypeOPLang[slot1])
	end

	return ""
end

function slot0.updateDesc(slot0, slot1)
	if slot1 == slot0._mo.senderId then
		slot0:_refreshUI()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onDestroy(slot0)
end

return slot0
