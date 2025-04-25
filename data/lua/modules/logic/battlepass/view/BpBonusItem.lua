module("modules.logic.battlepass.view.BpBonusItem", package.seeall)

slot0 = class("BpBonusItem", ListScrollCell)

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
	slot0._payHasGet2 = gohelper.findChild(slot0.go, "payStatus/#goHasGet/get2")
	slot0._goCanGetLv = gohelper.findChild(slot0.go, "#go_canGetLv")
	slot0._animGo1 = gohelper.findChild(slot0.go, "free/freenode/#goCanGet/bg/#vx_effect")
	slot0._animGo2 = gohelper.findChild(slot0.go, "pay/paynode/#goCanGet/image/#vx_effect")
	slot0._btnGetFree = gohelper.findChildButtonWithAudio(slot0.go, "#btn_getfree")
	slot0._btnGetPay = gohelper.findChildButtonWithAudio(slot0.go, "#btn_getpay")
	slot0._freeBonusList = {}
	slot0._payBonusList = {}
	slot0._payGetEffect = slot0:getUserDataTb_()

	slot0:showAnim()
end

function slot0.addEventListeners(slot0)
	slot0._btnGetFree:AddClickListener(slot0._onFreeItemIconClick, slot0)
	slot0._btnGetPay:AddClickListener(slot0._onPayItemIconClick, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnViewOpenFinish, slot0.showAnim, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnGetFree:RemoveClickListener()
	slot0._btnGetPay:RemoveClickListener()
	slot0:removeEventCb(BpController.instance, BpEvent.OnViewOpenFinish, slot0.showAnim, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot0.mo or slot1.id ~= slot0.mo.id then
		slot0:checkPlayAnim()
	elseif slot1.hasGetfreeBonus or slot1.hasGetPayBonus then
		if slot1.hasGetfreeBonus then
			slot0.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(slot0.freeUnLockGo, false)
		end

		if slot1.hasGetPayBonus then
			slot0.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(slot0.payUnLockGo, false)
		end
	end

	slot0.mo = slot1
	slot0._txtLevel.text = luaLang("level") .. slot1.level
	slot4 = slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))
	slot5 = slot0.mo.level <= slot3 and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	slot8 = BpConfig.instance:getBonusCO(BpModel.instance.id, slot0.mo.level)

	slot0:_setBonus(GameUtil.splitString2(slot8.freeBonus, true), slot0._freeBonusList, slot0._freeItemGO, slot0._onFreeItemIconClick, slot4, slot0.mo.hasGetfreeBonus)
	slot0:_setBonus(GameUtil.splitString2(slot8.payBonus, true), slot0._payBonusList, slot0._payItemGO, slot0._onPayItemIconClick, slot5, slot0.mo.hasGetPayBonus)
	gohelper.setActive(slot0._freeLockMask, false)
	gohelper.setActive(slot0._freeHasGet, slot4 and slot6)
	gohelper.setActive(slot0._payLockMask, false)
	gohelper.setActive(slot0._payHasGet, slot5 and slot7)
	gohelper.setActive(slot0.freelock, not slot4)
	gohelper.setActive(slot0.paylock, not slot5)
	gohelper.setActive(slot0.paylock2, not slot5 and #slot10 == 2)
	gohelper.setActive(slot0._payHasGet2, #slot10 == 2)
	gohelper.setActive(slot0.payUnLockGo2, #slot10 == 2)
	gohelper.setActive(slot0._freeCanGet, slot4 and not slot6)
	gohelper.setActive(slot0._payCanGet, slot5 and not slot7)
	gohelper.setActive(slot0._btnGetFree, slot4 and not slot6)
	gohelper.setActive(slot0._btnGetPay, slot5 and not slot7)

	for slot14 = 1, #slot0._payBonusList do
		if not slot0._payGetEffect[slot14] then
			slot0._payGetEffect[slot14] = gohelper.findChild(slot0._payBonusList[slot14].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for slot14 = 1, #slot0._payGetEffect do
		gohelper.setActive(slot0._payGetEffect[slot14], slot5 and not slot7)
	end

	slot11 = slot4 and not slot6 or slot5 and not slot7

	gohelper.setActive(slot0._goCanGetLv, slot11)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLevel, slot11 and "#FD7536" or "#DFBC7A")
end

function slot0.showAnim(slot0)
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(slot0._animGo1, true)
	gohelper.setActive(slot0._animGo2, true)
end

function slot0._setBonus(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	for slot10, slot11 in ipairs(slot1) do
		if not slot2[slot10] then
			slot13 = gohelper.cloneInPlace(slot3)

			gohelper.setActive(slot13, true)
			table.insert(slot2, IconMgr.instance:getCommonPropItemIcon(slot13))
		end

		slot12:setMOValue(slot11[1], slot11[2], slot11[3], nil, true)

		if slot11[1] == MaterialEnum.MaterialType.Equip then
			slot12._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, slot12._equipIcon)
			slot12._equipIcon:_loadIconImage()
		end

		if slot5 and not slot6 then
			slot12:customOnClickCallback(slot4, slot0)
		else
			slot12:customOnClickCallback(nil, )
		end

		slot12:setCountFontSize(46)
		slot12:setScale(0.6)

		slot13, slot14, slot15 = BpConfig.instance:getItemShowSize(slot11[1], slot11[2])

		slot12:setItemIconScale(slot13)
		slot12:setItemOffset(slot14, slot15)
		slot12:SetCountLocalY(43.6)
		slot12:SetCountBgHeight(40)
		slot12:SetCountBgScale(1, 1.3, 1)
		slot12:showStackableNum()
		slot12:setHideLvAndBreakFlag(true)
		slot12:hideEquipLvAndBreak(true)
		slot12:isShowCount(slot11[1] ~= MaterialEnum.MaterialType.HeroSkin)

		if slot6 then
			slot12:setAlpha(0.45, 0.8)
		else
			slot12:setAlpha(1, 1)
		end

		gohelper.setActive(slot12.go.transform.parent.gameObject, true)
		gohelper.setActive(gohelper.findChild(slot12.go.transform.parent.gameObject, "#goHasGet"), slot5 and slot6)
	end

	for slot10 = #slot1 + 1, #slot2 do
		gohelper.setActive(slot2[slot10].go.transform.parent.gameObject, false)
	end
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
	if slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) and not slot0.mo.hasGetfreeBonus then
		BpRpc.instance:sendGetBpBonusRequest(slot0.mo.level, false)
	end
end

function slot0._onPayItemIconClick(slot0)
	if slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id)) and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and not slot0.mo.hasGetPayBonus then
		BpRpc.instance:sendGetBpBonusRequest(slot0.mo.level, true)
	end
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
end

return slot0
