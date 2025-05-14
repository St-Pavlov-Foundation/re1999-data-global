module("modules.logic.battlepass.view.BpSPBonusKeyItem", package.seeall)

local var_0_0 = class("BpSPBonusKeyItem", ListScrollCell)

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
	arg_1_0._payHasGet1 = gohelper.findChild(arg_1_0.go, "pay/#goHasGet/get1")
	arg_1_0._payHasGet2 = gohelper.findChild(arg_1_0.go, "pay/#goHasGet/get2")
	arg_1_0._getcanvasGroup1 = gohelper.onceAddComponent(arg_1_0._payHasGet1, typeof(UnityEngine.CanvasGroup))
	arg_1_0._getcanvasGroup2 = gohelper.onceAddComponent(arg_1_0._payHasGet2, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_1_0._freeItemGO, false)
	gohelper.setActive(arg_1_0._payItemGO, false)

	arg_1_0._freeBonusList = {}
	arg_1_0._payBonusList = {}
	arg_1_0._selectBonusList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.onSelectBonusGet, arg_2_0._refreshSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.onSelectBonusGet, arg_3_0._refreshSelect, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0.mo = arg_4_1
	arg_4_0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), arg_4_0.mo.level)

	local var_4_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_4_1 = math.floor(BpModel.instance.score / var_4_0)
	local var_4_2 = var_4_1 >= arg_4_0.mo.level
	local var_4_3 = var_4_1 >= arg_4_0.mo.level
	local var_4_4 = var_4_1 >= arg_4_0.mo.level
	local var_4_5 = arg_4_0.mo.hasGetSpfreeBonus
	local var_4_6 = arg_4_0.mo.hasGetSpPayBonus
	local var_4_7 = BpBonusModel.instance:isGetSelectBonus(arg_4_0.mo.level)
	local var_4_8 = BpConfig.instance:getBonusCO(BpModel.instance.id, arg_4_0.mo.level)
	local var_4_9 = GameUtil.splitString2(var_4_8.spFreeBonus, true)
	local var_4_10 = GameUtil.splitString2(var_4_8.spPayBonus, true)
	local var_4_11 = GameUtil.splitString2(var_4_8.selfSelectPayItem, true) or {}

	arg_4_0:_setBonus(var_4_9, arg_4_0._freeBonusList, arg_4_0._freeItemGO, arg_4_0._onFreeItemIconClick, var_4_2, var_4_5)
	arg_4_0:_setBonus(var_4_10, arg_4_0._payBonusList, arg_4_0._payItemGO, arg_4_0._onPayItemIconClick, var_4_2, var_4_6)
	arg_4_0:_setBonus(var_4_11, arg_4_0._selectBonusList, arg_4_0._payItemGO, arg_4_0._onselectItemIconClick, var_4_4, var_4_7, true)

	if #var_4_11 > 0 then
		if #var_4_10 > 0 then
			arg_4_0._getcanvasGroup1.alpha = var_4_4 and var_4_6 and 1 or 0
			arg_4_0._getcanvasGroup2.alpha = var_4_7 and 1 or 0
		else
			arg_4_0._getcanvasGroup1.alpha = var_4_7 and 1 or 0
		end
	else
		arg_4_0._getcanvasGroup1.alpha = 1
		arg_4_0._getcanvasGroup2.alpha = 1
	end

	gohelper.setActive(arg_4_0._freeHasGet, var_4_3 and var_4_5)
	gohelper.setActive(arg_4_0._payHasGet, var_4_4 and var_4_6 or var_4_7)
	gohelper.setActive(arg_4_0.freelock, not var_4_3)
	gohelper.setActive(arg_4_0.paylock, not var_4_4)
	gohelper.setActive(arg_4_0.paylock2, not var_4_4 and #var_4_10 + #var_4_11 == 2)
	gohelper.setActive(arg_4_0._payHasGet2, #var_4_10 + #var_4_11 == 2)
end

function var_0_0._setBonus(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
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

		if arg_5_7 then
			var_5_0:customOnClickCallback(arg_5_4, arg_5_0)
		else
			var_5_0:customOnClickCallback(nil, nil)
		end

		if arg_5_6 then
			var_5_0:setAlpha(0.45, 0.8)
		else
			var_5_0:setAlpha(1, 1)
		end

		var_5_0:isShowCount(iter_5_1[1] ~= MaterialEnum.MaterialType.HeroSkin and not arg_5_7)
		gohelper.setActive(var_5_0.go.transform.parent.gameObject, true)
	end

	for iter_5_2 = #arg_5_1 + 1, #arg_5_2 do
		local var_5_5 = arg_5_2[iter_5_2]

		gohelper.setActive(var_5_5.go.transform.parent.gameObject, false)
	end
end

function var_0_0._onselectItemIconClick(arg_6_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function var_0_0._onFreeItemIconClick(arg_7_0)
	return
end

function var_0_0._onPayItemIconClick(arg_8_0)
	return
end

function var_0_0._refreshSelect(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.mo.level then
		return
	end

	arg_9_0:onUpdateMO(arg_9_0.mo)
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._freeBonusList then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._freeBonusList) do
			iter_10_1:onDestroy()
		end

		arg_10_0._freeBonusList = nil
	end

	if arg_10_0._payBonusList then
		for iter_10_2, iter_10_3 in pairs(arg_10_0._payBonusList) do
			iter_10_3:onDestroy()
		end

		arg_10_0._payBonusList = nil
	end
end

return var_0_0
