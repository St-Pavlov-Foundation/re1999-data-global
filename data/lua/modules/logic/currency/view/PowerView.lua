module("modules.logic.currency.view.PowerView", package.seeall)

slot0 = class("PowerView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._txtpower = gohelper.findChildText(slot0.viewGO, "powerGo/#txt_power")
	slot0._txtpowerlimit = gohelper.findChildText(slot0.viewGO, "powerGo/#txt_powerlimit")
	slot0._txtnexttime = gohelper.findChildText(slot0.viewGO, "#txt_nexttime")
	slot0._txttotaltime = gohelper.findChildText(slot0.viewGO, "#txt_totaltime")
	slot0._txtcount1 = gohelper.findChildText(slot0.viewGO, "item1/#txt_count1")
	slot0._txteffectname1 = gohelper.findChildText(slot0.viewGO, "item1/#txt_effectname1")
	slot0._btnuseitem1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "item1/#btn_useitem1")
	slot0._godeadline1 = gohelper.findChild(slot0.viewGO, "item1/#go_deadline1")
	slot0._txtdeadline1 = gohelper.findChildText(slot0.viewGO, "item1/#go_deadline1/#txt_deadline1")
	slot0._imagetimeicon1 = gohelper.findChildImage(slot0.viewGO, "item1/#go_deadline1/#image_timeicon1")
	slot0._btnadd1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "item1/#btn_add")
	slot0._txtcount2 = gohelper.findChildText(slot0.viewGO, "item2/#txt_count2")
	slot0._txteffectname2 = gohelper.findChildText(slot0.viewGO, "item2/#txt_effectname2")
	slot0._btnuseitem2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "item2/#btn_useitem2")
	slot0._godeadline2 = gohelper.findChild(slot0.viewGO, "item2/#go_deadline2")
	slot0._txtdeadline2 = gohelper.findChildText(slot0.viewGO, "item2/#go_deadline2/#txt_deadline2")
	slot0._imagetimeicon2 = gohelper.findChildImage(slot0.viewGO, "item2/#go_deadline2/#image_timeicon2")
	slot0._btnadd2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "item2/#btn_add")
	slot0._actItem = gohelper.findChild(slot0.viewGO, "act_item")
	slot0._txtactcount = gohelper.findChildText(slot0.viewGO, "act_item/#txt_actcount")
	slot0._txtacteffect = gohelper.findChildText(slot0.viewGO, "act_item/#txt_acteffect")
	slot0._btnactitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "act_item/#btn_actitem")
	slot0._goactdeatline = gohelper.findChild(slot0.viewGO, "act_item/#go_actdeadline")
	slot0._txtacttime = gohelper.findChildText(slot0.viewGO, "act_item/#go_actdeadline/#txt_acttime")
	slot0._txtacticon = gohelper.findChildImage(slot0.viewGO, "act_item/#go_actdeadline/#txt_acttime/acttimeicon")
	slot0._txtbuycount = gohelper.findChildText(slot0.viewGO, "buyitem/#txt_buycount")
	slot0._txtbuypower = gohelper.findChildText(slot0.viewGO, "buyitem/#txt_buypower")
	slot0._btnbuyitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "buyitem/#btn_buyitem")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "buyitem/#txt_cost")
	slot0._goaddPowerTip = gohelper.findChild(slot0.viewGO, "#go_addPowerTip")
	slot0._goinventoryLackTip = gohelper.findChild(slot0.viewGO, "#go_inventoryLackTip")
	slot0._simageCostIcon = gohelper.findChildSingleImage(slot0.viewGO, "buyitem/#simage_costicon")
	slot0._buySuccessAnim = gohelper.findChild(slot0.viewGO, "bg/vxeffect/anim"):GetComponent(typeof(UnityEngine.Animator))
	slot0._txtpowervx = gohelper.findChildText(slot0.viewGO, "bg/vxeffect/anim/#txt_powervx")
	slot0._txtpowerlimitvx = gohelper.findChildText(slot0.viewGO, "bg/vxeffect/anim/#txt_powerlimitvx")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnuseitem1:AddClickListener(slot0._btnuseitem1OnClick, slot0)
	slot0._btnuseitem2:AddClickListener(slot0._btnuseitem2OnClick, slot0)
	slot0._btnbuyitem:AddClickListener(slot0._btnbuyitemOnClick, slot0)
	slot0._btnactitem:AddClickListener(slot0._btnactitemOnClick, slot0)
	slot0._btnadd1:AddClickListener(slot0._btnadd1OnClick, slot0)
	slot0._btnadd2:AddClickListener(slot0._btnadd2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnuseitem1:RemoveClickListener()
	slot0._btnuseitem2:RemoveClickListener()
	slot0._btnbuyitem:RemoveClickListener()
	slot0._btnactitem:RemoveClickListener()
	slot0._btnadd1:RemoveClickListener()
	slot0._btnadd2:RemoveClickListener()
end

function slot0._btnactitemOnClick(slot0)
	if slot0._sendingUsePower or slot0._playingBuySuccessEffect or slot0._viewInEffect then
		return
	end

	if ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId) <= 0 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, ResUrl.getPropItemIcon(slot0.actPowerConfig.icon), slot0.actPowerConfig.name)

		return
	end

	if math.floor((CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit - slot0._currencyMO.quantity) / slot0.actPowerEffect) < 1 then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 4)

		return
	end

	ViewMgr.instance:openView(ViewName.PowerActChangeView)
