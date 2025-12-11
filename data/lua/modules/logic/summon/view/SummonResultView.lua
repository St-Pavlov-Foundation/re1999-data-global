module("modules.logic.summon.view.SummonResultView", package.seeall)

local var_0_0 = class("SummonResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ok")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btnokOnClick(arg_4_0)
	if arg_4_0._cantClose then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goheroitem, false)

	arg_5_0._heroItemTables = {}

	for iter_5_0 = 1, 10 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "herocontent/#go_heroitem" .. iter_5_0)
		var_5_0.txtname = gohelper.findChildText(var_5_0.go, "name")
		var_5_0.txtnameen = gohelper.findChildText(var_5_0.go, "nameen")
		var_5_0.imagerare = gohelper.findChildImage(var_5_0.go, "rare")
		var_5_0.equiprare = gohelper.findChildImage(var_5_0.go, "equiprare")
		var_5_0.imagecareer = gohelper.findChildImage(var_5_0.go, "career")
		var_5_0.imageequipcareer = gohelper.findChildImage(var_5_0.go, "equipcareer")
		var_5_0.goHeroIcon = gohelper.findChild(var_5_0.go, "heroicon")
		var_5_0.simageicon = gohelper.findChildSingleImage(var_5_0.go, "heroicon/icon")
		var_5_0.simageequipicon = gohelper.findChildSingleImage(var_5_0.go, "equipicon")
		var_5_0.imageicon = gohelper.findChildImage(var_5_0.go, "heroicon/icon")
		var_5_0.goeffect = gohelper.findChild(var_5_0.go, "effect")
		var_5_0.btnself = gohelper.findChildButtonWithAudio(var_5_0.go, "btn_self")
		var_5_0.goluckybag = gohelper.findChild(var_5_0.go, "luckybag")
		var_5_0.txtluckybagname = gohelper.findChildText(var_5_0.goluckybag, "name")
		var_5_0.txtluckybagnameen = gohelper.findChildText(var_5_0.goluckybag, "nameen")
		var_5_0.simageluckgbagicon = gohelper.findChildSingleImage(var_5_0.goluckybag, "icon")

		var_5_0.btnself:AddClickListener(arg_5_0.onClickItem, {
			view = arg_5_0,
			index = iter_5_0
		})
		table.insert(arg_5_0._heroItemTables, var_5_0)
	end

	arg_5_0._animation = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation))
	arg_5_0._canvas = gohelper.findChild(arg_5_0.viewGO, "#go_righttop"):GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvas.blocksRaycasts = false

	arg_5_0._animation:PlayQueued("summonresult_loop", UnityEngine.QueueMode.CompleteOthers)

	arg_5_0._cantClose = true
	arg_5_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.9, nil, arg_5_0._tweenFinish, arg_5_0, nil, EaseType.Linear)
	arg_5_0._goBtn = gohelper.findChild(arg_5_0.viewGO, "summonbtns")
	arg_5_0._goSummon1 = gohelper.findChild(arg_5_0.viewGO, "summonbtns/summon1")
	arg_5_0._goSummon10 = gohelper.findChild(arg_5_0.viewGO, "summonbtns/summon10")
	arg_5_0._btnSummon10 = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "summonbtns/summon10/#btn_summon10")
	arg_5_0._simagecurrency10 = gohelper.findChildSingleImage(arg_5_0.viewGO, "summonbtns/summon10/currency/#simage_currency10")
	arg_5_0._txtcurrency101 = gohelper.findChildText(arg_5_0.viewGO, "summonbtns/summon10/currency/#txt_currency10_1")
	arg_5_0._txtcurrency102 = gohelper.findChildText(arg_5_0.viewGO, "summonbtns/summon10/currency/#txt_currency10_2")

	arg_5_0._btnSummon10:AddClickListener(arg_5_0._btnsummon10OnClick, arg_5_0)

	arg_5_0._isReSummon = false
	arg_5_0._canSummon = true
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0 = 1, 10 do
		local var_6_0 = arg_6_0._heroItemTables[iter_6_0]

		if var_6_0 then
			if var_6_0.simageicon then
				var_6_0.simageicon:UnLoadImage()
			end

			if var_6_0.simageequipicon then
				var_6_0.simageequipicon:UnLoadImage()
			end

			if var_6_0.btnself then
				var_6_0.btnself:RemoveClickListener()
			end

			if var_6_0.simageluckgbagicon then
				var_6_0.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)
	end

	arg_6_0._btnSummon10:RemoveClickListener()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_7_0.onSummonReply, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_7_0.onSummonFailed, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	local var_7_0 = arg_7_0.viewParam.summonResultList

	arg_7_0._curPool = arg_7_0:getCurPool()
	arg_7_0._summonResultList = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		table.insert(arg_7_0._summonResultList, iter_7_1)
	end

	if arg_7_0._curPool then
		SummonModel.sortResult(arg_7_0._summonResultList, arg_7_0._curPool.id)
	end

	SummonModel.instance:cacheReward(arg_7_0._summonResultList)
	arg_7_0:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonResultView, arg_7_0._btnokOnClick, arg_7_0)
	arg_7_0:_setSummonBtnActive(true)
	arg_7_0:exReward()
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.onSummonReply, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_8_0.onSummonFailed, arg_8_0)

	if not arg_8_0._isReSummon and not arg_8_0:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function var_0_0.onCloseFinish(arg_9_0)
	PopupController.instance:showPopupView()
