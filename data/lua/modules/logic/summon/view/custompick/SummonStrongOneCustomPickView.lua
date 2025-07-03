module("modules.logic.summon.view.custompick.SummonStrongOneCustomPickView", package.seeall)

local var_0_0 = class("SummonStrongOneCustomPickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_fullbg")
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_unselected")
	arg_1_0._simagerole3unselected = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_role3_unselected")
	arg_1_0._simagerole4unselected = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_role4_unselected")
	arg_1_0._simagerole2unselected = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_role2_unselected")
	arg_1_0._goselfselect = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#go_selfselect")
	arg_1_0._btnselfselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#go_selfselect/#btn_selfselect")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_1_0._simagerole1outline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	arg_1_0._simagerole1selected = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_selected")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#go_selected/#btn_refresh")
	arg_1_0._simagerolerefresh = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#btn_refresh/#simage_role_refresh")
	arg_1_0._gosummonbtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._gosummon10 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_2")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count/#txt_count")
	arg_1_0._gosummon10normal = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal")
	arg_1_0._btnsummon10normal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/#btn_summon10_normal")
	arg_1_0._simagecurrency10normal = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#simage_currency10_normal")
	arg_1_0._txtcurrency101normal = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_1_normal")
	arg_1_0._txtcurrency102normal = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_2_normal")
	arg_1_0._simagetitle1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/title/#simage_title1")
	arg_1_0._godisCountTip = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip")
	arg_1_0._simagetips = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#simage_tips")
	arg_1_0._gotip2bg = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/tip/#go_disCountTip/#txt_tips")
	arg_1_0._simagetips2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/#simage_tips2")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnselfselect:AddClickListener(arg_2_0._btnselfselectOnClick, arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
	arg_2_0._btnsummon10normal:AddClickListener(arg_2_0._btnsummon10normalOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnselfselect:RemoveClickListener()
	arg_3_0._btnrefresh:RemoveClickListener()
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
	arg_3_0._btnsummon10normal:RemoveClickListener()
end

function var_0_0._btnsummon10normalOnClick(arg_4_0)
	arg_4_0:_btnsummon10OnClick()
end

function var_0_0._btnrefreshOnClick(arg_5_0)
	arg_5_0:openSelectView()
end

function var_0_0._btnselfselectOnClick(arg_6_0)
	arg_6_0:openSelectView()
end

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role3.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role4.png"
}

function var_0_0.openSelectView(arg_7_0)
	local var_7_0 = SummonMainModel.instance:getCurPool()

	if not var_7_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_7_0.id
	})
end

function var_0_0._btnsummon1OnClick(arg_8_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_8_0 = SummonMainModel.instance:getCurPool()

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_0:getPickHeroIds(var_8_0)
	local var_8_2 = SummonModel.instance:getSummonFullExSkillHero(var_8_0.id, var_8_1)

	if var_8_2 == nil then
		arg_8_0:_btnsummon1OnClick_2()
	else
		local var_8_3 = HeroConfig.instance:getHeroCO(var_8_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_8_0.id, arg_8_0._btnsummon1OnClick_2, nil, nil, arg_8_0, nil, nil, var_8_3)
	end
end

function var_0_0._btnsummon1OnClick_2(arg_9_0)
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

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_9_4)
end

function var_0_0._btnsummon10OnClick(arg_10_0)
	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0:getPickHeroIds(var_10_0)
	local var_10_2 = SummonModel.instance:getSummonFullExSkillHero(var_10_0.id, var_10_1)

	if var_10_2 == nil then
		arg_10_0:_btnsummon10OnClick_2()
	else
		local var_10_3 = HeroConfig.instance:getHeroCO(var_10_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_10_0.id, arg_10_0._btnsummon10OnClick_2, nil, nil, arg_10_0, nil, nil, var_10_3)
	end
end

