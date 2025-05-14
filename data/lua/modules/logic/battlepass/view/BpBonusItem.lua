module("modules.logic.battlepass.view.BpBonusItem", package.seeall)

local var_0_0 = class("BpBonusItem", ListScrollCell)

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
	arg_1_0._payHasGet2 = gohelper.findChild(arg_1_0.go, "payStatus/#goHasGet/get2")
	arg_1_0._goCanGetLv = gohelper.findChild(arg_1_0.go, "#go_canGetLv")
	arg_1_0._animGo1 = gohelper.findChild(arg_1_0.go, "free/freenode/#goCanGet/bg/#vx_effect")
	arg_1_0._animGo2 = gohelper.findChild(arg_1_0.go, "pay/paynode/#goCanGet/image/#vx_effect")
	arg_1_0._btnGetFree = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_getfree")
	arg_1_0._btnGetPay = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_getpay")
	arg_1_0._freeBonusList = {}
	arg_1_0._payBonusList = {}
	arg_1_0._payGetEffect = arg_1_0:getUserDataTb_()

	arg_1_0:showAnim()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnGetFree:AddClickListener(arg_2_0._onFreeItemIconClick, arg_2_0)
	arg_2_0._btnGetPay:AddClickListener(arg_2_0._onPayItemIconClick, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.OnViewOpenFinish, arg_2_0.showAnim, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnGetFree:RemoveClickListener()
	arg_3_0._btnGetPay:RemoveClickListener()
	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnViewOpenFinish, arg_3_0.showAnim, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	if not arg_4_0.mo or arg_4_1.id ~= arg_4_0.mo.id then
		arg_4_0:checkPlayAnim()
	elseif arg_4_1.hasGetfreeBonus or arg_4_1.hasGetPayBonus then
		if arg_4_1.hasGetfreeBonus then
			arg_4_0.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(arg_4_0.freeUnLockGo, false)
		end

		if arg_4_1.hasGetPayBonus then
			arg_4_0.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(arg_4_0.payUnLockGo, false)
		end
	end

	arg_4_0.mo = arg_4_1
	arg_4_0._txtLevel.text = luaLang("level") .. arg_4_1.level

	local var_4_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_4_1 = math.floor(BpModel.instance.score / var_4_0)
	local var_4_2 = var_4_1 >= arg_4_0.mo.level
	local var_4_3 = var_4_1 >= arg_4_0.mo.level and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	local var_4_4 = arg_4_0.mo.hasGetfreeBonus
	local var_4_5 = arg_4_0.mo.hasGetPayBonus
	local var_4_6 = BpConfig.instance:getBonusCO(BpModel.instance.id, arg_4_0.mo.level)
	local var_4_7 = GameUtil.splitString2(var_4_6.freeBonus, true)
	local var_4_8 = GameUtil.splitString2(var_4_6.payBonus, true)

	arg_4_0:_setBonus(var_4_7, arg_4_0._freeBonusList, arg_4_0._freeItemGO, arg_4_0._onFreeItemIconClick, var_4_2, var_4_4)
	arg_4_0:_setBonus(var_4_8, arg_4_0._payBonusList, arg_4_0._payItemGO, arg_4_0._onPayItemIconClick, var_4_3, var_4_5)
	gohelper.setActive(arg_4_0._freeLockMask, false)
	gohelper.setActive(arg_4_0._freeHasGet, var_4_2 and var_4_4)
	gohelper.setActive(arg_4_0._payLockMask, false)
	gohelper.setActive(arg_4_0._payHasGet, var_4_3 and var_4_5)
	gohelper.setActive(arg_4_0.freelock, not var_4_2)
	gohelper.setActive(arg_4_0.paylock, not var_4_3)
	gohelper.setActive(arg_4_0.paylock2, not var_4_3 and #var_4_8 == 2)
	gohelper.setActive(arg_4_0._payHasGet2, #var_4_8 == 2)
	gohelper.setActive(arg_4_0.payUnLockGo2, #var_4_8 == 2)
	gohelper.setActive(arg_4_0._freeCanGet, var_4_2 and not var_4_4)
	gohelper.setActive(arg_4_0._payCanGet, var_4_3 and not var_4_5)
	gohelper.setActive(arg_4_0._btnGetFree, var_4_2 and not var_4_4)
	gohelper.setActive(arg_4_0._btnGetPay, var_4_3 and not var_4_5)

	for iter_4_0 = 1, #arg_4_0._payBonusList do
		if not arg_4_0._payGetEffect[iter_4_0] then
			arg_4_0._payGetEffect[iter_4_0] = gohelper.findChild(arg_4_0._payBonusList[iter_4_0].go.transform.parent.gameObject, "#vx_get_down")
		end
	end

	for iter_4_1 = 1, #arg_4_0._payGetEffect do
		gohelper.setActive(arg_4_0._payGetEffect[iter_4_1], var_4_3 and not var_4_5)
	end

	local var_4_9 = var_4_2 and not var_4_4 or var_4_3 and not var_4_5

	gohelper.setActive(arg_4_0._goCanGetLv, var_4_9)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtLevel, var_4_9 and "#FD7536" or "#DFBC7A")
end

function var_0_0.showAnim(arg_5_0)
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(arg_5_0._animGo1, true)
	gohelper.setActive(arg_5_0._animGo2, true)
end

function var_0_0._setBonus(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
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

		if arg_6_5 and not arg_6_6 then
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

function var_0_0.checkPlayAnim(arg_7_0)
	if not BpModel.instance.animData then
		arg_7_0:endUnLockAnim()
	else
		arg_7_0:endUnLockAnim()

		local var_7_0 = BpModel.instance.animData.fromLv
		local var_7_1 = BpModel.instance.animData.toLv
		local var_7_2 = BpModel.instance.animData.fromPayLv
		local var_7_3 = arg_7_0._index

		arg_7_0:playUnLockAnim(var_7_0 < var_7_3 and var_7_3 <= var_7_1, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and var_7_2 < var_7_3 and var_7_3 <= var_7_1)
	end
end

function var_0_0.playUnLockAnim(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = SLFramework.AnimatorPlayer.Get(arg_8_0.freeAnim.gameObject)

		arg_8_0:playAnim(var_8_0, UIAnimationName.Open, arg_8_0.endFreeAnim, arg_8_0)
		gohelper.setActive(arg_8_0.freeUnLockGo, true)

		local var_8_1 = SLFramework.AnimatorPlayer.Get(arg_8_0.freeUnLockGo)

		arg_8_0:playAnim(var_8_1, UIAnimationName.Open, arg_8_0.endFreeUnLockAnim, arg_8_0)
	end

	if arg_8_2 then
		local var_8_2 = SLFramework.AnimatorPlayer.Get(arg_8_0.payAnim.gameObject)

		arg_8_0:playAnim(var_8_2, UIAnimationName.Open, arg_8_0.endPayAnim, arg_8_0)
		gohelper.setActive(arg_8_0.payUnLockGo, true)

		local var_8_3 = SLFramework.AnimatorPlayer.Get(arg_8_0.payUnLockGo)

		arg_8_0:playAnim(var_8_3, UIAnimationName.Open, arg_8_0.endPayUnLockAnim, arg_8_0)
	end
end

function var_0_0.playAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_1:Stop()

	if not arg_9_1.isActiveAndEnabled then
		arg_9_3(arg_9_4)

		return
	end

	arg_9_1:Play(arg_9_2, arg_9_3, arg_9_4)
end

function var_0_0.endFreeAnim(arg_10_0)
	arg_10_0.freeAnim:Play(UIAnimationName.Idle)
end

function var_0_0.endPayAnim(arg_11_0)
	arg_11_0.payAnim:Play(UIAnimationName.Idle)
end

function var_0_0.endFreeUnLockAnim(arg_12_0)
	gohelper.setActive(arg_12_0.freeUnLockGo, false)
end

function var_0_0.endPayUnLockAnim(arg_13_0)
	gohelper.setActive(arg_13_0.payUnLockGo, false)
end

function var_0_0.endUnLockAnim(arg_14_0)
	arg_14_0.freeAnim:Play(UIAnimationName.Idle)
	arg_14_0.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(arg_14_0.freeUnLockGo, false)
	gohelper.setActive(arg_14_0.payUnLockGo, false)
end

function var_0_0._onFreeItemIconClick(arg_15_0)
	local var_15_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_15_1 = math.floor(BpModel.instance.score / var_15_0) >= arg_15_0.mo.level
	local var_15_2 = arg_15_0.mo.hasGetfreeBonus

	if var_15_1 and not var_15_2 then
		BpRpc.instance:sendGetBpBonusRequest(arg_15_0.mo.level, false)
	end
end

function var_0_0._onPayItemIconClick(arg_16_0)
	local var_16_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_16_1 = math.floor(BpModel.instance.score / var_16_0) >= arg_16_0.mo.level and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	local var_16_2 = arg_16_0.mo.hasGetPayBonus

	if var_16_1 and not var_16_2 then
		BpRpc.instance:sendGetBpBonusRequest(arg_16_0.mo.level, true)
	end
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._freeBonusList then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._freeBonusList) do
			iter_17_1:onDestroy()
		end

		arg_17_0._freeBonusList = nil
	end

	if arg_17_0._payBonusList then
		for iter_17_2, iter_17_3 in pairs(arg_17_0._payBonusList) do
			iter_17_3:onDestroy()
		end

		arg_17_0._payBonusList = nil
	end
end

return var_0_0
