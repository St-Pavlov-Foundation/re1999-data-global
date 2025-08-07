module("modules.logic.summon.view.custompick.SummonThreeCustomPickView", package.seeall)

local var_0_0 = class("SummonThreeCustomPickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_unselected")
	arg_1_0._simagebgunselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect")
	arg_1_0._simageunselect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_unselect")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#simage_line")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_bg")
	arg_1_0._simageline1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_line1")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	arg_1_0._simagerole1outline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	arg_1_0._gorole3 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role3")
	arg_1_0._simagerole3outline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3_outline")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3")
	arg_1_0._gocharacteritem3 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role3/#go_characteritem3")
	arg_1_0._simagemask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_mask2")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2")
	arg_1_0._simagerole2outline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2_outline")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2")
	arg_1_0._gocharacteritem2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/#go_selected/#go_role2/#go_characteritem2")
	arg_1_0._simageline31 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_line3_1")
	arg_1_0._simageline32 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_line3_2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_mask")
	arg_1_0._simageline2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#go_selected/#simage_line2")
	arg_1_0._simagefrontbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frontbg1")
	arg_1_0._simagefrontbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frontbg2")
	arg_1_0._simagetitle1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/title/#simage_title1")
	arg_1_0._simagetips = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/#simage_tips")
	arg_1_0._gotip2bg = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/tip/#go_tip2bg")
	arg_1_0._txttips2 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/tip/#txt_tips2")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
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

function var_0_0._editableInitView(arg_4_0)
	logNormal("SummonThreeCustomPickView:_editableInitView()")

	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_4_0._txttips = gohelper.findChildText(arg_4_0.viewGO, "#go_ui/current/txt_tips")
	arg_4_0._characteritems = {}

	local var_4_0 = SummonMainModel.instance:getCurPool()

	arg_4_0._charaterItemCount = arg_4_0._charaterItemCount or SummonCustomPickModel.instance:getMaxSelectCount(var_4_0.id)

	for iter_4_0 = 1, arg_4_0._charaterItemCount do
		local var_4_1 = arg_4_0:getUserDataTb_()
		local var_4_2 = tostring(iter_4_0)
		local var_4_3 = string.format("#go_ui/current/#go_selected/#go_role%s/#go_characteritem%s", var_4_2, var_4_2)

		var_4_1.go = gohelper.findChild(arg_4_0.viewGO, var_4_3)
		var_4_1.imagecareer = gohelper.findChildImage(var_4_1.go, "image_career")
		var_4_1.txtnamecn = gohelper.findChildText(var_4_1.go, "txt_namecn")
		var_4_1.btndetail = gohelper.findChildButtonWithAudio(var_4_1.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		var_4_1.gorole = gohelper.findChild(arg_4_0.viewGO, "#go_ui/current/#go_selected/#go_role" .. var_4_2)
		var_4_1.simagehero = gohelper.findChildSingleImage(var_4_1.gorole, "#simage_role" .. var_4_2)
		var_4_1.simageroleoutline = gohelper.findChildSingleImage(var_4_1.gorole, string.format("#simage_role%s_outline", var_4_2))
		var_4_1.tfimagehero = var_4_1.simagehero.transform
		var_4_1.rares = {}

		for iter_4_1 = 1, 6 do
			local var_4_4 = gohelper.findChild(var_4_1.go, "rare/go_rare" .. iter_4_1)

			table.insert(var_4_1.rares, var_4_4)
		end

		table.insert(arg_4_0._characteritems, var_4_1)
		var_4_1.btndetail:AddClickListener(arg_4_0._onClickDetailByIndex, arg_4_0, iter_4_0)
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	logNormal("SummonThreeCustomPickView:onOpen()")
	arg_6_0:playEnterAnim()
	arg_6_0:refreshView()
	arg_6_0:addAllEvents()
end

function var_0_0.onClose(arg_7_0)
	logNormal("SummonThreeCustomPickView:onClose()")
	arg_7_0:removeAllEvents()
end

function var_0_0.onDestroyView(arg_8_0)
	logNormal("SummonThreeCustomPickView:onDestroyView()")
	arg_8_0._simagebg:UnLoadImage()
	arg_8_0._simagebgunselect:UnLoadImage()
	arg_8_0._simageunselect:UnLoadImage()
	arg_8_0._simagecurrency1:UnLoadImage()
	arg_8_0._simagecurrency10:UnLoadImage()
	arg_8_0._simageline:UnLoadImage()
	arg_8_0._simageline1:UnLoadImage()
	arg_8_0._simageline2:UnLoadImage()
	arg_8_0._simageline3:UnLoadImage()
	arg_8_0._simageline31:UnLoadImage()
	arg_8_0._simageline32:UnLoadImage()
	arg_8_0._simagemask:UnLoadImage()
	arg_8_0._simagemask2:UnLoadImage()
	arg_8_0._simagefrontbg1:UnLoadImage()
	arg_8_0._simagefrontbg2:UnLoadImage()
	arg_8_0._simagetitle1:UnLoadImage()
	arg_8_0._simagetips:UnLoadImage()

	if arg_8_0._compFreeButton then
		arg_8_0._compFreeButton:dispose()

		arg_8_0._compFreeButton = nil
	end

	if arg_8_0._characteritems then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._characteritems) do
			iter_8_1.btndetail:RemoveClickListener()
			iter_8_1.simagehero:UnLoadImage()
			iter_8_1.simageroleoutline:UnLoadImage()
		end

		arg_8_0._characteritems = nil
	end
