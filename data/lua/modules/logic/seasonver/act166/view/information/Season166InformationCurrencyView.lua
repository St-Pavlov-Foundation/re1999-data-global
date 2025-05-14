module("modules.logic.seasonver.act166.view.information.Season166InformationCurrencyView", package.seeall)

local var_0_0 = class("Season166InformationCurrencyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "RightTop/#go_container/#go_currency")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "RightTop/#go_container")

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

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, arg_5_1, false)

	if arg_5_0._callback then
		arg_5_0._callback(arg_5_0._callbackObj)
	end
end

function var_0_0._onClick(arg_6_0)
	local var_6_0 = arg_6_0.self
	local var_6_1 = arg_6_0.index
	local var_6_2 = var_6_0.param[var_6_1]

	if not var_6_2 then
		return
	end

	if type(var_6_2) == "number" then
		local var_6_3 = var_6_2

		CurrencyJumpHandler.JumpByCurrency(var_6_3)
	elseif var_6_2.jumpFunc then
		var_6_2.jumpFunc()
	end
end

local var_0_1 = CurrencyEnum.CurrencyType

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gocurrency, false)

	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._currencyObjs = {}
	arg_7_0._currentItemIndex = nil
	arg_7_0._initialized = true
end

function var_0_0.setCurrencyType(arg_8_0, arg_8_1)
	arg_8_0.param = arg_8_1

	arg_8_0:_onCurrencyChange()
end

function var_0_0.onDestroyView(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._currencyObjs) do
		iter_9_1.btn:RemoveClickListener()
		iter_9_1.btncurrency:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId or arg_10_0.viewParam.activityId
	arg_10_0.param = {
		Season166Config.instance:getSeasonConstNum(arg_10_0.actId, Season166Enum.InfoCostId)
	}

	arg_10_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_10_0._onCurrencyChange, arg_10_0)
	arg_10_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0._onCurrencyChange, arg_10_0)
	arg_10_0:_onCurrencyChange()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0._onCurrencyChange, arg_11_0)
	arg_11_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0._onCurrencyChange, arg_11_0)
end

function var_0_0._onCurrencyChange(arg_12_0)
	if not arg_12_0.param then
		gohelper.setActive(arg_12_0._gocontainer, false)

		return
	end

	if not arg_12_0._initialized then
		return
	end

	local var_12_0 = #arg_12_0.param
	local var_12_1 = 1

	for iter_12_0 = var_12_0, 1, -1 do
		local var_12_2 = arg_12_0:getCurrencyItem(iter_12_0)
		local var_12_3 = arg_12_0.param[iter_12_0]

		gohelper.setSibling(var_12_2.go, var_12_1)

		var_12_1 = var_12_1 + 1

		if var_12_3 then
			local var_12_4 = var_12_3
			local var_12_5 = CurrencyModel.instance:getCurrency(var_12_4)
			local var_12_6 = CurrencyConfig.instance:getCurrencyCo(var_12_4)
			local var_12_7 = var_12_5 and var_12_5.quantity or 0

			var_12_2.txt.text = GameUtil.numberDisplay(var_12_7)

			var_12_2.go:SetActive(true)

			local var_12_8 = var_12_6.icon

			UISpriteSetMgr.instance:setCurrencyItemSprite(var_12_2.image, var_12_8 .. "_1")
		else
			var_12_2.go:SetActive(false)
		end
	end

	if var_12_0 < #arg_12_0._currencyObjs then
		for iter_12_1 = var_12_0 + 1, #arg_12_0._currencyObjs do
			arg_12_0:getCurrencyItem(iter_12_1).go:SetActive(false)
		end
	end

	gohelper.setActive(arg_12_0._gocontainer, var_12_0 > 0)
end

function var_0_0.getCurrencyItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._currencyObjs[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()

		local var_13_1 = gohelper.cloneInPlace(arg_13_0._gocurrency, "currency")

		var_13_0.go = var_13_1
		var_13_0.btn = gohelper.findChildButtonWithAudio(var_13_1, "#btn_currency/#btn")
		var_13_0.image = gohelper.findChildImage(var_13_1, "#btn_currency/#image")
		var_13_0.btncurrency = gohelper.findChildButtonWithAudio(var_13_1, "#btn_currency")
		var_13_0.txt = gohelper.findChildText(var_13_1, "#btn_currency/content/#txt")
		var_13_0.click = gohelper.findChild(var_13_1, "#btn_currency/click")

		var_13_0.btn:AddClickListener(arg_13_0._onClick, {
			self = arg_13_0,
			index = arg_13_1
		})
		gohelper.setActive(var_13_0.btn, false)
		var_13_0.btncurrency:AddClickListener(arg_13_0._btncurrencyOnClick, {
			self = arg_13_0,
			index = arg_13_1
		})

		arg_13_0._currencyObjs[arg_13_1] = var_13_0

		gohelper.setActive(var_13_0.go, true)
	end

	return var_13_0
end

return var_0_0