function var_0_0._btnsummon10OnClick_2(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getCurPool()

	if not var_11_0 then
		return
	end

	local var_11_1, var_11_2, var_11_3 = SummonMainModel.getCostByConfig(var_11_0.cost10)
	local var_11_4 = SummonMainModel.instance:getDiscountCost10(var_11_0.id)

	if SummonMainModel.instance:getDiscountCostId(var_11_0.id) == var_11_2 then
		var_11_3 = var_11_4 < 0 and var_11_3 or var_11_4
	end

	local var_11_5 = {
		type = var_11_1,
		id = var_11_2,
		quantity = var_11_3,
		callback = arg_11_0._summon10Confirm,
		callbackObj = arg_11_0
	}

	var_11_5.notEnough = false

	local var_11_6 = ItemModel.instance:getItemQuantity(var_11_1, var_11_2)
	local var_11_7 = var_11_3 <= var_11_6
	local var_11_8 = SummonMainModel.instance.everyCostCount
	local var_11_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_11_10 = var_11_3 - var_11_6
	local var_11_11 = var_11_8 * var_11_10

	if not var_11_7 and var_11_9 < var_11_11 then
		var_11_5.notEnough = true
	end

	if var_11_7 then
		var_11_5.needTransform = false

		arg_11_0:_summon10Confirm()

		return
	else
		var_11_5.needTransform = true
		var_11_5.cost_type = SummonMainModel.instance.costCurrencyType
		var_11_5.cost_id = SummonMainModel.instance.costCurrencyId
		var_11_5.cost_quantity = var_11_11
		var_11_5.miss_quantity = var_11_10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_11_5)
end

