module("modules.logic.store.view.StoreSkinGoodsItem", package.seeall)

slot0 = class("StoreSkinGoodsItem", ListScrollCellExtend)
slot1 = {
	30,
	15,
	0
}
slot2 = "singlebg/characterskin/bg_beijing.png"
slot3 = {
	376,
	780
}
slot4 = {
	500,
	780
}
slot5 = "singlebg/signature/color/img_dressing1.png"

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_NormalSkin/#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_NormalSkin/#simage_icon")
	slot0._simageg = gohelper.findChildSingleImage(slot0.viewGO, "#go_NormalSkin/#simage_g")
	slot0._goNormalSkin = gohelper.findChild(slot0.viewGO, "#go_NormalSkin")
	slot0._advanceImagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_AdvancedSkin/#simage_bg")
	slot0._advanceImageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_AdvancedSkin/#simage_icon")
	slot0._advanceImage1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_AdvancedSkin/#image_D")
	slot0._advanceImage2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_AdvancedSkin/#image_A")
	slot0._goAdvanceSkin = gohelper.findChild(slot0.viewGO, "#go_AdvancedSkin")
	slot0._goUniqueSkinsImage = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin/#simage_icon")
	slot0._goUniqueSkin = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin")
	slot0._uniqueImageicon = gohelper.findChildImage(slot0.viewGO, "#go_UniqueSkin/#simage_icon")
	slot0._goUniqueImageicon2 = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin/#simage_icon2")
	slot0._uniqueSingleImageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_UniqueSkin/#simage_icon")
	slot0._uniqueImagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_UniqueSkin/#simage_iconbg")
	slot0._goUniqueSkinBubble = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin/#simage_bubble")
	slot0._govx_iconbg = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin/vx_iconbg")
	slot0._govx_bg = gohelper.findChild(slot0.viewGO, "#go_UniqueSkin/vx_bg")
	slot0._mask = slot0._goUniqueImageicon2:GetComponent(typeof(UnityEngine.UI.Mask))
	slot0._goLinkageLetterG = gohelper.findChild(slot0.viewGO, "#go_Linkage/#simage_g")
	slot0._goLinkageLetterA = gohelper.findChild(slot0.viewGO, "#go_Linkage/#image_A")
	slot0._goLinkageBgG = gohelper.findChildSingleImage(slot0.viewGO, "#go_Linkage/#simage_bg")
	slot0._goLinkageBgA = gohelper.findChildSingleImage(slot0.viewGO, "#go_Linkage/#simage_bgA")
	slot0._simagesign = gohelper.findChildSingleImage(slot0.viewGO, "#simage_sign")
	slot0._godeduction = gohelper.findChild(slot0.viewGO, "cost/#go_deduction")
	slot0._txtdeduction = gohelper.findChildTextMesh(slot0.viewGO, "cost/#go_deduction/txt_materialNum")
	slot0._goprice = gohelper.findChild(slot0.viewGO, "cost/#go_price")
	slot0._goowned = gohelper.findChild(slot0.viewGO, "cost/#go_owned")
	slot0._txtoriginalprice = gohelper.findChildText(slot0.viewGO, "cost/#txt_original_price")
	slot0._goCharge = gohelper.findChild(slot0.viewGO, "cost/#go_charge")
	slot0._txtCharge = gohelper.findChildText(slot0.viewGO, "cost/#go_charge/txt_chargeNum")
	slot0._txtOriginalCharge = gohelper.findChildText(slot0.viewGO, "cost/#go_charge/txt_originalChargeNum")
	slot0._txtskinname = gohelper.findChildText(slot0.viewGO, "#txt_skinname")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_skinname/#txt_name")
	slot0._goremaintime = gohelper.findChild(slot0.viewGO, "#go_remaintime")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#go_remaintime/bg/icon/#txt_remaintime")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "#go_tag")
	slot0._gonewtag = gohelper.findChild(slot0.viewGO, "#go_newtag")
	slot0._txtdiscount = gohelper.findChildText(slot0.viewGO, "#go_tag/bg/#txt_discount")
	slot0._goSkinTips = gohelper.findChild(slot0.viewGO, "#go_SkinTips")
	slot0._imgProp = gohelper.findChildImage(slot0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	slot0._txtPropNum = gohelper.findChildTextMesh(slot0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, slot0.refreshChargeInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, slot0.refreshChargeInfo, slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))
	slot0._simageg:LoadImage(ResUrl.getCharacterSkinIcon("img_g"))

	slot0._txtmaterialNum = gohelper.findChildText(slot0._goprice, "txt_materialNum")
	slot0._simagematerial = gohelper.findChildImage(slot0._goprice, "simage_material")
	slot0._goLinkage = gohelper.findChild(slot0.viewGO, "#go_Linkage")
	slot0._linkage_simageicon = gohelper.findChildSingleImage(slot0._goLinkage, "#simage_icon")
	slot0._btnGO = gohelper.findChild(slot0.viewGO, "clickArea")
	slot0._btn = gohelper.getClickWithAudio(slot0._btnGO, AudioEnum.UI.play_ui_rolesopen)

	slot0._btn:AddClickListener(slot0._onClick, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._mask.enabled = false
end

function slot0._onClick(slot0)
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = slot0._mo
	})