end

function var_0_0.onClickItem(arg_10_0)
	local var_10_0 = arg_10_0.view
	local var_10_1 = arg_10_0.index
	local var_10_2 = var_10_0._summonResultList[var_10_1]

	if var_10_2.heroId and var_10_2.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = var_10_2.heroId
		})
	elseif var_10_2.equipId and var_10_2.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = var_10_2.equipId
		})
	elseif var_10_2:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function var_0_0._tweenFinish(arg_11_0)
	arg_11_0._cantClose = false
	arg_11_0._canvas.blocksRaycasts = true
end

function var_0_0._refreshUI(arg_12_0)
	for iter_12_0 = 1, #arg_12_0._summonResultList do
		local var_12_0 = arg_12_0._summonResultList[iter_12_0]

		if var_12_0.heroId and var_12_0.heroId ~= 0 then
			arg_12_0:_refreshHeroItem(arg_12_0._heroItemTables[iter_12_0], var_12_0)
		elseif var_12_0.equipId and var_12_0.equipId ~= 0 then
			arg_12_0:_refreshEquipItem(arg_12_0._heroItemTables[iter_12_0], var_12_0)
		elseif var_12_0:isLuckyBag() then
			arg_12_0:_refreshLuckyBagItem(arg_12_0._heroItemTables[iter_12_0], var_12_0)
		else
			gohelper.setActive(arg_12_0._heroItemTables[iter_12_0].go, false)
		end
	end

	for iter_12_1 = #arg_12_0._summonResultList + 1, #arg_12_0._heroItemTables do
		gohelper.setActive(arg_12_0._heroItemTables[iter_12_1].go, false)
	end

	arg_12_0:_refreshCost()
end

local function var_0_1(arg_13_0)
	if not gohelper.isNil(arg_13_0.imageicon) then
		arg_13_0.imageicon:SetNativeSize()
	end
end

function var_0_0._refreshEquipItem(arg_14_0, arg_14_1, arg_14_2)
	gohelper.setActive(arg_14_1.goHeroIcon, false)
	gohelper.setActive(arg_14_1.simageequipicon.gameObject, true)
	gohelper.setActive(arg_14_1.goluckybag, false)
	gohelper.setActive(arg_14_1.txtname, true)

	local var_14_0 = GameConfig:GetCurLangType() == LangSettings.zh

	gohelper.setActive(arg_14_1.txtnameen, var_14_0)

	local var_14_1 = arg_14_2.equipId
	local var_14_2 = EquipConfig.instance:getEquipCo(var_14_1)

	arg_14_1.txtname.text = var_14_2.name
	arg_14_1.txtnameen.text = var_14_2.name_en

	UISpriteSetMgr.instance:setSummonSprite(arg_14_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_14_2.rare]))
	UISpriteSetMgr.instance:setSummonSprite(arg_14_1.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[var_14_2.rare]))
	gohelper.setActive(arg_14_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_14_1.simageicon.gameObject, false)
	arg_14_1.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(var_14_2.icon), var_0_1, arg_14_1)
	EquipHelper.loadEquipCareerNewIcon(var_14_2, arg_14_1.imageequipcareer, 1, "lssx")
	arg_14_0:_refreshEffect(var_14_2.rare, arg_14_1)
	gohelper.setActive(arg_14_1.go, true)
end

