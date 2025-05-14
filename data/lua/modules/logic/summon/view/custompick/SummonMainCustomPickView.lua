module("modules.logic.summon.view.custompick.SummonMainCustomPickView", package.seeall)

local var_0_0 = class("SummonMainCustomPickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simageunselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_unselect")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1")
	arg_1_0._gocharacteritem2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem2")
	arg_1_0._godisCountTip = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip")
	arg_1_0._simagetips = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#simage_tips")
	arg_1_0._gotip2bg = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg/#txt_tips")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._goselfselect = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_selfselect")
	arg_1_0._btnselfselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	arg_1_0._gosummonbtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._gosummon10 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/currency/#txt_currency10_2")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#go_count")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10/#go_count/#txt_count")
	arg_1_0._gosummon10normal = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal")
	arg_1_0._btnsummon10normal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/#btn_summon10_normal")
	arg_1_0._simagecurrency10normal = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#simage_currency10_normal")
	arg_1_0._txtcurrency101normal = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_1_normal")
	arg_1_0._txtcurrency102normal = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_2_normal")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnselfselect:AddClickListener(arg_2_0._btnselfselectOnClick, arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
	arg_2_0._btnsummon10normal:AddClickListener(arg_2_0._btnsummon10normalOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselfselect:RemoveClickListener()
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
	arg_3_0._btnsummon10normal:RemoveClickListener()
end

function var_0_0._btnselfselectOnClick(arg_4_0)
	local var_4_0 = SummonMainModel.instance:getCurPool()

	if not var_4_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_4_0.id
	})
end

function var_0_0._btnsummon10normalOnClick(arg_5_0)
	arg_5_0:_btnsummon10OnClick()
end

var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/full/v1a6_selfselectsix_summon_fullbg"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_rolemask"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_mask2")
}

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animRoot = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_6_0._characteritems = {}

	local var_6_0 = SummonMainModel.instance:getCurPool()

	arg_6_0._charaterItemCount = SummonCustomPickModel.instance:getMaxSelectCount(var_6_0 and var_6_0.id or 0)

	for iter_6_0 = 1, arg_6_0._charaterItemCount do
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.go = gohelper.findChild(arg_6_0.viewGO, "#go_ui/current/right/#go_characteritem" .. iter_6_0)
		var_6_1.imagecareer = gohelper.findChildImage(var_6_1.go, "image_career")
		var_6_1.txtnamecn = gohelper.findChildText(var_6_1.go, "txt_namecn")
		var_6_1.btndetail = gohelper.findChildButtonWithAudio(var_6_1.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		var_6_1.gorole = gohelper.findChild(arg_6_0.viewGO, "#go_ui/current/#go_selected/#go_role" .. tostring(iter_6_0))
		var_6_1.simagehero = gohelper.findChildSingleImage(var_6_1.gorole, "#simage_role" .. tostring(iter_6_0))
		var_6_1.tfimagehero = var_6_1.simagehero.transform
		var_6_1.rares = {}

		for iter_6_1 = 1, 6 do
			local var_6_2 = gohelper.findChild(var_6_1.go, "rare/go_rare" .. iter_6_1)

			table.insert(var_6_1.rares, var_6_2)
		end

		table.insert(arg_6_0._characteritems, var_6_1)
		var_6_1.btndetail:AddClickListener(arg_6_0._onClickDetailByIndex, arg_6_0, iter_6_0)
	end
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()
	arg_7_0._simageunselect:UnLoadImage()
	arg_7_0._simagecurrency1:UnLoadImage()
	arg_7_0._simagecurrency10:UnLoadImage()
	arg_7_0._simageline:UnLoadImage()

	if arg_7_0._compFreeButton then
		arg_7_0._compFreeButton:dispose()

		arg_7_0._compFreeButton = nil
	end

	if arg_7_0._characteritems then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._characteritems) do
			iter_7_1.btndetail:RemoveClickListener()
		end

		arg_7_0._characteritems = nil
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	logNormal("SummonMainCustomPickView:onOpen()")
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_9_0.onSummonFailed, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_9_0.onSummonReply, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_9_0.playerEnterAnimFromScene, arg_9_0)
	arg_9_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_9_0.onItemChanged, arg_9_0)
	arg_9_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_9_0.onItemChanged, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_9_0.refreshView, arg_9_0)
	arg_9_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_9_0._refreshOpenTime, arg_9_0)
	arg_9_0:playEnterAnim()
	arg_9_0:refreshView()
