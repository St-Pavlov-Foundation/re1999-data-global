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

	local var_14_1 = arg_14_0:getPickHeroIds(var_14_0)
	local var_14_2 = SummonModel.instance:getSummonFullExSkillHero(var_14_0.id, var_14_1)

	if var_14_2 == nil then
		arg_14_0:_btnsummon1OnClick_2()
	else
		local var_14_3 = HeroConfig.instance:getHeroCO(var_14_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_14_0.id, arg_14_0._btnsummon1OnClick_2, nil, nil, arg_14_0, nil, nil, var_14_3)
	end
end

function var_0_0._btnsummon1OnClick_2(arg_15_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

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

function var_0_0._btnsummon10OnClick(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	local var_16_1 = arg_16_0:getPickHeroIds(var_16_0)
	local var_16_2 = SummonModel.instance:getSummonFullExSkillHero(var_16_0.id, var_16_1)

	if var_16_2 == nil then
		arg_16_0:_btnsummon10OnClick_2()
	else
		local var_16_3 = HeroConfig.instance:getHeroCO(var_16_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_16_0.id, arg_16_0._btnsummon10OnClick_2, nil, nil, arg_16_0, nil, nil, var_16_3)
	end
end

function var_0_0._btnsummon10OnClick_2(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	local var_17_1, var_17_2, var_17_3, var_17_4 = SummonMainModel.getCostByConfig(var_17_0.cost10)
	local var_17_5 = SummonMainModel.instance:getDiscountCost10(var_17_0.id)

	if SummonMainModel.instance:getDiscountCostId(var_17_0.id) == var_17_2 then
		var_17_3 = var_17_5 < 0 and var_17_3 or var_17_5
	end

	local var_17_6 = {
		type = var_17_1,
		id = var_17_2,
		quantity = var_17_3,
		callback = arg_17_0._summon10Confirm,
		callbackObj = arg_17_0
	}

	var_17_6.notEnough = false
	var_17_4 = var_17_4 or ItemModel.instance:getItemQuantity(var_17_1, var_17_2)

	local var_17_7 = var_17_3 <= var_17_4
	local var_17_8 = SummonMainModel.instance.everyCostCount
	local var_17_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_17_10 = var_17_3 - var_17_4
	local var_17_11 = var_17_8 * var_17_10

	if not var_17_7 and var_17_9 < var_17_11 then
		var_17_6.notEnough = true
	end

	if var_17_7 then
		var_17_6.needTransform = false

		arg_17_0:_summon10Confirm()

		return
	else
		var_17_6.needTransform = true
		var_17_6.cost_type = SummonMainModel.instance.costCurrencyType
		var_17_6.cost_id = SummonMainModel.instance.costCurrencyId
		var_17_6.cost_quantity = var_17_11
		var_17_6.miss_quantity = var_17_10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_17_6)
end

function var_0_0._summon10Confirm(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_18_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if not var_19_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_19_0.id, 1, false, true)
end

function var_0_0._btnpickOnClick(arg_20_0)
	local var_20_0 = SummonMainModel.instance:getCurPool()

	if not var_20_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_20_0.id
	})
end

function var_0_0._onClickDetailByIndex(arg_21_0, arg_21_1)
	local var_21_0 = SummonMainModel.instance:getCurPool()

	if not var_21_0 then
		return
	end

	local var_21_1 = SummonMainModel.instance:getPoolServerMO(var_21_0.id)

	if var_21_1 and var_21_1.customPickMO then
		local var_21_2 = var_21_1.customPickMO.pickHeroIds[arg_21_1]

		if var_21_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_21_2
			})
		end
	end
end

function var_0_0.refreshView(arg_22_0)
	arg_22_0.summonSuccess = false

	local var_22_0 = SummonMainModel.instance:getList()

	if not var_22_0 or #var_22_0 <= 0 then
		gohelper.setActive(arg_22_0._goui, false)

		return
	end

	arg_22_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_23_0)
	local var_23_0 = SummonMainModel.instance:getCurPool()

	if not var_23_0 then
		return
	end

	if SummonCustomPickModel.instance:isCustomPickOver(var_23_0.id) then
		arg_23_0:handlePickOverStatus(var_23_0)
	else
		arg_23_0:handleNeedPickStatus()
	end

	arg_23_0:refreshPickHeroes(var_23_0)
	arg_23_0:_refreshOpenTime()

	local var_23_1 = SummonMainModel.instance:getDiscountCost10(var_23_0.id, 1)

	arg_23_0._txttips.text = string.format(luaLang("summon_discount_tips"), var_23_1)

	arg_23_0:refreshCost()
