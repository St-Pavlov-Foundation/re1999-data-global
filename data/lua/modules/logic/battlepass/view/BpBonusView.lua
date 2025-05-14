module("modules.logic.battlepass.view.BpBonusView", package.seeall)

local var_0_0 = class("BpBonusView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollRectWrap = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll")
	arg_1_0._goKeyBonus = gohelper.findChild(arg_1_0.viewGO, "root/#keyBonus")
	arg_1_0._simagepaymask = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/pay/#gomask")
	arg_1_0._simagescrollbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#scroll/#simage_scrollbg")
	arg_1_0._maskClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/pay/#btn_pay", AudioEnum.UI.UI_vertical_first_tabs_click)
	arg_1_0._txtLeftTime = gohelper.findChildText(arg_1_0.viewGO, "root/#txtLeftTime")
	arg_1_0._payAnim = gohelper.findChildComponent(arg_1_0.viewGO, "root/left/pay", typeof(UnityEngine.Animator))
	arg_1_0._lineTr = gohelper.findChildComponent(arg_1_0.viewGO, "root/#scroll/viewport/content/line", typeof(UnityEngine.Transform))
	arg_1_0._gomask = arg_1_0._simagepaymask.gameObject

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._maskClick:AddClickListener(arg_2_0._onClickbtnPay, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.ShowUnlockBonusAnim, arg_2_0._playUnLockItemAnim, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnGetBonus, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_2_0._refreshView, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_2_0._onUpdatePayStatus, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_2_0._onBuyLevel, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_2_0._onTaskUpdate, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, BpEvent.TapViewOpenAnimBegin, arg_2_0._updatePayAnim, arg_2_0)
	arg_2_0._scrollRectWrap:AddOnValueChanged(arg_2_0._onScrollRectValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._maskClick:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.ShowUnlockBonusAnim, arg_3_0._playUnLockItemAnim, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnGetBonus, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, arg_3_0._refreshView, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0._onUpdatePayStatus, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, arg_3_0._onBuyLevel, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_3_0._onTaskUpdate, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, BpEvent.TapViewOpenAnimBegin, arg_3_0._updatePayAnim, arg_3_0)
	arg_3_0._scrollRectWrap:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagescrollbg:LoadImage(ResUrl.getBattlePassBg("img_reward_bg_bot"))

	arg_4_0._scrollWidth = recthelper.getWidth(arg_4_0._scrollRectWrap.transform)
	arg_4_0._keyBonusItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goKeyBonus, BpBonusKeyItem)
	arg_4_0._cellWidth = 161
	arg_4_0._cellSpaceH = 0

	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "root/#scroll"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_0.prefabUrl = "root/#scroll/item"
	var_4_0.cellClass = BpBonusItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirH
	var_4_0.lineCount = 1
	var_4_0.cellWidth = arg_4_0._cellWidth
	var_4_0.cellHeight = 596
	var_4_0.cellSpaceH = arg_4_0._cellSpaceH
	var_4_0.cellSpaceV = 0
	var_4_0.startSpace = 0
	var_4_0.frameUpdateMs = 100
	arg_4_0._scrollView = LuaListScrollView.New(BpBonusModel.instance, var_4_0)

	arg_4_0:addChildView(arg_4_0._scrollView)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_onUpdatePayStatus()
	arg_5_0:_udpateScroll()
	arg_5_0:_updateBtn()
	arg_5_0:_updateLeftTime()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, arg_5_0._onClickbtnGetAll, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.scrollToLevel, arg_5_0, 0)

	if BpModel.instance.preStatus then
		TaskDispatcher.runDelay(arg_5_0._playUnLockItemAnim, arg_5_0, 0.5)
	end
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._simagescrollbg:UnLoadImage()
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.scrollToLevel, arg_7_0)

	if arg_7_0._scrollTime then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(arg_7_0.checkScrollEnd, arg_7_0)

		arg_7_0._scrollTime = nil
	end

	if arg_7_0._dotweenId then
		ZProj.TweenHelper.KillById(arg_7_0._dotweenId)

		arg_7_0._dotweenId = nil

		BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
	end

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	TaskDispatcher.cancelTask(arg_7_0.animFinish, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._playUnLockItemAnim, arg_7_0)
	BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
end

function var_0_0._updateLeftTime(arg_8_0)
	local var_8_0 = BpModel.instance.endTime - ServerTime.now()

	if var_8_0 > 0 then
		local var_8_1 = math.floor(var_8_0 / 86400)
		local var_8_2 = math.floor(var_8_0 % 86400 / 3600)

		if var_8_1 > 0 or var_8_2 > 0 then
			local var_8_3 = {
				var_8_1,
				var_8_2
			}

			arg_8_0._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("bp_dateLeft"), var_8_3)
		else
			arg_8_0._txtLeftTime.text = luaLang("bp_dateLeft_1h")
		end
	else
		arg_8_0._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function var_0_0._onClickbtnGetAll(arg_9_0)
	BpRpc.instance:sendGetBpBonusRequest(0)
