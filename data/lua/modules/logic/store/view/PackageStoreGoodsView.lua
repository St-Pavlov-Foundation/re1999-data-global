module("modules.logic.store.view.PackageStoreGoodsView", package.seeall)

local var_0_0 = class("PackageStoreGoodsView", BaseView)
local var_0_1 = 811372
local var_0_2 = 610001
local var_0_3 = -399
local var_0_4 = 90

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_blur")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_rightbg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/propinfo/#simage_icon")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/txt_goodslayout/#txt_goodsNameCn")
	arg_1_0._goSecondGoodsName = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/#txt_goodsNameCn/#txt_goodstips")
	arg_1_0._btnbuy = gohelper.findChildButton(arg_1_0.viewGO, "view/propinfo/#btn_buy")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/#go_tips")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/#go_tips/#txt_locktips")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/#btn_buy/cost/#txt_materialNum")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/#btn_buy/cost/#txt_price")
	arg_1_0._imagematerial = gohelper.findChildImage(arg_1_0.viewGO, "view/propinfo/#btn_buy/cost/simage_material")
	arg_1_0._goLine1 = gohelper.findChild(arg_1_0.viewGO, "view/bg/line")
	arg_1_0._gopropInfoTitle = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/title")
	arg_1_0._gopropInfoTitleLayout = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/txt_goodslayout")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "view/normal")
	arg_1_0._goDetailDescNormal = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail")
	arg_1_0._goyueka = gohelper.findChild(arg_1_0.viewGO, "view/yueka")
	arg_1_0._reward = gohelper.findChild(arg_1_0._goyueka, "reward")
	arg_1_0._txtleft = gohelper.findChildText(arg_1_0._reward, "left/txt")
	arg_1_0._txtright = gohelper.findChildText(arg_1_0._reward, "right/txt")
	arg_1_0._iconleft = gohelper.findChild(arg_1_0._reward, "left/#go_lefticon")
	arg_1_0._iconleft2 = gohelper.findChild(arg_1_0._reward, "left/#go_lefticon2")
	arg_1_0._goicon2new = gohelper.findChild(arg_1_0._reward, "left/#go_lefticon2/new")
	arg_1_0._iconright = gohelper.findChild(arg_1_0._reward, "right/#go_righticon")
	arg_1_0._iconpower = gohelper.findChild(arg_1_0._reward, "right/#go_powericon")
	arg_1_0._godailyrelease = gohelper.findChild(arg_1_0.viewGO, "view/dailyrelease")
	arg_1_0._dailyreleasereward = gohelper.findChild(arg_1_0._godailyrelease, "reward")
	arg_1_0._txtdailyreleasereleft = gohelper.findChildText(arg_1_0._dailyreleasereward, "left/txt")
	arg_1_0._txtdailyreleasereright = gohelper.findChildText(arg_1_0._dailyreleasereward, "right/txt")
	arg_1_0._icondailyreleasereleft = gohelper.findChild(arg_1_0._dailyreleasereward, "left/#go_lefticon")
	arg_1_0._icon2dailyreleasereleft = gohelper.findChild(arg_1_0._dailyreleasereward, "left/#go_lefticon2")
	arg_1_0._icondailyreleasereright = gohelper.findChild(arg_1_0._dailyreleasereward, "right/#go_righticon")
	arg_1_0._icondailyreleaserepower = gohelper.findChild(arg_1_0._dailyreleasereward, "right/#go_powericon")
	arg_1_0._txtDailyReleaseDesc1 = gohelper.findChildText(arg_1_0._godailyrelease, "desc/info/txt")
	arg_1_0._txtDailyReleaseDesc2 = gohelper.findChildText(arg_1_0._godailyrelease, "desc/info/txt (1)")
	arg_1_0._gonewbiePick = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/#simage_icon/#txt_pickdesc")
	arg_1_0._golittlemonthcard = gohelper.findChild(arg_1_0.viewGO, "view/littlemonthcard")
	arg_1_0._littlemonthcardreward = gohelper.findChild(arg_1_0._golittlemonthcard, "reward")
	arg_1_0._littlemonthcardtxtleft = gohelper.findChildText(arg_1_0._littlemonthcardreward, "left/txt")
	arg_1_0._littlemonthcardtxtright = gohelper.findChildText(arg_1_0._littlemonthcardreward, "right/txt")
	arg_1_0._littlemonthcardiconleft = gohelper.findChild(arg_1_0._littlemonthcardreward, "left/#go_lefticon")
	arg_1_0._littlemonthcardiconleft2 = gohelper.findChild(arg_1_0._littlemonthcardreward, "left/#go_lefticon2")
	arg_1_0._littlemonthcardiconright = gohelper.findChild(arg_1_0._littlemonthcardreward, "right/#go_righticon")
	arg_1_0._littlemonthcardiconpower = gohelper.findChild(arg_1_0._littlemonthcardreward, "right/#go_powericon")
	arg_1_0._golittlemonthcardicon2new = gohelper.findChild(arg_1_0._littlemonthcardreward, "left/#go_lefticon2/new")
	arg_1_0._goSkinTips = gohelper.findChild(arg_1_0.viewGO, "view/#go_SkinTips")
	arg_1_0._imgProp = gohelper.findChildImage(arg_1_0.viewGO, "view/#go_SkinTips/#txt_Tips/#image_Prop")
	arg_1_0._txtPropNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "view/#go_SkinTips/#txt_Tips/#txt_Num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)

	if arg_2_0._btnoverview then
		arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()

	if arg_3_0._btnoverview then
		arg_3_0._btnoverview:RemoveClickListener()
	end
