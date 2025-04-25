module("modules.logic.store.view.PackageStoreGoodsView", package.seeall)

slot0 = class("PackageStoreGoodsView", BaseView)
slot1 = 811372
slot2 = 610001
slot3 = -399
slot4 = 90

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_blur")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_rightbg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "view/propinfo/#simage_icon")
	slot0._txtgoodsNameCn = gohelper.findChildText(slot0.viewGO, "view/propinfo/txt_goodslayout/#txt_goodsNameCn")
	slot0._goSecondGoodsName = gohelper.findChild(slot0.viewGO, "view/propinfo/#txt_goodsNameCn/#txt_goodstips")
	slot0._btnbuy = gohelper.findChildButton(slot0.viewGO, "view/propinfo/#btn_buy")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "view/propinfo/#go_tips")
	slot0._txtlocktips = gohelper.findChildText(slot0.viewGO, "view/propinfo/#go_tips/#txt_locktips")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "view/#btn_close")
	slot0._txtmaterialNum = gohelper.findChildText(slot0.viewGO, "view/propinfo/#btn_buy/cost/#txt_materialNum")
	slot0._txtprice = gohelper.findChildText(slot0.viewGO, "view/propinfo/#btn_buy/cost/#txt_price")
	slot0._imagematerial = gohelper.findChildImage(slot0.viewGO, "view/propinfo/#btn_buy/cost/simage_material")
	slot0._goLine1 = gohelper.findChild(slot0.viewGO, "view/bg/line")
	slot0._gopropInfoTitle = gohelper.findChild(slot0.viewGO, "view/propinfo/title")
	slot0._gopropInfoTitleLayout = gohelper.findChild(slot0.viewGO, "view/propinfo/txt_goodslayout")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "view/normal")
	slot0._goDetailDescNormal = gohelper.findChild(slot0.viewGO, "view/normal_detail")
	slot0._goyueka = gohelper.findChild(slot0.viewGO, "view/yueka")
	slot0._reward = gohelper.findChild(slot0._goyueka, "reward")
	slot0._txtleft = gohelper.findChildText(slot0._reward, "left/txt")
	slot0._txtright = gohelper.findChildText(slot0._reward, "right/txt")
	slot0._iconleft = gohelper.findChild(slot0._reward, "left/#go_lefticon")
	slot0._iconleft2 = gohelper.findChild(slot0._reward, "left/#go_lefticon2")
	slot0._goicon2new = gohelper.findChild(slot0._reward, "left/#go_lefticon2/new")
	slot0._iconright = gohelper.findChild(slot0._reward, "right/#go_righticon")
	slot0._iconpower = gohelper.findChild(slot0._reward, "right/#go_powericon")
	slot0._godailyrelease = gohelper.findChild(slot0.viewGO, "view/dailyrelease")
	slot0._dailyreleasereward = gohelper.findChild(slot0._godailyrelease, "reward")
	slot0._txtdailyreleasereleft = gohelper.findChildText(slot0._dailyreleasereward, "left/txt")
	slot0._txtdailyreleasereright = gohelper.findChildText(slot0._dailyreleasereward, "right/txt")
	slot0._icondailyreleasereleft = gohelper.findChild(slot0._dailyreleasereward, "left/#go_lefticon")
	slot0._icon2dailyreleasereleft = gohelper.findChild(slot0._dailyreleasereward, "left/#go_lefticon2")
	slot0._icondailyreleasereright = gohelper.findChild(slot0._dailyreleasereward, "right/#go_righticon")
	slot0._icondailyreleaserepower = gohelper.findChild(slot0._dailyreleasereward, "right/#go_powericon")
	slot0._txtDailyReleaseDesc1 = gohelper.findChildText(slot0._godailyrelease, "desc/info/txt")
	slot0._txtDailyReleaseDesc2 = gohelper.findChildText(slot0._godailyrelease, "desc/info/txt (1)")
	slot0._gonewbiePick = gohelper.findChild(slot0.viewGO, "view/propinfo/#simage_icon/#txt_pickdesc")
	slot0._golittlemonthcard = gohelper.findChild(slot0.viewGO, "view/littlemonthcard")
	slot0._littlemonthcardreward = gohelper.findChild(slot0._golittlemonthcard, "reward")
	slot0._littlemonthcardtxtleft = gohelper.findChildText(slot0._littlemonthcardreward, "left/txt")
	slot0._littlemonthcardtxtright = gohelper.findChildText(slot0._littlemonthcardreward, "right/txt")
	slot0._littlemonthcardiconleft = gohelper.findChild(slot0._littlemonthcardreward, "left/#go_lefticon")
	slot0._littlemonthcardiconleft2 = gohelper.findChild(slot0._littlemonthcardreward, "left/#go_lefticon2")
	slot0._littlemonthcardiconright = gohelper.findChild(slot0._littlemonthcardreward, "right/#go_righticon")
	slot0._littlemonthcardiconpower = gohelper.findChild(slot0._littlemonthcardreward, "right/#go_powericon")
	slot0._golittlemonthcardicon2new = gohelper.findChild(slot0._littlemonthcardreward, "left/#go_lefticon2/new")
	slot0._goSkinTips = gohelper.findChild(slot0.viewGO, "view/#go_SkinTips")
	slot0._imgProp = gohelper.findChildImage(slot0.viewGO, "view/#go_SkinTips/#txt_Tips/#image_Prop")
	slot0._txtPropNum = gohelper.findChildTextMesh(slot0.viewGO, "view/#go_SkinTips/#txt_Tips/#txt_Num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnbuyOnClick(slot0)
	if StoreConfig.instance:hasNextGood(slot0._mo.id) then
		StoreModel.instance:setCurBuyPackageId(slot0._mo.id)
	end

	if slot0._mo.id == StoreEnum.MonthCardGoodsId and StoreModel.instance:getMonthCardInfo() and slot2:getRemainDay() >= StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).maxDaysLimit - 1 then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)

		return
	end

	if slot0._mo.isChargeGoods then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
		PayController.instance:startPay(slot0._mo.goodsId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			if CurrencyController.instance:checkFreeDiamondEnough(slot0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, slot0._buyGoods, slot0, slot0.closeThis, slot0) then
				slot0:_buyGoods()
			end
		elseif slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.Diamond then
			if CurrencyController.instance:checkDiamondEnough(slot0._costQuantity, slot0.closeThis, slot0) then
				slot0:_buyGoods()
			end
		else
			slot0:_buyGoods()
		end
	end
end

function slot0._buyGoods(slot0)
	StoreController.instance:buyGoods(slot0._mo, 1, slot0._buyCallback, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._productList = {}
	slot0._gooffTag = gohelper.findChild(slot0.viewGO, "view/propinfo/#simage_icon/#go_offTag")
	slot0._txtoff = gohelper.findChildText(slot0.viewGO, "view/propinfo/#simage_icon/#go_offTag/#txt_off")
	slot0._gotxtCost = gohelper.findChildText(slot0.viewGO, "view/propinfo/#btn_buy/cost/txt")
	slot0._seasoncardGo = gohelper.findChild(slot0.viewGO, "view/seasoncard")
	slot1 = gohelper.findChild(slot0._seasoncardGo, "reward")
	slot0._seasoncard_txtleft = gohelper.findChildText(slot1, "left/txt")
	slot0._seasoncard_txtright = gohelper.findChildText(slot1, "right/txt")
	slot0._seasoncard_iconleft = gohelper.findChild(slot1, "left/#go_lefticon")
	slot0._seasoncard_iconleft2 = gohelper.findChild(slot1, "left/#go_lefticon2")
	slot0._seasoncard_goicon2new = gohelper.findChild(slot1, "left/#go_lefticon2/new")
	slot0._seasoncard_iconright = gohelper.findChild(slot1, "right/#go_righticon")
	slot0._seasoncard_iconpower = gohelper.findChild(slot1, "right/#go_powericon")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam

	StoreModel.instance:setCurBuyPackageId(nil)
	StoreController.instance:statOpenChargeGoods(slot0._mo.belongStoreId, slot0._mo.config)
	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)

	slot0._txtgoodsNameCn.text = slot0._mo.config.name

	slot0._simageicon:LoadImage(ResUrl.getStorePackageIcon("detail_" .. slot0._mo.config.bigImg), slot0._loadiconCb, slot0)

	if slot0._mo.config.id == uv0 then
		recthelper.setAnchor(slot0._simageicon.transform, uv1, uv2)
	end

	if slot0._mo.goodsId == StoreEnum.LittleMonthCardGoodsId or slot0._mo.config.id == uv0 or slot0._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage then
		recthelper.setAnchor(slot0._btnbuy.transform, 280.63, -232.8)
	end

	slot0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	slot0:_refreshPriceArea()
	slot0:_refreshTagArea()

	slot2 = slot0._mo.goodsId == StoreEnum.SeasonCardGoodsId
	slot3 = slot0._mo.goodsId == StoreEnum.LittleMonthCardGoodsId
	slot4 = slot0._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage
	slot5 = slot0._mo.id == StoreEnum.NewbiePackId
	slot6 = not string.nilorempty(slot0._mo.config.detailDesc)

	gohelper.setActive(slot0._gonormal, false)
	gohelper.setActive(slot0._goDetailDescNormal, false)
	gohelper.setActive(slot0._goyueka, false)
	gohelper.setActive(slot0._godailyrelease, false)
	gohelper.setActive(slot0._golittlemonthcard, false)
	gohelper.setActive(slot0._seasoncardGo, false)

	if slot0._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(slot0._goyueka, true)
		slot0:_updateMonthCard()
	elseif slot2 then
		gohelper.setActive(slot0._seasoncardGo, true)
		slot0:_updateSeasonCard()
	elseif slot3 then
		gohelper.setActive(slot0._golittlemonthcard, true)
		slot0:_updateLittleMonthCard()
	elseif slot4 then
		gohelper.setActive(slot0._godailyrelease, true)
		slot0:_updateDailyReleasePackage()
	elseif slot6 then
		gohelper.setActive(slot0._goDetailDescNormal, true)
		slot0:_updateDetailDescNormalPack()
	else
		gohelper.setActive(slot0._gonormal, true)
		slot0:_updateNormal()
	end

	gohelper.setActive(slot0._gonewbiePick, slot5)
	slot0:refreshSkinTips(slot0._mo)
end

function slot0._refreshPriceArea(slot0)
	slot1 = slot0._mo.cost

	if slot0._mo.isChargeGoods then
		gohelper.setActive(slot0._txtprice.gameObject, StoreConfig.instance:getChargeGoodsOriginalCost(slot0._mo.config.id) > 0)
	else
		gohelper.setActive(slot0._txtprice.gameObject, slot0._mo.config.originalCost > 0)
	end

	gohelper.setActive(slot0._gotxtCost.gameObject, string.nilorempty(slot1) == false)

	if string.nilorempty(slot1) or slot1 == 0 then
		slot0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(slot0._imagematerial.gameObject, false)
	elseif slot0._mo.isChargeGoods then
		slot3, slot4, slot5 = PayModel.instance:getProductOriginPriceNum(slot0._mo.id)
		slot0._txtmaterialNum.text = string.format("%s%s", PayModel.instance:getProductOriginPriceSymbol(slot0._mo.id), slot4)

		if slot5 then
			slot0._txtprice.text = string.format("%s%s", slot2, string.format("%s", math.ceil(slot3 * StoreConfig.instance:getChargeGoodsOriginalCost(slot0._mo.config.id) / slot1)))
		else
			slot0._txtprice.text = string.format("%s%s", slot2, string.format("%.2f", slot6))
		end

		gohelper.setActive(slot0._imagematerial.gameObject, false)
	else
		slot4 = string.splitToNumber(string.split(slot1, "|")[slot0._mo.buyCount + 1] or slot2[#slot2], "#")
		slot0._costType = slot4[1]
		slot0._costId = slot4[2]
		slot0._costQuantity = slot4[3]
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagematerial, string.format("%s_1", slot5.icon))

		slot0._txtmaterialNum.text = slot0._costQuantity
		slot0._txtprice.text = slot0._mo.config.originalCost

		gohelper.setActive(slot0._imagematerial.gameObject, true)
	end
end

function slot0._refreshTagArea(slot0)
	if tonumber(slot0._mo:getDiscount()) and slot1 > 0 then
		gohelper.setActive(slot0._gooffTag, true)

		slot0._txtoff.text = string.format("-%d%%", slot1)
	else
		gohelper.setActive(slot0._gooffTag, false)
	end
end

function slot0._updateNormal(slot0)
	slot1 = slot0._mo:isLevelOpen()

	gohelper.setActive(slot0._btnbuy.gameObject, slot1)
	gohelper.setActive(slot0._gotips, slot1 == false)

	if slot1 == false then
		slot0._txtlocktips.text = formatLuaLang("account_level_unlock", slot0._mo.buyLevel)
	end

	if slot0._mo.isChargeGoods and slot1 then
		slot0.isPreGoodsSoldOut = slot0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(slot0._btnbuy.gameObject, slot0.isPreGoodsSoldOut)
		gohelper.setActive(slot0._gotips, slot0.isPreGoodsSoldOut == false)

		if slot0.isPreGoodsSoldOut == false then
			slot0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", StoreConfig.instance:getChargeGoodsConfig(slot0._mo.config.preGoodsId).name)
		end
	end

	if slot0._mo.offlineTime > 0 then
		gohelper.setActive(gohelper.findChild(slot0._gonormal, "info/remain/#go_rightbg"), true)

		gohelper.findChildText(slot0._gonormal, "info/remain/#go_rightbg/#txt_remaintime").text = string.format("%s%s", TimeUtil.secondToRoughTime(math.floor(slot0._mo.offlineTime - ServerTime.now())))
	else
		gohelper.setActive(slot2, false)
	end

	slot0:_updateNormalPackCommon(gohelper.findChild(slot0._gonormal, "info/remain/#go_leftbg"), gohelper.findChildText(slot0._gonormal, "info/remain/#go_leftbg/#txt_remain"), gohelper.findChild(slot0._gonormal, "info/remain"))

	slot7 = gohelper.findChild(slot0._gonormal, "info/scroll/#scroll_product/product")

	gohelper.setActive(slot7, false)
	slot0:_updateNormalPackGoods(slot7, gohelper.findChild(slot0._gonormal, "info/scroll/#scroll_product/Viewport/Content"))
end

function slot0._updateDetailDescNormalPack(slot0)
	gohelper.setActive(slot0._goLine1, false)
	gohelper.setActive(slot0._gopropInfoTitle, false)
	gohelper.setActive(slot0._gopropInfoTitleLayout, false)

	slot1 = slot0._mo:isLevelOpen()

	gohelper.setActive(slot0._btnbuy.gameObject, slot1)
	gohelper.setActive(slot0._gotips, slot1 == false)

	if slot1 == false then
		slot0._txtlocktips.text = formatLuaLang("account_level_unlock", slot0._mo.buyLevel)
	end

	if slot0._mo.isChargeGoods and slot1 then
		slot0.isPreGoodsSoldOut = slot0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(slot0._btnbuy.gameObject, slot0.isPreGoodsSoldOut)
		gohelper.setActive(slot0._gotips, slot0.isPreGoodsSoldOut == false)

		if slot0.isPreGoodsSoldOut == false then
			slot0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", StoreConfig.instance:getChargeGoodsConfig(slot0._mo.config.preGoodsId).name)
		end
	end

	if slot0._mo.offlineTime > 0 then
		gohelper.setActive(gohelper.findChild(slot0._goDetailDescNormal, "info/remain/#go_rightbg"), true)

		gohelper.findChildText(slot0._goDetailDescNormal, "info/remain/#go_rightbg/#txt_remaintime").text = string.format("%s%s", TimeUtil.secondToRoughTime(math.floor(slot0._mo.offlineTime - ServerTime.now())))
	else
		gohelper.setActive(slot3, false)
	end

	slot0:_updateNormalPackCommon(gohelper.findChild(slot0._goDetailDescNormal, "info/remain/#go_leftbg"), gohelper.findChildText(slot0._goDetailDescNormal, "info/remain/#go_leftbg/#txt_remain"), gohelper.findChild(slot0._goDetailDescNormal, "info/remain"))

	slot7 = gohelper.findChild(slot0._goDetailDescNormal, "info/scroll/#scroll_product/product")

	gohelper.setActive(slot7, false)
	slot0:_updateNormalPackGoods(slot7, gohelper.findChild(slot0._goDetailDescNormal, "info/scroll/#scroll_product/Viewport/Content"))
	gohelper.CreateObjList(nil, function (slot0, slot1, slot2, slot3)
		gohelper.findChildText(slot1, "").text = slot2
	end, string.split(slot0._mo.config.detailDesc, "\n"), nil, gohelper.findChild(slot0._goDetailDescNormal, "info/desc/info/txt"))

	gohelper.findChildText(slot0._goDetailDescNormal, "title/#txt_goodsNameCn").text = slot0._mo.config.name
end

function slot0._updateNormalPackCommon(slot0, slot1, slot2, slot3)
	slot5 = slot0._mo.maxBuyCount - slot0._mo.buyCount
	slot6 = nil

	if string.nilorempty((not slot0._mo.isChargeGoods or StoreConfig.instance:getChargeRemainText(slot4, slot0._mo.refreshTime, slot5, slot0._mo.offlineTime)) and StoreConfig.instance:getRemainText(slot4, slot0._mo.refreshTime, slot5, slot0._mo.offlineTime)) then
		gohelper.setActive(slot1, false)
		gohelper.setActive(slot2.gameObject, false)
		gohelper.setActive(slot3, slot0._mo.offlineTime > 0)
	else
		gohelper.setActive(slot1, true)
		gohelper.setActive(slot2.gameObject, true)

		slot2.text = slot6
	end
end

function slot0._updateNormalPackGoods(slot0, slot1, slot2)
	slot3 = slot0._mo.config.product and GameUtil.splitString2(slot0._mo.config.product) or {}

	for slot7, slot8 in ipairs(slot3) do
		if slot0._productList[slot7] == nil then
			slot9 = PackageStoreGoodsViewItem.New()

			slot9:init(gohelper.clone(slot1, slot2, "productItem"))

			slot0._productList[slot7] = slot9
		end

		slot9:onUpdateMO(slot8)
		slot9:setActive(true)
	end

	for slot7 = #slot3 + 1, #slot0._productList do
		slot0._productList[slot7]:setActive(false)
	end
end

function slot0._updateMonthCard(slot0)
	gohelper.setActive(slot0._btnbuy.gameObject, true)
	gohelper.setActive(slot0._gotips, false)

	slot3 = string.splitToNumber(string.split(StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).onceBonus, "|")[1], "#")
	slot0._monthCardItemIcon = slot0._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(slot0._iconleft)

	slot0:_setIcon(slot0._monthCardItemIcon, slot3[1], slot3[2], slot3[3])

	slot8 = string.splitToNumber(string.split(slot1.onceBonus, "|")[2], "#")
	slot0._monthCardItemIcon2 = slot0._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(slot0._iconleft2)

	gohelper.setAsFirstSibling(slot0._monthCardItemIcon2.go)
	slot0:_setIcon(slot0._monthCardItemIcon2, slot8[1], slot8[2], slot8[3])
	gohelper.setActive(slot0._goicon2new, StoreHelper.checkMonthCardLevelUpTagOpen())

	slot8 = string.splitToNumber(string.split(slot1.dailyBonus, "|")[1], "#")
	slot0._monthCardDailyItemIcon = slot0._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(slot0._iconright)

	slot0:_setIcon(slot0._monthCardDailyItemIcon, slot8[1], slot8[2], slot8[3])

	slot8 = string.splitToNumber(string.split(slot1.dailyBonus, "|")[2], "#")
	slot0._monthCardPowerItemIcon = slot0._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(slot0._iconpower)

	slot0:_setIcon(slot0._monthCardPowerItemIcon, slot8[1], slot8[2], slot8[3])
end

function slot0._updateLittleMonthCard(slot0)
	gohelper.setActive(slot0._btnbuy.gameObject, true)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._golittlemonthcardicon2new, false)

	slot2 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	slot4 = string.splitToNumber(string.split(StoreConfig.instance:getMonthCardAddConfig(StoreEnum.LittleMonthCardGoodsId).onceBonus, "|")[1], "#")
	slot0._littleMonthCardItemIcon = slot0._littleMonthCardItemIcon or IconMgr.instance:getCommonItemIcon(slot0._littlemonthcardiconleft)

	slot0:_setIcon(slot0._littleMonthCardItemIcon, slot4[1], slot4[2], slot4[3])

	slot4 = string.splitToNumber(string.split(slot1.onceBonus, "|")[2], "#")
	slot0._littleMonthCardItemIcon2 = slot0._littleMonthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(slot0._littlemonthcardiconleft2)

	gohelper.setAsFirstSibling(slot0._littleMonthCardItemIcon2.go)
	slot0:_setIcon(slot0._littleMonthCardItemIcon2, slot4[1], slot4[2], slot4[3])

	slot4 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[1], "#")
	slot0._littleMonthCardDailyItemIcon = slot0._littleMonthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(slot0._littlemonthcardiconright)

	slot0:_setIcon(slot0._littleMonthCardDailyItemIcon, slot4[1], slot4[2], slot4[3])

	slot4 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[2], "#")
	slot0._littleMonthCardPowerItemIcon = slot0._littleMonthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(slot0._littlemonthcardiconpower)

	slot0:_setIcon(slot0._littleMonthCardPowerItemIcon, slot4[1], slot4[2], slot4[3])
