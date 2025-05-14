module("modules.logic.battlepass.view.BpSPBonusItem", package.seeall)

local var_0_0 = class("BpSPBonusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.go, "#txtLevel")
	arg_1_0._freeItemGO = gohelper.findChild(arg_1_0.go, "free/freenode/#goItem")
	arg_1_0._freeCanGet = gohelper.findChild(arg_1_0.go, "free/freenode/#goCanGet")
	arg_1_0._payItemGO = gohelper.findChild(arg_1_0.go, "pay/paynode/Item/#goItem")
	arg_1_0._payCanGet = gohelper.findChild(arg_1_0.go, "pay/paynode/#goCanGet")

	gohelper.setActive(arg_1_0._freeItemGO, false)
	gohelper.setActive(arg_1_0._payItemGO, false)

	arg_1_0._freeLockMask = gohelper.findChild(arg_1_0.go, "freeStatus/#goLockMask")
	arg_1_0._freeHasGet = gohelper.findChild(arg_1_0.go, "freeStatus/#goHasGet")
	arg_1_0._payLockMask = gohelper.findChild(arg_1_0.go, "payStatus/#goLockMask")
	arg_1_0._payHasGet = gohelper.findChild(arg_1_0.go, "payStatus/#goHasGet")
	arg_1_0.freelock = gohelper.findChild(arg_1_0.go, "freelock/lock")
	arg_1_0.paylock = gohelper.findChild(arg_1_0.go, "paylock/lock")
	arg_1_0.paylock2 = gohelper.findChild(arg_1_0.go, "paylock/lock2")
	arg_1_0.freeAnim = gohelper.findChildComponent(arg_1_0.go, "free", typeof(UnityEngine.Animator))
	arg_1_0.freeUnLockGo = gohelper.findChild(arg_1_0.go, "freeunlock")
	arg_1_0.payAnim = gohelper.findChildComponent(arg_1_0.go, "pay", typeof(UnityEngine.Animator))
	arg_1_0.payUnLockGo = gohelper.findChild(arg_1_0.go, "payunlock")
	arg_1_0.payUnLockGo1 = gohelper.findChild(arg_1_0.go, "payunlock/unlock1")
	arg_1_0.payUnLockGo2 = gohelper.findChild(arg_1_0.go, "payunlock/unlock2")
	arg_1_0._payHasGet1 = gohelper.findChild(arg_1_0.go, "payStatus/#goHasGet/get1")
	arg_1_0._payHasGet2 = gohelper.findChild(arg_1_0.go, "payStatus/#goHasGet/get2")
	arg_1_0._getcanvasGroup1 = gohelper.onceAddComponent(arg_1_0._payHasGet1, typeof(UnityEngine.CanvasGroup))
	arg_1_0._getcanvasGroup2 = gohelper.onceAddComponent(arg_1_0._payHasGet2, typeof(UnityEngine.CanvasGroup))
	arg_1_0._goCanGetLv = gohelper.findChild(arg_1_0.go, "#go_canGetLv")
	arg_1_0._animGo1 = gohelper.findChild(arg_1_0.go, "free/freenode/#goCanGet/bg/#vx_effect")
	arg_1_0._animGo2 = gohelper.findChild(arg_1_0.go, "pay/paynode/#goCanGet/image/#vx_effect")
	arg_1_0._btnGetFree = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_getfree")
	arg_1_0._btnGetPay = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_getpay")
	arg_1_0._freeBonusList = {}
	arg_1_0._payBonusList = {}
	arg_1_0._selectBonusList = {}
	arg_1_0._payGetEffect = arg_1_0:getUserDataTb_()
	arg_1_0._selectBonusEffect = arg_1_0:getUserDataTb_()

	arg_1_0:showAnim()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnGetFree:AddClickListener(arg_2_0._onFreeItemIconClick, arg_2_0)
	arg_2_0._btnGetPay:AddClickListener(arg_2_0._onPayItemIconClick, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnViewOpenFinish, arg_2_0.showAnim, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.onSelectBonusGet, arg_2_0._refreshSelect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnGetFree:RemoveClickListener()
	arg_3_0._btnGetPay:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnViewOpenFinish, arg_3_0.showAnim, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.onSelectBonusGet, arg_3_0._refreshSelect, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	if not arg_4_0.mo or arg_4_1.id ~= arg_4_0.mo.id then
		arg_4_0:checkPlayAnim()
	elseif arg_4_1.hasGetSpfreeBonus or arg_4_1.hasGetSpPayBonus then
		if arg_4_1.hasGetSpfreeBonus then
			arg_4_0.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(arg_4_0.freeUnLockGo, false)
		end

		if arg_4_1.hasGetSpPayBonus then
			arg_4_0.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(arg_4_0.payUnLockGo, false)
		end
	end

	arg_4_0.mo = arg_4_1
	arg_4_0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), arg_4_0.mo.level)

	local var_4_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_4_1 = math.floor(BpModel.instance.score / var_4_0)
	local var_4_2 = var_4_1 >= arg_4_0.mo.level
	local var_4_3 = var_4_1 >= arg_4_0.mo.level
	local var_4_4 = arg_4_0.mo.hasGetSpfreeBonus
	local var_4_5 = arg_4_0.mo.hasGetSpPayBonus
	local var_4_6 = BpBonusModel.instance:isGetSelectBonus(arg_4_0.mo.level)
	local var_4_7 = BpConfig.instance:getBonusCO(BpModel.instance.id, arg_4_0.mo.level)
	local var_4_8 = GameUtil.splitString2(var_4_7.spFreeBonus, true)
	local var_4_9 = GameUtil.splitString2(var_4_7.spPayBonus, true)
	local var_4_10 = GameUtil.splitString2(var_4_7.selfSelectPayItem, true) or {}

	arg_4_0:_setBonus(var_4_8, arg_4_0._freeBonusList, arg_4_0._freeItemGO, arg_4_0._onFreeItemIconClick, var_4_2, var_4_4)
	arg_4_0:_setBonus(var_4_9, arg_4_0._payBonusList, arg_4_0._payItemGO, arg_4_0._onPayItemIconClick, var_4_3, var_4_5)
	arg_4_0:_setBonus(var_4_10, arg_4_0._selectBonusList, arg_4_0._payItemGO, arg_4_0._onselectItemIconClick, var_4_3, var_4_6, true)
	gohelper.setActive(arg_4_0._freeLockMask, false)
	gohelper.setActive(arg_4_0._freeHasGet, var_4_2 and var_4_4)
	gohelper.setActive(arg_4_0._payLockMask, false)
	gohelper.setActive(arg_4_0._payHasGet, var_4_3 and var_4_5 or var_4_6)
	gohelper.setActive(arg_4_0._payHasGet2, #var_4_9 + #var_4_10 == 2)
	gohelper.setActive(arg_4_0.freelock, not var_4_2)
	gohelper.setActive(arg_4_0.paylock, not var_4_3)
	gohelper.setActive(arg_4_0.paylock2, not var_4_3 and #var_4_9 + #var_4_10 == 2)
	gohelper.setActive(arg_4_0.payUnLockGo2, #var_4_9 + #var_4_10 == 2)
	gohelper.setActive(arg_4_0._freeCanGet, var_4_2 and not var_4_4)
	gohelper.setActive(arg_4_0._payCanGet, var_4_3 and (not var_4_5 or not var_4_6 and not string.nilorempty(var_4_7.selfSelectPayItem)))
	gohelper.setActive(arg_4_0._btnGetFree, var_4_2 and not var_4_4)
	gohelper.setActive(arg_4_0._btnGetPay, var_4_3 and not var_4_5)

	if #var_4_10 > 0 then
		if #var_4_9 > 0 then
			arg_4_0._getcanvasGroup1.alpha = var_4_3 and var_4_5 and 1 or 0
			arg_4_0._getcanvasGroup2.alpha = var_4_6 and 1 or 0
		else
			arg_4_0._getcanvasGroup1.alpha = var_4_6 and 1 or 0
		end
	else
		arg_4_0._getcanvasGroup1.alpha = 1
		arg_4_0._getcanvasGroup2.alpha = 1
	end

	for iter_4_0 = 1, #arg_4_0._payBonusList do
		if not arg_4_0._payGetEffect[iter_4_0] then
			arg_4_0._payGetEffect[iter_4_0] = gohelper.findChild(arg_4_0._payBonusList[iter_4_0].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for iter_4_1 = 1, #arg_4_0._selectBonusList do
		if not arg_4_0._selectBonusEffect[iter_4_1] then
			arg_4_0._selectBonusEffect[iter_4_1] = gohelper.findChild(arg_4_0._selectBonusList[iter_4_1].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for iter_4_2 = 1, #arg_4_0._payGetEffect do
		gohelper.setActive(arg_4_0._payGetEffect[iter_4_2], var_4_3 and not var_4_5)
	end

	for iter_4_3 = 1, #arg_4_0._selectBonusEffect do
		gohelper.setActive(arg_4_0._selectBonusEffect[iter_4_3], var_4_6)
	end

	local var_4_11 = var_4_2 and not var_4_4 or var_4_3 and not var_4_5

	gohelper.setActive(arg_4_0._goCanGetLv, var_4_11)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtLevel, var_4_11 and "#FD7536" or "#DFBC7A")
end

function var_0_0.showAnim(arg_5_0)
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(arg_5_0._animGo1, true)
	gohelper.setActive(arg_5_0._animGo2, true)
end

function var_0_0._setBonus(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = arg_6_2[iter_6_0]

		if not var_6_0 then
			local var_6_1 = gohelper.cloneInPlace(arg_6_3)

			gohelper.setActive(var_6_1, true)

			var_6_0 = IconMgr.instance:getCommonPropItemIcon(var_6_1)

			table.insert(arg_6_2, var_6_0)
		end

		var_6_0:setMOValue(iter_6_1[1], iter_6_1[2], iter_6_1[3], nil, true)

		if iter_6_1[1] == MaterialEnum.MaterialType.Equip then
			var_6_0._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, var_6_0._equipIcon)
			var_6_0._equipIcon:_loadIconImage()
		end

		if arg_6_5 and not arg_6_6 or arg_6_7 then
			var_6_0:customOnClickCallback(arg_6_4, arg_6_0)
		else
			var_6_0:customOnClickCallback(nil, nil)
		end

		var_6_0:setCountFontSize(46)
		var_6_0:setScale(0.6)

		local var_6_2, var_6_3, var_6_4 = BpConfig.instance:getItemShowSize(iter_6_1[1], iter_6_1[2])

		var_6_0:setItemIconScale(var_6_2)
		var_6_0:setItemOffset(var_6_3, var_6_4)
		var_6_0:SetCountLocalY(43.6)
		var_6_0:SetCountBgHeight(40)
		var_6_0:SetCountBgScale(1, 1.3, 1)
		var_6_0:showStackableNum()
		var_6_0:setHideLvAndBreakFlag(true)
		var_6_0:hideEquipLvAndBreak(true)
		var_6_0:isShowCount(iter_6_1[1] ~= MaterialEnum.MaterialType.HeroSkin)

		if arg_6_6 then
			var_6_0:setAlpha(0.45, 0.8)
		else
			var_6_0:setAlpha(1, 1)
		end

		gohelper.setActive(var_6_0.go.transform.parent.gameObject, true)

		local var_6_5 = gohelper.findChild(var_6_0.go.transform.parent.gameObject, "#goHasGet")

		gohelper.setActive(var_6_5, arg_6_5 and arg_6_6)
	end

	for iter_6_2 = #arg_6_1 + 1, #arg_6_2 do
		local var_6_6 = arg_6_2[iter_6_2]

		gohelper.setActive(var_6_6.go.transform.parent.gameObject, false)
	end
end

function var_0_0._refreshSelect(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.mo.level then
		return
	end

	arg_7_0:onUpdateMO(arg_7_0.mo)
end

function var_0_0.checkPlayAnim(arg_8_0)
	if not BpModel.instance.animData then
		arg_8_0:endUnLockAnim()
	else
		arg_8_0:endUnLockAnim()

		local var_8_0 = BpModel.instance.animData.fromLv
		local var_8_1 = BpModel.instance.animData.toLv
		local var_8_2 = BpModel.instance.animData.fromPayLv
		local var_8_3 = arg_8_0._index

		arg_8_0:playUnLockAnim(var_8_0 < var_8_3 and var_8_3 <= var_8_1, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and var_8_2 < var_8_3 and var_8_3 <= var_8_1)
	end
end

function var_0_0.playUnLockAnim(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		local var_9_0 = SLFramework.AnimatorPlayer.Get(arg_9_0.freeAnim.gameObject)

		arg_9_0:playAnim(var_9_0, UIAnimationName.Open, arg_9_0.endFreeAnim, arg_9_0)
		gohelper.setActive(arg_9_0.freeUnLockGo, true)

		local var_9_1 = SLFramework.AnimatorPlayer.Get(arg_9_0.freeUnLockGo)

		arg_9_0:playAnim(var_9_1, UIAnimationName.Open, arg_9_0.endFreeUnLockAnim, arg_9_0)
	end

	if arg_9_2 then
		local var_9_2 = SLFramework.AnimatorPlayer.Get(arg_9_0.payAnim.gameObject)

		arg_9_0:playAnim(var_9_2, UIAnimationName.Open, arg_9_0.endPayAnim, arg_9_0)
		gohelper.setActive(arg_9_0.payUnLockGo, true)

		local var_9_3 = SLFramework.AnimatorPlayer.Get(arg_9_0.payUnLockGo)

		arg_9_0:playAnim(var_9_3, UIAnimationName.Open, arg_9_0.endPayUnLockAnim, arg_9_0)
	end
end

function var_0_0.playAnim(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_1:Stop()

	if not arg_10_1.isActiveAndEnabled then
		arg_10_3(arg_10_4)

		return
	end

	arg_10_1:Play(arg_10_2, arg_10_3, arg_10_4)
end

function var_0_0.endFreeAnim(arg_11_0)
	arg_11_0.freeAnim:Play(UIAnimationName.Idle)
end

function var_0_0.endPayAnim(arg_12_0)
	arg_12_0.payAnim:Play(UIAnimationName.Idle)
end

function var_0_0.endFreeUnLockAnim(arg_13_0)
	gohelper.setActive(arg_13_0.freeUnLockGo, false)
end

function var_0_0.endPayUnLockAnim(arg_14_0)
	gohelper.setActive(arg_14_0.payUnLockGo, false)
end

function var_0_0.endUnLockAnim(arg_15_0)
	arg_15_0.freeAnim:Play(UIAnimationName.Idle)
	arg_15_0.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(arg_15_0.freeUnLockGo, false)
	gohelper.setActive(arg_15_0.payUnLockGo, false)
end

function var_0_0._onFreeItemIconClick(arg_16_0)
	local var_16_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_16_1 = math.floor(BpModel.instance.score / var_16_0) >= arg_16_0.mo.level
	local var_16_2 = arg_16_0.mo.hasGetSpfreeBonus

	if var_16_1 and not var_16_2 then
		BpRpc.instance:sendGetBpBonusRequest(arg_16_0.mo.level, false, true)
	end
end

function var_0_0._onPayItemIconClick(arg_17_0)
	local var_17_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_17_1 = math.floor(BpModel.instance.score / var_17_0) >= arg_17_0.mo.level
	local var_17_2 = arg_17_0.mo.hasGetSpPayBonus

	if var_17_1 and not var_17_2 then
		BpRpc.instance:sendGetBpBonusRequest(arg_17_0.mo.level, true, true, arg_17_0._onGetBonus, arg_17_0)
	end
end

function var_0_0._onGetBonus(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 == 0 then
		local var_18_0 = BpConfig.instance:getBonusCO(BpModel.instance.id, arg_18_0.mo.level)
		local var_18_1 = BpBonusModel.instance:isGetSelectBonus(arg_18_0.mo.level)

		if not string.nilorempty(var_18_0.selfSelectPayItem) and not var_18_1 then
			arg_18_0:_onselectItemIconClick()
		end
	end
end

function var_0_0._onselectItemIconClick(arg_19_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._freeBonusList then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._freeBonusList) do
			iter_20_1:onDestroy()
		end

		arg_20_0._freeBonusList = nil
	end

	if arg_20_0._payBonusList then
		for iter_20_2, iter_20_3 in pairs(arg_20_0._payBonusList) do
			iter_20_3:onDestroy()
		end

		arg_20_0._payBonusList = nil
	end

	if arg_20_0._selectBonusList then
		for iter_20_4, iter_20_5 in pairs(arg_20_0._selectBonusList) do
			iter_20_5:onDestroy()
		end

		arg_20_0._selectBonusList = nil
	end
end

return var_0_0
