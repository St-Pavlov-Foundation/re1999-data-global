module("modules.logic.social.view.PlayerInfoView", package.seeall)

slot0 = class("PlayerInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "Scroll_view/Viewport/Content/playerinfo/#go_playericon")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "Scroll_view/Viewport/Content/bg/normal")
	slot0._goskinbg = gohelper.findChild(slot0.viewGO, "Scroll_view/Viewport/Content/bg/actskin")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "Scroll_view/Viewport/Content/playerinfo/#txt_name")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "Scroll_view/Viewport/Content/playerinfo/level/#txt_level")
	slot0._gobuttonscontainer = gohelper.findChild(slot0.viewGO, "Scroll_view/Viewport/Content/buttonscontainer")
	slot0._btnplayerview = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_playerview")
	slot0._btnaddfriend = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_addfriend")
	slot0._btnremovefriend = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_removefriend")
	slot0._btnroom = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_room")
	slot0._btnaddblacklist = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_addblacklist")
	slot0._btnremoveblacklist = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_removeblacklist")
	slot0._btninformplayer = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_informplayer")
	slot0._btnremark = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_remark")
	slot0._btnplayercard = gohelper.findChildButtonWithAudio(slot0._gobuttonscontainer, "#btn_personalcard")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._hasSkin = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnplayerview:AddClickListener(slot0._btnplayerviewOnClick, slot0)
	slot0._btnaddfriend:AddClickListener(slot0._btnaddfriendOnClick, slot0)
	slot0._btnremovefriend:AddClickListener(slot0._btnremovefriendOnClick, slot0)
	slot0._btnroom:AddClickListener(slot0._btnroomOnClick, slot0)
	slot0._btnaddblacklist:AddClickListener(slot0._btnaddblacklistOnClick, slot0)
	slot0._btnremoveblacklist:AddClickListener(slot0._btnremoveblacklistOnClick, slot0)
	slot0._btninformplayer:AddClickListener(slot0._btninformplayerOnClick, slot0)
	slot0._btnremark:AddClickListener(slot0._btnremarkOnClick, slot0)
	slot0._btnplayercard:AddClickListener(slot0._btnplayercardOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplayerview:RemoveClickListener()
	slot0._btnaddfriend:RemoveClickListener()
	slot0._btnremovefriend:RemoveClickListener()
	slot0._btnroom:RemoveClickListener()
	slot0._btnaddblacklist:RemoveClickListener()
	slot0._btnremoveblacklist:RemoveClickListener()
	slot0._btninformplayer:RemoveClickListener()
	slot0._btnremark:RemoveClickListener()
	slot0._btnplayercard:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnplayercardOnClick(slot0)
	if not slot0._mo then
		return
	end

	PlayerCardController.instance:openPlayerCardView({
		userId = slot0._mo.userId
	})
end

function slot0._btninformplayerOnClick(slot0)
	SocialController.instance:openInformPlayerTipView(slot0._mo)
end

function slot0._btnremarkOnClick(slot0)
	ViewMgr.instance:openView(ViewName.SocialRemarkTipView, slot0._mo)
	slot0:closeThis()
end

function slot0._btnplayerviewOnClick(slot0)
	if PlayerModel.instance:getMyUserId() == slot0._mo.userId then
		slot0:closeThis()
		PlayerController.instance:openPlayerView(PlayerModel.instance:getPlayinfo(), true)
	else
		PlayerRpc.instance:sendGetOtherPlayerInfoRequest(slot0._mo.userId, slot0._getPlayerInfo, slot0)
	end
end

function slot0._btnaddfriendOnClick(slot0)
	SocialController.instance:AddFriend(slot0._mo.userId)
	slot0:closeThis()
end

function slot0._btnremovefriendOnClick(slot0)
	slot1 = slot0._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.FriendRemoveTip, MsgBoxEnum.BoxType.Yes_No, function ()
		FriendRpc.instance:sendRemoveFriendRequest(uv0)
	end)
	slot0:closeThis()
end

function slot0._btnroomOnClick(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Visit, nil, , {
		userId = slot0._mo.userId
	}, nil, , true)
end

function slot0._btnaddblacklistOnClick(slot0)
	slot1 = slot0._mo.userId

	GameFacade.showMessageBox(MessageBoxIdDefine.AddBlackTip, MsgBoxEnum.BoxType.Yes_No, function ()
		FriendRpc.instance:sendAddBlacklistRequest(uv0)
	end)
	slot0:closeThis()
end

