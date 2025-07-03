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

	local var_5_0 = {
		arg_5_0._mo.goodsId
	}

	ChargeRpc.instance:sendReadChargeNewRequest(var_5_0, arg_5_0._onRefreshNew, arg_5_0)

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

function var_0_0._onRefreshNew(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	gohelper.setActive(arg_6_0._gonewtag, false)
end

function var_0_0._onClickCost(arg_7_0)
	if arg_7_0.isLevelOpen == false then
		return
	end

	if not arg_7_0:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if arg_7_0._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif arg_7_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif arg_7_0._mo.isChargeGoods then
		if Time.time - arg_7_0._lastStartPayTime > 0.3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(arg_7_0._mo.goodsId)

			arg_7_0._lastStartPayTime = Time.time
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
		StoreController.instance:openPackageStoreGoodsView(arg_7_0._mo)
	end
end

function var_0_0._isStoreItemUnlock(arg_8_0)
	local var_8_0 = arg_8_0._mo.config.needEpisodeId

	if not var_8_0 or var_8_0 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_8_0)
end

function var_0_0._onUpdateProductDetails(arg_9_0, arg_9_1)
	if arg_9_0.mo then
		arg_9_0:onUpdateMO(arg_9_0.mo)
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	gohelper.setActive(arg_10_0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(arg_10_1.goodsId))
	gohelper.setActive(arg_10_0._golevellimit, not arg_10_0:_isStoreItemUnlock())
	gohelper.setActive(arg_10_0._gomooncardup, false)

	if not arg_10_0:_isStoreItemUnlock() then
		local var_10_0 = arg_10_0._mo.config.needEpisodeId
		local var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_0)
		local var_10_2 = DungeonConfig.instance:getChapterCO(var_10_1.chapterId)

		if var_10_2 and var_10_2.type == DungeonEnum.ChapterType.Hard then
			var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_1.preEpisode)
			var_10_2 = DungeonConfig.instance:getChapterCO(var_10_1.chapterId)
		end

		local var_10_3
		local var_10_4
		local var_10_5

		if var_10_1 and var_10_2 then
			var_10_3 = var_10_2.chapterIndex

			local var_10_6

			var_10_4, var_10_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_10_2.id, var_10_1.id)

			if type == DungeonEnum.EpisodeType.Sp then
				var_10_3 = "SP"
			end
		end

		arg_10_0._txtlvlimit.text = string.format(luaLang("level_limit_unlock"), string.format("%s-%s", var_10_3, var_10_4))
	end

	arg_10_0._txtname.text = arg_10_0._mo.config.name
	arg_10_0._txteng.text = arg_10_0._mo.config.nameEn

	arg_10_0._simageicon:LoadImage(ResUrl.getStorePackageIcon(arg_10_0._mo.config.bigImg))

	local var_10_7 = arg_10_0._mo.cost

	if string.nilorempty(var_10_7) or var_10_7 == 0 then
		arg_10_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_10_0._imagematerial.gameObject, false)
	elseif arg_10_0._mo.isChargeGoods then
		arg_10_0._txtmaterialNum.text = PayModel.instance:getProductPrice(arg_10_0._mo.id)

		gohelper.setActive(arg_10_0._imagematerial.gameObject, false)

		arg_10_0._costQuantity = var_10_7
	else
		local var_10_8 = string.split(var_10_7, "|")
		local var_10_9 = var_10_8[arg_10_1.buyCount + 1] or var_10_8[#var_10_8]
		local var_10_10 = string.splitToNumber(var_10_9, "#")

		arg_10_0._costType = var_10_10[1]
		arg_10_0._costId = var_10_10[2]
		arg_10_0._costQuantity = var_10_10[3]

		local var_10_11, var_10_12 = ItemModel.instance:getItemConfigAndIcon(arg_10_0._costType, arg_10_0._costId)

		arg_10_0._txtmaterialNum.text = arg_10_0._costQuantity

		gohelper.setActive(arg_10_0._imagematerial.gameObject, true)

		local var_10_13 = 0

		if string.len(arg_10_0._costId) == 1 then
			var_10_13 = arg_10_0._costType .. "0" .. arg_10_0._costId
		else
			var_10_13 = arg_10_0._costType .. arg_10_0._costId
		end

		local var_10_14 = string.format("%s_1", var_10_13)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_10_0._imagematerial, var_10_14)
	end

	local var_10_15 = arg_10_1.maxBuyCount
	local var_10_16 = var_10_15 - arg_10_1.buyCount

	arg_10_0._soldout = arg_10_1:isSoldOut()

	local var_10_17

	if arg_10_0._mo.isChargeGoods then
		var_10_17 = StoreConfig.instance:getChargeRemainText(var_10_15, arg_10_1.refreshTime, var_10_16, arg_10_1.offlineTime)
	else
		var_10_17 = StoreConfig.instance:getRemainText(var_10_15, arg_10_1.refreshTime, var_10_16, arg_10_1.offlineTime)
	end

	if string.nilorempty(var_10_17) then
		gohelper.setActive(arg_10_0._txtremain.gameObject, false)
	else
		gohelper.setActive(arg_10_0._txtremain.gameObject, true)

		arg_10_0._txtremain.text = var_10_17
	end

	local var_10_18 = arg_10_1.offlineTime - ServerTime.now()

	gohelper.setActive(arg_10_0._goremaintime, arg_10_1.offlineTime > 0)

	if var_10_18 > 3600 then
		local var_10_19, var_10_20 = TimeUtil.secondToRoughTime(var_10_18)

		arg_10_0._txtremiantime.text = formatLuaLang("remain", var_10_19 .. var_10_20)
	else
		arg_10_0._txtremiantime.text = luaLang("not_enough_one_hour")
	end

	local var_10_21 = tonumber(arg_10_1:getDiscount())

	if var_10_21 and var_10_21 > 0 then
		arg_10_0.hasTag = true

		gohelper.setActive(arg_10_0._gotag, true)

		arg_10_0._txtdiscount.text = string.format("-%d%%", var_10_21)
	else
		arg_10_0.hasTag = false

		gohelper.setActive(arg_10_0._gotag, false)
	end

	gohelper.setActive(arg_10_0._gonewtag, arg_10_1:needShowNew())

	arg_10_0._hascloth = arg_10_0._mo:alreadyHas()

	gohelper.setActive(arg_10_0._gohas, false)
	gohelper.setActive(arg_10_0._gosoldout, false)
	ZProj.UGUIHelper.SetColorAlpha(arg_10_0._iconImage, 1)

	if arg_10_0._hascloth then
		gohelper.setActive(arg_10_0._gohas, true)
	elseif arg_10_0._soldout then
		gohelper.setActive(arg_10_0._gosoldout, true)
		gohelper.setActive(arg_10_0._gosoldoutbg, not arg_10_0.hasTag)
		gohelper.setActive(arg_10_0._gosoldouttagbg, arg_10_0.hasTag)
		ZProj.UGUIHelper.SetColorAlpha(arg_10_0._iconImage, 0.8)
	end

	gohelper.setActive(arg_10_0._gowenhao, false)

	if arg_10_0._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(arg_10_0._gowenhao, true)

		arg_10_0._wenhaoClick = gohelper.getClick(arg_10_0._gowenhao)

		arg_10_0._wenhaoClick:AddClickListener(arg_10_0.showMonthCardTips, arg_10_0)

		local var_10_22 = StoreHelper.checkMonthCardLevelUpTagOpen()

		gohelper.setActive(arg_10_0._gomooncardup, var_10_22)
	elseif arg_10_0._mo.goodsId == StoreEnum.SeasonCardGoodsId then
		gohelper.setActive(arg_10_0._gowenhao, true)

		arg_10_0._wenhaoClick = gohelper.getClick(arg_10_0._gowenhao)

		arg_10_0._wenhaoClick:AddClickListener(arg_10_0._showSeasonCardTips, arg_10_0)
	else
		GameUtil.onDestroyViewMember_ClickListener(arg_10_0, "_wenhaoClick")
	end

	arg_10_0.isLevelOpen = arg_10_1:isLevelOpen()

	gohelper.setActive(arg_10_0._golevelLock, arg_10_0.isLevelOpen == false)
	gohelper.setActive(arg_10_0._golevelLockbg, not arg_10_0.hasTag)
	gohelper.setActive(arg_10_0._golevelLockbgtag, arg_10_0.hasTag)

	arg_10_0._txtneedLevel.text = formatLuaLang("packagestoregoodsitem_level", arg_10_1.buyLevel)

	if arg_10_1.isChargeGoods then
		arg_10_0.isPreGoodsSoldOut = arg_10_1:checkPreGoodsSoldOut()

		gohelper.setActive(arg_10_0._golevelLock, arg_10_0.isLevelOpen == false or arg_10_0.isPreGoodsSoldOut == false)

		if arg_10_0.isLevelOpen and arg_10_0.isPreGoodsSoldOut == false then
			local var_10_23 = StoreConfig.instance:getChargeGoodsConfig(arg_10_1.config.preGoodsId)

			arg_10_0._txtneedLevel.text = formatLuaLang("packagestoregoods_pregoods_tips", var_10_23.name)
		end
	end

	local var_10_24 = arg_10_1.isChargeGoods and arg_10_1.config.type == StoreEnum.StoreChargeType.Optional or arg_10_1.goodsId == StoreEnum.NewbiePackId

	gohelper.setActive(arg_10_0._gooptionalgift, var_10_24)
	gohelper.setActive(arg_10_0._gooptionalvx, var_10_24 and not arg_10_1.goodsId == StoreEnum.NewbiePackId)
	gohelper.setActive(arg_10_0._txtpickdesc.gameObject, arg_10_1.goodsId == StoreEnum.NewbiePackId)
	arg_10_0:_onUpdateMO_newMatUpTag(arg_10_1)
	arg_10_0:_onUpdateMO_coBrandedTag(arg_10_1)
	arg_10_0:_onUpdateMO_gosummonSimulationPickFX(arg_10_1)
	arg_10_0:refreshSkinTips(arg_10_1)
