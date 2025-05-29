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

	local var_8_1, var_8_2, var_8_3 = SummonMainModel.getCostByConfig(var_8_0.cost1)
	local var_8_4 = {
		type = var_8_1,
		id = var_8_2,
		quantity = var_8_3,
		callback = arg_8_0._summon1Confirm,
		callbackObj = arg_8_0
	}

	var_8_4.notEnough = false

	local var_8_5 = var_8_3 <= ItemModel.instance:getItemQuantity(var_8_1, var_8_2)
	local var_8_6 = SummonMainModel.instance.everyCostCount
	local var_8_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_8_5 and var_8_7 < var_8_6 then
		var_8_4.notEnough = true
	end

	if var_8_5 then
		var_8_4.needTransform = false

		arg_8_0:_summon1Confirm()

		return
	else
		var_8_4.needTransform = true
		var_8_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_8_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_8_4.cost_quantity = var_8_6
		var_8_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_8_4)
end

function var_0_0._btnsummon10OnClick(arg_9_0)
	local var_9_0 = SummonMainModel.instance:getCurPool()

	if not var_9_0 then
		return
	end

	local var_9_1, var_9_2, var_9_3 = SummonMainModel.getCostByConfig(var_9_0.cost10)
	local var_9_4 = SummonMainModel.instance:getDiscountCost10(var_9_0.id)

	if SummonMainModel.instance:getDiscountCostId(var_9_0.id) == var_9_2 then
		var_9_3 = var_9_4 < 0 and var_9_3 or var_9_4
	end

	local var_9_5 = {
		type = var_9_1,
		id = var_9_2,
		quantity = var_9_3,
		callback = arg_9_0._summon10Confirm,
		callbackObj = arg_9_0
	}

	var_9_5.notEnough = false

	local var_9_6 = ItemModel.instance:getItemQuantity(var_9_1, var_9_2)
	local var_9_7 = var_9_3 <= var_9_6
	local var_9_8 = SummonMainModel.instance.everyCostCount
	local var_9_9 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_9_10 = var_9_3 - var_9_6
	local var_9_11 = var_9_8 * var_9_10

	if not var_9_7 and var_9_9 < var_9_11 then
		var_9_5.notEnough = true
	end

	if var_9_7 then
		var_9_5.needTransform = false

		arg_9_0:_summon10Confirm()

		return
	else
		var_9_5.needTransform = true
		var_9_5.cost_type = SummonMainModel.instance.costCurrencyType
		var_9_5.cost_id = SummonMainModel.instance.costCurrencyId
		var_9_5.cost_quantity = var_9_11
		var_9_5.miss_quantity = var_9_10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_9_5)
end

