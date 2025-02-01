module("modules.logic.dungeon.view.DungeonViewEffect", package.seeall)

slot0 = class("DungeonViewEffect", BaseView)

function slot0.onInitView(slot0)
	slot0._gostory = gohelper.findChild(slot0.viewGO, "#go_story")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._effect = gohelper.findChild(slot0.viewGO, "#go_story/effect")
	slot0._effectTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._effect)

	slot0._effectTouchEventMgr:SetIgnoreUI(true)
	slot0._effectTouchEventMgr:SetOnlyTouch(true)
	slot0._effectTouchEventMgr:SetOnTouchDownCb(slot0._onEffectTouchDown, slot0)
	slot0:_loadEffect()
end

function slot0._loadEffect(slot0)
	slot0._effectItem = slot0:getUserDataTb_()
	slot0._effectIndex = 1
	slot0._effectNum = 3
	slot0._effectUrl = "ui/viewres/dungeon/dungeonview_effect.prefab"
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:addPath(slot0._effectUrl)
	slot0._effectLoader:startLoad(slot0._effectLoaded, slot0)
end

function slot0._effectLoaded(slot0, slot1)
	for slot7 = 1, slot0._effectNum do
		slot8 = slot0:getUserDataTb_()
		slot8.go = gohelper.clone(slot1:getAssetItem(slot0._effectUrl):GetResource(slot0._effectUrl), slot0._effect)
		slot8.tweenId = nil

		table.insert(slot0._effectItem, slot8)
		gohelper.setActive(slot8.go, false)
	end
end

function slot0._onEffectTouchDown(slot0, slot1)
	if UIBlockMgr.instance:isBlock() then
		return
	end

	if not ViewMgr.instance:getOpenViewNameList() or #slot2 <= 0 then
		return
	end

	for slot6 = #slot2, 1, -1 do
		slot7 = ViewMgr.instance:getSetting(slot2[slot6])

		if slot2[slot6] ~= ViewName.DungeonView and (slot7.layer == "POPUP_TOP" or slot7.layer == "POPUP") then
			return
		end

		if slot2[slot6] == ViewName.DungeonView then
			break
		end
	end

	if not slot0._effectItem[slot0._effectIndex] then
		return
	end

	slot1 = recthelper.screenPosToAnchorPos(slot1, slot0._effect.transform)

	if slot3.tweenId then
		ZProj.TweenHelper.KillById(slot3.tweenId)
		gohelper.setActive(slot3.go, false)
	end

	gohelper.setActive(slot3.go, true)
	transformhelper.setLocalPosXY(slot3.go.transform, slot1.x, slot1.y)

	slot3.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, nil, slot0._effectTweenFinish, slot0, slot0._effectIndex)

	if slot0._effectNum <= slot0._effectIndex then
		slot0._effectIndex = 1
	else
		slot0._effectIndex = slot0._effectIndex + 1
	end
end

function slot0._effectTweenFinish(slot0, slot1)
	if not slot0._effectItem[slot1] then
		return
	end

	slot2.tweenId = nil

	gohelper.setActive(slot2.go, false)
end

function slot0.onDestroyView(slot0)
	if slot0._effectTouchEventMgr then
		TouchEventMgrHepler.remove(slot0._effectTouchEventMgr)

		slot0._effectTouchEventMgr = nil
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()
	end

	for slot4 = 1, #slot0._effectItem do
		if slot0._effectItem[slot4].tweenId then
			ZProj.TweenHelper.KillById(slot5.tweenId)
		end
	end
end

return slot0
