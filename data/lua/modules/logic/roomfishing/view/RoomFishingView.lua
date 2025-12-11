module("modules.logic.roomfishing.view.RoomFishingView", package.seeall)

local var_0_0 = class("RoomFishingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelf = gohelper.findChild(arg_1_0.viewGO, "Root/Left/playerInfo/#go_Self")
	arg_1_0._goFriend = gohelper.findChild(arg_1_0.viewGO, "Root/Left/playerInfo/#go_Friend")
	arg_1_0._goheadicon = gohelper.findChild(arg_1_0.viewGO, "Root/Left/playerInfo/#go_headicon")
	arg_1_0._txtPlayerName = gohelper.findChildText(arg_1_0.viewGO, "Root/Left/playerInfo/#txt_PlayerName")
	arg_1_0._btnInfoCopy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/playerInfo/#btn_Copy")
	arg_1_0._txtrefreshTime = gohelper.findChildText(arg_1_0.viewGO, "Root/Left/playerInfo/#txt_refreshTime")
	arg_1_0._btnExpandFriendList = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/FriendList/#btn_Expand")
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/#input_inform")
	arg_1_0._btnFoldFriendList = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/#btn_Fold")
	arg_1_0._gounfishingTab = gohelper.findChild(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab1/#go_Selected")
	arg_1_0._btnunfishingTab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab1/image_TabBG")
	arg_1_0._gofishingTab = gohelper.findChild(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab2/#go_Selected")
	arg_1_0._btnfishingTab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/FriendList/#go_Expand/Tab/Tab2/image_TabBG")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Left/btn_hide")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/btn_back")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfoCopy:AddClickListener(arg_2_0._btnInfoCopyOnClick, arg_2_0)
	arg_2_0._btnExpandFriendList:AddClickListener(arg_2_0._btnExpandFriendListOnClick, arg_2_0)
	arg_2_0._btnFoldFriendList:AddClickListener(arg_2_0._btnFoldFriendListOnClick, arg_2_0)
	arg_2_0._btnunfishingTab:AddClickListener(arg_2_0._btnFriendTabOnClick, arg_2_0, FishingEnum.FriendListTag.UnFishing)
	arg_2_0._btnfishingTab:AddClickListener(arg_2_0._btnFriendTabOnClick, arg_2_0, FishingEnum.FriendListTag.Fishing)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnHideOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._input:AddOnValueChanged(arg_2_0._inputValueChanged, arg_2_0)
	arg_2_0._input:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_2_0._onFishingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, arg_2_0._onFishingProgressUpdate, arg_2_0)
	arg_2_0:addEventCb(FishingController.instance, FishingEvent.OnSelectFriendTab, arg_2_0.refreshFriendTab, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(GameSceneMgr.instance, SceneEventName.EnterSceneFinish, arg_2_0._onSceneDone, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(RoomController.instance, RoomEvent.OnSwitchModeDone, arg_2_0._onSceneDone, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfoCopy:RemoveClickListener()
	arg_3_0._btnExpandFriendList:RemoveClickListener()
	arg_3_0._btnFoldFriendList:RemoveClickListener()
	arg_3_0._btnunfishingTab:RemoveClickListener()
	arg_3_0._btnfishingTab:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._input:RemoveOnValueChanged()
	arg_3_0._input:RemoveOnEndEdit()
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, arg_3_0._onFishingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, arg_3_0._onFishingProgressUpdate, arg_3_0)
	arg_3_0:removeEventCb(FishingController.instance, FishingEvent.OnSelectFriendTab, arg_3_0.refreshFriendTab, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(GameSceneMgr.instance, SceneEventName.EnterSceneFinish, arg_3_0._onSceneDone, arg_3_0)
	arg_3_0:removeEventCb(RoomController.instance, RoomEvent.OnSwitchModeDone, arg_3_0._onSceneDone, arg_3_0)
end

function var_0_0._btnInfoCopyOnClick(arg_4_0)
	local var_4_0 = FishingModel.instance:getCurShowingUserId()

	ZProj.UGUIHelper.CopyText(var_4_0)
	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function var_0_0._btnExpandFriendListOnClick(arg_5_0)
	FishingController.instance:getFriendListInfo(arg_5_0._realExpandFriendList, arg_5_0)
end

function var_0_0._realExpandFriendList(arg_6_0)
	arg_6_0._isFriendListExpand = true

	arg_6_0:_btnFriendTabOnClick(FishingEnum.FriendListTag.UnFishing)
	arg_6_0:refreshFriendListExpand(true)
end

function var_0_0._btnFoldFriendListOnClick(arg_7_0)
	arg_7_0._isFriendListExpand = false

	arg_7_0:refreshFriendListExpand(true, arg_7_0._btnFriendTabOnClick, arg_7_0)
end

function var_0_0._btnFriendTabOnClick(arg_8_0, arg_8_1)
	FishingController.instance:selectFriendTab(arg_8_1)
end

function var_0_0._btnHideOnClick(arg_9_0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)
	else
		RoomMapController.instance:setUIHide(true)
	end
end

function var_0_0._btnbackOnClick(arg_10_0)
	FishingController.instance:enterFishingMode(true)
end

function var_0_0._inputValueChanged(arg_11_0)
	local var_11_0 = arg_11_0._input:GetText()
	local var_11_1 = string.gsub(var_11_0, "[^0-9]", "")
	local var_11_2 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.UidInputCountLimit, true)
	local var_11_3 = GameUtil.utf8sub(var_11_1, 1, math.min(GameUtil.utf8len(var_11_1), var_11_2))

	if var_11_3 ~= var_11_0 then
		arg_11_0._input:SetTextWithoutNotify(var_11_3)
	end
end

function var_0_0._onEndEdit(arg_12_0, arg_12_1)
	if not tonumber(arg_12_1) then
		return
	end

	FishingController.instance:visitOtherFishingPool(arg_12_1)
end

function var_0_0._onFishingInfoUpdate(arg_13_0, arg_13_1)
	if arg_13_1 then
		FishingController.instance:updateFriendListInfo()
	end
end

function var_0_0._onFishingProgressUpdate(arg_14_0)
	FishingController.instance:getFriendListInfo()
end

function var_0_0._onDailyRefresh(arg_15_0)
	if FishingModel.instance:getIsShowingMySelf() then
		arg_15_0:_updateFishingInfo(true)
	else
		arg_15_0:_btnbackOnClick()
	end
end

function var_0_0._onSceneDone(arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._delayDispatchOpen, arg_16_0, 0.1)
end

function var_0_0._delayDispatchOpen(arg_17_0)
	FishingController.instance:dispatchEvent(FishingEvent.GuideOnOpenFishingView)
end

function var_0_0._editableInitView(arg_18_0)
	local var_18_0 = gohelper.findChild(arg_18_0.viewGO, "Root/Left/FriendList")

	arg_18_0._friendListAnimator = var_18_0:GetComponent(typeof(UnityEngine.Animator))
	arg_18_0._friendListAnimatorPlayer = SLFramework.AnimatorPlayer.Get(var_18_0)
	arg_18_0._selectedFriendTag = FishingEnum.FriendListTag.UnFishing

	arg_18_0:setPlayerInfo()

	arg_18_0._PcBtnHide = gohelper.findChild(arg_18_0.viewGO, "Root/Left/btn_hide/#go_pcbtn")

	PCInputController.instance:showkeyTips(arg_18_0._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:refresh()
	arg_20_0:everySecondCall()
	TaskDispatcher.cancelTask(arg_20_0.everySecondCall, arg_20_0)
	TaskDispatcher.runRepeat(arg_20_0.everySecondCall, arg_20_0, TimeUtil.OneSecond)
	FishingController.instance:dispatchEvent(FishingEvent.GuideOnOpenFishingView)
end

function var_0_0.setPlayerInfo(arg_21_0)
	local var_21_0, var_21_1, var_21_2 = FishingModel.instance:getCurFishingPoolUserInfo()

	arg_21_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_21_0._goheadicon)

	arg_21_0._playericon:setMOValue(var_21_0, "", 0, var_21_2)
	arg_21_0._playericon:setEnableClick(false)
	arg_21_0._playericon:setShowLevel(false)

	arg_21_0._txtPlayerName.text = var_21_1

	local var_21_3 = FishingModel.instance:getIsShowingMySelf()

	gohelper.setActive(arg_21_0._goSelf, var_21_3)
	gohelper.setActive(arg_21_0._goFriend, not var_21_3)
	gohelper.setActive(arg_21_0._btnback, not var_21_3)

	arg_21_0._isFriendListExpand = not var_21_3
end

function var_0_0.refresh(arg_22_0)
	arg_22_0:refreshTime()
	arg_22_0:refreshFriendListExpand()
end

function var_0_0.refreshFriendListExpand(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:refreshFriendTab()

	local var_23_0 = arg_23_0._isFriendListExpand and UIAnimationName.Open or UIAnimationName.Close

	if arg_23_1 then
		arg_23_0._friendListAnimatorPlayer:Play(var_23_0, arg_23_2, arg_23_3)
	else
		arg_23_0._friendListAnimator.enabled = true

		arg_23_0._friendListAnimator:Play(var_23_0, 0, 1)
	end
end

function var_0_0.refreshFriendTab(arg_24_0)
	local var_24_0 = FishingFriendListModel.instance:getSelectedTab()

	gohelper.setActive(arg_24_0._gounfishingTab, var_24_0 == FishingEnum.FriendListTag.UnFishing)
	gohelper.setActive(arg_24_0._gofishingTab, var_24_0 == FishingEnum.FriendListTag.Fishing)
end

function var_0_0.everySecondCall(arg_25_0)
	arg_25_0:refreshTime()
	arg_25_0:checkBonus()
end

local var_0_1 = 2

function var_0_0.refreshTime(arg_26_0)
	local var_26_0, var_26_1 = FishingModel.instance:getCurFishingPoolRefreshTime()
	local var_26_2 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_26_0))

	arg_26_0._txtrefreshTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("RoomFishing_refresh_time"), var_26_2)

	if var_26_1 then
		arg_26_0:_updateFishingInfo()
	end
end

function var_0_0._updateFishingInfo(arg_27_0, arg_27_1)
	if not arg_27_1 then
		local var_27_0 = arg_27_0._lastGetInfoTime or 0
		local var_27_1 = Time.realtimeSinceStartup - var_27_0

		if arg_27_0.gettingInfo or var_27_1 < var_0_1 then
			return
		end
	end

	if FishingModel.instance:getIsShowingMySelf() then
		FishingController.instance:getFishingInfo(nil, arg_27_0._afterGetFishingInfo, arg_27_0)
	else
		local var_27_2 = FishingModel.instance:getCurShowingUserId()

		if var_27_2 then
			FishingController.instance:getFishingInfo(var_27_2, arg_27_0._afterGetFishingInfo, arg_27_0)
		end
	end

	arg_27_0._lastGetInfoTime = Time.realtimeSinceStartup
	arg_27_0.gettingInfo = true
end

function var_0_0._afterGetFishingInfo(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_2 ~= 0 then
		return
	end

	arg_28_0.gettingInfo = false

	arg_28_0:refreshTime()
	FishingController.instance:getFriendListInfo()
end

local var_0_2 = 2

function var_0_0.checkBonus(arg_29_0)
	local var_29_0 = ViewMgr.instance:isOpen(ViewName.LoadingRoomView)
	local var_29_1 = UIBlockMgr.instance:isKeyBlock(RoomController.ENTER_ROOM_BLOCK_KEY)

	if arg_29_0.gettingBonus or var_29_0 or var_29_1 then
		return
	end

	local var_29_2 = arg_29_0._lastGetBonusTime or 0

	if Time.realtimeSinceStartup - var_29_2 < var_0_2 then
		return
	end

	arg_29_0.gettingBonus = FishingController.instance:checkGetBonus(arg_29_0._afterGetBonus, arg_29_0)

	if arg_29_0.gettingBonus then
		arg_29_0._lastGetBonusTime = Time.realtimeSinceStartup
	end
end

function var_0_0._afterGetBonus(arg_30_0)
	arg_30_0.gettingBonus = false
end

function var_0_0.onClose(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.everySecondCall, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._delayDispatchOpen, arg_31_0)
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