function var_0_0._onClickDetail(arg_10_0)
	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0:getPickHeroIds(var_10_0)

	if var_10_1 and #var_10_1 > 0 then
		local var_10_2 = var_10_1[1]

		if var_10_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_10_2
			})
		end
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._animRoot = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_11_0._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_11_0._characteritem = arg_11_0:getUserDataTb_()
	arg_11_0._characteritem.go = arg_11_0._gocharacteritem1
	arg_11_0._characteritem.imagecareer = gohelper.findChildImage(arg_11_0._characteritem.go, "image_career")
	arg_11_0._characteritem.txtnamecn = gohelper.findChildText(arg_11_0._characteritem.go, "txt_namecn")
	arg_11_0._characteritem.btndetail = gohelper.findChildButtonWithAudio(arg_11_0._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	arg_11_0._characteritem.gorole = gohelper.findChild(arg_11_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_11_0._characteritem.simagehero = arg_11_0._simagerole1selected
	arg_11_0._characteritem.simageheroRefresh = arg_11_0._simagerolerefresh
	arg_11_0._characteritem.rares = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, 6 do
		local var_11_0 = gohelper.findChild(arg_11_0._characteritem.go, "rare/go_rare" .. iter_11_0)

		table.insert(arg_11_0._characteritem.rares, var_11_0)
	end

	arg_11_0._btncheck1 = gohelper.findChildButton(arg_11_0.viewGO, "#go_ui/current/#go_unselected/#btn_check_1")
	arg_11_0._btncheck2 = gohelper.findChildButton(arg_11_0.viewGO, "#go_ui/current/#go_selected/#btn_check_2")

	arg_11_0._btncheck1:AddClickListener(arg_11_0._btnOpenOnClick1, arg_11_0)
	arg_11_0._btncheck2:AddClickListener(arg_11_0._btnOpenOnClick2, arg_11_0)
	arg_11_0._characteritem.btndetail:AddClickListener(arg_11_0._onClickDetail, arg_11_0)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addAllEvents()
	arg_12_0:playEnterAnim()
	arg_12_0:refreshView()
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:removeAllEvents()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagecurrency1:UnLoadImage()
	arg_14_0._simagecurrency10:UnLoadImage()
	arg_14_0._simagecurrency10normal:UnLoadImage()
	arg_14_0._simageline3:UnLoadImage()

	if arg_14_0._compFreeButton then
		arg_14_0._compFreeButton:dispose()

		arg_14_0._compFreeButton = nil
	end

	if arg_14_0._characteritem then
		arg_14_0._characteritem.btndetail:RemoveClickListener()
		arg_14_0._characteritem.simagehero:UnLoadImage()
		arg_14_0._characteritem.simageheroRefresh:UnLoadImage()
		arg_14_0._simagerole1outline:UnLoadImage()

		arg_14_0._characteritem = nil
	end

	arg_14_0._btncheck1:RemoveClickListener()
	arg_14_0._btncheck2:RemoveClickListener()
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
	arg_18_0._simagecurrency10normal:LoadImage(var_18_3)

	local var_18_4 = SummonMainModel.instance:getCurId()
	local var_18_5 = SummonMainModel.instance:getDiscountCostId(var_18_4)
	local var_18_6 = SummonMainModel.instance:getDiscountTime10Server(var_18_4)
	local var_18_7 = var_18_6 > 0

	gohelper.setActive(arg_18_0._gotip2bg, var_18_7)
	gohelper.setActive(arg_18_0._txttips.gameObject, var_18_7)
	gohelper.setActive(arg_18_0._gosummon10, var_18_7)
	gohelper.setActive(arg_18_0._gosummon10normal, not var_18_7)

	local var_18_8 = ""
	local var_18_9 = ""

	if var_18_1 == var_18_5 then
		gohelper.setActive(arg_18_0._gocount, var_18_6 > 0)

		if var_18_6 > 0 then
			local var_18_10 = SummonMainModel.instance:getDiscountCost10(var_18_4)

			var_18_8 = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. var_18_10)
			var_18_9 = var_18_2

			local var_18_11 = (var_18_2 - var_18_10) / var_18_2 * 100

			arg_18_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_18_11)
		else
			var_18_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_18_2)
		end
	else
		var_18_8 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. var_18_2)

		gohelper.setActive(arg_18_0._gocount, false)
	end

	arg_18_0._txtcurrency101.text = var_18_8
	arg_18_0._txtcurrency101normal.text = var_18_8
	arg_18_0._txtcurrency102.text = var_18_9
	arg_18_0._txtcurrency102normal.text = var_18_9
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
	local var_20_1 = var_20_0 and var_20_0[1] or nil

	if var_20_1 ~= nil and arg_20_0._characteritem then
		local var_20_2 = HeroConfig.instance:getHeroCO(var_20_1)

		UISpriteSetMgr.instance:setCommonSprite(arg_20_0._characteritem.imagecareer, "lssx_" .. tostring(var_20_2.career))

		arg_20_0._characteritem.txtnamecn.text = var_20_2.name

		for iter_20_0 = 1, 6 do
			gohelper.setActive(arg_20_0._characteritem.rares[iter_20_0], iter_20_0 <= CharacterEnum.Star[var_20_2.rare])
		end

		local var_20_3, var_20_4, var_20_5 = arg_20_0:getOffset(var_20_2.skinId)

		arg_20_0._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(var_20_2.skinId), arg_20_0.handleLoadedImage, {
			imgTransform = arg_20_0._simagerole1selected.gameObject.transform,
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
		arg_20_0._simagerolerefresh:LoadImage(ResUrl.getHandbookheroIcon(var_20_2.skinId), nil)
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
	local var_22_1 = arg_22_0.offsetX or 0
	local var_22_2 = arg_22_0.offsetY or 0
	local var_22_3 = arg_22_0.scale or 1

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

	local var_24_1 = SummonCustomPickModel.instance:isCustomPickOver(var_24_0.id)

	arg_24_0:refreshPickHero(var_24_0)
	gohelper.setActive(arg_24_0._goselected, var_24_1)
	gohelper.setActive(arg_24_0._gounselected, not var_24_1)

	if var_24_1 then
		arg_24_0:refreshCost()
		arg_24_0:refreshFreeSummonButton(var_24_0)
	end

	local var_24_2 = SummonCustomPickModel.instance:isHaveFirstSSR(var_24_0.id)

	gohelper.setActive(arg_24_0._simagetips.gameObject, not var_24_2)
	gohelper.setActive(arg_24_0._simagetips2.gameObject, var_24_2)
	arg_24_0:_refreshOpenTime()

	local var_24_3 = SummonMainModel.instance:getDiscountCost10(var_24_0.id, 1)

	arg_24_0._txttips.text = string.format(luaLang("summon_discount_tips"), var_24_3)
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
		arg_26_0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_26_0:playAnim(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_27_0)
	arg_27_0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.playAnim(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_0._animRoot ~= nil then
		arg_28_0._animRoot:Play(arg_28_1, arg_28_2, arg_28_3)
	end
end

function var_0_0.addAllEvents(arg_29_0)
	arg_29_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_29_0.onSummonFailed, arg_29_0)
	arg_29_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_29_0.onSummonReply, arg_29_0)
	arg_29_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_29_0.playerEnterAnimFromScene, arg_29_0)
	arg_29_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_29_0.onItemChanged, arg_29_0)
	arg_29_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_29_0.onItemChanged, arg_29_0)
	arg_29_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_29_0.refreshView, arg_29_0)
	arg_29_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_29_0._refreshOpenTime, arg_29_0)
