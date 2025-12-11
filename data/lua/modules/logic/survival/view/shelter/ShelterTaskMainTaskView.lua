module("modules.logic.survival.view.shelter.ShelterTaskMainTaskView", package.seeall)

local var_0_0 = class("ShelterTaskMainTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.mainGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main")
	arg_1_0.itemGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_mainitem")
	arg_1_0.rewardItemGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewarditem")

	gohelper.setActive(arg_1_0.itemGO, false)
	gohelper.setActive(arg_1_0.rewardItemGO, false)

	arg_1_0.mainItemList = {}
	arg_1_0.subItemList = {}
	arg_1_0.taskType = SurvivalEnum.TaskModule.MainTask
	arg_1_0.subGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_sub")
	arg_1_0.collectionGO = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection")
	arg_1_0.txtCollection = gohelper.findChildTextMesh(arg_1_0.collectionGO, "#txt_collection")
	arg_1_0.simageCollection = gohelper.findChildSingleImage(arg_1_0.collectionGO, "layout/collection")
	arg_1_0.txtChoice = gohelper.findChildTextMesh(arg_1_0.collectionGO, "layout/#txt_choice")
	arg_1_0.txtBase = gohelper.findChildTextMesh(arg_1_0.collectionGO, "#txt_base")
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
			arg_6_0:refreshMainTask()
			arg_6_0:refreshSubTask()
			arg_6_0:refreshTalent()
		end

		return
	end

	arg_6_0._isVisible = arg_6_1

	gohelper.setActive(arg_6_0.mainGO, false)
	gohelper.setActive(arg_6_0.subGO, false)
	gohelper.setActive(arg_6_0.collectionGO, false)

	if arg_6_1 then
		if not arg_6_0.popupFlow then
			arg_6_0.popupFlow = FlowSequence.New()

			local var_6_0 = 0.06
			local var_6_1 = {
				time = var_6_0,
				callback = arg_6_0.refreshMainTask,
				callbackObj = arg_6_0
			}

			arg_6_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_6_1))

			local var_6_2 = {
				time = var_6_0,
				callback = arg_6_0.refreshSubTask,
				callbackObj = arg_6_0
			}

			arg_6_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_6_2))

			local var_6_3 = {
				time = var_6_0,
				callback = arg_6_0.refreshTalent,
				callbackObj = arg_6_0
			}

			arg_6_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_6_3))
		end

		arg_6_0.popupFlow:start()
	elseif arg_6_0.popupFlow then
		arg_6_0.popupFlow:stop()
	end
end