end

function var_0_0._btnselfselectOnClick(arg_9_0)
	local var_9_0 = SummonMainModel.instance:getCurPool()

	if not var_9_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = var_9_0.id
	})
end

function var_0_0._btnsummon1OnClick(arg_10_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0:getPickHeroIds(var_10_0)
	local var_10_2 = SummonModel.instance:getSummonFullExSkillHero(var_10_0.id, var_10_1)

	if var_10_2 == nil then
		arg_10_0:_btnsummon1OnClick_2()
	else
		local var_10_3 = HeroConfig.instance:getHeroCO(var_10_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_10_0.id, arg_10_0._btnsummon1OnClick_2, nil, nil, arg_10_0, nil, nil, var_10_3)
	end
end

function var_0_0._btnsummon1OnClick_2(arg_11_0)
	local var_11_0 = SummonMainModel.instance
	local var_11_1 = var_11_0:getCurPool()

	if not var_11_1 then
		return
	end

	local var_11_2, var_11_3, var_11_4 = var_11_0.getCostByConfig(var_11_1.cost1)
	local var_11_5 = {
		type = var_11_2,
		id = var_11_3,
		quantity = var_11_4,
		callback = arg_11_0._summon1Confirm,
		callbackObj = arg_11_0
	}

	var_11_5.notEnough = false

	local var_11_6 = var_11_4 <= ItemModel.instance:getItemQuantity(var_11_2, var_11_3)
	local var_11_7 = var_11_0.everyCostCount
	local var_11_8 = var_11_0:getOwnCostCurrencyNum()

	if not var_11_6 and var_11_8 < var_11_7 then
		var_11_5.notEnough = true
	end

	if var_11_6 then
		var_11_5.needTransform = false

		arg_11_0:_summon1Confirm()

		return
	else
		var_11_5.needTransform = true
		var_11_5.cost_type = var_11_0.costCurrencyType
		var_11_5.cost_id = var_11_0.costCurrencyId
		var_11_5.cost_quantity = var_11_7
		var_11_5.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_11_5)
end

function var_0_0._btnsummon10OnClick(arg_12_0)
	local var_12_0 = SummonMainModel.instance:getCurPool()

	if not var_12_0 then
		return
	end

	local var_12_1 = arg_12_0:getPickHeroIds(var_12_0)
	local var_12_2 = SummonModel.instance:getSummonFullExSkillHero(var_12_0.id, var_12_1)

	if var_12_2 == nil then
		arg_12_0:_btnsummon10OnClick_2()
	else
		local var_12_3 = HeroConfig.instance:getHeroCO(var_12_2).name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, var_12_0.id, arg_12_0._btnsummon10OnClick_2, nil, nil, arg_12_0, nil, nil, var_12_3)
	end
end

