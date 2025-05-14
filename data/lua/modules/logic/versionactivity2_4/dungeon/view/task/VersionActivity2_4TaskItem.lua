module("modules.logic.versionactivity2_4.dungeon.view.task.VersionActivity2_4TaskItem", package.seeall)

local var_0_0 = class("VersionActivity2_4TaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0.txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0.txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0.txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.goDoing = gohelper.findChild(arg_1_0.viewGO, "#go_normal/txt_finishing")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.goRunning = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_running")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall")
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0.animatorPlayer:Play(UIAnimationName.Open)

	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0.btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0.btnFinishAll:AddClickListener(arg_2_0._btnFinishAllOnClick, arg_2_0)
	TaskController.instance:registerCallback(TaskEvent.OnClickFinishAllTask, arg_2_0._onClickFinishAllTaskItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnNotFinish:RemoveClickListener()
	arg_3_0.btnFinish:RemoveClickListener()
	arg_3_0.btnFinishAll:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.OnClickFinishAllTask, arg_3_0._onClickFinishAllTaskItem, arg_3_0)
end

function var_0_0._btnNotFinishOnClick(arg_4_0)
	if arg_4_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_4_0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4TaskView)
		end
	end
end

function var_0_0._onClickFinishAllTaskItem(arg_5_0, arg_5_1)
	if arg_5_0.taskMo.getAll then
		return
	end

	if arg_5_1 ~= VersionActivity2_4Enum.ActivityId.Dungeon or not arg_5_0.taskMo.hasFinished then
		return
	end

	arg_5_0.animator.speed = 1

	arg_5_0.animatorPlayer:Play(UIAnimationName.Finish)
end

function var_0_0._btnFinishAllOnClick(arg_6_0)
	arg_6_0:_btnFinishOnClick()
end

var_0_0.FinishKey = "VersionActivity2_4TaskItem FinishKey"

function var_0_0._btnFinishOnClick(arg_7_0)
	UIBlockMgr.instance:startBlock(var_0_0.FinishKey)

	if arg_7_0.taskMo.getAll then
		TaskController.instance:dispatchEvent(TaskEvent.OnClickFinishAllTask, VersionActivity2_4Enum.ActivityId.Dungeon)
	end

	arg_7_0.animator.speed = 1

	arg_7_0.animatorPlayer:Play(UIAnimationName.Finish, arg_7_0.firstAnimationDone, arg_7_0)
end

function var_0_0.firstAnimationDone(arg_8_0)
	local var_8_0 = VersionActivity2_4TaskListModel.instance:getFinishedTaskIdxList()

	var_8_0[#var_8_0 + 1] = arg_8_0._index

	arg_8_0._view.viewContainer.taskAnimRemoveItem:removeByIndexs(var_8_0, arg_8_0.secondAnimationDone, arg_8_0)
end

function var_0_0.secondAnimationDone(arg_9_0)
	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
	arg_9_0.animatorPlayer:Play(UIAnimationName.Idle)

	if arg_9_0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, VersionActivity2_4Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_9_0.co.id)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0.taskMo = arg_11_1
	arg_11_0.scrollReward.parentGameObject = arg_11_0._view._csListScroll.gameObject

	gohelper.setActive(arg_11_0._gonormal, not arg_11_0.taskMo.getAll)
	gohelper.setActive(arg_11_0._gogetall, arg_11_0.taskMo.getAll)

	if arg_11_0.taskMo.getAll then
		arg_11_0:refreshGetAllUI()
	else
		arg_11_0:refreshNormalUI()
	end
end

function var_0_0.refreshNormalUI(arg_12_0)
	arg_12_0.co = arg_12_0.taskMo.config
	arg_12_0.txttaskdesc.text = arg_12_0.co.desc
	arg_12_0.txtnum.text = arg_12_0.taskMo.progress
	arg_12_0.txttotal.text = arg_12_0.co.maxProgress

	if arg_12_0.taskMo.finishCount >= arg_12_0.co.maxFinishCount then
		gohelper.setActive(arg_12_0.goDoing, false)
		gohelper.setActive(arg_12_0.btnNotFinish, false)
		gohelper.setActive(arg_12_0.goRunning, false)
		gohelper.setActive(arg_12_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_12_0.goFinished, true)
	elseif arg_12_0.taskMo.hasFinished then
		gohelper.setActive(arg_12_0.btnFinish, true)
		gohelper.setActive(arg_12_0.btnNotFinish, false)
		gohelper.setActive(arg_12_0.goDoing, false)
		gohelper.setActive(arg_12_0.goRunning, false)
		gohelper.setActive(arg_12_0.goFinished, false)
	else
		if arg_12_0.co.jumpId ~= 0 then
			gohelper.setActive(arg_12_0.btnNotFinish, true)
			gohelper.setActive(arg_12_0.goDoing, false)
			gohelper.setActive(arg_12_0.goRunning, false)
		else
			gohelper.setActive(arg_12_0.btnNotFinish, false)
			gohelper.setActive(arg_12_0.goDoing, true)
			gohelper.setActive(arg_12_0.goRunning, true)
		end

		gohelper.setActive(arg_12_0.goFinished, false)
		gohelper.setActive(arg_12_0.btnFinish.gameObject, false)
	end

	arg_12_0:refreshRewardItems()
end

function var_0_0.refreshRewardItems(arg_13_0)
	local var_13_0 = arg_13_0.co.bonus

	if string.nilorempty(var_13_0) then
		gohelper.setActive(arg_13_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_13_0.scrollReward.gameObject, true)

	local var_13_1 = GameUtil.splitString2(var_13_0, true, "|", "#")

	arg_13_0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_13_1 > 2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = iter_13_1[1]
		local var_13_3 = iter_13_1[2]
		local var_13_4 = iter_13_1[3]
		local var_13_5 = arg_13_0.rewardItemList[iter_13_0]

		if not var_13_5 then
			var_13_5 = IconMgr.instance:getCommonPropItemIcon(arg_13_0.goRewardContent)

			transformhelper.setLocalScale(var_13_5.go.transform, 1, 1, 1)
			var_13_5:setMOValue(var_13_2, var_13_3, var_13_4, nil, true)
			var_13_5:setCountFontSize(26)
			var_13_5:showStackableNum2()
			var_13_5:isShowEffect(true)
			table.insert(arg_13_0.rewardItemList, var_13_5)

			local var_13_6 = var_13_5:getItemIcon():getCountBg()
			local var_13_7 = var_13_5:getItemIcon():getCount()

			transformhelper.setLocalScale(var_13_6.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(var_13_7.transform, 1.5, 1.5, 1)
		else
			var_13_5:setMOValue(var_13_2, var_13_3, var_13_4, nil, true)
		end

		gohelper.setActive(var_13_5.go, true)
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.rewardItemList do
		gohelper.setActive(arg_13_0.rewardItemList[iter_13_2].go, false)
	end

	arg_13_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.refreshGetAllUI(arg_14_0)
	return
end

function var_0_0.canGetReward(arg_15_0)
	return arg_15_0.taskMo.finishCount < arg_15_0.co.maxFinishCount and arg_15_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0.animator
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagenormalbg:UnLoadImage()
	arg_17_0._simagegetallbg:UnLoadImage()
end

return var_0_0
