module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTaskView", package.seeall)

slot0 = class("VersionActivity1_5HeroTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._goherotask = gohelper.findChild(slot0.viewGO, "#go_herotask")
	slot0._simagebookbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_herotask/#simage_bookbg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_herotask/Title/#txt_title")
	slot0._imageheroPhoto = gohelper.findChildImage(slot0.viewGO, "#go_herotask/#image_heroPhoto")
	slot0._txtheroDetail = gohelper.findChildText(slot0.viewGO, "#go_herotask/#image_heroPhoto/#scroll_heroDetail/viewprot/#txt_heroDetail")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_herotask/LeftDown/#txt_total")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_herotask/LeftDown/#txt_total/#txt_num")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_herotask/LeftDown/#go_rewarditem")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_hasget")
	slot0._gogainedreward = gohelper.findChild(slot0.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_gainReward")
	slot0._gopointitem = gohelper.findChild(slot0.viewGO, "#go_herotask/LeftDown/progresspoint/#go_pointitem")
	slot0._goTaskList = gohelper.findChild(slot0.viewGO, "#go_herotask/#scroll_task/Viewport/#go_TaskList")
	slot0._scrollTask = gohelper.findChildScrollRect(slot0.viewGO, "#go_herotask/#scroll_task")
	slot0.goNextIcon = gohelper.findChild(slot0.viewGO, "nexticon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onValueChanged(slot0, slot1)
	gohelper.setActive(slot0.goNextIcon, slot0._scrollTask.verticalNormalizedPosition >= 0.01)
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0._goherotask:GetComponent(gohelper.Type_Animator)
	slot0.goSubHeroTaskItem = slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[1])

	gohelper.setActive(slot0._gopointitem, false)

	slot0.gainRewardClick = gohelper.getClickWithAudio(slot0._gogainedreward, AudioEnum.UI.UI_Common_Click)

	slot0.gainRewardClick:AddClickListener(slot0.onClickGainReward, slot0)
	slot0._scrollTask:AddOnValueChanged(slot0.onValueChanged, slot0)

	slot0.progressPointList = {}
	slot0.subHeroTaskItemList = {}

	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, slot0.onSelectHeroTabChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, slot0.onGainedHeroTaskReward, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, slot0.onGainedSubHeroTaskReward, slot0)
end

function slot0.onClickGainReward(slot0)
	if slot0.taskMo.gainedReward then
		return
	end

	if slot0.taskMo:isFinish() then
		VersionActivity1_5DungeonRpc.instance:sendAct139GainHeroTaskRewardRequest(slot0.taskId)
	end
end

function slot0.onSelectHeroTabChange(slot0)
	slot1 = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() ~= VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(slot0._goherotask, slot1)
	gohelper.setActive(slot0.goNextIcon, slot1)

	if not slot1 then
		slot0.taskId = 0

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(true)
	slot0.animator:Play("open", 0, 0)

	slot0._scrollTask.verticalNormalizedPosition = 1

	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.onOpenAnimDone, slot0, 0.667)
end

function slot0.onOpenAnimDone(slot0)
	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(false)
end

function slot0.refreshUI(slot0)
	if slot0.taskId == VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() then
		return
	end

	slot0.taskId = slot1
	slot0.taskMo = VersionActivity1_5RevivalTaskModel.instance:getTaskMo(slot0.taskId)
	slot0.taskCo = slot0.taskMo.config
	slot2 = string.splitToNumber(slot0.taskCo.reward, "#")
	slot0.rewardType = slot2[1]
	slot0.rewardId = slot2[2]
	slot0.rewardQuantity = slot2[3]

	slot0:refreshTitle()

	slot0._txtheroDetail.text = slot0.taskCo.desc

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(slot0._imageheroPhoto, slot0.taskCo.heroIcon)
	slot0:refreshProgress()
	slot0:refreshReward()
	slot0:refreshGainedReward()
	slot0:refreshSubTask()
end

function slot0.refreshTitle(slot0)
	slot1 = string.split(slot0.taskCo.title, "-")
	slot0._txttitle.text = string.format("%s——<color=#C66030>%s</color>", slot1[1], slot1[2])
end

function slot0.refreshProgress(slot0)
	slot1 = slot0.taskMo:getSubTaskCount()
	slot0._txttotal.text = slot1
	slot0._txtnum.text = slot0.taskMo:getSubTaskFinishCount()

	for slot6 = 1, slot1 do
		UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(slot0:getPointItem(slot6).image, slot6 <= slot2 and "v1a5_revival_img_point1_2" or "v1a5_revival_img_point1_1")
	end

	for slot6 = slot1 + 1, #slot0.progressPointList do
		gohelper.setActive(slot0.progressPointList[slot6].go, false)
	end
end

function slot0.refreshReward(slot0)
	if not slot0.icon then
		slot0.icon = IconMgr.instance:getCommonItemIcon(slot0._gorewarditem)
	end

	slot0.icon:setMOValue(slot0.rewardType, slot0.rewardId, slot0.rewardQuantity)
	slot0.icon:setScale(0.6, 0.6, 0.6)
	gohelper.setAsLastSibling(slot0._gogainedreward)
	gohelper.setAsLastSibling(slot0._gohasget)
end

function slot0.refreshGainedReward(slot0)
	gohelper.setActive(slot0._gohasget, slot0.taskMo.gainedReward)

	if not slot0.taskMo:isFinish() then
		gohelper.setActive(slot0._gogainedreward, false)

		return
	end

	gohelper.setActive(slot0._gogainedreward, not slot0.taskMo.gainedReward)
end

function slot0.refreshSubTask(slot0)
	for slot5, slot6 in ipairs(slot0.taskMo:getSubTaskCoList()) do
		slot0:getSubHeroTaskItem(slot5):updateData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.subHeroTaskItemList do
		slot0.subHeroTaskItemList[slot5]:hide()
	end
end

function slot0.getPointItem(slot0, slot1)
	if not slot0.progressPointList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gopointitem)
		slot2.image = slot2.go:GetComponent(gohelper.Type_Image)

		table.insert(slot0.progressPointList, slot2)
	end

	gohelper.setActive(slot2.go, true)

	return slot2
end

function slot0.getSubHeroTaskItem(slot0, slot1)
	if not slot0.subHeroTaskItemList[slot1] then
		table.insert(slot0.subHeroTaskItemList, VersionActivity1_5SubHeroTaskItem.createItem(gohelper.clone(slot0.goSubHeroTaskItem, slot0._goTaskList)))
	end

	slot2:show()

	return slot2
end

function slot0.onGainedHeroTaskReward(slot0, slot1)
	if slot0.taskId ~= slot1 then
		return
	end

	slot0:refreshProgress()
	slot0:refreshGainedReward()
end

function slot0.onGainedSubHeroTaskReward(slot0, slot1)
	slot0:refreshProgress()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.onOpenAnimDone, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.progressPointList = nil

	for slot4, slot5 in ipairs(slot0.subHeroTaskItemList) do
		slot5:destroy()
	end

	slot0.gainRewardClick:RemoveClickListener()
	slot0._scrollTask:RemoveOnValueChanged()

	slot0.subHeroTaskItemList = nil
end

return slot0