end

function slot0._updateSeasonCard(slot0)
	gohelper.setActive(slot0._btnbuy.gameObject, true)
	gohelper.setActive(slot0._gotips, false)

	slot4 = string.splitToNumber(string.split(StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).onceBonus, "|")[1], "#")
	slot0._monthCardItemIcon = slot0._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(slot0._seasoncard_iconleft)

	slot0:_setIcon(slot0._monthCardItemIcon, slot4[1], slot4[2], slot4[3] * StoreConfig.instance:getSeasonCardMultiFactor())

	slot9 = string.splitToNumber(string.split(slot2.onceBonus, "|")[2], "#")
	slot0._monthCardItemIcon2 = slot0._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(slot0._seasoncard_iconleft2)

	gohelper.setAsFirstSibling(slot0._monthCardItemIcon2.go)
	slot0:_setIcon(slot0._monthCardItemIcon2, slot9[1], slot9[2], slot9[3] * slot1)
	gohelper.setActive(slot0._seasoncard_goicon2new, StoreHelper.checkMonthCardLevelUpTagOpen())

	slot9 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[1], "#")
	slot0._monthCardDailyItemIcon = slot0._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(slot0._seasoncard_iconright)

	slot0:_setIcon(slot0._monthCardDailyItemIcon, slot9[1], slot9[2], slot9[3])

	slot9 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[2], "#")
	slot0._monthCardPowerItemIcon = slot0._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(slot0._seasoncard_iconpower)

	slot0:_setIcon(slot0._monthCardPowerItemIcon, slot9[1], slot9[2], slot9[3])