function var_0_0._btnsummon10OnClick_2(arg_13_0)
	local var_13_0 = SummonMainModel.instance:getCurPool()

	if not var_13_0 then
		return
	end

	local var_13_1 = SummonMainModel.instance
	local var_13_2, var_13_3, var_13_4, var_13_5 = var_13_1.getCostByConfig(var_13_0.cost10)
	local var_13_6 = var_13_1:getDiscountCost10(var_13_0.id)

	if var_13_1:getDiscountCostId(var_13_0.id) == var_13_3 then
		var_13_4 = var_13_6 < 0 and var_13_4 or var_13_6
	end

	local var_13_7 = {
		type = var_13_2,
		id = var_13_3,
		quantity = var_13_4,
		callback = arg_13_0._summon10Confirm,
		callbackObj = arg_13_0
	}

	var_13_7.notEnough = false
	var_13_5 = var_13_5 or ItemModel.instance:getItemQuantity(var_13_2, var_13_3)

	local var_13_8 = var_13_4 <= var_13_5
	local var_13_9 = var_13_1.everyCostCount
	local var_13_10 = var_13_1:getOwnCostCurrencyNum()
	local var_13_11 = var_13_4 - var_13_5
	local var_13_12 = var_13_9 * var_13_11

	if not var_13_8 and var_13_10 < var_13_12 then
		var_13_7.notEnough = true
	end

	if var_13_8 then
		var_13_7.needTransform = false

		arg_13_0:_summon10Confirm()

		return
	else
		var_13_7.needTransform = true
		var_13_7.cost_type = var_13_1.costCurrencyType
		var_13_7.cost_id = var_13_1.costCurrencyId
		var_13_7.cost_quantity = var_13_12
		var_13_7.miss_quantity = var_13_11
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_13_7)
end

function var_0_0._summon10Confirm(arg_14_0)
	local var_14_0 = SummonMainModel.instance:getCurPool()

	if not var_14_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_14_0.id, 10, false, true)
end

function var_0_0._summon1Confirm(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_15_0.id, 1, false, true)
end

function var_0_0.refreshView(arg_16_0)
	arg_16_0.summonSuccess = false

	local var_16_0 = SummonMainModel.instance:getList()

	if not var_16_0 or #var_16_0 <= 0 then
		gohelper.setActive(arg_16_0._goui, false)

		return
	end

	arg_16_0:refreshPoolUI()
end

function var_0_0.getPickHeroIds(arg_17_0, arg_17_1)
	local var_17_0 = SummonMainModel.instance:getPoolServerMO(arg_17_1.id)

	if var_17_0 and var_17_0.customPickMO then
		return var_17_0.customPickMO.pickHeroIds
	end

	return nil
end

