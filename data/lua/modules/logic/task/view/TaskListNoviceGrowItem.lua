module("modules.logic.task.view.TaskListNoviceGrowItem", package.seeall)

slot0 = class("TaskListNoviceGrowItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.go = slot1
	slot0._index = slot2
	slot0._mo = slot3
	slot0._txttaskdes = gohelper.findChildText(slot0.go, "#txt_taskdes")
	slot0._txttasktitle = gohelper.findChildText(slot0.go, "#txt_taskdes/#txt_title")
	slot0._scrollreward = gohelper.findChild(slot0.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gorewards = gohelper.findChild(slot0.go, "scroll_reward/Viewport/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	slot0._goblackmask = gohelper.findChild(slot0.go, "#go_blackmask")
	slot0._goget = gohelper.findChild(slot0.go, "#go_get")
	slot0._gonotget = gohelper.findChild(slot0.go, "#go_notget")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.go, "#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButton(slot0.go, "#go_notget/#btn_finishbg")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.go, "#simage_roleicon")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.go, "#simage_bg")
	slot0._goclick = gohelper.findChild(slot0.go, "click")
	slot0._simageclickmask = gohelper.findChildSingleImage(slot0.go, "click/getmask")
	slot0._itemAni = slot0.go:GetComponent(typeof(UnityEngine.Animator))

	slot0._simagebg:LoadImage(ResUrl.getTaskBg("bg_youdi2"))
	slot0._simageclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	slot0._rewardItems = {}

	slot0:addEvents()
	slot0:_refreshItem()

	if slot4 then
		slot0._itemAni:Play(UIAnimationName.Open)
	else
		slot0._itemAni:Play(UIAnimationName.Idle)
	end

	slot0._scrollreward.parentGameObject = slot5
end

function slot0.reset(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._mo = slot2

	slot0:_refreshItem()
	slot0._itemAni:Play(UIAnimationName.Idle)
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
end

function slot0._btnnotfinishbgOnClick(slot0)
	if slot0._mo.config.jumpId ~= 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem)
		GameFacade.jump(slot1)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(slot0._goclick, true)
	slot0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")

	slot1 = TaskConfig.instance:gettaskNoviceConfig(slot0._mo.id).activity

	for slot7 = 1, #TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice) do
		if slot2[slot7].config.minTypeId == TaskEnum.TaskMinType.GrowBack and slot2[slot7].finishCount < slot2[slot7].config.maxFinishCount then
			slot3 = 0 + 1
		end
	end

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, {
		num = slot1,
		taskType = TaskEnum.TaskType.Novice,
		force = false,
		growCount = slot3
	})
	TaskDispatcher.runDelay(slot0._onPlayActAniFinished, slot0, 0.76)
end

function slot0._onPlayActAniFinished(slot0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
	slot0:destroy()
end

function slot0.getTaskId(slot0)
	return slot0._mo.id
end

function slot0.hasFinished(slot0)
	return slot0._mo.config.maxFinishCount <= slot0._mo.finishCount
end

function slot0.getTaskMinType(slot0)
	return TaskEnum.TaskMinType.GrowBack
end

function slot0._refreshItem(slot0)
	slot0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(HeroConfig.instance:getHeroCO(tonumber(slot0._mo.config.listenerParam)).skinId))

	slot0._txttaskdes.text = slot0._mo.config.desc
	slot0._txttasktitle.text = slot0._mo.config.listenerType == "HeroRank" and luaLang("taskitem_growtask2") or luaLang("taskitem_growtask1")

	for slot5, slot6 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot6.itemIcon.go)
		gohelper.destroy(slot6.parentGo)
		slot6.itemIcon:onDestroy()
	end

	slot0._rewardItems = {}
	slot0._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #string.split(slot0._mo.config.bonus, "|") > 3

	for slot6 = 1, #slot2 do
		slot7 = {
			parentGo = gohelper.cloneInPlace(slot0._gorewarditem)
		}

		gohelper.setActive(slot7.parentGo, true)

		slot8 = string.splitToNumber(slot2[slot6], "#")
		slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.parentGo)

		slot7.itemIcon:setMOValue(slot8[1], slot8[2], slot8[3], nil, true)
		slot7.itemIcon:isShowCount(slot8[1] ~= MaterialEnum.MaterialType.Hero)
		slot7.itemIcon:setCountFontSize(47)
		slot7.itemIcon:showStackableNum2()
		slot7.itemIcon:setHideLvAndBreakFlag(true)
		slot7.itemIcon:hideEquipLvAndBreak(true)
		table.insert(slot0._rewardItems, slot7)
	end

	if slot0._mo.config.maxFinishCount <= slot0._mo.finishCount then
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._goget, true)
		gohelper.setActive(slot0._gonotget, false)
		gohelper.setActive(slot0._goblackmask.gameObject, true)
	elseif slot0._mo.hasFinished then
		gohelper.setActive(slot0._btnfinishbg.gameObject, true)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._goblackmask.gameObject, false)
	else
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, slot0._mo.config.jumpId ~= 0)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._goblackmask.gameObject, false)
	end
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayClickFinished, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)

	if slot0.go then
		gohelper.destroy(slot0.go)

		slot0.go = nil
	end

	slot0:removeEvents()
	slot0._simagebg:UnLoadImage()
	slot0._simageroleicon:UnLoadImage()
	slot0._simageclickmask:UnLoadImage()

	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = nil
end

return slot0
