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
	slot0._simagematerial = gohelper.findChildSingleImage(slot0._goprice, "simage_material")
	slot0._simagematerial = gohelper.findChildImage(slot0._goprice, "simage_material")
	slot0._goLinkage = gohelper.findChild(slot0.viewGO, "#go_Linkage")
	slot0._btnGO = gohelper.findChild(slot0.viewGO, "clickArea")
	slot0._btn = gohelper.getClickWithAudio(slot0._btnGO, AudioEnum.UI.play_ui_rolesopen)

	slot0._btn:AddClickListener(slot0._onClick, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._mask.enabled = false
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onClick(slot0)
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = slot0._mo
	})
end

function slot0._onDraggingBegin(slot0)
	if slot0._mo.config.skinLevel == 2 and slot0._skinSpineGO2 then
		slot0._mask.enabled = true
	end
end

function slot0._onDragging(slot0)
	if slot0._mo.config.skinLevel == 2 and slot0._skinSpineGO2 then
		slot2 = slot0.viewGO.transform
		slot4 = recthelper.getWidth(slot2) * 0.5

		recthelper.setAnchorX(slot2, -slot4)
		recthelper.setAnchorX(slot2, slot4)
		recthelper.setAnchorX(slot2, 0)

		slot0._mask.enabled = not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot2) or not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot2)
	end
end

function slot0._onDraggingEnd(slot0)
	if slot0._mo.config.skinLevel == 2 and slot0._skinSpineGO2 then
		slot2 = slot0.viewGO.transform
		slot4 = recthelper.getWidth(slot2) * 0.5

		recthelper.setAnchorX(slot2, -slot4)
		recthelper.setAnchorX(slot2, slot4)
		recthelper.setAnchorX(slot2, 0)

		slot0._mask.enabled = not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot2) or not slot0:checkItemInGoodsList(slot0.viewGO.transform.parent.parent.parent, slot2)
	end
end

