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
	arg_1_0._overflowItem = gohelper.findChild(arg_1_0.viewGO, "overflowitem")
	arg_1_0._txtoverflowcount = gohelper.findChildText(arg_1_0.viewGO, "overflowitem/#txt_overflowcount")
	arg_1_0._txtoverfloweffect = gohelper.findChildText(arg_1_0.viewGO, "overflowitem/#txt_overfloweffect")
	arg_1_0._btnoverflowitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "overflowitem/#btn_overflowitem")
	arg_1_0._gooverflowdeatline = gohelper.findChild(arg_1_0.viewGO, "overflowitem/#go_overflowdeadline")
	arg_1_0._txtoverflowtime = gohelper.findChildText(arg_1_0.viewGO, "overflowitem/#go_overflowdeadline/#txt_overflowtime")
	arg_1_0._txtoverflowicon = gohelper.findChildImage(arg_1_0.viewGO, "overflowitem/#go_overflowdeadline/#txt_overflowtime/overflowtimeicon")
	arg_1_0._btnoverflowadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "overflowitem/#btn_add")
	arg_1_0._gooverflowmaker = gohelper.findChild(arg_1_0.viewGO, "#go_overflowmaker")
	arg_1_0._btnoverflowmakerInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_overflowmaker/#btn_Info")
	arg_1_0._gomaking = gohelper.findChild(arg_1_0.viewGO, "#go_overflowmaker/#go_making")
	arg_1_0._txtmaketime = gohelper.findChildText(arg_1_0.viewGO, "#go_overflowmaker/#go_making/#txt_maketime")
	arg_1_0._gopause = gohelper.findChild(arg_1_0.viewGO, "#go_overflowmaker/#go_pause")
	arg_1_0._txtpausemaketime = gohelper.findChildText(arg_1_0.viewGO, "#go_overflowmaker/#go_pause/#txt_maketime")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_overflowmaker/#go_empty")

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
	arg_2_0._btnoverflowitem:AddClickListener(arg_2_0._btnoverflowitemOnClick, arg_2_0)
	arg_2_0._btnadd1:AddClickListener(arg_2_0._btnadd1OnClick, arg_2_0)
	arg_2_0._btnadd2:AddClickListener(arg_2_0._btnadd2OnClick, arg_2_0)
	arg_2_0._btnoverflowadd:AddClickListener(arg_2_0._btnoverflowAddOnClick, arg_2_0)
	arg_2_0._btnoverflowmakerInfo:AddClickListener(arg_2_0._btnoverflowmakerOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnuseitem1:RemoveClickListener()
	arg_3_0._btnuseitem2:RemoveClickListener()
	arg_3_0._btnbuyitem:RemoveClickListener()
	arg_3_0._btnactitem:RemoveClickListener()
	arg_3_0._btnoverflowitem:RemoveClickListener()
	arg_3_0._btnadd1:RemoveClickListener()
	arg_3_0._btnadd2:RemoveClickListener()
	arg_3_0._btnoverflowadd:RemoveClickListener()
	arg_3_0._btnoverflowmakerInfo:RemoveClickListener()
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

	ViewMgr.instance:openView(ViewName.PowerActChangeView, {
		PowerId = MaterialEnum.PowerId.ActPowerId
	})
end

function var_0_0._btnoverflowitemOnClick(arg_5_0)
	arg_5_0:_showPowerBuyTipView(MaterialEnum.PowerType.Overflow, MaterialEnum.PowerId.OverflowPowerId)
end

function var_0_0._btnbuyitemOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	if arg_6_0._playingBuySuccessEffect or arg_6_0._viewInEffect then
		return
	end

	if CurrencyModel.instance.powerCanBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.MaxBuyTimeId, 3)

		return
	end

	if arg_6_0._currencyMO.quantity + arg_6_0._addBuyRecoverPower > arg_6_0._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	local var_6_0 = {}

	var_6_0.index = nil
	var_6_0.isPowerPotion = false
	var_6_0.item = nil

	ViewMgr.instance:openView(ViewName.PowerBuyTipView, var_6_0)