end

function var_0_0.refreshCost10(arg_24_0, arg_24_1)
	local var_24_0, var_24_1, var_24_2 = SummonMainModel.instance.getCostByConfig(arg_24_1)
	local var_24_3 = SummonMainModel.instance.getSummonItemIcon(var_24_0, var_24_1)

	arg_24_0._simagecurrency10:LoadImage(var_24_3)
	arg_24_0._simagecurrency10normal:LoadImage(var_24_3)

	local var_24_4 = SummonMainModel.instance:getCurId()
	local var_24_5 = SummonMainModel.instance:getDiscountCostId(var_24_4)
	local var_24_6 = SummonMainModel.instance:getDiscountTime10Server(var_24_4)
	local var_24_7 = var_24_6 > 0

	gohelper.setActive(arg_24_0._gotip2bg, var_24_7)
	gohelper.setActive(arg_24_0._gosummon10, var_24_7)
	gohelper.setActive(arg_24_0._gosummon10normal, not var_24_7)

	local var_24_8 = ""
	local var_24_9 = ""

	if var_24_1 == var_24_5 then
		gohelper.setActive(arg_24_0._gocount, var_24_6 > 0)

		if var_24_6 > 0 then
			local var_24_10 = SummonMainModel.instance:getDiscountCost10(var_24_4)

			var_24_8 = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. var_24_10)
			var_24_9 = var_24_2

			local var_24_11 = (var_24_2 - var_24_10) / var_24_2 * 100

			arg_24_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_24_11)
		else
			var_24_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_24_2)
		end
	else
		var_24_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_24_2)

		gohelper.setActive(arg_24_0._gocount, false)
	end

	arg_24_0._txtcurrency101.text = var_24_8
	arg_24_0._txtcurrency101normal.text = var_24_8
	arg_24_0._txtcurrency102.text = var_24_9
	arg_24_0._txtcurrency102normal.text = var_24_9
end

function var_0_0.handleNeedPickStatus(arg_25_0)
	gohelper.setActive(arg_25_0._gosummonbtns, false)
	gohelper.setActive(arg_25_0._goselected, false)
	gohelper.setActive(arg_25_0._simageunselect, true)
	gohelper.setActive(arg_25_0._goselfselect, true)
	gohelper.setActive(arg_25_0._simageunselect, true)
end

function var_0_0.handlePickOverStatus(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._gosummonbtns, true)
	gohelper.setActive(arg_26_0._goselected, true)
	gohelper.setActive(arg_26_0._simageunselect, false)
	gohelper.setActive(arg_26_0._goselfselect, false)
	gohelper.setActive(arg_26_0._simageunselect, false)
	arg_26_0:refreshFreeSummonButton(arg_26_1)
end

function var_0_0.refreshPickHeroes(arg_27_0, arg_27_1)
	local var_27_0 = SummonMainModel.instance:getPoolServerMO(arg_27_1.id)

	if var_27_0 and var_27_0.customPickMO then
		for iter_27_0 = 1, arg_27_0._charaterItemCount do
			local var_27_1 = var_27_0.customPickMO.pickHeroIds[iter_27_0]

			arg_27_0:_refreshPickHero(arg_27_1.id, iter_27_0, var_27_1)
		end
	end
end

function var_0_0.getPickHeroIds(arg_28_0, arg_28_1)
	local var_28_0 = SummonMainModel.instance:getPoolServerMO(arg_28_1.id)

	if var_28_0 and var_28_0.customPickMO then
		return var_28_0.customPickMO.pickHeroIds
	end

	return nil
end

