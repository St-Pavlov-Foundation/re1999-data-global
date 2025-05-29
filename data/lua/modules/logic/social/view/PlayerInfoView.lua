module("modules.logic.social.view.PlayerInfoView", package.seeall)

local var_0_0 = class("PlayerInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "Scroll_view/Viewport/Content/playerinfo/#go_playericon")
	arg_1_0._goimagebg = gohelper.findChild(arg_1_0.viewGO, "Scroll_view/Viewport/Content/bg/normal2")
	arg_1_0._goskinbg = gohelper.findChild(arg_1_0.viewGO, "Scroll_view/Viewport/Content/bg/actskin")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Scroll_view/Viewport/Content/playerinfo/#txt_name")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "Scroll_view/Viewport/Content/playerinfo/level/#txt_level")
	arg_1_0._gobuttonscontainer = gohelper.findChild(arg_1_0.viewGO, "Scroll_view/Viewport/Content/buttonscontainer")
	arg_1_0._btnplayerview = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_playerview")
	arg_1_0._btnaddfriend = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_addfriend")
	arg_1_0._btnremovefriend = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_removefriend")
	arg_1_0._btnroom = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_room")
	arg_1_0._btnaddblacklist = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_addblacklist")
	arg_1_0._btnremoveblacklist = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_removeblacklist")
	arg_1_0._btninformplayer = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_informplayer")
	arg_1_0._btnremark = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_remark")
	arg_1_0._btnplayercard = gohelper.findChildButtonWithAudio(arg_1_0._gobuttonscontainer, "#btn_personalcard")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._hasSkin = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplayerview:AddClickListener(arg_2_0._btnplayerviewOnClick, arg_2_0)
	arg_2_0._btnaddfriend:AddClickListener(arg_2_0._btnaddfriendOnClick, arg_2_0)
	arg_2_0._btnremovefriend:AddClickListener(arg_2_0._btnremovefriendOnClick, arg_2_0)
	arg_2_0._btnroom:AddClickListener(arg_2_0._btnroomOnClick, arg_2_0)
	arg_2_0._btnaddblacklist:AddClickListener(arg_2_0._btnaddblacklistOnClick, arg_2_0)
	arg_2_0._btnremoveblacklist:AddClickListener(arg_2_0._btnremoveblacklistOnClick, arg_2_0)
	arg_2_0._btninformplayer:AddClickListener(arg_2_0._btninformplayerOnClick, arg_2_0)
	arg_2_0._btnremark:AddClickListener(arg_2_0._btnremarkOnClick, arg_2_0)
	arg_2_0._btnplayercard:AddClickListener(arg_2_0._btnplayercardOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplayerview:RemoveClickListener()
	arg_3_0._btnaddfriend:RemoveClickListener()
	arg_3_0._btnremovefriend:RemoveClickListener()
	arg_3_0._btnroom:RemoveClickListener()
	arg_3_0._btnaddblacklist:RemoveClickListener()
	arg_3_0._btnremoveblacklist:RemoveClickListener()
	arg_3_0._btninformplayer:RemoveClickListener()
	arg_3_0._btnremark:RemoveClickListener()
	arg_3_0._btnplayercard:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnplayercardOnClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	PlayerCardController.instance:openPlayerCardView({
		userId = arg_4_0._mo.userId
	})
end

function var_0_0._btninformplayerOnClick(arg_5_0)
	SocialController.instance:openInformPlayerTipView(arg_5_0._mo)
end

function var_0_0._btnremarkOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.SocialRemarkTipView, arg_6_0._mo)
	arg_6_0:closeThis()
end

function var_0_0._btnplayerviewOnClick(arg_7_0)
	if PlayerModel.instance:getMyUserId() == arg_7_0._mo.userId then
		local var_7_0 = PlayerModel.instance:getPlayinfo()

		arg_7_0:closeThis()
		PlayerController.instance:openPlayerView(var_7_0, true)
	else
		PlayerRpc.instance:sendGetOtherPlayerInfoRequest(arg_7_0._mo.userId, arg_7_0._getPlayerInfo, arg_7_0)
	end
end

function var_0_0._btnaddfriendOnClick(arg_8_0)
	SocialController.instance:AddFriend(arg_8_0._mo.userId)
	arg_8_0:closeThis()
end

function var_0_0._btnremovefriendOnClick(arg_9_0)
	local var_9_0 = arg_9_0._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.FriendRemoveTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendRemoveFriendRequest(var_9_0)
	end)
	arg_9_0:closeThis()
end

function var_0_0._btnroomOnClick(arg_11_0)
	local var_11_0 = {
		userId = arg_11_0._mo.userId
	}

	RoomController.instance:enterRoom(RoomEnum.GameMode.Visit, nil, nil, var_11_0, nil, nil, true)
end

function var_0_0._btnaddblacklistOnClick(arg_12_0)
	local var_12_0 = arg_12_0._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.AddBlackTip, MsgBoxEnum.BoxType.Yes_No, function()
		FriendRpc.instance:sendAddBlacklistRequest(var_12_0)
	end)
	arg_12_0:closeThis()
end

function var_0_0._btnremoveblacklistOnClick(arg_14_0)
	FriendRpc.instance:sendRemoveBlacklistRequest(arg_14_0._mo.userId)
	arg_14_0:closeThis()
end