end

function slot0._onDraggingBegin(slot0)
	if slot0:_isUniqueSkin() and slot0._skinSpineGO2 then
		slot0._mask.enabled = true
	end
end

function slot0._onDragging(slot0)
	if slot0:_isUniqueSkin() and slot0._skinSpineGO2 then
		slot1 = slot0.viewGO.transform
		slot3 = recthelper.getWidth(slot1) * 0.5

		recthelper.setAnchorX(slot1, -slot3)
		recthelper.setAnchorX(slot1, slot3)
		recthelper.setAnchorX(slot1, 0)

		slot0._mask.enabled = not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot1) or not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot1)
	end
end

function slot0._onDraggingEnd(slot0)
	if slot0:_isUniqueSkin() and slot0._skinSpineGO2 then
		slot1 = slot0.viewGO.transform
		slot3 = recthelper.getWidth(slot1) * 0.5

		recthelper.setAnchorX(slot1, -slot3)
		recthelper.setAnchorX(slot1, slot3)
		recthelper.setAnchorX(slot1, 0)

		slot0._mask.enabled = not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot1) or not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot1)
	end
end

function slot0.checkItemInGoodsList(slot0, slot1, slot2)
	slot3, slot4 = recthelper.uiPosToScreenPos2(slot2)

	return recthelper.screenPosInRect(slot1, CameraMgr.instance:getUICamera(), slot3, slot4)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = not slot0:_isLinkageSkin() and slot0:_isNormalSkin()
	slot4 = not slot2 and slot0:_isAdvanceSkin()
	slot5 = not slot2 and slot0:_isUniqueSkin()
	slot6 = uv0
	slot7 = slot0._mo.config.product
	slot8 = slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1

	gohelper.setActive(slot0._goNormalSkin, slot0._mo.config.skinLevel == 0)
	gohelper.setActive(slot0._goAdvanceSkin, slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1)
	gohelper.setActive(slot0._goUniqueSkin, slot0._mo.config.skinLevel == 2)

	if slot0._mo.config.skinLevel == 2 then
		slot0:clearSpine()
		slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, slot0._onDraggingBegin, slot0)
		slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, slot0._onDraggingEnd, slot0)
		slot0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, slot0._onDragging, slot0)
		gohelper.setAsLastSibling(slot0.viewGO.transform.parent.gameObject)

		slot11 = slot0._mo.config.bigImg

		if not string.nilorempty(slot0._mo.config.spineParams) then
			slot13 = string.split(slot12, "#")
			slot15 = slot13[1]
			slot16 = #slot13 > 1 and slot13[2]
			slot17 = slot14 > 2 and string.splitToNumber(slot13[3], ",")
			slot18 = slot14 > 3 and tonumber(slot13[4])
			slot19 = slot14 > 4 and slot13[5]

			if slot14 > 6 then
				slot10 = slot13[7] or uv0
			end

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot15, slot0._onSkinSpineLoaded, slot0, true)
			else
				slot0._skinSpineGO = slot0._skinSpineGO or gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")
				slot20 = slot0._skinSpineGO.transform

				recthelper.setWidth(slot20, uv1[1])
				transformhelper.setLocalPos(slot20, slot17[1], slot17[2], 0)
				transformhelper.setLocalScale(slot20, slot18, slot18, slot18)

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot15, slot0._onSkinSpineLoaded, slot0, true)

				if not string.nilorempty(slot16) then
					slot0._skinSpineGO2 = slot0._skinSpineGO2 or gohelper.create2d(slot0._goUniqueImageicon2, "uniqueSkinSpine2")
					slot21 = slot0._skinSpineGO2.transform

					recthelper.setWidth(slot21, uv1[1])
					transformhelper.setLocalPos(slot21, slot17[1], slot17[2], 0)
					transformhelper.setLocalScale(slot21, slot18, slot18, slot18)

					slot0._skinSpine2 = GuiSpine.Create(slot0._skinSpineGO2, false)

					slot0._skinSpine2:setResPath(slot16, slot0._onSkinSpine2Loaded, slot0, true)
				end

				transformhelper.setLocalPos(slot0._uniqueImageicon.transform, 0, 0, 0)

				slot0._uniqueImageicon.transform.sizeDelta = Vector2.New(uv2[1], uv2[2])
			end

			gohelper.setActive(slot0._skinSpineGO, true)
			gohelper.setActive(slot0._goUniqueSkinBubble, false)
			gohelper.setActive(slot0._govx_iconbg, false)
			gohelper.setActive(slot0._govx_bg, false)

			if not string.nilorempty(slot19) then
				slot0._uniqueImagebg:LoadImage(slot19)

				slot0._uniqueImageicon.enabled = true

				slot0._uniqueSingleImageicon:LoadImage(slot19)
			else
				gohelper.setActive(slot0._uniqueImagebg.gameObject, false)

				slot0._uniqueImageicon.enabled = false
			end
		elseif string.find(slot11, "prefab") then
			slot13 = string.split(slot11, "#")
			slot15 = slot13[1]
			slot16 = slot13[2]

			if #slot13 > 3 then
				slot10 = slot13[4] or slot10
			end

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot15, slot0._onSpineLoaded, slot0, true)
			else
				slot0._skinSpineGO = slot0._skinSpineGO or gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")

				transformhelper.setLocalPos(slot0._skinSpineGO.transform, uv3[1], uv3[2], uv3[3])

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot15, slot0._onSpineLoaded, slot0, true)
			end

			gohelper.setActive(slot0._skinSpineGO, true)

			if not string.nilorempty(slot16) then
				slot0._uniqueImagebg:LoadImage(slot16)
			else
				slot0._uniqueImagebg:LoadImage(uv4)
			end

			slot0._uniqueImageicon.enabled = true
		else
			slot0._uniqueImageicon.enabled = true

			if not string.nilorempty(slot11) then
				slot0._uniqueSingleImageicon:LoadImage(slot0._mo.config.bigImg)
			else
				slot0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
			end
		end
	else
		slot0:clearSpine()

		if string.nilorempty(slot0._mo.config.bigImg) == false then
			(slot8 and slot0._advanceImageicon or slot0._simageicon):LoadImage(slot0._mo.config.bigImg)
		else
			slot11:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	slot0._simagesign:LoadImage(slot10, slot0._loadedSignImage, slot0)

	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot7, "#")[2])
	slot13 = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId)

	slot0:clearSpine()
	gohelper.setActive(slot0._goNormalSkin, slot3)
	gohelper.setActive(slot0._goAdvanceSkin, slot4)
	gohelper.setActive(slot0._goUniqueSkin, slot5)
	gohelper.setActive(slot0._goLinkage, slot2)

	if slot5 then
		slot0:_onUpdateMO_uniqueSkin()
	else
		slot14 = nil

		if slot2 then
			slot14 = slot0._linkage_simageicon

			gohelper.setActive(slot0._goLinkageBgA, slot0:_isAdvanceSkin())
			gohelper.setActive(slot0._goLinkageBgG, slot0:_isNormalSkin())
			gohelper.setActive(slot0._goLinkageLetterA, slot0:_isAdvanceSkin())
			gohelper.setActive(slot0._goLinkageLetterG, slot0:_isNormalSkin())
		else
			slot14 = (not slot4 or slot0._advanceImageicon) and slot0._simageicon
		end

		if string.nilorempty(slot0._mo.config.bigImg) == false then
			slot14:LoadImage(slot0._mo.config.bigImg)
		else
			slot14:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	slot0._simagesign:LoadImage(slot10, slot0._loadedSignImage, slot0)

	slot0._txtskinname.text = slot0.skinCo.characterSkin
	slot0._txtname.text = slot13.name

	if slot1:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(slot1) then
		gohelper.setActive(slot0._goowned, true)
		gohelper.setActive(slot0._goprice, false)
		gohelper.setActive(slot0._godeduction, false)
	else
		gohelper.setActive(slot0._goowned, false)
		gohelper.setActive(slot0._goprice, true)

		slot15 = 0

		if not string.nilorempty(slot0._mo.config.deductionItem) then
			slot16 = GameUtil.splitString2(slot0._mo.config.deductionItem, true)
			slot15 = ItemModel.instance:getItemCount(slot16[1][2])
			slot0._txtdeduction.text = -slot16[2][1]
		end

		gohelper.setActive(slot0._godeduction, slot15 > 0)
	end

	slot15 = string.splitToNumber(slot0._mo.config.cost, "#")
	slot0._costType = slot15[1]
	slot0._costId = slot15[2]
	slot0._costQuantity = slot15[3]
	slot16, slot17 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simagematerial, string.format("%s_1", slot16.icon), true)

	slot0._txtmaterialNum.text = slot0._costQuantity

	gohelper.setActive(slot0._gotag, slot1.config.originalCost > 0)
	gohelper.setActive(slot0._txtoriginalprice.gameObject, slot1.config.originalCost > 0)

	slot0._txtdiscount.text = string.format("-%d%%", 100 - math.ceil(slot0._costQuantity / slot1.config.originalCost * 100))
	slot0._txtoriginalprice.text = slot1.config.originalCost

	gohelper.setActive(slot0._gonewtag, slot1:needShowNew())

	slot21 = slot1:getOfflineTime()

	gohelper.setActive(slot0._goremaintime, slot21 > 0 and slot14 == false)

	if slot21 - ServerTime.now() > 3600 then
		slot23, slot24 = TimeUtil.secondToRoughTime(slot22)
		slot0._txtremaintime.text = formatLuaLang("remain", slot23 .. slot24)
	else
		slot0._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	slot0:refreshChargeInfo()
	slot0:refreshSkinTips()
