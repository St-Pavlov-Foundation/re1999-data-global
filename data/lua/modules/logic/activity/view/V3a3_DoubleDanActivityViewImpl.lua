module("modules.logic.activity.view.V3a3_DoubleDanActivityViewImpl", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivityViewImpl", BaseView)

function var_0_0._sendGet101BonusRequest(arg_1_0, arg_1_1, arg_1_2)
	return arg_1_0.viewContainer:sendGet101BonusRequest(arg_1_0:getSelectedDay(), arg_1_1, arg_1_2)
end

function var_0_0._isType101RewardCouldGet(arg_2_0)
	return arg_2_0.viewContainer:isType101RewardCouldGet(arg_2_0:getSelectedDay())
end

function var_0_0._isType101RewardGet(arg_3_0)
	return arg_3_0.viewContainer:isType101RewardGet(arg_3_0:getSelectedDay())
end

function var_0_0._isDayOpen(arg_4_0)
	return arg_4_0.viewContainer:isDayOpen(arg_4_0:getSelectedDay())
end

function var_0_0.ctor(arg_5_0)
	var_0_0.super.ctor(arg_5_0)

	arg_5_0._itemTabList = {}
	arg_5_0._rewardItemList = {}
end

function var_0_0._btnClaimOnClick(arg_6_0)
	arg_6_0:onRewardItemClick()
end

function var_0_0.onRewardItemClick(arg_7_0)
	if not arg_7_0:_isType101RewardCouldGet() then
		return
	end

	arg_7_0:_sendGet101BonusRequest(arg_7_0._onClaimCb, arg_7_0)

	return true
end

function var_0_0._btnGoOnClick(arg_8_0)
	local var_8_0 = ActivityType101Config.instance:getDoubleDanJumpId()

	GameFacade.jump(var_8_0)
end

function var_0_0._btnswitchOnClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	arg_9_0._isShowSpine = not arg_9_0._isShowSpine

	arg_9_0._animator:Play(UIAnimationName.Switch, 0, 0)
	arg_9_0:_refreshTxtSwitch()
	TaskDispatcher.cancelTask(arg_9_0._refreshBigVertical, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._refreshBigVertical, arg_9_0, 0.16)
end

function var_0_0._btnClaimedOnClick(arg_10_0)
	return
end

function var_0_0._btnUnopenOnClick(arg_11_0)
	return
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:_refresh()
	arg_12_0:_refreshTxtSwitch()
	arg_12_0:_refreshTimeTick()
	arg_12_0:_refreshBigVertical()
	arg_12_0:_refreshSkinDesc()
end

function var_0_0._refreshSkinDesc(arg_13_0)
	local var_13_0 = arg_13_0.viewContainer:getSkinCo()
	local var_13_1 = arg_13_0.viewContainer:getHeroCO()

	arg_13_0._txtcharacterName.text = var_13_1.name
	arg_13_0._txtskinNameEn.text = var_13_0.nameEng
	arg_13_0._txtskinName.text = var_13_0.name
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._lastItemTab = nil
	arg_14_0._isShowSpine = false

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)

	arg_14_0._txtLimitTime.text = ""

	TaskDispatcher.runRepeat(arg_14_0._refreshTimeTick, arg_14_0, 1)

	if arg_14_0.viewParam.parent then
		gohelper.addChild(arg_14_0.viewParam.parent, arg_14_0.viewGO)
	end

	local var_14_0 = arg_14_0.viewContainer:getActivityCo()

	arg_14_0._txtDescr.text = var_14_0.actDesc

	arg_14_0:onUpdateParam()
	arg_14_0:_focusByIndex(arg_14_0:getSelectedDay())
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_14_0._onRefreshNorSignActivity, arg_14_0)
end

