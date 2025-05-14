module("modules.logic.store.view.PackageStoreGoodsItem", package.seeall)

local var_0_0 = class("PackageStoreGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._iconImage = arg_1_0._simageicon:GetComponent(gohelper.Type_Image)
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum")
	arg_1_0._imagematerial = gohelper.findChildImage(arg_1_0.viewGO, "cost/simage_material")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txteng = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_eng")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "txt_remain")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_0.viewGO, "#go_soldout")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "go_has")
	arg_1_0._goitemreddot = gohelper.findChild(arg_1_0.viewGO, "go_itemreddot")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "#go_tag")
	arg_1_0._imagediscount = gohelper.findChild(arg_1_0.viewGO, "#go_tag/#image_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "#go_tag/#txt_discount")
	arg_1_0._gowenhao = gohelper.findChild(arg_1_0.viewGO, "#go_wenhao")
	arg_1_0._gosoldoutbg = gohelper.findChild(arg_1_0._gosoldout, "bg")
	arg_1_0._gosoldouttagbg = gohelper.findChild(arg_1_0._gosoldout, "bg_tag")
	arg_1_0._gooptionalgift = gohelper.findChild(arg_1_0.viewGO, "#go_optionalgift")
	arg_1_0._gooptionalvx = gohelper.findChild(arg_1_0.viewGO, "#packs_vx")
	arg_1_0._gosummonSimulationPickFX = gohelper.findChild(arg_1_0.viewGO, "#go_summonSimulationPickFX")
	arg_1_0._txtpickdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_pickdesc")
	arg_1_0._goSkinTips = gohelper.findChild(arg_1_0.viewGO, "#go_SkinTips")
	arg_1_0._imgProp = gohelper.findChildImage(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	arg_1_0._txtPropNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.UpdateProductDetails, arg_2_0._onUpdateProductDetails, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.UpdateProductDetails, arg_3_0._onUpdateProductDetails, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO, AudioEnum.UI.play_ui_common_pause)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._gocost = gohelper.findChild(arg_4_0.viewGO, "cost")
	arg_4_0._btnCost = gohelper.getClick(arg_4_0._gocost)

	arg_4_0._btnCost:AddClickListener(arg_4_0._onClickCost, arg_4_0)

	arg_4_0._golevelLock = gohelper.findChild(arg_4_0.viewGO, "#go_levelLock")
	arg_4_0._txtneedLevel = gohelper.findChildText(arg_4_0.viewGO, "#go_levelLock/levellock/#txt_needLevel")
	arg_4_0._golevelLockbg = gohelper.findChild(arg_4_0.viewGO, "#go_levelLock/bg")
	arg_4_0._golevelLockbgtag = gohelper.findChild(arg_4_0.viewGO, "#go_levelLock/bg_tag")
	arg_4_0._soldout = false
	arg_4_0._hascloth = false
	arg_4_0._lastStartPayTime = 0
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._goremaintime = gohelper.findChild(arg_4_0.viewGO, "go_remaintime")
	arg_4_0._txtremiantime = gohelper.findChildText(arg_4_0.viewGO, "go_remaintime/bg/#txt_remiantime")
	arg_4_0._gonewtag = gohelper.findChild(arg_4_0.viewGO, "go_newtag")
	arg_4_0._gomooncardup = gohelper.findChild(arg_4_0.viewGO, "#go_mooncardup")
	arg_4_0._gomaterialup = gohelper.findChild(arg_4_0.viewGO, "#go_materialup")
	arg_4_0._gocobranded = gohelper.findChild(arg_4_0.viewGO, "#go_cobranded")
end

function var_0_0._onClick(arg_5_0)
	StoreController.instance:forceReadTab(arg_5_0._mo.belongStoreId)

	if not arg_5_0:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if arg_5_0._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif arg_5_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	else
		StoreController.instance:openPackageStoreGoodsView(arg_5_0._mo)
	end
end

function var_0_0._onClickCost(arg_6_0)
	if arg_6_0.isLevelOpen == false then
		return
	end

	if not arg_6_0:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if arg_6_0._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif arg_6_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif arg_6_0._mo.isChargeGoods then
		if Time.time - arg_6_0._lastStartPayTime > 0.3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(arg_6_0._mo.goodsId)

			arg_6_0._lastStartPayTime = Time.time
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
		StoreController.instance:openPackageStoreGoodsView(arg_6_0._mo)
	end
end

function var_0_0._isStoreItemUnlock(arg_7_0)
	local var_7_0 = arg_7_0._mo.config.needEpisodeId

	if not var_7_0 or var_7_0 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_7_0)
