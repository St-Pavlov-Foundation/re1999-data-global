module("modules.logic.battlepass.view.BpBonusView", package.seeall)

slot0 = class("BpBonusView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollRectWrap = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll")
	slot0._goKeyBonus = gohelper.findChild(slot0.viewGO, "root/#keyBonus")
	slot0._simagepaymask = gohelper.findChildSingleImage(slot0.viewGO, "root/left/pay/#gomask")
	slot0._simagescrollbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#scroll/#simage_scrollbg")
	slot0._maskClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/pay/#btn_pay", AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._txtLeftTime = gohelper.findChildText(slot0.viewGO, "root/#txtLeftTime")
	slot0._payAnim = gohelper.findChildComponent(slot0.viewGO, "root/left/pay", typeof(UnityEngine.Animator))
	slot0._lineTr = gohelper.findChildComponent(slot0.viewGO, "root/#scroll/viewport/content/line", typeof(UnityEngine.Transform))
	slot0._gomask = slot0._simagepaymask.gameObject

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._maskClick:AddClickListener(slot0._onClickbtnPay, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.ShowUnlockBonusAnim, slot0._playUnLockItemAnim, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._refreshView, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetBonus, slot0._refreshView, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._refreshView, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._onUpdatePayStatus, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._onBuyLevel, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnTaskUpdate, slot0._onTaskUpdate, slot0)
	slot0:addEventCb(slot0.viewContainer, BpEvent.TapViewOpenAnimBegin, slot0._updatePayAnim, slot0)
	slot0._scrollRectWrap:AddOnValueChanged(slot0._onScrollRectValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._maskClick:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.ShowUnlockBonusAnim, slot0._playUnLockItemAnim, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._refreshView, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnGetBonus, slot0._refreshView, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdateScore, slot0._refreshView, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0._onUpdatePayStatus, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnBuyLevel, slot0._onBuyLevel, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnTaskUpdate, slot0._onTaskUpdate, slot0)
	slot0:removeEventCb(slot0.viewContainer, BpEvent.TapViewOpenAnimBegin, slot0._updatePayAnim, slot0)
	slot0._scrollRectWrap:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simagescrollbg:LoadImage(ResUrl.getBattlePassBg("img_reward_bg_bot"))

	slot0._scrollWidth = recthelper.getWidth(slot0._scrollRectWrap.transform)
	slot0._keyBonusItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goKeyBonus, BpBonusKeyItem)
	slot0._cellWidth = 161
	slot0._cellSpaceH = 0
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/#scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "root/#scroll/item"
	slot1.cellClass = BpBonusItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = slot0._cellWidth
	slot1.cellHeight = 596
	slot1.cellSpaceH = slot0._cellSpaceH
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(BpBonusModel.instance, slot1)

	slot0:addChildView(slot0._scrollView)
end

function slot0.onOpen(slot0)
	slot0:_onUpdatePayStatus()
	slot0:_udpateScroll()
	slot0:_updateBtn()
	slot0:_updateLeftTime()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, slot0._onClickbtnGetAll, slot0)
	TaskDispatcher.runDelay(slot0.scrollToLevel, slot0, 0)

	if BpModel.instance.preStatus then
		TaskDispatcher.runDelay(slot0._playUnLockItemAnim, slot0, 0.5)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagescrollbg:UnLoadImage()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.scrollToLevel, slot0)

	if slot0._scrollTime then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(slot0.checkScrollEnd, slot0)

		slot0._scrollTime = nil
	end

	if slot0._dotweenId then
		ZProj.TweenHelper.KillById(slot0._dotweenId)

		slot0._dotweenId = nil

		BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
	end

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	TaskDispatcher.cancelTask(slot0.animFinish, slot0)
	TaskDispatcher.cancelTask(slot0._playUnLockItemAnim, slot0)
	BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
end