end

function var_0_0._btnuseitem1OnClick(arg_7_0)
	arg_7_0:_usePowerPotion(MaterialEnum.PowerType.Small)
end

function var_0_0._btnuseitem2OnClick(arg_8_0)
	arg_8_0:_usePowerPotion(MaterialEnum.PowerType.Big)
end

function var_0_0._btnadd1OnClick(arg_9_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.SmallPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Small)
end

function var_0_0._btnadd2OnClick(arg_10_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.BigPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Big)
end

function var_0_0._btnoverflowAddOnClick(arg_11_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.OverflowPowerId)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Overflow)
end

function var_0_0._usePowerPotion(arg_12_0, arg_12_1)
	if arg_12_1 == MaterialEnum.PowerType.Small then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)
	end

	if arg_12_0._sendingUsePower or arg_12_0._playingBuySuccessEffect or arg_12_0._viewInEffect then
		return
	end

	local var_12_0 = ItemPowerModel.instance:getPowerByType(arg_12_1)
	local var_12_1

	if not var_12_0 or var_12_0.quantity <= 0 then
		if arg_12_1 == MaterialEnum.PowerType.Small then
			local var_12_2 = ResUrl.getPropItemIcon("100101")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_12_2, luaLang("power_item1_name"))
		elseif arg_12_1 == MaterialEnum.PowerType.Big then
			local var_12_3 = ResUrl.getPropItemIcon("100201")

			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_12_3, luaLang("power_item2_name"))
		end

		return
	end

	local var_12_4 = arg_12_1 == MaterialEnum.PowerType.Small and arg_12_0.smallPowerConfig or arg_12_0.bigPowerConfig

	if arg_12_0._currencyMO.quantity + var_12_4.effect > arg_12_0._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, arg_12_1)

		return
	end

	if arg_12_0.isNeedOpenTip then
		local var_12_5 = {
			type = arg_12_1
		}

		var_12_5.isPowerPotion = true
		var_12_5.uid = var_12_0.uid

		ViewMgr.instance:openView(ViewName.PowerBuyTipView, var_12_5)

		return
	end

	arg_12_0._sendingUsePower = true

	ItemRpc.instance:sendUsePowerItemRequest(var_12_0.uid)
	arg_12_0:_playBuyPowerSuccessEffect()
end

function var_0_0._showPowerBuyTipView(arg_13_0, arg_13_1, arg_13_2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	local var_13_0 = ItemPowerModel.instance:getPowerByType(arg_13_1)
	local var_13_1 = ItemConfig.instance:getPowerItemCo(arg_13_2)

	if not var_13_0 or var_13_0.quantity <= 0 then
		local var_13_2 = ResUrl.getPropItemIcon(var_13_1.icon)

		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_13_2, var_13_1.name)

		return
	end

	if arg_13_0._currencyMO.quantity + var_13_1.effect > arg_13_0._maxPowerValue then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	if arg_13_0.isNeedOpenTip then
		local var_13_3 = {
			type = arg_13_1
		}

		var_13_3.isPowerPotion = true
		var_13_3.uid = var_13_0.uid

		ViewMgr.instance:openView(ViewName.PowerBuyTipView, var_13_3)

		return
	end

	arg_13_0._sendingUsePower = true

	ItemRpc.instance:sendUsePowerItemRequest(var_13_0.uid)
	arg_13_0:_playBuyPowerSuccessEffect()
end

function var_0_0._btncloseOnClick(arg_14_0)
	if not arg_14_0._playingBuySuccessEffect and not arg_14_0._viewInEffect then
		arg_14_0:closeThis()
	end
end