end

function slot0.refreshChargeInfo(slot0)
	slot1, slot2 = nil

	if slot0.skinCo and StoreModel.instance:isStoreSkinChargePackageValid(slot0.skinCo.id) then
		slot1, slot2 = StoreConfig.instance:getSkinChargePrice(slot3)
	end

	if slot1 then
		slot0._txtCharge.text = string.format("%s%s", StoreModel.instance:getCostStr(slot1))

		if slot2 then
			slot0._txtOriginalCharge.text = slot2
		end

		gohelper.setActive(slot0._txtOriginalCharge.gameObject, slot2)
	end

	slot3 = false

	if slot0._mo then
		slot3 = slot0._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(slot0._mo)
	end

	gohelper.setActive(slot0._goCharge, slot1 and not slot3)
	ZProj.UGUIHelper.RebuildLayout(slot0._goCharge.transform)
end

function slot0._onSkinSpineLoaded(slot0)
	slot1 = slot0._skinSpine:getSpineTr()
	slot2 = slot1.parent

	recthelper.setWidth(slot1, recthelper.getWidth(slot2))
	recthelper.setHeight(slot1, recthelper.getHeight(slot2))
	slot0:setSpineRaycastTarget(slot0._raycastTarget)
end

function slot0._onSkinSpine2Loaded(slot0)
	slot1 = slot0._skinSpine2:getSpineTr()
	slot2 = slot1.parent

	recthelper.setWidth(slot1, recthelper.getWidth(slot2))
	recthelper.setHeight(slot1, recthelper.getHeight(slot2))