function slot0.checkItemInGoodsList(slot0, slot1, slot2)
	slot3, slot4 = recthelper.uiPosToScreenPos2(slot2)

	return recthelper.screenPosInRect(slot1, CameraMgr.instance:getUICamera(), slot3, slot4)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot0._mo.config.product
	slot3 = slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1

	gohelper.setActive(slot0._goNormalSkin, slot0._mo.config.skinLevel == 0)
	gohelper.setActive(slot0._goAdvanceSkin, slot0._mo.config.isAdvancedSkin or slot0._mo.config.skinLevel == 1)
	gohelper.setActive(slot0._goUniqueSkin, slot0._mo.config.skinLevel == 2)

	if slot0._mo.config.skinLevel == 2 then
		slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, slot0._onDraggingBegin, slot0)
		slot0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, slot0._onDraggingEnd, slot0)
		slot0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, slot0._onDragging, slot0)
		gohelper.setAsLastSibling(slot0.viewGO.transform.parent.gameObject)

		slot5 = slot0._mo.config.bigImg

		if not string.nilorempty(slot0._mo.config.spineParams) then
			slot7 = string.split(slot6, "#")
			slot9 = slot7[2]
			slot10 = string.splitToNumber(slot7[3], ",")
			slot11 = tonumber(slot7[4])
			slot12 = slot7[5]

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot7[1], slot0._onSkinSpineLoaded, slot0, true)
			else
				slot0._skinSpineGO = gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")
				slot13 = slot0._skinSpineGO.transform

				recthelper.setWidth(slot13, uv0[1])
				transformhelper.setLocalPos(slot13, slot10[1], slot10[2], 0)
				transformhelper.setLocalScale(slot13, slot11, slot11, slot11)

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot8, slot0._onSkinSpineLoaded, slot0, true)

				if not string.nilorempty(slot9) then
					slot0._skinSpineGO2 = gohelper.create2d(slot0._goUniqueImageicon2, "uniqueSkinSpine2")
					slot14 = slot0._skinSpineGO2.transform

					recthelper.setWidth(slot14, uv0[1])
					transformhelper.setLocalPos(slot14, slot10[1], slot10[2], 0)
					transformhelper.setLocalScale(slot14, slot11, slot11, slot11)

					slot0._skinSpine2 = GuiSpine.Create(slot0._skinSpineGO2, false)

					slot0._skinSpine2:setResPath(slot9, slot0._onSkinSpine2Loaded, slot0, true)
				end

				transformhelper.setLocalPos(slot0._uniqueImageicon.transform, 0, 0, 0)

				slot0._uniqueImageicon.transform.sizeDelta = Vector2.New(uv1[1], uv1[2])
			end

			gohelper.setActive(slot0._skinSpineGO, true)
			gohelper.setActive(slot0._goUniqueSkinBubble, false)
			gohelper.setActive(slot0._govx_iconbg, false)
			gohelper.setActive(slot0._govx_bg, false)

			if not string.nilorempty(slot12) then
				slot0._uniqueImagebg:LoadImage(slot12)

				slot0._uniqueImageicon.enabled = true

				slot0._uniqueSingleImageicon:LoadImage(slot12)
			else
				gohelper.setActive(slot0._uniqueImagebg.gameObject, false)

				slot0._uniqueImageicon.enabled = false
			end
		elseif string.find(slot5, "prefab") then
			slot7 = string.split(slot5, "#")
			slot9 = slot7[2]

			if slot0._skinSpine then
				slot0._skinSpine:setResPath(slot7[1], slot0._onSpineLoaded, slot0, true)
			else
				slot0._skinSpineGO = gohelper.create2d(slot0._goUniqueSkinsImage, "uniqueSkinSpine")

				transformhelper.setLocalPos(slot0._skinSpineGO.transform, uv2[1], uv2[2], uv2[3])

				slot0._skinSpine = GuiSpine.Create(slot0._skinSpineGO, false)

				slot0._skinSpine:setResPath(slot8, slot0._onSpineLoaded, slot0, true)
			end

			gohelper.setActive(slot0._skinSpineGO, true)

			if not string.nilorempty(slot9) then
				slot0._uniqueImagebg:LoadImage(slot9)
			else
				slot0._uniqueImagebg:LoadImage(uv3)
			end

			slot0._uniqueImageicon.enabled = true
		else
			slot0._uniqueImageicon.enabled = true

			if not string.nilorempty(slot5) then
				slot0._uniqueSingleImageicon:LoadImage(slot0._mo.config.bigImg)
			else
				slot0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
			end
		end

		slot0._simagesign:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))
	else
		slot0._simagesign:LoadImage(ResUrl.getCharacterSkinIcon("img_dressing"))

		if string.nilorempty(slot0._mo.config.bigImg) == false then
			(slot3 and slot0._advanceImageicon or slot0._simageicon):LoadImage(slot0._mo.config.bigImg)
		else
			slot5:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	slot0.skinCo = SkinConfig.instance:getSkinCo(string.splitToNumber(slot2, "#")[2])
	slot0._txtskinname.text = slot0.skinCo.characterSkin
	slot0._txtname.text = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId).name

	if slot1:alreadyHas() then
		gohelper.setActive(slot0._goowned, true)
		gohelper.setActive(slot0._goprice, false)
		gohelper.setActive(slot0._godeduction, false)
	else
		gohelper.setActive(slot0._goowned, false)
		gohelper.setActive(slot0._goprice, true)

		slot9 = 0

		if not string.nilorempty(slot0._mo.config.deductionItem) then
			slot10 = GameUtil.splitString2(slot0._mo.config.deductionItem, true)
			slot9 = ItemModel.instance:getItemCount(slot10[1][2])
			slot0._txtdeduction.text = -slot10[2][1]
		end

		gohelper.setActive(slot0._godeduction, slot9 > 0)
	end

	slot9 = string.splitToNumber(slot0._mo.config.cost, "#")
	slot0._costType = slot9[1]
	slot0._costId = slot9[2]
	slot0._costQuantity = slot9[3]
	slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simagematerial, string.format("%s_1", slot10.icon), true)

	slot0._txtmaterialNum.text = slot0._costQuantity

	gohelper.setActive(slot0._gotag, slot1.config.originalCost > 0)
	gohelper.setActive(slot0._txtoriginalprice.gameObject, slot1.config.originalCost > 0)

	slot0._txtdiscount.text = string.format("-%d%%", 100 - math.ceil(slot0._costQuantity / slot1.config.originalCost * 100))
	slot0._txtoriginalprice.text = slot1.config.originalCost

	gohelper.setActive(slot0._gonewtag, slot1:needShowNew())

	slot15 = slot1:getOfflineTime()

	gohelper.setActive(slot0._goremaintime, slot15 > 0 and slot8 == false)

	if slot15 - ServerTime.now() > 3600 then
		slot17, slot18 = TimeUtil.secondToRoughTime(slot16)
		slot0._txtremaintime.text = formatLuaLang("remain", slot17 .. slot18)
	else
		slot0._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	slot0:refreshChargeInfo()
	slot0:_onUpdateMO_linkage()
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
		slot3 = slot0._mo:alreadyHas()
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

function slot0.onDestroyView(slot0)
	slot0._btn:RemoveClickListener()
	slot0._simagebg:UnLoadImage()
	slot0._simageg:UnLoadImage()
	slot0._simagesign:UnLoadImage()
	slot0._simagesign:UnLoadImage()
	slot0._uniqueSingleImageicon:UnLoadImage()
	slot0._uniqueImagebg:UnLoadImage()

	if slot0._skinSpine then
		slot0._skinSpine:doClear()

		slot0._skinSpine = nil
	end

	if slot0._skinSpine2 then
		slot0._skinSpine2:doClear()

		slot0._skinSpine2 = nil
	end

	if slot0._mo.config.skinLevel == 2 then
		slot0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, slot0._onDraggingBegin, slot0)
		slot0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, slot0._onDraggingEnd, slot0)
		slot0:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, slot0._onDragging, slot0)
	end
end

function slot0._onUpdateMO_linkage(slot0)
	gohelper.setActive(slot0._goLinkage, slot0._mo.config.islinkageSkin or false)
end

return slot0