function var_0_0._btnoverflowmakerOnClick(arg_15_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, MaterialEnum.PowerMakerItemId)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0.smallPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.SmallPower)
	arg_16_0.smallPowerEffect = arg_16_0.smallPowerConfig.effect
	arg_16_0.bigPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.BigPower)
	arg_16_0.bigPowerEffect = arg_16_0.bigPowerConfig.effect
	arg_16_0.actPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.ActPowerId)
	arg_16_0.actPowerEffect = arg_16_0.actPowerConfig.effect
	arg_16_0.showToastId = 0

	arg_16_0._simagebg:LoadImage(ResUrl.getPowerBuyBg("full/tlyuan_tl_001"))

	arg_16_0._currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	arg_16_0._maxPowerValue = arg_16_0._currencyCo.maxLimit
	arg_16_0._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)

	local var_16_0 = CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId)
	local var_16_1 = CommonConfig.instance:getConstStr(ConstEnum.PowerPresentId)

	arg_16_0._costParamList = GameUtil.splitString2(var_16_0, true)
	arg_16_0._costParam = arg_16_0._costParamList[1]
	arg_16_0._presentParam = string.splitToNumber(var_16_1, "#")
	arg_16_0._sendingUsePower = false

	arg_16_0:_initEffectList()
	arg_16_0:refreshPowerItem()
	arg_16_0:_refreshPower()
	arg_16_0:_refreshBuyPower()
	arg_16_0:_refreshOfMaker()

	arg_16_0._playingBuySuccessEffect = false
	arg_16_0._changePowerTextEffect = false

	gohelper.removeUIClickAudio(arg_16_0._btnuseitem1.gameObject)
	gohelper.removeUIClickAudio(arg_16_0._btnuseitem2.gameObject)
	gohelper.removeUIClickAudio(arg_16_0._btnbuyitem.gameObject)
	TaskDispatcher.runRepeat(arg_16_0._refreshDeadlineTime, arg_16_0, 1)
end

function var_0_0._refreshDeadlineTime(arg_17_0)
	arg_17_0:refreshPowerItem()
end

function var_0_0._initEffectList(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(lua_power_item.configList) do
		if not var_18_0[iter_18_1.effect] then
			var_18_0[iter_18_1.effect] = true
		end
	end

	arg_18_0._powerEffectList = {}

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		table.insert(arg_18_0._powerEffectList, iter_18_2)
	end

	table.sort(arg_18_0._powerEffectList, function(arg_19_0, arg_19_1)
		return arg_19_0 < arg_19_1
	end)
end

function var_0_0.refreshPowerItem(arg_20_0)
	arg_20_0:refreshOnePowerItem(MaterialEnum.PowerType.Small)
	arg_20_0:refreshOnePowerItem(MaterialEnum.PowerType.Big)
	arg_20_0:refreshOnePowerItem(MaterialEnum.PowerType.Act)
	arg_20_0:refreshOnePowerItem(MaterialEnum.PowerType.Overflow)
end

function var_0_0.refreshOnePowerItem(arg_21_0, arg_21_1)
	local var_21_0 = 0
	local var_21_1 = 0
	local var_21_2 = 0

	if arg_21_1 == MaterialEnum.PowerType.Small then
		var_21_0 = var_21_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower_Expire)
		var_21_0 = var_21_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower)

		local var_21_3 = arg_21_0.smallPowerEffect
		local var_21_4 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.SmallPower_Expire)

		arg_21_0:refreshTxtCount(arg_21_0._txtcount1, var_21_0)
		arg_21_0:refreshTxtEffect(arg_21_0._txteffectname1, var_21_3)
		arg_21_0:refreshDeadLine(arg_21_0._godeadline1, arg_21_0._txtdeadline1, arg_21_0._imagetimeicon1, var_21_4, var_21_0)
	elseif arg_21_1 == MaterialEnum.PowerType.Big then
		local var_21_5 = var_21_0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower)
		local var_21_6 = arg_21_0.bigPowerEffect
		local var_21_7 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.BigPower_Expire)

		arg_21_0:refreshTxtCount(arg_21_0._txtcount2, var_21_5)
		arg_21_0:refreshTxtEffect(arg_21_0._txteffectname2, var_21_6)
		arg_21_0:refreshDeadLine(arg_21_0._godeadline2, arg_21_0._txtdeadline2, arg_21_0._imagetimeicon2, var_21_7, var_21_5)
	elseif arg_21_1 == MaterialEnum.PowerType.Act then
		arg_21_0:_refreshActPower()
	elseif arg_21_1 == MaterialEnum.PowerType.Overflow then
		arg_21_0:_refreshOverflow()
	end