end

function var_0_0._onUpdateProductDetails(arg_8_0, arg_8_1)
	if arg_8_0.mo then
		arg_8_0:onUpdateMO(arg_8_0.mo)
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	gohelper.setActive(arg_9_0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(arg_9_1.goodsId))
	gohelper.setActive(arg_9_0._golevellimit, not arg_9_0:_isStoreItemUnlock())
	gohelper.setActive(arg_9_0._gomooncardup, false)

	if not arg_9_0:_isStoreItemUnlock() then
		local var_9_0 = arg_9_0._mo.config.needEpisodeId
		local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)
		local var_9_2 = DungeonConfig.instance:getChapterCO(var_9_1.chapterId)

		if var_9_2 and var_9_2.type == DungeonEnum.ChapterType.Hard then
			var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_1.preEpisode)
			var_9_2 = DungeonConfig.instance:getChapterCO(var_9_1.chapterId)
		end

		local var_9_3
		local var_9_4
		local var_9_5

		if var_9_1 and var_9_2 then
			var_9_3 = var_9_2.chapterIndex

			local var_9_6

			var_9_4, var_9_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_9_2.id, var_9_1.id)

			if type == DungeonEnum.EpisodeType.Sp then
				var_9_3 = "SP"
			end
		end

		arg_9_0._txtlvlimit.text = string.format(luaLang("level_limit_unlock"), string.format("%s-%s", var_9_3, var_9_4))
	end

	arg_9_0._txtname.text = arg_9_0._mo.config.name
	arg_9_0._txteng.text = arg_9_0._mo.config.nameEn

	arg_9_0._simageicon:LoadImage(ResUrl.getStorePackageIcon(arg_9_0._mo.config.bigImg))

	local var_9_7 = arg_9_0._mo.cost

	if string.nilorempty(var_9_7) or var_9_7 == 0 then
		arg_9_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_9_0._imagematerial.gameObject, false)
	elseif arg_9_0._mo.isChargeGoods then
		arg_9_0._txtmaterialNum.text = PayModel.instance:getProductPrice(arg_9_0._mo.id)

		gohelper.setActive(arg_9_0._imagematerial.gameObject, false)

		arg_9_0._costQuantity = var_9_7
	else
		local var_9_8 = string.split(var_9_7, "|")
		local var_9_9 = var_9_8[arg_9_1.buyCount + 1] or var_9_8[#var_9_8]
		local var_9_10 = string.splitToNumber(var_9_9, "#")

		arg_9_0._costType = var_9_10[1]
		arg_9_0._costId = var_9_10[2]
		arg_9_0._costQuantity = var_9_10[3]

		local var_9_11, var_9_12 = ItemModel.instance:getItemConfigAndIcon(arg_9_0._costType, arg_9_0._costId)

		arg_9_0._txtmaterialNum.text = arg_9_0._costQuantity

		gohelper.setActive(arg_9_0._imagematerial.gameObject, true)

		local var_9_13 = 0

		if string.len(arg_9_0._costId) == 1 then
			var_9_13 = arg_9_0._costType .. "0" .. arg_9_0._costId
		else
			var_9_13 = arg_9_0._costType .. arg_9_0._costId
		end

		local var_9_14 = string.format("%s_1", var_9_13)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_9_0._imagematerial, var_9_14)
	end

	local var_9_15 = arg_9_1.maxBuyCount
	local var_9_16 = var_9_15 - arg_9_1.buyCount

	arg_9_0._soldout = arg_9_1:isSoldOut()

	local var_9_17

	if arg_9_0._mo.isChargeGoods then
		var_9_17 = StoreConfig.instance:getChargeRemainText(var_9_15, arg_9_1.refreshTime, var_9_16, arg_9_1.offlineTime)
	else
		var_9_17 = StoreConfig.instance:getRemainText(var_9_15, arg_9_1.refreshTime, var_9_16, arg_9_1.offlineTime)
	end

	if string.nilorempty(var_9_17) then
		gohelper.setActive(arg_9_0._txtremain.gameObject, false)
	else
		gohelper.setActive(arg_9_0._txtremain.gameObject, true)

		arg_9_0._txtremain.text = var_9_17
	end

	local var_9_18 = arg_9_1.offlineTime - ServerTime.now()

	gohelper.setActive(arg_9_0._goremaintime, arg_9_1.offlineTime > 0)

	if var_9_18 > 3600 then
		local var_9_19, var_9_20 = TimeUtil.secondToRoughTime(var_9_18)

		arg_9_0._txtremiantime.text = formatLuaLang("remain", var_9_19 .. var_9_20)
	else
		arg_9_0._txtremiantime.text = luaLang("not_enough_one_hour")
	end

	local var_9_21 = tonumber(arg_9_1:getDiscount())

	if var_9_21 and var_9_21 > 0 then
		arg_9_0.hasTag = true

		gohelper.setActive(arg_9_0._gotag, true)

		arg_9_0._txtdiscount.text = string.format("-%d%%", var_9_21)
	else
		arg_9_0.hasTag = false

		gohelper.setActive(arg_9_0._gotag, false)
	end

	gohelper.setActive(arg_9_0._gonewtag, arg_9_1:needShowNew())

	arg_9_0._hascloth = arg_9_0._mo:alreadyHas()

	gohelper.setActive(arg_9_0._gohas, false)
	gohelper.setActive(arg_9_0._gosoldout, false)
	ZProj.UGUIHelper.SetColorAlpha(arg_9_0._iconImage, 1)

	if arg_9_0._hascloth then
		gohelper.setActive(arg_9_0._gohas, true)
	elseif arg_9_0._soldout then
		gohelper.setActive(arg_9_0._gosoldout, true)
		gohelper.setActive(arg_9_0._gosoldoutbg, not arg_9_0.hasTag)
		gohelper.setActive(arg_9_0._gosoldouttagbg, arg_9_0.hasTag)
		ZProj.UGUIHelper.SetColorAlpha(arg_9_0._iconImage, 0.8)
	end

	gohelper.setActive(arg_9_0._gowenhao, false)

	if arg_9_0._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(arg_9_0._gowenhao, true)

		arg_9_0._wenhaoClick = gohelper.getClick(arg_9_0._gowenhao)

		arg_9_0._wenhaoClick:AddClickListener(arg_9_0.showMonthCardTips, arg_9_0)

		local var_9_22 = StoreHelper.checkMonthCardLevelUpTagOpen()

		gohelper.setActive(arg_9_0._gomooncardup, var_9_22)
	elseif arg_9_0._mo.goodsId == StoreEnum.SeasonCardGoodsId then
		gohelper.setActive(arg_9_0._gowenhao, true)

		arg_9_0._wenhaoClick = gohelper.getClick(arg_9_0._gowenhao)

		arg_9_0._wenhaoClick:AddClickListener(arg_9_0._showSeasonCardTips, arg_9_0)
	else
		GameUtil.onDestroyViewMember_ClickListener(arg_9_0, "_wenhaoClick")
	end

	arg_9_0.isLevelOpen = arg_9_1:isLevelOpen()

	gohelper.setActive(arg_9_0._golevelLock, arg_9_0.isLevelOpen == false)
	gohelper.setActive(arg_9_0._golevelLockbg, not arg_9_0.hasTag)
	gohelper.setActive(arg_9_0._golevelLockbgtag, arg_9_0.hasTag)

	arg_9_0._txtneedLevel.text = formatLuaLang("packagestoregoodsitem_level", arg_9_1.buyLevel)

	if arg_9_1.isChargeGoods then
		arg_9_0.isPreGoodsSoldOut = arg_9_1:checkPreGoodsSoldOut()

		gohelper.setActive(arg_9_0._golevelLock, arg_9_0.isLevelOpen == false or arg_9_0.isPreGoodsSoldOut == false)

		if arg_9_0.isLevelOpen and arg_9_0.isPreGoodsSoldOut == false then
			local var_9_23 = StoreConfig.instance:getChargeGoodsConfig(arg_9_1.config.preGoodsId)

			arg_9_0._txtneedLevel.text = formatLuaLang("packagestoregoods_pregoods_tips", var_9_23.name)
		end
	end

	local var_9_24 = arg_9_1.isChargeGoods and arg_9_1.config.type == StoreEnum.StoreChargeType.Optional or arg_9_1.goodsId == StoreEnum.NewbiePackId

	gohelper.setActive(arg_9_0._gooptionalgift, var_9_24)
	gohelper.setActive(arg_9_0._gooptionalvx, var_9_24 and not arg_9_1.goodsId == StoreEnum.NewbiePackId)
	gohelper.setActive(arg_9_0._txtpickdesc.gameObject, arg_9_1.goodsId == StoreEnum.NewbiePackId)
	arg_9_0:_onUpdateMO_newMatUpTag(arg_9_1)
	arg_9_0:_onUpdateMO_coBrandedTag(arg_9_1)
	arg_9_0:_onUpdateMO_gosummonSimulationPickFX(arg_9_1)
	arg_9_0:refreshSkinTips(arg_9_1)