end

function var_0_0._onClickbtnPay(arg_10_0)
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(ViewName.BpChargeView)
end

function var_0_0._refreshView(arg_11_0)
	if not arg_11_0._has_onOpen then
		return
	end

	arg_11_0:_udpateScroll()
	arg_11_0:_updateBtn()
end

function var_0_0._onBuyLevel(arg_12_0)
	arg_12_0:_refreshView()
	arg_12_0:scrollToLevel()
end

function var_0_0._onTaskUpdate(arg_13_0)
	arg_13_0:_udpateScroll()
end

function var_0_0._playUnLockItemAnim(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._playUnLockItemAnim, arg_14_0)

	if not BpModel.instance.preStatus then
		return
	end

	if not arg_14_0._has_onOpen then
		return
	end

	if arg_14_0._dotweenId then
		ZProj.TweenHelper.KillById(arg_14_0._dotweenId, false)

		arg_14_0._dotweenId = nil
	end

	TaskDispatcher.cancelTask(arg_14_0.animFinish, arg_14_0)

	local var_14_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_14_1 = math.floor(BpModel.instance.preStatus.score / var_14_0)
	local var_14_2 = math.floor(BpModel.instance.score / var_14_0)
	local var_14_3 = var_14_1
	local var_14_4 = var_14_2 - var_14_1

	if BpModel.instance.preStatus.payStatus == BpEnum.PayStatus.NotPay and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
		var_14_3 = 1
		var_14_4 = var_14_2 - var_14_3
	end

	BpModel.instance.animData = {
		toScrollX = 0,
		preScrollX = 0,
		fromLv = var_14_1,
		toLv = var_14_2,
		fromPayLv = var_14_3
	}

	if var_14_4 > BpEnum.BonusTweenMin then
		local var_14_5 = (var_14_3 - 4) * (arg_14_0._cellWidth + arg_14_0._cellSpaceH)
		local var_14_6 = var_14_5 + var_14_4 * (arg_14_0._cellWidth + arg_14_0._cellSpaceH)
		local var_14_7 = #BpConfig.instance:getBonusCOList(BpModel.instance.id) * (arg_14_0._cellWidth + arg_14_0._cellSpaceH) - arg_14_0._scrollWidth

		BpModel.instance.animData.preScrollX = var_14_5
		BpModel.instance.animData.toScrollX = math.min(var_14_7, var_14_6)
		arg_14_0._dotweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, BpEnum.BonusTweenTime, arg_14_0.everyFrame, arg_14_0.animFinish, arg_14_0, nil, EaseType.OutQuart)
	else
		BpModel.instance.animProcess = 0

		for iter_14_0 in pairs(arg_14_0._scrollView._cellCompDict) do
			local var_14_8 = iter_14_0._index

			iter_14_0:playUnLockAnim(var_14_1 < var_14_8 and var_14_8 <= var_14_2, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and var_14_3 < var_14_8 and var_14_8 <= var_14_2)
		end

		TaskDispatcher.runDelay(arg_14_0.animFinish, arg_14_0, BpEnum.BonusTweenTime)
	end
end

function var_0_0.everyFrame(arg_15_0, arg_15_1)
	local var_15_0 = BpModel.instance.animData

	BpModel.instance.animProcess = arg_15_1

	local var_15_1 = arg_15_0._scrollView:getCsListScroll()

	var_15_1.HorizontalScrollPixel = Mathf.Lerp(var_15_0.preScrollX, var_15_0.toScrollX, arg_15_1)

	var_15_1:UpdateCells(false)
end

function var_0_0.animFinish(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.animFinish, arg_16_0)

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	for iter_16_0 in pairs(arg_16_0._scrollView._cellCompDict) do
		iter_16_0:endUnLockAnim()
	end

	BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
end

function var_0_0._onUpdatePayStatus(arg_17_0)
	arg_17_0:_refreshView()
	arg_17_0:_updatePayAnim(1)
end

function var_0_0._updatePayAnim(arg_18_0, arg_18_1)
	if arg_18_1 == 1 then
		if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
			arg_18_0._payAnim:Play(UIAnimationName.Idle)
		else
			arg_18_0._payAnim:Play(UIAnimationName.Loop)
		end
	end
end

function var_0_0._udpateScroll(arg_19_0)
	BpBonusModel.instance:refreshListView()

	if arg_19_0._keyBonusItem and arg_19_0._keyBonusItem.mo then
		arg_19_0._keyBonusItem:onUpdateMO(arg_19_0._keyBonusItem.mo)
	end
end