function var_0_0._onClickDetail(arg_12_0)
	local var_12_0 = SummonMainModel.instance:getCurPool()

	if not var_12_0 then
		return
	end

	local var_12_1 = arg_12_0:getPickHeroIds(var_12_0)

	if var_12_1 and #var_12_1 > 0 then
		local var_12_2 = var_12_1[1]

		if var_12_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_12_2
			})
		end
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._animRoot = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_13_0._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_13_0._characteritem = arg_13_0:getUserDataTb_()
	arg_13_0._characteritem.go = arg_13_0._gocharacteritem1
	arg_13_0._characteritem.imagecareer = gohelper.findChildImage(arg_13_0._characteritem.go, "image_career")
	arg_13_0._characteritem.txtnamecn = gohelper.findChildText(arg_13_0._characteritem.go, "txt_namecn")
	arg_13_0._characteritem.btndetail = gohelper.findChildButtonWithAudio(arg_13_0._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	arg_13_0._characteritem.gorole = gohelper.findChild(arg_13_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_13_0._characteritem.simagehero = arg_13_0._simagerole1selected
	arg_13_0._characteritem.simageheroRefresh = arg_13_0._simagerolerefresh
	arg_13_0._characteritem.rares = arg_13_0:getUserDataTb_()

	for iter_13_0 = 1, 6 do
		local var_13_0 = gohelper.findChild(arg_13_0._characteritem.go, "rare/go_rare" .. iter_13_0)

		table.insert(arg_13_0._characteritem.rares, var_13_0)
	end

	arg_13_0._btncheck1 = gohelper.findChildButton(arg_13_0.viewGO, "#go_ui/current/#go_unselected/#btn_check_1")
	arg_13_0._btncheck2 = gohelper.findChildButton(arg_13_0.viewGO, "#go_ui/current/#go_selected/#btn_check_2")

	arg_13_0._btncheck1:AddClickListener(arg_13_0._btnOpenOnClick1, arg_13_0)
	arg_13_0._btncheck2:AddClickListener(arg_13_0._btnOpenOnClick2, arg_13_0)
	arg_13_0._characteritem.btndetail:AddClickListener(arg_13_0._onClickDetail, arg_13_0)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:addAllEvents()
	arg_14_0:playEnterAnim()
	arg_14_0:refreshView()
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeAllEvents()
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagecurrency1:UnLoadImage()
	arg_16_0._simagecurrency10:UnLoadImage()
	arg_16_0._simagecurrency10normal:UnLoadImage()
	arg_16_0._simageline3:UnLoadImage()

	if arg_16_0._compFreeButton then
		arg_16_0._compFreeButton:dispose()

		arg_16_0._compFreeButton = nil
	end

	if arg_16_0._characteritem then
		arg_16_0._characteritem.btndetail:RemoveClickListener()
		arg_16_0._characteritem.simagehero:UnLoadImage()
		arg_16_0._characteritem.simageheroRefresh:UnLoadImage()
		arg_16_0._simagerole1outline:UnLoadImage()

		arg_16_0._characteritem = nil
	end

	arg_16_0._btncheck1:RemoveClickListener()
	arg_16_0._btncheck2:RemoveClickListener()
end

function var_0_0.refreshFreeSummonButton(arg_17_0, arg_17_1)
	arg_17_0._compFreeButton = arg_17_0._compFreeButton or SummonFreeSingleGacha.New(arg_17_0._btnsummon1.gameObject, arg_17_1.id)

	arg_17_0._compFreeButton:refreshUI()
end

function var_0_0.refreshCost(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if var_18_0 then
		arg_18_0:_refreshSingleCost(var_18_0.cost1, arg_18_0._simagecurrency1, "_txtcurrency1")
		arg_18_0:refreshCost10(var_18_0.cost10)
	end
end

function var_0_0._refreshSingleCost(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1, var_19_2 = SummonMainModel.instance.getCostByConfig(arg_19_1)
	local var_19_3 = SummonMainModel.instance.getSummonItemIcon(var_19_0, var_19_1)

	arg_19_2:LoadImage(var_19_3)

	arg_19_0[arg_19_3 .. "1"].text = luaLang("multiple") .. var_19_2
	arg_19_0[arg_19_3 .. "2"].text = ""
end

function var_0_0.refreshCost10(arg_20_0, arg_20_1)
	local var_20_0, var_20_1, var_20_2 = SummonMainModel.instance.getCostByConfig(arg_20_1)
	local var_20_3 = SummonMainModel.instance.getSummonItemIcon(var_20_0, var_20_1)

	arg_20_0._simagecurrency10:LoadImage(var_20_3)
	arg_20_0._simagecurrency10normal:LoadImage(var_20_3)

	local var_20_4 = SummonMainModel.instance:getCurId()
	local var_20_5 = SummonMainModel.instance:getDiscountCostId(var_20_4)
	local var_20_6 = SummonMainModel.instance:getDiscountTime10Server(var_20_4)
	local var_20_7 = var_20_6 > 0

	gohelper.setActive(arg_20_0._gotip2bg, var_20_7)
	gohelper.setActive(arg_20_0._txttips.gameObject, var_20_7)
	gohelper.setActive(arg_20_0._gosummon10, var_20_7)
	gohelper.setActive(arg_20_0._gosummon10normal, not var_20_7)

	local var_20_8 = ""
	local var_20_9 = ""

	if var_20_1 == var_20_5 then
		gohelper.setActive(arg_20_0._gocount, var_20_6 > 0)

		if var_20_6 > 0 then
			local var_20_10 = SummonMainModel.instance:getDiscountCost10(var_20_4)

			var_20_8 = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. var_20_10)
			var_20_9 = var_20_2

			local var_20_11 = (var_20_2 - var_20_10) / var_20_2 * 100

			arg_20_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_20_11)
		else
			var_20_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_20_2)
		end
	else
		var_20_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_20_2)

		gohelper.setActive(arg_20_0._gocount, false)
	end

	arg_20_0._txtcurrency101.text = var_20_8
	arg_20_0._txtcurrency101normal.text = var_20_8
	arg_20_0._txtcurrency102.text = var_20_9
	arg_20_0._txtcurrency102normal.text = var_20_9
end

function var_0_0.getPickHeroIds(arg_21_0, arg_21_1)
	local var_21_0 = SummonMainModel.instance:getPoolServerMO(arg_21_1.id)

	if var_21_0 and var_21_0.customPickMO then
		return var_21_0.customPickMO.pickHeroIds
	end

	return nil
