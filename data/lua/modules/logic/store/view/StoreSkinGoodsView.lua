module("modules.logic.store.view.StoreSkinGoodsView", package.seeall)

slot0 = class("StoreSkinGoodsView", BaseView)
slot1 = {
	45,
	-46,
	0
}
slot2 = 0.85

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_leftbg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_icon")
	slot0._gooffTag = gohelper.findChild(slot0.viewGO, "view/bgroot/#simage_icon/#go_offTag")
	slot0._txtoff = gohelper.findChildText(slot0.viewGO, "view/bgroot/#simage_icon/#go_offTag/#txt_off")
	slot0._simagedreesing = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_dreesing")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_buy")
	slot0._txtmaterialNum = gohelper.findChildText(slot0.viewGO, "view/propinfo/cost/price/#txt_materialNum")
	slot0._simagematerial = gohelper.findChildImage(slot0.viewGO, "view/propinfo/cost/price/#txt_materialNum/#simage_material")
	slot0._txtprice = gohelper.findChildText(slot0.viewGO, "view/propinfo/cost/price/#txt_price")
	slot0._godeduction = gohelper.findChild(slot0.viewGO, "view/propinfo/cost/#go_deduction")
	slot0._txtdeduction = gohelper.findChildTextMesh(slot0.viewGO, "view/propinfo/cost/#go_deduction/#txt_deduction")
	slot0._txtskinname = gohelper.findChildText(slot0.viewGO, "view/propinfo/#txt_skinname")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "view/propinfo/content/desc/#txt_desc")
	slot0._txtusedesc = gohelper.findChildText(slot0.viewGO, "view/propinfo/content/desc/usedesc")
	slot0._goleftbg = gohelper.findChild(slot0.viewGO, "view/propinfo/content/remain/#go_leftbg")
	slot0._txtremainday = gohelper.findChildText(slot0.viewGO, "view/propinfo/content/remain/#go_leftbg/#txt_remainday")
	slot0._gorightbg = gohelper.findChild(slot0.viewGO, "view/propinfo/content/remain/#go_rightbg")
	slot0._txtremain = gohelper.findChildText(slot0.viewGO, "view/propinfo/content/remain/#go_rightbg/#txt_remain")
	slot0._scrollproduct = gohelper.findChildScrollRect(slot0.viewGO, "view/propinfo/#scroll_product")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "view/propinfo/#scroll_product/product/go_goods/#go_icon")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_close")
	slot0._godeco = gohelper.findChild(slot0.viewGO, "view/bgroot/deco")
	slot0._simageGeneralSkinIcon = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_icon")
	slot0._simageUniqueSkinIcon = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_s+icon")
	slot0._imageUniqueSkinIcon = gohelper.findChildImage(slot0.viewGO, "view/bgroot/#simage_s+icon")
	slot0._goUniqueSkinsImage = gohelper.findChild(slot0.viewGO, "view/bgroot/#simage_s+icon")
	slot0._goUniqueSkinsSpineRoot = gohelper.findChild(slot0.viewGO, "view/bgroot/#simage_s+spineroot")
	slot0._goUniqueSkinsTitle = gohelper.findChild(slot0.viewGO, "view/bgroot/#simage_s+decoration")
	slot0._simageUniqueSkinSpineRoot = gohelper.findChildSingleImage(slot0.viewGO, "view/bgroot/#simage_s+spineroot")
	slot0._imageUniqueSkinSpineRoot = gohelper.findChildImage(slot0.viewGO, "view/bgroot/#simage_s+spineroot")
	slot0._goUniqueSkinsSpineRoot2 = gohelper.findChild(slot0.viewGO, "view/bgroot/#simage_s+spineroot2")

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

	if slot0.btnIcon then
		slot0.btnIcon:RemoveClickListener()
	end
end

