module("modules.logic.survival.view.shelter.ShelterTaskNormalTaskView", package.seeall)

local var_0_0 = class("ShelterTaskNormalTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.rewardItemGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewarditem")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_normal")
	arg_1_0.itemList = {}
	arg_1_0.taskType = SurvivalEnum.TaskModule.NormalTask
	arg_1_0.itemGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_normal/#go_normalitem")

	gohelper.setActive(arg_1_0.itemGO, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnFollowTaskUpdate, arg_2_0.refreshTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_3_0.refreshView, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnFollowTaskUpdate, arg_3_0.refreshTask, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.refreshView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 == arg_5_0.taskType or arg_5_1 == SurvivalEnum.TaskModule.MapMainTarget

	arg_5_0:setTaskVisible(var_5_0)
end

function var_0_0.setTaskVisible(arg_6_0, arg_6_1)
	if arg_6_0._isVisible == arg_6_1 then
		if arg_6_1 then
			arg_6_0:refreshTask()
		end

		return
	end

	arg_6_0._isVisible = arg_6_1

	if arg_6_1 then
		arg_6_0:refreshTask()

		if not arg_6_0.animComp then
			arg_6_0.animComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0.goNormal, SurvivalItemListAnimComp)
		end

		arg_6_0.animComp:playListOpenAnim(arg_6_0.itemList, 0.06)
	else
		gohelper.setActive(arg_6_0.goNormal, false)
	end
end

function var_0_0.refreshTask(arg_7_0)
	local var_7_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.NormalTask)
	local var_7_1 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MapMainTarget)
	local var_7_2 = #var_7_0 + #var_7_1

	for iter_7_0 = 1, math.max(var_7_2, #arg_7_0.itemList) do
		local var_7_3 = arg_7_0:getItem(iter_7_0)

		arg_7_0:updateItem(var_7_3, var_7_0[iter_7_0] or var_7_1[iter_7_0 - #var_7_0])
	end

	gohelper.setActive(arg_7_0.goNormal, var_7_2 > 0)
end

function var_0_0.getItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.itemList[arg_8_1]

	if not var_8_0 then
		var_8_0 = arg_8_0:createItem(arg_8_1, arg_8_0.goNormal)
		arg_8_0.itemList[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.index = arg_9_1
	var_9_0.go = gohelper.clone(arg_9_0.itemGO, arg_9_2, tostring(arg_9_1))
	var_9_0.goFinished = gohelper.findChild(var_9_0.go, "finished")
	var_9_0.txtDesc = gohelper.findChildTextMesh(var_9_0.go, "scroll_desc/viewport/#txt_desc")
	var_9_0.txtTitle = gohelper.findChildTextMesh(var_9_0.go, "#txt_title")
	var_9_0.simageHero = gohelper.findChildSingleImage(var_9_0.go, "role/#simage_hero")
	var_9_0.goItem = gohelper.findChild(var_9_0.go, "#scroll_Reward/Viewport/Content")
	var_9_0.btnSelect = gohelper.findChildButtonWithAudio(var_9_0.go, "#btn_select")
	var_9_0.goSelect = gohelper.findChild(var_9_0.go, "#go_select")
	var_9_0.anim = var_9_0.go:GetComponent(gohelper.Type_Animator)
	var_9_0.rewardList = {}

	return var_9_0
end

function var_0_0.updateItem(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_1.go, arg_10_2 ~= nil)

	if not arg_10_2 then
		return
	end

	local var_10_0 = not arg_10_2:isUnFinish()

	gohelper.setActive(arg_10_1.goFinished, var_10_0)

	arg_10_1.txtTitle.text = arg_10_2:getName()
	arg_10_1.txtDesc.text = arg_10_2:getDesc()

	arg_10_1.simageHero:LoadImage(ResUrl.getSurvivalNpcIcon(arg_10_2.co.icon))
	arg_10_0:removeClickCb(arg_10_1.btnSelect)
	arg_10_0:addClickCb(arg_10_1.btnSelect, arg_10_0.onClickSelect, arg_10_0, arg_10_2)
	gohelper.setActive(arg_10_1.goSelect, arg_10_0:isFollowTask(arg_10_2))
	arg_10_0:refreshItemReward(arg_10_1, arg_10_2.co, arg_10_1.goItem)
end

function var_0_0.refreshItemReward(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = GameUtil.splitString2(arg_11_2.dropShow, true, "&", ":")
	local var_11_1 = var_11_0 and #var_11_0 or 0

	for iter_11_0 = 1, math.max(var_11_1, #arg_11_1.rewardList) do
		local var_11_2 = arg_11_0:getRewardItem(arg_11_1, iter_11_0, arg_11_3)

		arg_11_0:refreshRewardItem(var_11_2, var_11_0[iter_11_0])
	end
end

function var_0_0.refreshRewardItem(arg_12_0, arg_12_1, arg_12_2)
	gohelper.setActive(arg_12_1.go, arg_12_2 ~= nil)

	if not arg_12_2 then
		return
	end

	local var_12_0 = arg_12_2[1]
	local var_12_1 = arg_12_2[2]

	gohelper.setActive(arg_12_1.goCanget, false)
	gohelper.setActive(arg_12_1.goReceive, false)

	if not arg_12_1.itemIcon then
		local var_12_2 = arg_12_0:getIconInstance(arg_12_1.goIcon)

		arg_12_1.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_2, SurvivalBagItem)

		arg_12_1.itemIcon:setClickCallback(arg_12_0.onClicRewardItem, arg_12_0)
	end

	arg_12_1.itemIcon._rewardItem = arg_12_1

	arg_12_1.itemIcon:updateByItemId(var_12_0, var_12_1)
	arg_12_1.itemIcon:setItemSize(137.6, 137.6)
end

function var_0_0.onClicRewardItem(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = arg_13_1._mo
	})
end

function var_0_0.getIconInstance(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.viewContainer:getSetting().otherRes.itemRes

	return arg_14_0.viewContainer:getResInst(var_14_0, arg_14_1, "itemIcon")
end

function var_0_0.getRewardItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1.rewardList[arg_15_2]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.clone(arg_15_0.rewardItemGO, arg_15_3, tostring(arg_15_2))
		var_15_0.goIcon = gohelper.findChild(var_15_0.go, "go_icon")
		var_15_0.goCanget = gohelper.findChild(var_15_0.go, "go_canget")
		var_15_0.goReceive = gohelper.findChild(var_15_0.go, "go_receive")
		arg_15_1.rewardList[arg_15_2] = var_15_0
	else
		gohelper.addChild(arg_15_3, var_15_0.go)
	end

	var_15_0.parentItem = arg_15_1

	return var_15_0
end

function var_0_0.onClickSelect(arg_16_0, arg_16_1)
	if not arg_16_1:isUnFinish() then
		return
	end

	if arg_16_1.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		return
	end

	SurvivalInteriorRpc.instance:sendSurvivalTaskFollowRequest(arg_16_1.moduleId, arg_16_1.id, not arg_16_0:isFollowTask(arg_16_1))
end

function var_0_0.isFollowTask(arg_17_0, arg_17_1)
	if arg_17_1.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		return true
	end

	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_17_1 = false

	if var_17_0.inSurvival then
		var_17_1 = SurvivalMapModel.instance:getSceneMo().followTask.taskId == arg_17_1.co.id
	end

	return var_17_1
end

function var_0_0.onClose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.itemList) do
		iter_18_1.simageHero:UnLoadImage()
	end
end

return var_0_0
