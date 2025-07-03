module("modules.logic.summon.view.SummonMainCharacterProbUp", package.seeall)

local var_0_0 = class("SummonMainCharacterProbUp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frontbg")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1")
	arg_1_0._simagesignature1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._gopageitem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/pageicon/#go_pageitem")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._txtpreferential = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/first/#txt_times")
	arg_1_0._gopreferential = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/first")

	for iter_1_0 = 1, 3 do
		arg_1_0["_simagead" .. iter_1_0] = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad" .. iter_1_0)
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.DETAIL_COUNT = 1
var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonHeroIcon("full/bg111")
}

for iter_0_0 = 1, var_0_0.SIMAGE_COUNT do
	table.insert(var_0_0.preloadList, ResUrl.getSummonHeroIcon("role" .. iter_0_0))
end

function var_0_0.initCharacterItemCount(arg_4_0)
	local var_4_0 = SummonMainModel.instance:getCurId()
	local var_4_1 = SummonConfig.instance:getSummonPool(var_4_0)
	local var_4_2 = ""

	if var_4_1 then
		var_4_2 = var_4_1.customClz
	end

	arg_4_0._characterItemCount = SummonCharacterProbUpPreloadConfig.getCharacterItemCountByName(var_4_2)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._characteritems = {}
	arg_5_0._pageitems = {}
	arg_5_0._animRoot = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_5_0:refreshSingleImage()
	arg_5_0:initCharacterItemCount()

	for iter_5_0 = 1, arg_5_0._characterItemCount do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "#go_ui/current/right/#go_characteritem" .. iter_5_0)
		var_5_0.imagecareer = gohelper.findChildImage(var_5_0.go, "image_career")
		var_5_0.txtnamecn = gohelper.findChildText(var_5_0.go, "txt_namecn")
		var_5_0.btndetail = gohelper.findChildButtonWithAudio(var_5_0.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		var_5_0.rares = {}

		for iter_5_1 = 1, 6 do
			local var_5_1 = gohelper.findChild(var_5_0.go, "rare/go_rare" .. iter_5_1)

			table.insert(var_5_0.rares, var_5_1)
		end

		table.insert(arg_5_0._characteritems, var_5_0)
		var_5_0.btndetail:AddClickListener(var_0_0._onClickDetailByIndex, arg_5_0, iter_5_0)
	end

	arg_5_0._goShop = gohelper.findChild(arg_5_0.viewGO, "#go_ui/#go_shop")
	arg_5_0._txtticket = gohelper.findChildText(arg_5_0.viewGO, "#go_ui/#go_shop/#txt_num")
	arg_5_0._btnshop = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "#go_ui/#go_shop/#btn_shop")

	if arg_5_0._btnshop then
		arg_5_0._btnshop:AddClickListener(arg_5_0._btnshopOnClick, arg_5_0)
	end

	local var_5_2 = gohelper.findChildText(arg_5_0.viewGO, "#go_ui/summonbtns/summon1/text")
	local var_5_3 = gohelper.findChildText(arg_5_0.viewGO, "#go_ui/summonbtns/summon10/text")

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_5_2.text = string.format(luaLang("p_summon_once"), luaLang("multiple"))
		var_5_3.text = string.format(luaLang("p_summon_tentimes"), luaLang("multiple"))
	else
		var_5_2.text = luaLang("p_summon_once")
		var_5_3.text = luaLang("p_summon_tentimes")
	end
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0._compFreeButton then
		arg_6_0._compFreeButton:dispose()

		arg_6_0._compFreeButton = nil
	end

	for iter_6_0 = 1, #arg_6_0._characteritems do
		arg_6_0._characteritems[iter_6_0].btndetail:RemoveClickListener()
	end

	arg_6_0:unloadSingleImage()

	if arg_6_0._btnshop then
		arg_6_0._btnshop:RemoveClickListener()
	end
end

function var_0_0.refreshSingleImage(arg_7_0)
	arg_7_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_8_0)
	arg_8_0._simageline:UnLoadImage()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_10_0.onSummonFailed, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_10_0.onSummonReply, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_10_0.playerEnterAnimFromScene, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_10_0._refreshOpenTime, arg_10_0)
	arg_10_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0.onItemChanged, arg_10_0)
	arg_10_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_10_0.onItemChanged, arg_10_0)
	arg_10_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_10_0._refreshView, arg_10_0)
	arg_10_0:playEnterAnim()
	arg_10_0:_refreshView()
end

function var_0_0.playEnterAnim(arg_11_0)
	if arg_11_0._animRoot then
		if SummonMainModel.instance:getFirstTimeSwitch() then
			SummonMainModel.instance:setFirstTimeSwitch(false)
			arg_11_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
		else
			arg_11_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
		end
	end
end

function var_0_0.playerEnterAnimFromScene(arg_12_0)
	arg_12_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_13_0.onSummonFailed, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_13_0.onSummonReply, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_13_0.playerEnterAnimFromScene, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_13_0._refreshOpenTime, arg_13_0)
	arg_13_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_13_0.onItemChanged, arg_13_0)
	arg_13_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0.onItemChanged, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_13_0._refreshView, arg_13_0)
