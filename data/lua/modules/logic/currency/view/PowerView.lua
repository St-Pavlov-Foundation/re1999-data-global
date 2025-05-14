module("modules.logic.currency.view.PowerView", package.seeall)

local var_0_0 = class("PowerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "powerGo/#txt_power")
	arg_1_0._txtpowerlimit = gohelper.findChildText(arg_1_0.viewGO, "powerGo/#txt_powerlimit")
	arg_1_0._txtnexttime = gohelper.findChildText(arg_1_0.viewGO, "#txt_nexttime")
	arg_1_0._txttotaltime = gohelper.findChildText(arg_1_0.viewGO, "#txt_totaltime")
	arg_1_0._txtcount1 = gohelper.findChildText(arg_1_0.viewGO, "item1/#txt_count1")
	arg_1_0._txteffectname1 = gohelper.findChildText(arg_1_0.viewGO, "item1/#txt_effectname1")
	arg_1_0._btnuseitem1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item1/#btn_useitem1")
	arg_1_0._godeadline1 = gohelper.findChild(arg_1_0.viewGO, "item1/#go_deadline1")
	arg_1_0._txtdeadline1 = gohelper.findChildText(arg_1_0.viewGO, "item1/#go_deadline1/#txt_deadline1")
	arg_1_0._imagetimeicon1 = gohelper.findChildImage(arg_1_0.viewGO, "item1/#go_deadline1/#image_timeicon1")
	arg_1_0._btnadd1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item1/#btn_add")
	arg_1_0._txtcount2 = gohelper.findChildText(arg_1_0.viewGO, "item2/#txt_count2")
	arg_1_0._txteffectname2 = gohelper.findChildText(arg_1_0.viewGO, "item2/#txt_effectname2")
	arg_1_0._btnuseitem2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item2/#btn_useitem2")
	arg_1_0._godeadline2 = gohelper.findChild(arg_1_0.viewGO, "item2/#go_deadline2")
	arg_1_0._txtdeadline2 = gohelper.findChildText(arg_1_0.viewGO, "item2/#go_deadline2/#txt_deadline2")
	arg_1_0._imagetimeicon2 = gohelper.findChildImage(arg_1_0.viewGO, "item2/#go_deadline2/#image_timeicon2")
	arg_1_0._btnadd2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "item2/#btn_add")
	arg_1_0._actItem = gohelper.findChild(arg_1_0.viewGO, "act_item")
	arg_1_0._txtactcount = gohelper.findChildText(arg_1_0.viewGO, "act_item/#txt_actcount")
	arg_1_0._txtacteffect = gohelper.findChildText(arg_1_0.viewGO, "act_item/#txt_acteffect")
	arg_1_0._btnactitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "act_item/#btn_actitem")
	arg_1_0._goactdeatline = gohelper.findChild(arg_1_0.viewGO, "act_item/#go_actdeadline")
	arg_1_0._txtacttime = gohelper.findChildText(arg_1_0.viewGO, "act_item/#go_actdeadline/#txt_acttime")
	arg_1_0._txtacticon = gohelper.findChildImage(arg_1_0.viewGO, "act_item/#go_actdeadline/#txt_acttime/acttimeicon")
	arg_1_0._txtbuycount = gohelper.findChildText(arg_1_0.viewGO, "buyitem/#txt_buycount")
	arg_1_0._txtbuypower = gohelper.findChildText(arg_1_0.viewGO, "buyitem/#txt_buypower")
	arg_1_0._btnbuyitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "buyitem/#btn_buyitem")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "buyitem/#txt_cost")
	arg_1_0._goaddPowerTip = gohelper.findChild(arg_1_0.viewGO, "#go_addPowerTip")
	arg_1_0._goinventoryLackTip = gohelper.findChild(arg_1_0.viewGO, "#go_inventoryLackTip")
	arg_1_0._simageCostIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "buyitem/#simage_costicon")
	arg_1_0._buySuccessAnim = gohelper.findChild(arg_1_0.viewGO, "bg/vxeffect/anim"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtpowervx = gohelper.findChildText(arg_1_0.viewGO, "bg/vxeffect/anim/#txt_powervx")
	arg_1_0._txtpowerlimitvx = gohelper.findChildText(arg_1_0.viewGO, "bg/vxeffect/anim/#txt_powerlimitvx")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnuseitem1:AddClickListener(arg_2_0._btnuseitem1OnClick, arg_2_0)
	arg_2_0._btnuseitem2:AddClickListener(arg_2_0._btnuseitem2OnClick, arg_2_0)
	arg_2_0._btnbuyitem:AddClickListener(arg_2_0._btnbuyitemOnClick, arg_2_0)
	arg_2_0._btnactitem:AddClickListener(arg_2_0._btnactitemOnClick, arg_2_0)
	arg_2_0._btnadd1:AddClickListener(arg_2_0._btnadd1OnClick, arg_2_0)
	arg_2_0._btnadd2:AddClickListener(arg_2_0._btnadd2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnuseitem1:RemoveClickListener()
	arg_3_0._btnuseitem2:RemoveClickListener()
	arg_3_0._btnbuyitem:RemoveClickListener()
	arg_3_0._btnactitem:RemoveClickListener()
	arg_3_0._btnadd1:RemoveClickListener()
	arg_3_0._btnadd2:RemoveClickListener()
end

function var_0_0._btnactitemOnClick(arg_4_0)
	if arg_4_0._sendingUsePower or arg_4_0._playingBuySuccessEffect or arg_4_0._viewInEffect then
		return
	end

	if ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId) <= 0 then
		local var_4_0 = ResUrl.getPropItemIcon(arg_4_0.actPowerConfig.icon)

		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_4_0, arg_4_0.actPowerConfig.name)

		return
	end

	local var_4_1 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit - arg_4_0._currencyMO.quantity

	if math.floor(var_4_1 / arg_4_0.actPowerEffect) < 1 then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 4)

		return
	end

	ViewMgr.instance:openView(ViewName.PowerActChangeView)