function var_0_0.refreshMainTask(arg_7_0)
	local var_7_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.MainTask)
	local var_7_1 = #var_7_0

	for iter_7_0 = 1, math.max(var_7_1, #arg_7_0.mainItemList) do
		local var_7_2 = arg_7_0:getMainItem(iter_7_0)

		arg_7_0:updateItem(var_7_2, var_7_0[iter_7_0])
	end

	gohelper.setActive(arg_7_0.mainGO, var_7_1 > 0)
end

function var_0_0.refreshSubTask(arg_8_0)
	local var_8_0 = SurvivalTaskModel.instance:getTaskList(SurvivalEnum.TaskModule.SubTask)
	local var_8_1 = #var_8_0

	for iter_8_0 = 1, math.max(var_8_1, #arg_8_0.subItemList) do
		local var_8_2 = arg_8_0:getSubItem(iter_8_0)

		arg_8_0:updateItem(var_8_2, var_8_0[iter_8_0])
	end

	gohelper.setActive(arg_8_0.subGO, var_8_1 > 0)
end

function var_0_0.getMainItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.mainItemList[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:createItem(arg_9_1, arg_9_0.mainGO)
		arg_9_0.mainItemList[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.getSubItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.subItemList[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:createItem(arg_10_1, arg_10_0.subGO)
		arg_10_0.subItemList[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.createItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.index = arg_11_1
	var_11_0.go = gohelper.clone(arg_11_0.itemGO, arg_11_2, tostring(arg_11_1))
	var_11_0.goFinishing = gohelper.findChild(var_11_0.go, "finishing")
	var_11_0.goFinishingBg = gohelper.findChild(var_11_0.goFinishing, "bg")
	var_11_0.txtFinishingDesc = gohelper.findChildTextMesh(var_11_0.goFinishing, "#txt_task")
	var_11_0.goFinishingRewardContent = gohelper.findChild(var_11_0.goFinishing, "#scroll_Reward/Viewport/Content")
	var_11_0.goFinished = gohelper.findChild(var_11_0.go, "finished")
	var_11_0.txtFinishedNum = gohelper.findChildTextMesh(var_11_0.goFinished, "#txt_num")
	var_11_0.txtFinishedDesc = gohelper.findChildTextMesh(var_11_0.goFinished, "#txt_task")
	var_11_0.goFinishedRewardContent = gohelper.findChild(var_11_0.goFinished, "#scroll_Reward/Viewport/Content")
	var_11_0.goUnfinish = gohelper.findChild(var_11_0.go, "unfinish")
	var_11_0.goUnfinishBg = gohelper.findChild(var_11_0.goUnfinish, "bg")
	var_11_0.txtUnFinishNum = gohelper.findChildTextMesh(var_11_0.goUnfinish, "#txt_num")
	var_11_0.txtUnFinishDesc = gohelper.findChildTextMesh(var_11_0.goUnfinish, "#txt_task")
	var_11_0.goUnfinishRewardContent = gohelper.findChild(var_11_0.goUnfinish, "#scroll_Reward/Viewport/Content")
	var_11_0.anim = var_11_0.go:GetComponent(typeof(UnityEngine.Animator))
	var_11_0.rewardList = {}

	return var_11_0
end

function var_0_0.getRewardItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1.rewardList[arg_12_2]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.go = gohelper.clone(arg_12_0.rewardItemGO, arg_12_3, tostring(arg_12_2))
		var_12_0.goIcon = gohelper.findChild(var_12_0.go, "go_icon")
		var_12_0.goCanget = gohelper.findChild(var_12_0.go, "go_canget")
		var_12_0.goReceive = gohelper.findChild(var_12_0.go, "go_receive")
		arg_12_1.rewardList[arg_12_2] = var_12_0
	else
		gohelper.addChild(arg_12_3, var_12_0.go)
	end

	var_12_0.parentItem = arg_12_1

	return var_12_0
end

function var_0_0.updateItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1.taskMo = arg_13_2

	gohelper.setActive(arg_13_1.go, arg_13_2 ~= nil)

	if not arg_13_2 then
		return
	end

	if arg_13_0.playRewardTaskId == arg_13_2.id then
		arg_13_0.playRewardTaskId = nil

		arg_13_0:playItemFinishAnim(arg_13_1)

		return
	end

	local var_13_0 = arg_13_2.moduleId == SurvivalEnum.TaskModule.MainTask
	local var_13_1 = arg_13_2:isFinish()

	if var_13_0 then
		var_13_1 = not arg_13_2:isUnFinish()
	end

	gohelper.setActive(arg_13_1.goFinished, var_13_1)
	gohelper.setActive(arg_13_1.goFinishing, var_13_0 and not var_13_1)
	gohelper.setActive(arg_13_1.goUnfinish, not var_13_0 and not var_13_1)

	local var_13_2

	if var_13_1 then
		arg_13_1.txtFinishedNum.text = tostring(arg_13_1.index)
		arg_13_1.txtFinishedDesc.text = arg_13_2:getDesc()
		var_13_2 = arg_13_1.goFinishedRewardContent
	elseif var_13_0 then
		gohelper.setActive(arg_13_1.goFinishingBg, arg_13_1.index == 1)

		arg_13_1.txtFinishingDesc.text = arg_13_2:getDesc()
		var_13_2 = arg_13_1.goFinishingRewardContent
	else
		gohelper.setActive(arg_13_1.goUnfinishBg, arg_13_1.index == 1)

		arg_13_1.txtUnFinishNum.text = tostring(arg_13_1.index)
		arg_13_1.txtUnFinishDesc.text = arg_13_2:getDesc()
		var_13_2 = arg_13_1.goUnfinishRewardContent
	end

	arg_13_0:refreshItemReward(arg_13_1, arg_13_2.co, var_13_2, arg_13_2.status)
end

function var_0_0.refreshItemReward(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = GameUtil.splitString2(arg_14_2.dropShow, true, "&", ":")
	local var_14_1 = var_14_0 and #var_14_0 or 0

	for iter_14_0 = 1, math.max(var_14_1, #arg_14_1.rewardList) do
		local var_14_2 = arg_14_0:getRewardItem(arg_14_1, iter_14_0, arg_14_3)

		arg_14_0:refreshRewardItem(var_14_2, var_14_0[iter_14_0], arg_14_4)
	end
end

function var_0_0.refreshRewardItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.setActive(arg_15_1.go, arg_15_2 ~= nil)

	if not arg_15_2 then
		return
	end

	local var_15_0 = arg_15_2[1]
	local var_15_1 = arg_15_2[2]

	gohelper.setActive(arg_15_1.goCanget, arg_15_3 == SurvivalEnum.TaskStatus.Done)
	gohelper.setActive(arg_15_1.goReceive, arg_15_3 == SurvivalEnum.TaskStatus.Finish)

	if not arg_15_1.itemIcon then
		local var_15_2 = arg_15_0:getIconInstance(arg_15_1.goIcon)

		arg_15_1.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, SurvivalBagItem)

		arg_15_1.itemIcon:setClickCallback(arg_15_0.onClicRewardItem, arg_15_0)
	end

	arg_15_1.itemIcon._rewardItem = arg_15_1

	arg_15_1.itemIcon:updateByItemId(var_15_0, var_15_1)
	arg_15_1.itemIcon:setItemSize(100, 100)
end

function var_0_0.getIconInstance(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes.itemRes

	return arg_16_0.viewContainer:getResInst(var_16_0, arg_16_1, "itemIcon")
end

function var_0_0.refreshTalent(arg_17_0)
	gohelper.setActive(arg_17_0.collectionGO, false)
end

function var_0_0.onClicRewardItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1._rewardItem

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0.parentItem

	if not var_18_1 then
		return
	end

	local var_18_2 = var_18_1.taskMo

	if not var_18_2 then
		return
	end

	if var_18_2:isCangetReward() then
		PopupController.instance:setPause(arg_18_0.viewName, true)

		arg_18_0.playRewardTaskId = var_18_2.id

		SurvivalWeekRpc.instance:sendSurvivalReceiveTaskRewardRequest(var_18_2.moduleId, var_18_2.id)
	else
		ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
			itemMo = arg_18_1._mo
		})
	end
end

function var_0_0.refreshAnimItem(arg_19_0)
	if arg_19_0._animItem then
		arg_19_0:updateItem(arg_19_0._animItem, arg_19_0._animItem.taskMo)

		arg_19_0._animItem = nil
	end

	PopupController.instance:setPause(arg_19_0.viewName, false)
end

function var_0_0.playItemFinishAnim(arg_20_0, arg_20_1)
	arg_20_1.anim:Play("finished", 0, 0)

	arg_20_0._animItem = arg_20_1

	TaskDispatcher.runDelay(arg_20_0.refreshAnimItem, arg_20_0, 0.5)
end

function var_0_0.onClose(arg_21_0)
	PopupController.instance:setPause(arg_21_0.viewName, false)
	TaskDispatcher.cancelTask(arg_21_0.refreshAnimItem, arg_21_0)
	arg_21_0.simageCollection:UnLoadImage()

	if arg_21_0.popupFlow then
		arg_21_0.popupFlow:destroy()

		arg_21_0.popupFlow = nil
	end
end

return var_0_0
