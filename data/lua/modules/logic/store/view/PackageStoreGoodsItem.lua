module("modules.logic.store.view.PackageStoreGoodsItem", package.seeall)

slot0 = class("PackageStoreGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._iconImage = slot0._simageicon:GetComponent(gohelper.Type_Image)
	slot0._txtmaterialNum = gohelper.findChildText(slot0.viewGO, "cost/txt_materialNum")
	slot0._imagematerial = gohelper.findChildImage(slot0.viewGO, "cost/simage_material")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txteng = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_eng")
	slot0._txtremain = gohelper.findChildText(slot0.viewGO, "txt_remain")
	slot0._gosoldout = gohelper.findChild(slot0.viewGO, "#go_soldout")
	slot0._gohas = gohelper.findChild(slot0.viewGO, "go_has")
	slot0._goitemreddot = gohelper.findChild(slot0.viewGO, "go_itemreddot")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "#go_tag")
	slot0._imagediscount = gohelper.findChild(slot0.viewGO, "#go_tag/#image_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0.viewGO, "#go_tag/#txt_discount")
	slot0._gowenhao = gohelper.findChild(slot0.viewGO, "#go_wenhao")
	slot0._gosoldoutbg = gohelper.findChild(slot0._gosoldout, "bg")
	slot0._gosoldouttagbg = gohelper.findChild(slot0._gosoldout, "bg_tag")
	slot0._gooptionalgift = gohelper.findChild(slot0.viewGO, "#go_optionalgift")
	slot0._gooptionalvx = gohelper.findChild(slot0.viewGO, "#packs_vx")
	slot0._gosummonSimulationPickFX = gohelper.findChild(slot0.viewGO, "#go_summonSimulationPickFX")
	slot0._txtpickdesc = gohelper.findChildText(slot0.viewGO, "#txt_pickdesc")
	slot0._goSkinTips = gohelper.findChild(slot0.viewGO, "#go_SkinTips")
	slot0._imgProp = gohelper.findChildImage(slot0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	slot0._txtPropNum = gohelper.findChildTextMesh(slot0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PayController.instance, PayEvent.UpdateProductDetails, slot0._onUpdateProductDetails, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.UpdateProductDetails, slot0._onUpdateProductDetails, slot0)
end

function slot0._editableInitView(slot0)
	slot0._btnGO = gohelper.findChild(slot0.viewGO, "clickArea")
	slot0._btn = gohelper.getClickWithAudio(slot0._btnGO, AudioEnum.UI.play_ui_common_pause)

	slot0._btn:AddClickListener(slot0._onClick, slot0)

	slot0._gocost = gohelper.findChild(slot0.viewGO, "cost")
	slot0._btnCost = gohelper.getClick(slot0._gocost)

	slot0._btnCost:AddClickListener(slot0._onClickCost, slot0)

	slot0._golevelLock = gohelper.findChild(slot0.viewGO, "#go_levelLock")
	slot0._txtneedLevel = gohelper.findChildText(slot0.viewGO, "#go_levelLock/levellock/#txt_needLevel")
	slot0._golevelLockbg = gohelper.findChild(slot0.viewGO, "#go_levelLock/bg")
	slot0._golevelLockbgtag = gohelper.findChild(slot0.viewGO, "#go_levelLock/bg_tag")
	slot0._soldout = false
	slot0._hascloth = false
	slot0._lastStartPayTime = 0
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goremaintime = gohelper.findChild(slot0.viewGO, "go_remaintime")
	slot0._txtremiantime = gohelper.findChildText(slot0.viewGO, "go_remaintime/bg/#txt_remiantime")
	slot0._gonewtag = gohelper.findChild(slot0.viewGO, "go_newtag")
	slot0._gomooncardup = gohelper.findChild(slot0.viewGO, "#go_mooncardup")
	slot0._gomaterialup = gohelper.findChild(slot0.viewGO, "#go_materialup")
	slot0._gocobranded = gohelper.findChild(slot0.viewGO, "#go_cobranded")
end

function slot0._onClick(slot0)
	StoreController.instance:forceReadTab(slot0._mo.belongStoreId)

	if not slot0:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if slot0._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif slot0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	else
		StoreController.instance:openPackageStoreGoodsView(slot0._mo)
	end
end

function slot0._onClickCost(slot0)
	if slot0.isLevelOpen == false then
		return
	end

	if not slot0:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if slot0._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif slot0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif slot0._mo.isChargeGoods then
		if Time.time - slot0._lastStartPayTime > 0.3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(slot0._mo.goodsId)

			slot0._lastStartPayTime = Time.time
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
		StoreController.instance:openPackageStoreGoodsView(slot0._mo)
	end
end

function slot0._isStoreItemUnlock(slot0)
	if not slot0._mo.config.needEpisodeId or slot1 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0._onUpdateProductDetails(slot0, slot1)
	if slot0.mo then
		slot0:onUpdateMO(slot0.mo)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(slot1.goodsId))
	gohelper.setActive(slot0._golevellimit, not slot0:_isStoreItemUnlock())
	gohelper.setActive(slot0._gomooncardup, false)

	if not slot0:_isStoreItemUnlock() then
		if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0._mo.config.needEpisodeId).chapterId) and slot4.type == DungeonEnum.ChapterType.Hard then
			slot4 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot3.preEpisode).chapterId)
		end

		slot5, slot6, slot7 = nil

		if slot3 and slot4 then
			slot5 = slot4.chapterIndex
			slot6, slot7 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot4.id, slot3.id)

			if type == DungeonEnum.EpisodeType.Sp then
				slot5 = "SP"
			end
		end

		slot0._txtlvlimit.text = string.format(luaLang("level_limit_unlock"), string.format("%s-%s", slot5, slot6))
	end

	slot0._txtname.text = slot0._mo.config.name
	slot0._txteng.text = slot0._mo.config.nameEn

	slot0._simageicon:LoadImage(ResUrl.getStorePackageIcon(slot0._mo.config.bigImg))

	if string.nilorempty(slot0._mo.cost) or slot2 == 0 then
		slot0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(slot0._imagematerial.gameObject, false)
	elseif slot0._mo.isChargeGoods then
		slot0._txtmaterialNum.text = PayModel.instance:getProductPrice(slot0._mo.id)

		gohelper.setActive(slot0._imagematerial.gameObject, false)

		slot0._costQuantity = slot2
	else
		slot5 = string.splitToNumber(string.split(slot2, "|")[slot1.buyCount + 1] or slot3[#slot3], "#")
		slot0._costType = slot5[1]
		slot0._costId = slot5[2]
		slot0._costQuantity = slot5[3]
		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)
		slot0._txtmaterialNum.text = slot0._costQuantity

		gohelper.setActive(slot0._imagematerial.gameObject, true)

		slot8 = 0

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagematerial, string.format("%s_1", string.len(slot0._costId) == 1 and slot0._costType .. "0" .. slot0._costId or slot0._costType .. slot0._costId))
	end

	slot4 = slot1.maxBuyCount - slot1.buyCount
	slot0._soldout = slot1:isSoldOut()
	slot5 = nil

	if string.nilorempty((not slot0._mo.isChargeGoods or StoreConfig.instance:getChargeRemainText(slot3, slot1.refreshTime, slot4, slot1.offlineTime)) and StoreConfig.instance:getRemainText(slot3, slot1.refreshTime, slot4, slot1.offlineTime)) then
		gohelper.setActive(slot0._txtremain.gameObject, false)
	else
		gohelper.setActive(slot0._txtremain.gameObject, true)

		slot0._txtremain.text = slot5
	end

	gohelper.setActive(slot0._goremaintime, slot1.offlineTime > 0)

	if slot1.offlineTime - ServerTime.now() > 3600 then
		slot7, slot8 = TimeUtil.secondToRoughTime(slot6)
		slot0._txtremiantime.text = formatLuaLang("remain", slot7 .. slot8)
	else
		slot0._txtremiantime.text = luaLang("not_enough_one_hour")
	end

	if tonumber(slot1:getDiscount()) and slot7 > 0 then
		slot0.hasTag = true

		gohelper.setActive(slot0._gotag, true)

		slot0._txtdiscount.text = string.format("-%d%%", slot7)
	else
		slot0.hasTag = false

		gohelper.setActive(slot0._gotag, false)
	end

	gohelper.setActive(slot0._gonewtag, slot1:needShowNew())

	slot0._hascloth = slot0._mo:alreadyHas()

	gohelper.setActive(slot0._gohas, false)
	gohelper.setActive(slot0._gosoldout, false)
	ZProj.UGUIHelper.SetColorAlpha(slot0._iconImage, 1)

	if slot0._hascloth then
		gohelper.setActive(slot0._gohas, true)
	elseif slot0._soldout then
		gohelper.setActive(slot0._gosoldout, true)
		gohelper.setActive(slot0._gosoldoutbg, not slot0.hasTag)
		gohelper.setActive(slot0._gosoldouttagbg, slot0.hasTag)
		ZProj.UGUIHelper.SetColorAlpha(slot0._iconImage, 0.8)
	end

	gohelper.setActive(slot0._gowenhao, false)

	if slot0._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(slot0._gowenhao, true)

		slot0._wenhaoClick = gohelper.getClick(slot0._gowenhao)

		slot0._wenhaoClick:AddClickListener(slot0.showMonthCardTips, slot0)
		gohelper.setActive(slot0._gomooncardup, StoreHelper.checkMonthCardLevelUpTagOpen())
	elseif slot0._mo.goodsId == StoreEnum.SeasonCardGoodsId then
		gohelper.setActive(slot0._gowenhao, true)

		slot0._wenhaoClick = gohelper.getClick(slot0._gowenhao)

		slot0._wenhaoClick:AddClickListener(slot0._showSeasonCardTips, slot0)
	else
		GameUtil.onDestroyViewMember_ClickListener(slot0, "_wenhaoClick")
	end

	slot0.isLevelOpen = slot1:isLevelOpen()

	gohelper.setActive(slot0._golevelLock, slot0.isLevelOpen == false)
	gohelper.setActive(slot0._golevelLockbg, not slot0.hasTag)
	gohelper.setActive(slot0._golevelLockbgtag, slot0.hasTag)

	slot0._txtneedLevel.text = formatLuaLang("packagestoregoodsitem_level", slot1.buyLevel)

	if slot1.isChargeGoods then
		slot0.isPreGoodsSoldOut = slot1:checkPreGoodsSoldOut()

		gohelper.setActive(slot0._golevelLock, slot0.isLevelOpen == false or slot0.isPreGoodsSoldOut == false)

		if slot0.isLevelOpen and slot0.isPreGoodsSoldOut == false then
			slot0._txtneedLevel.text = formatLuaLang("packagestoregoods_pregoods_tips", StoreConfig.instance:getChargeGoodsConfig(slot1.config.preGoodsId).name)
		end
	end

	slot8 = slot1.isChargeGoods and slot1.config.type == StoreEnum.StoreChargeType.Optional or slot1.goodsId == StoreEnum.NewbiePackId

	gohelper.setActive(slot0._gooptionalgift, slot8)
	gohelper.setActive(slot0._gooptionalvx, slot8 and not slot1.goodsId == StoreEnum.NewbiePackId)
	gohelper.setActive(slot0._txtpickdesc.gameObject, slot1.goodsId == StoreEnum.NewbiePackId)
	slot0:_onUpdateMO_newMatUpTag(slot1)
	slot0:_onUpdateMO_coBrandedTag(slot1)
	slot0:_onUpdateMO_gosummonSimulationPickFX(slot1)
	slot0:refreshSkinTips(slot1)