end

function slot0._updateDailyReleasePackage(slot0, slot1)
	gohelper.setActive(slot0._btnbuy.gameObject, true)
	gohelper.setActive(slot0._gotips, false)

	if slot0._mo.isChargeGoods then
		slot0.isPreGoodsSoldOut = slot0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(slot0._btnbuy.gameObject, slot0.isPreGoodsSoldOut)
		gohelper.setActive(slot0._gotips, slot0.isPreGoodsSoldOut == false)

		if slot0.isPreGoodsSoldOut == false then
			slot0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", StoreConfig.instance:getChargeGoodsConfig(slot0._mo.config.preGoodsId).name)
		end
	end

	slot2 = StoreConfig.instance:getDailyReleasePackageCfg(slot0._mo.goodsId)
	slot3 = slot2.days
	slot5 = string.splitToNumber(string.split(slot2.onceBonus, "|")[1], "#")
	slot0._dailyReleasePackageIcon = slot0._dailyReleasePackageIcon or IconMgr.instance:getCommonItemIcon(slot0._icon2dailyreleasereleft)

	slot0:_setIcon(slot0._dailyReleasePackageIcon, slot5[1], slot5[2], slot5[3])

	if #slot4 > 1 then
		slot10 = string.splitToNumber(slot4[2], "#")
		slot0._dailyReleasePackageIcon2 = slot0._dailyReleasePackageIcon2 or IconMgr.instance:getCommonItemIcon(slot0._icondailyreleasereleft)

		slot0:_setIcon(slot0._dailyReleasePackageIcon2, slot10[1], slot10[2], slot10[3])
	end

	slot5 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[1], "#")
	slot0._dailyReleasePackageDailyItemIcon1 = slot0._dailyReleasePackageDailyItemIcon1 or IconMgr.instance:getCommonItemIcon(slot0._icondailyreleasereright)

	slot0:_setIcon(slot0._dailyReleasePackageDailyItemIcon1, slot5[1], slot5[2], slot5[3] * slot3)

	slot5 = string.splitToNumber(string.split(slot2.dailyBonus, "|")[2], "#")
	slot0._dailyReleasePackageDailyItemIcon2 = slot0._dailyReleasePackageDailyItemIcon2 or IconMgr.instance:getCommonItemIcon(slot0._icondailyreleaserepower)

	slot0:_setIcon(slot0._dailyReleasePackageDailyItemIcon2, slot5[1], slot5[2], slot5[3] * slot3)

	slot0._txtDailyReleaseDesc1.text = slot2.desc1
	slot0._txtDailyReleaseDesc2.text = slot2.desc2