end

function var_0_0.showMonthCardTips(arg_11_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function var_0_0.getAnimator(arg_12_0)
	return arg_12_0._animator
end

function var_0_0.refreshSkinTips(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = SkinConfig.instance:isSkinStoreGoods(arg_13_1.goodsId)

	if not var_13_0 then
		gohelper.setActive(arg_13_0._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_13_1, var_13_1) then
		gohelper.setActive(arg_13_0._goSkinTips, true)

		local var_13_2 = SkinConfig.instance:getSkinCo(var_13_1)
		local var_13_3 = string.splitToNumber(var_13_2.compensate, "#")
		local var_13_4 = var_13_3[2]
		local var_13_5 = var_13_3[3]
		local var_13_6 = CurrencyConfig.instance:getCurrencyCo(var_13_4)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_13_0._imgProp, string.format("%s_1", var_13_6.icon))

		arg_13_0._txtPropNum.text = tostring(var_13_5)
	else
		gohelper.setActive(arg_13_0._goSkinTips, false)
	end
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0._btn:RemoveClickListener()
	arg_14_0._btnCost:RemoveClickListener()
	GameUtil.onDestroyViewMember_ClickListener(arg_14_0, "_wenhaoClick")
end

function var_0_0._onUpdateMO_newMatUpTag(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.goodsId
	local var_15_1 = StoreHelper.checkNewMatUpTagOpen(var_15_0)

	gohelper.setActive(arg_15_0._gomaterialup, var_15_1)
end

function var_0_0._onUpdateMO_coBrandedTag(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.config.showLinkageTag or false

	gohelper.setActive(arg_16_0._gocobranded, var_16_0)
end

function var_0_0._showSeasonCardTips(arg_17_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

local var_0_1 = {
	811466,
	StoreEnum.SeasonCardGoodsId
}

function var_0_0._onUpdateMO_gosummonSimulationPickFX(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.config.bigImg == StoreEnum.SummonSimulationPick

	if not var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_0_1) do
			if arg_18_1.goodsId == iter_18_1 then
				var_18_0 = true

				break
			end
		end
	end

	gohelper.setActive(arg_18_0._gosummonSimulationPickFX, var_18_0)
end

return var_0_0