function var_0_0._refreshHeroItem(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setActive(arg_15_1.imageequipcareer.gameObject, false)
	gohelper.setActive(arg_15_1.goHeroIcon, true)
	gohelper.setActive(arg_15_1.goluckybag, false)
	gohelper.setActive(arg_15_1.txtname, true)

	local var_15_0 = GameConfig:GetCurLangType() == LangSettings.zh

	gohelper.setActive(arg_15_1.txtnameen, var_15_0)

	local var_15_1 = arg_15_2.heroId
	local var_15_2 = HeroConfig.instance:getHeroCO(var_15_1)
	local var_15_3 = SkinConfig.instance:getSkinCo(var_15_2.skinId)

	gohelper.setActive(arg_15_1.equiprare.gameObject, false)
	gohelper.setActive(arg_15_1.simageequipicon.gameObject, false)

	arg_15_1.txtname.text = var_15_2.name
	arg_15_1.txtnameen.text = var_15_2.nameEng

	UISpriteSetMgr.instance:setSummonSprite(arg_15_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[var_15_2.rare]))
	UISpriteSetMgr.instance:setCommonSprite(arg_15_1.imagecareer, "lssx_" .. tostring(var_15_2.career))
	arg_15_1.simageicon:LoadImage(ResUrl.getHeadIconMiddle(var_15_3.retangleIcon))

	if arg_15_1.effect then
		gohelper.destroy(arg_15_1.effect)

		arg_15_1.effect = nil
	end

	arg_15_0:_refreshEffect(var_15_2.rare, arg_15_1)
	gohelper.setActive(arg_15_1.go, true)
end