end

function var_0_0._btnbuyOnClick(arg_4_0)
	if StoreConfig.instance:hasNextGood(arg_4_0._mo.id) then
		StoreModel.instance:setCurBuyPackageId(arg_4_0._mo.id)
	end

	if arg_4_0._mo.id == StoreEnum.MonthCardGoodsId then
		local var_4_0 = StoreModel.instance:getMonthCardInfo()

		if var_4_0 and var_4_0:getRemainDay() >= StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).maxDaysLimit - 1 then
			GameFacade.showToast(ToastEnum.PackageStoreGoods)

			return
		end
	end

	if arg_4_0._mo.isChargeGoods then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
		PayController.instance:startPay(arg_4_0._mo.goodsId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if arg_4_0._costType == MaterialEnum.MaterialType.Currency and arg_4_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			if CurrencyController.instance:checkFreeDiamondEnough(arg_4_0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_4_0._buyGoods, arg_4_0, arg_4_0.closeThis, arg_4_0) then
				arg_4_0:_buyGoods()
			end
		elseif arg_4_0._costType == MaterialEnum.MaterialType.Currency and arg_4_0._costId == CurrencyEnum.CurrencyType.Diamond then
			if CurrencyController.instance:checkDiamondEnough(arg_4_0._costQuantity, arg_4_0.closeThis, arg_4_0) then
				arg_4_0:_buyGoods()
			end
		else
			arg_4_0:_buyGoods()
		end
	end
end

function var_0_0._buyGoods(arg_5_0)
	StoreController.instance:buyGoods(arg_5_0._mo, 1, arg_5_0._buyCallback, arg_5_0)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnoverviewOnClick(arg_7_0)
	if not string.nilorempty(arg_7_0._overviewJumpId) then
		GameFacade.jumpByAdditionParam(arg_7_0._overviewJumpId)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_8_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_8_0._productList = {}
	arg_8_0._gooffTag = gohelper.findChild(arg_8_0.viewGO, "view/propinfo/#simage_icon/#go_offTag")
	arg_8_0._txtoff = gohelper.findChildText(arg_8_0.viewGO, "view/propinfo/#simage_icon/#go_offTag/#txt_off")
	arg_8_0._gotxtCost = gohelper.findChildText(arg_8_0.viewGO, "view/propinfo/#btn_buy/cost/txt")
	arg_8_0._gotxtv2a8_09 = gohelper.findChild(arg_8_0.viewGO, "view/propinfo/#simage_icon/txt_v2a8_09")
	arg_8_0._seasoncardGo = gohelper.findChild(arg_8_0.viewGO, "view/seasoncard")

	local var_8_0 = gohelper.findChild(arg_8_0._seasoncardGo, "reward")

	arg_8_0._seasoncard_txtleft = gohelper.findChildText(var_8_0, "left/txt")
	arg_8_0._seasoncard_txtright = gohelper.findChildText(var_8_0, "right/txt")
	arg_8_0._seasoncard_iconleft = gohelper.findChild(var_8_0, "left/#go_lefticon")
	arg_8_0._seasoncard_iconleft2 = gohelper.findChild(var_8_0, "left/#go_lefticon2")
	arg_8_0._seasoncard_goicon2new = gohelper.findChild(var_8_0, "left/#go_lefticon2/new")
	arg_8_0._seasoncard_iconright = gohelper.findChild(var_8_0, "right/#go_righticon")
	arg_8_0._seasoncard_iconpower = gohelper.findChild(var_8_0, "right/#go_powericon")
	arg_8_0._btnoverview = gohelper.findChildButtonWithAudio(arg_8_0.viewGO, "view/#go_overview")
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:onOpen()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._mo = arg_10_0.viewParam
	arg_10_0._overviewJumpId = arg_10_0._mo and arg_10_0._mo.config and arg_10_0._mo.config.overviewJumpId

	StoreModel.instance:setCurBuyPackageId(nil)
	StoreController.instance:statOpenChargeGoods(arg_10_0._mo.belongStoreId, arg_10_0._mo.config)
	arg_10_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_10_0._payFinished, arg_10_0)

	arg_10_0._txtgoodsNameCn.text = arg_10_0._mo.config.name

	arg_10_0._simageicon:LoadImage(ResUrl.getStorePackageIcon("detail_" .. arg_10_0._mo.config.bigImg), arg_10_0._loadiconCb, arg_10_0)

	if arg_10_0._mo.config.id == var_0_2 then
		recthelper.setAnchor(arg_10_0._simageicon.transform, var_0_3, var_0_4)
	end

	if arg_10_0._mo.goodsId == StoreEnum.LittleMonthCardGoodsId or arg_10_0._mo.config.id == var_0_2 or arg_10_0._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage then
		recthelper.setAnchor(arg_10_0._btnbuy.transform, 280.63, -232.8)
	end

	arg_10_0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	arg_10_0:_refreshPriceArea()
	arg_10_0:_refreshTagArea()

	local var_10_0 = arg_10_0._mo.goodsId == StoreEnum.MonthCardGoodsId
	local var_10_1 = arg_10_0._mo.goodsId == StoreEnum.SeasonCardGoodsId
	local var_10_2 = arg_10_0._mo.goodsId == StoreEnum.LittleMonthCardGoodsId
	local var_10_3 = arg_10_0._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage
	local var_10_4 = arg_10_0._mo.id == StoreEnum.NewbiePackId
	local var_10_5 = not string.nilorempty(arg_10_0._mo.config.detailDesc)

	gohelper.setActive(arg_10_0._gonormal, false)
	gohelper.setActive(arg_10_0._goDetailDescNormal, false)
	gohelper.setActive(arg_10_0._goyueka, false)
	gohelper.setActive(arg_10_0._godailyrelease, false)
	gohelper.setActive(arg_10_0._golittlemonthcard, false)
	gohelper.setActive(arg_10_0._seasoncardGo, false)

	if var_10_0 then
		gohelper.setActive(arg_10_0._goyueka, true)
		arg_10_0:_updateMonthCard()
	elseif var_10_1 then
		gohelper.setActive(arg_10_0._seasoncardGo, true)
		arg_10_0:_updateSeasonCard()
	elseif var_10_2 then
		gohelper.setActive(arg_10_0._golittlemonthcard, true)
		arg_10_0:_updateLittleMonthCard()
	elseif var_10_3 then
		gohelper.setActive(arg_10_0._godailyrelease, true)
		arg_10_0:_updateDailyReleasePackage()
	elseif var_10_5 then
		gohelper.setActive(arg_10_0._goDetailDescNormal, true)
		arg_10_0:_updateDetailDescNormalPack()
	else
		gohelper.setActive(arg_10_0._gonormal, true)
		arg_10_0:_updateNormal()
	end

	gohelper.setActive(arg_10_0._gonewbiePick, var_10_4)
	arg_10_0:refreshSkinTips(arg_10_0._mo)
	gohelper.setActive(arg_10_0._gotxtv2a8_09, PackageStoreEnum.AnimHeadDict[arg_10_0._mo.goodsId])

	if arg_10_0._btnoverview then
		gohelper.setActive(arg_10_0._btnoverview, not string.nilorempty(arg_10_0._overviewJumpId))
	end