function slot0._btnbuyOnClick(slot0)
	slot1 = ItemModel.instance:getItemQuantity(slot0._costType, slot0._costId)

	if slot0.deductionInfo then
		slot2 = math.max(0, slot0._costQuantity - slot0.deductionInfo.deductionCount)
	end

	if slot0.isActivityStore then
		if slot1 < slot2 then
			GameFacade.showToast(ToastEnum.DiamondBuy, slot0.costName)
		else
			slot0:_buyGoods()
		end
	elseif CurrencyController.instance:checkDiamondEnough(slot2, slot0.jumpCallBack, slot0) then
		slot0:_buyGoods()
	end
end

function slot0._buyGoods(slot0)
	if slot0.isActivityStore then
		Activity107Rpc.instance:sendBuy107GoodsRequest(slot0._mo.activityId, slot0._mo.id, 1)
	else
		StoreController.instance:buyGoods(slot0._mo, 1, slot0._buyCallback, slot0)
	end
end

function slot0.jumpCallBack(slot0)
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("img_dressing"))

	slot0._goremain = gohelper.findChild(slot0.viewGO, "view/propinfo/content/remain")
	slot0._gonormaltitle = gohelper.findChild(slot0.viewGO, "view/bgroot/#go_normal_title")
	slot0._goadvancedtitle = gohelper.findChild(slot0.viewGO, "view/bgroot/#go_advanced_title")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.isActivityStore = slot0.viewParam.isActivityStore

	if slot0.isActivityStore then
		slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0._btncloseOnClick, slot0)
		slot0:_updateActivityStore()
	else
		slot0:_updateSkinStore()
	end

	slot0._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), lua_character.configDict[slot0.skinCo.characterId].name)
end

function slot0._updateActivityStore(slot0)
	slot0._mo = slot0.viewParam.goodsMO
	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot0._mo.product, "#")[2])
	slot0._txtskinname.text = slot0.skinCo.characterSkin
	slot0._txtdesc.text = slot0.skinCo.skinDescription

	recthelper.setAnchorY(slot0._txtdesc.transform, -100)

	slot4 = string.splitToNumber(slot0._mo.cost, "#")
	slot0._costType = slot4[1]
	slot0._costId = slot4[2]
	slot0._costQuantity = slot4[3]
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)
	slot0.costName = slot5.name

	if slot0._costQuantity <= ItemModel.instance:getItemQuantity(slot0._costType, slot0._costId) then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmaterialNum, "#bf2e11")
	end

	slot0._txtmaterialNum.text = slot0._costQuantity

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simagematerial, string.format("%s_1", slot5.icon))
	slot0.viewContainer:setCurrencyType({
		slot0._costId
	})
	slot0._simageicon:LoadImage(ResUrl.getStoreSkin(slot3))

	if not slot0.btnIcon then
		slot0.btnIcon = gohelper.getClick(slot0._simageicon.gameObject)

		slot0.btnIcon:AddClickListener(slot0.onClickIcon, slot0)
	end

	gohelper.setActive(slot0._txtprice.gameObject, false)
	slot0:_enableRemain(false)
	gohelper.setActive(slot0._gooffTag, false)
	gohelper.setActive(slot0._gonormaltitle, true)
	gohelper.setActive(slot0._goadvancedtitle, false)
end

function slot0._updateSkinStore(slot0)
	slot0._mo = slot0.viewParam.goodsMO
	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot0._mo.config.product, "#")[2])
	slot5 = string.splitToNumber(slot0._mo.config.cost, "#")
	slot0._costType = slot5[1]
	slot0._costId = slot5[2]
	slot0._costQuantity = slot5[3]

	if not string.nilorempty(slot0._mo.config.deductionItem) then
		if ItemModel.instance:getItemCount(GameUtil.splitString2(slot0._mo.config.deductionItem, true)[1][2]) > 0 then
			slot0.deductionInfo = {
				deductionCount = slot6[2][1],
				currencyType = {
					isCurrencySprite = true,
					type = slot6[1][1],
					id = slot6[1][2]
				}
			}
		end
	else
		slot0.deductionInfo = nil
	end

	slot0:_refreshSkinDesc(slot4, slot0.skinCo)
	slot0:_refreshSkinCost(slot4)
	slot0:_refreshSkinIcon(slot4)