function var_0_0.refreshPoolUI(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	local var_18_1 = SummonCustomPickModel.instance:isCustomPickOver(var_18_0.id)

	arg_18_0:handlePickStatus(var_18_1, var_18_0)
	arg_18_0:_refreshOpenTime()
end

function var_0_0.handlePickStatus(arg_19_0, arg_19_1, arg_19_2)
	gohelper.setActive(arg_19_0._gosummonbtns, arg_19_1)
	gohelper.setActive(arg_19_0._goselected, arg_19_1)

	local var_19_0 = not arg_19_1

	gohelper.setActive(arg_19_0._simageunselect, var_19_0)
	gohelper.setActive(arg_19_0._goselfselect, var_19_0)
	gohelper.setActive(arg_19_0._txttips, var_19_0)
	gohelper.setActive(arg_19_0._simageunselect, var_19_0)

	if arg_19_1 then
		arg_19_0:refreshCost()
		arg_19_0:refreshFreeSummonButton(arg_19_2)
		arg_19_0:refreshPickHeroes(arg_19_2)
	else
		for iter_19_0 = 1, arg_19_0._charaterItemCount do
			arg_19_0:refreshPickHero(arg_19_2.id, iter_19_0, nil)
		end
	end
end

function var_0_0.refreshPickHeroes(arg_20_0, arg_20_1)
	local var_20_0 = SummonMainModel.instance:getPoolServerMO(arg_20_1.id)

	if var_20_0 and var_20_0.customPickMO then
		local var_20_1 = var_20_0.customPickMO.pickHeroIds

		table.sort(var_20_1)

		for iter_20_0 = 1, arg_20_0._charaterItemCount do
			local var_20_2 = var_20_1[iter_20_0]

			arg_20_0:refreshPickHero(arg_20_1.id, iter_20_0, var_20_2)
		end
	end
end

function var_0_0.refreshPickHero(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0._characteritems[arg_21_2]

	if var_21_0 then
		if arg_21_3 then
			gohelper.setActive(var_21_0.go, true)
			gohelper.setActive(var_21_0.simagehero, true)

			local var_21_1 = HeroConfig.instance:getHeroCO(arg_21_3)

			UISpriteSetMgr.instance:setCommonSprite(var_21_0.imagecareer, "lssx_" .. tostring(var_21_1.career))

			var_21_0.txtnamecn.text = var_21_1.name

			for iter_21_0 = 1, 6 do
				gohelper.setActive(var_21_0.rares[iter_21_0], iter_21_0 <= CharacterEnum.Star[var_21_1.rare])
			end

			local var_21_2, var_21_3, var_21_4 = arg_21_0:getOffset(var_21_1.skinId)

			var_21_0.simagehero:LoadImage(ResUrl.getHeadIconImg(var_21_1.skinId), arg_21_0.handleLoadedImageOutline, {
				imgTransform = var_21_0.simagehero.gameObject.transform,
				offsetX = var_21_2,
				offsetY = var_21_3,
				scale = var_21_4
			})
			var_21_0.simageroleoutline:LoadImage(ResUrl.getHeadIconImg(var_21_1.skinId), arg_21_0.handleLoadedImageOutline, {
				imgTransform = var_21_0.simageroleoutline.gameObject.transform,
				offsetX = var_21_2 - 5,
				offsetY = var_21_3 + 2,
				scale = var_21_4
			})
		else
			gohelper.setActive(var_21_0.go, false)
			gohelper.setActive(var_21_0.simagehero, false)
		end
	end
end

function var_0_0.getOffset(arg_22_0, arg_22_1)
	local var_22_0 = SkinConfig.instance:getSkinCo(arg_22_1).summonPickUpImgOffset

	if not string.nilorempty(var_22_0) then
		local var_22_1 = string.splitToNumber(var_22_0, "#")
		local var_22_2 = var_22_1[1]
		local var_22_3 = var_22_1[2]
		local var_22_4 = var_22_1[3]

		return var_22_2, var_22_3, var_22_4
	end

	return -150, -150, 0.6
end

function var_0_0.handleLoadedImage(arg_23_0)
	local var_23_0 = arg_23_0.panel
	local var_23_1 = arg_23_0.skinId
	local var_23_2 = arg_23_0.index
	local var_23_3 = var_23_0._characteritems[var_23_2]

	ZProj.UGUIHelper.SetImageSize(var_23_3.simagehero.gameObject)

	local var_23_4 = SkinConfig.instance:getSkinCo(var_23_1).skinViewImgOffset

	if not string.nilorempty(var_23_4) then
		local var_23_5 = string.splitToNumber(var_23_4, "#")

		recthelper.setAnchor(var_23_3.tfimagehero, tonumber(var_23_5[1]), tonumber(var_23_5[2]))
		transformhelper.setLocalScale(var_23_3.tfimagehero, tonumber(var_23_5[3]), tonumber(var_23_5[3]), tonumber(var_23_5[3]))
	else
		recthelper.setAnchor(var_23_3.tfimagehero, -150, -150)
		transformhelper.setLocalScale(var_23_3.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function var_0_0.handleLoadedImageOutline(arg_24_0)
	local var_24_0 = arg_24_0.imgTransform
	local var_24_1 = arg_24_0.offsetX
	local var_24_2 = arg_24_0.offsetY
	local var_24_3 = arg_24_0.scale

	ZProj.UGUIHelper.SetImageSize(var_24_0.gameObject)
	recthelper.setAnchor(var_24_0, var_24_1, var_24_2)
	transformhelper.setLocalScale(var_24_0, var_24_3, var_24_3, var_24_3)
end

function var_0_0.refreshFreeSummonButton(arg_25_0, arg_25_1)
	arg_25_0._compFreeButton = arg_25_0._compFreeButton or SummonFreeSingleGacha.New(arg_25_0._btnsummon1.gameObject, arg_25_1.id)

	arg_25_0._compFreeButton:refreshUI()
end

function var_0_0._onClickDetailByIndex(arg_26_0, arg_26_1)
	local var_26_0 = SummonMainModel.instance:getCurPool()

	if not var_26_0 then
		return
	end

	local var_26_1 = SummonMainModel.instance:getPoolServerMO(var_26_0.id)

	if var_26_1 and var_26_1.customPickMO then
		local var_26_2 = var_26_1.customPickMO.pickHeroIds[arg_26_1]

		if var_26_2 then
			ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
				heroId = var_26_2
			})
		end
	end
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

function var_0_0.refreshCost(arg_28_0)
	local var_28_0 = SummonMainModel.instance:getCurPool()

	if var_28_0 then
		arg_28_0:_refreshSingleCost(var_28_0.cost1, arg_28_0._simagecurrency1, "_txtcurrency1")
		arg_28_0:refreshCost10(var_28_0.cost10)
	end
end

function var_0_0.refreshTicket(arg_29_0)
	local var_29_0 = SummonMainModel.instance:getCurPool()

	if not var_29_0 then
		return
	end

	local var_29_1 = 0

	if var_29_0.ticketId ~= 0 then
		var_29_1 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, var_29_0.ticketId)
	end

	arg_29_0._txtticket.text = tostring(var_29_1)