end

function var_0_0._btnsummon1OnClick(arg_14_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_14_0 = SummonMainModel.instance:getCurPool()

	if not var_14_0 then
		return
	end

	local var_14_1 = SummonModel.instance:getSummonFullExSkillHero(var_14_0.id)

	if var_14_1 == nil then
		arg_14_0:_btnsummon1OnClick_2()
	else
		local var_14_2 = HeroConfig.instance:getHeroCO(var_14_1).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_14_0.id, arg_14_0._btnsummon1OnClick_2, nil, nil, arg_14_0, nil, nil, var_14_2)
	end
end

function var_0_0._btnsummon1OnClick_2(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	local var_15_1, var_15_2, var_15_3 = SummonMainModel.getCostByConfig(var_15_0.cost1)
	local var_15_4 = {
		type = var_15_1,
		id = var_15_2,
		quantity = var_15_3,
		callback = arg_15_0._summon1Confirm,
		callbackObj = arg_15_0
	}

	var_15_4.notEnough = false

	local var_15_5 = var_15_3 <= ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
	local var_15_6 = SummonMainModel.instance.everyCostCount
	local var_15_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_15_5 and var_15_7 < var_15_6 then
		var_15_4.notEnough = true
	end

	if var_15_5 then
		var_15_4.needTransform = false

		arg_15_0:_summon1Confirm()

		return
	else
		var_15_4.needTransform = true
		var_15_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_15_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_15_4.cost_quantity = var_15_6
		var_15_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_15_4)
end

function var_0_0._summon1Confirm(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_16_0.id, 1, false, true)
end

function var_0_0._btnsummon10OnClick(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	local var_17_1 = SummonModel.instance:getSummonFullExSkillHero(var_17_0.id)

	if var_17_1 == nil then
		arg_17_0:_btnsummon10OnClick_2()
	else
		local var_17_2 = HeroConfig.instance:getHeroCO(var_17_1).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_17_0.id, arg_17_0._btnsummon10OnClick_2, nil, nil, arg_17_0, nil, nil, var_17_2)
	end
end

function var_0_0._btnsummon10OnClick_2(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	local var_18_1, var_18_2, var_18_3 = SummonMainModel.getCostByConfig(var_18_0.cost10)
	local var_18_4 = {
		type = var_18_1,
		id = var_18_2,
		quantity = var_18_3,
		callback = arg_18_0._summon10Confirm,
		callbackObj = arg_18_0
	}

	var_18_4.notEnough = false

	local var_18_5 = ItemModel.instance:getItemQuantity(var_18_1, var_18_2)
	local var_18_6 = var_18_3 <= var_18_5
	local var_18_7 = SummonMainModel.instance.everyCostCount
	local var_18_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_18_9 = 10 - var_18_5
	local var_18_10 = var_18_7 * var_18_9

	if not var_18_6 and var_18_8 < var_18_10 then
		var_18_4.notEnough = true
	end

	if var_18_6 then
		var_18_4.needTransform = false

		arg_18_0:_summon10Confirm()

		return
	else
		var_18_4.needTransform = true
		var_18_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_18_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_18_4.cost_quantity = var_18_10
		var_18_4.miss_quantity = var_18_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_18_4)
end

function var_0_0._summon10Confirm(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if not var_19_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_19_0.id, 10, false, true)
end

function var_0_0._onClickDetailByIndex(arg_20_0, arg_20_1)
	if not arg_20_0._characteritems then
		return
	end

	local var_20_0 = arg_20_0._characteritems[arg_20_1]

	if var_20_0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = var_20_0.characterDetailId
		})
	end
end

function var_0_0._refreshView(arg_21_0)
	arg_21_0.summonSuccess = false

	local var_21_0 = SummonMainModel.instance:getList()

	if not var_21_0 or #var_21_0 <= 0 then
		gohelper.setActive(arg_21_0._goui, false)

		return
	end

	arg_21_0:_refreshPoolUI()
	arg_21_0:_refreshTicket()
end

function var_0_0._refreshPoolUI(arg_22_0)
	local var_22_0 = SummonMainModel.instance:getCurPool()

	if not var_22_0 then
		return
	end

	arg_22_0:_refreshCost()
	arg_22_0:showCharacter(var_22_0)
	arg_22_0:refreshFreeSummonButton(var_22_0)
	arg_22_0:_refreshOpenTime()
	arg_22_0:_refreshPreferentialInfo()
end

function var_0_0.refreshFreeSummonButton(arg_23_0, arg_23_1)
	arg_23_0._compFreeButton = arg_23_0._compFreeButton or SummonFreeSingleGacha.New(arg_23_0._btnsummon1.gameObject, arg_23_1.id)

	arg_23_0._compFreeButton:refreshUI()
end