end

function var_0_0.removeAllEvents(arg_30_0)
	arg_30_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_30_0.onSummonFailed, arg_30_0)
	arg_30_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_30_0.onSummonReply, arg_30_0)
	arg_30_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_30_0.playerEnterAnimFromScene, arg_30_0)
	arg_30_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_30_0.onItemChanged, arg_30_0)
	arg_30_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_30_0.onItemChanged, arg_30_0)
	arg_30_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_30_0.refreshView, arg_30_0)
	arg_30_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_30_0._refreshOpenTime, arg_30_0)
end

function var_0_0._summon10Confirm(arg_31_0)
	local var_31_0 = SummonMainModel.instance:getCurPool()

	if not var_31_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_31_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_32_0)
	local var_32_0 = SummonMainModel.instance:getCurPool()

	if not var_32_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_32_0.id, 1, false, true)
end

function var_0_0.onItemChanged(arg_33_0)
	if SummonController.instance.isWaitingSummonResult or arg_33_0.summonSuccess then
		return
	end

	arg_33_0:refreshCost()
end

function var_0_0.onSummonFailed(arg_34_0)
	arg_34_0.summonSuccess = false

	arg_34_0:refreshCost()
end

function var_0_0.onSummonReply(arg_35_0)
	arg_35_0.summonSuccess = true
end

function var_0_0._btnOpenOnClick1(arg_36_0)
	local var_36_0 = SummonMainModel.instance:getCurPool()
	local var_36_1 = SummonConfig.instance:getStrongCustomChoiceIds(var_36_0.id)
	local var_36_2 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = var_36_1
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_36_2)
end

function var_0_0._btnOpenOnClick2(arg_37_0)
	local var_37_0 = SummonMainModel.instance:getCurPool()
	local var_37_1 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = arg_37_0:getPickHeroIds(var_37_0)
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_37_1)
end

return var_0_0