end

function var_0_0._refreshSingleCost(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0, var_30_1, var_30_2 = SummonMainModel.getCostByConfig(arg_30_1, true)
	local var_30_3 = SummonMainModel.getSummonItemIcon(var_30_0, var_30_1)

	arg_30_2:LoadImage(var_30_3)

	local var_30_4

	var_30_4 = var_30_2 <= ItemModel.instance:getItemQuantity(var_30_0, var_30_1)
	arg_30_0[arg_30_3 .. "1"].text = luaLang("multiple") .. var_30_2
	arg_30_0[arg_30_3 .. "2"].text = ""
end

function var_0_0.refreshCost10(arg_31_0, arg_31_1)
	local var_31_0, var_31_1, var_31_2 = SummonMainModel.instance.getCostByConfig(arg_31_1)
	local var_31_3 = SummonMainModel.instance.getSummonItemIcon(var_31_0, var_31_1)

	arg_31_0._simagecurrency10:LoadImage(var_31_3)

	local var_31_4 = SummonMainModel.instance:getCurId()
	local var_31_5 = SummonMainModel.instance:getDiscountCostId(var_31_4)
	local var_31_6 = SummonMainModel.instance:getDiscountTime10Server(var_31_4)

	gohelper.setActive(arg_31_0._gotip2bg, var_31_6 > 0)
	gohelper.setActive(arg_31_0._txttips2, var_31_6 > 0)

	if var_31_1 == var_31_5 then
		gohelper.setActive(arg_31_0._gocount, var_31_6 > 0)

		if var_31_6 > 0 then
			local var_31_7 = SummonMainModel.instance:getDiscountCost10(var_31_4)
			local var_31_8 = luaLang("multiple_color")
			local var_31_9 = "#FFE095"

			arg_31_0._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_31_8, var_31_9, luaLang("multiple") .. var_31_7)
			arg_31_0._txtcurrency102.text = var_31_2

			local var_31_10 = (var_31_2 - var_31_7) / var_31_2 * 100

			arg_31_0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), var_31_10)

			return
		end
	else
		gohelper.setActive(arg_31_0._gocount, false)
	end

	local var_31_11 = "#000000"
	local var_31_12 = luaLang("multiple_color")

	arg_31_0._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_31_12, var_31_11, luaLang("multiple") .. var_31_2)
	arg_31_0._txtcurrency102.text = ""
end

function var_0_0.onSummonFailed(arg_32_0)
	arg_32_0.summonSuccess = false

	arg_32_0:refreshCost()
end

function var_0_0.onSummonReply(arg_33_0)
	arg_33_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_34_0)
	if SummonController.instance.isWaitingSummonResult or arg_34_0.summonSuccess then
		return
	end

	arg_34_0:refreshCost()
end

function var_0_0.addAllEvents(arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_35_0.onSummonFailed, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_35_0.onSummonReply, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_35_0.playerEnterAnimFromScene, arg_35_0)
	arg_35_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_35_0.onItemChanged, arg_35_0)
	arg_35_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_35_0.onItemChanged, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_35_0.refreshView, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_35_0._refreshOpenTime, arg_35_0)
end

function var_0_0.removeAllEvents(arg_36_0)
	arg_36_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_36_0.onSummonFailed, arg_36_0)
	arg_36_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_36_0.onSummonReply, arg_36_0)
	arg_36_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_36_0.playerEnterAnimFromScene, arg_36_0)
	arg_36_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_36_0.onItemChanged, arg_36_0)
	arg_36_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_36_0.onItemChanged, arg_36_0)
	arg_36_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_36_0.refreshView, arg_36_0)
	arg_36_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_36_0._refreshOpenTime, arg_36_0)
end

function var_0_0.playEnterAnim(arg_37_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_37_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_37_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_38_0)
	arg_38_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

return var_0_0