function var_0_0._getPlayerInfo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 == 0 and arg_15_3 and arg_15_3.playerInfo then
		arg_15_0:closeThis()
		PlayerController.instance:openPlayerView(arg_15_3.playerInfo, false, arg_15_3.heroCover)
	end
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_16_0._goplayericon)

	arg_16_0._playericon:setEnableClick(false)

	arg_16_0._parentWidth = recthelper.getWidth(arg_16_0.viewGO.transform.parent)
	arg_16_0._parentHeight = recthelper.getHeight(arg_16_0.viewGO.transform.parent)
	arg_16_0._viewWidth = 540
	arg_16_0._viewHeight = 390
end

function var_0_0._refreshUI(arg_17_0)
	if not arg_17_0._mo.bg or arg_17_0._mo.bg == 0 then
		arg_17_0._hasSkin = false
	else
		arg_17_0._hasSkin = true
		arg_17_0._skinPath = string.format("ui/viewres/social/playerinfoview_bg_%s.prefab", arg_17_0._mo.bg)
		arg_17_0._loader = MultiAbLoader.New()

		arg_17_0._loader:addPath(arg_17_0._skinPath)
		arg_17_0._loader:startLoad(arg_17_0._onLoadFinish, arg_17_0)
	end

	gohelper.setActive(arg_17_0._goimagebg, not arg_17_0._hasSkin)
	gohelper.setActive(arg_17_0._goskinbg, arg_17_0._hasSkin)
	arg_17_0._playericon:onUpdateMO(arg_17_0._mo)
	arg_17_0._playericon:setShowLevel(false)

	local var_17_0 = arg_17_0._mo.name

	if not string.nilorempty(arg_17_0._mo.desc) then
		if arg_17_0._isSelectInFriend then
			var_17_0 = "<color=#c66030>" .. var_17_0 .. "<color=#6d6c6b>(" .. arg_17_0._mo.desc .. ")"
		else
			var_17_0 = var_17_0 .. "<color=#6d6c6b>(" .. arg_17_0._mo.desc .. ")"
		end
	elseif arg_17_0._isSelectInFriend then
		var_17_0 = "<color=#c66030>" .. var_17_0
	end

	arg_17_0._txtname.text = var_17_0
	arg_17_0._txtlevel.text = arg_17_0._mo.level

	local var_17_1 = PlayerModel.instance:getMyUserId() == arg_17_0._mo.userId
	local var_17_2 = SocialModel.instance:isMyFriendByUserId(arg_17_0._mo.userId)
	local var_17_3 = SocialModel.instance:isMyBlackListByUserId(arg_17_0._mo.userId)

	gohelper.setActive(arg_17_0._btnaddfriend.gameObject, not var_17_2)
	gohelper.setActive(arg_17_0._btnremovefriend.gameObject, var_17_2)
	gohelper.setActive(arg_17_0._btnremark.gameObject, var_17_2)
	gohelper.setActive(arg_17_0._btnaddblacklist.gameObject, not var_17_3 and not var_17_1)
	gohelper.setActive(arg_17_0._btnremoveblacklist.gameObject, var_17_3 and not var_17_1)
	gohelper.setActive(arg_17_0._btnroom.gameObject, true)
end

function var_0_0._onLoadFinish(arg_18_0)
	local var_18_0 = arg_18_0._loader:getAssetItem(arg_18_0._skinPath):GetResource(arg_18_0._skinPath)

	arg_18_0._goskinEffect = gohelper.clone(var_18_0, arg_18_0._goskinbg)
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._mo = arg_19_0.viewParam.mo
	arg_19_0._worldPos = arg_19_0.viewParam.worldPos

	if arg_19_0.viewParam.isSelectInFriend then
		arg_19_0._isSelectInFriend = arg_19_0.viewParam.isSelectInFriend
	end

	arg_19_0:_refreshUI()
	arg_19_0:_refreshPos()
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0._mo = arg_21_0.viewParam.mo
	arg_21_0._worldPos = arg_21_0.viewParam.worldPos

	if arg_21_0.viewParam.isSelectInFriend then
		arg_21_0._isSelectInFriend = arg_21_0.viewParam.isSelectInFriend
	end

	arg_21_0:_refreshUI()
	arg_21_0:_refreshPos()
end

function var_0_0._refreshPos(arg_22_0)
	local var_22_0 = 326
	local var_22_1 = 144
	local var_22_2 = recthelper.rectToRelativeAnchorPos(arg_22_0._worldPos, arg_22_0.viewGO.transform.parent)

	for iter_22_0 = -1, 1, 2 do
		for iter_22_1 = -1, 1, 2 do
			local var_22_3 = var_22_2.x + var_22_0 * iter_22_0
			local var_22_4 = var_22_2.y + var_22_1 * iter_22_1

			if not arg_22_0:_isOverScreen(var_22_3, var_22_4) then
				recthelper.setAnchor(arg_22_0.viewGO.transform, var_22_3, var_22_4)

				return
			end
		end
	end

	recthelper.setAnchor(arg_22_0.viewGO.transform, 0, 0)
end

function var_0_0._isOverScreen(arg_23_0, arg_23_1, arg_23_2)
	if math.abs(arg_23_1) * 2 >= arg_23_0._parentWidth - arg_23_0._viewWidth then
		return true
	elseif math.abs(arg_23_2) * 2 >= arg_23_0._parentHeight - arg_23_0._viewHeight then
		return true
	end

	return false
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
