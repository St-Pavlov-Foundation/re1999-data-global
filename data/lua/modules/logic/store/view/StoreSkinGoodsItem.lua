-- chunkname: @modules/logic/store/view/StoreSkinGoodsItem.lua

module("modules.logic.store.view.StoreSkinGoodsItem", package.seeall)

local StoreSkinGoodsItem = class("StoreSkinGoodsItem", ListScrollCellExtend)
local spineDefaultPos = {
	30,
	15,
	0
}
local spineDefaultBg = "singlebg/characterskin/bg_beijing.png"
local spineDefaultSize = {
	260,
	600
}
local defaultSignaturePng = "singlebg/signature/color/img_dressing1.png"

function StoreSkinGoodsItem:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/image_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_NormalSkin/#simage_icon")
	self._goNormalSkin = gohelper.findChild(self.viewGO, "#go_NormalSkin")
	self._advanceImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_bg")
	self._advanceImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#simage_icon")
	self._advanceImage1 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_D")
	self._advanceImage2 = gohelper.findChildSingleImage(self.viewGO, "#go_AdvancedSkin/#image_A")
	self._goAdvanceSkin = gohelper.findChild(self.viewGO, "#go_AdvancedSkin")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._goUniqueSkin = gohelper.findChild(self.viewGO, "#go_UniqueSkin")
	self._uniqueSingleImageicon = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_icon")
	self._uniqueImagebg = gohelper.findChildSingleImage(self.viewGO, "#go_UniqueSkin/#simage_iconbg")
	self._goUniqueSkinBubble = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#simage_bubble")
	self._xtIconbg = gohelper.findChild(self.viewGO, "#go_UniqueSkin/#xingti_iconbg")
	self._goLinkageLetterG = gohelper.findChild(self.viewGO, "#go_Linkage/#simage_g")
	self._goLinkageLetterA = gohelper.findChild(self.viewGO, "#go_Linkage/#image_A")
	self._goLinkageBgG = gohelper.findChildSingleImage(self.viewGO, "#go_Linkage/#simage_bg")
	self._goLinkageBgA = gohelper.findChildSingleImage(self.viewGO, "#go_Linkage/#simage_bgA")
	self._gocostline = gohelper.findChild(self.viewGO, "cost/line")
	self._goprice = gohelper.findChild(self.viewGO, "cost/#go_price")
	self._goowned = gohelper.findChild(self.viewGO, "cost/#go_owned")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "cost/#txt_original_price")
	self._goCharge = gohelper.findChild(self.viewGO, "cost/#go_charge")
	self._txtCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_chargeNum")
	self._txtOriginalCharge = gohelper.findChildText(self.viewGO, "cost/#go_charge/txt_originalChargeNum")
	self._goremaintime = gohelper.findChild(self.viewGO, "#go_tag/#go_remaintime")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#go_tag/#go_remaintime/bg/icon/#txt_remaintime")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._gonewtag = gohelper.findChild(self.viewGO, "#go_newtag")
	self._godiscount = gohelper.findChild(self.viewGO, "#go_tag/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#go_tag/#go_discount/#txt_discount")
	self._godeduction = gohelper.findChild(self.viewGO, "#go_tag/#go_deduction")
	self._txtdeduction = gohelper.findChildTextMesh(self.viewGO, "#go_tag/#go_deduction/txt_materialNum")
	self._goSkinTips = gohelper.findChild(self.viewGO, "#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")
	self.goSelect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsItem:addEvents()
	self:addEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, self.refreshChargeInfo, self)
	self:addEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
end

function StoreSkinGoodsItem:removeEvents()
	self:removeEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, self.refreshChargeInfo, self)
	self:removeEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, self._onSkinPreviewChanged, self)
end