end

function slot0._btnbuyitemOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)

	if slot0._playingBuySuccessEffect or slot0._viewInEffect then
		return
	end

	if CurrencyModel.instance.powerCanBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.MaxBuyTimeId, 3)

		return
	end

	if slot0._maxPowerValue < slot0._currencyMO.quantity + slot0._addBuyRecoverPower then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, 3)

		return
	end

	ViewMgr.instance:openView(ViewName.PowerBuyTipView, {
		index = nil,
		isPowerPotion = false,
		item = nil
	})
end

function slot0._btnuseitem1OnClick(slot0)
	slot0:_usePowerPotion(MaterialEnum.PowerType.Small)
end

function slot0._btnuseitem2OnClick(slot0)
	slot0:_usePowerPotion(MaterialEnum.PowerType.Big)
end

function slot0._btnadd1OnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.SmallPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Small)
end

function slot0._btnadd2OnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.PowerPotion, MaterialEnum.PowerId.BigPower_Expire)
	StoreController.instance:statOnClickPowerPotion(StatEnum.PowerType.Big)
end

function slot0._usePowerPotion(slot0, slot1)
	if slot1 == MaterialEnum.PowerType.Small then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_viability_click_2)
	end

	if slot0._sendingUsePower or slot0._playingBuySuccessEffect or slot0._viewInEffect then
		return
	end

	slot3 = nil

	if not ItemPowerModel.instance:getPowerByType(slot1) or slot2.quantity <= 0 then
		if slot1 == MaterialEnum.PowerType.Small then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, ResUrl.getPropItemIcon("100101"), luaLang("power_item1_name"))
		elseif slot1 == MaterialEnum.PowerType.Big then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, ResUrl.getPropItemIcon("100201"), luaLang("power_item2_name"))
		end

		return
	end

	if slot0._maxPowerValue < slot0._currencyMO.quantity + (slot1 == MaterialEnum.PowerType.Small and slot0.smallPowerConfig or slot0.bigPowerConfig).effect then
		GameFacade.showToast(ToastEnum.MaxPowerLimitId, slot1)

		return
	end

	if slot0.isNeedOpenTip then
		ViewMgr.instance:openView(ViewName.PowerBuyTipView, {
			type = slot1,
			isPowerPotion = true,
			uid = slot2.uid
		})

		return
	end

	slot0._sendingUsePower = true

	ItemRpc.instance:sendUsePowerItemRequest(slot2.uid)
	slot0:_playBuyPowerSuccessEffect()
end

function slot0._btncloseOnClick(slot0)
	if not slot0._playingBuySuccessEffect and not slot0._viewInEffect then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0.smallPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.SmallPower)
	slot0.smallPowerEffect = slot0.smallPowerConfig.effect
	slot0.bigPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.BigPower)
	slot0.bigPowerEffect = slot0.bigPowerConfig.effect
	slot0.actPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.ActPowerId)
	slot0.actPowerEffect = slot0.actPowerConfig.effect
	slot0.showToastId = 0

	slot0._simagebg:LoadImage(ResUrl.getPowerBuyBg("full/tlyuan_tl_001"))

	slot0._currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	slot0._maxPowerValue = slot0._currencyCo.maxLimit
	slot0._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)
	slot0._costParamList = GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId), true)
	slot0._costParam = slot0._costParamList[1]
	slot0._presentParam = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.PowerPresentId), "#")
	slot0._sendingUsePower = false

	slot0:_initEffectList()
	slot0:refreshPowerItem()
	slot0:_refreshPower()
	slot0:_refreshBuyPower()

	slot0._playingBuySuccessEffect = false
	slot0._changePowerTextEffect = false

	gohelper.removeUIClickAudio(slot0._btnuseitem1.gameObject)
	gohelper.removeUIClickAudio(slot0._btnuseitem2.gameObject)
	gohelper.removeUIClickAudio(slot0._btnbuyitem.gameObject)
	TaskDispatcher.runRepeat(slot0._refreshDeadlineTime, slot0, 1)
