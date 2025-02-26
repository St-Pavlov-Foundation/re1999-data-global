module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryView", package.seeall)

slot0 = class("RoleStoryDispatchStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0.itemList = {}
	slot0.goDispatchScroll = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch")
	slot0.goDispatch = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_RolestoryDispatch")
	slot0.content = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	slot0.dispatchType = RoleStoryEnum.DispatchType.Story
	slot0.btnScore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_scorereward")
	slot0.txtScore = gohelper.findChildTextMesh(slot0.viewGO, "#btn_scorereward/score/#txt_score")
	slot0.goScoreRed = gohelper.findChild(slot0.viewGO, "#btn_scorereward/#go_rewardredpoint")
	slot0.scoreAnim = gohelper.findChildComponent(slot0.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnScore, slot0.onClickBtnScore, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, slot0._onUpdateInfo, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryDispatchUnlock, slot0._onStoryDispatchUnlock, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnScore(slot0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function slot0._onDispatchStateChange(slot0)
	slot0:refreshView()
end

function slot0._onUpdateInfo(slot0)
	slot0:refreshScore()
	slot0:refreshView()
end

function slot0._onScoreUpdate(slot0)
	slot0:refreshScore()
end

function slot0._onStoryChange(slot0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function slot0.onOpen(slot0)
	slot0.storyId = slot0.viewParam.storyId

	if not slot0.storyId then
		slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	end

	slot0:refreshScore()
	slot0:refreshView()
	TaskDispatcher.runDelay(slot0.delayShow, slot0, 0.05)
end

function slot0.delayShow(slot0)
	if not RoleStoryModel.instance:getById(slot0.storyId) then
		return
	end

	if #slot1:getNormalDispatchList() == 0 then
		slot3 = nil

		for slot7, slot8 in ipairs(slot0.itemList) do
			if slot8.data and RoleStoryEnum.DispatchState.Canget == slot1:getDispatchState(slot8.data.id) then
				slot3 = slot8

				break
			end
		end

		if not slot3 then
			for slot7, slot8 in ipairs(slot0.itemList) do
				if slot8.data and RoleStoryEnum.DispatchState.Normal == slot1:getDispatchState(slot8.data.id) then
					slot3 = slot8

					break
				end
			end
		end

		if slot3 then
			slot5 = slot0.content.transform

			recthelper.setAnchorX(slot5, -math.min(recthelper.getAnchorX(slot3.viewGO.transform.parent) - 37, math.max(recthelper.getWidth(slot5) + 92 - recthelper.getWidth(slot5.parent), 0)))
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0.storyId = slot0.viewParam.storyId

	slot0:refreshScore()
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot1 = RoleStoryConfig.instance:getDispatchList(slot0.storyId, slot0.dispatchType) or {}
	slot5 = #slot0.itemList

	for slot5 = 1, math.max(#slot1, slot5) do
		slot0:refreshDispatchItem(slot0.itemList[slot5], slot1[slot5], slot5)
	end
end

function slot0.refreshDispatchItem(slot0, slot1, slot2, slot3)
	(slot1 or slot0:createItem(slot3)):onUpdateMO(slot2, slot3)
end

function slot0.createItem(slot0, slot1)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.storyItemRes, gohelper.findChild(slot0.goDispatch, string.format("Item/#go_item%s", slot1)), "go"), RoleStoryDispatchStoryItem)
	slot5.scrollDesc.parentGameObject = slot0.goDispatchScroll
	slot0.itemList[slot1] = slot5

	return slot5
end

function slot0.refreshScore(slot0)
	slot0.txtScore.text = RoleStoryModel.instance:getById(slot0.storyId) and slot2:getScore() or 0
	slot4 = slot2 and slot2:hasScoreReward()

	gohelper.setActive(slot0.goScoreRed, slot4)

	if slot4 then
		slot0.scoreAnim:Play("loop")
	else
		slot0.scoreAnim:Play("idle")
	end
end

function slot0._onStoryDispatchUnlock(slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAudio, slot0)
	TaskDispatcher.runDelay(slot0.playUnlockAudio, slot0, 0.05)
end

function slot0.playUnlockAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_unlock)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAudio, slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
end

return slot0