end

function var_0_0.refreshPickHero(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getPickHeroIds(arg_22_1)
	local var_22_1 = var_22_0 and var_22_0[1] or nil

	if var_22_1 ~= nil and arg_22_0._characteritem then
		local var_22_2 = HeroConfig.instance:getHeroCO(var_22_1)

		UISpriteSetMgr.instance:setCommonSprite(arg_22_0._characteritem.imagecareer, "lssx_" .. tostring(var_22_2.career))

		arg_22_0._characteritem.txtnamecn.text = var_22_2.name

		for iter_22_0 = 1, 6 do
			gohelper.setActive(arg_22_0._characteritem.rares[iter_22_0], iter_22_0 <= CharacterEnum.Star[var_22_2.rare])
		end

		local var_22_3, var_22_4, var_22_5 = arg_22_0:getOffset(var_22_2.skinId)

		arg_22_0._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(var_22_2.skinId), arg_22_0.handleLoadedImage, {
			imgTransform = arg_22_0._simagerole1selected.gameObject.transform,
			offsetX = var_22_3,
			offsetY = var_22_4,
			scale = var_22_5
		})
		arg_22_0._simagerole1outline:LoadImage(ResUrl.getHeadIconImg(var_22_2.skinId), arg_22_0.handleLoadedImage, {
			imgTransform = arg_22_0._simagerole1outline.gameObject.transform,
			offsetX = var_22_3 - 5,
			offsetY = var_22_4 + 2,
			scale = var_22_5
		})
		arg_22_0._simagerolerefresh:LoadImage(ResUrl.getHandbookheroIcon(var_22_2.skinId), nil)
	end
end

function var_0_0.getOffset(arg_23_0, arg_23_1)
	local var_23_0 = SkinConfig.instance:getSkinCo(arg_23_1).skinViewImgOffset

	if not string.nilorempty(var_23_0) then
		local var_23_1 = string.splitToNumber(var_23_0, "#")
		local var_23_2 = var_23_1[1]
		local var_23_3 = var_23_1[2]
		local var_23_4 = var_23_1[3]

		return var_23_2, var_23_3, var_23_4
	end

	return -150, -150, 0.6
end

function var_0_0.handleLoadedImage(arg_24_0)
	local var_24_0 = arg_24_0.imgTransform
	local var_24_1 = arg_24_0.offsetX or 0
	local var_24_2 = arg_24_0.offsetY or 0
	local var_24_3 = arg_24_0.scale or 1

	ZProj.UGUIHelper.SetImageSize(var_24_0.gameObject)
	recthelper.setAnchor(var_24_0, var_24_1, var_24_2)
	transformhelper.setLocalScale(var_24_0, var_24_3, var_24_3, var_24_3)
end

function var_0_0.refreshView(arg_25_0)
	arg_25_0.summonSuccess = false

	local var_25_0 = SummonMainModel.instance:getList()

	if not var_25_0 or #var_25_0 <= 0 then
		gohelper.setActive(arg_25_0._goui, false)

		return
	end

	arg_25_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_26_0)
	local var_26_0 = SummonMainModel.instance:getCurPool()

	if not var_26_0 then
		return
	end

	local var_26_1 = SummonCustomPickModel.instance:isCustomPickOver(var_26_0.id)

	arg_26_0:refreshPickHero(var_26_0)
	gohelper.setActive(arg_26_0._goselected, var_26_1)
	gohelper.setActive(arg_26_0._gounselected, not var_26_1)

	if var_26_1 then
		arg_26_0:refreshCost()
		arg_26_0:refreshFreeSummonButton(var_26_0)
	end

	local var_26_2 = SummonCustomPickModel.instance:isHaveFirstSSR(var_26_0.id)

	gohelper.setActive(arg_26_0._simagetips.gameObject, not var_26_2)
	gohelper.setActive(arg_26_0._simagetips2.gameObject, var_26_2)
	arg_26_0:_refreshOpenTime()

	local var_26_3 = SummonMainModel.instance:getDiscountCost10(var_26_0.id, 1)

	arg_26_0._txttips.text = string.format(luaLang("summon_discount_tips"), var_26_3)
