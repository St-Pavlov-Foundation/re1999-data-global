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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._characteritems = {}
	arg_4_0._pageitems = {}
	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:refreshSingleImage()

	arg_4_0._charaterItemCount = arg_4_0._charaterItemCount or var_0_0.DETAIL_COUNT

	for iter_4_0 = 1, arg_4_0._charaterItemCount do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.go = gohelper.findChild(arg_4_0.viewGO, "#go_ui/current/right/#go_characteritem" .. iter_4_0)
		var_4_0.imagecareer = gohelper.findChildImage(var_4_0.go, "image_career")
		var_4_0.txtnamecn = gohelper.findChildText(var_4_0.go, "txt_namecn")
		var_4_0.btndetail = gohelper.findChildButtonWithAudio(var_4_0.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		var_4_0.rares = {}

		for iter_4_1 = 1, 6 do
			local var_4_1 = gohelper.findChild(var_4_0.go, "rare/go_rare" .. iter_4_1)

			table.insert(var_4_0.rares, var_4_1)
		end

		table.insert(arg_4_0._characteritems, var_4_0)
		var_4_0.btndetail:AddClickListener(var_0_0._onClickDetailByIndex, arg_4_0, iter_4_0)
	end

	local var_4_2 = gohelper.findChildText(arg_4_0.viewGO, "#go_ui/summonbtns/summon1/text")
	local var_4_3 = gohelper.findChildText(arg_4_0.viewGO, "#go_ui/summonbtns/summon10/text")

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_4_2.text = string.format(luaLang("p_summon_once"), luaLang("multiple"))
		var_4_3.text = string.format(luaLang("p_summon_tentimes"), luaLang("multiple"))
	else
		var_4_2.text = luaLang("p_summon_once")
		var_4_3.text = luaLang("p_summon_tentimes")
	end
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._compFreeButton then
		arg_5_0._compFreeButton:dispose()

		arg_5_0._compFreeButton = nil
	end

	for iter_5_0 = 1, #arg_5_0._characteritems do
		arg_5_0._characteritems[iter_5_0].btndetail:RemoveClickListener()
	end

	arg_5_0:unloadSingleImage()
end

function var_0_0.refreshSingleImage(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getSummonHeroIcon("full/bg111"))
	arg_6_0._simagefrontbg:LoadImage(ResUrl.getSummonHeroIcon("bg_role_3"))
	arg_6_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	for iter_6_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_6_0["_simagead" .. iter_6_0]:LoadImage(ResUrl.getSummonHeroIcon("role" .. iter_6_0), arg_6_0._adLoaded, arg_6_0)
	end

	arg_6_0._simagesignature1:LoadImage(ResUrl.getSignature("3009"))
end

function var_0_0.unloadSingleImage(arg_7_0)
	for iter_7_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_7_0["_simagead" .. iter_7_0]:UnLoadImage()
	end

	arg_7_0._simagebg:UnLoadImage()
	arg_7_0._simagefrontbg:UnLoadImage()
	arg_7_0._simageline:UnLoadImage()
	arg_7_0._simagesignature1:UnLoadImage()
	arg_7_0._simagecurrency1:UnLoadImage()
	arg_7_0._simagecurrency10:UnLoadImage()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_9_0.onSummonFailed, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_9_0.onSummonReply, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_9_0.playerEnterAnimFromScene, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_9_0._refreshOpenTime, arg_9_0)
	arg_9_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_9_0.onItemChanged, arg_9_0)
	arg_9_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_9_0.onItemChanged, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_9_0._refreshView, arg_9_0)
	arg_9_0:playEnterAnim()
	arg_9_0:_refreshView()
end

function var_0_0.playEnterAnim(arg_10_0)
	if arg_10_0._animRoot then
		if SummonMainModel.instance:getFirstTimeSwitch() then
			SummonMainModel.instance:setFirstTimeSwitch(false)
			arg_10_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
		else
			arg_10_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
		end
	end
end