end

function var_0_0._refreshPriceArea(arg_11_0)
	local var_11_0 = arg_11_0._mo.cost

	if arg_11_0._mo.isChargeGoods then
		gohelper.setActive(arg_11_0._txtprice.gameObject, StoreConfig.instance:getChargeGoodsOriginalCost(arg_11_0._mo.config.id) > 0)
	else
		gohelper.setActive(arg_11_0._txtprice.gameObject, arg_11_0._mo.config.originalCost > 0)
	end

	gohelper.setActive(arg_11_0._gotxtCost.gameObject, string.nilorempty(var_11_0) == false)

	if string.nilorempty(var_11_0) or var_11_0 == 0 then
		arg_11_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_11_0._imagematerial.gameObject, false)
	elseif arg_11_0._mo.isChargeGoods then
		local var_11_1 = PayModel.instance:getProductOriginPriceSymbol(arg_11_0._mo.id)
		local var_11_2, var_11_3, var_11_4 = PayModel.instance:getProductOriginPriceNum(arg_11_0._mo.id)

		arg_11_0._txtmaterialNum.text = string.format("%s%s", var_11_1, var_11_3)

		local var_11_5 = var_11_2 * (StoreConfig.instance:getChargeGoodsOriginalCost(arg_11_0._mo.config.id) / var_11_0)

		if var_11_4 then
			var_11_5 = math.ceil(var_11_5)
			arg_11_0._txtprice.text = string.format("%s%s", var_11_1, string.format("%s", var_11_5))
		else
			arg_11_0._txtprice.text = string.format("%s%s", var_11_1, string.format("%.2f", var_11_5))
		end

		gohelper.setActive(arg_11_0._imagematerial.gameObject, false)
	else
		local var_11_6 = string.split(var_11_0, "|")
		local var_11_7 = var_11_6[arg_11_0._mo.buyCount + 1] or var_11_6[#var_11_6]
		local var_11_8 = string.splitToNumber(var_11_7, "#")

		arg_11_0._costType = var_11_8[1]
		arg_11_0._costId = var_11_8[2]
		arg_11_0._costQuantity = var_11_8[3]

		local var_11_9, var_11_10 = ItemModel.instance:getItemConfigAndIcon(arg_11_0._costType, arg_11_0._costId)
		local var_11_11 = var_11_9.icon
		local var_11_12 = string.format("%s_1", var_11_11)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_11_0._imagematerial, var_11_12)

		arg_11_0._txtmaterialNum.text = arg_11_0._costQuantity
		arg_11_0._txtprice.text = arg_11_0._mo.config.originalCost

		gohelper.setActive(arg_11_0._imagematerial.gameObject, true)

		if ItemModel.instance:getItemQuantity(arg_11_0._costType, arg_11_0._costId) >= arg_11_0._costQuantity then
			SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtmaterialNum, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtmaterialNum, "#bf2e11")
		end
	end