end

function var_0_0._btnbuyitemOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	if arg_5_0._playingBuySuccessEffect or arg_5_0._viewInEffect then
		return
	end

	if CurrencyModel.instance.powerCanBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.MaxBuyTimeId, 3)

		return
	end

	if arg_5_0._currencyMO.quantity + arg_5_0._addBuyRecoverPower > arg_5_0._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	local var_5_0 = {}

	var_5_0.index = nil
	var_5_0.isPowerPotion = false
	var_5_0.item = nil

	ViewMgr.instance:openView(ViewName.PowerBuyTipView, var_5_0)
end

function var_0_0._btnuseitem1OnClick(arg_6_0)
	arg_6_0:_usePowerPotion(MaterialEnum.PowerType.Small)
end

function var_0_0._btnuseitem2OnClick(arg_7_0)
	arg_7_0:_usePowerPotion(MaterialEnum.PowerType.Big)
end

function var_0_0._btnadd1OnClick(arg_8_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.SmallPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Small)
end

function var_0_0._btnadd2OnClick(arg_9_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.BigPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Big)
end

function var_0_0._usePowerPotion(arg_10_0, arg_10_1)
	if arg_10_1 == MaterialEnum.PowerType.Small then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)
	end

	if arg_10_0._sendingUsePower or arg_10_0._playingBuySuccessEffect or arg_10_0._viewInEffect then
		return
	end

	local var_10_0 = ItemPowerModel.instance:getPowerByType(arg_10_1)
	local var_10_1

	if not var_10_0 or var_10_0.quantity <= 0 then
		if arg_10_1 == MaterialEnum.PowerType.Small then
			local var_10_2 = ResUrl.getPropItemIcon("100101")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_10_2, luaLang("power_item1_name"))
		elseif arg_10_1 == MaterialEnum.PowerType.Big then
			local var_10_3 = ResUrl.getPropItemIcon("100201")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_10_3, luaLang("power_item2_name"))
		end

		return
	end

	local var_10_4 = arg_10_1 == MaterialEnum.PowerType.Small and arg_10_0.smallPowerConfig or arg_10_0.bigPowerConfig

	if arg_10_0._currencyMO.quantity + var_10_4.effect > arg_10_0._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, arg_10_1)

		return
	end

	if arg_10_0.isNeedOpenTip then
		local var_10_5 = {
			type = arg_10_1
		}

		var_10_5.isPowerPotion = true
		var_10_5.uid = var_10_0.uid

		ViewMgr.instance:openView(ViewName.PowerBuyTipView, var_10_5)

		return
	end

	arg_10_0._sendingUsePower = true

	ItemRpc.instance:sendUsePowerItemRequest(var_10_0.uid)
	arg_10_0:_playBuyPowerSuccessEffect()
