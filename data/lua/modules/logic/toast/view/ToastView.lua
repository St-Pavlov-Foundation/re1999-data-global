module("modules.logic.toast.view.ToastView", package.seeall)

slot0 = class("ToastView", BaseView)
slot1 = 10000

function slot0.onInitView(slot0)
	slot0._gotemplate = gohelper.findChild(slot0.viewGO, "#go_template")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "#go_point")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._usingList = {}
	slot0._freeList = {}
	slot0._cacheMsgList = {}
	slot0._maxCount = 4
	slot0.space = 5
	slot0._showNextToastInterval = 0.1
	slot0.hadTask = false
	slot1 = slot0._gotemplate.transform
	slot0._itemHeight = recthelper.getHeight(slot1)
	slot0._itemWidth = recthelper.getWidth(slot1)

	slot0:_initExpandedSpace()
	recthelper.setAnchor(slot0._gotemplate.transform, uv0, uv0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot0:addToastMsg(slot0.viewParam)

	slot1 = ToastController.instance._msgList

	while #slot1 > 0 do
		slot0:addToastMsg(table.remove(slot1, 1))
	end

	slot0:addEventCb(ToastController.instance, ToastEvent.ShowToast, slot0.addToastMsg, slot0)
	slot0:addEventCb(ToastController.instance, ToastEvent.RecycleToast, slot0._doRecycleAnimation, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ToastController.instance, ToastEvent.ShowToast, slot0.addToastMsg, slot0)
	slot0:removeEventCb(ToastController.instance, ToastEvent.RecycleToast, slot0._doRecycleAnimation, slot0)
	TaskDispatcher.cancelTask(slot0._showToast, slot0)

	slot0.hadTask = false
end

function slot0.addToastMsg(slot0, slot1)
	table.insert(slot0._cacheMsgList, slot1)

	if not slot0.hadTask then
		slot0:_showToast()
		TaskDispatcher.runRepeat(slot0._showToast, slot0, slot0._showNextToastInterval)

		slot0.hadTask = true
	end
end

function slot0._showToast(slot0)
	if not table.remove(slot0._cacheMsgList, 1) then
		TaskDispatcher.cancelTask(slot0._showToast, slot0)

		slot0.hadTask = false

		return
	end

	slot2 = table.remove(slot0._freeList, 1) or MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gotemplate, slot0._gopoint), ToastItem)
	slot3 = nil

	if slot0._maxCount <= #slot0._usingList then
		slot0:_doRecycleAnimation(slot0._usingList[1], true)
	end

	table.insert(slot0._usingList, slot2)
	slot2:setMsg(slot1)
	slot2:appearAnimation(slot1)
	slot0:_refreshAllItemsAnimation()
end

function slot0._doRecycleAnimation(slot0, slot1, slot2)
	if tabletool.indexOf(slot0._usingList, slot1) then
		table.remove(slot0._usingList, slot3)
	end

	slot1:clearAllTask()
	slot1:quitAnimation(slot0._recycleToast, slot0)
end

function slot0._recycleToast(slot0, slot1)
	slot1:reset()
	table.insert(slot0._freeList, slot1)
end

function slot0._refreshAllItemsAnimation(slot0)
	slot1 = 0
	slot0._preAnchorY = 0

	for slot5 = 1, #slot0._usingList do
		if slot5 > 1 then
			slot1 = slot0._preAnchorY - slot6 - (slot0._templateMinHeight < slot0._usingList[slot5 - 1]:getToastItemHeight() and slot0._templateMinHeight < slot0._usingList[slot5]:getToastItemHeight() and slot0._spaceWhenExpanded or slot0.space)
		end

		slot0._preAnchorY = slot1

		if slot5 == #slot0._usingList then
			recthelper.setAnchorY(slot0._usingList[slot5].tr, slot1)
		else
			slot0._usingList[slot5]:upAnimation(slot1)
		end
	end
end

function slot0._initExpandedSpace(slot0)
	slot0._spaceWhenExpanded = slot0.space
	slot0._templateMinHeight = slot0._gotemplate:GetComponent(typeof(UnityEngine.UI.LayoutElement)).minHeight

	if gohelper.findChild(slot0.viewGO, "#go_template/#go_normal/bg").transform.anchorMin.y == 0 and slot1.anchorMax.y == 1 then
		slot0._spaceWhenExpanded = (slot1.offsetMax.y - slot1.offsetMin.y) * 0.5
	end
end

return slot0