function var_0_0._onClaimCb(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getFirstAvailableIndex()

	FrameTimerController.onDestroyViewMember(arg_15_0, "_frameTimer")

	if arg_15_0:getSelectedDay() ~= var_15_0 then
		arg_15_0._frameTimer = FrameTimerController.instance:register(function()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(arg_15_0, "_frameTimer")
				arg_15_0:_focusAndClickTabByIndex(var_15_0)
			end
		end, nil, 6, 6)

		arg_15_0._frameTimer:Start()
	end
end

function var_0_0.onClose(arg_17_0)
	FrameTimerController.onDestroyViewMember(arg_17_0, "_fTimer")
	FrameTimerController.onDestroyViewMember(arg_17_0, "_frameTimer")
	TaskDispatcher.cancelTask(arg_17_0._refreshTimeTick, arg_17_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_17_0._onRefreshNorSignActivity, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	FrameTimerController.onDestroyViewMember(arg_18_0, "_fTimer")
	FrameTimerController.onDestroyViewMember(arg_18_0, "_frameTimer")
	TaskDispatcher.cancelTask(arg_18_0._refreshBigVertical, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._refreshTimeTick, arg_18_0)

	if arg_18_0._bigSpine then
		arg_18_0._bigSpine:onDestroy()

		arg_18_0._bigSpine = nil
	end

	GameUtil.onDestroyViewMemberList(arg_18_0, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(arg_18_0, "_itemTabList")
end

function var_0_0._onRefreshNorSignActivity(arg_19_0)
	arg_19_0:_refreshTabList()
	arg_19_0:_onClickTab(arg_19_0._lastItemTab)
end

function var_0_0._refresh(arg_20_0)
	arg_20_0:_refreshTabList()
end

function var_0_0._refreshBtnState(arg_21_0)
	local var_21_0 = arg_21_0:_isType101RewardCouldGet()
	local var_21_1 = arg_21_0:_isType101RewardGet()
	local var_21_2 = arg_21_0:_isDayOpen()

	gohelper.setActive(arg_21_0._btnClaimGo, var_21_0)
	gohelper.setActive(arg_21_0._btnClaimedGo, var_21_1)
	gohelper.setActive(arg_21_0._btnUnopenGo, not var_21_2)
	gohelper.setActive(arg_21_0._goClaim, var_21_0)
end

function var_0_0._refreshTabList(arg_22_0)
	local var_22_0 = arg_22_0:getSelectedDay()
	local var_22_1 = arg_22_0.viewContainer:getSignMaxDay()

	for iter_22_0 = 1, var_22_1 do
		local var_22_2 = arg_22_0._itemTabList[iter_22_0]

		if not var_22_2 then
			var_22_2 = arg_22_0:_create_V3a3_DoubleDanActivity_radiotaskitem(iter_22_0)

			table.insert(arg_22_0._itemTabList, var_22_2)
		end

		var_22_2:onUpdateMO()
		var_22_2:setActive(true)
		var_22_2:setSelected(iter_22_0 == var_22_0)
	end

	for iter_22_1 = var_22_1 + 1, #arg_22_0._itemTabList do
		arg_22_0._itemTabList[iter_22_1]:setActive(false)
	end

	arg_22_0:onClickTab(arg_22_0._itemTabList[var_22_0 or 1] or arg_22_0._itemTabList[1])
end

function var_0_0.getSelectedDay(arg_23_0)
	local var_23_0

	if arg_23_0._lastItemTab then
		var_23_0 = arg_23_0._lastItemTab:index()
	else
		var_23_0 = arg_23_0.viewContainer:getFirstAvailableIndex()

		if var_23_0 <= 0 then
			var_23_0 = arg_23_0.viewContainer:getType101LoginCount()
		end
	end

	return GameUtil.clamp(var_23_0, 1, arg_23_0.viewContainer:getSignMaxDay())
end

function var_0_0.onClickTab(arg_24_0, arg_24_1)
	if arg_24_0._lastItemTab == arg_24_1 then
		return
	end

	if arg_24_0._lastItemTab and arg_24_0._lastItemTab:index() == arg_24_1:index() then
		return
	end

	arg_24_0:_onClickTab(arg_24_1)
end

function var_0_0._onClickTab(arg_25_0, arg_25_1)
	if arg_25_0._lastItemTab then
		arg_25_0._lastItemTab:setSelected(false)
	end

	arg_25_0._lastItemTab = arg_25_1

	if arg_25_1 then
		arg_25_1:setSelected(true)
		arg_25_0:_refreshRewardList(arg_25_1:index())
	end
end

function var_0_0._refreshRewardList(arg_26_0, arg_26_1)
	arg_26_1 = arg_26_1 or arg_26_0:getSelectedDay()

	local var_26_0 = arg_26_0.viewContainer:getDayBonusList(arg_26_1)
	local var_26_1 = #var_26_0
	local var_26_2

	if var_26_1 == 1 then
		var_26_2 = arg_26_0._1SlotTrans
	elseif var_26_1 == 2 then
		var_26_2 = arg_26_0._2SlotTrans
	elseif var_26_1 == 3 then
		var_26_2 = arg_26_0._3SlotTrans
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_3 = arg_26_0._rewardItemList[iter_26_0]

		if not var_26_3 then
			var_26_3 = arg_26_0:_create_V3a3_DoubleDanActivity_rewarditem(iter_26_0)

			table.insert(arg_26_0._rewardItemList, var_26_3)
		end

		local var_26_4 = iter_26_0 - 1
		local var_26_5 = var_26_2:GetChild(var_26_4)

		if var_26_5 then
			var_26_3:onUpdateMO(iter_26_1)
			var_26_3:setActive(true)
			var_26_3:setParentAndResetPosZero(var_26_5)
		else
			logError(tostring(iter_26_0) .. "Slot child node out of range!")
		end
	end

	for iter_26_2 = var_26_1 + 1, #arg_26_0._rewardItemList do
		arg_26_0._rewardItemList[iter_26_2]:setActive(false)
	end

	arg_26_0:_refreshBtnState()
end

function var_0_0._refreshTimeTick(arg_27_0)
	arg_27_0._txtLimitTime.text = arg_27_0.viewContainer:getRemainTimeStr()
end

function var_0_0._refreshTxtSwitch(arg_28_0)
	arg_28_0._txtswitch.text = arg_28_0._isShowSpine and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function var_0_0._create_V3a3_DoubleDanActivity_radiotaskitem(arg_29_0, arg_29_1)
	local var_29_0 = gohelper.cloneInPlace(arg_29_0._goradiotaskitem)
	local var_29_1 = V3a3_DoubleDanActivity_radiotaskitem.New({
		parent = arg_29_0,
		baseViewContainer = arg_29_0.viewContainer
	})

	var_29_1:setIndex(arg_29_1)
	var_29_1:init(var_29_0)

	return var_29_1
end

function var_0_0._create_V3a3_DoubleDanActivity_rewarditem(arg_30_0, arg_30_1)
	local var_30_0 = gohelper.cloneInPlace(arg_30_0._goitem)
	local var_30_1 = V3a3_DoubleDanActivity_rewarditem.New({
		parent = arg_30_0,
		baseViewContainer = arg_30_0.viewContainer
	})

	var_30_1:setIndex(arg_30_1)
	var_30_1:init(var_30_0)

	return var_30_1
end

function var_0_0._refreshBigVertical(arg_31_0)
	local var_31_0 = arg_31_0.viewContainer:getSkinCo()

	gohelper.setActive(arg_31_0._gospinecontainer, arg_31_0._isShowSpine)
	gohelper.setActive(arg_31_0._simageRoleGo, not arg_31_0._isShowSpine)
	arg_31_0._bigSpine:setModelVisible(arg_31_0._isShowSpine)
end

function var_0_0._onBigSpineLoaded(arg_32_0)
	arg_32_0._bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local var_32_0 = arg_32_0.viewContainer:getSkinCo()
	local var_32_1 = var_32_0.skinSwitchLive2dOffset

	if string.nilorempty(var_32_1) then
		var_32_1 = var_32_0.characterViewOffset
	end

	local var_32_2 = SkinConfig.instance:getSkinOffset(var_32_1)

	recthelper.setAnchor(arg_32_0._gospineTran, tonumber(var_32_2[1]), tonumber(var_32_2[2]))
	transformhelper.setLocalScale(arg_32_0._gospineTran, tonumber(var_32_2[3]), tonumber(var_32_2[3]), tonumber(var_32_2[3]))
end

function var_0_0._focus(arg_33_0, arg_33_1)
	local var_33_0 = recthelper.getWidth(arg_33_0._viewportTrans)
	local var_33_1 = recthelper.getWidth(arg_33_0._contentTrans)
	local var_33_2 = math.max(0, var_33_1 - var_33_0)

	if var_33_2 <= 0 then
		return false
	end

	local var_33_3 = arg_33_0._itemTabList[arg_33_1]

	if not var_33_3 then
		return false
	end

	local var_33_4 = arg_33_0._contentTrans.rect
	local var_33_5 = arg_33_0._contentTrans.pivot
	local var_33_6 = var_33_3:rect()
	local var_33_7 = var_33_3:pivot()
	local var_33_8 = var_33_3:posX() - var_33_6.width * var_33_7.x + var_33_4.width * var_33_5.x

	arg_33_0._scrollTaskTabList.horizontalNormalizedPosition = GameUtil.saturate(var_33_8 / var_33_2)

	return true
end

function var_0_0._focusAndClickTabByIndex(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._itemTabList[arg_34_1]

	if not var_34_0 then
		return
	end

	arg_34_0:_onClickTab(var_34_0)
	arg_34_0:_focusByIndex(arg_34_1)
end

function var_0_0._focusByIndex(arg_35_0, arg_35_1)
	local var_35_0 = false

	FrameTimerController.onDestroyViewMember(arg_35_0, "_fTimer")

	arg_35_0._fTimer = FrameTimerController.instance:register(function()
		if var_35_0 then
			return
		end

		var_35_0 = arg_35_0:_focus(arg_35_1)
	end, arg_35_0, 5, 3)

	arg_35_0._fTimer:Start()
end

function var_0_0._editableInitView(arg_37_0)
	arg_37_0._goitem = gohelper.findChild(arg_37_0.viewGO, "Right/RawardPanel/go_Content/go_item")
	arg_37_0._1Slot = gohelper.findChild(arg_37_0.viewGO, "Right/RawardPanel/go_Content/1Slots")
	arg_37_0._2Slot = gohelper.findChild(arg_37_0.viewGO, "Right/RawardPanel/go_Content/2Slots")
	arg_37_0._3Slot = gohelper.findChild(arg_37_0.viewGO, "Right/RawardPanel/go_Content/3Slots")
	arg_37_0._1SlotTrans = arg_37_0._1Slot.transform
	arg_37_0._2SlotTrans = arg_37_0._2Slot.transform
	arg_37_0._3SlotTrans = arg_37_0._3Slot.transform

	gohelper.setActive(arg_37_0._goitem, false)
	gohelper.setActive(arg_37_0._goradiotaskitem, false)
	gohelper.setActive(arg_37_0._btnClaimGo, false)
	gohelper.setActive(arg_37_0._btnClaimedGo, false)
	gohelper.setActive(arg_37_0._btnUnopenGo, false)
	gohelper.setActive(arg_37_0._goClaim, false)

	arg_37_0._btnClaimGo = arg_37_0._btnClaim.gameObject
	arg_37_0._btnClaimedGo = arg_37_0._btnClaimed.gameObject
	arg_37_0._btnUnopenGo = arg_37_0._btnUnopen.gameObject
	arg_37_0._gospineTran = arg_37_0._gospine.transform
	arg_37_0._simageRoleGo = arg_37_0._simageRole.gameObject

	local var_37_0 = arg_37_0._scrollTaskTabList.gameObject

	arg_37_0._scrollRect = var_37_0:GetComponent(gohelper.Type_ScrollRect)
	arg_37_0._viewportTrans = gohelper.findChild(var_37_0, "Viewport").transform
	arg_37_0._contentTrans = arg_37_0._scrollRect.content
	arg_37_0._animator = arg_37_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_37_0:_editableInitView_loadSpine()
end

function var_0_0._editableInitView_loadSpine(arg_38_0)
	local var_38_0 = arg_38_0.viewContainer:getSkinCo()

	arg_38_0._bigSpine = GuiModelAgent.Create(arg_38_0._gospine, true)

	arg_38_0._bigSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_38_0.viewName)
	arg_38_0._bigSpine:setResPath(var_38_0, arg_38_0._onBigSpineLoaded, arg_38_0)
end

return var_0_0
