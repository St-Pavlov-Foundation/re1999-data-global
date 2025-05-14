module("modules.logic.act201.view.TurnBackFullView", package.seeall)

local var_0_0 = class("TurnBackFullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/#txt_LimitTime")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/#txt_num")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/Right/#scroll_des")
	arg_1_0._btninvite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_invite")
	arg_1_0._btncopy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_copy")
	arg_1_0._simagebook = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Left/#simage_book")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Root/Left/#txt_title")
	arg_1_0._simageplayerheadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Left/#simage_playerheadicon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "Root/Left/#simage_playerheadicon/#go_framenode")
	arg_1_0._goplayer1 = gohelper.findChild(arg_1_0.viewGO, "Root/Left/#scroll_playerlist/viweport/content/#go_player1")
	arg_1_0._goLongClick = gohelper.findChild(arg_1_0.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	arg_1_0._btnCopyClick = gohelper.findChildClick(arg_1_0.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	arg_1_0._btnreward1 = gohelper.findChildClick(arg_1_0.viewGO, "Root/Right/rewardroot1/#btn_reward")
	arg_1_0._btnreward2 = gohelper.findChildClick(arg_1_0.viewGO, "Root/Right/rewardroot2/#btn_reward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninvite:AddClickListener(arg_2_0._btninviteOnClick, arg_2_0)
	arg_2_0._btncopy:AddClickListener(arg_2_0._btncopyOnClick, arg_2_0)
	arg_2_0._btnCopyClick:AddClickListener(arg_2_0._btncopyOnClick, arg_2_0)
	arg_2_0._btnreward1:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnreward2:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnCopyLongPress:AddLongPressListener(arg_2_0._btncopyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninvite:RemoveClickListener()
	arg_3_0._btncopy:RemoveClickListener()
	arg_3_0._btnCopyClick:RemoveClickListener()
	arg_3_0._btnreward1:RemoveClickListener()
	arg_3_0._btnreward2:RemoveClickListener()
	arg_3_0._btnCopyLongPress:RemoveLongPressListener()
end

function var_0_0._btninviteOnClick(arg_4_0)
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("海外人拉人H5活动界面", "进入活动")

	local var_4_0 = Activity201Model.instance:getLoginUrl()

	WebViewController.instance:openWebView(var_4_0, false, arg_4_0.OnWebViewBack, arg_4_0)
end

function var_0_0._btncopyOnClick(arg_5_0)
	local var_5_0 = Activity201Model.instance:getInvitationInfo(arg_5_0._actId)

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.inviteCode

	if not var_5_1 then
		return
	end

	ZProj.UGUIHelper.CopyText(var_5_1)
	ToastController.instance:showToast(ToastEnum.ClickPlayerId)
end

function var_0_0._btnrewardOnClick(arg_6_0)
	local var_6_0 = CurrencyEnum.CurrencyType.FreeDiamondCoupon

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_6_0, false, nil, nil)
end

function var_0_0.OnWebViewBack(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == WebViewEnum.WebViewCBType.Cb then
		local var_7_0 = string.split(arg_7_2, "#")
		local var_7_1 = var_7_0[1]

		if var_7_1 == "webClose" then
			Activity201Controller.instance:getInvitationInfo(arg_7_0._actId)
			ViewMgr.instance:closeView(ViewName.WebView)
		elseif var_7_1 == "saveImage" and var_7_0[2] then
			Base64Util.saveImage(var_7_0[2])
		end
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._friendItemList = {}
	arg_8_0._loader = MultiAbLoader.New()
	arg_8_0._btnCopyLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_8_0._goLongClick)

	arg_8_0._btnCopyLongPress:SetLongPressTime({
		0.5,
		99999
	})
	gohelper.setActive(arg_8_0._goplayer1, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, arg_10_0._refreshUI, arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TurnBackH5.play_ui_rolesopen)
	arg_10_0:_checkParent()
	arg_10_0:_refreshData()
end

function var_0_0._refreshData(arg_11_0)
	arg_11_0._actId = arg_11_0.viewParam.actId

	Activity201Controller.instance:getInvitationInfo(arg_11_0._actId)
end

function var_0_0._checkParent(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.parent

	if var_12_0 then
		gohelper.addChild(var_12_0, arg_12_0.viewGO)
	end

	arg_12_0._actId = arg_12_0.viewParam.actId
end

function var_0_0._refreshUI(arg_13_0)
	local var_13_0 = Activity201Model.instance:getInvitationInfo(arg_13_0._actId)
	local var_13_1 = #var_13_0.invitePlayers

	for iter_13_0 = 1, var_13_1 do
		local var_13_2 = arg_13_0._friendItemList[iter_13_0]

		if not var_13_2 then
			var_13_2 = arg_13_0:_create_TurnBackFullViewFriendItem(iter_13_0)
			arg_13_0._friendItemList[iter_13_0] = var_13_2
		end

		var_13_2:setActive(true)
		var_13_2:setData(var_13_0.invitePlayers[iter_13_0])
	end

	for iter_13_1 = var_13_1 + 1, math.max(3, #arg_13_0._friendItemList) do
		local var_13_3 = arg_13_0._friendItemList[iter_13_1]

		if not var_13_3 then
			var_13_3 = arg_13_0:_create_TurnBackFullViewFriendItem(iter_13_1)
			arg_13_0._friendItemList[iter_13_1] = var_13_3
		end

		var_13_3:setEmpty()
		var_13_3:setActive(iter_13_1 <= 3)
	end

	arg_13_0._txtnum.text = var_13_0.inviteCode

	arg_13_0:_refreshTime()

	if Activity201Model.instance:isActOpen(arg_13_0._actId) then
		TaskDispatcher.cancelTask(arg_13_0._refreshTime, arg_13_0)
		TaskDispatcher.runRepeat(arg_13_0._refreshTime, arg_13_0, 1)
	end

	arg_13_0:_refreshPlayerInfo()
end

function var_0_0._refreshTime(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActMO(arg_14_0._actId):getRealEndTimeStamp()
	local var_14_1 = ServerTime.now()

	if var_14_0 <= var_14_1 then
		arg_14_0._txtLimitTime.text = luaLang("ended")

		return
	end

	local var_14_2 = TimeUtil.SecondToActivityTimeFormat(var_14_0 - var_14_1)

	arg_14_0._txtLimitTime.text = var_14_2
end

function var_0_0._refreshPlayerInfo(arg_15_0)
	local var_15_0 = PlayerModel.instance:getPlayinfo()
	local var_15_1 = lua_item.configDict[var_15_0.portrait]

	if not arg_15_0._liveHeadIcon then
		arg_15_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_15_0._simageplayerheadicon)
	end

	arg_15_0._liveHeadIcon:setLiveHead(var_15_1.id)

	arg_15_0._txttitle.text = formatLuaLang("TurnBackFullView_title", var_15_0.name)

	local var_15_2 = string.split(var_15_1.effect, "#")

	if #var_15_2 > 1 then
		if var_15_1.id == tonumber(var_15_2[#var_15_2]) then
			gohelper.setActive(arg_15_0._goframenode, true)

			if not arg_15_0.frame then
				local var_15_3 = "ui/viewres/common/effect/frame.prefab"

				arg_15_0._loader:addPath(var_15_3)
				arg_15_0._loader:startLoad(arg_15_0._onLoadCallback, arg_15_0)
			end
		end
	else
		gohelper.setActive(arg_15_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_16_0)
	local var_16_0 = arg_16_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_16_0, arg_16_0._goframenode, "frame")

	arg_16_0.frame = gohelper.findChild(arg_16_0._goframenode, "frame")
	arg_16_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_16_1 = 1.41 * (recthelper.getWidth(arg_16_0._simageplayerheadicon.transform) / recthelper.getWidth(arg_16_0.frame.transform))

	transformhelper.setLocalScale(arg_16_0.frame.transform, var_16_1, var_16_1, 1)
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:disposeLoader()
	arg_17_0:removeEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, arg_17_0._refreshUI, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._refreshTime, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	GameUtil.onDestroyViewMemberList(arg_18_0, "_friendItemList")
	TaskDispatcher.cancelTask(arg_18_0._refreshTime, arg_18_0)
end

function var_0_0._create_TurnBackFullViewFriendItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = TurnBackFullViewFriendItem.New({
		parent = arg_19_0,
		baseViewContainer = arg_19_0.viewContainer
	})

	var_19_0:setIndex(arg_19_1)
	var_19_0:init(arg_19_2 or gohelper.cloneInPlace(arg_19_0._goplayer1))

	return var_19_0
end

function var_0_0.disposeLoader(arg_20_0)
	if arg_20_0._loader then
		arg_20_0._loader:dispose()

		arg_20_0._loader = nil
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._friendItemList or {}) do
		if iter_20_1 then
			iter_20_1:disposeLoader()
		end
	end
end

return var_0_0