function var_0_0._refreshOpenTime(arg_24_0)
	arg_24_0._txtdeadline.text = ""

	local var_24_0 = SummonMainModel.instance:getCurPool()

	if not var_24_0 then
		return
	end

	local var_24_1 = SummonMainModel.instance:getPoolServerMO(var_24_0.id)

	if not var_24_1 then
		return
	end

	local var_24_2, var_24_3 = var_24_1:onOffTimestamp()

	if var_24_2 < var_24_3 and var_24_3 > 0 then
		local var_24_4 = var_24_3 - ServerTime.now()

		arg_24_0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(var_24_4))
	end
end

function var_0_0._refreshPreferentialInfo(arg_25_0)
	local var_25_0 = SummonMainModel.instance:getCurPool()

	if not var_25_0 then
		return
	end

	local var_25_1 = SummonMainModel.instance:getPoolServerMO(var_25_0.id)
	local var_25_2 = var_25_1.canGetGuaranteeSRCount

	if arg_25_0._gopreferential then
		gohelper.setActive(arg_25_0._gopreferential, var_25_2 > 0)

		if arg_25_0._txtpreferential and var_25_2 > 0 then
			local var_25_3 = var_25_1.guaranteeSRCountDown

			arg_25_0._txtpreferential.text = var_25_3
		end
	end
end

function var_0_0._adLoaded(arg_26_0)
	for iter_26_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_26_0["_simagead" .. iter_26_0]:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function var_0_0.showCharacter(arg_27_0, arg_27_1)
	local var_27_0

	if not string.nilorempty(arg_27_1.characterDetail) then
		var_27_0 = string.split(arg_27_1.characterDetail, "#")
	end

	local var_27_1 = {}

	if var_27_0 ~= nil then
		for iter_27_0 = 1, #var_27_0 do
			local var_27_2 = tonumber(var_27_0[iter_27_0])
			local var_27_3 = SummonConfig.instance:getCharacterDetailConfig(var_27_2)
			local var_27_4 = var_27_3.location
			local var_27_5 = arg_27_0._characteritems[var_27_4]

			if var_27_5 then
				local var_27_6 = var_27_3.heroId
				local var_27_7 = HeroConfig.instance:getHeroCO(var_27_6)

				UISpriteSetMgr.instance:setCommonSprite(var_27_5.imagecareer, "lssx_" .. tostring(var_27_7.career))

				var_27_5.txtnamecn.text = var_27_7.name

				for iter_27_1 = 1, 6 do
					gohelper.setActive(var_27_5.rares[iter_27_1], iter_27_1 <= CharacterEnum.Star[var_27_7.rare])
				end

				var_27_5.characterDetailId = var_27_2

				gohelper.setActive(var_27_5.go, true)

				var_27_1[var_27_4] = true
			end
		end
	end

	for iter_27_2 = 1, #arg_27_0._characteritems do
		gohelper.setActive(arg_27_0._characteritems[iter_27_2].go, var_27_1[iter_27_2])
	end
end

function var_0_0._refreshCost(arg_28_0)
	local var_28_0 = SummonMainModel.instance:getCurPool()

	if var_28_0 then
		arg_28_0:_refreshSingleCost(var_28_0.cost1, arg_28_0._simagecurrency1, "_txtcurrency1")
		arg_28_0:_refreshSingleCost(var_28_0.cost10, arg_28_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0, var_29_1, var_29_2 = SummonMainModel.getCostByConfig(arg_29_1)
	local var_29_3 = SummonMainModel.getSummonItemIcon(var_29_0, var_29_1)

	arg_29_2:LoadImage(var_29_3)

	local var_29_4

	var_29_4 = var_29_2 <= ItemModel.instance:getItemQuantity(var_29_0, var_29_1)
	arg_29_0[arg_29_3 .. "1"].text = luaLang("multiple") .. var_29_2
	arg_29_0[arg_29_3 .. "2"].text = ""
end

function var_0_0.onSummonFailed(arg_30_0)
	arg_30_0.summonSuccess = false

	arg_30_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_31_0)
	arg_31_0.summonSuccess = true

	arg_31_0:_refreshPreferentialInfo()
end

function var_0_0.onItemChanged(arg_32_0)
	if SummonController.instance.isWaitingSummonResult or arg_32_0.summonSuccess then
		return
	end

	arg_32_0:_refreshCost()
	arg_32_0:_refreshTicket()
end

function var_0_0._refreshTicket(arg_33_0)
	if arg_33_0._txtticket == nil then
		return
	end

	local var_33_0 = SummonMainModel.instance:getCurPool()

	if not var_33_0 then
		return
	end

	local var_33_1 = 0

	if var_33_0.ticketId ~= 0 then
		local var_33_2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_33_0.ticketId)

		arg_33_0._txtticket.text = tostring(var_33_2)
	end

	gohelper.setActive(arg_33_0._goShop, var_33_0.ticketId ~= 0)
end

function var_0_0._btnshopOnClick(arg_34_0)
	local var_34_0 = StoreEnum.StoreId.LimitStore

	StoreController.instance:checkAndOpenStoreView(var_34_0)
end

return var_0_0
