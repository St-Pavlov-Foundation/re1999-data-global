module("modules.logic.turnback.invitation.view.TurnBackInvitationMainView", package.seeall)

slot0 = class("TurnBackInvitationMainView", BaseView)
slot0.TIME_REFRESH_DURATION = 10

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/Right/#txt_LimitTime")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Root/Right/#txt_num")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "Root/Right/#scroll_des")
	slot0._btninvite = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_invite")
	slot0._btncopy = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_copy")
	slot0._simagebook = gohelper.findChildSingleImage(slot0.viewGO, "Root/Left/#simage_book")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "Root/Left/#txt_title")
	slot0._simageplayerheadicon = gohelper.findChildSingleImage(slot0.viewGO, "Root/Left/#simage_playerheadicon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "Root/Left/#simage_playerheadicon/#go_framenode")
	slot0._goplayer1 = gohelper.findChild(slot0.viewGO, "Root/Left/#go_player1")
	slot0._goplayer2 = gohelper.findChild(slot0.viewGO, "Root/Left/#go_player2")
	slot0._goplayer3 = gohelper.findChild(slot0.viewGO, "Root/Left/#go_player3")
	slot0._goLongClick = gohelper.findChild(slot0.viewGO, "Root/Right/#go_copyLongClick")
	slot0._btnCopyClick = gohelper.findChildClick(slot0.viewGO, "Root/Right/#go_copyLongClick")
	slot0._btnreward = gohelper.findChildClick(slot0.viewGO, "Root/Right/#btn_reward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninvite:AddClickListener(slot0._btninviteOnClick, slot0)
	slot0._btncopy:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btnCopyClick:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnCopyLongPress:AddLongPressListener(slot0._btncopyOnClick, slot0)
	slot0:addEventCb(TurnBackInvitationController.instance, TurnBackInvitationEvent.OnGetInfoSuccess, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninvite:RemoveClickListener()
	slot0._btncopy:RemoveClickListener()
	slot0._btnCopyClick:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnCopyLongPress:RemoveLongPressListener()
	slot0:removeEventCb(TurnBackInvitationController.instance, TurnBackInvitationEvent.OnGetInfoSuccess, slot0._refreshUI, slot0)
end

function slot0._btninviteOnClick(slot0)
	WebViewController.instance:openWebView(TurnBackInvitationModel.instance:getLoginUrl(), false, slot0.OnWebViewBack, slot0)
end

function slot0._btncopyOnClick(slot0)
	if not TurnBackInvitationModel.instance:getInvitationInfo(slot0._actId) then
		return
	end

	if not slot1.inviteCode then
		return
	end

	ZProj.UGUIHelper.CopyText(slot2)
	ToastController.instance:showToast(ToastEnum.ClickPlayerId)
end

function slot0._btnrewardOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.FreeDiamondCoupon, false, nil, )
end

function slot0.OnWebViewBack(slot0, slot1, slot2)
	if slot1 == WebViewEnum.WebViewCBType.Cb then
		if string.split(slot2, "#")[1] == "webClose" then
			TurnBackInvitationController.instance:getInvitationInfo(slot0._actId)
			ViewMgr.instance:closeView(ViewName.WebView)
		elseif slot4 == "saveImage" and slot3[2] then
			Base64Util.saveImage(slot3[2])
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._friendItemList = {}

	for slot5, slot6 in ipairs({
		slot0._goplayer1,
		slot0._goplayer2,
		slot0._goplayer3,
		slot0._goplayer4
	}) do
		slot7 = TurnBackInvitationFriendItem.New()

		slot7:init(slot6)
		table.insert(slot0._friendItemList, slot7)
	end

	slot0._loader = MultiAbLoader.New()
	slot0._btnCopyLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._goLongClick)

	slot0._btnCopyLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TurnBackH5.play_ui_rolesopen)
	slot0:_checkParent()
	slot0:_refreshData()
end

function slot0._refreshData(slot0)
	slot0._actId = slot0.viewParam.actId

	TurnBackInvitationController.instance:getInvitationInfo(slot0._actId)
end

function slot0._checkParent(slot0)
	if slot0.viewParam.parent then
		gohelper.addChild(slot1, slot0.viewGO)
	end

	slot0._actId = slot0.viewParam.actId
end

function slot0._refreshUI(slot0)
	for slot7 = 1, #slot0._friendItemList do
		if slot7 <= #TurnBackInvitationModel.instance:getInvitationInfo(slot0._actId).invitePlayers then
			slot0._friendItemList[slot7]:setData(slot1.invitePlayers[slot7])
		else
			slot8:setEmpty()
		end
	end

	slot0._txtnum.text = slot1.inviteCode

	slot0:_refreshTime()

	if TurnBackInvitationModel.instance:isActOpen(slot0._actId) then
		TaskDispatcher.runRepeat(slot0._refreshTime, slot0, slot0.TIME_REFRESH_DURATION)
	end

	slot0:_refreshPlayerInfo()
end

function slot0._refreshTime(slot0)
	if ActivityModel.instance:getActMO(slot0._actId):getRealEndTimeStamp() <= ServerTime.now() then
		slot0._txtLimitTime.text = luaLang("ended")

		return
	end

	slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2 - slot3)
end

function slot0._refreshPlayerInfo(slot0)
	slot2 = lua_item.configDict[PlayerModel.instance:getPlayinfo().portrait]

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageplayerheadicon)
	end

	slot0._liveHeadIcon:setLiveHead(slot2.id)

	slot0._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("turnabck_invitation_title"), slot1.name)

	if #string.split(slot2.effect, "#") > 1 then
		if slot2.id == tonumber(slot5[#slot5]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame then
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simageplayerheadicon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._friendItemList = nil
end

function slot0.registerEvent(slot0)
end

function slot0.unRegisterEvent(slot0)
end

return slot0
