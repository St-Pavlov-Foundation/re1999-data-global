module("modules.logic.currency.view.PowerMakerPatFaceView", package.seeall)

local var_0_0 = class("PowerMakerPatFaceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntouchClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_touchClose")
	arg_1_0._txtdesc1 = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc_1")
	arg_1_0._txtdesc2 = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc_2")
	arg_1_0._txtdesc3 = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc_3")
	arg_1_0._goleftitem = gohelper.findChild(arg_1_0.viewGO, "#go_leftitem")
	arg_1_0._gorightitem = gohelper.findChild(arg_1_0.viewGO, "#go_rightitem")
	arg_1_0._txtoverflowcount = gohelper.findChildText(arg_1_0.viewGO, "#go_rightitem/#txt_overflowcount")
	arg_1_0._txtoverfloweffect = gohelper.findChildText(arg_1_0.viewGO, "#go_rightitem/#txt_overfloweffect")
	arg_1_0._btnoverflowitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rightitem/#btn_overflowitem")
	arg_1_0._gooverflowdeatline = gohelper.findChild(arg_1_0.viewGO, "#go_rightitem/#go_overflowdeadline")
	arg_1_0._txtoverflowtime = gohelper.findChildText(arg_1_0.viewGO, "#go_rightitem/#go_overflowdeadline/#txt_overflowtime")
	arg_1_0._txtoverflowicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_rightitem/#go_overflowdeadline/#txt_overflowtime/overflowtimeicon")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buy")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntouchClose:AddClickListener(arg_2_0._btntouchCloseOnClick, arg_2_0)
	arg_2_0._btnoverflowitem:AddClickListener(arg_2_0._btnoverflowitemOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntouchClose:RemoveClickListener()
	arg_3_0._btnoverflowitem:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnoverflowitemOnClick(arg_4_0)
	return
end

function var_0_0._btntouchCloseOnClick(arg_5_0)
	return
end

function var_0_0._btnbuyOnClick(arg_6_0)
	CurrencyController.instance:openPowerView()
	arg_6_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshPowerMakerInfo()
	arg_10_0:_ofMakerFlyPower()
end

function var_0_0._refreshPowerMakerInfo(arg_11_0)
	arg_11_0._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if not arg_11_0._ofMakerInfo then
		return
	end

	local var_11_0 = luaLang("PowerMakerPatFaceView_desc_1")
	local var_11_1 = TimeUtil.SecondToActivityTimeFormat(arg_11_0._ofMakerInfo.logoutSecond)

	arg_11_0._txtdesc1.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_0, var_11_1)

	local var_11_2 = luaLang("PowerMakerPatFaceView_desc_2")

	arg_11_0._txtdesc2.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_2, arg_11_0._ofMakerInfo.makeCount)

	local var_11_3 = MaterialEnum.PowerId.OverflowPowerId
	local var_11_4 = ItemPowerModel.instance:getPowerCount(var_11_3)
	local var_11_5 = ItemConfig.instance:getPowerItemCo(var_11_3)
	local var_11_6 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(var_11_3)

	arg_11_0:refreshTxtCount(arg_11_0._txtoverflowcount, var_11_4)
	arg_11_0:refreshTxtEffect(arg_11_0._txtoverfloweffect, var_11_5.effect)
	arg_11_0:refreshDeadLine(arg_11_0._gooverflowdeatline, arg_11_0._txtoverflowtime, arg_11_0._txtoverflowicon, var_11_6, var_11_4)
end

function var_0_0.refreshTxtCount(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1.text = GameUtil.numberDisplay(arg_12_2)
end

function var_0_0.refreshTxtEffect(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		arg_13_2
	})
end

function var_0_0.refreshDeadLine(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if not arg_14_4 or arg_14_4 <= 0 then
		gohelper.setActive(arg_14_1, false)

		return
	end

	if arg_14_5 and arg_14_5 <= 0 then
		gohelper.setActive(arg_14_1, false)

		return
	end

	gohelper.setActive(arg_14_1, true)

	if arg_14_4 <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_3, "#EA6868")

		arg_14_2.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(arg_14_4))
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_3, "#FFFFFF")

		arg_14_2.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(arg_14_4))
	end
end

function var_0_0._ofMakerFlyPower(arg_15_0)
	local var_15_0 = arg_15_0._ofMakerInfo.makeCount

	if var_15_0 <= 0 then
		return
	end

	if not arg_15_0._ofMakerFlyGroup then
		local var_15_1 = gohelper.findChild(arg_15_0.viewGO, "flygroup")

		arg_15_0._ofMakerFlyGroup = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, PowerItemFlyGroup)
	end

	arg_15_0._ofMakerFlyGroup:flyItems(var_15_0)

	arg_15_0._ofMakerInfo.makeCount = 0
end

function var_0_0.onClose(arg_16_0)
	if arg_16_0._ofMakerFlyGroup then
		arg_16_0._ofMakerFlyGroup:cancelTask()
	end
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