end

function slot0._loadiconCb(slot0)
	slot0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function slot0._setIcon(slot0, slot1, slot2, slot3, slot4)
	if slot2 == MaterialEnum.MaterialType.PowerPotion then
		slot1:setMOValue(slot2, slot3, slot4, nil, true)
		slot1:setCantJump(true)
		slot1:setCountFontSize(36)
		slot1:setScale(0.7)
		slot1:SetCountLocalY(43.6)
		slot1:SetCountBgHeight(25)
		slot1:setItemIconScale(1.1)
		recthelper.setAnchor(slot1:getIcon().transform, -7.2, 3.5)

		slot6 = slot1:getDeadline1()

		recthelper.setAnchor(slot6.transform, 78, 82.8)
		transformhelper.setLocalScale(slot6.transform, 0.7, 0.7, 1)

		slot0._simgdeadline = gohelper.findChildImage(slot6, "timebg")

		UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._simgdeadline, "img_xianshi1")
	else
		slot1:setMOValue(slot2, slot3, slot4, nil, true)
		slot1:setCantJump(true)
		slot1:setCountFontSize(36)
		slot1:setScale(0.7)
		slot1:SetCountLocalY(43.6)
		slot1:SetCountBgHeight(25)
	end
end

function slot0._buyCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:closeThis()
	end
end

function slot0._payFinished(slot0)
	slot0:closeThis()
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

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	GameUtil.onDestroyViewMemberList(slot0, "_productList")

	if slot0._monthCardItemIcon then
		slot0._monthCardItemIcon:onDestroy()
	end

	if slot0._monthCardDailyItemIcon then
		slot0._monthCardDailyItemIcon:onDestroy()
	end
end

return slot0