end

function var_0_0.refreshTxtCount(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1.text = GameUtil.numberDisplay(arg_22_2)
end

function var_0_0.refreshTxtEffect(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		arg_23_2
	})
end

function var_0_0.refreshDeadLine(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if not arg_24_4 or arg_24_4 <= 0 then
		gohelper.setActive(arg_24_1, false)

		return
	end

	if arg_24_5 and arg_24_5 <= 0 then
		gohelper.setActive(arg_24_1, false)

		return
	end

	gohelper.setActive(arg_24_1, true)

	if arg_24_4 <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(arg_24_3, "#EA6868")

		arg_24_2.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(arg_24_4))
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_24_3, "#FFFFFF")

		arg_24_2.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(arg_24_4))
	end
end

function var_0_0._refreshActPower(arg_25_0)
	local var_25_0 = MaterialEnum.ActPowerBindActId
	local var_25_1 = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId)

	if ActivityHelper.getActivityStatus(var_25_0) ~= ActivityEnum.ActivityStatus.Normal and var_25_1 < 1 then
		gohelper.setActive(arg_25_0._actItem, false)

		return
	end

	gohelper.setActive(arg_25_0._actItem, true)

	local var_25_2 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.ActPowerId)

	arg_25_0:refreshTxtCount(arg_25_0._txtactcount, var_25_1)
	arg_25_0:refreshTxtEffect(arg_25_0._txtacteffect, arg_25_0.actPowerEffect)
	arg_25_0:refreshDeadLine(arg_25_0._goactdeatline, arg_25_0._txtacttime, arg_25_0._txtacticon, var_25_2, var_25_1)
end

