module("modules.logic.battlepass.view.BpBonusKeyItem", package.seeall)

local var_0_0 = class("BpBonusKeyItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.go, "#txtLevel")
	arg_1_0._freeItemGO = gohelper.findChild(arg_1_0.go, "free/freenode/#goItem")
	arg_1_0._payItemGO = gohelper.findChild(arg_1_0.go, "pay/paynode/#goItem")
	arg_1_0._freeHasGet = gohelper.findChild(arg_1_0.go, "free/#goHasGet")
	arg_1_0._payHasGet = gohelper.findChild(arg_1_0.go, "pay/#goHasGet")
	arg_1_0.freelock = gohelper.findChild(arg_1_0.go, "free/freelock/lock")
	arg_1_0.paylock = gohelper.findChild(arg_1_0.go, "pay/paylock/lock1")
	arg_1_0.paylock2 = gohelper.findChild(arg_1_0.go, "pay/paylock/lock2")
	arg_1_0._payHasGet2 = gohelper.findChild(arg_1_0.go, "pay/#goHasGet/get2")

	gohelper.setActive(arg_1_0._freeItemGO, false)
	gohelper.setActive(arg_1_0._payItemGO, false)

	arg_1_0._freeBonusList = {}
	arg_1_0._payBonusList = {}
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1
	arg_4_0._txtLevel.text = luaLang("level") .. arg_4_1.level

	local var_4_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_4_1 = math.floor(BpModel.instance.score / var_4_0)
	local var_4_2 = var_4_1 >= arg_4_0.mo.level
	local var_4_3 = var_4_1 >= arg_4_0.mo.level
	local var_4_4 = var_4_1 >= arg_4_0.mo.level and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	local var_4_5 = arg_4_0.mo.hasGetfreeBonus
	local var_4_6 = arg_4_0.mo.hasGetPayBonus
	local var_4_7 = BpConfig.instance:getBonusCO(BpModel.instance.id, arg_4_0.mo.level)
	local var_4_8 = GameUtil.splitString2(var_4_7.freeBonus, true)
	local var_4_9 = GameUtil.splitString2(var_4_7.payBonus, true)

	arg_4_0:_setBonus(var_4_8, arg_4_0._freeBonusList, arg_4_0._freeItemGO, arg_4_0._onFreeItemIconClick, var_4_2, var_4_5)
	arg_4_0:_setBonus(var_4_9, arg_4_0._payBonusList, arg_4_0._payItemGO, arg_4_0._onPayItemIconClick, var_4_2, var_4_6)
	gohelper.setActive(arg_4_0._freeHasGet, var_4_3 and var_4_5)
	gohelper.setActive(arg_4_0._payHasGet, var_4_4 and var_4_6)
	gohelper.setActive(arg_4_0.freelock, not var_4_3)
	gohelper.setActive(arg_4_0.paylock, not var_4_4)
	gohelper.setActive(arg_4_0.paylock2, not var_4_4 and #var_4_9 == 2)
	gohelper.setActive(arg_4_0._payHasGet2, #var_4_9 == 2)
end

function var_0_0._setBonus(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = arg_5_2[iter_5_0]

		if not var_5_0 then
			local var_5_1 = gohelper.cloneInPlace(arg_5_3)

			gohelper.setActive(var_5_1, true)

			var_5_0 = IconMgr.instance:getCommonPropItemIcon(var_5_1)

			table.insert(arg_5_2, var_5_0)
		end

		gohelper.setAsFirstSibling(var_5_0.go)
		var_5_0:setMOValue(iter_5_1[1], iter_5_1[2], iter_5_1[3], nil, true)

		if iter_5_1[1] == MaterialEnum.MaterialType.Equip then
			var_5_0._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, var_5_0._equipIcon)
			var_5_0._equipIcon:_loadIconImage()
		end

		var_5_0:setCountFontSize(46)
		var_5_0:setScale(0.6)

		local var_5_2, var_5_3, var_5_4 = BpConfig.instance:getItemShowSize(iter_5_1[1], iter_5_1[2])

		var_5_0:setItemIconScale(var_5_2)
		var_5_0:setItemOffset(var_5_3, var_5_4)
		var_5_0:SetCountLocalY(43.6)
		var_5_0:SetCountBgHeight(40)
		var_5_0:SetCountBgScale(1, 1.3, 1)
		var_5_0:showStackableNum()
		var_5_0:setHideLvAndBreakFlag(true)
		var_5_0:hideEquipLvAndBreak(true)

		if arg_5_6 then
			var_5_0:setAlpha(0.45, 0.8)
		else
			var_5_0:setAlpha(1, 1)
		end

		var_5_0:isShowCount(iter_5_1[1] ~= MaterialEnum.MaterialType.HeroSkin)
		gohelper.setActive(var_5_0.go.transform.parent.gameObject, true)
	end

	for iter_5_2 = #arg_5_1 + 1, #arg_5_2 do
		local var_5_5 = arg_5_2[iter_5_2]

		gohelper.setActive(var_5_5.go.transform.parent.gameObject, false)
	end
end

function var_0_0._onFreeItemIconClick(arg_6_0)
	return
end

function var_0_0._onPayItemIconClick(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._freeBonusList then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._freeBonusList) do
			iter_8_1:onDestroy()
		end

		arg_8_0._freeBonusList = nil
	end

	if arg_8_0._payBonusList then
		for iter_8_2, iter_8_3 in pairs(arg_8_0._payBonusList) do
			iter_8_3:onDestroy()
		end

		arg_8_0._payBonusList = nil
	end
end

return var_0_0