function slot0._updateLeftTime(slot0)
	if BpModel.instance.endTime - ServerTime.now() > 0 then
		slot3 = math.floor(slot1 % 86400 / 3600)

		if math.floor(slot1 / 86400) > 0 or slot3 > 0 then
			slot0._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("bp_dateLeft"), {
				slot2,
				slot3
			})
		else
			slot0._txtLeftTime.text = luaLang("bp_dateLeft_1h")
		end
	else
		slot0._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function slot0._onClickbtnGetAll(slot0)
	BpRpc.instance:sendGetBpBonusRequest(0)
end

function slot0._onClickbtnPay(slot0)
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(ViewName.BpChargeView)
end

function slot0._refreshView(slot0)
	if not slot0._has_onOpen then
		return
	end

	slot0:_udpateScroll()
	slot0:_updateBtn()
end

function slot0._onBuyLevel(slot0)
	slot0:_refreshView()
	slot0:scrollToLevel()
end

function slot0._onTaskUpdate(slot0)
	slot0:_udpateScroll()
end

function slot0._playUnLockItemAnim(slot0)
	TaskDispatcher.cancelTask(slot0._playUnLockItemAnim, slot0)

	if not BpModel.instance.preStatus then
		return
	end

	if not slot0._has_onOpen then
		return
	end

	if slot0._dotweenId then
		ZProj.TweenHelper.KillById(slot0._dotweenId, false)

		slot0._dotweenId = nil
	end

	TaskDispatcher.cancelTask(slot0.animFinish, slot0)

	slot1 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	slot2 = math.floor(BpModel.instance.preStatus.score / slot1)
	slot4 = slot2
	slot5 = math.floor(BpModel.instance.score / slot1) - slot2

	if BpModel.instance.preStatus.payStatus == BpEnum.PayStatus.NotPay and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
		slot5 = slot3 - 1
	end

	BpModel.instance.animData = {
		toScrollX = 0,
		preScrollX = 0,
		fromLv = slot2,
		toLv = slot3,
		fromPayLv = slot4
	}

	if BpEnum.BonusTweenMin < slot5 then
		slot6 = (slot4 - 4) * (slot0._cellWidth + slot0._cellSpaceH)
		BpModel.instance.animData.preScrollX = slot6
		BpModel.instance.animData.toScrollX = math.min(#BpConfig.instance:getBonusCOList(BpModel.instance.id) * (slot0._cellWidth + slot0._cellSpaceH) - slot0._scrollWidth, slot6 + slot5 * (slot0._cellWidth + slot0._cellSpaceH))
		slot0._dotweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, BpEnum.BonusTweenTime, slot0.everyFrame, slot0.animFinish, slot0, nil, EaseType.OutQuart)
	else
		BpModel.instance.animProcess = 0

		for slot9 in pairs(slot0._scrollView._cellCompDict) do
			slot9:playUnLockAnim(slot2 < slot9._index and slot10 <= slot3, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and slot4 < slot10 and slot10 <= slot3)
		end

		TaskDispatcher.runDelay(slot0.animFinish, slot0, BpEnum.BonusTweenTime)
	end
end

function slot0.everyFrame(slot0, slot1)
	slot2 = BpModel.instance.animData
	BpModel.instance.animProcess = slot1
	slot3 = slot0._scrollView:getCsListScroll()
	slot3.HorizontalScrollPixel = Mathf.Lerp(slot2.preScrollX, slot2.toScrollX, slot1)

	slot3:UpdateCells(false)
end

function slot0.animFinish(slot0)
	TaskDispatcher.cancelTask(slot0.animFinish, slot0)

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	for slot4 in pairs(slot0._scrollView._cellCompDict) do
		slot4:endUnLockAnim()
	end

	BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
end

function slot0._onUpdatePayStatus(slot0)
	slot0:_refreshView()
	slot0:_updatePayAnim(1)
end

function slot0._updatePayAnim(slot0, slot1)
	if slot1 == 1 then
		if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
			slot0._payAnim:Play(UIAnimationName.Idle)
		else
			slot0._payAnim:Play(UIAnimationName.Loop)
		end
	end