end

function var_0_0._refreshOpenTime(arg_27_0)
	local var_27_0 = SummonMainModel.instance:getCurPool()

	if not var_27_0 then
		return
	end

	local var_27_1 = SummonMainModel.instance:getPoolServerMO(var_27_0.id)

	if var_27_1 ~= nil and var_27_1.offlineTime ~= 0 and var_27_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_27_2 = var_27_1.offlineTime - ServerTime.now()

		arg_27_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_27_2))
	else
		arg_27_0._txtdeadline.text = ""
	end
end

function var_0_0.playEnterAnim(arg_28_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_28_0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_28_0:playAnim(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_29_0)
	arg_29_0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.playAnim(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0._animRoot ~= nil then
		arg_30_0._animRoot:Play(arg_30_1, arg_30_2, arg_30_3)
	end
end

function var_0_0.addAllEvents(arg_31_0)
	arg_31_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_31_0.onSummonFailed, arg_31_0)
	arg_31_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_31_0.onSummonReply, arg_31_0)
	arg_31_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_31_0.playerEnterAnimFromScene, arg_31_0)
	arg_31_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_31_0.onItemChanged, arg_31_0)
	arg_31_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_31_0.onItemChanged, arg_31_0)
	arg_31_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_31_0.refreshView, arg_31_0)
	arg_31_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_31_0._refreshOpenTime, arg_31_0)
end

function var_0_0.removeAllEvents(arg_32_0)
	arg_32_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_32_0.onSummonFailed, arg_32_0)
	arg_32_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_32_0.onSummonReply, arg_32_0)
	arg_32_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_32_0.playerEnterAnimFromScene, arg_32_0)
	arg_32_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_32_0.onItemChanged, arg_32_0)
	arg_32_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_32_0.onItemChanged, arg_32_0)
	arg_32_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_32_0.refreshView, arg_32_0)
	arg_32_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_32_0._refreshOpenTime, arg_32_0)
end

function var_0_0._summon10Confirm(arg_33_0)
	local var_33_0 = SummonMainModel.instance:getCurPool()

	if not var_33_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_33_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_34_0)
	local var_34_0 = SummonMainModel.instance:getCurPool()

	if not var_34_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_34_0.id, 1, false, true)
end

function var_0_0.onItemChanged(arg_35_0)
	if SummonController.instance.isWaitingSummonResult or arg_35_0.summonSuccess then
		return
	end

	arg_35_0:refreshCost()
end

function var_0_0.onSummonFailed(arg_36_0)
	arg_36_0.summonSuccess = false

	arg_36_0:refreshCost()
end

function var_0_0.onSummonReply(arg_37_0)
	arg_37_0.summonSuccess = true
end

function var_0_0._btnOpenOnClick1(arg_38_0)
	local var_38_0 = SummonMainModel.instance:getCurPool()
	local var_38_1 = SummonConfig.instance:getStrongCustomChoiceIds(var_38_0.id)
	local var_38_2 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = var_38_1
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_38_2)
end

function var_0_0._btnOpenOnClick2(arg_39_0)
	local var_39_0 = SummonMainModel.instance:getCurPool()
	local var_39_1 = SummonConfig.instance:getStrongCustomChoiceIds(var_39_0.id)
	local var_39_2 = arg_39_0:getPickHeroIds(var_39_0)[1]
	local var_39_3

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		if iter_39_1 == var_39_2 then
			var_39_3 = iter_39_0

			break
		end
	end

	if var_39_3 then
		table.remove(var_39_1, var_39_3)
		table.insert(var_39_1, 1, var_39_2)
	end

	local var_39_4 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = var_39_1
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_39_4)
end

return var_0_0
