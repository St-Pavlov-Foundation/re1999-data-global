module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandStairs", package.seeall)

slot0 = class("FairyLandStairs", BaseView)

function slot0.onInitView(slot0)
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "main/#go_Root")
	slot0.rootTrs = slot0.goRoot.transform
	slot0.goStairs = gohelper.findChild(slot0.goRoot, "#go_Stairs")
	slot0.goPool = gohelper.findChild(slot0.goStairs, "pool")
	slot0.goStair = gohelper.findChild(slot0.goStairs, "pool/stair")
	slot0.stairPool = slot0:getUserDataTb_()
	slot0.stairDict = slot0:getUserDataTb_()
	slot0.noUseDict = {}
	slot0.poolCount = 0
	slot0.startPosX = -90
	slot0.startPosY = -120
	slot0.spaceX = 244
	slot0.spaceY = 73
	slot0.maxStair = 50
	slot0.offsetX = recthelper.getWidth(slot0.viewGO.transform) * 0.5 - slot0:caleStairPos(3) - 318

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.DoStairAnim, slot0.onDoStairAnim, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.SetStairPos, slot0.onSetStairPos, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onDoStairAnim(slot0, slot1)
	if slot0.stairDict[slot1] then
		slot0.stairDict[slot1].anim:Play("open", 0, 0)
	end
end

function slot0.moveToPos(slot0, slot1, slot2)
	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end

	slot3, slot4 = slot0:caleStairRootPos(math.min(slot0.maxStair - 6, slot1))

	if slot2 then
		slot0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0.rootTrs, slot3, slot4, slot0._tweenTime or 1, slot0._moveDone, slot0, nil, EaseType.OutQuad)
	else
		recthelper.setAnchor(slot0.rootTrs, slot3, slot4)
		slot0:updateStairs()
	end
end

function slot0._moveDone(slot0)
	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end

	slot0:updateStairs()
end

function slot0.caleStairRootPos(slot0, slot1)
	return -slot1 * slot0.spaceX + FairyLandEnum.StartCameraPosX + slot0.offsetX, slot1 * slot0.spaceY + FairyLandEnum.StartCameraPosY
end

function slot0.onSetStairPos(slot0, slot1)
	if slot1 then
		slot0:moveToPos(FairyLandModel.instance:getStairPos(), true)
	else
		slot0:moveToPos(slot2)
		slot0:updateStairs()
	end
end

function slot0.updateStairs(slot0)
	slot1 = math.min(slot0.maxStair - 6, FairyLandModel.instance:getStairPos())

	slot0:setNoUseStairs()

	for slot7 = slot1 - 2, slot1 + slot0:getScreenStairCount() do
		slot0:getStair(slot7)
	end

	slot0:recycleStairs()
end

function slot0.getScreenStairCount(slot0)
	if slot0.stairCount then
		return slot0.stairCount
	end

	slot0.stairCount = math.ceil(recthelper.getHeight(gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP").transform) / slot0.spaceY) + 2

	return slot0.stairCount
end

function slot0.onUpdateParam(slot0)
end

function slot0.setNoUseStairs(slot0)
	for slot4, slot5 in pairs(slot0.stairDict) do
		slot0.noUseDict[slot4] = true
	end
end

function slot0.recycleStairs(slot0)
	for slot4, slot5 in pairs(slot0.noUseDict) do
		slot0:recycleStair(slot0.stairDict[slot4])

		slot0.stairDict[slot4] = nil
	end

	slot0.noUseDict = {}
end

function slot0.getStair(slot0, slot1)
	slot0.noUseDict[slot1] = nil

	if not slot0.stairDict[slot1] then
		slot0.stairDict[slot1] = slot0:getOrCreateStair(slot1)
	end

	gohelper.setActive(slot2.go, slot1 <= slot0.maxStair)

	return slot2
end

function slot0.getOrCreateStair(slot0, slot1)
	slot2 = nil

	if slot0.poolCount > 0 then
		slot0.poolCount = slot0.poolCount - 1

		gohelper.addChild(slot0.goStairs, table.remove(slot0.stairPool).go)
	else
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0.goStair, slot0.goStairs)
		slot2.transform = slot2.go.transform
		slot2.anim = slot2.go:GetComponent(typeof(UnityEngine.Animator))
	end

	slot2.go.name = tostring(slot1)
	slot3, slot4 = slot0:caleStairPos(slot1)

	recthelper.setAnchor(slot2.transform, slot3, slot4)

	return slot2
end

function slot0.caleStairPos(slot0, slot1)
	return slot0.startPosX + slot1 * slot0.spaceX, slot0.startPosY - slot1 * slot0.spaceY
end

function slot0.recycleStair(slot0, slot1)
	if not slot1 then
		return
	end

	gohelper.addChild(slot0.goPool, slot1.go)
	table.insert(slot0.stairPool, slot1)

	slot0.poolCount = slot0.poolCount + 1
end

function slot0.onDestroyView(slot0)
	if slot0.moveTweenId then
		ZProj.TweenHelper.KillById(slot0.moveTweenId)

		slot0.moveTweenId = nil
	end
end

return slot0
