module("modules.logic.summon.view.custompick.SummonOneCustomPickView", package.seeall)

local var_0_0 = class("SummonOneCustomPickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simageunselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_unselect")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_1_0._simagerole1outline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frontbg")
	arg_1_0._gocharacteritem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem")
	arg_1_0._simagetitle1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/title/#simage_title1")
	arg_1_0._simagetips = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/#simage_tips")
	arg_1_0._gotip2bg = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_tip2bg")
	arg_1_0._txttips2 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/tip/#go_tip2bg/#txt_tips2")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_tips")
	arg_1_0._goselfselect = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_selfselect")
	arg_1_0._btnselfselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	arg_1_0._gosummonbtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count/#txt_count")
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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselfselect:RemoveClickListener()
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line4_1.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_fullbg2.png",
	"singlebg/summon/heroversion_2_2/selfselectsix/v2a2_selfselectsix_summon_line.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselect2/v2a8_selfselect2_rolebg.png",
	"singlebg/summon/heroversion_2_8/v2a8_selfselect2/v2a8_selfselect2_fullbg.png"
}

function var_0_0._btnselfselectOnClick(arg_4_0)
	local var_4_0 = SummonMainModel.instance:getCurPool()

	if not var_4_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_4_0.id
	})
end

function var_0_0._btnsummon1OnClick(arg_5_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_5_0 = SummonMainModel.instance:getCurPool()

	if not var_5_0 then
		return
	end

	local var_5_1, var_5_2, var_5_3 = SummonMainModel.getCostByConfig(var_5_0.cost1)
	local var_5_4 = {
		type = var_5_1,
		id = var_5_2,
		quantity = var_5_3,
		callback = arg_5_0._summon1Confirm,
		callbackObj = arg_5_0
	}

	var_5_4.notEnough = false

	local var_5_5 = var_5_3 <= ItemModel.instance:getItemQuantity(var_5_1, var_5_2)
	local var_5_6 = SummonMainModel.instance.everyCostCount
	local var_5_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_5_5 and var_5_7 < var_5_6 then
		var_5_4.notEnough = true
	end

	if var_5_5 then
		var_5_4.needTransform = false

		arg_5_0:_summon1Confirm()

		return
	else
		var_5_4.needTransform = true
		var_5_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_5_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_5_4.cost_quantity = var_5_6
		var_5_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_5_4)
end

function var_0_0._btnsummon10OnClick(arg_6_0)
	local var_6_0 = SummonMainModel.instance:getCurPool()

	if not var_6_0 then
		return
	end

	local var_6_1, var_6_2, var_6_3, var_6_4 = SummonMainModel.getCostByConfig(var_6_0.cost10)
	local var_6_5 = SummonMainModel.instance:getDiscountCost10(var_6_0.id)

	if SummonMainModel.instance:getDiscountCostId(var_6_0.id) == var_6_2 then
		var_6_3 = var_6_5 < 0 and var_6_3 or var_6_5
	end

	local var_6_6 = {
		type = var_6_1,
		id = var_6_2,
		quantity = var_6_3,
		callback = arg_6_0._summon10Confirm,
		callbackObj = arg_6_0
	}

	var_6_6.notEnough = false
	var_6_4 = var_6_4 or ItemModel.instance:getItemQuantity(var_6_1, var_6_2)

	local var_6_7 = var_6_3 <= var_6_4
	local var_6_8 = SummonMainModel.instance.everyCostCount
	local var_6_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_6_10 = var_6_3 - var_6_4
	local var_6_11 = var_6_8 * var_6_10

	if not var_6_7 and var_6_9 < var_6_11 then
		var_6_6.notEnough = true
	end

	if var_6_7 then
		var_6_6.needTransform = false

		arg_6_0:_summon10Confirm()

		return
	else
		var_6_6.needTransform = true
		var_6_6.cost_type = SummonMainModel.instance.costCurrencyType
		var_6_6.cost_id = SummonMainModel.instance.costCurrencyId
		var_6_6.cost_quantity = var_6_11
		var_6_6.miss_quantity = var_6_10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_6_6)
end

