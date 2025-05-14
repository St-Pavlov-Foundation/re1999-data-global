module("modules.logic.room.view.layout.RoomLayoutVisitPlan", package.seeall)

local var_0_0 = class("RoomLayoutVisitPlan", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goplayinfo = gohelper.findChild(arg_1_0.viewGO, "#go_playinfo")
	arg_1_0._txtplanname = gohelper.findChildText(arg_1_0.viewGO, "#go_playinfo/#txt_planname")
	arg_1_0._btnplaninfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_playinfo/#txt_planname/#btn_planinfo")
	arg_1_0._txtplayername = gohelper.findChildText(arg_1_0.viewGO, "#go_playinfo/#txt_playername")
	arg_1_0._txtplayerId = gohelper.findChildText(arg_1_0.viewGO, "#go_playinfo/#txt_playerId")
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "#go_playinfo/#go_playericon")
	arg_1_0._goshareinfo = gohelper.findChild(arg_1_0.viewGO, "#go_shareinfo")
	arg_1_0._txtsharecode = gohelper.findChildText(arg_1_0.viewGO, "#go_shareinfo/go_sharecode/#txt_sharecode")
	arg_1_0._btncopysharecode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_shareinfo/go_sharecode/#btn_copysharecode")
	arg_1_0._goplaninfo = gohelper.findChild(arg_1_0.viewGO, "#go_shareinfo/#go_planinfo")
	arg_1_0._txtplaninfodesc = gohelper.findChildText(arg_1_0.viewGO, "#go_shareinfo/#go_planinfo/#txt_planinfodesc")
	arg_1_0._gocomparing = gohelper.findChild(arg_1_0.viewGO, "#go_shareinfo/#go_comparing")
	arg_1_0._btncomparing = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_shareinfo/#go_comparing/txt_comparing/#btn_comparing")
	arg_1_0._gocompare = gohelper.findChild(arg_1_0.viewGO, "#go_shareinfo/#go_compare")
	arg_1_0._btncompare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_shareinfo/#go_compare/txt_compare/#btn_compare")
	arg_1_0._btncopy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_copy")
	arg_1_0._gocopylock = gohelper.findChild(arg_1_0.viewGO, "layout/#btn_copy/#go_copylock")
	arg_1_0._gocopyunlock = gohelper.findChild(arg_1_0.viewGO, "layout/#btn_copy/#go_copyunlock")
	arg_1_0._btnshare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_share")
	arg_1_0._btnmoremask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_moremask")
	arg_1_0._goinformexpand = gohelper.findChild(arg_1_0.viewGO, "#go_informexpand")
	arg_1_0._btninform = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_informexpand/#btn_inform")
	arg_1_0._btnmore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_more")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplaninfo:AddClickListener(arg_2_0._btnplaninfoOnClick, arg_2_0)
	arg_2_0._btncopysharecode:AddClickListener(arg_2_0._btncopysharecodeOnClick, arg_2_0)
	arg_2_0._btncomparing:AddClickListener(arg_2_0._btncomparingOnClick, arg_2_0)
	arg_2_0._btncompare:AddClickListener(arg_2_0._btncompareOnClick, arg_2_0)
	arg_2_0._btncopy:AddClickListener(arg_2_0._btncopyOnClick, arg_2_0)
	arg_2_0._btnshare:AddClickListener(arg_2_0._btnshareOnClick, arg_2_0)
	arg_2_0._btnmoremask:AddClickListener(arg_2_0._btnmoremaskOnClick, arg_2_0)
	arg_2_0._btninform:AddClickListener(arg_2_0._btninformOnClick, arg_2_0)
	arg_2_0._btnmore:AddClickListener(arg_2_0._btnmoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplaninfo:RemoveClickListener()
	arg_3_0._btncopysharecode:RemoveClickListener()
	arg_3_0._btncomparing:RemoveClickListener()
	arg_3_0._btncompare:RemoveClickListener()
	arg_3_0._btncopy:RemoveClickListener()
	arg_3_0._btnshare:RemoveClickListener()
	arg_3_0._btnmoremask:RemoveClickListener()
	arg_3_0._btninform:RemoveClickListener()
	arg_3_0._btnmore:RemoveClickListener()
end

function var_0_0._btncomparingOnClick(arg_4_0)
	arg_4_0:_compareRoom(false)
end

function var_0_0._btnmoremaskOnClick(arg_5_0)
	arg_5_0:_showExpand(false)
end

function var_0_0._btnmoreOnClick(arg_6_0)
	arg_6_0:_showExpand(arg_6_0._isShowExpand ~= true)
end

function var_0_0._btncompareOnClick(arg_7_0)
	arg_7_0:_compareRoom(true)
end

function var_0_0._btninformOnClick(arg_8_0)
	RoomInformController.instance:openShareTipView(arg_8_0._playerMO, arg_8_0._shareCode)
	arg_8_0:_showExpand(false)
end

function var_0_0._btnplaninfoOnClick(arg_9_0)
	RoomLayoutController.instance:openCopyTips(arg_9_0._planInfo)
end

function var_0_0._btncopysharecodeOnClick(arg_10_0)
	RoomLayoutController.instance:copyShareCodeTxt(arg_10_0._shareCode)
end

function var_0_0._btncopyOnClick(arg_11_0)
	if not arg_11_0._isShare then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanCopy)

		return
	end

	if RoomLayoutController.instance:isOpen() then
		if RoomLayoutModel.instance:getCanUseShareCount() <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		RoomLayoutController.instance:openCopyView(arg_11_0._playerMO.name)
	else
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)
	end