function var_0_0._refreshPickHero(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0._characteritems[arg_29_2]

	if var_29_0 then
		if arg_29_3 then
			gohelper.setActive(var_29_0.go, true)
			gohelper.setActive(var_29_0.simagehero, true)

			local var_29_1 = HeroConfig.instance:getHeroCO(arg_29_3)

			UISpriteSetMgr.instance:setCommonSprite(var_29_0.imagecareer, "lssx_" .. tostring(var_29_1.career))

			var_29_0.txtnamecn.text = var_29_1.name

			for iter_29_0 = 1, 6 do
				gohelper.setActive(var_29_0.rares[iter_29_0], iter_29_0 <= CharacterEnum.Star[var_29_1.rare])
			end

			var_29_0.simagehero:LoadImage(ResUrl.getHeadIconImg(var_29_1.skinId), arg_29_0.handleLoadedImage, {
				panel = arg_29_0,
				skinId = var_29_1.skinId,
				index = arg_29_2
			})
		else
			gohelper.setActive(var_29_0.go, false)
			gohelper.setActive(var_29_0.simagehero, false)
		end
	end
end

function var_0_0.handleLoadedImage(arg_30_0)
	local var_30_0 = arg_30_0.panel
	local var_30_1 = arg_30_0.skinId
	local var_30_2 = arg_30_0.index
	local var_30_3 = var_30_0._characteritems[var_30_2]

	ZProj.UGUIHelper.SetImageSize(var_30_3.simagehero.gameObject)

	local var_30_4 = SkinConfig.instance:getSkinCo(var_30_1).skinViewImgOffset

	if not string.nilorempty(var_30_4) then
		local var_30_5 = string.splitToNumber(var_30_4, "#")

		recthelper.setAnchor(var_30_3.tfimagehero, tonumber(var_30_5[1]), tonumber(var_30_5[2]))
		transformhelper.setLocalScale(var_30_3.tfimagehero, tonumber(var_30_5[3]), tonumber(var_30_5[3]), tonumber(var_30_5[3]))
	else
		recthelper.setAnchor(var_30_3.tfimagehero, -150, -150)
		transformhelper.setLocalScale(var_30_3.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function var_0_0.refreshFreeSummonButton(arg_31_0, arg_31_1)
	arg_31_0._compFreeButton = arg_31_0._compFreeButton or SummonFreeSingleGacha.New(arg_31_0._btnsummon1.gameObject, arg_31_1.id)

	arg_31_0._compFreeButton:refreshUI()
end

function var_0_0.refreshRemainTimes(arg_32_0, arg_32_1)
	local var_32_0 = SummonConfig.getSummonSSRTimes(arg_32_1)
	local var_32_1 = SummonMainModel.instance:getPoolServerMO(arg_32_1.id)

	if var_32_1 and var_32_1.luckyBagMO then
		arg_32_0._txttimes.text = string.format("%s/%s", var_32_1.luckyBagMO.summonTimes, var_32_0)
	else
		arg_32_0._txttimes.text = "-"
	end
end

function var_0_0.refreshCost(arg_33_0)
	local var_33_0 = SummonMainModel.instance:getCurPool()

	if var_33_0 then
		arg_33_0:_refreshSingleCost(var_33_0.cost1, arg_33_0._simagecurrency1, "_txtcurrency1")
		arg_33_0:refreshCost10(var_33_0.cost10)
	end
end

function var_0_0._refreshSingleCost(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0, var_34_1, var_34_2 = SummonMainModel.getCostByConfig(arg_34_1, true)
	local var_34_3 = SummonMainModel.getSummonItemIcon(var_34_0, var_34_1)

	arg_34_2:LoadImage(var_34_3)

	local var_34_4 = ItemModel.instance:getItemQuantity(var_34_0, var_34_1)

	arg_34_0[arg_34_3 .. "1"].text = luaLang("multiple") .. var_34_2
	arg_34_0[arg_34_3 .. "2"].text = ""
end

function var_0_0._refreshOpenTime(arg_35_0)
	local var_35_0 = SummonMainModel.instance:getCurPool()

	if not var_35_0 then
		return
	end

	local var_35_1 = SummonMainModel.instance:getPoolServerMO(var_35_0.id)

	if var_35_1 ~= nil and var_35_1.offlineTime ~= 0 and var_35_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_35_2 = var_35_1.offlineTime - ServerTime.now()

		arg_35_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_35_2))
	else
		arg_35_0._txtdeadline.text = ""
	end
end

function var_0_0.onSummonFailed(arg_36_0)
	arg_36_0.summonSuccess = false

	arg_36_0:refreshCost()
end

function var_0_0.onSummonReply(arg_37_0)
	arg_37_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_38_0)
	if SummonController.instance.isWaitingSummonResult or arg_38_0.summonSuccess then
		return
	end

	arg_38_0:refreshCost()
end

return var_0_0