end

function slot0._refreshDeadlineTime(slot0)
	slot0:refreshPowerItem()
end

function slot0._initEffectList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_power_item.configList) do
		if not slot1[slot6.effect] then
			slot1[slot6.effect] = true
		end
	end

	slot0._powerEffectList = {}

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0._powerEffectList, slot5)
	end

	table.sort(slot0._powerEffectList, function (slot0, slot1)
		return slot0 < slot1
	end)
end

function slot0.refreshPowerItem(slot0)
	slot0:refreshOnePowerItem(MaterialEnum.PowerType.Small)
	slot0:refreshOnePowerItem(MaterialEnum.PowerType.Big)
	slot0:refreshOnePowerItem(MaterialEnum.PowerType.Act)
end

function slot0.refreshOnePowerItem(slot0, slot1)
	slot3 = 0
	slot4 = 0

	if slot1 == MaterialEnum.PowerType.Small then
		slot2 = 0 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.SmallPower)

		slot0:refreshTxtCount(slot0._txtcount1, slot2)
		slot0:refreshTxtEffect(slot0._txteffectname1, slot0.smallPowerEffect)
		slot0:refreshDeadLine(slot0._godeadline1, slot0._txtdeadline1, slot0._imagetimeicon1, ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.SmallPower_Expire), slot2)
	elseif slot1 == MaterialEnum.PowerType.Big then
		slot2 = slot2 + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower_Expire) + ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.BigPower)

		slot0:refreshTxtCount(slot0._txtcount2, slot2)
		slot0:refreshTxtEffect(slot0._txteffectname2, slot0.bigPowerEffect)
		slot0:refreshDeadLine(slot0._godeadline2, slot0._txtdeadline2, slot0._imagetimeicon2, ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.BigPower_Expire), slot2)
	elseif slot1 == MaterialEnum.PowerType.Act then
		slot0:_refreshActPower()
	end
end

function slot0.refreshTxtCount(slot0, slot1, slot2)
	slot1.text = GameUtil.numberDisplay(slot2)
end

function slot0.refreshTxtEffect(slot0, slot1, slot2)
	slot1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerview_addpower"), {
		slot2
	})
end

function slot0.refreshDeadLine(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot4 or slot4 <= 0 then
		gohelper.setActive(slot1, false)

		return
	end

	if slot5 and slot5 <= 0 then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	if slot4 <= TimeUtil.OneDaySecond then
		SLFramework.UGUI.GuiHelper.SetColor(slot3, "#EA6868")

		slot2.text = string.format("<color=#EA6868>%s%s</color>", TimeUtil.secondToRoughTime(slot4))
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot3, "#FFFFFF")

		slot2.text = string.format("<color=#FFFFFF>%s%s</color>", TimeUtil.secondToRoughTime(slot4))
	end
end

function slot0._refreshActPower(slot0)
	slot2 = ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId)

	if ActivityHelper.getActivityStatus(MaterialEnum.ActPowerBindActId) ~= ActivityEnum.ActivityStatus.Normal and slot2 < 1 then
		gohelper.setActive(slot0._actItem, false)

		return
	end

	gohelper.setActive(slot0._actItem, true)
	slot0:refreshTxtCount(slot0._txtactcount, slot2)
	slot0:refreshTxtEffect(slot0._txtacteffect, slot0.actPowerEffect)
	slot0:refreshDeadLine(slot0._goactdeatline, slot0._txtacttime, slot0._txtacticon, ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.ActPowerId), slot2)
end

function slot0._getPowerPotionByIndex(slot0, slot1)
	return slot0._powerPotionList[slot0._powerEffectList[slot1]] and slot3[1]
