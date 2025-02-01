module("modules.logic.room.view.layout.RoomLayoutVisitPlan", package.seeall)

slot0 = class("RoomLayoutVisitPlan", BaseView)

function slot0.onInitView(slot0)
	slot0._goplayinfo = gohelper.findChild(slot0.viewGO, "#go_playinfo")
	slot0._txtplanname = gohelper.findChildText(slot0.viewGO, "#go_playinfo/#txt_planname")
	slot0._btnplaninfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_playinfo/#txt_planname/#btn_planinfo")
	slot0._txtplayername = gohelper.findChildText(slot0.viewGO, "#go_playinfo/#txt_playername")
	slot0._txtplayerId = gohelper.findChildText(slot0.viewGO, "#go_playinfo/#txt_playerId")
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playinfo/#go_playericon")
	slot0._goshareinfo = gohelper.findChild(slot0.viewGO, "#go_shareinfo")
	slot0._txtsharecode = gohelper.findChildText(slot0.viewGO, "#go_shareinfo/go_sharecode/#txt_sharecode")
	slot0._btncopysharecode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_shareinfo/go_sharecode/#btn_copysharecode")
	slot0._goplaninfo = gohelper.findChild(slot0.viewGO, "#go_shareinfo/#go_planinfo")
	slot0._txtplaninfodesc = gohelper.findChildText(slot0.viewGO, "#go_shareinfo/#go_planinfo/#txt_planinfodesc")
	slot0._gocomparing = gohelper.findChild(slot0.viewGO, "#go_shareinfo/#go_comparing")
	slot0._btncomparing = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_shareinfo/#go_comparing/txt_comparing/#btn_comparing")
	slot0._gocompare = gohelper.findChild(slot0.viewGO, "#go_shareinfo/#go_compare")
	slot0._btncompare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_shareinfo/#go_compare/txt_compare/#btn_compare")
	slot0._btncopy = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_copy")
	slot0._gocopylock = gohelper.findChild(slot0.viewGO, "layout/#btn_copy/#go_copylock")
	slot0._gocopyunlock = gohelper.findChild(slot0.viewGO, "layout/#btn_copy/#go_copyunlock")
	slot0._btnshare = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_share")
	slot0._btnmoremask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_moremask")
	slot0._goinformexpand = gohelper.findChild(slot0.viewGO, "#go_informexpand")
	slot0._btninform = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_informexpand/#btn_inform")
	slot0._btnmore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_more")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnplaninfo:AddClickListener(slot0._btnplaninfoOnClick, slot0)
	slot0._btncopysharecode:AddClickListener(slot0._btncopysharecodeOnClick, slot0)
	slot0._btncomparing:AddClickListener(slot0._btncomparingOnClick, slot0)
	slot0._btncompare:AddClickListener(slot0._btncompareOnClick, slot0)
	slot0._btncopy:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btnshare:AddClickListener(slot0._btnshareOnClick, slot0)
	slot0._btnmoremask:AddClickListener(slot0._btnmoremaskOnClick, slot0)
	slot0._btninform:AddClickListener(slot0._btninformOnClick, slot0)
	slot0._btnmore:AddClickListener(slot0._btnmoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplaninfo:RemoveClickListener()
	slot0._btncopysharecode:RemoveClickListener()
	slot0._btncomparing:RemoveClickListener()
	slot0._btncompare:RemoveClickListener()
	slot0._btncopy:RemoveClickListener()
	slot0._btnshare:RemoveClickListener()
	slot0._btnmoremask:RemoveClickListener()
	slot0._btninform:RemoveClickListener()
	slot0._btnmore:RemoveClickListener()
end

function slot0._btncomparingOnClick(slot0)
	slot0:_compareRoom(false)
end

function slot0._btnmoremaskOnClick(slot0)
	slot0:_showExpand(false)
end

function slot0._btnmoreOnClick(slot0)
	slot0:_showExpand(slot0._isShowExpand ~= true)
end

function slot0._btncompareOnClick(slot0)
	slot0:_compareRoom(true)
end

function slot0._btninformOnClick(slot0)
	RoomInformController.instance:openShareTipView(slot0._playerMO, slot0._shareCode)
	slot0:_showExpand(false)
end

function slot0._btnplaninfoOnClick(slot0)
	RoomLayoutController.instance:openCopyTips(slot0._planInfo)
end

function slot0._btncopysharecodeOnClick(slot0)
	RoomLayoutController.instance:copyShareCodeTxt(slot0._shareCode)
end

function slot0._btncopyOnClick(slot0)
	if not slot0._isShare then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanCopy)

		return
	end

	if RoomLayoutController.instance:isOpen() then
		if RoomLayoutModel.instance:getCanUseShareCount() <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		RoomLayoutController.instance:openCopyView(slot0._playerMO.name)
	else
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)
	end
end

function slot0._btnshareOnClick(slot0)
	if slot0._playerMO:isMyFriend() then
		SocialModel.instance:setSelectFriend(slot0._playerMO.userId)
		SocialController.instance:openSocialView({
			preSendInfo = {
				recipientId = slot0._playerMO.userId,
				msgType = ChatEnum.MsgType.RoomSeekShare,
				content = luaLang("room_chat_seek_share_content")
			}
		})
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanApplyFriend, MsgBoxEnum.BoxType.Yes_No, slot0._sendAddFriend, nil, , slot0, nil, , slot0._playerMO.name)
	end
end

function slot0._sendAddFriend(slot0)
	SocialController.instance:AddFriend(slot0._playerMO.userId)
end