end

function var_0_0._refreshTagArea(arg_12_0)
	local var_12_0 = tonumber(arg_12_0._mo:getDiscount())

	if var_12_0 and var_12_0 > 0 then
		gohelper.setActive(arg_12_0._gooffTag, true)

		arg_12_0._txtoff.text = string.format("-%d%%", var_12_0)
	else
		gohelper.setActive(arg_12_0._gooffTag, false)
	end
end

function var_0_0._updateNormal(arg_13_0)
	local var_13_0 = arg_13_0._mo:isLevelOpen()

	gohelper.setActive(arg_13_0._btnbuy.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._gotips, var_13_0 == false)

	if var_13_0 == false then
		arg_13_0._txtlocktips.text = formatLuaLang("account_level_unlock", arg_13_0._mo.buyLevel)
	end

	if arg_13_0._mo.isChargeGoods and var_13_0 then
		arg_13_0.isPreGoodsSoldOut = arg_13_0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(arg_13_0._btnbuy.gameObject, arg_13_0.isPreGoodsSoldOut)
		gohelper.setActive(arg_13_0._gotips, arg_13_0.isPreGoodsSoldOut == false)

		if arg_13_0.isPreGoodsSoldOut == false then
			local var_13_1 = StoreConfig.instance:getChargeGoodsConfig(arg_13_0._mo.config.preGoodsId)

			arg_13_0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", var_13_1.name)
		end
	end

	local var_13_2 = gohelper.findChild(arg_13_0._gonormal, "info/remain/#go_rightbg")
	local var_13_3 = gohelper.findChildText(arg_13_0._gonormal, "info/remain/#go_rightbg/#txt_remaintime")

	if arg_13_0._mo.offlineTime > 0 then
		local var_13_4 = math.floor(arg_13_0._mo.offlineTime - ServerTime.now())

		gohelper.setActive(var_13_2, true)

		var_13_3.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_13_4))
	else
		gohelper.setActive(var_13_2, false)
	end

	local var_13_5 = gohelper.findChild(arg_13_0._gonormal, "info/remain/#go_leftbg")
	local var_13_6 = gohelper.findChildText(arg_13_0._gonormal, "info/remain/#go_leftbg/#txt_remain")
	local var_13_7 = gohelper.findChild(arg_13_0._gonormal, "info/remain")

	arg_13_0:_updateNormalPackCommon(var_13_5, var_13_6, var_13_7)

	local var_13_8 = gohelper.findChild(arg_13_0._gonormal, "info/scroll/#scroll_product/product")
	local var_13_9 = gohelper.findChild(arg_13_0._gonormal, "info/scroll/#scroll_product/Viewport/Content")

	gohelper.setActive(var_13_8, false)
	arg_13_0:_updateNormalPackGoods(var_13_8, var_13_9)
end