end

function slot0._onSpineLoaded(slot0)
	slot3 = 1
	slot4 = slot0._skinSpine:getSpineTr()
	slot5 = slot0._uniqueImageicon.transform

	recthelper.setAnchor(slot4, recthelper.getAnchor(slot5))
	recthelper.setWidth(slot4, recthelper.getWidth(slot5))
	recthelper.setHeight(slot4, recthelper.getHeight(slot5))
	recthelper.setAnchor(slot4, 0, 0)
	transformhelper.setLocalScale(slot4, slot3, slot3, 1)
	slot0:setSpineRaycastTarget(slot0._raycastTarget)
end

function slot0._loadedSignImage(slot0)
	gohelper.onceAddComponent(slot0._simagesign.gameObject, gohelper.Type_Image):SetNativeSize()
end

function slot0.setSpineRaycastTarget(slot0, slot1)
	slot0._raycastTarget = slot1 == true and true or false

	if slot0._skinSpine and slot0._skinSpine:getSkeletonGraphic() then
		slot2.raycastTarget = slot0._raycastTarget
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.refreshSkinTips(slot0)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(slot0._mo) then
		gohelper.setActive(slot0._goSkinTips, true)

		slot1 = string.splitToNumber(slot0.skinCo.compensate, "#")

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgProp, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot1[2]).icon))

		slot0._txtPropNum.text = tostring(slot1[3])
	else
		gohelper.setActive(slot0._goSkinTips, false)
	end
