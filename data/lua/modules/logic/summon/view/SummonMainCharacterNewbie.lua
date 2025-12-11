module("modules.logic.summon.view.SummonMainCharacterNewbie", package.seeall)

local var_0_0 = class("SummonMainCharacterNewbie", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1")
	arg_1_0._simagesignature1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	arg_1_0._gocharacteritem2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem2")
	arg_1_0._simagesignature2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem2/#simage_signature2")
	arg_1_0._gocharacteritem3 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem3")
	arg_1_0._simagesignature3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem3/#simage_signature3")
	arg_1_0._txtsummonnum = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/count/#txt_summonnum")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#simage_line")
	arg_1_0._simagetips1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/tips/#simage_tips1")
	arg_1_0._simagetips2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/tips/#simage_tips2")
	arg_1_0._simagetips3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/tips/#simage_tips3")

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

var_0_0.showHeroNum = 3
var_0_0.heroId = {
	"3025",
	"3051",
	"3004"
}
var_0_0.preloadList = {
	ResUrl.getSummonHeroIcon("full/bg000")
}

if var_0_0.heroId ~= nil then
	for iter_0_0 = 1, #var_0_0.heroId do
		local var_0_1 = var_0_0.heroId[iter_0_0]

		table.insert(var_0_0.preloadList, ResUrl.getSummonHeroIcon(var_0_1))
	end
end

function var_0_0.onUpdateParam(arg_4_0)
	arg_4_0:_refreshView()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_5_0.onSummonFailed, arg_5_0)
	arg_5_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_5_0.onSummonReply, arg_5_0)
	arg_5_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_5_0.playerEnterAnimFromScene, arg_5_0)
	arg_5_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_5_0.onItemChanged, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0.onItemChanged, arg_5_0)
	arg_5_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_5_0._refreshView, arg_5_0)
	arg_5_0:playEnterAnim()
	arg_5_0:_refreshView()
end

function var_0_0.playEnterAnim(arg_6_0)
	logNormal("playEnterAnim")

	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_6_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_6_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_7_0)
	logNormal("playerEnterAnimFromScene")
	arg_7_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_8_0.onSummonFailed, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.onSummonReply, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_8_0.playerEnterAnimFromScene, arg_8_0)
	arg_8_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_8_0.onItemChanged, arg_8_0)
	arg_8_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.onItemChanged, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_8_0._refreshView, arg_8_0)
end

function var_0_0._btnsummon1OnClick(arg_9_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_9_0 = SummonMainModel.instance:getCurPool()

	if not var_9_0 then
		return
	end

	local var_9_1, var_9_2, var_9_3 = SummonMainModel.getCostByConfig(var_9_0.cost1)
	local var_9_4 = {
		type = var_9_1,
		id = var_9_2,
		quantity = var_9_3,
		callback = arg_9_0._summon1Confirm,
		callbackObj = arg_9_0
	}

	var_9_4.notEnough = false

	local var_9_5 = var_9_3 <= ItemModel.instance:getItemQuantity(var_9_1, var_9_2)
	local var_9_6 = SummonMainModel.instance.everyCostCount
	local var_9_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_9_5 and var_9_7 < var_9_6 then
		var_9_4.notEnough = true
	end

	if var_9_5 then
		var_9_4.needTransform = false

		arg_9_0:_summon1Confirm()

		return
	else
		var_9_4.needTransform = true
		var_9_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_9_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_9_4.cost_quantity = var_9_6
		var_9_4.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(var_9_4)
end

function var_0_0._summon1Confirm(arg_10_0)
	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_10_0.id, 1, false, true)
end

