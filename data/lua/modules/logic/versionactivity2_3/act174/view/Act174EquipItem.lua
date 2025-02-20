module("modules.logic.versionactivity2_3.act174.view.Act174EquipItem", package.seeall)

slot0 = class("Act174EquipItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._teamView = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imageQuality = gohelper.findChildImage(slot1, "image_quality")
	slot0._simageCollection = gohelper.findChildSingleImage(slot1, "simage_Collection")
	slot0._goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0._click = gohelper.findChildClick(slot1, "")

	CommonDragHelper.instance:registerDragObj(slot1, slot0.beginDrag, nil, slot0.endDrag, slot0.checkDrag, slot0)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0._simageCollection:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(slot0._go)
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1

	gohelper.setActive(slot0._go, Activity174Helper.CalculateRowColumn(slot1) <= slot0._teamView.unLockTeamCnt)
end

function slot0.setData(slot0, slot1)
	slot0._collectionId = slot1

	if slot1 then
		slot2 = lua_activity174_collection.configDict[slot1]

		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageQuality, "act174_propitembg_" .. slot2.rare)
		slot0._simageCollection:LoadImage(ResUrl.getRougeSingleBgCollection(slot2.icon))
	else
		slot0._simageCollection:UnLoadImage()
	end

	gohelper.setActive(slot0._imageQuality, slot1)
	gohelper.setActive(slot0._simageCollection, slot1)
	gohelper.setActive(slot0._goEmpty, not slot1)
end

function slot0.onClick(slot0)
	if slot0.tweenId or slot0.isDraging then
		return
	end

	slot0._teamView:clickCollection(slot0._index)
end

function slot0.beginDrag(slot0)
	gohelper.setAsLastSibling(slot0._go)

	slot0.isDraging = true
end

function slot0.endDrag(slot0, slot1, slot2)
	slot0.isDraging = false

	if not slot0:findTarget(slot2.position) then
		slot6, slot7 = recthelper.getAnchor(slot0._teamView.frameTrList[slot0._index])

		slot0:setToPos(slot0._go.transform, Vector2(slot6, slot7), true, slot0.tweenCallback, slot0)
		slot0._teamView:UnInstallCollection(slot0._index)
	elseif slot0._teamView:canEquipMove(slot0._index, slot4._index) then
		slot8, slot9 = recthelper.getAnchor(slot0._teamView.frameTrList[slot6])

		slot0:setToPos(slot0._go.transform, Vector2(slot8, slot9), true, slot0.tweenCallback, slot0)

		if slot4 ~= slot0 then
			slot11, slot12 = recthelper.getAnchor(slot0._teamView.frameTrList[slot0._index])

			slot0:setToPos(slot4._go.transform, Vector2(slot11, slot12), true, function ()
				uv0._teamView:exchangeEquipItem(uv0._index, uv1)
			end, slot0)
		end
	else
		GameFacade.showToast(ToastEnum.Act174OnlyCollection)

		slot8, slot9 = recthelper.getAnchor(slot0._teamView.frameTrList[slot0._index])

		slot0:setToPos(slot0._go.transform, Vector2(slot8, slot9), true, slot0.tweenCallback, slot0)
	end
end

function slot0.checkDrag(slot0)
	if slot0._collectionId and slot0._collectionId ~= 0 then
		return false
	end

	return true
end

function slot0.findTarget(slot0, slot1)
	for slot5 = 1, slot0._teamView.unLockTeamCnt * 4 do
		slot6 = slot0._teamView.frameTrList[slot5]
		slot8, slot9 = recthelper.getAnchor(slot6)

		if math.abs(recthelper.screenPosToAnchorPos(slot1, slot6.parent).x - slot8) * 2 < recthelper.getWidth(slot6) and math.abs(slot11.y - slot9) * 2 < recthelper.getHeight(slot6) then
			return slot0._teamView.equipItemList[slot5] or nil
		end
	end

	return nil
end

function slot0.setToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0.tweenCallback(slot0)
	slot0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return slot0