end

function var_0_0.onOpenFinish(arg_10_0)
	return
end

function var_0_0.playEnterAnim(arg_11_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_11_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_11_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_12_0)
	arg_12_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.onClose(arg_13_0)
	logNormal("SummonMainCustomPickView:onClose()")
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_13_0.onSummonFailed, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_13_0.onSummonReply, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_13_0.playerEnterAnimFromScene, arg_13_0)
	arg_13_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_13_0.onItemChanged, arg_13_0)
	arg_13_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0.onItemChanged, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_13_0.refreshView, arg_13_0)
	arg_13_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_13_0._refreshOpenTime, arg_13_0)
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

function var_0_0._btnsummon10OnClick(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	local var_15_1, var_15_2, var_15_3 = SummonMainModel.getCostByConfig(var_15_0.cost10)
	local var_15_4 = SummonMainModel.instance:getDiscountCost10(var_15_0.id)

	if SummonMainModel.instance:getDiscountCostId(var_15_0.id) == var_15_2 then
		var_15_3 = var_15_4 < 0 and var_15_3 or var_15_4
	end

	local var_15_5 = {
		type = var_15_1,
		id = var_15_2,
		quantity = var_15_3,
		callback = arg_15_0._summon10Confirm,
		callbackObj = arg_15_0
	}

	var_15_5.notEnough = false

	local var_15_6 = ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
	local var_15_7 = var_15_3 <= var_15_6
	local var_15_8 = SummonMainModel.instance.everyCostCount
	local var_15_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_15_10 = var_15_3 - var_15_6
	local var_15_11 = var_15_8 * var_15_10

	if not var_15_7 and var_15_9 < var_15_11 then
		var_15_5.notEnough = true
	end

	if var_15_7 then
		var_15_5.needTransform = false

		arg_15_0:_summon10Confirm()

		return
	else
		var_15_5.needTransform = true
		var_15_5.cost_type = SummonMainModel.instance.costCurrencyType
		var_15_5.cost_id = SummonMainModel.instance.costCurrencyId
		var_15_5.cost_quantity = var_15_11
		var_15_5.miss_quantity = var_15_10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_15_5)
end

function var_0_0._summon10Confirm(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_16_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_17_0.id, 1, false, true)
end

function var_0_0._btnpickOnClick(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_18_0.id
	})
end

function var_0_0._onClickDetailByIndex(arg_19_0, arg_19_1)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if not var_19_0 then
		return
	end

	local var_19_1 = SummonMainModel.instance:getPoolServerMO(var_19_0.id)

	if var_19_1 and var_19_1.customPickMO then
		local var_19_2 = var_19_1.customPickMO.pickHeroIds[arg_19_1]

		if var_19_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_19_2
			})
		end
	end
end

function var_0_0.refreshView(arg_20_0)
	arg_20_0.summonSuccess = false

	local var_20_0 = SummonMainModel.instance:getList()

	if not var_20_0 or #var_20_0 <= 0 then
		gohelper.setActive(arg_20_0._goui, false)

		return
	end

	arg_20_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_21_0)
	local var_21_0 = SummonMainModel.instance:getCurPool()

	if not var_21_0 then
		return
	end

	if SummonCustomPickModel.instance:isCustomPickOver(var_21_0.id) then
		arg_21_0:handlePickOverStatus(var_21_0)
	else
		arg_21_0:handleNeedPickStatus()
	end

	arg_21_0:refreshPickHeroes(var_21_0)
	arg_21_0:_refreshOpenTime()

	local var_21_1 = SummonMainModel.instance:getDiscountCost10(var_21_0.id, 1)

	arg_21_0._txttips.text = string.format(luaLang("summon_discount_tips"), var_21_1)

	arg_21_0:refreshCost()