function var_0_0._onClickDetail(arg_7_0)
	local var_7_0 = SummonMainModel.instance:getCurPool()

	if not var_7_0 then
		return
	end

	local var_7_1 = arg_7_0:getPickHeroIds(var_7_0)

	if var_7_1 and #var_7_1 > 0 then
		local var_7_2 = var_7_1[1]

		if var_7_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_7_2
			})
		end
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._animRoot = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_8_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_8_0._characteritem = arg_8_0:getUserDataTb_()
	arg_8_0._characteritem.go = gohelper.findChild(arg_8_0.viewGO, "#go_ui/current/right/#go_characteritem")
	arg_8_0._characteritem.imagecareer = gohelper.findChildImage(arg_8_0._characteritem.go, "image_career")
	arg_8_0._characteritem.txtnamecn = gohelper.findChildText(arg_8_0._characteritem.go, "txt_namecn")
	arg_8_0._characteritem.btndetail = gohelper.findChildButtonWithAudio(arg_8_0._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	arg_8_0._characteritem.gorole = gohelper.findChild(arg_8_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_8_0._characteritem.simagehero = gohelper.findChildSingleImage(arg_8_0._characteritem.gorole, "#simage_role1")
	arg_8_0._characteritem.tfimagehero = arg_8_0._characteritem.simagehero.transform
	arg_8_0._characteritem.rares = arg_8_0:getUserDataTb_()

	for iter_8_0 = 1, 6 do
		local var_8_0 = gohelper.findChild(arg_8_0._characteritem.go, "rare/go_rare" .. iter_8_0)

		table.insert(arg_8_0._characteritem.rares, var_8_0)
	end

	arg_8_0._characteritem.btndetail:AddClickListener(arg_8_0._onClickDetail, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addAllEvents()
	arg_10_0:playEnterAnim()
	arg_10_0:refreshView()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeAllEvents()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageunselect:UnLoadImage()
	arg_12_0._simagecurrency1:UnLoadImage()
	arg_12_0._simagecurrency10:UnLoadImage()
	arg_12_0._simageline:UnLoadImage()
	arg_12_0._simagefrontbg:UnLoadImage()

	if arg_12_0._compFreeButton then
		arg_12_0._compFreeButton:dispose()

		arg_12_0._compFreeButton = nil
	end

	if arg_12_0._characteritem then
		arg_12_0._characteritem.btndetail:RemoveClickListener()
		arg_12_0._characteritem.simagehero:UnLoadImage()
		arg_12_0._simagerole1outline:UnLoadImage()

		arg_12_0._characteritem = nil
	end
end

function var_0_0.handleNeedPickStatus(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._gosummonbtns, false)
	gohelper.setActive(arg_13_0._goselected, false)
	gohelper.setActive(arg_13_0._simageunselect, true)
	gohelper.setActive(arg_13_0._goselfselect, true)
	gohelper.setActive(arg_13_0._txttips, true)
	gohelper.setActive(arg_13_0._simageunselect, true)
end

function var_0_0.handlePickOverStatus(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._gosummonbtns, true)
	gohelper.setActive(arg_14_0._goselected, true)
	gohelper.setActive(arg_14_0._simageunselect, false)
	gohelper.setActive(arg_14_0._goselfselect, false)
	gohelper.setActive(arg_14_0._txttips, false)
	gohelper.setActive(arg_14_0._simageunselect, false)
	arg_14_0:refreshCost()
	arg_14_0:refreshFreeSummonButton(arg_14_1)
end

function var_0_0.refreshFreeSummonButton(arg_15_0, arg_15_1)
	arg_15_0._compFreeButton = arg_15_0._compFreeButton or SummonFreeSingleGacha.New(arg_15_0._btnsummon1.gameObject, arg_15_1.id)

	arg_15_0._compFreeButton:refreshUI()
end

function var_0_0.refreshCost(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if var_16_0 then
		arg_16_0:_refreshSingleCost(var_16_0.cost1, arg_16_0._simagecurrency1, "_txtcurrency1")
		arg_16_0:refreshCost10(var_16_0.cost10)
	end
end

function var_0_0._refreshSingleCost(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0, var_17_1, var_17_2 = SummonMainModel.instance.getCostByConfig(arg_17_1)
	local var_17_3 = SummonMainModel.instance.getSummonItemIcon(var_17_0, var_17_1)

	arg_17_2:LoadImage(var_17_3)

	arg_17_0[arg_17_3 .. "1"].text = luaLang("multiple") .. var_17_2
	arg_17_0[arg_17_3 .. "2"].text = ""
end

function var_0_0.refreshCost10(arg_18_0, arg_18_1)
	local var_18_0, var_18_1, var_18_2 = SummonMainModel.instance.getCostByConfig(arg_18_1)
	local var_18_3 = SummonMainModel.instance.getSummonItemIcon(var_18_0, var_18_1)

	arg_18_0._simagecurrency10:LoadImage(var_18_3)

	local var_18_4 = SummonMainModel.instance:getCurId()
	local var_18_5 = SummonMainModel.instance:getDiscountCostId(var_18_4)
	local var_18_6 = SummonMainModel.instance:getDiscountTime10Server(var_18_4)

	gohelper.setActive(arg_18_0._gotip2bg, var_18_6 > 0)
	gohelper.setActive(arg_18_0._txttips2, var_18_6 > 0)

	if var_18_1 == var_18_5 then
		gohelper.setActive(arg_18_0._gocount, var_18_6 > 0)

		if var_18_6 > 0 then
			local var_18_7 = SummonMainModel.instance:getDiscountCost10(var_18_4)

			arg_18_0._txtcurrency101.text = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. var_18_7)
			arg_18_0._txtcurrency102.text = var_18_2

			local var_18_8 = (var_18_2 - var_18_7) / var_18_2 * 100

			arg_18_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_18_8)

			return
		end
	else
		gohelper.setActive(arg_18_0._gocount, false)
	end

	arg_18_0._txtcurrency101.text = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_18_2)
	arg_18_0._txtcurrency102.text = ""
end

function var_0_0.getPickHeroIds(arg_19_0, arg_19_1)
	local var_19_0 = SummonMainModel.instance:getPoolServerMO(arg_19_1.id)

	if var_19_0 and var_19_0.customPickMO then
		return var_19_0.customPickMO.pickHeroIds
	end

	return nil
end

function var_0_0.refreshPickHero(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getPickHeroIds(arg_20_1)

	if var_20_0 and #var_20_0 > 0 and arg_20_0._characteritem then
		local var_20_1 = var_20_0[1]

		gohelper.setActive(arg_20_0._characteritem.go, true)
		gohelper.setActive(arg_20_0._characteritem.simagehero, true)

		local var_20_2 = HeroConfig.instance:getHeroCO(var_20_1)

		UISpriteSetMgr.instance:setCommonSprite(arg_20_0._characteritem.imagecareer, "lssx_" .. tostring(var_20_2.career))

		arg_20_0._characteritem.txtnamecn.text = var_20_2.name

		for iter_20_0 = 1, 6 do
			gohelper.setActive(arg_20_0._characteritem.rares[iter_20_0], iter_20_0 <= CharacterEnum.Star[var_20_2.rare])
		end

		local var_20_3, var_20_4, var_20_5 = arg_20_0:getOffset(var_20_2.skinId)

		arg_20_0._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(var_20_2.skinId), arg_20_0.handleLoadedImage, {
			imgTransform = arg_20_0._simagerole1.gameObject.transform,
			offsetX = var_20_3,
			offsetY = var_20_4,
			scale = var_20_5
		})
		arg_20_0._simagerole1outline:LoadImage(ResUrl.getHeadIconImg(var_20_2.skinId), arg_20_0.handleLoadedImage, {
			imgTransform = arg_20_0._simagerole1outline.gameObject.transform,
			offsetX = var_20_3 - 5,
			offsetY = var_20_4 + 2,
			scale = var_20_5
		})
	else
		gohelper.setActive(arg_20_0._characteritem.go, false)
		gohelper.setActive(arg_20_0._characteritem.simagehero, false)
	end
end

function var_0_0.getOffset(arg_21_0, arg_21_1)
	local var_21_0 = SkinConfig.instance:getSkinCo(arg_21_1).skinViewImgOffset

	if not string.nilorempty(var_21_0) then
		local var_21_1 = string.splitToNumber(var_21_0, "#")
		local var_21_2 = var_21_1[1]
		local var_21_3 = var_21_1[2]
		local var_21_4 = var_21_1[3]

		return var_21_2, var_21_3, var_21_4
	end

	return -150, -150, 0.6
end

function var_0_0.handleLoadedImage(arg_22_0)
	local var_22_0 = arg_22_0.imgTransform
	local var_22_1 = arg_22_0.offsetX
	local var_22_2 = arg_22_0.offsetY
	local var_22_3 = arg_22_0.scale

	ZProj.UGUIHelper.SetImageSize(var_22_0.gameObject)
	recthelper.setAnchor(var_22_0, var_22_1, var_22_2)
	transformhelper.setLocalScale(var_22_0, var_22_3, var_22_3, var_22_3)
end

function var_0_0.refreshView(arg_23_0)
	arg_23_0.summonSuccess = false

	local var_23_0 = SummonMainModel.instance:getList()

	if not var_23_0 or #var_23_0 <= 0 then
		gohelper.setActive(arg_23_0._goui, false)

		return
	end

	arg_23_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_24_0)
	local var_24_0 = SummonMainModel.instance:getCurPool()

	if not var_24_0 then
		return
	end

	if SummonCustomPickModel.instance:isCustomPickOver(var_24_0.id) then
		arg_24_0:handlePickOverStatus(var_24_0)
	else
		arg_24_0:handleNeedPickStatus(var_24_0)
	end

	arg_24_0:refreshPickHero(var_24_0)
	arg_24_0:_refreshOpenTime()

	local var_24_1 = SummonMainModel.instance:getDiscountCost10(var_24_0.id, 1)

	arg_24_0._txttips2.text = string.format(luaLang("summon_discount_tips"), var_24_1)
end

function var_0_0._refreshOpenTime(arg_25_0)
	local var_25_0 = SummonMainModel.instance:getCurPool()

	if not var_25_0 then
		return
	end

	local var_25_1 = SummonMainModel.instance:getPoolServerMO(var_25_0.id)

	if var_25_1 ~= nil and var_25_1.offlineTime ~= 0 and var_25_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_25_2 = var_25_1.offlineTime - ServerTime.now()

		arg_25_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_25_2))
	else
		arg_25_0._txtdeadline.text = ""
	end