end

function var_0_0._btncloseOnClick(arg_11_0)
	if not arg_11_0._playingBuySuccessEffect and not arg_11_0._viewInEffect then
		arg_11_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.smallPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.SmallPower)
	arg_12_0.smallPowerEffect = arg_12_0.smallPowerConfig.effect
	arg_12_0.bigPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.BigPower)
	arg_12_0.bigPowerEffect = arg_12_0.bigPowerConfig.effect
	arg_12_0.actPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.ActPowerId)
	arg_12_0.actPowerEffect = arg_12_0.actPowerConfig.effect
	arg_12_0.showToastId = 0

	arg_12_0._simagebg:LoadImage(ResUrl.getPowerBuyBg("full/tlyuan_tl_001"))

	arg_12_0._currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	arg_12_0._maxPowerValue = arg_12_0._currencyCo.maxLimit
	arg_12_0._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)

	local var_12_0 = CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId)
	local var_12_1 = CommonConfig.instance:getConstStr(ConstEnum.PowerPresentId)

	arg_12_0._costParamList = GameUtil.splitString2(var_12_0, true)
	arg_12_0._costParam = arg_12_0._costParamList[1]
	arg_12_0._presentParam = string.splitToNumber(var_12_1, "#")
	arg_12_0._sendingUsePower = false

	arg_12_0:_initEffectList()
	arg_12_0:refreshPowerItem()
	arg_12_0:_refreshPower()
	arg_12_0:_refreshBuyPower()

	arg_12_0._playingBuySuccessEffect = false
	arg_12_0._changePowerTextEffect = false

	gohelper.removeUIClickAudio(arg_12_0._btnuseitem1.gameObject)
	gohelper.removeUIClickAudio(arg_12_0._btnuseitem2.gameObject)
	gohelper.removeUIClickAudio(arg_12_0._btnbuyitem.gameObject)
	TaskDispatcher.runRepeat(arg_12_0._refreshDeadlineTime, arg_12_0, 1)
end

function var_0_0._refreshDeadlineTime(arg_13_0)
	arg_13_0:refreshPowerItem()
end

function var_0_0._initEffectList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(lua_power_item.configList) do
		if not var_14_0[iter_14_1.effect] then
			var_14_0[iter_14_1.effect] = true
		end
	end

	arg_14_0._powerEffectList = {}

	for iter_14_2, iter_14_3 in pairs(var_14_0) do
		table.insert(arg_14_0._powerEffectList, iter_14_2)
	end

	table.sort(arg_14_0._powerEffectList, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)
end

function var_0_0.refreshPowerItem(arg_16_0)
	arg_16_0:refreshOnePowerItem(MaterialEnum.PowerType.Small)
	arg_16_0:refreshOnePowerItem(MaterialEnum.PowerType.Big)
	arg_16_0:refreshOnePowerItem(MaterialEnum.PowerType.Act)
end

function var_0_0.refreshOnePowerItem(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = 0
	local var_17_2 = 0

	if arg_17_1 == MaterialEnum.PowerType.Small then
		var_17_0 = var_17_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower_Expire)
		var_17_0 = var_17_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower)

		local var_17_3 = arg_17_0.smallPowerEffect
		local var_17_4 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.SmallPower_Expire)

		arg_17_0:refreshTxtCount(arg_17_0._txtcount1, var_17_0)
		arg_17_0:refreshTxtEffect(arg_17_0._txteffectname1, var_17_3)
		arg_17_0:refreshDeadLine(arg_17_0._godeadline1, arg_17_0._txtdeadline1, arg_17_0._imagetimeicon1, var_17_4, var_17_0)
	elseif arg_17_1 == MaterialEnum.PowerType.Big then
		local var_17_5 = var_17_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower)
		local var_17_6 = arg_17_0.bigPowerEffect
		local var_17_7 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.BigPower_Expire)

		arg_17_0:refreshTxtCount(arg_17_0._txtcount2, var_17_5)
		arg_17_0:refreshTxtEffect(arg_17_0._txteffectname2, var_17_6)
		arg_17_0:refreshDeadLine(arg_17_0._godeadline2, arg_17_0._txtdeadline2, arg_17_0._imagetimeicon2, var_17_7, var_17_5)
	elseif arg_17_1 == MaterialEnum.PowerType.Act then
		arg_17_0:_refreshActPower()
	end