end

function var_0_0.refreshCost10(arg_22_0, arg_22_1)
	local var_22_0, var_22_1, var_22_2 = SummonMainModel.instance.getCostByConfig(arg_22_1)
	local var_22_3 = SummonMainModel.instance.getSummonItemIcon(var_22_0, var_22_1)

	arg_22_0._simagecurrency10:LoadImage(var_22_3)
	arg_22_0._simagecurrency10normal:LoadImage(var_22_3)

	local var_22_4 = SummonMainModel.instance:getCurId()
	local var_22_5 = SummonMainModel.instance:getDiscountCostId(var_22_4)
	local var_22_6 = SummonMainModel.instance:getDiscountTime10Server(var_22_4)
	local var_22_7 = var_22_6 > 0

	gohelper.setActive(arg_22_0._gotip2bg, var_22_7)
	gohelper.setActive(arg_22_0._gosummon10, var_22_7)
	gohelper.setActive(arg_22_0._gosummon10normal, not var_22_7)

	local var_22_8 = ""
	local var_22_9 = ""

	if var_22_1 == var_22_5 then
		gohelper.setActive(arg_22_0._gocount, var_22_6 > 0)

		if var_22_6 > 0 then
			local var_22_10 = SummonMainModel.instance:getDiscountCost10(var_22_4)

			var_22_8 = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. var_22_10)
			var_22_9 = var_22_2

			local var_22_11 = (var_22_2 - var_22_10) / var_22_2 * 100

			arg_22_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_22_11)
		else
			var_22_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_22_2)
		end
	else
		var_22_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_22_2)

		gohelper.setActive(arg_22_0._gocount, false)
	end

	arg_22_0._txtcurrency101.text = var_22_8
	arg_22_0._txtcurrency101normal.text = var_22_8
	arg_22_0._txtcurrency102.text = var_22_9
	arg_22_0._txtcurrency102normal.text = var_22_9
end

function var_0_0.handleNeedPickStatus(arg_23_0)
	gohelper.setActive(arg_23_0._gosummonbtns, false)
	gohelper.setActive(arg_23_0._goselected, false)
	gohelper.setActive(arg_23_0._simageunselect, true)
	gohelper.setActive(arg_23_0._goselfselect, true)
	gohelper.setActive(arg_23_0._simageunselect, true)
end

function var_0_0.handlePickOverStatus(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._gosummonbtns, true)
	gohelper.setActive(arg_24_0._goselected, true)
	gohelper.setActive(arg_24_0._simageunselect, false)
	gohelper.setActive(arg_24_0._goselfselect, false)
	gohelper.setActive(arg_24_0._simageunselect, false)
	arg_24_0:refreshFreeSummonButton(arg_24_1)
end

function var_0_0.refreshPickHeroes(arg_25_0, arg_25_1)
	local var_25_0 = SummonMainModel.instance:getPoolServerMO(arg_25_1.id)

	if var_25_0 and var_25_0.customPickMO then
		for iter_25_0 = 1, arg_25_0._charaterItemCount do
			local var_25_1 = var_25_0.customPickMO.pickHeroIds[iter_25_0]

			arg_25_0:_refreshPickHero(arg_25_1.id, iter_25_0, var_25_1)
		end
	end
end

