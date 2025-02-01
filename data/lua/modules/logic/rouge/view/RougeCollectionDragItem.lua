module("modules.logic.rouge.view.RougeCollectionDragItem", package.seeall)

slot0 = class("RougeCollectionDragItem", RougeCollectionSizeBagItem)

function slot0.onInit(slot0, slot1, slot2)
	slot0:createCollectionGO(slot1, slot2)
	uv0.super.onInit(slot0, slot0.viewGO)

	slot0._gocenter = gohelper.findChild(slot0.viewGO, "go_center")
	slot0._simageiconeffect = gohelper.findChildSingleImage(slot0.viewGO, "go_center/simage_icon/icon_effect")
	slot0._godisconnect = gohelper.findChild(slot0.viewGO, "go_center/go_disconnect")
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._animator.enabled = false
	slot0._activeEffectMap = {}

	slot0:setAnimatorEnabled(false)
	slot0:setShowTypeFlagVisible(false)
	slot0:setPivot(0, 1)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateActiveEffect, slot0.updateActiveEffectTag, slot0)
end

function slot0.createCollectionGO(slot0, slot1, slot2)
	if slot2._gochessitem then
		slot0.viewGO = gohelper.cloneInPlace(slot3, slot1)
		slot0.viewGO.transform.anchorMin = Vector2.New(0.5, 0.5)
		slot0.viewGO.transform.anchorMax = Vector2.New(0.5, 0.5)
		slot0.viewGO.transform.pivot = Vector2.New(0.5, 0.5)

		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0.getCollectionTransform(slot0)
	return slot0.viewGO and slot0.viewGO.transform
end

function slot0.setPivot(slot0, slot1, slot2)
	slot0.viewGO.transform.pivot = Vector2(slot1, slot2)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:updateCollectionPosition()
	slot0._simageiconeffect:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.cfgId))
	slot0:_selectCollection()
end

function slot0.onUpdateRotateAngle(slot0)
	uv0.super.onUpdateRotateAngle(slot0)
	slot0:updateElectirDisconnnectFlagPos()
end

function slot0.updateCollectionRotation(slot0, slot1)
	transformhelper.setLocalRotation(slot0._gocenter.transform, 0, 0, slot1)
end

function slot0.refreshSlotCell(slot0, slot1, slot2, slot3)
	slot0:setCellAnchor(slot1, slot2, slot3)
	slot0:checkAndPlaceAroundLine(slot1, slot2)
end

function slot0.setParent(slot0, slot1)
	if not slot1 or slot0._curParentTran == slot1 then
		return
	end

	slot0.viewGO.transform:SetParent(slot1)

	slot0._curParentTran = slot1
end

function slot0.setShowTypeFlagVisible(slot0, slot1)
	slot0._isElectriDisconnect = slot1 and slot0._activeEffectMap[RougeEnum.EffectActiveType.Electric] == false

	gohelper.setActive(slot0._simageiconeffect.gameObject, slot1 and slot0._activeEffectMap[RougeEnum.EffectActiveType.LevelUp] or slot1 and slot0._activeEffectMap[RougeEnum.EffectActiveType.Engulf])
	gohelper.setActive(slot0._godisconnect, slot0._isElectriDisconnect)
	slot0:updateElectirDisconnnectFlagPos()
end

slot0.BaseElectricDisconnectFlagPosX = 0

function slot0.updateElectirDisconnnectFlagPos(slot0)
	if not slot0._isElectriDisconnect then
		return
	end

	slot4 = 0

	for slot8 = 1, #RougeCollectionConfig.instance:getShapeMatrix(slot0._mo.cfgId, slot0._mo:getRotation())[1] do
		if slot3[slot8] and slot3[slot8] > 0 then
			slot4 = slot8 - 1

			break
		end
	end

	recthelper.setAnchorX(slot0._godisconnect.transform, uv0.BaseElectricDisconnectFlagPosX + slot4 * RougeCollectionHelper.CollectionSlotCellSize.x)
end

function slot0.updateActiveEffectTag(slot0, slot1, slot2, slot3)
	if slot0._mo and slot1 == slot0._mo.id then
		slot0._activeEffectMap = slot0._activeEffectMap or {}
		slot0._activeEffectMap[slot2] = slot3

		slot0:setShowTypeFlagVisible(true)
	end
end

function slot0.setSelectFrameVisible(slot0, slot1)
	uv0.super.setSelectFrameVisible(slot0, slot1)
	slot0:setShapeCellsVisible(slot1)
end

function slot0.setAnimatorEnabled(slot0, slot1)
	slot0._animator.enabled = slot1
end

function slot0.playAnim(slot0, slot1)
	slot0:setAnimatorEnabled(true)
	slot0._animator:Play(slot1, 0, 0)
end

function slot0.reset(slot0)
	uv0.super.reset(slot0)
	transformhelper.setLocalRotation(slot0._gocenter.transform, 0, 0, 0)
	slot0:setAnimatorEnabled(false)
	slot0:setShowTypeFlagVisible(false)
	gohelper.setActive(slot0._simageiconeffect.gameObject, false)
	tabletool.clear(slot0._activeEffectMap)
end

function slot0.destroy(slot0)
	uv0.super.destroy(slot0)
end

return slot0
