module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTaskView", package.seeall)

local var_0_0 = class("VersionActivity1_5HeroTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goherotask = gohelper.findChild(arg_1_0.viewGO, "#go_herotask")
	arg_1_0._simagebookbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_herotask/#simage_bookbg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_herotask/Title/#txt_title")
	arg_1_0._imageheroPhoto = gohelper.findChildImage(arg_1_0.viewGO, "#go_herotask/#image_heroPhoto")
	arg_1_0._txtheroDetail = gohelper.findChildText(arg_1_0.viewGO, "#go_herotask/#image_heroPhoto/#scroll_heroDetail/viewprot/#txt_heroDetail")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_herotask/LeftDown/#txt_total")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_herotask/LeftDown/#txt_total/#txt_num")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_herotask/LeftDown/#go_rewarditem")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_hasget")
	arg_1_0._gogainedreward = gohelper.findChild(arg_1_0.viewGO, "#go_herotask/LeftDown/#go_rewarditem/#go_gainReward")
	arg_1_0._gopointitem = gohelper.findChild(arg_1_0.viewGO, "#go_herotask/LeftDown/progresspoint/#go_pointitem")
	arg_1_0._goTaskList = gohelper.findChild(arg_1_0.viewGO, "#go_herotask/#scroll_task/Viewport/#go_TaskList")
	arg_1_0._scrollTask = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_herotask/#scroll_task")
	arg_1_0.goNextIcon = gohelper.findChild(arg_1_0.viewGO, "nexticon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onValueChanged(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.goNextIcon, arg_4_0._scrollTask.verticalNormalizedPosition >= 0.01)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.animator = arg_5_0._goherotask:GetComponent(gohelper.Type_Animator)
	arg_5_0.goSubHeroTaskItem = arg_5_0.viewContainer:getRes(arg_5_0.viewContainer:getSetting().otherRes[1])

	gohelper.setActive(arg_5_0._gopointitem, false)

	arg_5_0.gainRewardClick = gohelper.getClickWithAudio(arg_5_0._gogainedreward, AudioEnum.UI.UI_Common_Click)

	arg_5_0.gainRewardClick:AddClickListener(arg_5_0.onClickGainReward, arg_5_0)
	arg_5_0._scrollTask:AddOnValueChanged(arg_5_0.onValueChanged, arg_5_0)

	arg_5_0.progressPointList = {}
	arg_5_0.subHeroTaskItemList = {}

	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, arg_5_0.onSelectHeroTabChange, arg_5_0)
	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedHeroTaskReward, arg_5_0.onGainedHeroTaskReward, arg_5_0)
	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnGainedSubHeroTaskReward, arg_5_0.onGainedSubHeroTaskReward, arg_5_0)
end

function var_0_0.onClickGainReward(arg_6_0)
	if arg_6_0.taskMo.gainedReward then
		return
	end

	if arg_6_0.taskMo:isFinish() then
		VersionActivity1_5DungeonRpc.instance:sendAct139GainHeroTaskRewardRequest(arg_6_0.taskId)
	end
end

function var_0_0.onSelectHeroTabChange(arg_7_0)
	local var_7_0 = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() ~= VersionActivity1_5DungeonEnum.ExploreTaskId

	gohelper.setActive(arg_7_0._goherotask, var_7_0)
	gohelper.setActive(arg_7_0.goNextIcon, var_7_0)

	if not var_7_0 then
		arg_7_0.taskId = 0

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(true)
	arg_7_0.animator:Play("open", 0, 0)

	arg_7_0._scrollTask.verticalNormalizedPosition = 1

	arg_7_0:refreshUI()
	TaskDispatcher.runDelay(arg_7_0.onOpenAnimDone, arg_7_0, 0.667)
end

function var_0_0.onOpenAnimDone(arg_8_0)
	VersionActivity1_5RevivalTaskModel.instance:setIsPlayingOpenAnim(false)
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId()

	if arg_9_0.taskId == var_9_0 then
		return
	end

	arg_9_0.taskId = var_9_0
	arg_9_0.taskMo = VersionActivity1_5RevivalTaskModel.instance:getTaskMo(arg_9_0.taskId)
	arg_9_0.taskCo = arg_9_0.taskMo.config

	local var_9_1 = string.splitToNumber(arg_9_0.taskCo.reward, "#")

	arg_9_0.rewardType = var_9_1[1]
	arg_9_0.rewardId = var_9_1[2]
	arg_9_0.rewardQuantity = var_9_1[3]

	arg_9_0:refreshTitle()

	arg_9_0._txtheroDetail.text = arg_9_0.taskCo.desc

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(arg_9_0._imageheroPhoto, arg_9_0.taskCo.heroIcon)
	arg_9_0:refreshProgress()
	arg_9_0:refreshReward()
	arg_9_0:refreshGainedReward()
	arg_9_0:refreshSubTask()