end

function var_0_0.refreshTxtCount(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1.text = GameUtil.numberDisplay(arg_18_2)
end

function var_0_0.refreshTxtEffect(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		arg_19_2
	})
end

function var_0_0.refreshDeadLine(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_4 or arg_20_4 <= 0 then
		gohelper.setActive(arg_20_1, false)

		return
	end

	if arg_20_5 and arg_20_5 <= 0 then
		gohelper.setActive(arg_20_1, false)

		return
	end

	gohelper.setActive(arg_20_1, true)

	if arg_20_4 <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(arg_20_3, "#EA6868")

		arg_20_2.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(arg_20_4))
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_20_3, "#FFFFFF")

		arg_20_2.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(arg_20_4))
	end
end

function var_0_0._refreshActPower(arg_21_0)
	local var_21_0 = MaterialEnum.ActPowerBindActId
	local var_21_1 = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId)

	if ActivityHelper.getActivityStatus(var_21_0) ~= ActivityEnum.ActivityStatus.Normal and var_21_1 < 1 then
		gohelper.setActive(arg_21_0._actItem, false)

		return
	end

	gohelper.setActive(arg_21_0._actItem, true)

	local var_21_2 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.ActPowerId)

	arg_21_0:refreshTxtCount(arg_21_0._txtactcount, var_21_1)
	arg_21_0:refreshTxtEffect(arg_21_0._txtacteffect, arg_21_0.actPowerEffect)
	arg_21_0:refreshDeadLine(arg_21_0._goactdeatline, arg_21_0._txtacttime, arg_21_0._txtacticon, var_21_2, var_21_1)
end

