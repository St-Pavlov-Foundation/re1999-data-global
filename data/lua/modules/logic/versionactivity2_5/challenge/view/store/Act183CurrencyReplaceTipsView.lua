module("modules.logic.versionactivity2_5.challenge.view.store.Act183CurrencyReplaceTipsView", package.seeall)

local var_0_0 = class("Act183CurrencyReplaceTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_desc")
	arg_1_0._simageold = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_old/#simage_old")
	arg_1_0._simagenew = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_new/#simage_new")
	arg_1_0._txtoldcount = gohelper.findChildText(arg_1_0.viewGO, "root/#go_old/#txt_oldcount")
	arg_1_0._txtnewcount = gohelper.findChildText(arg_1_0.viewGO, "root/#go_new/#txt_newcount")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refresh()
	Act183Helper.saveOpenCurrencyReplaceTipsViewInLocal()
end

function var_0_0.refresh(arg_7_0)
	arg_7_0._oldCurrencyId, arg_7_0._oldCurrencyCo, arg_7_0._oldCurrencyIconUrl = arg_7_0:initSingleInfo("oldCurrencyId", "oldCurrencyIconUrl")
	arg_7_0._newCurrencyId, arg_7_0._newCurrencyCo, arg_7_0._newCurrencyIconUrl = arg_7_0:initSingleInfo("newCurrencyId", "newCurrencyIconUrl")

	arg_7_0._simageold:LoadImage(arg_7_0._oldCurrencyIconUrl)
	arg_7_0._simagenew:LoadImage(arg_7_0._newCurrencyIconUrl)

	arg_7_0._replaceRate = arg_7_0.viewParam and arg_7_0.viewParam.replaceRate

	if not arg_7_0._replaceRate then
		logError(string.format("缺少货币替换比例参数replaceRate"))

		arg_7_0._replaceRate = 1
	end

	arg_7_0._oldCurrencyNum = arg_7_0.viewParam and arg_7_0.viewParam.oldCurrencyNum

	if not arg_7_0._oldCurrencyNum then
		logError(string.format("缺少原始货币数量参数oldCurrencyNum"))

		arg_7_0._oldCurrencyNum = 0
	end

	arg_7_0._newCurrencyNum = arg_7_0._oldCurrencyNum * arg_7_0._replaceRate
	arg_7_0._txtoldcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), arg_7_0._oldCurrencyNum)
	arg_7_0._txtnewcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), arg_7_0._newCurrencyNum)
	arg_7_0._txtdesc.text = arg_7_0.viewParam and arg_7_0.viewParam.desc or ""
end

function var_0_0.initSingleInfo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam[arg_8_1]
	local var_8_1 = CurrencyConfig.instance:getCurrencyCo(var_8_0)

	if not var_8_1 then
		logError(string.format("货币配置不存在  currencyIdParamName = %s, currencyId = %s", arg_8_1, var_8_0))
	end

	local var_8_2 = arg_8_0.viewParam and arg_8_0.viewParam[arg_8_2]

	if not var_8_2 then
		local var_8_3 = var_8_1 and var_8_1.icon

		var_8_2 = ResUrl.getCurrencyItemIcon(var_8_3)
	end

	return var_8_0, var_8_1, var_8_2
end

function var_0_0.getCurrencyCount(arg_9_0, arg_9_1)
	local var_9_0 = CurrencyModel.instance:getCurrency(arg_9_1)

	if not var_9_0 then
		logError(string.format("货币数据不存在 currencyId = %s", arg_9_1))

		return 0
	end

	return var_9_0.quantity
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._simageold:UnLoadImage()
	arg_10_0._simagenew:UnloadImage()
end

return var_0_0