end

function var_0_0.refreshTitle(arg_10_0)
	local var_10_0 = string.split(arg_10_0.taskCo.title, "-")
	local var_10_1 = var_10_0[1]
	local var_10_2 = var_10_0[2]

	arg_10_0._txttitle.text = string.format("%s——<color=#C66030>%s</color>", var_10_1, var_10_2)
end

function var_0_0.refreshProgress(arg_11_0)
	local var_11_0 = arg_11_0.taskMo:getSubTaskCount()
	local var_11_1 = arg_11_0.taskMo:getSubTaskFinishCount()

	arg_11_0._txttotal.text = var_11_0
	arg_11_0._txtnum.text = var_11_1

	for iter_11_0 = 1, var_11_0 do
		local var_11_2 = arg_11_0:getPointItem(iter_11_0)

		UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(var_11_2.image, iter_11_0 <= var_11_1 and "v1a5_revival_img_point1_2" or "v1a5_revival_img_point1_1")
	end

	for iter_11_1 = var_11_0 + 1, #arg_11_0.progressPointList do
		gohelper.setActive(arg_11_0.progressPointList[iter_11_1].go, false)
	end
end

function var_0_0.refreshReward(arg_12_0)
	if not arg_12_0.icon then
		arg_12_0.icon = IconMgr.instance:getCommonItemIcon(arg_12_0._gorewarditem)
	end

	arg_12_0.icon:setMOValue(arg_12_0.rewardType, arg_12_0.rewardId, arg_12_0.rewardQuantity)
	arg_12_0.icon:setScale(0.6, 0.6, 0.6)
	gohelper.setAsLastSibling(arg_12_0._gogainedreward)
	gohelper.setAsLastSibling(arg_12_0._gohasget)
end

function var_0_0.refreshGainedReward(arg_13_0)
	gohelper.setActive(arg_13_0._gohasget, arg_13_0.taskMo.gainedReward)

	if not arg_13_0.taskMo:isFinish() then
		gohelper.setActive(arg_13_0._gogainedreward, false)

		return
	end

	gohelper.setActive(arg_13_0._gogainedreward, not arg_13_0.taskMo.gainedReward)
end

function var_0_0.refreshSubTask(arg_14_0)
	local var_14_0 = arg_14_0.taskMo:getSubTaskCoList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0:getSubHeroTaskItem(iter_14_0):updateData(iter_14_1)
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_0.subHeroTaskItemList do
		arg_14_0.subHeroTaskItemList[iter_14_2]:hide()
	end
end

function var_0_0.getPointItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.progressPointList[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.cloneInPlace(arg_15_0._gopointitem)
		var_15_0.image = var_15_0.go:GetComponent(gohelper.Type_Image)

		table.insert(arg_15_0.progressPointList, var_15_0)
	end

	gohelper.setActive(var_15_0.go, true)

	return var_15_0
end

function var_0_0.getSubHeroTaskItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.subHeroTaskItemList[arg_16_1]

	if not var_16_0 then
		local var_16_1 = gohelper.clone(arg_16_0.goSubHeroTaskItem, arg_16_0._goTaskList)

		var_16_0 = VersionActivity1_5SubHeroTaskItem.createItem(var_16_1)

		table.insert(arg_16_0.subHeroTaskItemList, var_16_0)
	end

	var_16_0:show()

	return var_16_0
end

function var_0_0.onGainedHeroTaskReward(arg_17_0, arg_17_1)
	if arg_17_0.taskId ~= arg_17_1 then
		return
	end

	arg_17_0:refreshProgress()
	arg_17_0:refreshGainedReward()
end

function var_0_0.onGainedSubHeroTaskReward(arg_18_0, arg_18_1)
	arg_18_0:refreshProgress()
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.onOpenAnimDone, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.progressPointList = nil

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.subHeroTaskItemList) do
		iter_20_1:destroy()
	end

	arg_20_0.gainRewardClick:RemoveClickListener()
	arg_20_0._scrollTask:RemoveOnValueChanged()

	arg_20_0.subHeroTaskItemList = nil
end

return var_0_0