function var_0_0._refreshPickHero(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0._characteritems[arg_26_2]

	if var_26_0 then
		if arg_26_3 then
			gohelper.setActive(var_26_0.go, true)
			gohelper.setActive(var_26_0.simagehero, true)

			local var_26_1 = HeroConfig.instance:getHeroCO(arg_26_3)

			UISpriteSetMgr.instance:setCommonSprite(var_26_0.imagecareer, "lssx_" .. tostring(var_26_1.career))

			var_26_0.txtnamecn.text = var_26_1.name

			for iter_26_0 = 1, 6 do
				gohelper.setActive(var_26_0.rares[iter_26_0], iter_26_0 <= CharacterEnum.Star[var_26_1.rare])
			end

			var_26_0.simagehero:LoadImage(ResUrl.getHeadIconImg(var_26_1.skinId), arg_26_0.handleLoadedImage, {
				panel = arg_26_0,
				skinId = var_26_1.skinId,
				index = arg_26_2
			})
		else
			gohelper.setActive(var_26_0.go, false)
			gohelper.setActive(var_26_0.simagehero, false)
		end
	end
end

function var_0_0.handleLoadedImage(arg_27_0)
	local var_27_0 = arg_27_0.panel
	local var_27_1 = arg_27_0.skinId
	local var_27_2 = arg_27_0.index
	local var_27_3 = var_27_0._characteritems[var_27_2]

	ZProj.UGUIHelper.SetImageSize(var_27_3.simagehero.gameObject)

	local var_27_4 = SkinConfig.instance:getSkinCo(var_27_1).skinViewImgOffset

	if not string.nilorempty(var_27_4) then
		local var_27_5 = string.splitToNumber(var_27_4, "#")

		recthelper.setAnchor(var_27_3.tfimagehero, tonumber(var_27_5[1]), tonumber(var_27_5[2]))
		transformhelper.setLocalScale(var_27_3.tfimagehero, tonumber(var_27_5[3]), tonumber(var_27_5[3]), tonumber(var_27_5[3]))
	else
		recthelper.setAnchor(var_27_3.tfimagehero, -150, -150)
		transformhelper.setLocalScale(var_27_3.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function var_0_0.refreshFreeSummonButton(arg_28_0, arg_28_1)
	arg_28_0._compFreeButton = arg_28_0._compFreeButton or SummonFreeSingleGacha.New(arg_28_0._btnsummon1.gameObject, arg_28_1.id)

	arg_28_0._compFreeButton:refreshUI()
end

function var_0_0.refreshRemainTimes(arg_29_0, arg_29_1)
	local var_29_0 = SummonConfig.getSummonSSRTimes(arg_29_1)
	local var_29_1 = SummonMainModel.instance:getPoolServerMO(arg_29_1.id)

	if var_29_1 and var_29_1.luckyBagMO then
		arg_29_0._txttimes.text = string.format("%s/%s", var_29_1.luckyBagMO.summonTimes, var_29_0)
	else
		arg_29_0._txttimes.text = "-"
	end
end

function var_0_0.refreshCost(arg_30_0)
	local var_30_0 = SummonMainModel.instance:getCurPool()

	if var_30_0 then
		arg_30_0:_refreshSingleCost(var_30_0.cost1, arg_30_0._simagecurrency1, "_txtcurrency1")
		arg_30_0:refreshCost10(var_30_0.cost10)
	end
end

function var_0_0._refreshSingleCost(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0, var_31_1, var_31_2 = SummonMainModel.getCostByConfig(arg_31_1)
	local var_31_3 = SummonMainModel.getSummonItemIcon(var_31_0, var_31_1)

	arg_31_2:LoadImage(var_31_3)

	local var_31_4 = ItemModel.instance:getItemQuantity(var_31_0, var_31_1)

	arg_31_0[arg_31_3 .. "1"].text = luaLang("multiple") .. var_31_2
	arg_31_0[arg_31_3 .. "2"].text = ""
end

function var_0_0._refreshOpenTime(arg_32_0)
	local var_32_0 = SummonMainModel.instance:getCurPool()

	if not var_32_0 then
		return
	end

	local var_32_1 = SummonMainModel.instance:getPoolServerMO(var_32_0.id)

	if var_32_1 ~= nil and var_32_1.offlineTime ~= 0 and var_32_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_32_2 = var_32_1.offlineTime - ServerTime.now()

		arg_32_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_32_2))
	else
		arg_32_0._txtdeadline.text = ""
	end
end

function var_0_0.onSummonFailed(arg_33_0)
	arg_33_0.summonSuccess = false

	arg_33_0:refreshCost()
end

function var_0_0.onSummonReply(arg_34_0)
	arg_34_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_35_0)
	if SummonController.instance.isWaitingSummonResult or arg_35_0.summonSuccess then
		return
	end

	arg_35_0:refreshCost()
end

return var_0_0