function slot0._btnremoveblacklistOnClick(slot0)
	FriendRpc.instance:sendRemoveBlacklistRequest(slot0._mo.userId)
	slot0:closeThis()
end

function slot0._getPlayerInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 and slot3 and slot3.playerInfo then
		slot0:closeThis()
		PlayerController.instance:openPlayerView(slot3.playerInfo, false, slot3.heroCover)
	end
end

function slot0._editableInitView(slot0)
	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)

	slot0._playericon:setEnableClick(false)

	slot0._parentWidth = recthelper.getWidth(slot0.viewGO.transform.parent)
	slot0._parentHeight = recthelper.getHeight(slot0.viewGO.transform.parent)
	slot0._viewWidth = 540
	slot0._viewHeight = 390
end

function slot0._refreshUI(slot0)
	if not slot0._mo.bg or slot0._mo.bg == 0 then
		slot0._hasSkin = false
	else
		slot0._hasSkin = true
		slot0._skinPath = string.format("ui/viewres/social/playerinfoview_bg_%s.prefab", slot0._mo.bg)
		slot0._loader = MultiAbLoader.New()

		slot0._loader:addPath(slot0._skinPath)
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	end

	gohelper.setActive(slot0._imagebg.gameObject, not slot0._hasSkin)
	gohelper.setActive(slot0._goskinbg, slot0._hasSkin)
	slot0._playericon:onUpdateMO(slot0._mo)
	slot0._playericon:setShowLevel(false)

	if not string.nilorempty(slot0._mo.desc) then
		if slot0._isSelectInFriend then
			slot1 = "<color=#c66030>" .. slot0._mo.name .. "<color=#6d6c6b>(" .. slot0._mo.desc .. ")"
		else
			slot1 = slot1 .. "<color=#6d6c6b>(" .. slot0._mo.desc .. ")"
		end
	elseif slot0._isSelectInFriend then
		slot1 = "<color=#c66030>" .. slot1
	end

	slot0._txtname.text = slot1
	slot0._txtlevel.text = slot0._mo.level
	slot3 = PlayerModel.instance:getMyUserId() == slot0._mo.userId
	slot4 = SocialModel.instance:isMyFriendByUserId(slot0._mo.userId)

	gohelper.setActive(slot0._btnaddfriend.gameObject, not slot4)
	gohelper.setActive(slot0._btnremovefriend.gameObject, slot4)
	gohelper.setActive(slot0._btnremark.gameObject, slot4)
	gohelper.setActive(slot0._btnaddblacklist.gameObject, not SocialModel.instance:isMyBlackListByUserId(slot0._mo.userId) and not slot3)
	gohelper.setActive(slot0._btnremoveblacklist.gameObject, slot5 and not slot3)
	gohelper.setActive(slot0._btnroom.gameObject, true)
end

function slot0._onLoadFinish(slot0)
	slot0._goskinEffect = gohelper.clone(slot0._loader:getAssetItem(slot0._skinPath):GetResource(slot0._skinPath), slot0._goskinbg)
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam.mo
	slot0._worldPos = slot0.viewParam.worldPos

	if slot0.viewParam.isSelectInFriend then
		slot0._isSelectInFriend = slot0.viewParam.isSelectInFriend
	end

	slot0:_refreshUI()
	slot0:_refreshPos()
end

function slot0.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._mo = slot0.viewParam.mo
	slot0._worldPos = slot0.viewParam.worldPos

	if slot0.viewParam.isSelectInFriend then
		slot0._isSelectInFriend = slot0.viewParam.isSelectInFriend
	end

	slot0:_refreshUI()
	slot0:_refreshPos()
end

function slot0._refreshPos(slot0)
	slot1 = 326
	slot2 = 144
	slot3 = recthelper.rectToRelativeAnchorPos(slot0._worldPos, slot0.viewGO.transform.parent)

	for slot7 = -1, 1, 2 do
		for slot11 = -1, 1, 2 do
			if not slot0:_isOverScreen(slot3.x + slot1 * slot7, slot3.y + slot2 * slot11) then
				recthelper.setAnchor(slot0.viewGO.transform, slot12, slot13)

				return
			end
		end
	end

	recthelper.setAnchor(slot0.viewGO.transform, 0, 0)
end

function slot0._isOverScreen(slot0, slot1, slot2)
	if math.abs(slot1) * 2 >= slot0._parentWidth - slot0._viewWidth then
		return true
	elseif math.abs(slot2) * 2 >= slot0._parentHeight - slot0._viewHeight then
		return true
	end

	return false
end

function slot0.onDestroyView(slot0)
end

return slot0