end

function slot0._refreshPower(slot0)
	slot0._recoverLimit = PlayerConfig.instance:getPlayerLevelCO(PlayerModel.instance:getPlayinfo().level).maxAutoRecoverPower
	slot0._currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	slot0.presentConfig = ItemModel.instance:getItemConfig(slot0._presentParam[1], slot0._presentParam[2])

	TaskDispatcher.runRepeat(slot0._checkPowerRecover, slot0, 1)
	slot0:_checkPowerRecover()
end

function slot0._checkPowerRecover2(slot0)
	slot0:_checkPowerRecover()
	TaskDispatcher.runRepeat(slot0._checkPowerRecover, slot0, 1)
end

function slot0._checkPowerRecover(slot0)
	if slot0._changePowerTextEffect then
		TaskDispatcher.cancelTask(slot0._checkPowerRecover, slot0)

		slot0._changePowerTextEffect = false

		TaskDispatcher.runDelay(slot0._checkPowerRecover2, slot0, 0.85)

		return
	end

	slot0._txtpowerlimit.text = string.format("<size=40>/</size>%s", slot0._recoverLimit)
	slot0._txtpowerlimitvx.text = slot0._txtpowerlimit.text

	if slot0._recoverLimit <= slot0._currencyMO.quantity then
		TaskDispatcher.cancelTask(slot0._checkPowerRecover, slot0)

		slot0._txtpower.text = string.format("<color=#EA6868>%s</color>", slot1)
		slot0._txtpowervx.text = slot0._txtpower.text
		slot0._txtnexttime.text = "--:--:--"
		slot0._txttotaltime.text = "--:--:--"

		return
	else
		slot0._txtpower.text = string.format("<color=#FFFFFF>%s</color>", slot1)
		slot0._txtpowervx.text = slot0._txtpower.text
	end

	slot4 = math.max(slot0._currencyMO.lastRecoverTime / 1000 + slot0._currencyCo.recoverTime - ServerTime.now(), 0)
	slot0._txtnexttime.text = TimeUtil.second2TimeString(slot4, true)
	slot0._txttotaltime.text = TimeUtil.second2TimeString(slot4 + slot0._currencyCo.recoverTime * math.ceil(math.max(0, slot0._recoverLimit - slot1 - slot0._currencyCo.recoverNum) / slot0._currencyCo.recoverNum), true)
end

function slot0._refreshBuyPower(slot0)
	slot0._txtbuycount.text = string.format("%s/%s", CurrencyModel.instance.powerCanBuyCount, slot0._powerMaxBuyCount)
	slot0._costParam = slot0._costParamList[slot0._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

	if slot0._costParam == nil then
		slot0._costParam = slot0._costParamList[#slot0._costParamList]
	end

	slot0._txtcost.text = luaLang("multiple") .. slot0._costParam[3]
	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0._costParam[1], slot0._costParam[2])

	slot0._simageCostIcon:LoadImage(slot2)

	slot0._addBuyRecoverPower = PlayerConfig.instance:getPlayerLevelCO(PlayerModel.instance:getPlayinfo().level).addBuyRecoverPower

	if LangSettings.instance:getCurLangShortcut() == "en" then
		slot0._txtbuypower.text = string.format("+ %s %s", slot4, luaLang("p_mainview_power"))
	else
		slot0._txtbuypower.text = string.format("+%s%s", slot4, luaLang("p_mainview_power"))
	end
end

function slot0.onUpdateParam(slot0)
	slot0.isNeedOpenTip = false

	slot0:updateNeedOpenTipValue()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, slot0._onPowerBuyCountChange, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionFinish, slot0._onUsePowerPotionFinish, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, slot0._onUsePowerPotionListFinish, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.BeforeUsePowerPotionList, slot0._onUsePowerPotionListBefore, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyTipToggleOn, slot0._onSwitchBuyTip, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.PowerBuySuccess, slot0._playBuyPowerSuccessEffect, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.updateNeedOpenTipValue, slot0)
	slot0:updateNeedOpenTipValue()

	slot0._viewInEffect = true

	TaskDispatcher.runDelay(slot0._viewInEffectEnd, slot0, 0.6)
	NavigateMgr.instance:addEscape(ViewName.PowerView, slot0._btncloseOnClick, slot0)
end