function var_0_0._updateDetailDescNormalPack(arg_14_0)
	gohelper.setActive(arg_14_0._goLine1, false)
	gohelper.setActive(arg_14_0._gopropInfoTitle, false)
	gohelper.setActive(arg_14_0._gopropInfoTitleLayout, false)

	local var_14_0 = arg_14_0._mo:isLevelOpen()

	gohelper.setActive(arg_14_0._btnbuy.gameObject, var_14_0)
	gohelper.setActive(arg_14_0._gotips, var_14_0 == false)

	if var_14_0 == false then
		arg_14_0._txtlocktips.text = formatLuaLang("account_level_unlock", arg_14_0._mo.buyLevel)
	end

	if arg_14_0._mo.isChargeGoods and var_14_0 then
		arg_14_0.isPreGoodsSoldOut = arg_14_0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(arg_14_0._btnbuy.gameObject, arg_14_0.isPreGoodsSoldOut)
		gohelper.setActive(arg_14_0._gotips, arg_14_0.isPreGoodsSoldOut == false)

		if arg_14_0.isPreGoodsSoldOut == false then
			local var_14_1 = StoreConfig.instance:getChargeGoodsConfig(arg_14_0._mo.config.preGoodsId)

			arg_14_0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", var_14_1.name)
		end
	end

	local var_14_2 = gohelper.findChildText(arg_14_0._goDetailDescNormal, "info/remain/#go_rightbg/#txt_remaintime")
	local var_14_3 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/remain/#go_rightbg")

	if arg_14_0._mo.offlineTime > 0 then
		local var_14_4 = math.floor(arg_14_0._mo.offlineTime - ServerTime.now())

		gohelper.setActive(var_14_3, true)

		var_14_2.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_14_4))
	else
		gohelper.setActive(var_14_3, false)
	end

	local var_14_5 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/remain")
	local var_14_6 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/remain/#go_leftbg")
	local var_14_7 = gohelper.findChildText(arg_14_0._goDetailDescNormal, "info/remain/#go_leftbg/#txt_remain")

	arg_14_0:_updateNormalPackCommon(var_14_6, var_14_7, var_14_5)

	local var_14_8 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/scroll/#scroll_product/product")
	local var_14_9 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/scroll/#scroll_product/Viewport/Content")

	gohelper.setActive(var_14_8, false)
	arg_14_0:_updateNormalPackGoods(var_14_8, var_14_9)

	local var_14_10 = gohelper.findChild(arg_14_0._goDetailDescNormal, "info/desc/info/txt")
	local var_14_11 = arg_14_0._mo.config.detailDesc
	local var_14_12 = string.split(var_14_11, "\n")

	gohelper.CreateObjList(nil, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		gohelper.findChildText(arg_15_1, "").text = arg_15_2
	end, var_14_12, nil, var_14_10)

	gohelper.findChildText(arg_14_0._goDetailDescNormal, "title/#txt_goodsNameCn").text = arg_14_0._mo.config.name
end