end

function slot0._udpateScroll(slot0)
	BpBonusModel.instance:refreshListView()

	if slot0._keyBonusItem and slot0._keyBonusItem.mo then
		slot0._keyBonusItem:onUpdateMO(slot0._keyBonusItem.mo)
	end
end

function slot0.scrollToLevel(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.scrollToLevel, slot0)

	slot2 = nil
	slot5 = slot0._scrollView:getCsListScroll()
	slot6 = (slot0._cellWidth + slot0._cellSpaceH) * (math.max((slot1 or math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))) - 3, 1) - 1)

	recthelper.setWidth(slot0._lineTr, #BpConfig.instance:getBonusCOList(BpModel.instance.id) * (slot0._cellWidth + slot0._cellSpaceH))
	slot0._lineTr:SetAsLastSibling()

	slot5.HorizontalScrollPixel = slot6

	slot5:UpdateCells(false)
	slot0:initKeyBonusKey(slot6)
end

function slot0._onScrollRectValueChanged(slot0, slot1, slot2)
	slot3 = slot0._scrollView:getCsListScroll()

	slot0:initKeyBonusKey(slot3.HorizontalScrollPixel)

	if not slot0.nowFirstCellIndex then
		slot0.nowFirstCellIndex = slot3.FirstVisualCellIndex
	elseif slot5 ~= slot0.nowFirstCellIndex then
		slot0.nowFirstCellIndex = slot5

		if not slot0._scrollTime then
			slot0._scrollTime = 0
			slot0._scrollX = slot1

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_slide)
			TaskDispatcher.runRepeat(slot0.checkScrollEnd, slot0, 0)
		end
	end

	if slot0._scrollTime and math.abs(slot0._scrollX - slot1) > 0.05 then
		slot0._scrollTime = 0
		slot0._scrollX = slot1
	end
end

function slot0.checkScrollEnd(slot0)
	slot0._scrollTime = slot0._scrollTime + UnityEngine.Time.deltaTime

	if slot0._scrollTime > 0.05 then
		slot0._scrollTime = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(slot0.checkScrollEnd, slot0)
	end
end

function slot0.initKeyBonusKey(slot0, slot1)
	if not slot0._keyBonusLvs then
		slot0._keyBonusLvs = {}

		for slot6, slot7 in ipairs(BpConfig.instance:getBonusCOList(BpModel.instance.id)) do
			if slot7.keyBonus == 1 then
				table.insert(slot0._keyBonusLvs, slot7.level)
			end
		end
	end

	slot2 = slot0._keyBonusLvs[#slot0._keyBonusLvs]

	for slot6, slot7 in ipairs(slot0._keyBonusLvs) do
		if slot1 < (slot0._cellWidth + slot0._cellSpaceH) * slot7 - slot0._cellSpaceH - slot0._scrollWidth then
			slot2 = slot7

			break
		end
	end

	if not BpBonusModel.instance:getById(slot2) then
		return
	end

	slot0._keyBonusItem:onUpdateMO(slot3)
end

function slot0._updateBtn(slot0)
	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, slot0:_canGetAnyBonus())
	gohelper.setActive(slot0._gomask, BpModel.instance.payStatus == BpEnum.PayStatus.NotPay)
end

function slot0._canGetAnyBonus(slot0)
	for slot7, slot8 in ipairs(BpBonusModel.instance:getList()) do
		if slot8.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) then
			slot9 = BpConfig.instance:getBonusCO(BpModel.instance.id, slot8.level)
			slot11 = string.split(slot9.payBonus, "|")

			if not slot8.hasGetfreeBonus then
				slot3 = 0 + #string.split(slot9.freeBonus, "|")
			end

			if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and not slot8.hasGetPayBonus then
				slot3 = slot3 + #slot11
			end

			if slot3 >= 1 then
				return true
			end
		end
	end

	return slot3 >= 1
end

return slot0
