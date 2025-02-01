module("modules.logic.dungeon.view.rolestory.RoleStoryRewardView", package.seeall)

slot0 = class("RoleStoryRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtScore = gohelper.findChildTextMesh(slot0.viewGO, "Left/title/scorebg/#txt_score")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "Left/progress")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "Left/progress/#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "Left/progress/#scroll_view/Viewport/Content")
	slot0._gonormalline = gohelper.findChild(slot0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	slot0._rectnormalline = slot0._gonormalline.transform
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "Left/rightbg")
	slot0._gotargetrewardpos = gohelper.findChild(slot0.viewGO, "Left/rightbg/rightprogressbg/#go_progressitem")
	slot0._normalDelta = Vector2.New(-420, 600)
	slot0._fullDelta = Vector2.New(-200, 600)
	slot0.startSpace = 2
	slot0.cellWidth = 268
	slot0.space = 0
	slot0.targetId = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onGetScoreBonus, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onGetScoreBonus, slot0)
end

function slot0._editableInitView(slot0)
	slot0._scrollreward:AddOnValueChanged(slot0._onScrollChange, slot0)
end

function slot0._onScrollChange(slot0, slot1)
	slot0:refreshTarget()
end

function slot0._onGetScoreBonus(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshView()
	TaskDispatcher.runDelay(slot0.checkGetReward, slot0, 0.6)
end

function slot0.refreshView(slot0)
	slot0:refreshReward()
	slot0:refreshProgress()
	TaskDispatcher.cancelTask(slot0.refreshTarget, slot0)
	TaskDispatcher.runDelay(slot0.refreshTarget, slot0, 0.02)
end

function slot0.refreshProgress(slot0)
	slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	slot0.storyMo = RoleStoryModel.instance:getById(slot0.storyId)

	if not slot0.storyMo then
		return
	end

	slot0._txtScore.text = slot0.storyMo:getScore()
	slot3 = #(RoleStoryConfig.instance:getRewardList(slot0.storyId) or {})

	for slot7, slot8 in ipairs(slot2) do
		if slot1 < slot8.score then
			slot3 = slot7 - 1

			break
		end
	end

	slot4 = slot2[slot3] and slot2[slot3].score or 0
	slot6 = 0
	slot9 = 0

	if slot4 < (slot2[slot3 + 1] and slot2[slot3 + 1].score or slot4) then
		slot9 = (slot1 - slot4) / (slot5 - slot4) * (slot0:getNodeWidth(slot3 + 1, slot6) - slot0:getNodeWidth(slot3, slot6))
	end

	recthelper.setWidth(slot0._rectnormalline, slot7 + slot9)

	if not slot0.isPlayMove then
		slot0.isPlayMove = true

		slot0.viewContainer:getScrollView():moveToByCheckFunc(function (slot0)
			return slot0.index == uv0
		end)
	end
end

function slot0.getNodeWidth(slot0, slot1, slot2)
	slot3 = slot2 or 0

	if slot1 > 0 then
		slot3 = (slot1 - 1) * (slot0.cellWidth + slot0.space) + slot0.startSpace + slot0.cellWidth * 0.5 + slot2
	end

	return slot3
end

function slot0.refreshReward(slot0)
	RoleStoryRewardListModel.instance:refreshList()
end

function slot0.refreshTarget(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTarget, slot0)

	if (slot0:getTargetReward() and slot1.config and slot1.config.id) == slot0.targetId then
		return
	end

	slot0.targetId = slot2
	slot3 = nil

	if slot2 then
		if not slot0.targetItem then
			slot0.targetItem = MonoHelper.addLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0._gotargetrewardpos, "targetItem"), RoleStoryRewardItem)
		end

		slot3 = {
			config = slot1.config,
			index = slot1.index,
			isTarget = true
		}
	end

	if slot0.targetItem then
		slot0.targetItem:refresh(slot3)
	end

	if slot3 then
		gohelper.setActive(slot0._gotarget, true)

		slot0._goMask.transform.sizeDelta = slot0._normalDelta
	else
		gohelper.setActive(slot0._gotarget, false)

		slot0._goMask.transform.sizeDelta = slot0._fullDelta
	end
end

function slot0.getTargetReward(slot0)
	if not slot0.importantRewards then
		slot0.importantRewards = {}

		for slot5, slot6 in ipairs(RoleStoryConfig.instance:getRewardList(slot0.storyId) or {}) do
			if slot6.keyReward == 1 then
				table.insert(slot0.importantRewards, {
					score = slot6.score,
					index = slot5,
					config = slot6
				})
			end
		end

		table.sort(slot0.importantRewards, SortUtil.keyLower("score"))
	end

	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot0.importantRewards) do
		if RoleStoryModel.instance:getRewardState(slot9.config.storyId, slot9.config.id, slot9.config.score) == 0 then
			slot4 = slot9

			if recthelper.getWidth(slot0._scrollreward.transform) < (slot9.index - 1) * (slot0.cellWidth + slot0.space) + slot0.startSpace + recthelper.getAnchorX(slot0._gocontent.transform) then
				slot3 = slot9

				break
			end
		end
	end

	if not slot3.config then
		slot3 = slot4
	end

	return slot3
end

function slot0.checkGetReward(slot0)
	slot1 = {}

	if RoleStoryConfig.instance:getRewardList(slot0.storyId) then
		for slot6, slot7 in ipairs(slot2) do
			if RoleStoryModel.instance:getRewardState(slot7.storyId, slot7.id, slot7.score) == 1 then
				table.insert(slot1, slot7.id)
			end
		end
	end

	if #slot1 > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(slot1)
	end
end

function slot0.onClose(slot0)
	slot0._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0.checkGetReward, slot0)
	TaskDispatcher.cancelTask(slot0.refreshTarget, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
