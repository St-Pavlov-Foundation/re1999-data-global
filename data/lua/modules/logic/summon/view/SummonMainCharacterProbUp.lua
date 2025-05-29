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

	local var_14_1, var_14_2, var_14_3 = SummonMainModel.getCostByConfig(var_14_0.cost1)
	local var_14_4 = {
		type = var_14_1,
		id = var_14_2,
		quantity = var_14_3,
		callback = arg_14_0._summon1Confirm,
		callbackObj = arg_14_0
	}

	var_14_4.notEnough = false

	local var_14_5 = var_14_3 <= ItemModel.instance:getItemQuantity(var_14_1, var_14_2)
	local var_14_6 = SummonMainModel.instance.everyCostCount
	local var_14_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_14_5 and var_14_7 < var_14_6 then
		var_14_4.notEnough = true
	end

	if var_14_5 then
		var_14_4.needTransform = false

		arg_14_0:_summon1Confirm()

		return
	else
		var_14_4.needTransform = true
		var_14_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_14_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_14_4.cost_quantity = var_14_6
		var_14_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_14_4)
end

function var_0_0._summon1Confirm(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_15_0.id, 1, false, true)
end

function var_0_0._btnsummon10OnClick(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	local var_16_1, var_16_2, var_16_3 = SummonMainModel.getCostByConfig(var_16_0.cost10)
	local var_16_4 = {
		type = var_16_1,
		id = var_16_2,
		quantity = var_16_3,
		callback = arg_16_0._summon10Confirm,
		callbackObj = arg_16_0
	}

	var_16_4.notEnough = false

	local var_16_5 = ItemModel.instance:getItemQuantity(var_16_1, var_16_2)
	local var_16_6 = var_16_3 <= var_16_5
	local var_16_7 = SummonMainModel.instance.everyCostCount
	local var_16_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_16_9 = 10 - var_16_5
	local var_16_10 = var_16_7 * var_16_9

	if not var_16_6 and var_16_8 < var_16_10 then
		var_16_4.notEnough = true
	end

	if var_16_6 then
		var_16_4.needTransform = false

		arg_16_0:_summon10Confirm()

		return
	else
		var_16_4.needTransform = true
		var_16_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_16_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_16_4.cost_quantity = var_16_10
		var_16_4.miss_quantity = var_16_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_16_4)
end

function var_0_0._summon10Confirm(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_17_0.id, 10, false, true)
end

function var_0_0._onClickDetailByIndex(arg_18_0, arg_18_1)
	if not arg_18_0._characteritems then
		return
	end

	local var_18_0 = arg_18_0._characteritems[arg_18_1]

	if var_18_0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = var_18_0.characterDetailId
		})
	end
end

function var_0_0._refreshView(arg_19_0)
	arg_19_0.summonSuccess = false

	local var_19_0 = SummonMainModel.instance:getList()

	if not var_19_0 or #var_19_0 <= 0 then
		gohelper.setActive(arg_19_0._goui, false)

		return
	end

	arg_19_0:_refreshPoolUI()
	arg_19_0:_refreshTicket()
end

function var_0_0._refreshPoolUI(arg_20_0)
	local var_20_0 = SummonMainModel.instance:getCurPool()

	if not var_20_0 then
		return
	end

	arg_20_0:_refreshCost()
	arg_20_0:showCharacter(var_20_0)
	arg_20_0:refreshFreeSummonButton(var_20_0)
	arg_20_0:_refreshOpenTime()
	arg_20_0:_refreshPreferentialInfo()
end

function var_0_0.refreshFreeSummonButton(arg_21_0, arg_21_1)
	arg_21_0._compFreeButton = arg_21_0._compFreeButton or SummonFreeSingleGacha.New(arg_21_0._btnsummon1.gameObject, arg_21_1.id)

	arg_21_0._compFreeButton:refreshUI()
end

function var_0_0._refreshOpenTime(arg_22_0)
	arg_22_0._txtdeadline.text = ""

	local var_22_0 = SummonMainModel.instance:getCurPool()

	if not var_22_0 then
		return
	end

	local var_22_1 = SummonMainModel.instance:getPoolServerMO(var_22_0.id)

	if not var_22_1 then
		return
	end

	local var_22_2, var_22_3 = var_22_1:onOffTimestamp()

	if var_22_2 < var_22_3 and var_22_3 > 0 then
		local var_22_4 = var_22_3 - ServerTime.now()

		arg_22_0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(var_22_4))
	end