function var_0_0._getPowerPotionByIndex(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._powerEffectList[arg_26_1]
	local var_26_1 = arg_26_0._powerPotionList[var_26_0]

	return var_26_1 and var_26_1[1]
end

function var_0_0._refreshPower(arg_27_0)
	local var_27_0 = PlayerModel.instance:getPlayinfo().level

	arg_27_0._recoverLimit = PlayerConfig.instance:getPlayerLevelCO(var_27_0).maxAutoRecoverPower
	arg_27_0._currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	arg_27_0.presentConfig = ItemModel.instance:getItemConfig(arg_27_0._presentParam[1], arg_27_0._presentParam[2])

	TaskDispatcher.runRepeat(arg_27_0._checkPowerRecover, arg_27_0, 1)
	arg_27_0:_checkPowerRecover()
end

function var_0_0._checkPowerRecover2(arg_28_0)
	arg_28_0:_checkPowerRecover()
	TaskDispatcher.runRepeat(arg_28_0._checkPowerRecover, arg_28_0, 1)
end

function var_0_0._checkPowerRecover(arg_29_0)
	if arg_29_0._changePowerTextEffect then
		TaskDispatcher.cancelTask(arg_29_0._checkPowerRecover, arg_29_0)

		arg_29_0._changePowerTextEffect = false

		TaskDispatcher.runDelay(arg_29_0._checkPowerRecover2, arg_29_0, 0.85)

		return
	end

	local var_29_0 = arg_29_0._currencyMO.quantity

	arg_29_0._txtpowerlimit.text = string.format("<size=40>/</size>%s", arg_29_0._recoverLimit)
	arg_29_0._txtpowerlimitvx.text = arg_29_0._txtpowerlimit.text

	if var_29_0 >= arg_29_0._recoverLimit then
		TaskDispatcher.cancelTask(arg_29_0._checkPowerRecover, arg_29_0)

		arg_29_0._txtpower.text = string.format("<color=#EA6868>%s</color>", var_29_0)
		arg_29_0._txtpowervx.text = arg_29_0._txtpower.text
		arg_29_0._txtnexttime.text = "--:--:--"
		arg_29_0._txttotaltime.text = "--:--:--"

		return
	else
		arg_29_0._txtpower.text = string.format("<color=#FFFFFF>%s</color>", var_29_0)
		arg_29_0._txtpowervx.text = arg_29_0._txtpower.text
	end

	local var_29_1 = arg_29_0._currencyMO.lastRecoverTime / 1000 + arg_29_0._currencyCo.recoverTime
	local var_29_2 = math.max(var_29_1 - ServerTime.now(), 0)
	local var_29_3 = math.max(0, arg_29_0._recoverLimit - var_29_0 - arg_29_0._currencyCo.recoverNum)
	local var_29_4 = var_29_2 + arg_29_0._currencyCo.recoverTime * math.ceil(var_29_3 / arg_29_0._currencyCo.recoverNum)

	arg_29_0._txtnexttime.text = TimeUtil.second2TimeString(var_29_2, true)
	arg_29_0._txttotaltime.text = TimeUtil.second2TimeString(var_29_4, true)
end

function var_0_0._refreshBuyPower(arg_30_0)
	arg_30_0._txtbuycount.text = string.format("%s/%s", CurrencyModel.instance.powerCanBuyCount, arg_30_0._powerMaxBuyCount)
	arg_30_0._costParam = arg_30_0._costParamList[arg_30_0._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

	if arg_30_0._costParam == nil then
		arg_30_0._costParam = arg_30_0._costParamList[#arg_30_0._costParamList]
	end

	arg_30_0._txtcost.text = luaLang("multiple") .. arg_30_0._costParam[3]

	local var_30_0, var_30_1 = ItemModel.instance:getItemConfigAndIcon(arg_30_0._costParam[1], arg_30_0._costParam[2])

	arg_30_0._simageCostIcon:LoadImage(var_30_1)

	local var_30_2 = PlayerModel.instance:getPlayinfo().level
	local var_30_3 = PlayerConfig.instance:getPlayerLevelCO(var_30_2).addBuyRecoverPower

	arg_30_0._addBuyRecoverPower = var_30_3

	if LangSettings.instance:getCurLangShortcut() == "en" then
		arg_30_0._txtbuypower.text = string.format("+ %s %s", var_30_3, luaLang("p_mainview_power"))
	else
		arg_30_0._txtbuypower.text = string.format("+%s%s", var_30_3, luaLang("p_mainview_power"))
	end
end

function var_0_0.onUpdateParam(arg_31_0)
	arg_31_0.isNeedOpenTip = false

	arg_31_0:updateNeedOpenTipValue()
end

function var_0_0.onOpen(arg_32_0)
	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_32_0._onCurrencyChange, arg_32_0)
	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, arg_32_0._onPowerBuyCountChange, arg_32_0)
	arg_32_0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionFinish, arg_32_0._onUsePowerPotionFinish, arg_32_0)
	arg_32_0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, arg_32_0._onUsePowerPotionListFinish, arg_32_0)
	arg_32_0:addEventCb(BackpackController.instance, BackpackEvent.BeforeUsePowerPotionList, arg_32_0._onUsePowerPotionListBefore, arg_32_0)
	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyTipToggleOn, arg_32_0._onSwitchBuyTip, arg_32_0)
	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuySuccess, arg_32_0._playBuyPowerSuccessEffect, arg_32_0)
	arg_32_0:addEventCb(CurrencyController.instance, CurrencyEvent.RefreshPowerMakerInfo, arg_32_0._refreshPowerMakerInfo, arg_32_0)
	arg_32_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_32_0.onRefreshActivity, arg_32_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_32_0.updateNeedOpenTipValue, arg_32_0)
	arg_32_0:updateNeedOpenTipValue()

	arg_32_0._viewInEffect = true

	TaskDispatcher.runDelay(arg_32_0._viewInEffectEnd, arg_32_0, 0.6)
	NavigateMgr.instance:addEscape(ViewName.PowerView, arg_32_0._btncloseOnClick, arg_32_0)
	arg_32_0:_initPowerMakerInfo()