function StoreSkinGoodsItem:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))

	self._txtmaterialNum = gohelper.findChildText(self._goprice, "txt_materialNum")
	self._simagematerial = gohelper.findChildImage(self._goprice, "simage_material")
	self._goLinkage = gohelper.findChild(self.viewGO, "#go_Linkage")
	self._goLinkageLogo = gohelper.findChild(self.viewGO, "#go_Linkage/image_Logo")
	self._linkage_simageicon = gohelper.findChildSingleImage(self._goLinkage, "#simage_icon")
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.play_ui_rolesopen)

	self._btn:AddClickListener(self._onClick, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewGOTrs = self.viewGO.transform
	self.parentViewGO = self.viewGO.transform.parent.gameObject
end

function StoreSkinGoodsItem:_onSkinPreviewChanged()
	self:updateSelect()
	self:updateNew()
end

function StoreSkinGoodsItem:updateNew()
	local alreadyHas = self._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(self._mo)

	if alreadyHas then
		gohelper.setActive(self._gonewtag, false)

		return
	end

	local needNew = self._mo:checkShowNewRedDot()

	gohelper.setActive(self._gonewtag, needNew)
end

function StoreSkinGoodsItem:updateSelect()
	local selectGoods = StoreClothesGoodsItemListModel.instance:getSelectGoods()
	local isSelect = selectGoods == self._mo

	gohelper.setActive(self.goSelect, isSelect)

	if self._mo:checkShowNewRedDot() then
		self._mo:setNewRedDotKey()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function StoreSkinGoodsItem:_onClick()
	StoreClothesGoodsItemListModel.instance:setSelectIndex(self._index)
end

function StoreSkinGoodsItem:_openStoreSkinView()
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = self._mo
	})
end

function StoreSkinGoodsItem:_onDraggingBegin()
	return
end

function StoreSkinGoodsItem:_onDragging()
	return
end

function StoreSkinGoodsItem:_onDraggingEnd()
	return
end

function StoreSkinGoodsItem:checkItemInGoodsList(rectTrans, itemRectTrans)
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(itemRectTrans)

	return recthelper.screenPosInRect(rectTrans, CameraMgr.instance:getUICamera(), screenPosX, screenPosY)
end

function StoreSkinGoodsItem:onUpdateMO(mo)
	self._mo = mo

	local isShowLinkageSkin = self:_isLinkageSkin()
	local isShowNormalSkin = not isShowLinkageSkin and self:_isNormalSkin()
	local isShowAdvancedSkin = not isShowLinkageSkin and self:_isAdvanceSkin()
	local isShowUniqueSkin = not isShowLinkageSkin and self:_isUniqueSkin()
	local product = self._mo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self._skinId = skinId
	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	local heroConfig = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self:clearSpine()
	gohelper.setActive(self._goNormalSkin, isShowNormalSkin)
	gohelper.setActive(self._goAdvanceSkin, isShowAdvancedSkin)
	gohelper.setActive(self._goUniqueSkin, isShowUniqueSkin)
	gohelper.setActive(self._goLinkage, isShowLinkageSkin)
	gohelper.setActive(self._goLinkageLogo, self:_isShowLinkageLogo())

	if isShowUniqueSkin then
		self:_onUpdateMO_uniqueSkin()
	else
		local imageIcon

		if isShowLinkageSkin then
			imageIcon = self._linkage_simageicon

			gohelper.setActive(self._goLinkageBgA, self:_isAdvanceSkin())
			gohelper.setActive(self._goLinkageBgG, self:_isNormalSkin())
			gohelper.setActive(self._goLinkageLetterA, self:_isAdvanceSkin())
			gohelper.setActive(self._goLinkageLetterG, self:_isNormalSkin())
		elseif isShowAdvancedSkin then
			imageIcon = self._advanceImageicon
		else
			imageIcon = self._simageicon
		end

		if string.nilorempty(self._mo.config.bigImg) == false then
			imageIcon:LoadImage(self._mo.config.bigImg)
		else
			imageIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	local alreadyHas = mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(mo)

	if alreadyHas then
		gohelper.setActive(self._goowned, true)
		gohelper.setActive(self._goprice, false)
		gohelper.setActive(self._godeduction, false)
		gohelper.setActive(self._gocostline, false)
	else
		gohelper.setActive(self._goowned, false)
		gohelper.setActive(self._goprice, true)
		gohelper.setActive(self._gocostline, true)

		local deductionItemCount = 0

		if not string.nilorempty(self._mo.config.deductionItem) then
			local info = GameUtil.splitString2(self._mo.config.deductionItem, true)

			deductionItemCount = ItemModel.instance:getItemCount(info[1][2])
			self._txtdeduction.text = -info[2][1]
		end

		gohelper.setActive(self._godeduction, deductionItemCount > 0)
	end

	local costInfo = string.splitToNumber(self._mo.config.cost, "#")

	self._costType = costInfo[1]
	self._costId = costInfo[2]
	self._costQuantity = costInfo[3]

	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
	local id = costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagematerial, str, true)

	self._txtmaterialNum.text = self._costQuantity

	gohelper.setActive(self._godiscount, mo.config.originalCost > 0)
	gohelper.setActive(self._txtoriginalprice.gameObject, mo.config.originalCost > 0)

	local offTag = self._costQuantity / mo.config.originalCost

	offTag = math.ceil(offTag * 100)
	self._txtdiscount.text = string.format("-%d%%", 100 - offTag)
	self._txtoriginalprice.text = mo.config.originalCost

	local offlineTime = mo:getOfflineTime()
	local offEndTime = offlineTime - ServerTime.now()

	gohelper.setActive(self._goremaintime, offlineTime > 0 and alreadyHas == false)

	if offEndTime > 3600 then
		self._txtremaintime.text = TimeUtil.getFormatTime1(offEndTime)
	else
		self._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	self:refreshChargeInfo()
	self:refreshSkinTips()
	self:updateNew()
	self:updateSelect()

	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(StoreEvent.SkinGoodsItemChanged)
	end