end

function var_0_0._refreshPreferentialInfo(arg_23_0)
	local var_23_0 = SummonMainModel.instance:getCurPool()

	if not var_23_0 then
		return
	end

	local var_23_1 = SummonMainModel.instance:getPoolServerMO(var_23_0.id)
	local var_23_2 = var_23_1.canGetGuaranteeSRCount

	if arg_23_0._gopreferential then
		gohelper.setActive(arg_23_0._gopreferential, var_23_2 > 0)

		if arg_23_0._txtpreferential and var_23_2 > 0 then
			local var_23_3 = var_23_1.guaranteeSRCountDown

			arg_23_0._txtpreferential.text = var_23_3
		end
	end
end

function var_0_0._adLoaded(arg_24_0)
	for iter_24_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_24_0["_simagead" .. iter_24_0]:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function var_0_0.showCharacter(arg_25_0, arg_25_1)
	local var_25_0

	if not string.nilorempty(arg_25_1.characterDetail) then
		var_25_0 = string.split(arg_25_1.characterDetail, "#")
	end

	local var_25_1 = {}

	if var_25_0 ~= nil then
		for iter_25_0 = 1, #var_25_0 do
			local var_25_2 = tonumber(var_25_0[iter_25_0])
			local var_25_3 = SummonConfig.instance:getCharacterDetailConfig(var_25_2)
			local var_25_4 = var_25_3.location
			local var_25_5 = arg_25_0._characteritems[var_25_4]

			if var_25_5 then
				local var_25_6 = var_25_3.heroId
				local var_25_7 = HeroConfig.instance:getHeroCO(var_25_6)

				UISpriteSetMgr.instance:setCommonSprite(var_25_5.imagecareer, "lssx_" .. tostring(var_25_7.career))

				var_25_5.txtnamecn.text = var_25_7.name

				for iter_25_1 = 1, 6 do
					gohelper.setActive(var_25_5.rares[iter_25_1], iter_25_1 <= CharacterEnum.Star[var_25_7.rare])
				end

				var_25_5.characterDetailId = var_25_2

				gohelper.setActive(var_25_5.go, true)

				var_25_1[var_25_4] = true
			end
		end
	end

	for iter_25_2 = 1, #arg_25_0._characteritems do
		gohelper.setActive(arg_25_0._characteritems[iter_25_2].go, var_25_1[iter_25_2])
	end
end

function var_0_0._refreshCost(arg_26_0)
	local var_26_0 = SummonMainModel.instance:getCurPool()

	if var_26_0 then
		arg_26_0:_refreshSingleCost(var_26_0.cost1, arg_26_0._simagecurrency1, "_txtcurrency1")
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

function var_0_0.onSummonFailed(arg_28_0)
	arg_28_0.summonSuccess = false

	arg_28_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_29_0)
	arg_29_0.summonSuccess = true

	arg_29_0:_refreshPreferentialInfo()
end

function var_0_0.onItemChanged(arg_30_0)
	if SummonController.instance.isWaitingSummonResult or arg_30_0.summonSuccess then
		return
	end

	arg_30_0:_refreshCost()
	arg_30_0:_refreshTicket()
end

function var_0_0._refreshTicket(arg_31_0)
	if arg_31_0._txtticket == nil then
		return
	end

	local var_31_0 = SummonMainModel.instance:getCurPool()

	if not var_31_0 then
		return
	end

	local var_31_1 = 0

	if var_31_0.ticketId ~= 0 then
		local var_31_2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_31_0.ticketId)

		arg_31_0._txtticket.text = tostring(var_31_2)
	end

	gohelper.setActive(arg_31_0._goShop, var_31_0.ticketId ~= 0)
end

function var_0_0._btnshopOnClick(arg_32_0)
	local var_32_0 = StoreEnum.StoreId.LimitStore

	StoreController.instance:checkAndOpenStoreView(var_32_0)
end

return var_0_0
