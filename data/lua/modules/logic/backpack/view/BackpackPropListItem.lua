module("modules.logic.backpack.view.BackpackPropListItem", package.seeall)

slot0 = class("BackpackPropListItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	gohelper.setActive(slot1, false)

	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot1)
end

function slot0.addEvents(slot0)
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, slot0._categorySelected, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
end

function slot0.removeEvents(slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, slot0._categorySelected, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
end

function slot0._categorySelected(slot0)
	if slot0._itemIcon then
		slot0._itemIcon:setAutoPlay(false)

		if not slot0._canvasGroup then
			slot0._canvasGroup = gohelper.onceAddComponent(slot0._itemIcon.go, typeof(UnityEngine.CanvasGroup))
		end

		slot0._canvasGroup.alpha = 1

		TaskDispatcher.cancelTask(slot0._showItem, slot0)

		slot0._itemIcon.go:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1

		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function slot0._onViewClose(slot0, slot1)
	if not slot0._mo or not slot0._itemIcon then
		return
	end

	slot2 = slot0._mo.config

	slot0._itemIcon:setRecordFarmItem({
		type = slot2.type,
		id = slot2.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function slot0._showItem(slot0)
	gohelper.setActive(slot0.go, true)

	if not BackpackModel.instance:getItemAniHasShown() then
		slot0._itemIcon:playAnimation("backpack_common_in")
	end

	if slot0._index >= 24 then
		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot0._index <= 24 then
		TaskDispatcher.runDelay(slot0._showItem, slot0, 0.03 * math.floor((slot0._index - 1) / 6))
	else
		slot0._itemIcon:setAutoPlay(false)
		TaskDispatcher.cancelTask(slot0._showItem, slot0)
		slot0:_showItem()
		BackpackModel.instance:setItemAniHasShown(true)
	end

	slot2 = slot1.config

	slot0._itemIcon:setInPack(true)
	slot0._itemIcon:setMOValue(slot2.type, slot2.id, slot2.quantity, slot2.uid)
	slot0._itemIcon:isShowName(false)
	slot0._itemIcon:isShowCount(slot2.isStackable ~= 0)
	slot0._itemIcon:isShowEffect(true)
	slot0._itemIcon:setRecordFarmItem({
		type = slot2.type,
		id = slot2.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showItem, slot0)
end

return slot0