function var_0_0._getPowerPotionByIndex(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._powerEffectList[arg_22_1]
	local var_22_1 = arg_22_0._powerPotionList[var_22_0]

	return var_22_1 and var_22_1[1]
end

function var_0_0._refreshPower(arg_23_0)
	local var_23_0 = PlayerModel.instance:getPlayinfo().level

	arg_23_0._recoverLimit = PlayerConfig.instance:getPlayerLevelCO(var_23_0).maxAutoRecoverPower
	arg_23_0._currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	arg_23_0.presentConfig = ItemModel.instance:getItemConfig(arg_23_0._presentParam[1], arg_23_0._presentParam[2])

	TaskDispatcher.runRepeat(arg_23_0._checkPowerRecover, arg_23_0, 1)
	arg_23_0:_checkPowerRecover()
end

function var_0_0._checkPowerRecover2(arg_24_0)
	arg_24_0:_checkPowerRecover()
	TaskDispatcher.runRepeat(arg_24_0._checkPowerRecover, arg_24_0, 1)
end

function var_0_0._checkPowerRecover(arg_25_0)
	if arg_25_0._changePowerTextEffect then
		TaskDispatcher.cancelTask(arg_25_0._checkPowerRecover, arg_25_0)

		arg_25_0._changePowerTextEffect = false

		TaskDispatcher.runDelay(arg_25_0._checkPowerRecover2, arg_25_0, 0.85)

		return
	end

	local var_25_0 = arg_25_0._currencyMO.quantity

	arg_25_0._txtpowerlimit.text = string.format("<size=40>/</size>%s", arg_25_0._recoverLimit)
	arg_25_0._txtpowerlimitvx.text = arg_25_0._txtpowerlimit.text

	if var_25_0 >= arg_25_0._recoverLimit then
		TaskDispatcher.cancelTask(arg_25_0._checkPowerRecover, arg_25_0)

		arg_25_0._txtpower.text = string.format("<color=#EA6868>%s</color>", var_25_0)
		arg_25_0._txtpowervx.text = arg_25_0._txtpower.text
		arg_25_0._txtnexttime.text = "--:--:--"
		arg_25_0._txttotaltime.text = "--:--:--"

		return
	else
		arg_25_0._txtpower.text = string.format("<color=#FFFFFF>%s</color>", var_25_0)
		arg_25_0._txtpowervx.text = arg_25_0._txtpower.text
	end

	local var_25_1 = arg_25_0._currencyMO.lastRecoverTime / 1000 + arg_25_0._currencyCo.recoverTime
	local var_25_2 = math.max(var_25_1 - ServerTime.now(), 0)
	local var_25_3 = math.max(0, arg_25_0._recoverLimit - var_25_0 - arg_25_0._currencyCo.recoverNum)
	local var_25_4 = var_25_2 + arg_25_0._currencyCo.recoverTime * math.ceil(var_25_3 / arg_25_0._currencyCo.recoverNum)

	arg_25_0._txtnexttime.text = TimeUtil.second2TimeString(var_25_2, true)
	arg_25_0._txttotaltime.text = TimeUtil.second2TimeString(var_25_4, true)
end

function var_0_0._refreshBuyPower(arg_26_0)
	arg_26_0._txtbuycount.text = string.format("%s/%s", CurrencyModel.instance.powerCanBuyCount, arg_26_0._powerMaxBuyCount)
	arg_26_0._costParam = arg_26_0._costParamList[arg_26_0._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

	if arg_26_0._costParam == nil then
		arg_26_0._costParam = arg_26_0._costParamList[#arg_26_0._costParamList]
	end

	arg_26_0._txtcost.text = luaLang("multiple") .. arg_26_0._costParam[3]

	local var_26_0, var_26_1 = ItemModel.instance:getItemConfigAndIcon(arg_26_0._costParam[1], arg_26_0._costParam[2])

	arg_26_0._simageCostIcon:LoadImage(var_26_1)

	local var_26_2 = PlayerModel.instance:getPlayinfo().level
	local var_26_3 = PlayerConfig.instance:getPlayerLevelCO(var_26_2).addBuyRecoverPower

	arg_26_0._addBuyRecoverPower = var_26_3

	if LangSettings.instance:getCurLangShortcut() == "en" then
		arg_26_0._txtbuypower.text = string.format("+ %s %s", var_26_3, luaLang("p_mainview_power"))
	else
		arg_26_0._txtbuypower.text = string.format("+%s%s", var_26_3, luaLang("p_mainview_power"))
	end
end

function var_0_0.onUpdateParam(arg_27_0)
	arg_27_0.isNeedOpenTip = false

	arg_27_0:updateNeedOpenTipValue()
end

function var_0_0.onOpen(arg_28_0)
	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_28_0._onCurrencyChange, arg_28_0)
	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, arg_28_0._onPowerBuyCountChange, arg_28_0)
	arg_28_0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionFinish, arg_28_0._onUsePowerPotionFinish, arg_28_0)
	arg_28_0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, arg_28_0._onUsePowerPotionListFinish, arg_28_0)
	arg_28_0:addEventCb(BackpackController.instance, BackpackEvent.BeforeUsePowerPotionList, arg_28_0._onUsePowerPotionListBefore, arg_28_0)
	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyTipToggleOn, arg_28_0._onSwitchBuyTip, arg_28_0)
	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuySuccess, arg_28_0._playBuyPowerSuccessEffect, arg_28_0)
	arg_28_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_28_0.onRefreshActivity, arg_28_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_28_0.updateNeedOpenTipValue, arg_28_0)
	arg_28_0:updateNeedOpenTipValue()

	arg_28_0._viewInEffect = true

	TaskDispatcher.runDelay(arg_28_0._viewInEffectEnd, arg_28_0, 0.6)
	NavigateMgr.instance:addEscape(ViewName.PowerView, arg_28_0._btncloseOnClick, arg_28_0)
end

function var_0_0._viewInEffectEnd(arg_29_0)
	arg_29_0._viewInEffect = false
end

function var_0_0.updateNeedOpenTipValue(arg_30_0)
	local var_30_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)

	arg_30_0.isNeedOpenTip = ServerTime.getServerTimeToday(true) ~= PlayerPrefsHelper.getNumber(var_30_0, 0)
end

function var_0_0._onCurrencyChange(arg_31_0, arg_31_1)
	if not arg_31_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_31_0:_refreshPower()
end

function var_0_0._onSwitchBuyTip(arg_32_0, arg_32_1)
	if arg_32_1 then
		arg_32_0.isNeedOpenTip = false

		arg_32_0:_updateCurrentDayPlayerPrefs()
	end
end

function var_0_0._updateCurrentDayPlayerPrefs(arg_33_0)
	local var_33_0 = ServerTime.getServerTimeToday(true)
	local var_33_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)

	PlayerPrefsHelper.setNumber(var_33_1, var_33_0)
end

function var_0_0._playBuyPowerSuccessEffect(arg_34_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Addhuoxing)
	arg_34_0._buySuccessAnim:SetTrigger("buySuccess")

	arg_34_0._changePowerTextEffect = true