function slot0._editableInitView(slot0)
	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)

	slot0._playericon:setEnableClick(false)
	slot0._playericon:setShowLevel(false)
	slot0:_showExpand(false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshPlayerUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshData(slot0)
	slot0._isShare = RoomController.instance:isVisitShareMode()
	slot0._curInfo = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())

	if not slot0._curInfo then
		return
	end

	slot0._planInfo = RoomLayoutHelper.createInfoByObInfo(slot0._curInfo)
	slot0._shareCode = nil
	slot0._planName = nil
	slot0._isCompareInfo = false

	if not slot0._playerMO then
		slot0._playerMO = SocialPlayerMO.New()
	end

	if slot0._isShare then
		slot1 = slot0._curInfo

		slot0._playerMO:init(slot0:_createPlayerInfo(slot1.shareUserId, slot1.nickName, slot1.levle, slot1.portrait, slot1.time))

		slot0._shareCode = slot1.shareCode
		slot0._planName = slot1.roomPlanName

		if RoomLayoutHelper.checkVisitParamCoppare(RoomModel.instance:getVisitParam()) then
			slot0._isCompareInfo = true
		end

		if string.nilorempty(slot0._planName) then
			slot0._planName = formatLuaLang("room_layoutplan_default_name", "")
		end
	else
		slot0._playerMO:init(SocialModel.instance:getPlayerMO(slot0._curInfo.targetUid) or slot0:_createPlayerInfo(slot0._curInfo.targetUid))
		slot0:_checkPlayerInfo(slot0._playerMO)

		slot0._planName = formatLuaLang("room_layoutplan_look_details", slot0._playerMO.name or "")
	end
end

function slot0._createPlayerInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {
		userId = slot1 or 0,
		name = slot2,
		portrait = slot4 or 0,
		level = slot3 or 1,
		time = slot5 or 0
	}

	slot0:_checkPlayerInfo(slot6)

	return slot6
end

function slot0._checkPlayerInfo(slot0, slot1)
	if string.nilorempty(slot1.name) then
		slot1.name = string.format("#%s", slot1.userId)
	end
end

function slot0._refreshPlayerUI(slot0)
	slot0:_refreshData()

	if not slot0._curInfo then
		return
	end

	gohelper.setActive(slot0._goshareinfo, slot0._isShare)
	gohelper.setActive(slot0._btnshare, not slot0._isShare)
	slot0._playericon:onUpdateMO(slot0._playerMO)
	slot0._playericon:setShowLevel(false)

	slot0._txtplayername.text = slot0._playerMO.name
	slot0._txtplayerId.text = string.format("ID:%s", slot0._playerMO.userId)
	slot0._txtplanname.text = slot0._planName

	if slot0._isShare then
		slot0._txtsharecode.text = slot0._shareCode
		slot0._txtplaninfodesc.text = luaLang("room_layoutplan_share_notlack_desc")
		slot1 = slot0:_isHasAllBlockAndBuiling(slot0._planInfo)

		gohelper.setActive(slot0._goplaninfo, slot1)
		gohelper.setActive(slot0._gocomparing, not slot1 and slot0._isCompareInfo)
		gohelper.setActive(slot0._gocompare, not slot1 and not slot0._isCompareInfo)
	end

	slot0:_refreshLayoutPlan()
end

function slot0._isHasAllBlockAndBuiling(slot0, slot1)
	slot2, slot3, slot4, slot5 = RoomLayoutHelper.comparePlanInfo(slot1)

	if slot2 > 0 or slot3 > 0 or slot4 > 0 then
		return false
	end

	return true
end

function slot0._getDesStr(slot0, slot1)
	slot2, slot3, slot4, slot5 = RoomLayoutHelper.comparePlanInfo(slot1)

	if slot2 > 0 or slot3 > 0 or slot4 > 0 then
		slot6 = {}

		slot0:_addCollStrList("room_layoutplan_blockpackage_lack", slot2, slot6)
		slot0:_addCollStrList("room_layoutplan_birthdayblock_lack", slot3, slot6)
		slot0:_addCollStrList("room_layoutplan_building_lack", slot4, slot6)

		return string.format("<color=#AB1313>%s</color>", formatLuaLang("room_layoutplan_share_lack_desc", RoomLayoutHelper.connStrList(slot6, luaLang("room_levelup_init_and1"), luaLang("room_levelup_init_and2"))))
	end

	return luaLang("room_layoutplan_share_notlack_desc")
end

function slot0._addCollStrList(slot0, slot1, slot2, slot3)
	if slot2 > 0 then
		table.insert(slot3, formatLuaLang(slot1, slot2))
	end
end

function slot0._refreshLayoutPlan(slot0)
	slot2 = slot0._isShare and RoomLayoutController.instance:isOpen()

	gohelper.setActive(slot0._gocopyunlock, slot2)
	gohelper.setActive(slot0._gocopylock, not slot2)
end

function slot0._showExpand(slot0, slot1)
	slot0._isShowExpand = slot1

	gohelper.setActive(slot0._goinformexpand, slot1)
	gohelper.setActive(slot0._btnmoremask, slot1)
end

function slot0._compareRoom(slot0, slot1)
	slot0._isCompareInfo = slot1

	if GameSceneMgr.instance:getCurScene() and slot2.camera then
		slot3 = RoomEnum.CameraState.Overlook

		slot2.camera:switchCameraState(slot3, {
			focusY = 0,
			focusX = 0,
			rotate = 0,
			zoom = slot2.camera:getZoomInitValue(slot3)
		}, nil, slot0._onSwitchCameraDone, slot0)
	else
		slot0:_onSwitchCameraDone()
	end
end

function slot0._onSwitchCameraDone(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, slot0._curInfo, {
		userId = slot0._playerMO.userId,
		shareCode = slot0._shareCode,
		isCompareInfo = slot0._isCompareInfo
	}, nil, , true)
end

return slot0
