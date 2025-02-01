module("modules.logic.explore.view.ExploreBonusItem", package.seeall)

slot0 = class("ExploreBonusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._progress = gohelper.findChildImage(slot1, "bottom/progressbar1/image_progresssilder")
	slot0._progress2 = gohelper.findChildImage(slot1, "bottom/progressbar2/image_progresssilder")
	slot0._bglight = gohelper.findChild(slot1, "bottom/bg_light")
	slot0._bgdark = gohelper.findChild(slot1, "bottom/bg_dark")
	slot0._point = gohelper.findChildTextMesh(slot1, "bottom/txt_point")
	slot0._rewardItem = gohelper.findChild(slot1, "go_rewarditem")
	slot0._itemParent = gohelper.findChild(slot1, "icons")
	slot0._display = gohelper.findChild(slot1, "bottom/bg_normal/bg_canget")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, slot0._onUpdateTask, slot0)
end

function slot0.removeEventListeners(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, slot0._onUpdateTask, slot0)
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = string.splitToNumber(slot1.listenerParam, "#")
	slot6 = 1
	slot7 = 0

	if slot1.maxProgress <= (TaskModel.instance:getTaskById(slot1.id) and slot4.progress or 0) then
		if slot0._index == #ExploreConfig.instance:getTaskList(slot2[1], slot2[2]) then
			slot7 = 1
		else
			if TaskModel.instance:getTaskById(slot3[slot0._index + 1].id) then
				slot5 = slot9.progress or slot5
			end

			slot7 = Mathf.Clamp((slot5 - slot1.maxProgress) / (slot3[slot0._index + 1].maxProgress - slot1.maxProgress), 0, 0.5) * 2
		end
	else
		slot6 = slot0._index == 1 and slot5 / slot1.maxProgress or (Mathf.Clamp((slot5 - slot3[slot0._index - 1].maxProgress) / (slot1.maxProgress - slot3[slot0._index - 1].maxProgress), 0.5, 1) - 0.5) * 2
	end

	slot0._progress.fillAmount = slot6
	slot0._progress2.fillAmount = slot7
	slot0._point.text = slot1.maxProgress

	SLFramework.UGUI.GuiHelper.SetColor(slot0._point, slot8 and "#1e1919" or "#d2c197")

	slot0._items = slot0._items or {}

	gohelper.CreateObjList(slot0, slot0._setRewardItem, GameUtil.splitString2(slot1.bonus, true), slot0._itemParent, slot0._rewardItem)
	slot0:_onUpdateTask()
	gohelper.setActive(slot0._display, slot1.display == 1)
	gohelper.setActive(slot0._bglight, slot8)
	gohelper.setActive(slot0._bgdark, not slot8)
end

function slot0._setRewardItem(slot0, slot1, slot2, slot3)
	slot0._items[slot3] = slot0._items[slot3] or {}
	slot6 = slot0._items[slot3].item or IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_icon"))
	slot0._items[slot3].item = slot6

	slot6:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
	slot6:setCountFontSize(46)
	slot6:SetCountBgHeight(31)

	slot0._items[slot3].hasget = gohelper.findChild(slot1, "go_receive")
end

function slot0._onUpdateTask(slot0)
	for slot6 = 1, #slot0._items do
		gohelper.setActive(slot0._items[slot6].hasget, TaskModel.instance:getTaskById(slot0._mo.id) and slot1.finishCount > 0 or false)
	end
end

function slot0.onDestroy(slot0)
	for slot4 = 1, #slot0._items do
		slot0._items[slot4].item:onDestroy()
	end
end

return slot0