end

function slot0._refreshSkinDesc(slot0, slot1, slot2)
	slot0._txtskinname.text = slot2.characterSkin
	slot0._txtdesc.text = slot2.skinDescription

	if slot0._mo:getOfflineTime() > 0 then
		slot0:_enableRemain(true)

		slot0._txtremainday.text = string.format("%s%s", TimeUtil.secondToRoughTime(math.floor(slot3 - ServerTime.now())))
	else
		gohelper.setActive(slot0._goremain, false)
		slot0:_enableRemain(false)
	end

	gohelper.setActive(slot0._gooffTag, slot1.originalCost > 0)

	slot0._txtoff.text = string.format("-%d%%", 100 - math.ceil(slot0._costQuantity / slot1.originalCost * 100))
end

function slot0._refreshSkinCost(slot0, slot1)
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

	if slot0.deductionInfo then
		slot4 = math.max(0, slot0._costQuantity - slot0.deductionInfo.deductionCount)

		gohelper.setActive(slot0._godeduction, true)

		slot0._txtdeduction.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("bp_deduction_item_count"), tostring(slot0.deductionInfo.deductionCount), ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId).name)
	else
		gohelper.setActive(slot0._godeduction, false)
	end

	if slot4 <= ItemModel.instance:getItemQuantity(slot0._costType, slot0._costId) then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmaterialNum, "#bf2e11")
	end

	slot0._txtmaterialNum.text = slot4

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simagematerial, string.format("%s_1", slot2.icon))

	slot8 = {}

	if slot0._costId ~= CurrencyEnum.CurrencyType.Diamond then
		table.insert(slot8, CurrencyEnum.CurrencyType.Diamond)
	end

	table.insert(slot8, slot0._costId)

	if slot0.deductionInfo then
		table.insert(slot8, slot0.deductionInfo.currencyType)
	end

	slot0.viewContainer:setCurrencyType(slot8)
	gohelper.setActive(slot0._txtprice.gameObject, slot1.originalCost > 0 or slot0.deductionInfo)

	slot0._txtprice.text = slot1.originalCost > 0 and slot1.originalCost or slot0._costQuantity
end

