module("modules.logic.currency.view.CurrencyView", package.seeall)

local var_0_0 = class("CurrencyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_currency")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btncurrencyOnClick(arg_4_0)
	local var_4_0 = arg_4_0.self
	local var_4_1 = arg_4_0.index

	var_4_0:_btncurrencyClick(var_4_0.param[var_4_1])
end

function var_0_0._btncurrencyClick(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	if arg_5_0.overrideClickFunc then
		return arg_5_0.overrideClickFunc(arg_5_0.overrideClickFuncObj, arg_5_1)
	end

	if type(arg_5_1) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, arg_5_1, false, nil, arg_5_0._cantJump)
	else
		MaterialTipController.instance:showMaterialInfo(arg_5_1.type, arg_5_1.id, false, nil, arg_5_0._cantJump)
	end

	if arg_5_0._callback then
		arg_5_0._callback(arg_5_0._callbackObj)
	end
end

function var_0_0.setOpenCallback(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._openCallback = arg_6_1
	arg_6_0._openCallbackObj = arg_6_2
end

function var_0_0.ctor(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	var_0_0.super.ctor(arg_7_0)

	arg_7_0.param = arg_7_1
	arg_7_0._callback = arg_7_2
	arg_7_0._callbackObj = arg_7_3
	arg_7_0._localItemsEvent = arg_7_4
	arg_7_0._cantJump = arg_7_5
end

function var_0_0.overrideCurrencyClickFunc(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.overrideClickFunc = arg_8_1
	arg_8_0.overrideClickFuncObj = arg_8_2
end

function var_0_0._onLocalItemChanged(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._minusItemDict = {}

	if arg_9_1 then
		for iter_9_0 = 1, #arg_9_1 do
			local var_9_0 = arg_9_1[iter_9_0]

			if var_9_0.type == MaterialEnum.MaterialType.Currency then
				arg_9_0._minusItemDict[var_9_0.id] = (arg_9_0._minusItemDict[var_9_0.id] or 0) + var_9_0.quantity
			end
		end
	end

	if arg_9_2 then
		return
	end

	arg_9_0:_onCurrencyChange()
end

function var_0_0._onClick(arg_10_0)
	local var_10_0 = arg_10_0.self
	local var_10_1 = arg_10_0.index
	local var_10_2 = var_10_0.param[var_10_1]

	if not var_10_2 then
		return
	end

	if type(var_10_2) == "number" then
		local var_10_3 = var_10_2

		CurrencyJumpHandler.JumpByCurrency(var_10_3)
	elseif var_10_2.jumpFunc then
		var_10_2.jumpFunc(var_10_2.type, var_10_2.id)
	end
end

local var_0_1 = CurrencyEnum.CurrencyType

function var_0_0._editableInitView(arg_11_0)
	gohelper.setActive(arg_11_0._gocurrency, false)

	arg_11_0._animator = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_11_0._currencyObjs = {}
	arg_11_0._currentItemIndex = nil

	if not arg_11_0.param then
		logError("没有传入货币类型给CurrencyView")

		return
	end

	arg_11_0._initialized = true

	arg_11_0:_onCurrencyChange()
end

function var_0_0.setCurrencyType(arg_12_0, arg_12_1)
	arg_12_0.param = arg_12_1

	arg_12_0:_onCurrencyChange()
end

function var_0_0.onDestroyView(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._currencyObjs) do
		iter_13_1.simage:UnLoadImage()
		iter_13_1.btn:RemoveClickListener()
		iter_13_1.btncurrency:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_14_0._onCurrencyChange, arg_14_0)
	arg_14_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_14_0._onCurrencyChange, arg_14_0)

	if arg_14_0._localItemsEvent then
		arg_14_0:addEventCb(CharacterController.instance, CharacterEvent.levelUplocalItem, arg_14_0._onLocalItemChanged, arg_14_0)
	end

	if arg_14_0.viewContainer.viewParam and arg_14_0.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		arg_14_0._animator:Play("currencyview_in2")
	else
		arg_14_0._animator:Play("currencyview_in")
	end

	if arg_14_0._openCallback then
		arg_14_0._openCallback(arg_14_0._openCallbackObj)

		arg_14_0._openCallback = nil
		arg_14_0._openCallbackObj = nil
	end
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onRefreshDeadlineUI, arg_15_0)
	arg_15_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_15_0._onCurrencyChange, arg_15_0)
	arg_15_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_15_0._onCurrencyChange, arg_15_0)

	if arg_15_0.viewContainer.viewParam and arg_15_0.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		arg_15_0._animator:Play("currencyview_out2")
	else
		arg_15_0._animator:Play("currencyview_out")
	end
end