end

function var_0_0.showMonthCardTips(arg_10_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

function var_0_0.refreshSkinTips(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = SkinConfig.instance:isSkinStoreGoods(arg_12_1.goodsId)

	if not var_12_0 then
		gohelper.setActive(arg_12_0._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_12_1, var_12_1) then
		gohelper.setActive(arg_12_0._goSkinTips, true)

		local var_12_2 = SkinConfig.instance:getSkinCo(var_12_1)
		local var_12_3 = string.splitToNumber(var_12_2.compensate, "#")
		local var_12_4 = var_12_3[2]
		local var_12_5 = var_12_3[3]
		local var_12_6 = CurrencyConfig.instance:getCurrencyCo(var_12_4)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0._imgProp, string.format("%s_1", var_12_6.icon))

		arg_12_0._txtPropNum.text = tostring(var_12_5)
	else
		gohelper.setActive(arg_12_0._goSkinTips, false)
	end
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._btn:RemoveClickListener()
	arg_13_0._btnCost:RemoveClickListener()
	GameUtil.onDestroyViewMember_ClickListener(arg_13_0, "_wenhaoClick")
end

function var_0_0._onUpdateMO_newMatUpTag(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.goodsId
	local var_14_1 = StoreHelper.checkNewMatUpTagOpen(var_14_0)

	gohelper.setActive(arg_14_0._gomaterialup, var_14_1)
end

function var_0_0._onUpdateMO_coBrandedTag(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.config.showLinkageTag or false

	gohelper.setActive(arg_15_0._gocobranded, var_15_0)
end

function var_0_0._showSeasonCardTips(arg_16_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

local var_0_1 = {
	811466,
	StoreEnum.SeasonCardGoodsId
}

function var_0_0._onUpdateMO_gosummonSimulationPickFX(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.config.bigImg == StoreEnum.SummonSimulationPick

	if not var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_0_1) do
			if arg_17_1.goodsId == iter_17_1 then
				var_17_0 = true

				break
			end
		end
	end

	gohelper.setActive(arg_17_0._gosummonSimulationPickFX, var_17_0)
end

return var_0_0
