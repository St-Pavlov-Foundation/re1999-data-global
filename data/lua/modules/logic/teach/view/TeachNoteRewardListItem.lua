module("modules.logic.teach.view.TeachNoteRewardListItem", package.seeall)

slot0 = class("TeachNoteRewardListItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0._txtDesc = gohelper.findChildText(slot1, "right/#txt_des")
	slot0._gopoint = gohelper.findChild(slot1, "right/#go_process/#go_point")
	slot0._gorewarditem = gohelper.findChild(slot1, "right/#go_reward/#go_rewarditem")
	slot0._gofinish = gohelper.findChild(slot1, "#go_finish")
	slot0._golock = gohelper.findChild(slot1, "#go_lock")
	slot0._goreceive = gohelper.findChild(slot1, "#go_receive")
	slot0._goreceivebg = gohelper.findChild(slot1, "#go_receive/receivebg")
	slot0._goreward = gohelper.findChild(slot1, "right/#go_reward")
	slot0._txtrewardcount = gohelper.findChildText(slot1, "right/#go_reward/rewardcountbg/#txt_rewardcount")
	slot0._txtindex = gohelper.findChildText(slot1, "right/#txt_index")
	slot0._rewardClick = gohelper.getClick(slot0._goreceive.gameObject)
	slot0._rewardCanvasGroup = slot0._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._processItems = slot0:getUserDataTb_()
end

function slot0.addEventListeners(slot0)
	slot0._rewardClick:AddClickListener(slot0._onRewardClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._rewardClick:RemoveClickListener()
end

function slot0._onRewardClick(slot0)
	if TeachNoteModel.instance:isRewardCouldGet(slot0._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_act)
		DungeonRpc.instance:sendInstructionDungeonRewardRequest(slot0._mo.id)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	if slot0._processItems then
		for slot4, slot5 in pairs(slot0._processItems) do
			gohelper.setActive(slot5.go, false)
		end
	end

	slot0._txtDesc.text = DungeonConfig.instance:getChapterCO(slot0._mo.chapterId).name
	slot0._txtindex.text = "NO." .. slot0._index
	slot2 = TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(slot0._mo.id)

	for slot7 = 1, TeachNoteModel.instance:getTeachNoteTopicLevelCount(slot0._mo.id) do
		if not slot0._processItems[slot7] then
			slot0._processItems[slot7] = {
				go = gohelper.cloneInPlace(slot0._gopoint, "point" .. slot7)
			}
			slot0._processItems[slot7].gofinish = gohelper.findChild(slot0._processItems[slot7].go, "finish")
			slot0._processItems[slot7].gounfinish = gohelper.findChild(slot0._processItems[slot7].go, "unfinish")
		end

		gohelper.setActive(slot0._processItems[slot7].go, true)
		gohelper.setActive(slot0._processItems[slot7].gofinish, slot7 <= slot2)
		gohelper.setActive(slot0._processItems[slot7].gounfinish, slot2 < slot7)
	end

	gohelper.setActive(slot0._goreceive, TeachNoteModel.instance:isRewardCouldGet(slot0._mo.id))
	gohelper.setActive(slot0._gofinish, TeachNoteModel.instance:isTopicRewardGet(slot0._mo.id))
	gohelper.setActive(slot0._golock, not TeachNoteModel.instance:isTopicUnlock(slot0._mo.id))
	gohelper.setActive(slot0._txtDesc.gameObject, TeachNoteModel.instance:isTopicUnlock(slot0._mo.id))

	slot0._rewardCanvasGroup.alpha = TeachNoteModel.instance:isTopicUnlock(slot0._mo.id) and 1 or 0.5
	slot4 = string.splitToNumber(TeachNoteConfig.instance:getInstructionTopicCO(slot0._mo.id).bonus, "#")

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._gorewarditem)
	end

	slot0._itemIcon:setMOValue(slot4[1], slot4[2], slot4[3])
	slot0._itemIcon:isShowEffect(false)
	slot0._itemIcon:isShowCount(false)
	slot0._itemIcon:isShowQuality(false)

	slot0._txtrewardcount.text = slot4[3]
end

function slot0.onDestroyView(slot0)
	if slot0._processItems then
		slot0._processItems = {}
	end

	if slot0._itemIcon then
		slot0._itemIcon:onDestroy()
	end
end

return slot0