end

function var_0_0._btnshareOnClick(arg_12_0)
	if arg_12_0._playerMO:isMyFriend() then
		local var_12_0 = {
			preSendInfo = {
				recipientId = arg_12_0._playerMO.userId,
				msgType = ChatEnum.MsgType.RoomSeekShare,
				content = luaLang("room_chat_seek_share_content")
			}
		}

		SocialModel.instance:setSelectFriend(arg_12_0._playerMO.userId)
		SocialController.instance:openSocialView(var_12_0)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanApplyFriend, MsgBoxEnum.BoxType.Yes_No, arg_12_0._sendAddFriend, nil, nil, arg_12_0, nil, nil, arg_12_0._playerMO.name)
	end
end

function var_0_0._sendAddFriend(arg_13_0)
	SocialController.instance:AddFriend(arg_13_0._playerMO.userId)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_14_0._goplayericon)

	arg_14_0._playericon:setEnableClick(false)
	arg_14_0._playericon:setShowLevel(false)
	arg_14_0:_showExpand(false)
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_refreshPlayerUI()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

function var_0_0._refreshData(arg_19_0)
	arg_19_0._isShare = RoomController.instance:isVisitShareMode()
	arg_19_0._curInfo = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())

	if not arg_19_0._curInfo then
		return
	end

	arg_19_0._planInfo = RoomLayoutHelper.createInfoByObInfo(arg_19_0._curInfo)
	arg_19_0._shareCode = nil
	arg_19_0._planName = nil
	arg_19_0._isCompareInfo = false

	if not arg_19_0._playerMO then
		arg_19_0._playerMO = SocialPlayerMO.New()
	end

	if arg_19_0._isShare then
		local var_19_0 = arg_19_0._curInfo
		local var_19_1 = arg_19_0:_createPlayerInfo(var_19_0.shareUserId, var_19_0.nickName, var_19_0.levle, var_19_0.portrait, var_19_0.time)

		arg_19_0._playerMO:init(var_19_1)

		arg_19_0._shareCode = var_19_0.shareCode
		arg_19_0._planName = var_19_0.roomPlanName

		local var_19_2 = RoomModel.instance:getVisitParam()

		if RoomLayoutHelper.checkVisitParamCoppare(var_19_2) then
			arg_19_0._isCompareInfo = true
		end

		if string.nilorempty(arg_19_0._planName) then
			arg_19_0._planName = formatLuaLang("room_layoutplan_default_name", "")
		end
	else
		local var_19_3 = SocialModel.instance:getPlayerMO(arg_19_0._curInfo.targetUid) or arg_19_0:_createPlayerInfo(arg_19_0._curInfo.targetUid)

		arg_19_0._playerMO:init(var_19_3)
		arg_19_0:_checkPlayerInfo(arg_19_0._playerMO)

		arg_19_0._planName = formatLuaLang("room_layoutplan_look_details", arg_19_0._playerMO.name or "")
	end
end

function var_0_0._createPlayerInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = {
		userId = arg_20_1 or 0,
		name = arg_20_2,
		portrait = arg_20_4 or 0,
		level = arg_20_3 or 1,
		time = arg_20_5 or 0
	}

	arg_20_0:_checkPlayerInfo(var_20_0)

	return var_20_0
end

function var_0_0._checkPlayerInfo(arg_21_0, arg_21_1)
	if string.nilorempty(arg_21_1.name) then
		arg_21_1.name = string.format("#%s", arg_21_1.userId)
	end
end