function var_0_0._btnsummon10OnClick(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getCurPool()

	if not var_11_0 then
		return
	end

	local var_11_1, var_11_2, var_11_3, var_11_4 = SummonMainModel.getCostByConfig(var_11_0.cost10)
	local var_11_5 = 10
	local var_11_6 = {
		type = var_11_1,
		id = var_11_2,
		quantity = var_11_3,
		callback = arg_11_0._summon10Confirm,
		callbackObj = arg_11_0
	}

	var_11_6.notEnough = false
	var_11_4 = var_11_4 or ItemModel.instance:getItemQuantity(var_11_1, var_11_2)

	local var_11_7 = var_11_3 <= var_11_4
	local var_11_8 = SummonMainModel.instance.everyCostCount
	local var_11_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_11_10 = var_11_5 - var_11_4
	local var_11_11 = var_11_8 * var_11_10

	var_11_6.gachaTimes = var_11_5

	if not var_11_7 and var_11_9 < var_11_11 then
		var_11_6.notEnough = true
	end

	if var_11_7 then
		var_11_6.needTransform = false

		arg_11_0:_summon10Confirm(var_11_6)

		return
	else
		var_11_6.needTransform = true
		var_11_6.cost_type = SummonMainModel.instance.costCurrencyType
		var_11_6.cost_id = SummonMainModel.instance.costCurrencyId
		var_11_6.cost_quantity = var_11_11
		var_11_6.miss_quantity = var_11_10
	end

	SummonMainController.instance:openSummonConfirmView(var_11_6)
end

function var_0_0._summon10Confirm(arg_12_0, arg_12_1)
	local var_12_0 = SummonMainModel.instance:getCurPool()

	if not var_12_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_12_0.id, 10, false, true)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._characteritems = {}
	arg_13_0._pageitems = {}
	arg_13_0._animRoot = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_13_0._simagebg:LoadImage(ResUrl.getSummonHeroIcon("full/bg000"))
	arg_13_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
	arg_13_0._simagetips1:LoadImage(ResUrl.getSummonHeroIcon("title_bg_black"))
	arg_13_0._simagetips2:LoadImage(ResUrl.getSummonHeroIcon("title"))
	arg_13_0._simagetips3:LoadImage(ResUrl.getSummonHeroIcon("title_bg_orange"))

	arg_13_0._goSummon1 = gohelper.findChild(arg_13_0.viewGO, "#go_ui/summonbtns/summon1")
	arg_13_0._txtGacha10 = gohelper.findChildText(arg_13_0.viewGO, "#go_ui/summonbtns/summon10/text")

	for iter_13_0 = 1, var_0_0.showHeroNum do
		arg_13_0["_simagead" .. iter_13_0] = gohelper.findChildSingleImage(arg_13_0.viewGO, "#go_ui/current/simage_ad" .. iter_13_0)

		local var_13_0 = arg_13_0:getUserDataTb_()

		var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "#go_ui/current/right/#go_characteritem" .. iter_13_0)
		var_13_0.imagecareer = gohelper.findChildImage(var_13_0.go, "image_career")
		var_13_0.txtnamecn = gohelper.findChildText(var_13_0.go, "txt_namecn")
		var_13_0.btndetail = gohelper.findChildButtonWithAudio(var_13_0.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		var_13_0.rares = {}

		for iter_13_1 = 1, 6 do
			local var_13_1 = gohelper.findChild(var_13_0.go, "rare/go_rare" .. iter_13_1)

			table.insert(var_13_0.rares, var_13_1)
		end

		table.insert(arg_13_0._characteritems, var_13_0)
		var_13_0.btndetail:AddClickListener(var_0_0._onClickDetailByIndex, arg_13_0, iter_13_0)
	end

	local var_13_2 = gohelper.findChildText(arg_13_0.viewGO, "#go_ui/summonbtns/summon1/text")
	local var_13_3 = gohelper.findChildText(arg_13_0.viewGO, "#go_ui/summonbtns/summon10/text")

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_13_2.text = string.format(luaLang("p_summon_once"), luaLang("multiple"))
		var_13_3.text = string.format(luaLang("p_summon_tentimes"), luaLang("multiple"))
	else
		var_13_2.text = luaLang("p_summon_once")
		var_13_3.text = luaLang("p_summon_tentimes")
	end
end

function var_0_0._onClickDetailByIndex(arg_14_0, arg_14_1)
	if not arg_14_0._characteritems then
		return
	end

	local var_14_0 = arg_14_0._characteritems[arg_14_1]

	if var_14_0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = var_14_0.characterDetailId
		})
	end
end

function var_0_0._refreshView(arg_15_0)
	arg_15_0.summonSuccess = false

	local var_15_0 = SummonMainModel.instance:getList()

	if not var_15_0 or #var_15_0 <= 0 then
		gohelper.setActive(arg_15_0._goui, false)

		return
	end

	arg_15_0:_refreshPoolUI()
end

