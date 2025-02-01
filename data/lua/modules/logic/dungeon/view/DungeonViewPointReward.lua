module("modules.logic.dungeon.view.DungeonViewPointReward", package.seeall)

slot0 = class("DungeonViewPointReward", BaseView)

function slot0.onInitView(slot0)
	slot0._btntipreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_story/#btn_tipreward")
	slot0._txtrewardprogress = gohelper.findChildText(slot0.viewGO, "#go_story/#btn_tipreward/#txt_rewardprogress")
	slot0._gorewardredpoint = gohelper.findChild(slot0.viewGO, "#go_story/#btn_tipreward/#go_rewardredpoint")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntipreward:AddClickListener(slot0._btntiprewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntipreward:RemoveClickListener()
end

function slot0._btntiprewardOnClick(slot0)
	DungeonController.instance:openDungeonCumulativeRewardsView()
end

function slot0._editableInitView(slot0)
	slot0._animTipsReward = slot0._btntipreward.gameObject:GetComponent(typeof(UnityEngine.Animation))

	slot0:_updateMapTip()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, slot0._updateMapTip, slot0)
end

function slot0.onOpenFinish(slot0)
end

function slot0.onClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, slot0._updateMapTip, slot0)
	TaskDispatcher.cancelTask(slot0._refreshProgress, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1, slot2)
	if slot1 == ViewName.DungeonMapView then
		slot0:_updateMapTip()
	end
end

function slot0._isShowBtnGift(slot0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function slot0._updateMapTip(slot0)
	TaskDispatcher.cancelTask(slot0._refreshProgress, slot0)
	TaskDispatcher.runDelay(slot0._refreshProgress, slot0, 0)
end

function slot0._refreshProgress(slot0)
	slot1 = slot0:_isShowBtnGift()

	gohelper.setActive(slot0._btntipreward.gameObject, slot1)

	if not slot1 then
		return
	end

	slot0._maxChapterId = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId

	if DungeonMapModel.instance:canGetRewardsList(slot0._maxChapterId) and #slot3 > 0 then
		slot0._animTipsReward:Play("btn_tipreward_loop")
		gohelper.setActive(slot0._gorewardredpoint, true)
	else
		slot0._animTipsReward:Play("btn_tipreward")
		gohelper.setActive(slot0._gorewardredpoint, false)
	end

	slot0._txtrewardprogress.text = string.format("%s/%s", DungeonMapModel.instance:getRewardPointInfo().rewardPoint, DungeonMapModel.instance:getUnfinishedTargetReward().rewardPointNum)
end

function slot0.onDestroyView(slot0)
end

return slot0