end

function slot0.clearSpine(slot0)
	if slot0._skinSpine then
		slot0._skinSpine:doClear()

		slot0._skinSpine = nil
	end

	if slot0._skinSpine2 then
		slot0._skinSpine2:doClear()

		slot0._skinSpine2 = nil
	end

	GameUtil.doClearMember(slot0, "_skinSpine")
	GameUtil.doClearMember(slot0, "_skinSpine2")
end

function slot0.onDestroyView(slot0)
	slot0._btn:RemoveClickListener()
	slot0._simagebg:UnLoadImage()
	slot0._simageg:UnLoadImage()
	slot0._simagesign:UnLoadImage()
	slot0._simagesign:UnLoadImage()
	slot0._uniqueSingleImageicon:UnLoadImage()
	slot0._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(slot0, "_skinSpine")
	GameUtil.doClearMember(slot0, "_skinSpine2")

	if slot0:_isUniqueSkin() then
		slot0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, slot0._onDraggingBegin, slot0)
		slot0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, slot0._onDraggingEnd, slot0)
		slot0:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, slot0._onDragging, slot0)
	end
end

function slot0._onUpdateMO_uniqueSkin(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, slot0._onDraggingBegin, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, slot0._onDraggingEnd, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, slot0._onDragging, slot0)
	gohelper.setAsLastSibling(slot0.viewGO.transform.parent.gameObject)

	slot1 = slot0._mo.config.bigImg

	if not string.nilorempty(slot0._mo.config.spineParams) then
		slot3 = string.split(slot2, "#")
		slot6 = #slot3 > 1 and slot3[2]
		slot7 = slot4 > 2 and string.splitToNumber(slot3[3], ",")
		slot8 = slot4 > 3 and tonumber(slot3[4])
		slot9 = slot4 > 4 and slot3[5]
		signTexturePath = slot4 > 6 and slot3[7] or signTexturePath

		if slot0._skinSpine then
			slot0._skinSpine:setResPath(slot3[1], slot0._onSkinSpineLoaded, slot0, true)
		else
			slot0._skinSpineGO = slot0._skinSpineGO or gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")
			slot10 = slot0._skinSpineGO.transform

			recthelper.setWidth(slot10, uv0[1])
			transformhelper.setLocalPos(slot10, slot7[1], slot7[2], 0)
			transformhelper.setLocalScale(slot10, slot8, slot8, slot8)

			slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

			slot0._skinSpine:setResPath(slot5, slot0._onSkinSpineLoaded, slot0, true)

			if not string.nilorempty(slot6) then
				slot0._skinSpineGO2 = slot0._skinSpineGO2 or gohelper.create2d(slot0._goUniqueImageicon2, "uniqueSkinSpine2")
				slot11 = slot0._skinSpineGO2.transform

				recthelper.setWidth(slot11, uv0[1])
				transformhelper.setLocalPos(slot11, slot7[1], slot7[2], 0)
				transformhelper.setLocalScale(slot11, slot8, slot8, slot8)

				slot0._skinSpine2 = GuiSpine.Create(slot0._skinSpineGO2, false)

				slot0._skinSpine2:setResPath(slot6, slot0._onSkinSpine2Loaded, slot0, true)
			end

			transformhelper.setLocalPos(slot0._uniqueImageicon.transform, 0, 0, 0)

			slot0._uniqueImageicon.transform.sizeDelta = Vector2.New(uv1[1], uv1[2])
		end

		gohelper.setActive(slot0._skinSpineGO, true)
		gohelper.setActive(slot0._goUniqueSkinBubble, false)
		gohelper.setActive(slot0._govx_iconbg, false)
		gohelper.setActive(slot0._govx_bg, false)

		if not string.nilorempty(slot9) then
			slot0._uniqueImagebg:LoadImage(slot9)

			slot0._uniqueImageicon.enabled = true

			slot0._uniqueSingleImageicon:LoadImage(slot9)
		else
			gohelper.setActive(slot0._uniqueImagebg.gameObject, false)

			slot0._uniqueImageicon.enabled = false
		end
	elseif string.find(slot1, "prefab") then
		slot3 = string.split(slot1, "#")
		slot6 = slot3[2]
		signTexturePath = #slot3 > 3 and slot3[4] or signTexturePath

		if slot0._skinSpine then
			slot0._skinSpine:setResPath(slot3[1], slot0._onSpineLoaded, slot0, true)
		else
			slot0._skinSpineGO = slot0._skinSpineGO or gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")

			transformhelper.setLocalPos(slot0._skinSpineGO.transform, uv2[1], uv2[2], uv2[3])

			slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

			slot0._skinSpine:setResPath(slot5, slot0._onSpineLoaded, slot0, true)
		end

		gohelper.setActive(slot0._skinSpineGO, true)

		if not string.nilorempty(slot6) then
			slot0._uniqueImagebg:LoadImage(slot6)
		else
			slot0._uniqueImagebg:LoadImage(uv3)
		end

		slot0._uniqueImageicon.enabled = true
	else
		slot0._uniqueImageicon.enabled = true

		if not string.nilorempty(slot1) then
			slot0._uniqueSingleImageicon:LoadImage(slot0._mo.config.bigImg)
		else
			slot0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end
end

function slot0._isNormalSkin(slot0)
	return slot0._mo.config.skinLevel == 0
end

function slot0._isAdvanceSkin(slot0)
	return slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1
end

function slot0._isUniqueSkin(slot0)
	return slot0._mo.config.skinLevel == 2
end

function slot0._isLinkageSkin(slot0)
	return slot0._mo.config.islinkageSkin or false
end

return slot0
