module("modules.logic.battlepass.view.BpSPBonusItem", package.seeall)

slot0 = class("BpSPBonusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtLevel = gohelper.findChildText(slot0.go, "#txtLevel")
	slot0._freeItemGO = gohelper.findChild(slot0.go, "free/freenode/#goItem")
	slot0._freeCanGet = gohelper.findChild(slot0.go, "free/freenode/#goCanGet")
	slot0._payItemGO = gohelper.findChild(slot0.go, "pay/paynode/Item/#goItem")
	slot0._payCanGet = gohelper.findChild(slot0.go, "pay/paynode/#goCanGet")

	gohelper.setActive(slot0._freeItemGO, false)
	gohelper.setActive(slot0._payItemGO, false)

	slot0._freeLockMask = gohelper.findChild(slot0.go, "freeStatus/#goLockMask")
	slot0._freeHasGet = gohelper.findChild(slot0.go, "freeStatus/#goHasGet")
	slot0._payLockMask = gohelper.findChild(slot0.go, "payStatus/#goLockMask")
	slot0._payHasGet = gohelper.findChild(slot0.go, "payStatus/#goHasGet")
	slot0.freelock = gohelper.findChild(slot0.go, "freelock/lock")
	slot0.paylock = gohelper.findChild(slot0.go, "paylock/lock")
	slot0.paylock2 = gohelper.findChild(slot0.go, "paylock/lock2")
	slot0.freeAnim = gohelper.findChildComponent(slot0.go, "free", typeof(UnityEngine.Animator))
	slot0.freeUnLockGo = gohelper.findChild(slot0.go, "freeunlock")
	slot0.payAnim = gohelper.findChildComponent(slot0.go, "pay", typeof(UnityEngine.Animator))
	slot0.payUnLockGo = gohelper.findChild(slot0.go, "payunlock")
	slot0.payUnLockGo1 = gohelper.findChild(slot0.go, "payunlock/unlock1")
	slot0.payUnLockGo2 = gohelper.findChild(slot0.go, "payunlock/unlock2")
	slot0._payHasGet1 = gohelper.findChild(slot0.go, "payStatus/#goHasGet/get1")
	slot0._payHasGet2 = gohelper.findChild(slot0.go, "payStatus/#goHasGet/get2")
	slot0._getcanvasGroup1 = gohelper.onceAddComponent(slot0._payHasGet1, typeof(UnityEngine.CanvasGroup))
	slot0._getcanvasGroup2 = gohelper.onceAddComponent(slot0._payHasGet2, typeof(UnityEngine.CanvasGroup))
	slot0._goCanGetLv = gohelper.findChild(slot0.go, "#go_canGetLv")
	slot0._animGo1 = gohelper.findChild(slot0.go, "free/freenode/#goCanGet/bg/#vx_effect")
	slot0._animGo2 = gohelper.findChild(slot0.go, "pay/paynode/#goCanGet/image/#vx_effect")
	slot0._btnGetFree = gohelper.findChildButtonWithAudio(slot0.go, "#btn_getfree")
	slot0._btnGetPay = gohelper.findChildButtonWithAudio(slot0.go, "#btn_getpay")
	slot0._freeBonusList = {}
	slot0._payBonusList = {}
	slot0._selectBonusList = {}
	slot0._payGetEffect = slot0:getUserDataTb_()
	slot0._selectBonusEffect = slot0:getUserDataTb_()

	slot0:showAnim()
end

function slot0.addEventListeners(slot0)
	slot0._btnGetFree:AddClickListener(slot0._onFreeItemIconClick, slot0)
	slot0._btnGetPay:AddClickListener(slot0._onPayItemIconClick, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnViewOpenFinish, slot0.showAnim, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.onSelectBonusGet, slot0._refreshSelect, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnGetFree:RemoveClickListener()
	slot0._btnGetPay:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.OnViewOpenFinish, slot0.showAnim, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.onSelectBonusGet, slot0._refreshSelect, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot0.mo or slot1.id ~= slot0.mo.id then
		slot0:checkPlayAnim()
	elseif slot1.hasGetSpfreeBonus or slot1.hasGetSpPayBonus then
		if slot1.hasGetSpfreeBonus then
			slot0.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(slot0.freeUnLockGo, false)
		end

		if slot1.hasGetSpPayBonus then
			slot0.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(slot0.payUnLockGo, false)
		end
	end

	slot0.mo = slot1
	slot0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), slot0.mo.level)
	slot4 = slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))
	slot5 = slot0.mo.level <= slot3
	slot6 = slot0.mo.hasGetSpfreeBonus
	slot7 = slot0.mo.hasGetSpPayBonus
	slot8 = BpBonusModel.instance:isGetSelectBonus(slot0.mo.level)
	slot9 = BpConfig.instance:getBonusCO(BpModel.instance.id, slot0.mo.level)
	slot11 = GameUtil.splitString2(slot9.spPayBonus, true)
	slot12 = GameUtil.splitString2(slot9.selfSelectPayItem, true) or {}

	slot0:_setBonus(GameUtil.splitString2(slot9.spFreeBonus, true), slot0._freeBonusList, slot0._freeItemGO, slot0._onFreeItemIconClick, slot4, slot6)
	slot0:_setBonus(slot11, slot0._payBonusList, slot0._payItemGO, slot0._onPayItemIconClick, slot5, slot7)
	slot0:_setBonus(slot12, slot0._selectBonusList, slot0._payItemGO, slot0._onselectItemIconClick, slot5, slot8, true)
	gohelper.setActive(slot0._freeLockMask, false)
	gohelper.setActive(slot0._freeHasGet, slot4 and slot6)
	gohelper.setActive(slot0._payLockMask, false)
	gohelper.setActive(slot0._payHasGet, slot5 and slot7 or slot8)
	gohelper.setActive(slot0._payHasGet2, #slot11 + #slot12 == 2)
	gohelper.setActive(slot0.freelock, not slot4)
	gohelper.setActive(slot0.paylock, not slot5)
	gohelper.setActive(slot0.paylock2, not slot5 and #slot11 + #slot12 == 2)
	gohelper.setActive(slot0.payUnLockGo2, #slot11 + #slot12 == 2)
	gohelper.setActive(slot0._freeCanGet, slot4 and not slot6)
	gohelper.setActive(slot0._payCanGet, slot5 and (not slot7 or not slot8 and not string.nilorempty(slot9.selfSelectPayItem)))
	gohelper.setActive(slot0._btnGetFree, slot4 and not slot6)
	gohelper.setActive(slot0._btnGetPay, slot5 and not slot7)

	if #slot12 > 0 then
		if #slot11 > 0 then
			slot0._getcanvasGroup1.alpha = slot5 and slot7 and 1 or 0
			slot0._getcanvasGroup2.alpha = slot8 and 1 or 0
		else
			slot0._getcanvasGroup1.alpha = slot8 and 1 or 0
		end
	else
		slot0._getcanvasGroup1.alpha = 1
		slot0._getcanvasGroup2.alpha = 1
	end

	for slot16 = 1, #slot0._payBonusList do
		if not slot0._payGetEffect[slot16] then
			slot0._payGetEffect[slot16] = gohelper.findChild(slot0._payBonusList[slot16].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for slot16 = 1, #slot0._selectBonusList do
		if not slot0._selectBonusEffect[slot16] then
			slot0._selectBonusEffect[slot16] = gohelper.findChild(slot0._selectBonusList[slot16].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for slot16 = 1, #slot0._payGetEffect do
		gohelper.setActive(slot0._payGetEffect[slot16], slot5 and not slot7)
	end

	for slot16 = 1, #slot0._selectBonusEffect do
		gohelper.setActive(slot0._selectBonusEffect[slot16], slot8)
	end

	slot13 = slot4 and not slot6 or slot5 and not slot7

	gohelper.setActive(slot0._goCanGetLv, slot13)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLevel, slot13 and "#FD7536" or "#DFBC7A")
end

function slot0.showAnim(slot0)
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(slot0._animGo1, true)
	gohelper.setActive(slot0._animGo2, true)
end

function slot0._setBonus(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	for slot11, slot12 in ipairs(slot1) do
		if not slot2[slot11] then
			slot14 = gohelper.cloneInPlace(slot3)

			gohelper.setActive(slot14, true)
			table.insert(slot2, IconMgr.instance:getCommonPropItemIcon(slot14))
		end

		slot13:setMOValue(slot12[1], slot12[2], slot12[3], nil, true)

		if slot12[1] == MaterialEnum.MaterialType.Equip then
			slot13._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, slot13._equipIcon)
			slot13._equipIcon:_loadIconImage()
		end

		if slot5 and not slot6 or slot7 then
			slot13:customOnClickCallback(slot4, slot0)
		else
			slot13:customOnClickCallback(nil, )
		end

		slot13:setCountFontSize(46)
		slot13:setScale(0.6)

		slot14, slot15, slot16 = BpConfig.instance:getItemShowSize(slot12[1], slot12[2])

		slot13:setItemIconScale(slot14)
		slot13:setItemOffset(slot15, slot16)
		slot13:SetCountLocalY(43.6)
		slot13:SetCountBgHeight(40)
		slot13:SetCountBgScale(1, 1.3, 1)
		slot13:showStackableNum()
		slot13:setHideLvAndBreakFlag(true)
		slot13:hideEquipLvAndBreak(true)
		slot13:isShowCount(true)

		if slot6 then
			slot13:setAlpha(0.45, 0.8)
		else
			slot13:setAlpha(1, 1)
		end

		gohelper.setActive(slot13.go.transform.parent.gameObject, true)
		gohelper.setActive(gohelper.findChild(slot13.go.transform.parent.gameObject, "#goHasGet"), slot5 and slot6)
	end

	for slot11 = #slot1 + 1, #slot2 do
		gohelper.setActive(slot2[slot11].go.transform.parent.gameObject, false)
	end
end

function slot0._refreshSelect(slot0, slot1)
	if slot1 ~= slot0.mo.level then
		return
	end

	slot0:onUpdateMO(slot0.mo)
end

function slot0.checkPlayAnim(slot0)
	if not BpModel.instance.animData then
		slot0:endUnLockAnim()
	else
		slot0:endUnLockAnim()

		slot2 = BpModel.instance.animData.toLv

		slot0:playUnLockAnim(BpModel.instance.animData.fromLv < slot0._index and slot4 <= slot2, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and BpModel.instance.animData.fromPayLv < slot4 and slot4 <= slot2)
	end
end

function slot0.playUnLockAnim(slot0, slot1, slot2)
	if slot1 then
		slot0:playAnim(SLFramework.AnimatorPlayer.Get(slot0.freeAnim.gameObject), UIAnimationName.Open, slot0.endFreeAnim, slot0)
		gohelper.setActive(slot0.freeUnLockGo, true)
		slot0:playAnim(SLFramework.AnimatorPlayer.Get(slot0.freeUnLockGo), UIAnimationName.Open, slot0.endFreeUnLockAnim, slot0)
	end

	if slot2 then
		slot0:playAnim(SLFramework.AnimatorPlayer.Get(slot0.payAnim.gameObject), UIAnimationName.Open, slot0.endPayAnim, slot0)
		gohelper.setActive(slot0.payUnLockGo, true)
		slot0:playAnim(SLFramework.AnimatorPlayer.Get(slot0.payUnLockGo), UIAnimationName.Open, slot0.endPayUnLockAnim, slot0)
	end
end

function slot0.playAnim(slot0, slot1, slot2, slot3, slot4)
	slot1:Stop()

	if not slot1.isActiveAndEnabled then
		slot3(slot4)

		return
	end

	slot1:Play(slot2, slot3, slot4)
end

function slot0.endFreeAnim(slot0)
	slot0.freeAnim:Play(UIAnimationName.Idle)
end

function slot0.endPayAnim(slot0)
	slot0.payAnim:Play(UIAnimationName.Idle)
end

function slot0.endFreeUnLockAnim(slot0)
	gohelper.setActive(slot0.freeUnLockGo, false)
end

function slot0.endPayUnLockAnim(slot0)
	gohelper.setActive(slot0.payUnLockGo, false)
end

function slot0.endUnLockAnim(slot0)
	slot0.freeAnim:Play(UIAnimationName.Idle)
	slot0.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(slot0.freeUnLockGo, false)
	gohelper.setActive(slot0.payUnLockGo, false)
end

function slot0._onFreeItemIconClick(slot0)
	if slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) and not slot0.mo.hasGetSpfreeBonus then
		BpRpc.instance:sendGetBpBonusRequest(slot0.mo.level, false, true)
	end
end

function slot0._onPayItemIconClick(slot0)
	if slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) and not slot0.mo.hasGetSpPayBonus then
		BpRpc.instance:sendGetBpBonusRequest(slot0.mo.level, true, true, slot0._onGetBonus, slot0)
	end
end

function slot0._onGetBonus(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if not string.nilorempty(BpConfig.instance:getBonusCO(BpModel.instance.id, slot0.mo.level).selfSelectPayItem) and not BpBonusModel.instance:isGetSelectBonus(slot0.mo.level) then
			slot0:_onselectItemIconClick()
		end
	end
end

function slot0._onselectItemIconClick(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function slot0.onDestroyView(slot0)
	if slot0._freeBonusList then
		for slot4, slot5 in pairs(slot0._freeBonusList) do
			slot5:onDestroy()
		end

		slot0._freeBonusList = nil
	end

	if slot0._payBonusList then
		for slot4, slot5 in pairs(slot0._payBonusList) do
			slot5:onDestroy()
		end

		slot0._payBonusList = nil
	end

	if slot0._selectBonusList then
		for slot4, slot5 in pairs(slot0._selectBonusList) do
			slot5:onDestroy()
		end

		slot0._selectBonusList = nil
	end
end

return slot0
