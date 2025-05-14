module("modules.logic.versionactivity1_8.dungeon.view.task.VersionActivity1_8TaskItem", package.seeall)

local var_0_0 = class("VersionActivity1_8TaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0.sizeFitterRewardContent = arg_1_0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0.btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0.btnFinishAll:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnNotFinish:RemoveClickListener()
	arg_3_0.btnFinish:RemoveClickListener()
	arg_3_0.btnFinishAll:RemoveClickListener()
end

function var_0_0._btnNotFinishOnClick(arg_4_0)
	if arg_4_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_4_0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_8TaskView)
		end
	end
end

function var_0_0._btnFinishOnClick(arg_5_0)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)

	arg_5_0._animator.speed = 1

	arg_5_0._animatorPlayer:Play(UIAnimationName.Finish, arg_5_0.firstAnimationDone, arg_5_0)
end

function var_0_0.firstAnimationDone(arg_6_0)
	arg_6_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_6_0._index, arg_6_0.secondAnimationDone, arg_6_0)
end

function var_0_0.secondAnimationDone(arg_7_0)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)
	arg_7_0._animatorPlayer:Play(UIAnimationName.Idle)

	if arg_7_0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, VersionActivity1_8Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_7_0.co.id)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0.taskMo = arg_9_1
	arg_9_0.scrollReward.parentGameObject = arg_9_0._view._csListScroll.gameObject

	gohelper.setActive(arg_9_0._gonormal, not arg_9_0.taskMo.getAll)
	gohelper.setActive(arg_9_0._gogetall, arg_9_0.taskMo.getAll)

	if arg_9_0.taskMo.getAll then
		arg_9_0:refreshGetAllUI()
	else
		arg_9_0:refreshNormalUI()
	end
end

function var_0_0.refreshGetAllUI(arg_10_0)
	return
end

function var_0_0.refreshNormalUI(arg_11_0)
	arg_11_0.co = arg_11_0.taskMo.config
	arg_11_0._txttaskdes.text = arg_11_0.co.desc
	arg_11_0._txtnum.text = arg_11_0.taskMo.progress
	arg_11_0._txttotal.text = arg_11_0.co.maxProgress

	if arg_11_0.taskMo.finishCount >= arg_11_0.co.maxFinishCount then
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_11_0.goFinished, true)
	elseif arg_11_0.taskMo.hasFinished then
		gohelper.setActive(arg_11_0.btnFinish.gameObject, true)
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_11_0.goFinished, false)
	else
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, true)
		gohelper.setActive(arg_11_0.goFinished, false)
	end

	arg_11_0:refreshRewardItems()
end

local var_0_1 = 26

function var_0_0.refreshRewardItems(arg_12_0)
	local var_12_0 = arg_12_0.co.bonus

	if string.nilorempty(var_12_0) then
		gohelper.setActive(arg_12_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_12_0.scrollReward.gameObject, true)

	local var_12_1 = GameUtil.splitString2(var_12_0, true, "|", "#")

	arg_12_0.sizeFitterRewardContent.enabled = #var_12_1 > 2

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = iter_12_1[1]
		local var_12_3 = iter_12_1[2]
		local var_12_4 = iter_12_1[3]
		local var_12_5 = arg_12_0.rewardItemList[iter_12_0]

		if not var_12_5 then
			var_12_5 = IconMgr.instance:getCommonPropItemIcon(arg_12_0.goRewardContent)

			var_12_5:setMOValue(var_12_2, var_12_3, var_12_4, nil, true)
			var_12_5:setCountFontSize(var_0_1)
			var_12_5:showStackableNum2()
			var_12_5:isShowEffect(true)

			local var_12_6 = var_12_5:getItemIcon():getCountBg()
			local var_12_7 = var_12_5:getItemIcon():getCount()

			transformhelper.setLocalScale(var_12_6.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(var_12_7.transform, 1.5, 1.5, 1)
			table.insert(arg_12_0.rewardItemList, var_12_5)
		else
			var_12_5:setMOValue(var_12_2, var_12_3, var_12_4, nil, true)
		end

		gohelper.setActive(var_12_5.go, true)
	end

	for iter_12_2 = #var_12_1 + 1, #arg_12_0.rewardItemList do
		gohelper.setActive(arg_12_0.rewardItemList[iter_12_2].go, false)
	end

	arg_12_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagenormalbg:UnLoadImage()
	arg_14_0._simagegetallbg:UnLoadImage()

	arg_14_0.rewardItemList = {}

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.TaskGetReward)
end

return var_0_0