end

function var_0_0._viewInEffectEnd(arg_33_0)
	arg_33_0._viewInEffect = false
end

function var_0_0.updateNeedOpenTipValue(arg_34_0)
	local var_34_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)

	arg_34_0.isNeedOpenTip = ServerTime.getServerTimeToday(true) ~= PlayerPrefsHelper.getNumber(var_34_0, 0)
end

function var_0_0._onCurrencyChange(arg_35_0, arg_35_1)
	if not arg_35_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_35_0:_refreshPower()
	arg_35_0:_checkOfMaking()
end

function var_0_0._onSwitchBuyTip(arg_36_0, arg_36_1)
	if arg_36_1 then
		arg_36_0.isNeedOpenTip = false

		arg_36_0:_updateCurrentDayPlayerPrefs()
	end
end

function var_0_0._updateCurrentDayPlayerPrefs(arg_37_0)
	local var_37_0 = ServerTime.getServerTimeToday(true)
	local var_37_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey)

	PlayerPrefsHelper.setNumber(var_37_1, var_37_0)
end

function var_0_0._playBuyPowerSuccessEffect(arg_38_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Addhuoxing)
	arg_38_0._buySuccessAnim:SetTrigger("buySuccess")

	arg_38_0._changePowerTextEffect = true
end

function var_0_0._onPowerBuyCountChange(arg_39_0, arg_39_1)
	arg_39_0.showToastId = arg_39_0.showToastId + 1

	arg_39_0:_refreshBuyPower()

	if arg_39_1 then
		GameFacade.showToast(ToastEnum.PowerAddId, arg_39_0._addBuyRecoverPower, arg_39_0.showToastId)
	end

	if arg_39_0.presentConfig then
		GameFacade.showToast(ToastEnum.GetGiftId, arg_39_0.presentConfig.name, arg_39_0._presentParam[3], arg_39_0.showToastId)
	end
end

function var_0_0._onUsePowerPotionFinish(arg_40_0, arg_40_1)
	local var_40_0 = ItemPowerModel.instance:getPowerItem(arg_40_1)
	local var_40_1 = ItemConfig.instance:getPowerItemCo(var_40_0.id)

	arg_40_0.showToastId = arg_40_0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, var_40_1.effect, arg_40_0.showToastId)
	arg_40_0:refreshPowerItem()

	arg_40_0._sendingUsePower = false

	if var_40_0.id == MaterialEnum.PowerId.OverflowPowerId then
		ItemRpc.instance:sendGetPowerMakerInfoRequest()
	end
end

function var_0_0._onUsePowerPotionListBefore(arg_41_0)
	arg_41_0._sendingUsePower = true

	arg_41_0:_playBuyPowerSuccessEffect()
end

function var_0_0._onUsePowerPotionListFinish(arg_42_0, arg_42_1)
	local var_42_0 = 0

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		local var_42_1 = ItemPowerModel.instance:getPowerItem(iter_42_1.uid)

		var_42_0 = var_42_0 + ItemConfig.instance:getPowerItemCo(var_42_1.id).effect * iter_42_1.num
	end

	arg_42_0.showToastId = arg_42_0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, var_42_0, arg_42_0.showToastId)
	arg_42_0:refreshPowerItem()

	arg_42_0._sendingUsePower = false
end