function var_0_0._onCurrencyChange(arg_16_0)
	if not arg_16_0.param then
		gohelper.setActive(arg_16_0._gocontainer, false)

		return
	end

	if not arg_16_0._initialized then
		return
	end

	local var_16_0 = #arg_16_0.param
	local var_16_1 = 1

	for iter_16_0 = var_16_0, 1, -1 do
		local var_16_2 = arg_16_0:getCurrencyItem(iter_16_0)
		local var_16_3 = arg_16_0.param[iter_16_0]

		gohelper.setSibling(var_16_2.go, var_16_1)

		var_16_1 = var_16_1 + 1

		if var_16_3 then
			local var_16_4 = false
			local var_16_5 = true

			if type(var_16_3) == "number" then
				local var_16_6 = var_16_3
				local var_16_7 = CurrencyModel.instance:getCurrency(var_16_6)
				local var_16_8 = CurrencyConfig.instance:getCurrencyCo(var_16_6)
				local var_16_9 = var_16_7 and var_16_7.quantity or 0

				if arg_16_0._minusItemDict and arg_16_0._minusItemDict[var_16_6] then
					var_16_9 = var_16_9 - arg_16_0._minusItemDict[var_16_6]
				end

				if arg_16_0.showMaxLimit then
					var_16_2.txt.text = string.format("%s/%s", GameUtil.numberDisplay(var_16_9), GameUtil.numberDisplay(var_16_8.maxLimit))
				else
					var_16_2.txt.text = GameUtil.numberDisplay(var_16_9)
				end

				var_16_2.go:SetActive(true)

				local var_16_10 = var_16_8.icon

				UISpriteSetMgr.instance:setCurrencyItemSprite(var_16_2.image, var_16_10 .. "_1")

				if arg_16_0:isNeedShieldAddBtn() then
					var_16_5 = false

					var_16_2.btn.gameObject:SetActive(false)
				end

				if var_16_6 == CurrencyEnum.CurrencyType.Power then
					arg_16_0.powerItemObj = var_16_2

					arg_16_0:_onRefreshDeadline()
				end

				var_16_4 = false
			else
				local var_16_11 = var_16_3.type
				local var_16_12 = var_16_3.id
				local var_16_13 = var_16_3.isIcon
				local var_16_14 = var_16_3.quantity or ItemModel.instance:getItemQuantity(var_16_11, var_16_12)

				var_16_2.txt.text = GameUtil.numberDisplay(var_16_14)

				var_16_2.go:SetActive(true)

				if var_16_3.isCurrencySprite then
					local var_16_15 = var_16_3.icon or var_16_12

					UISpriteSetMgr.instance:setCurrencyItemSprite(var_16_2.image, tostring(var_16_15) .. "_1")
				else
					local var_16_16 = var_16_3.icon

					if not var_16_16 then
						if var_16_13 then
							var_16_16 = ItemModel.instance:getItemSmallIcon(var_16_12)
						else
							local var_16_17, var_16_18 = ItemModel.instance:getItemConfigAndIcon(var_16_11, var_16_12, var_16_13)

							var_16_16 = var_16_18
						end
					end

					var_16_2.simage:LoadImage(var_16_16)
				end

				if arg_16_0:isNeedShieldAddBtn() or var_16_3.isHideAddBtn == true then
					var_16_5 = false
				end

				if var_16_11 == MaterialEnum.MaterialType.PowerPotion then
					arg_16_0.powerItemObj = var_16_2

					arg_16_0:_onRefreshDeadline()
				end

				var_16_4 = not var_16_3.isCurrencySprite
			end

			gohelper.setActive(var_16_2.image.gameObject, not var_16_4)
			gohelper.setActive(var_16_2.simage.gameObject, var_16_4)
			gohelper.setActive(var_16_2.btn, var_16_5)
		else
			var_16_2.go:SetActive(false)
		end
	end

	if var_16_0 < #arg_16_0._currencyObjs then
		for iter_16_1 = var_16_0 + 1, #arg_16_0._currencyObjs do
			arg_16_0:getCurrencyItem(iter_16_1).go:SetActive(false)
		end
	end

	gohelper.setActive(arg_16_0._gocontainer, var_16_0 > 0)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
		arg_16_0:_hideAddBtn(CurrencyEnum.CurrencyType.Diamond)
	end
end