function var_0_0.playerEnterAnimFromScene(arg_11_0)
	arg_11_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_12_0.onSummonFailed, arg_12_0)
	arg_12_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_12_0.onSummonReply, arg_12_0)
	arg_12_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_12_0.playerEnterAnimFromScene, arg_12_0)
	arg_12_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_12_0._refreshOpenTime, arg_12_0)
	arg_12_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_12_0.onItemChanged, arg_12_0)
	arg_12_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0.onItemChanged, arg_12_0)
	arg_12_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_12_0._refreshView, arg_12_0)
end

function var_0_0._btnsummon1OnClick(arg_13_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_13_0 = SummonMainModel.instance:getCurPool()

	if not var_13_0 then
		return
	end

	local var_13_1, var_13_2, var_13_3 = SummonMainModel.getCostByConfig(var_13_0.cost1)
	local var_13_4 = {
		type = var_13_1,
		id = var_13_2,
		quantity = var_13_3,
		callback = arg_13_0._summon1Confirm,
		callbackObj = arg_13_0
	}

	var_13_4.notEnough = false

	local var_13_5 = var_13_3 <= ItemModel.instance:getItemQuantity(var_13_1, var_13_2)
	local var_13_6 = SummonMainModel.instance.everyCostCount
	local var_13_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_13_5 and var_13_7 < var_13_6 then
		var_13_4.notEnough = true
	end

	if var_13_5 then
		var_13_4.needTransform = false

		arg_13_0:_summon1Confirm()

		return
	else
		var_13_4.needTransform = true
		var_13_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_13_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_13_4.cost_quantity = var_13_6
		var_13_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_13_4)
end

function var_0_0._summon1Confirm(arg_14_0)
	local var_14_0 = SummonMainModel.instance:getCurPool()

	if not var_14_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_14_0.id, 1, false, true)
end

function var_0_0._btnsummon10OnClick(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	local var_15_1, var_15_2, var_15_3 = SummonMainModel.getCostByConfig(var_15_0.cost10)
	local var_15_4 = {
		type = var_15_1,
		id = var_15_2,
		quantity = var_15_3,
		callback = arg_15_0._summon10Confirm,
		callbackObj = arg_15_0
	}

	var_15_4.notEnough = false

	local var_15_5 = ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
	local var_15_6 = var_15_3 <= var_15_5
	local var_15_7 = SummonMainModel.instance.everyCostCount
	local var_15_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_15_9 = 10 - var_15_5
	local var_15_10 = var_15_7 * var_15_9

	if not var_15_6 and var_15_8 < var_15_10 then
		var_15_4.notEnough = true
	end

	if var_15_6 then
		var_15_4.needTransform = false

		arg_15_0:_summon10Confirm()

		return
	else
		var_15_4.needTransform = true
		var_15_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_15_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_15_4.cost_quantity = var_15_10
		var_15_4.miss_quantity = var_15_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_15_4)
end

function var_0_0._summon10Confirm(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_16_0.id, 10, false, true)
end

function var_0_0._onClickDetailByIndex(arg_17_0, arg_17_1)
	if not arg_17_0._characteritems then
		return
	end

	local var_17_0 = arg_17_0._characteritems[arg_17_1]

	if var_17_0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = var_17_0.characterDetailId
		})
	end
end

function var_0_0._refreshView(arg_18_0)
	arg_18_0.summonSuccess = false

	local var_18_0 = SummonMainModel.instance:getList()

	if not var_18_0 or #var_18_0 <= 0 then
		gohelper.setActive(arg_18_0._goui, false)

		return
	end

	arg_18_0:_refreshPoolUI()
end

function var_0_0._refreshPoolUI(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if not var_19_0 then
		return
	end

	arg_19_0:_refreshCost()
	arg_19_0:showCharacter(var_19_0)
	arg_19_0:refreshFreeSummonButton(var_19_0)
	arg_19_0:_refreshOpenTime()
	arg_19_0:_refreshPreferentialInfo()
end

function var_0_0.refreshFreeSummonButton(arg_20_0, arg_20_1)
	arg_20_0._compFreeButton = arg_20_0._compFreeButton or SummonFreeSingleGacha.New(arg_20_0._btnsummon1.gameObject, arg_20_1.id)

	arg_20_0._compFreeButton:refreshUI()
end

function var_0_0._refreshOpenTime(arg_21_0)
	arg_21_0._txtdeadline.text = ""

	local var_21_0 = SummonMainModel.instance:getCurPool()

	if not var_21_0 then
		return
	end

	local var_21_1 = SummonMainModel.instance:getPoolServerMO(var_21_0.id)

	if not var_21_1 then
		return
	end

	local var_21_2, var_21_3 = var_21_1:onOffTimestamp()

	if var_21_2 < var_21_3 and var_21_3 > 0 then
		local var_21_4 = var_21_3 - ServerTime.now()

		arg_21_0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(var_21_4))
	end