function var_0_0._refreshLuckyBagItem(arg_16_0, arg_16_1, arg_16_2)
	gohelper.setActive(arg_16_1.goluckybag, true)
	gohelper.setActive(arg_16_1.equiprare.gameObject, false)
	gohelper.setActive(arg_16_1.simageequipicon.gameObject, false)
	gohelper.setActive(arg_16_1.imagecareer.gameObject, false)
	gohelper.setActive(arg_16_1.simageicon.gameObject, false)
	gohelper.setActive(arg_16_1.txtname, false)
	gohelper.setActive(arg_16_1.txtnameen, false)

	local var_16_0 = arg_16_2.luckyBagId

	if not arg_16_0._curPool then
		return
	end

	local var_16_1 = SummonConfig.instance:getLuckyBag(arg_16_0._curPool.id, var_16_0)

	arg_16_1.txtluckybagname.text = var_16_1.name
	arg_16_1.txtluckybagnameen.text = var_16_1.nameEn or ""

	arg_16_1.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(var_16_1.icon))
	UISpriteSetMgr.instance:setSummonSprite(arg_16_1.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	arg_16_0:_refreshEffect(SummonEnum.LuckyBagRare, arg_16_1)
	gohelper.setActive(arg_16_1.go, true)
end

function var_0_0._refreshEffect(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0

	if arg_17_1 == 3 then
		var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[1]
	elseif arg_17_1 == 4 then
		var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[2]
	elseif arg_17_1 == 5 then
		var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[3]
	end

	if var_17_0 then
		arg_17_2.effect = arg_17_0.viewContainer:getResInst(var_17_0, arg_17_2.goeffect, "effect")

		arg_17_2.effect:GetComponent(typeof(UnityEngine.Animation)):PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function var_0_0.onUpdateParam(arg_18_0)
	local var_18_0 = arg_18_0.viewParam.summonResultList

	arg_18_0._summonResultList = {}
	arg_18_0._curPool = arg_18_0:getCurPool()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		table.insert(arg_18_0._summonResultList, iter_18_1)
	end

	if arg_18_0._curPool then
		SummonModel.sortResult(arg_18_0._summonResultList, arg_18_0._curPool.id)
	end

	arg_18_0:_refreshUI()
end

function var_0_0.exReward(arg_19_0)
	local var_19_0 = SummonModel.instance:getCacheReward()

	arg_19_0.rewards = SummonModel.getRewardList(var_19_0)

	if arg_19_0._curPool and arg_19_0._curPool.ticketId ~= 0 then
		SummonModel.appendRewardTicket(arg_19_0._summonResultList, arg_19_0.rewards, arg_19_0._curPool.ticketId)
	end
end

function var_0_0._showCommonPropView(arg_20_0)
	if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == 102 then
		return false
	end

	if #arg_20_0.rewards <= 0 then
		return false
	end

	table.sort(arg_20_0.rewards, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_20_0.rewards)
	SummonModel.instance:clearCacheReward()

	return true
end

function var_0_0.getCurPool(arg_21_0)
	return arg_21_0.viewParam.curPool
end

function var_0_0._setSummonBtnActive(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._goBtn, arg_22_1)
	gohelper.setActive(arg_22_0._goSummon1, false)

	local var_22_0 = arg_22_0:getCurPool()
	local var_22_1 = SummonMainModel.instance:getPoolServerMO(var_22_0.id)

	if SummonMainModel.validContinueTenPool(var_22_0.id) then
		gohelper.setActive(arg_22_0._goSummon10, true)
		arg_22_0:_summonTrack("summon10_auto_show")
	else
		gohelper.setActive(arg_22_0._goSummon10, false)
	end
end

function var_0_0._btnsummon10OnClick(arg_23_0)
	if not arg_23_0._canSummon then
		return
	end

	local var_23_0 = arg_23_0:getCurPool()

	if not var_23_0 then
		return
	end

	local var_23_1 = SummonModel.instance:getSummonFullExSkillHero(var_23_0.id)

	if var_23_1 == nil then
		arg_23_0:_btnsummon10OnClick_2()
	else
		local var_23_2 = HeroConfig.instance:getHeroCO(var_23_1).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_23_0.id, arg_23_0._btnsummon10OnClick_2, nil, nil, arg_23_0, nil, nil, var_23_2)
	end

	arg_23_0:_summonTrack("summon10_click")
end

function var_0_0._btnsummon10OnClick_2(arg_24_0)
	local var_24_0 = arg_24_0:getCurPool()

	if not var_24_0 then
		return
	end

	local var_24_1, var_24_2, var_24_3 = SummonMainModel.getCostByConfig(var_24_0.cost10)
	local var_24_4 = {
		type = var_24_1,
		id = var_24_2,
		quantity = var_24_3,
		callback = arg_24_0._summon10Confirm,
		callbackObj = arg_24_0,
		noCallback = arg_24_0._btnokOnClick,
		noCallbackObj = arg_24_0
	}

	var_24_4.notEnough = false

	local var_24_5 = ItemModel.instance:getItemQuantity(var_24_1, var_24_2)
	local var_24_6 = var_24_3 <= var_24_5
	local var_24_7 = SummonMainModel.instance.everyCostCount
	local var_24_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_24_9 = 10 - var_24_5
	local var_24_10 = var_24_7 * var_24_9

	if not var_24_6 and var_24_8 < var_24_10 then
		var_24_4.notEnough = true
	end

	if var_24_6 then
		var_24_4.needTransform = false

		arg_24_0:_summon10Confirm()

		return
	else
		var_24_4.needTransform = true
		var_24_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_24_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_24_4.cost_quantity = var_24_10
		var_24_4.miss_quantity = var_24_9
	end

	SummonMainController.instance:openSummonConfirmView(var_24_4)
	PopupController.instance:endPopupView()
end

function var_0_0._summon10Confirm(arg_25_0)
	local var_25_0 = arg_25_0:getCurPool()

	if not var_25_0 then
		return
	end

	arg_25_0._canSummon = false

	SummonMainController.instance:sendStartSummon(var_25_0.id, 10, false, true)
end

function var_0_0._refreshCost(arg_26_0)
	local var_26_0 = arg_26_0:getCurPool()

	if var_26_0 then
		arg_26_0:_refreshSingleCost(var_26_0.cost10, arg_26_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0, var_27_1, var_27_2 = SummonMainModel.getCostByConfig(arg_27_1)
	local var_27_3 = SummonMainModel.getSummonItemIcon(var_27_0, var_27_1)

	arg_27_2:LoadImage(var_27_3)

	local var_27_4

	var_27_4 = var_27_2 <= ItemModel.instance:getItemQuantity(var_27_0, var_27_1)
	arg_27_0[arg_27_3 .. "1"].text = luaLang("multiple") .. var_27_2
	arg_27_0[arg_27_3 .. "2"].text = ""
end

function var_0_0.onSummonReply(arg_28_0)
	arg_28_0:_summonShowExitAnim()
end

function var_0_0.onSummonFailed(arg_29_0)
	arg_29_0._canSummon = true
end

function var_0_0._summonShowExitAnim(arg_30_0)
	arg_30_0._isReSummon = true
	arg_30_0._canSummon = true

	arg_30_0:closeThis()
end

function var_0_0._summonTrack(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getCurPool()

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.PoolName] = var_31_0 and var_31_0.nameCn or "",
		[StatEnum.EventProperties.ButtonName] = arg_31_1,
		[StatEnum.EventProperties.ViewName] = arg_31_0.viewName
	})
end

return var_0_0
