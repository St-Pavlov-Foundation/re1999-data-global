module("modules.logic.survival.view.shelter.ShelterTaskStoryTaskView", package.seeall)

local var_0_0 = class("ShelterTaskStoryTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goStory = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_npc")
	arg_1_0.itemList = {}
	arg_1_0.taskType = SurvivalEnum.TaskModule.StoryTask
	arg_1_0.itemGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_npc/#go_npcitem")

	gohelper.setActive(arg_1_0.itemGO, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_3_0.refreshView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.refreshView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 == arg_5_0.taskType

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
			arg_6_0.animComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0.goStory, SurvivalItemListAnimComp)
		end

		arg_6_0.animComp:playListOpenAnim(arg_6_0.itemList, 0.06)
	else
		gohelper.setActive(arg_6_0.goStory, false)
	end
end

function var_0_0.refreshTask(arg_7_0)
	local var_7_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.StoryTask)
	local var_7_1 = #var_7_0

	for iter_7_0 = 1, math.max(var_7_1, #arg_7_0.itemList) do
		local var_7_2 = arg_7_0:getItem(iter_7_0)

		arg_7_0:updateItem(var_7_2, var_7_0[iter_7_0])
	end

	gohelper.setActive(arg_7_0.goStory, var_7_1 > 0)
end

function var_0_0.getItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.itemList[arg_8_1]

	if not var_8_0 then
		var_8_0 = arg_8_0:createItem(arg_8_1, arg_8_0.goStory)
		arg_8_0.itemList[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.createItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.index = arg_9_1
	var_9_0.go = gohelper.clone(arg_9_0.itemGO, arg_9_2, tostring(arg_9_1))
	var_9_0.goFinished = gohelper.findChild(var_9_0.go, "finished")
	var_9_0.txtFinishedDesc = gohelper.findChildTextMesh(var_9_0.goFinished, "#txt_task")
	var_9_0.goUnfinish = gohelper.findChild(var_9_0.go, "unfinish")
	var_9_0.txtUnFinishDesc = gohelper.findChildTextMesh(var_9_0.goUnfinish, "#txt_task")
	var_9_0.goFinishing = gohelper.findChild(var_9_0.go, "finishing")
	var_9_0.txtFinishingDesc = gohelper.findChildTextMesh(var_9_0.goFinishing, "#txt_task")
	var_9_0.anim = var_9_0.go:GetComponent(gohelper.Type_Animator)

	return var_9_0
end

function var_0_0.updateItem(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_1.go, arg_10_2 ~= nil)

	if not arg_10_2 then
		return
	end

	local var_10_0 = not arg_10_2:isUnFinish()
	local var_10_1 = arg_10_2:isFail()

	gohelper.setActive(arg_10_1.goFinished, var_10_0 and not var_10_1)
	gohelper.setActive(arg_10_1.goUnfinish, not var_10_0)
	gohelper.setActive(arg_10_1.goFinishing, var_10_0 and var_10_1)

	local var_10_2 = arg_10_2.co

	if var_10_0 then
		if var_10_1 then
			arg_10_1.txtFinishingDesc.text = var_10_2 and var_10_2.desc3 or ""
		else
			arg_10_1.txtFinishedDesc.text = var_10_2 and var_10_2.desc2 or ""
		end
	else
		arg_10_1.txtUnFinishDesc.text = var_10_2 and var_10_2.desc or ""
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

return var_0_0