end

function slot0.showMonthCardTips(slot0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.refreshSkinTips(slot0, slot1)
	slot2, slot3 = SkinConfig.instance:isSkinStoreGoods(slot1.goodsId)

	if not slot2 then
		gohelper.setActive(slot0._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(slot1, slot3) then
		gohelper.setActive(slot0._goSkinTips, true)

		slot5 = string.splitToNumber(SkinConfig.instance:getSkinCo(slot3).compensate, "#")

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgProp, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot5[2]).icon))

		slot0._txtPropNum.text = tostring(slot5[3])
	else
		gohelper.setActive(slot0._goSkinTips, false)
	end
end

function slot0.onDestroy(slot0)
	slot0._btn:RemoveClickListener()
	slot0._btnCost:RemoveClickListener()
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_wenhaoClick")
end

function slot0._onUpdateMO_newMatUpTag(slot0, slot1)
	gohelper.setActive(slot0._gomaterialup, StoreHelper.checkNewMatUpTagOpen(slot1.goodsId))
end

function slot0._onUpdateMO_coBrandedTag(slot0, slot1)
	gohelper.setActive(slot0._gocobranded, slot1.config.showLinkageTag or false)
end

function slot0._showSeasonCardTips(slot0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

slot1 = {
	811466,
	StoreEnum.SeasonCardGoodsId
}

function slot0._onUpdateMO_gosummonSimulationPickFX(slot0, slot1)
	if not (slot1.config.bigImg == StoreEnum.SummonSimulationPick) then
		for slot6, slot7 in ipairs(uv0) do
			if slot1.goodsId == slot7 then
				slot2 = true

				break
			end
		end
	end

	gohelper.setActive(slot0._gosummonSimulationPickFX, slot2)
end

return slot0