end

function StoreSkinGoodsItem:refreshChargeInfo()
	local price, originalPrice

	if self.skinCo then
		local skinId = self.skinCo.id
		local isChargePackageValid = StoreModel.instance:isStoreSkinChargePackageValid(skinId)

		if isChargePackageValid then
			price, originalPrice = StoreConfig.instance:getSkinChargePrice(skinId)
		end
	end

	if price then
		local priceStr = string.format("%s%s", StoreModel.instance:getCostStr(price))

		self._txtCharge.text = priceStr

		if originalPrice then
			self._txtOriginalCharge.text = originalPrice
		end

		gohelper.setActive(self._txtOriginalCharge.gameObject, originalPrice)
	end

	local alreadyHas = false

	if self._mo then
		alreadyHas = self._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(self._mo)
	end

	gohelper.setActive(self._goCharge, price and not alreadyHas)
	ZProj.UGUIHelper.RebuildLayout(self._goCharge.transform)
end

function StoreSkinGoodsItem:getAnimator()
	return self._animator
end

function StoreSkinGoodsItem:refreshSkinTips()
	gohelper.setActive(self._goSkinTips, false)
end

function StoreSkinGoodsItem:clearSpine()
	GameUtil.doClearMember(self, "_skinSpine")
	GameUtil.doClearMember(self, "_skinSpine2")
end

function StoreSkinGoodsItem:onDestroyView()
	self._btn:RemoveClickListener()
	self._simagebg:UnLoadImage()
	self._uniqueSingleImageicon:UnLoadImage()
	self._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(self, "_skinSpine")
	GameUtil.doClearMember(self, "_skinSpine2")

	if self:_isUniqueSkin() then
		self:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, self._onDraggingBegin, self)
		self:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, self._onDraggingEnd, self)
		self:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, self._onDragging, self)
	end
end

function StoreSkinGoodsItem:_onUpdateMO_uniqueSkin()
	self:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, self._onDraggingBegin, self)
	self:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, self._onDraggingEnd, self)
	self:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, self._onDragging, self)

	local resPath = self._mo.config.bigImg
	local spineParams = self._mo.config.spineParams

	gohelper.setActive(self._xtIconbg, false)
	gohelper.setActive(self._goUniqueSkinBubble, false)
	self._uniqueImagebg:LoadImage(ResUrl.getCharacterSkinIcon(self._skinId))
	self._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconUnique(self._skinId))
end

function StoreSkinGoodsItem:_isNormalSkin()
	return self._mo.config.skinLevel == 0
end

function StoreSkinGoodsItem:_isAdvanceSkin()
	return self._mo.config.isAdvancedSkin or self._mo.config.skinLevel == 1
end

function StoreSkinGoodsItem:_isUniqueSkin()
	return self._mo.config.skinLevel == 2
end

function StoreSkinGoodsItem:_isLinkageSkin()
	return self._mo.config.islinkageSkin or false
end

function StoreSkinGoodsItem:_isShowLinkageLogo()
	return self._mo.config.showLinkageLogo or false
end

return StoreSkinGoodsItem