function var_0_0._refreshPoolUI(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	arg_16_0:_refreshCost()

	local var_16_1 = SummonConfig.getSummonSSRTimes(var_16_0) or "-"
	local var_16_2 = SummonMainModel.instance:getNewbieProgress() or "-"

	arg_16_0._txtsummonnum.text = string.format("%s/%s", var_16_2, var_16_1)

	arg_16_0:showSummonPool(var_16_0)
end

function var_0_0.refreshFreeSummonButton(arg_17_0, arg_17_1)
	arg_17_0._compFreeButton = arg_17_0._compFreeButton or SummonFreeSingleGacha.New(arg_17_0._btnsummon1.gameObject, arg_17_1.id)

	arg_17_0._compFreeButton:refreshUI()
end

function var_0_0.showSummonPool(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.heroId

	for iter_18_0 = 1, var_0_0.showHeroNum do
		arg_18_0["_simagead" .. iter_18_0]:LoadImage(ResUrl.getSummonHeroIcon(var_18_0[iter_18_0]), arg_18_0._adLoaded, {
			view = arg_18_0,
			simage = arg_18_0["_simagead" .. iter_18_0]
		})
	end

	arg_18_0._simagesignature1:LoadImage(ResUrl.getSignature(var_18_0[1]))
	arg_18_0._simagesignature2:LoadImage(ResUrl.getSignature(var_18_0[2]))
	arg_18_0._simagesignature3:LoadImage(ResUrl.getSignature(var_18_0[3]))
	arg_18_0:showCharacter(arg_18_1)
end

function var_0_0._adLoaded(arg_19_0)
	local var_19_0 = arg_19_0.view
	local var_19_1 = arg_19_0.simage

	if gohelper.isNil(var_19_1) then
		return
	end

	var_19_1:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
end

function var_0_0.showCharacter(arg_20_0, arg_20_1)
	local var_20_0

	if not string.nilorempty(arg_20_1.characterDetail) then
		var_20_0 = string.split(arg_20_1.characterDetail, "#")
	end

	local var_20_1 = {}

	if var_20_0 then
		for iter_20_0 = 1, #var_20_0 do
			local var_20_2 = tonumber(var_20_0[iter_20_0])
			local var_20_3 = SummonConfig.instance:getCharacterDetailConfig(var_20_2)
			local var_20_4 = var_20_3.location
			local var_20_5 = arg_20_0._characteritems[var_20_4]

			if var_20_5 then
				local var_20_6 = var_20_3.heroId
				local var_20_7 = HeroConfig.instance:getHeroCO(var_20_6)

				UISpriteSetMgr.instance:setCommonSprite(var_20_5.imagecareer, "lssx_" .. tostring(var_20_7.career))

				var_20_5.txtnamecn.text = var_20_7.name

				for iter_20_1 = 1, 6 do
					gohelper.setActive(var_20_5.rares[iter_20_1], iter_20_1 <= CharacterEnum.Star[var_20_7.rare])
				end

				var_20_5.characterDetailId = var_20_2

				gohelper.setActive(var_20_5.go, true)

				var_20_1[var_20_4] = true
			end
		end
	end

	for iter_20_2 = 1, #arg_20_0._characteritems do
		gohelper.setActive(arg_20_0._characteritems[iter_20_2].go, var_20_1[iter_20_2])
	end
end

function var_0_0._refreshCost(arg_21_0)
	local var_21_0 = SummonMainModel.instance:getCurPool()

	if var_21_0 then
		arg_21_0:_refreshSingleCost(var_21_0.cost1, arg_21_0._simagecurrency1, "_txtcurrency1")
		arg_21_0:_refreshSingleCost(var_21_0.cost10, arg_21_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1, var_22_2 = SummonMainModel.getCostByConfig(arg_22_1, true)
	local var_22_3 = SummonMainModel.getSummonItemIcon(var_22_0, var_22_1)

	arg_22_2:LoadImage(var_22_3)

	local var_22_4

	var_22_4 = var_22_2 <= ItemModel.instance:getItemQuantity(var_22_0, var_22_1)
	arg_22_0[arg_22_3 .. "1"].text = luaLang("multiple") .. var_22_2
	arg_22_0[arg_22_3 .. "2"].text = ""
end

function var_0_0.onSummonFailed(arg_23_0)
	arg_23_0.summonSuccess = false

	arg_23_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_24_0)
	arg_24_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_25_0)
	if SummonController.instance.isWaitingSummonResult or arg_25_0.summonSuccess then
		return
	end

	arg_25_0:_refreshCost()
end

function var_0_0.onDestroyView(arg_26_0)
	if arg_26_0._compFreeButton then
		arg_26_0._compFreeButton:dispose()

		arg_26_0._compFreeButton = nil
	end

	for iter_26_0 = 1, #arg_26_0._characteritems do
		arg_26_0._characteritems[iter_26_0].btndetail:RemoveClickListener()
	end

	for iter_26_1 = 1, var_0_0.showHeroNum do
		arg_26_0["_simagead" .. iter_26_1]:UnLoadImage()
	end

	arg_26_0._simagebg:UnLoadImage()
	arg_26_0._simageline:UnLoadImage()
	arg_26_0._simagetips1:UnLoadImage()
	arg_26_0._simagetips2:UnLoadImage()
	arg_26_0._simagetips3:UnLoadImage()
	arg_26_0._simagesignature1:UnLoadImage()
	arg_26_0._simagesignature2:UnLoadImage()
	arg_26_0._simagecurrency10:UnLoadImage()
end

return var_0_0