function slot0._viewInEffectEnd(slot0)
	slot0._viewInEffect = false
end

function slot0.updateNeedOpenTipValue(slot0)
	slot0.isNeedOpenTip = ServerTime.getServerTimeToday(true) ~= PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey), 0)
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:_refreshPower()
end

function slot0._onSwitchBuyTip(slot0, slot1)
	if slot1 then
		slot0.isNeedOpenTip = false

		slot0:_updateCurrentDayPlayerPrefs()
	end
end

function slot0._updateCurrentDayPlayerPrefs(slot0)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PowerTipsCurrentDayKey), ServerTime.getServerTimeToday(true))
end

function slot0._playBuyPowerSuccessEffect(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Addhuoxing)
	slot0._buySuccessAnim:SetTrigger("buySuccess")

	slot0._changePowerTextEffect = true
end

function slot0._onPowerBuyCountChange(slot0)
	slot0.showToastId = slot0.showToastId + 1

	slot0:_refreshBuyPower()
	GameFacade.showToast(ToastEnum.PowerAddId, slot0._addBuyRecoverPower, slot0.showToastId)

	if slot0.presentConfig then
		GameFacade.showToast(ToastEnum.GetGiftId, slot0.presentConfig.name, slot0._presentParam[3], slot0.showToastId)
	end
end

function slot0._onUsePowerPotionFinish(slot0, slot1)
	slot0.showToastId = slot0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, ItemConfig.instance:getPowerItemCo(ItemPowerModel.instance:getPowerItem(slot1).id).effect, slot0.showToastId)
	slot0:refreshPowerItem()

	slot0._sendingUsePower = false
end

function slot0._onUsePowerPotionListBefore(slot0)
	slot0._sendingUsePower = true

	slot0:_playBuyPowerSuccessEffect()
end

function slot0._onUsePowerPotionListFinish(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot2 = 0 + ItemConfig.instance:getPowerItemCo(ItemPowerModel.instance:getPowerItem(slot7.uid).id).effect * slot7.num
	end

	slot0.showToastId = slot0.showToastId + 1

	GameFacade.showToast(ToastEnum.PowerAddId, slot2, slot0.showToastId)
	slot0:refreshPowerItem()

	slot0._sendingUsePower = false
end

function slot0._onPowerAddTip(slot0, slot1)
	transformhelper.setLocalPosXY(slot0._goaddPowerTip.transform, 782.5, -134)
	gohelper.setActive(slot0._goaddPowerTip, true)

	if slot0.addMoveId then
		ZProj.TweenHelper.KillById(slot0.addMoveId)
	end

	if slot0.addFadeId then
		ZProj.TweenHelper.KillById(slot0.addFadeId)
	end

	GameFacade.showToast(ToastEnum.PowerAddId, slot1)

	slot0.addMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0._goaddPowerTip.transform, -12, 1)
	slot0.addFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._goaddPowerTip, 1, 0, 1.5)
end

function slot0._onPowerLackTip(slot0)
	transformhelper.setLocalPosXY(slot0._goinventoryLackTip.transform, 782.5, -134)
	gohelper.setActive(slot0._goinventoryLackTip, true)

	if slot0.lackMoveId then
		ZProj.TweenHelper.KillById(slot0.lackMoveId)
	end

	if slot0.lackFadeId then
		ZProj.TweenHelper.KillById(slot0.lackFadeId)
	end

	gohelper.findChildText(slot0._goinventoryLackTip, "tiptxt").text = string.format("%s", luaLang("power_lack"))
	slot0.lackMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0._goinventoryLackTip.transform, -12, 1)
	slot0.lackFadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._goinventoryLackTip, 1, 0, 1.5)
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 ~= MaterialEnum.ActPowerBindActId then
		return
	end

	slot0:_refreshActPower()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.PowerBuyCountChange, slot0._onPowerBuyCountChange, slot0)
	TaskDispatcher.cancelTask(slot0._checkPowerRecover, slot0)
	TaskDispatcher.cancelTask(slot0._checkPowerRecover2, slot0)
	TaskDispatcher.cancelTask(slot0._refreshDeadlineTime, slot0)
	TaskDispatcher.cancelTask(slot0._viewInEffectEnd, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.updateNeedOpenTipValue, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	if slot0.clonepowerview then
		gohelper.destroy(slot0.clonepowerview)

		slot0.clonepowerview = nil
	end
end

return slot0