function var_0_0._updateNormalPackCommon(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0._mo.maxBuyCount
	local var_16_1 = var_16_0 - arg_16_0._mo.buyCount
	local var_16_2

	if arg_16_0._mo.isChargeGoods then
		var_16_2 = StoreConfig.instance:getChargeRemainText(var_16_0, arg_16_0._mo.refreshTime, var_16_1, arg_16_0._mo.offlineTime)
	else
		var_16_2 = StoreConfig.instance:getRemainText(var_16_0, arg_16_0._mo.refreshTime, var_16_1, arg_16_0._mo.offlineTime)
	end

	if string.nilorempty(var_16_2) then
		gohelper.setActive(arg_16_1, false)
		gohelper.setActive(arg_16_2.gameObject, false)
		gohelper.setActive(arg_16_3, arg_16_0._mo.offlineTime > 0)
	else
		gohelper.setActive(arg_16_1, true)
		gohelper.setActive(arg_16_2.gameObject, true)

		arg_16_2.text = var_16_2
	end
end

function var_0_0._updateNormalPackGoods(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._mo.config.product and GameUtil.splitString2(arg_17_0._mo.config.product) or {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_1 = arg_17_0._productList[iter_17_0]

		if var_17_1 == nil then
			var_17_1 = PackageStoreGoodsViewItem.New()

			local var_17_2 = gohelper.clone(arg_17_1, arg_17_2, "productItem")

			var_17_1:init(var_17_2)

			arg_17_0._productList[iter_17_0] = var_17_1
		end

		var_17_1:onUpdateMO(iter_17_1)
		var_17_1:setActive(true)
	end

	for iter_17_2 = #var_17_0 + 1, #arg_17_0._productList do
		arg_17_0._productList[iter_17_2]:setActive(false)
	end
end

function var_0_0._updateMonthCard(arg_18_0)
	gohelper.setActive(arg_18_0._btnbuy.gameObject, true)
	gohelper.setActive(arg_18_0._gotips, false)

	local var_18_0 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local var_18_1 = string.split(var_18_0.onceBonus, "|")[1]
	local var_18_2 = string.splitToNumber(var_18_1, "#")
	local var_18_3 = var_18_2[1]
	local var_18_4 = var_18_2[2]
	local var_18_5 = var_18_2[3]

	arg_18_0._monthCardItemIcon = arg_18_0._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(arg_18_0._iconleft)

	arg_18_0:_setIcon(arg_18_0._monthCardItemIcon, var_18_3, var_18_4, var_18_5)

	local var_18_6 = string.split(var_18_0.onceBonus, "|")[2]
	local var_18_7 = string.splitToNumber(var_18_6, "#")
	local var_18_8 = var_18_7[1]
	local var_18_9 = var_18_7[2]
	local var_18_10 = var_18_7[3]

	arg_18_0._monthCardItemIcon2 = arg_18_0._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(arg_18_0._iconleft2)

	gohelper.setAsFirstSibling(arg_18_0._monthCardItemIcon2.go)
	arg_18_0:_setIcon(arg_18_0._monthCardItemIcon2, var_18_8, var_18_9, var_18_10)

	local var_18_11 = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(arg_18_0._goicon2new, var_18_11)

	local var_18_12 = string.split(var_18_0.dailyBonus, "|")[1]
	local var_18_13 = string.splitToNumber(var_18_12, "#")
	local var_18_14 = var_18_13[1]
	local var_18_15 = var_18_13[2]
	local var_18_16 = var_18_13[3]

	arg_18_0._monthCardDailyItemIcon = arg_18_0._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(arg_18_0._iconright)

	arg_18_0:_setIcon(arg_18_0._monthCardDailyItemIcon, var_18_14, var_18_15, var_18_16)

	local var_18_17 = string.split(var_18_0.dailyBonus, "|")[2]
	local var_18_18 = string.splitToNumber(var_18_17, "#")
	local var_18_19 = var_18_18[1]
	local var_18_20 = var_18_18[2]
	local var_18_21 = var_18_18[3]

	arg_18_0._monthCardPowerItemIcon = arg_18_0._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(arg_18_0._iconpower)

	arg_18_0:_setIcon(arg_18_0._monthCardPowerItemIcon, var_18_19, var_18_20, var_18_21)
end

function var_0_0._updateLittleMonthCard(arg_19_0)
	gohelper.setActive(arg_19_0._btnbuy.gameObject, true)
	gohelper.setActive(arg_19_0._gotips, false)
	gohelper.setActive(arg_19_0._golittlemonthcardicon2new, false)

	local var_19_0 = StoreConfig.instance:getMonthCardAddConfig(StoreEnum.LittleMonthCardGoodsId)
	local var_19_1 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local var_19_2 = string.split(var_19_0.onceBonus, "|")[1]
	local var_19_3 = string.splitToNumber(var_19_2, "#")
	local var_19_4 = var_19_3[1]
	local var_19_5 = var_19_3[2]
	local var_19_6 = var_19_3[3]

	arg_19_0._littleMonthCardItemIcon = arg_19_0._littleMonthCardItemIcon or IconMgr.instance:getCommonItemIcon(arg_19_0._littlemonthcardiconleft)

	arg_19_0:_setIcon(arg_19_0._littleMonthCardItemIcon, var_19_4, var_19_5, var_19_6)

	local var_19_7 = string.split(var_19_0.onceBonus, "|")[2]
	local var_19_8 = string.splitToNumber(var_19_7, "#")
	local var_19_9 = var_19_8[1]
	local var_19_10 = var_19_8[2]
	local var_19_11 = var_19_8[3]

	arg_19_0._littleMonthCardItemIcon2 = arg_19_0._littleMonthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(arg_19_0._littlemonthcardiconleft2)

	gohelper.setAsFirstSibling(arg_19_0._littleMonthCardItemIcon2.go)
	arg_19_0:_setIcon(arg_19_0._littleMonthCardItemIcon2, var_19_9, var_19_10, var_19_11)

	local var_19_12 = string.split(var_19_1.dailyBonus, "|")[1]
	local var_19_13 = string.splitToNumber(var_19_12, "#")
	local var_19_14 = var_19_13[1]
	local var_19_15 = var_19_13[2]
	local var_19_16 = var_19_13[3]

	arg_19_0._littleMonthCardDailyItemIcon = arg_19_0._littleMonthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(arg_19_0._littlemonthcardiconright)

	arg_19_0:_setIcon(arg_19_0._littleMonthCardDailyItemIcon, var_19_14, var_19_15, var_19_16)

	local var_19_17 = string.split(var_19_1.dailyBonus, "|")[2]
	local var_19_18 = string.splitToNumber(var_19_17, "#")
	local var_19_19 = var_19_18[1]
	local var_19_20 = var_19_18[2]
	local var_19_21 = var_19_18[3]

	arg_19_0._littleMonthCardPowerItemIcon = arg_19_0._littleMonthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(arg_19_0._littlemonthcardiconpower)

	arg_19_0:_setIcon(arg_19_0._littleMonthCardPowerItemIcon, var_19_19, var_19_20, var_19_21)
end

function var_0_0._updateSeasonCard(arg_20_0)
	local var_20_0 = StoreConfig.instance:getSeasonCardMultiFactor()

	gohelper.setActive(arg_20_0._btnbuy.gameObject, true)
	gohelper.setActive(arg_20_0._gotips, false)

	local var_20_1 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local var_20_2 = string.split(var_20_1.onceBonus, "|")[1]
	local var_20_3 = string.splitToNumber(var_20_2, "#")
	local var_20_4 = var_20_3[1]
	local var_20_5 = var_20_3[2]
	local var_20_6 = var_20_3[3] * var_20_0

	arg_20_0._monthCardItemIcon = arg_20_0._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(arg_20_0._seasoncard_iconleft)

	arg_20_0:_setIcon(arg_20_0._monthCardItemIcon, var_20_4, var_20_5, var_20_6)

	local var_20_7 = string.split(var_20_1.onceBonus, "|")[2]
	local var_20_8 = string.splitToNumber(var_20_7, "#")
	local var_20_9 = var_20_8[1]
	local var_20_10 = var_20_8[2]
	local var_20_11 = var_20_8[3] * var_20_0

	arg_20_0._monthCardItemIcon2 = arg_20_0._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(arg_20_0._seasoncard_iconleft2)

	gohelper.setAsFirstSibling(arg_20_0._monthCardItemIcon2.go)
	arg_20_0:_setIcon(arg_20_0._monthCardItemIcon2, var_20_9, var_20_10, var_20_11)

	local var_20_12 = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(arg_20_0._seasoncard_goicon2new, var_20_12)

	local var_20_13 = string.split(var_20_1.dailyBonus, "|")[1]
	local var_20_14 = string.splitToNumber(var_20_13, "#")
	local var_20_15 = var_20_14[1]
	local var_20_16 = var_20_14[2]
	local var_20_17 = var_20_14[3]

	arg_20_0._monthCardDailyItemIcon = arg_20_0._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(arg_20_0._seasoncard_iconright)

	arg_20_0:_setIcon(arg_20_0._monthCardDailyItemIcon, var_20_15, var_20_16, var_20_17)

	local var_20_18 = string.split(var_20_1.dailyBonus, "|")[2]
	local var_20_19 = string.splitToNumber(var_20_18, "#")
	local var_20_20 = var_20_19[1]
	local var_20_21 = var_20_19[2]
	local var_20_22 = var_20_19[3]

	arg_20_0._monthCardPowerItemIcon = arg_20_0._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(arg_20_0._seasoncard_iconpower)

	arg_20_0:_setIcon(arg_20_0._monthCardPowerItemIcon, var_20_20, var_20_21, var_20_22)
end

function var_0_0._updateDailyReleasePackage(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._btnbuy.gameObject, true)
	gohelper.setActive(arg_21_0._gotips, false)

	if arg_21_0._mo.isChargeGoods then
		arg_21_0.isPreGoodsSoldOut = arg_21_0._mo:checkPreGoodsSoldOut()

		gohelper.setActive(arg_21_0._btnbuy.gameObject, arg_21_0.isPreGoodsSoldOut)
		gohelper.setActive(arg_21_0._gotips, arg_21_0.isPreGoodsSoldOut == false)

		if arg_21_0.isPreGoodsSoldOut == false then
			local var_21_0 = StoreConfig.instance:getChargeGoodsConfig(arg_21_0._mo.config.preGoodsId)

			arg_21_0._txtlocktips.text = formatLuaLang("packagestoregoods_pregoods_tips", var_21_0.name)
		end
	end

	local var_21_1 = StoreConfig.instance:getDailyReleasePackageCfg(arg_21_0._mo.goodsId)
	local var_21_2 = var_21_1.days
	local var_21_3 = string.split(var_21_1.onceBonus, "|")
	local var_21_4 = string.splitToNumber(var_21_3[1], "#")
	local var_21_5 = var_21_4[1]
	local var_21_6 = var_21_4[2]
	local var_21_7 = var_21_4[3]

	arg_21_0._dailyReleasePackageIcon = arg_21_0._dailyReleasePackageIcon or IconMgr.instance:getCommonItemIcon(arg_21_0._icon2dailyreleasereleft)

	arg_21_0:_setIcon(arg_21_0._dailyReleasePackageIcon, var_21_5, var_21_6, var_21_7)

	if #var_21_3 > 1 then
		local var_21_8 = var_21_3[2]
		local var_21_9 = string.splitToNumber(var_21_8, "#")
		local var_21_10 = var_21_9[1]
		local var_21_11 = var_21_9[2]
		local var_21_12 = var_21_9[3]

		arg_21_0._dailyReleasePackageIcon2 = arg_21_0._dailyReleasePackageIcon2 or IconMgr.instance:getCommonItemIcon(arg_21_0._icondailyreleasereleft)

		arg_21_0:_setIcon(arg_21_0._dailyReleasePackageIcon2, var_21_10, var_21_11, var_21_12)
	end

	local var_21_13 = string.split(var_21_1.dailyBonus, "|")[1]
	local var_21_14 = string.splitToNumber(var_21_13, "#")
	local var_21_15 = var_21_14[1]
	local var_21_16 = var_21_14[2]
	local var_21_17 = var_21_14[3]

	arg_21_0._dailyReleasePackageDailyItemIcon1 = arg_21_0._dailyReleasePackageDailyItemIcon1 or IconMgr.instance:getCommonItemIcon(arg_21_0._icondailyreleasereright)

	arg_21_0:_setIcon(arg_21_0._dailyReleasePackageDailyItemIcon1, var_21_15, var_21_16, var_21_17 * var_21_2)

	local var_21_18 = string.split(var_21_1.dailyBonus, "|")[2]
	local var_21_19 = string.splitToNumber(var_21_18, "#")
	local var_21_20 = var_21_19[1]
	local var_21_21 = var_21_19[2]
	local var_21_22 = var_21_19[3]

	arg_21_0._dailyReleasePackageDailyItemIcon2 = arg_21_0._dailyReleasePackageDailyItemIcon2 or IconMgr.instance:getCommonItemIcon(arg_21_0._icondailyreleaserepower)

	arg_21_0:_setIcon(arg_21_0._dailyReleasePackageDailyItemIcon2, var_21_20, var_21_21, var_21_22 * var_21_2)

	arg_21_0._txtDailyReleaseDesc1.text = var_21_1.desc1
	arg_21_0._txtDailyReleaseDesc2.text = var_21_1.desc2
end

function var_0_0._loadiconCb(arg_22_0)
	arg_22_0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function var_0_0._setIcon(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_2 == MaterialEnum.MaterialType.PowerPotion then
		arg_23_1:setMOValue(arg_23_2, arg_23_3, arg_23_4, nil, true)
		arg_23_1:setCantJump(true)
		arg_23_1:setCountFontSize(36)
		arg_23_1:setScale(0.7)
		arg_23_1:SetCountLocalY(43.6)
		arg_23_1:SetCountBgHeight(25)
		arg_23_1:setItemIconScale(1.1)

		local var_23_0 = arg_23_1:getIcon().transform

		recthelper.setAnchor(var_23_0, -7.2, 3.5)

		local var_23_1 = arg_23_1:getDeadline1()

		recthelper.setAnchor(var_23_1.transform, 78, 82.8)
		transformhelper.setLocalScale(var_23_1.transform, 0.7, 0.7, 1)

		arg_23_0._simgdeadline = gohelper.findChildImage(var_23_1, "timebg")

		UISpriteSetMgr.instance:setStoreGoodsSprite(arg_23_0._simgdeadline, "img_xianshi1")
	else
		arg_23_1:setMOValue(arg_23_2, arg_23_3, arg_23_4, nil, true)
		arg_23_1:setCantJump(true)
		arg_23_1:setCountFontSize(36)
		arg_23_1:setScale(0.7)
		arg_23_1:SetCountLocalY(43.6)
		arg_23_1:SetCountBgHeight(25)
	end
end

function var_0_0._buyCallback(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 == 0 then
		arg_24_0:closeThis()
	end
end

function var_0_0._payFinished(arg_25_0)
	arg_25_0:closeThis()
end

function var_0_0.refreshSkinTips(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = SkinConfig.instance:isSkinStoreGoods(arg_26_1.goodsId)

	if not var_26_0 then
		gohelper.setActive(arg_26_0._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_26_1, var_26_1) then
		gohelper.setActive(arg_26_0._goSkinTips, true)

		local var_26_2 = SkinConfig.instance:getSkinCo(var_26_1)
		local var_26_3 = string.splitToNumber(var_26_2.compensate, "#")
		local var_26_4 = var_26_3[2]
		local var_26_5 = var_26_3[3]
		local var_26_6 = CurrencyConfig.instance:getCurrencyCo(var_26_4)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_26_0._imgProp, string.format("%s_1", var_26_6.icon))

		arg_26_0._txtPropNum.text = tostring(var_26_5)
	else
		gohelper.setActive(arg_26_0._goSkinTips, false)
	end
end

function var_0_0.onClose(arg_27_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_27_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_27_0._payFinished, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simageicon:UnLoadImage()
	arg_28_0._simageleftbg:UnLoadImage()
	arg_28_0._simagerightbg:UnLoadImage()
	GameUtil.onDestroyViewMemberList(arg_28_0, "_productList")

	if arg_28_0._monthCardItemIcon then
		arg_28_0._monthCardItemIcon:onDestroy()
	end

	if arg_28_0._monthCardDailyItemIcon then
		arg_28_0._monthCardDailyItemIcon:onDestroy()
	end
end

return var_0_0
