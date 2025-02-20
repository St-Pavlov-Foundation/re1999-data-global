module("modules.logic.versionactivity2_3.newinsight.view.ActivityInsightShowTaskItem_2_3", package.seeall)

slot0 = class("ActivityInsightShowTaskItem_2_3", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._index = slot2
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._goinfo = gohelper.findChild(slot1, "root/info")
	slot0._txttaskdes = gohelper.findChildText(slot1, "root/info/txt_taskdes")
	slot0._txtprocess = gohelper.findChildText(slot1, "root/info/txt_process")
	slot0._gorewards = gohelper.findChild(slot1, "root/scroll_reward/Viewport/go_rewardContent")
	slot0._gonotget = gohelper.findChild(slot1, "root/go_notget")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot1, "root/go_notget/btn_goto")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot1, "root/go_notget/btn_canget")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot1, "root/go_notget/btn_use")
	slot0._goget = gohelper.findChild(slot1, "root/go_get")

	gohelper.setActive(slot0.go, false)

	slot0._rewardItems = {}

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0._btncanget:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
end

function slot0._btngotoOnClick(slot0)
	if slot0._config.jumpId > 0 then
		GameFacade.jump(slot0._config.jumpId)
	end
end

function slot0._btncangetOnClick(slot0)
	TaskRpc.instance:sendFinishTaskRequest(slot0._config.id)
end

function slot0._btnuseOnClick(slot0)
	slot1 = {
		id = slot0._config.itemId
	}
	slot1.uid = ItemInsightModel.instance:getEarliestExpireInsight(slot1.id).uid

	GiftController.instance:openGiftInsightHeroChoiceView(slot1)
end

function slot0.setTask(slot0, slot1)
	slot0._taskId = slot1

	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0._taskMO = TaskModel.instance:getTaskById(slot0._taskId)

	gohelper.setActive(slot0._goclick, false)
	gohelper.setActive(slot0.go, true)

	slot0._config = Activity172Config.instance:getAct172TaskById(slot0._taskId)
	slot0._txttaskdes.text = slot0._config.desc
	slot0._txtprocess.text = string.format("%s/%s", slot0._taskMO.progress, slot0._config.maxProgress)

	slot0:_refreshTaskRewards()
	slot0:_refreshBtns()
end

function slot0._refreshBtns(slot0)
	gohelper.setActive(slot0._goget, false)
	gohelper.setActive(slot0._gonotget, false)
	gohelper.setActive(slot0._btnuse.gameObject, false)
	gohelper.setActive(slot0._btncanget.gameObject, false)
	gohelper.setActive(slot0._btngoto.gameObject, false)

	if slot0._taskMO.finishCount >= 1 then
		if not ActivityType172Model.instance:isTaskHasUsed(ActivityEnum.Activity.V2a3_NewInsight, slot0._taskId) and slot0._config.itemId ~= 0 then
			gohelper.setActive(slot0._gonotget, true)
			gohelper.setActive(slot0._btnuse.gameObject, true)
		else
			gohelper.setActive(slot0._goget, true)
		end
	elseif slot0._taskMO.hasFinished then
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._btncanget.gameObject, true)
	else
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._btngoto.gameObject, true)
	end
end

function slot0._refreshTaskRewards(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.setActive(slot5.go, false)
	end

	for slot5 = 1, #string.split(slot0._config.bonus, "|") do
		slot6 = string.splitToNumber(slot1[slot5], "#")

		if not slot0._rewardItems[slot5] then
			slot0._rewardItems[slot5] = IconMgr.instance:getCommonPropItemIcon(slot0._gorewards)
		end

		gohelper.setActive(slot0._rewardItems[slot5].go, true)
		slot0._rewardItems[slot5]:setMOValue(slot6[1], slot6[2], slot6[3])
		slot0._rewardItems[slot5]:setScale(0.7)
		slot0._rewardItems[slot5]:setCountFontSize(46)
		slot0._rewardItems[slot5]:setHideLvAndBreakFlag(true)
	end
end

function slot0.destroy(slot0)
	slot0:removeEvents()
end

return slot0