end

function var_0_0._refreshPreferentialInfo(arg_22_0)
	local var_22_0 = SummonMainModel.instance:getCurPool()

	if not var_22_0 then
		return
	end

	local var_22_1 = SummonMainModel.instance:getPoolServerMO(var_22_0.id)
	local var_22_2 = var_22_1.canGetGuaranteeSRCount

	if arg_22_0._gopreferential then
		gohelper.setActive(arg_22_0._gopreferential, var_22_2 > 0)

		if arg_22_0._txtpreferential and var_22_2 > 0 then
			local var_22_3 = var_22_1.guaranteeSRCountDown

			arg_22_0._txtpreferential.text = var_22_3
		end
	end
end

function var_0_0._adLoaded(arg_23_0)
	for iter_23_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_23_0["_simagead" .. iter_23_0]:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function var_0_0.showCharacter(arg_24_0, arg_24_1)
	local var_24_0

	if not string.nilorempty(arg_24_1.characterDetail) then
		var_24_0 = string.split(arg_24_1.characterDetail, "#")
	end

	local var_24_1 = {}

	if var_24_0 ~= nil then
		for iter_24_0 = 1, #var_24_0 do
			local var_24_2 = tonumber(var_24_0[iter_24_0])
			local var_24_3 = SummonConfig.instance:getCharacterDetailConfig(var_24_2)
			local var_24_4 = var_24_3.location
			local var_24_5 = arg_24_0._characteritems[var_24_4]

			if var_24_5 then
				local var_24_6 = var_24_3.heroId
				local var_24_7 = HeroConfig.instance:getHeroCO(var_24_6)

				UISpriteSetMgr.instance:setCommonSprite(var_24_5.imagecareer, "lssx_" .. tostring(var_24_7.career))

				var_24_5.txtnamecn.text = var_24_7.name

				for iter_24_1 = 1, 6 do
					gohelper.setActive(var_24_5.rares[iter_24_1], iter_24_1 <= CharacterEnum.Star[var_24_7.rare])
				end

				var_24_5.characterDetailId = var_24_2

				gohelper.setActive(var_24_5.go, true)

				var_24_1[var_24_4] = true
			end
		end
	end

	for iter_24_2 = 1, #arg_24_0._characteritems do
		gohelper.setActive(arg_24_0._characteritems[iter_24_2].go, var_24_1[iter_24_2])
	end
end

function var_0_0._refreshCost(arg_25_0)
	local var_25_0 = SummonMainModel.instance:getCurPool()

	if var_25_0 then
		arg_25_0:_refreshSingleCost(var_25_0.cost1, arg_25_0._simagecurrency1, "_txtcurrency1")
		arg_25_0:_refreshSingleCost(var_25_0.cost10, arg_25_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0, var_26_1, var_26_2 = SummonMainModel.getCostByConfig(arg_26_1)
	local var_26_3 = SummonMainModel.getSummonItemIcon(var_26_0, var_26_1)

	arg_26_2:LoadImage(var_26_3)

	local var_26_4

	var_26_4 = var_26_2 <= ItemModel.instance:getItemQuantity(var_26_0, var_26_1)
	arg_26_0[arg_26_3 .. "1"].text = luaLang("multiple") .. var_26_2
	arg_26_0[arg_26_3 .. "2"].text = ""
end

function var_0_0.onSummonFailed(arg_27_0)
	arg_27_0.summonSuccess = false

	arg_27_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_28_0)
	arg_28_0.summonSuccess = true

	arg_28_0:_refreshPreferentialInfo()
end

function var_0_0.onItemChanged(arg_29_0)
	if SummonController.instance.isWaitingSummonResult or arg_29_0.summonSuccess then
		return
	end

	arg_29_0:_refreshCost()
end

return var_0_0