function var_0_0.getCurrencyItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._currencyObjs[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()

		local var_17_1 = gohelper.cloneInPlace(arg_17_0._gocurrency, "currency")

		var_17_0.go = var_17_1
		var_17_0.btn = gohelper.findChildButtonWithAudio(var_17_1, "#btn_currency/#btn")
		var_17_0.simage = gohelper.findChildSingleImage(var_17_1, "#btn_currency/#simage")
		var_17_0.image = gohelper.findChildImage(var_17_1, "#btn_currency/#image")
		var_17_0.btncurrency = gohelper.findChildButtonWithAudio(var_17_1, "#btn_currency")
		var_17_0.txt = gohelper.findChildText(var_17_1, "#btn_currency/content/#txt")
		var_17_0.click = gohelper.findChild(var_17_1, "#btn_currency/click")
		var_17_0.goCurrentTime = gohelper.findChild(var_17_1, "#btn_currency/#go_currenttime")
		var_17_0.txtTime = gohelper.findChildText(var_17_1, "#btn_currency/#go_currenttime/timetxt")
		var_17_0.deadlineEffect = gohelper.findChild(var_17_1, "#btn_currency/#effect")

		var_17_0.btn:AddClickListener(arg_17_0._onClick, {
			self = arg_17_0,
			index = arg_17_1
		})
		var_17_0.btncurrency:AddClickListener(arg_17_0._btncurrencyOnClick, {
			self = arg_17_0,
			index = arg_17_1
		})

		arg_17_0._currencyObjs[arg_17_1] = var_17_0

		gohelper.setActive(var_17_0.go, true)
	end

	return var_17_0
end

function var_0_0.isNeedShieldAddBtn(arg_18_0)
	if arg_18_0.foreShowBtn then
		return false
	end

	if arg_18_0.foreHideBtn then
		return true
	end

	if not var_0_0.needShieldAddBtnViews then
		var_0_0.needShieldAddBtnViews = {
			[ViewName.StoreSkinConfirmView] = 1,
			[ViewName.CharacterLevelUpView] = 1,
			[ViewName.StoreView] = 1,
			[ViewName.EquipView] = 1,
			[ViewName.NormalStoreGoodsView] = 1,
			[ViewName.SummonConfirmView] = 1,
			[ViewName.CharacterRankUpView] = 1,
			[ViewName.CurrencyExchangeView] = 1,
			[ViewName.PowerView] = 1,
			[ViewName.PowerBuyTipView] = 1,
			[ViewName.CurrencyDiamondExchangeView] = 1,
			[ViewName.CharacterTalentLevelUpView] = 1,
			[ViewName.RoomStoreGoodsTipView] = 1,
			[ViewName.PackageStoreGoodsView] = 1,
			[ViewName.StoreLinkGiftGoodsView] = 1,
			[ViewName.StoreSkinGoodsView] = 1,
			[ViewName.DecorateStoreGoodsView] = 1,
			[ViewName.VersionActivityStoreView] = 1,
			[ViewName.VersionActivityNormalStoreGoodsView] = 1,
			[ViewName.SeasonStoreView] = 1,
			[ViewName.VersionActivity1_2StoreView] = 1,
			[ViewName.V1a5BuildingView] = 1,
			[ViewName.V1a5BuildingDetailView] = 1,
			[ViewName.PowerActChangeView] = 1,
			[ViewName.SummonStoreGoodsView] = 1,
			[ViewName.VersionActivity1_6NormalStoreGoodsView] = 1,
			[ViewName.RoomFormulaMsgBoxView] = 1,
			[ViewName.SummonResultView] = 1
		}
	end

	if not arg_18_0.viewName then
		return false
	end

	return var_0_0.needShieldAddBtnViews[arg_18_0.viewName] == 1
end

function var_0_0._hideAddBtn(arg_19_0, arg_19_1)
	for iter_19_0 = #arg_19_0.param, 1, -1 do
		if arg_19_0.param[iter_19_0] == arg_19_1 then
			local var_19_0 = arg_19_0:getCurrencyItem(iter_19_0)

			gohelper.setActive(var_19_0.btn.gameObject, false)
		end
	end
end

function var_0_0._onRefreshDeadline(arg_20_0)
	arg_20_0:_onRefreshDeadlineUI()
	TaskDispatcher.runRepeat(arg_20_0._onRefreshDeadlineUI, arg_20_0, 1)
end

function var_0_0._onRefreshDeadlineUI(arg_21_0)
	local var_21_0 = CurrencyController.instance:getPowerItemDeadLineTime()

	if var_21_0 and var_21_0 > 0 then
		local var_21_1 = var_21_0 - ServerTime.now()

		if var_21_1 <= 0 then
			ItemRpc.instance:autoUseExpirePowerItem()
			gohelper.setActive(arg_21_0.powerItemObj.goCurrentTime, false)
			gohelper.setActive(arg_21_0.powerItemObj.deadlineEffect, false)
			TaskDispatcher.cancelTask(arg_21_0._onRefreshDeadlineUI, arg_21_0)

			return
		end

		local var_21_2, var_21_3, var_21_4 = TimeUtil.secondToRoughTime(var_21_1, true)

		arg_21_0.powerItemObj.txtTime.text = string.format("%s%s", var_21_2, var_21_3)

		gohelper.setActive(arg_21_0.powerItemObj.goCurrentTime, not var_21_4)
		gohelper.setActive(arg_21_0.powerItemObj.deadlineEffect, not var_21_4)
	else
		gohelper.setActive(arg_21_0.powerItemObj.goCurrentTime, false)
		gohelper.setActive(arg_21_0.powerItemObj.deadlineEffect, false)
	end
end

var_0_0.prefabPath = "ui/viewres/common/currencyview.prefab"

return var_0_0
