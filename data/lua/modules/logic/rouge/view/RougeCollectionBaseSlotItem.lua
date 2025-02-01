module("modules.logic.rouge.view.RougeCollectionBaseSlotItem", package.seeall)

slot0 = class("RougeCollectionBaseSlotItem", UserDataDispose)

function slot0.onInit(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "go_center")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "go_center/simage_icon")
	slot0._goholetool = gohelper.findChild(slot0.viewGO, "go_center/go_holetool")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "go_center/go_holetool/go_holeitem")
	slot0._imageenchanticon = gohelper.findChild(slot0.viewGO, "go_center/go_holetool/go_holeitem/image_enchanticon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateEnchantInfo, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SetCollectionVisible, slot0.setCollectionVisibleCallBack, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0.failed2PlaceSlotCollection, slot0)

	slot0._holeItemTab = slot0:getUserDataTb_()
	slot0._canvasgroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)

	slot0:setPerCellWidthAndHeight()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshCollectionIcon()
	slot0:updateItemSize()
	slot0:refreshAllHoles()
	slot0:onUpdateRotateAngle()
	slot0:setItemVisible(true)
	slot0:updateIconPosition()
	slot0:updateCollectionPosition()
end

function slot0.setPerCellWidthAndHeight(slot0, slot1, slot2)
	slot0._perCellWidth = slot1 or RougeCollectionHelper.CollectionSlotCellSize.x
	slot0._perCellHeight = slot2 or RougeCollectionHelper.CollectionSlotCellSize.y
end

function slot0.refreshCollectionIcon(slot0)
	slot0._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(slot0._mo.cfgId)

	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.cfgId))
	slot0:setIconRoateAngle()
	RougeCollectionHelper.computeAndSetCollectionIconScale(slot0._mo.cfgId, slot0._simageicon.transform, slot0._perCellWidth, slot0._perCellHeight)
end

function slot0.onUpdateRotateAngle(slot0)
	slot0:updateItemSize()
	slot0:setIconRoateAngle()
	slot0:updateHoleContainerPos()
end

function slot0.updateItemSize(slot0)
	slot2, slot3 = RougeCollectionHelper.getCollectionSizeAfterRotation(slot0._mo.cfgId, slot0._mo:getRotation())

	recthelper.setSize(slot0.viewGO.transform, slot0._perCellWidth * slot2, slot0._perCellHeight * slot3)
end

function slot0.refreshAllHoles(slot0)
	gohelper.CreateObjList(slot0, slot0.refrehHole, slot0._mo:getAllEnchantId() or {}, slot0._goholetool, slot0._goholeitem)
	slot0:updateHoleContainerPos()
end

slot0.BaseHoleContainerAnchorPosX = 0

function slot0.updateHoleContainerPos(slot0)
	if (slot0._collectionCfg.holeNum or 0) <= 0 then
		return
	end

	slot3 = RougeCollectionConfig.instance:getShapeMatrix(slot0._mo.cfgId, slot0._mo:getRotation())
	slot6 = 0

	for slot11 = #slot3[tabletool.len(slot3)], 1, -1 do
		if slot5[slot11] and slot5[slot11] > 0 then
			slot6 = slot7 - slot11

			break
		end
	end

	recthelper.setAnchorX(slot0._goholetool.transform, uv0.BaseHoleContainerAnchorPosX + -slot6 * RougeCollectionHelper.CollectionSlotCellSize.x)
end

function slot0.refrehHole(slot0, slot1, slot2, slot3)
	slot6 = slot2 and slot2 > 0

	gohelper.setActive(gohelper.findChild(slot1, "go_get"), slot6)
	gohelper.setActive(gohelper.findChild(slot1, "go_none"), not slot6)

	if not slot0._holeItemTab[slot3] then
		slot0._holeItemTab[slot3] = slot1
	end

	if not slot6 then
		return
	end

	slot8, slot9 = slot0._mo:getEnchantIdAndCfgId(slot3)

	gohelper.findChildSingleImage(slot1, "go_get/image_enchanticon"):LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot9))
end

function slot0.getHoleObj(slot0, slot1)
	return slot0._holeItemTab and slot0._holeItemTab[slot1]
end

function slot0.getAllHoleObj(slot0)
	return slot0._holeItemTab
end

function slot0.setCollectionVisibleCallBack(slot0, slot1, slot2)
	if slot0._mo and slot0._mo.id == slot1 then
		slot0:setItemVisible(slot2)
	end
end

function slot0.setItemVisible(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
	slot0:setCanvasGroupVisible(slot1)
end

function slot0.setCanvasGroupVisible(slot0, slot1)
	slot0._canvasgroup.alpha = slot1 and 1 or 0

	slot0:setCollectionInteractable(slot1)
end

function slot0.setCollectionInteractable(slot0, slot1)
	slot0._canvasgroup.interactable = slot1
	slot0._canvasgroup.blocksRaycasts = slot1
end

function slot0.updateEnchantInfo(slot0, slot1)
	if not slot0._mo or slot0._mo.id ~= slot1 then
		return
	end

	if not slot0._mo:getAllEnchantId() then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		if slot0:getHoleObj(slot6) then
			slot0:refrehHole(slot8, slot7, slot6)
		end
	end
end

function slot0.setHoleToolVisible(slot0, slot1)
	gohelper.setActive(slot0._goholetool, slot1)
end

function slot0.setIconRoateAngle(slot0)
	transformhelper.setLocalRotation(slot0._simageicon.transform, 0, 0, RougeCollectionHelper.getRotateAngleByRotation(slot0._mo:getRotation()))
end

function slot0.updateIconPosition(slot0)
	slot2 = RougeCollectionConfig.instance:getOriginEditorParam(slot0._mo.cfgId, RougeEnum.CollectionEditorParamType.IconOffset)

	recthelper.setAnchor(slot0._gocenter.transform, slot2.x, slot2.y)
end

function slot0.updateCollectionPosition(slot0)
	if not slot0._mo or not slot0._mo.getLeftTopPos then
		return
	end

	slot2, slot3 = RougeCollectionHelper.getCollectionPlacePosition(slot0._mo:getLeftTopPos(), slot0._perCellWidth, slot0._perCellHeight)

	slot0:setCollectionPosition(slot2, slot3)
end

function slot0.setCollectionPosition(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.viewGO.transform, slot1, slot2)
end

function slot0.failed2PlaceSlotCollection(slot0, slot1)
	if slot0._mo and slot0._mo.id == slot1 then
		slot0:setItemVisible(true)
	end
end

function slot0.reset(slot0)
	slot0._mo = nil

	slot0:setItemVisible(false)
end

function slot0.destroy(slot0)
	slot0._simageicon:UnLoadImage()

	if slot0._holeItemTab then
		for slot4, slot5 in pairs(slot0._holeItemTab) do
			gohelper.findChildSingleImage(slot5, "go_get/image_enchanticon"):UnLoadImage()
		end
	end

	slot0:__onDispose()
end

return slot0