function var_0_0._refreshPlayerUI(arg_22_0)
	arg_22_0:_refreshData()

	if not arg_22_0._curInfo then
		return
	end

	gohelper.setActive(arg_22_0._goshareinfo, arg_22_0._isShare)
	gohelper.setActive(arg_22_0._btnshare, not arg_22_0._isShare)
	arg_22_0._playericon:onUpdateMO(arg_22_0._playerMO)
	arg_22_0._playericon:setShowLevel(false)

	arg_22_0._txtplayername.text = arg_22_0._playerMO.name
	arg_22_0._txtplayerId.text = string.format("ID:%s", arg_22_0._playerMO.userId)
	arg_22_0._txtplanname.text = arg_22_0._planName

	if arg_22_0._isShare then
		arg_22_0._txtsharecode.text = arg_22_0._shareCode
		arg_22_0._txtplaninfodesc.text = luaLang("room_layoutplan_share_notlack_desc")

		local var_22_0 = arg_22_0:_isHasAllBlockAndBuiling(arg_22_0._planInfo)

		gohelper.setActive(arg_22_0._goplaninfo, var_22_0)
		gohelper.setActive(arg_22_0._gocomparing, not var_22_0 and arg_22_0._isCompareInfo)
		gohelper.setActive(arg_22_0._gocompare, not var_22_0 and not arg_22_0._isCompareInfo)
	end

	arg_22_0:_refreshLayoutPlan()
end

function var_0_0._isHasAllBlockAndBuiling(arg_23_0, arg_23_1)
	local var_23_0, var_23_1, var_23_2, var_23_3 = RoomLayoutHelper.comparePlanInfo(arg_23_1)

	if var_23_0 > 0 or var_23_1 > 0 or var_23_2 > 0 then
		return false
	end

	return true
end

function var_0_0._getDesStr(arg_24_0, arg_24_1)
	local var_24_0, var_24_1, var_24_2, var_24_3 = RoomLayoutHelper.comparePlanInfo(arg_24_1)

	if var_24_0 > 0 or var_24_1 > 0 or var_24_2 > 0 then
		local var_24_4 = {}

		arg_24_0:_addCollStrList("room_layoutplan_blockpackage_lack", var_24_0, var_24_4)
		arg_24_0:_addCollStrList("room_layoutplan_birthdayblock_lack", var_24_1, var_24_4)
		arg_24_0:_addCollStrList("room_layoutplan_building_lack", var_24_2, var_24_4)

		local var_24_5 = luaLang("room_levelup_init_and1")
		local var_24_6 = luaLang("room_levelup_init_and2")
		local var_24_7 = RoomLayoutHelper.connStrList(var_24_4, var_24_5, var_24_6)

		return string.format("<color=#AB1313>%s</color>", formatLuaLang("room_layoutplan_share_lack_desc", var_24_7))
	end

	return luaLang("room_layoutplan_share_notlack_desc")
end

function var_0_0._addCollStrList(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 > 0 then
		table.insert(arg_25_3, formatLuaLang(arg_25_1, arg_25_2))
	end
end

function var_0_0._refreshLayoutPlan(arg_26_0)
	local var_26_0 = RoomLayoutController.instance:isOpen()
	local var_26_1 = arg_26_0._isShare and var_26_0

	gohelper.setActive(arg_26_0._gocopyunlock, var_26_1)
	gohelper.setActive(arg_26_0._gocopylock, not var_26_1)
end

function var_0_0._showExpand(arg_27_0, arg_27_1)
	arg_27_0._isShowExpand = arg_27_1

	gohelper.setActive(arg_27_0._goinformexpand, arg_27_1)
	gohelper.setActive(arg_27_0._btnmoremask, arg_27_1)
end

function var_0_0._compareRoom(arg_28_0, arg_28_1)
	arg_28_0._isCompareInfo = arg_28_1

	local var_28_0 = GameSceneMgr.instance:getCurScene()

	if var_28_0 and var_28_0.camera then
		local var_28_1 = RoomEnum.CameraState.Overlook
		local var_28_2 = {
			focusY = 0,
			focusX = 0,
			rotate = 0,
			zoom = var_28_0.camera:getZoomInitValue(var_28_1)
		}

		var_28_0.camera:switchCameraState(var_28_1, var_28_2, nil, arg_28_0._onSwitchCameraDone, arg_28_0)
	else
		arg_28_0:_onSwitchCameraDone()
	end
end

function var_0_0._onSwitchCameraDone(arg_29_0)
	local var_29_0 = {
		userId = arg_29_0._playerMO.userId,
		shareCode = arg_29_0._shareCode,
		isCompareInfo = arg_29_0._isCompareInfo
	}
	local var_29_1 = arg_29_0._curInfo

	RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, var_29_1, var_29_0, nil, nil, true)
end

return var_0_0
