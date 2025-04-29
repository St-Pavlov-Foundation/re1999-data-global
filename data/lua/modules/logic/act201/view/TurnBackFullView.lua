module("modules.logic.act201.view.TurnBackFullView", package.seeall)

slot0 = class("TurnBackFullView", BaseView)

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
	slot0._goplayer1 = gohelper.findChild(slot0.viewGO, "Root/Left/#scroll_playerlist/viweport/content/#go_player1")
	slot0._goLongClick = gohelper.findChild(slot0.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	slot0._btnCopyClick = gohelper.findChildClick(slot0.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	slot0._btnreward1 = gohelper.findChildClick(slot0.viewGO, "Root/Right/rewardroot1/#btn_reward")
	slot0._btnreward2 = gohelper.findChildClick(slot0.viewGO, "Root/Right/rewardroot2/#btn_reward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninvite:AddClickListener(slot0._btninviteOnClick, slot0)
	slot0._btncopy:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btnCopyClick:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btnreward1:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnreward2:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnCopyLongPress:AddLongPressListener(slot0._btncopyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninvite:RemoveClickListener()
	slot0._btncopy:RemoveClickListener()
	slot0._btnCopyClick:RemoveClickListener()
	slot0._btnreward1:RemoveClickListener()
	slot0._btnreward2:RemoveClickListener()
	slot0._btnCopyLongPress:RemoveLongPressListener()
end

function slot0._btninviteOnClick(slot0)
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("海外人拉人H5活动界面", "进入活动")
	WebViewController.instance:openWebView(Activity201Model.instance:getLoginUrl(), false, slot0.OnWebViewBack, slot0)
end

function slot0._btncopyOnClick(slot0)
	if not Activity201Model.instance:getInvitationInfo(slot0._actId) then
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
			Activity201Controller.instance:getInvitationInfo(slot0._actId)
			ViewMgr.instance:closeView(ViewName.WebView)
		elseif slot4 == "saveImage" and slot3[2] then
			Base64Util.saveImage(slot3[2])
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._friendItemList = {}
	slot0._loader = MultiAbLoader.New()
	slot0._btnCopyLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._goLongClick)

	slot0._btnCopyLongPress:SetLongPressTime({
		0.5,
		99999
	})
	gohelper.setActive(slot0._goplayer1, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, slot0._refreshUI, slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TurnBackH5.play_ui_rolesopen)
	slot0:_checkParent()
	slot0:_refreshData()
end

function slot0._refreshData(slot0)
	slot0._actId = slot0.viewParam.actId

	Activity201Controller.instance:getInvitationInfo(slot0._actId)
end

function slot0._checkParent(slot0)
	if slot0.viewParam.parent then
		gohelper.addChild(slot1, slot0.viewGO)
	end

	slot0._actId = slot0.viewParam.actId
end

function slot0._refreshUI(slot0)
	for slot6 = 1, #Activity201Model.instance:getInvitationInfo(slot0._actId).invitePlayers do
		if not slot0._friendItemList[slot6] then
			slot0._friendItemList[slot6] = slot0:_create_TurnBackFullViewFriendItem(slot6)
		end

		slot7:setActive(true)
		slot7:setData(slot1.invitePlayers[slot6])
	end

	slot6 = #slot0._friendItemList

	for slot6 = slot2 + 1, math.max(3, slot6) do
		if not slot0._friendItemList[slot6] then
			slot0._friendItemList[slot6] = slot0:_create_TurnBackFullViewFriendItem(slot6)
		end

		slot7:setEmpty()
		slot7:setActive(slot6 <= 3)
	end

	slot0._txtnum.text = slot1.inviteCode

	slot0:_refreshTime()

	if Activity201Model.instance:isActOpen(slot0._actId) then
		TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
		TaskDispatcher.runRepeat(slot0._refreshTime, slot0, 1)
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

	slot0._txttitle.text = formatLuaLang("TurnBackFullView_title", slot1.name)

	if #string.split(slot2.effect, "#") > 1 then
		if slot2.id == tonumber(slot3[#slot3]) then
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
	slot0:disposeLoader()
	slot0:removeEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, slot0._refreshUI, slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_friendItemList")
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0._create_TurnBackFullViewFriendItem(slot0, slot1, slot2)
	slot3 = TurnBackFullViewFriendItem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(slot2 or gohelper.cloneInPlace(slot0._goplayer1))

	return slot3
end

function slot0.disposeLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	for slot4, slot5 in ipairs(slot0._friendItemList or {}) do
		if slot5 then
			slot5:disposeLoader()
		end
	end
end

return slot0