function var_0_0._onPowerAddTip(arg_43_0, arg_43_1)
	transformhelper.setLocalPosXY(arg_43_0._goaddPowerTip.transform, 782.5, -134)
	gohelper.setActive(arg_43_0._goaddPowerTip, true)

	if arg_43_0.addMoveId then
		ZProj.TweenHelper.KillById(arg_43_0.addMoveId)
	end

	if arg_43_0.addFadeId then
		ZProj.TweenHelper.KillById(arg_43_0.addFadeId)
	end

	GameFacade.showToast(ToastEnum.PowerAddId, arg_43_1)

	arg_43_0.addMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_43_0._goaddPowerTip.transform, -12, 1)
	arg_43_0.addFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_43_0._goaddPowerTip, 1, 0, 1.5)
end

function var_0_0._onPowerLackTip(arg_44_0)
	transformhelper.setLocalPosXY(arg_44_0._goinventoryLackTip.transform, 782.5, -134)
	gohelper.setActive(arg_44_0._goinventoryLackTip, true)

	if arg_44_0.lackMoveId then
		ZProj.TweenHelper.KillById(arg_44_0.lackMoveId)
	end

	if arg_44_0.lackFadeId then
		ZProj.TweenHelper.KillById(arg_44_0.lackFadeId)
	end

	gohelper.findChildText(arg_44_0._goinventoryLackTip, "tiptxt").text = string.format("%s", luaLang("power_lack"))
	arg_44_0.lackMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_44_0._goinventoryLackTip.transform, -12, 1)
	arg_44_0.lackFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_44_0._goinventoryLackTip, 1, 0, 1.5)
end

function var_0_0.onRefreshActivity(arg_45_0, arg_45_1)
	if arg_45_1 ~= MaterialEnum.ActPowerBindActId then
		return
	end

	arg_45_0:_refreshActPower()
end

function var_0_0._initPowerMakerInfo(arg_46_0)
	arg_46_0._lessTimeMaker = 0

	arg_46_0:_powerMakerInfoRequest(true)
end

function var_0_0._powerMakerInfoRequest(arg_47_0, arg_47_1)
	arg_47_0._isShowMakerTime = false

	gohelper.setActive(arg_47_0._gomaking, false)

	if arg_47_0._lessTimeMaker > 1 then
		return
	end

	ItemRpc.instance:sendGetPowerMakerInfoRequest(arg_47_1)
end

function var_0_0._refreshPowerMakerInfo(arg_48_0)
	arg_48_0._isShowMakerTime = true
	arg_48_0._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if not arg_48_0._ofMakerInfo then
		arg_48_0:_powerMakerInfoRequest()

		return
	end

	local var_48_0 = arg_48_0._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Pause

	if arg_48_0._ofMakerInfo.nextRemainSecond <= 0 or var_48_0 then
		arg_48_0._lessTimeMaker = arg_48_0._lessTimeMaker + 1
	else
		arg_48_0._lessTimeMaker = 0
	end

	arg_48_0:_ofMakerFlyPower()
	gohelper.setActive(arg_48_0._gopause, var_48_0)
	gohelper.setActive(arg_48_0._goempty, false)
	gohelper.setActive(arg_48_0._gomaking, not var_48_0)

	local var_48_1 = var_48_0 and "pause" or "click"

	arg_48_0:_playOfMakerAnim(var_48_1)
	arg_48_0:_runRepeatOfMaker()
end

function var_0_0._refreshOverflow(arg_49_0)
	local var_49_0 = MaterialEnum.PowerId.OverflowPowerId

	arg_49_0._ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	local var_49_1 = arg_49_0._ofMakerInfo and arg_49_0._ofMakerInfo.itemTotalCount or ItemPowerModel.instance:getPowerCount(var_49_0)
	local var_49_2 = ItemConfig.instance:getPowerItemCo(var_49_0)
	local var_49_3 = ItemPowerModel.instance:getPowerMinExpireTimeOffset(var_49_0)

	arg_49_0:refreshTxtCount(arg_49_0._txtoverflowcount, var_49_1)
	arg_49_0:refreshTxtEffect(arg_49_0._txtoverfloweffect, var_49_2.effect)
	arg_49_0:refreshDeadLine(arg_49_0._gooverflowdeatline, arg_49_0._txtoverflowtime, arg_49_0._txtoverflowicon, var_49_3, var_49_1)