function slot0._refreshSkinIcon(slot0, slot1)
	slot2 = slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1
	slot3 = slot0._mo.config.skinLevel == 2

	gohelper.setActive(slot0._godeco, not slot3)
	gohelper.setActive(slot0._gonormaltitle, not slot2 and not slot3)
	gohelper.setActive(slot0._goadvancedtitle, slot2)
	gohelper.setActive(slot0._simageGeneralSkinIcon.gameObject, not slot3)
	gohelper.setActive(slot0._goUniqueSkinsImage, slot3)
	gohelper.setActive(slot0._goUniqueSkinsSpineRoot, slot3)
	gohelper.setActive(slot0._goUniqueSkinsSpineRoot2, slot3)
	gohelper.setActive(slot0._goUniqueSkinsTitle, slot3)

	if slot3 then
		slot0._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))

		slot4 = slot0._mo.config.bigImg

		if not string.nilorempty(slot0._mo.config.spineParams) then
			slot6 = string.split(slot5, "#")
			slot8 = slot6[2]
			slot9 = string.splitToNumber(slot6[3], ",")
			slot10 = slot6[6]

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot6[1], slot0._onSpine1Loaded, slot0, true)
			else
				slot0._skinSpineGO = gohelper.create2d(slot0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

				transformhelper.setLocalPos(slot0._skinSpineGO.transform, slot9[1], slot9[2], 0)

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot7, slot0._onSpine1Loaded, slot0, true)

				if not string.nilorempty(slot8) then
					slot0._skinSpineGO2 = gohelper.create2d(slot0._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

					transformhelper.setLocalPos(slot0._skinSpineGO2.transform, slot9[1], slot9[2], 0)

					slot0._skinSpine2 = GuiSpine.Create(slot0._skinSpineGO2, false)

					slot0._skinSpine2:setResPath(slot8, slot0._onSpine2Loaded, slot0, true)
				end
			end

			if not string.nilorempty(slot10) then
				slot0._simageUniqueSkinIcon:LoadImage(slot10)
				slot0._simageUniqueSkinSpineRoot:LoadImage(slot10)
			else
				gohelper.setActive(slot0._uniqueImagebg.gameObject, false)
			end

			gohelper.setActive(slot0._skinSpineGO, true)
		elseif string.find(slot4, "prefab") then
			slot6 = string.split(slot4, "#")
			slot8 = slot6[3]

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot6[1], slot0._onSpineLoaded, slot0, true)
			else
				slot0._skinSpineGO = gohelper.create2d(slot0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

				transformhelper.setLocalPos(slot0._skinSpineGO.transform, uv0[1], uv0[2], uv0[3])

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot7, slot0._onSpineLoaded, slot0, true)
			end

			slot0._simageUniqueSkinIcon:LoadImage(slot8)
			slot0._imageUniqueSkinIcon:SetNativeSize()
			slot0._imageUniqueSkinSpineRoot:SetNativeSize()
			gohelper.setActive(slot0._skinSpineGO, true)
		elseif not string.nilorempty(slot4) then
			slot0._simageUniqueSkinIcon:LoadImage(slot0._mo.config.bigImg)
		else
			slot0._simageUniqueSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	elseif string.nilorempty(slot1.bigImg) == false then
		slot0._simageGeneralSkinIcon:LoadImage(slot1.bigImg)
	else
		slot0._simageGeneralSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
	end
end

function slot0._onSpine1Loaded(slot0)
	transformhelper.setLocalScale(slot0._skinSpine:getSpineTr(), uv0, uv0, 1)
end

function slot0._onSpine2Loaded(slot0)
	transformhelper.setLocalScale(slot0._skinSpine2:getSpineTr(), uv0, uv0, 1)
end

function slot0._onSpineLoaded(slot0)
	slot5 = slot0._skinSpine:getSpineTr()
	slot6 = slot0._simageUniqueSkinIcon.transform

	recthelper.setAnchor(slot5, recthelper.getAnchor(slot6))
	recthelper.setWidth(slot5, recthelper.getWidth(slot6))
	recthelper.setHeight(slot5, recthelper.getHeight(slot6))
	recthelper.setAnchor(slot5, 0, 0)
	transformhelper.setLocalScale(slot5, 0.88, 0.84, 1)
	slot0:setSpineRaycastTarget(slot0._raycastTarget)
end

function slot0.setSpineRaycastTarget(slot0, slot1)
	slot0._raycastTarget = slot1 == true and true or false

	if slot0._skinSpine and slot0._skinSpine:getSkeletonGraphic() then
		slot2.raycastTarget = slot0._raycastTarget
	end
end

function slot0._buyCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function slot0._enableRemain(slot0, slot1)
	gohelper.setActive(slot0._goremain, slot1)
	recthelper.setAnchorY(slot0._txtdesc.transform, slot1 and -140 or -88)
end

function slot0.onClickIcon(slot0)
	if not slot0.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, slot0.skinCo.id, false, nil, false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simagedreesing:UnLoadImage()

	if slot0._skinSpine then
		slot0._skinSpine:doClear()

		slot0._skinSpine = nil
	end

	if slot0._skinSpine2 then
		slot0._skinSpine2:doClear()

		slot0._skinSpine2 = nil
	end
end

return slot0