end

function var_0_0._onPowerBuyCountChange(arg_35_0)
	arg_35_0.showToastId = arg_35_0.showToastId + 1

	arg_35_0:_refreshBuyPower()
	GameFacade.showToast(ToastEnum.PowerAddId, arg_35_0._addBuyRecoverPower, arg_35_0.showToastId)

	if arg_35_0.presentConfig then
		GameFacade.showToast(ToastEnum.GetGiftId, arg_35_0.presentConfig.name, arg_35_0._presentParam[3], arg_35_0.showToastId)
	end
end

function var_0_0._onUsePowerPotionFinish(arg_36_0, arg_36_1)
	local var_36_0 = ItemPowerModel.instance:getPowerItem(arg_36_1)
	local var_36_1 = ItemConfig.instance:getPowerItemCo(var_36_0.id)

	arg_36_0.showToastId = arg_36_0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, var_36_1.effect, arg_36_0.showToastId)
	arg_36_0:refreshPowerItem()

	arg_36_0._sendingUsePower = false
end

function var_0_0._onUsePowerPotionListBefore(arg_37_0)
	arg_37_0._sendingUsePower = true

	arg_37_0:_playBuyPowerSuccessEffect()
end

function var_0_0._onUsePowerPotionListFinish(arg_38_0, arg_38_1)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		local var_38_1 = ItemPowerModel.instance:getPowerItem(iter_38_1.uid)

		var_38_0 = var_38_0 + ItemConfig.instance:getPowerItemCo(var_38_1.id).effect * iter_38_1.num
	end

	arg_38_0.showToastId = arg_38_0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, var_38_0, arg_38_0.showToastId)
	arg_38_0:refreshPowerItem()

	arg_38_0._sendingUsePower = false
end

function var_0_0._onPowerAddTip(arg_39_0, arg_39_1)
	transformhelper.setLocalPosXY(arg_39_0._goaddPowerTip.transform, 782.5, -134)
	gohelper.setActive(arg_39_0._goaddPowerTip, true)

	if arg_39_0.addMoveId then
		ZProj.TweenHelper.KillById(arg_39_0.addMoveId)
	end

	if arg_39_0.addFadeId then
		ZProj.TweenHelper.KillById(arg_39_0.addFadeId)
	end

	GameFacade.showToast(ToastEnum.PowerAddId, arg_39_1)

	arg_39_0.addMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_39_0._goaddPowerTip.transform, -12, 1)
	arg_39_0.addFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_39_0._goaddPowerTip, 1, 0, 1.5)
end

function var_0_0._onPowerLackTip(arg_40_0)
	transformhelper.setLocalPosXY(arg_40_0._goinventoryLackTip.transform, 782.5, -134)
	gohelper.setActive(arg_40_0._goinventoryLackTip, true)

	if arg_40_0.lackMoveId then
		ZProj.TweenHelper.KillById(arg_40_0.lackMoveId)
	end

	if arg_40_0.lackFadeId then
		ZProj.TweenHelper.KillById(arg_40_0.lackFadeId)
	end

	gohelper.findChildText(arg_40_0._goinventoryLackTip, "tiptxt").text = string.format("%s", luaLang("power_lack"))
	arg_40_0.lackMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_40_0._goinventoryLackTip.transform, -12, 1)
	arg_40_0.lackFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_40_0._goinventoryLackTip, 1, 0, 1.5)
end

function var_0_0.onRefreshActivity(arg_41_0, arg_41_1)
	if arg_41_1 ~= MaterialEnum.ActPowerBindActId then
		return
	end

	arg_41_0:_refreshActPower()
end

function var_0_0.onClose(arg_42_0)
	arg_42_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_42_0._onCurrencyChange, arg_42_0)
	arg_42_0:removeEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, arg_42_0._onPowerBuyCountChange, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._checkPowerRecover, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._checkPowerRecover2, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._refreshDeadlineTime, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._viewInEffectEnd, arg_42_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_42_0.updateNeedOpenTipValue, arg_42_0)
end

function var_0_0.onDestroyView(arg_43_0)
	arg_43_0._simagebg:UnLoadImage()

	if arg_43_0.clonepowerview then
		gohelper.destroy(arg_43_0.clonepowerview)

		arg_43_0.clonepowerview = nil
	end
end

return var_0_0