function var_0_0.scrollToLevel(arg_20_0, arg_20_1)
	TaskDispatcher.cancelTask(arg_20_0.scrollToLevel, arg_20_0)

	local var_20_0
	local var_20_1 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_20_2 = math.floor(BpModel.instance.score / var_20_1)
	local var_20_3 = (arg_20_1 or var_20_2) - 3
	local var_20_4 = math.max(var_20_3, 1)
	local var_20_5 = arg_20_0._scrollView:getCsListScroll()
	local var_20_6 = (arg_20_0._cellWidth + arg_20_0._cellSpaceH) * (var_20_4 - 1)
	local var_20_7 = #BpConfig.instance:getBonusCOList(BpModel.instance.id) * (arg_20_0._cellWidth + arg_20_0._cellSpaceH)

	recthelper.setWidth(arg_20_0._lineTr, var_20_7)
	arg_20_0._lineTr:SetAsLastSibling()

	var_20_5.HorizontalScrollPixel = var_20_6

	var_20_5:UpdateCells(false)
	arg_20_0:initKeyBonusKey(var_20_6)
end

function var_0_0._onScrollRectValueChanged(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._scrollView:getCsListScroll()
	local var_21_1 = var_21_0.HorizontalScrollPixel

	arg_21_0:initKeyBonusKey(var_21_1)

	local var_21_2 = var_21_0.FirstVisualCellIndex

	if not arg_21_0.nowFirstCellIndex then
		arg_21_0.nowFirstCellIndex = var_21_2
	elseif var_21_2 ~= arg_21_0.nowFirstCellIndex then
		arg_21_0.nowFirstCellIndex = var_21_2

		if not arg_21_0._scrollTime then
			arg_21_0._scrollTime = 0
			arg_21_0._scrollX = arg_21_1

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_slide)
			TaskDispatcher.runRepeat(arg_21_0.checkScrollEnd, arg_21_0, 0)
		end
	end

	if arg_21_0._scrollTime and math.abs(arg_21_0._scrollX - arg_21_1) > 0.05 then
		arg_21_0._scrollTime = 0
		arg_21_0._scrollX = arg_21_1
	end
end

function var_0_0.checkScrollEnd(arg_22_0)
	arg_22_0._scrollTime = arg_22_0._scrollTime + UnityEngine.Time.deltaTime

	if arg_22_0._scrollTime > 0.05 then
		arg_22_0._scrollTime = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(arg_22_0.checkScrollEnd, arg_22_0)
	end
end

function var_0_0.initKeyBonusKey(arg_23_0, arg_23_1)
	if not arg_23_0._keyBonusLvs then
		arg_23_0._keyBonusLvs = {}

		local var_23_0 = BpConfig.instance:getBonusCOList(BpModel.instance.id)

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			if iter_23_1.keyBonus == 1 then
				table.insert(arg_23_0._keyBonusLvs, iter_23_1.level)
			end
		end
	end

	local var_23_1 = arg_23_0._keyBonusLvs[#arg_23_0._keyBonusLvs]

	for iter_23_2, iter_23_3 in ipairs(arg_23_0._keyBonusLvs) do
		if arg_23_1 < (arg_23_0._cellWidth + arg_23_0._cellSpaceH) * iter_23_3 - arg_23_0._cellSpaceH - arg_23_0._scrollWidth then
			var_23_1 = iter_23_3

			break
		end
	end

	local var_23_2 = BpBonusModel.instance:getById(var_23_1)

	if not var_23_2 then
		return
	end

	arg_23_0._keyBonusItem:onUpdateMO(var_23_2)
end

function var_0_0._updateBtn(arg_24_0)
	local var_24_0 = arg_24_0:_canGetAnyBonus()

	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, var_24_0)
	gohelper.setActive(arg_24_0._gomask, BpModel.instance.payStatus == BpEnum.PayStatus.NotPay)
end

function var_0_0._canGetAnyBonus(arg_25_0)
	local var_25_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_25_1 = math.floor(BpModel.instance.score / var_25_0)
	local var_25_2 = 0

	for iter_25_0, iter_25_1 in ipairs(BpBonusModel.instance:getList()) do
		if var_25_1 >= iter_25_1.level then
			local var_25_3 = BpConfig.instance:getBonusCO(BpModel.instance.id, iter_25_1.level)
			local var_25_4 = string.split(var_25_3.freeBonus, "|")
			local var_25_5 = string.split(var_25_3.payBonus, "|")

			if not iter_25_1.hasGetfreeBonus then
				var_25_2 = var_25_2 + #var_25_4
			end

			if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and not iter_25_1.hasGetPayBonus then
				var_25_2 = var_25_2 + #var_25_5
			end

			if var_25_2 >= 1 then
				return true
			end
		end
	end

	return var_25_2 >= 1
end

return var_0_0