end

function var_0_0._refreshOfMaker(arg_50_0)
	TaskDispatcher.runRepeat(arg_50_0._runRepeatOfMaker, arg_50_0, 1)
end

function var_0_0._runRepeatOfMaker(arg_51_0)
	if not arg_51_0._isShowMakerTime then
		return
	end

	if not arg_51_0._ofMakerInfo then
		arg_51_0:_powerMakerInfoRequest()

		return
	end

	if arg_51_0._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Pause then
		arg_51_0:_showOFPowerPauseStatus()

		return
	end

	local var_51_0 = arg_51_0._ofMakerInfo.nextRemainSecond - (ServerTime.now() - arg_51_0._ofMakerInfo.nowTime)

	arg_51_0._txtmaketime.text = arg_51_0:_showMakerTime(var_51_0)

	if var_51_0 <= 0 then
		arg_51_0:_powerMakerInfoRequest()
	end
end

function var_0_0._checkOfMaking(arg_52_0)
	if arg_52_0._ofMakerInfo and arg_52_0._ofMakerInfo.status == MaterialEnum.PowerMakerStatus.Making then
		return
	end

	if arg_52_0._currencyMO.quantity >= arg_52_0._recoverLimit then
		arg_52_0:_powerMakerInfoRequest()
	end
end

function var_0_0._showOFPowerPauseStatus(arg_53_0)
	local var_53_0 = arg_53_0._ofMakerInfo.nextRemainSecond

	var_53_0 = var_53_0 <= 0 and MaterialEnum.PowerMakerFixedPauseTime or var_53_0
	arg_53_0._txtpausemaketime.text = arg_53_0:_showMakerTime(var_53_0)
end

function var_0_0._ofMakerFlyPower(arg_54_0)
	local var_54_0 = arg_54_0._ofMakerInfo.makeCount

	if var_54_0 <= 0 then
		return
	end

	if not arg_54_0._ofMakerFlyGroup then
		local var_54_1 = gohelper.findChild(arg_54_0.viewGO, "#go_overflowmaker/flygroup")

		arg_54_0._ofMakerFlyGroup = MonoHelper.addNoUpdateLuaComOnceToGo(var_54_1, PowerItemFlyGroup)
	end

	arg_54_0._ofMakerFlyGroup:flyItems(var_54_0)

	arg_54_0._ofMakerInfo.makeCount = 0
end

function var_0_0._showMakerTime(arg_55_0, arg_55_1)
	return arg_55_1 > 0 and TimeUtil.second2TimeString(arg_55_1, true) or ""
end

function var_0_0._playOfMakerAnim(arg_56_0, arg_56_1)
	if not arg_56_0._anioverflowmaker then
		arg_56_0._anioverflowmaker = arg_56_0._gooverflowmaker:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_56_0._anioverflowmaker:Play(arg_56_1, 0, 0)
end

function var_0_0.onClose(arg_57_0)
	arg_57_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_57_0._onCurrencyChange, arg_57_0)
	arg_57_0:removeEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, arg_57_0._onPowerBuyCountChange, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._checkPowerRecover, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._checkPowerRecover2, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._refreshDeadlineTime, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._runRepeatOfMaker, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._viewInEffectEnd, arg_57_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_57_0.updateNeedOpenTipValue, arg_57_0)

	if arg_57_0._ofMakerFlyGroup then
		arg_57_0._ofMakerFlyGroup:cancelTask()
	end
end

function var_0_0.onDestroyView(arg_58_0)
	arg_58_0._simagebg:UnLoadImage()

	if arg_58_0.clonepowerview then
		gohelper.destroy(arg_58_0.clonepowerview)

		arg_58_0.clonepowerview = nil
	end
end

return var_0_0