end

function var_0_0.playEnterAnim(arg_26_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_26_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_26_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_27_0)
	arg_27_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.addAllEvents(arg_28_0)
	arg_28_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_28_0.onSummonFailed, arg_28_0)
	arg_28_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_28_0.onSummonReply, arg_28_0)
	arg_28_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_28_0.playerEnterAnimFromScene, arg_28_0)
	arg_28_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_28_0.onItemChanged, arg_28_0)
	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_28_0.onItemChanged, arg_28_0)
	arg_28_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_28_0.refreshView, arg_28_0)
	arg_28_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_28_0._refreshOpenTime, arg_28_0)
end

function var_0_0.removeAllEvents(arg_29_0)
	arg_29_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_29_0.onSummonFailed, arg_29_0)
	arg_29_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_29_0.onSummonReply, arg_29_0)
	arg_29_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_29_0.playerEnterAnimFromScene, arg_29_0)
	arg_29_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_29_0.onItemChanged, arg_29_0)
	arg_29_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_29_0.onItemChanged, arg_29_0)
	arg_29_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_29_0.refreshView, arg_29_0)
	arg_29_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_29_0._refreshOpenTime, arg_29_0)
end

function var_0_0._summon10Confirm(arg_30_0)
	local var_30_0 = SummonMainModel.instance:getCurPool()

	if not var_30_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_30_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_31_0)
	local var_31_0 = SummonMainModel.instance:getCurPool()

	if not var_31_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_31_0.id, 1, false, true)
end

function var_0_0.onItemChanged(arg_32_0)
	if SummonController.instance.isWaitingSummonResult or arg_32_0.summonSuccess then
		return
	end

	arg_32_0:refreshCost()
end

function var_0_0.onSummonFailed(arg_33_0)
	arg_33_0.summonSuccess = false

	arg_33_0:refreshCost()
end

function var_0_0.onSummonReply(arg_34_0)
	arg_34_0.summonSuccess = true
end

return var_0_0
