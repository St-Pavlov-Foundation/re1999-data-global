module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskItem", package.seeall)

local var_0_0 = class("V2a4_WarmUp_TaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_normal/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
end

local var_0_1 = "V2a4_WarmUp_TaskItem:_btnfinishbgOnClick()"

function var_0_0._btnnotfinishbgOnClick(arg_4_0)
	if arg_4_0._mo.config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_4_0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.V2a4_WarmUp_TaskView)
		end
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	UIBlockMgr.instance:startBlock(var_0_1)

	arg_5_0.animator.speed = 1

	arg_5_0.animatorPlayer:Play(UIAnimationName.Finish, arg_5_0._firstAnimationDone, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._rewardItemList = {}
	arg_6_0._btnnotfinishbgGo = arg_6_0._btnnotfinishbg.gameObject
	arg_6_0._btnfinishbgGo = arg_6_0._btnfinishbg.gameObject
	arg_6_0._goallfinishGo = arg_6_0._goallfinish.gameObject
	arg_6_0._scrollrewardsGo = arg_6_0._scrollrewards.gameObject
	arg_6_0._gorewardsContentFilter = gohelper.onceAddComponent(arg_6_0._gorewards, gohelper.Type_ContentSizeFitter)
	arg_6_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_6_0.viewGO)
	arg_6_0.animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagenormalbg:UnLoadImage()
end

function var_0_0.initInternal(arg_8_0, ...)
	var_0_0.super.initInternal(arg_8_0, ...)

	arg_8_0.scrollReward = arg_8_0._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_8_0.scrollReward.parentGameObject = arg_8_0._view._csListScroll.gameObject
end

function var_0_0._viewContainer(arg_9_0)
	return arg_9_0._view.viewContainer
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	if arg_10_1.getAll then
		arg_10_0:_refreshGetAllUI()
	else
		arg_10_0:_refreshNormalUI()
	end
end

function var_0_0._refreshGetAllUI(arg_11_0)
	return
end

function var_0_0._isReadTask(arg_12_0)
	return arg_12_0._mo.config.listenerType == "ReadTask"
end

function var_0_0._getProgressReadTask(arg_13_0)
	local var_13_0 = ActivityWarmUpEnum.Activity125TaskTag
	local var_13_1 = arg_13_0._mo
	local var_13_2 = var_13_1.config
	local var_13_3 = var_13_2.id
	local var_13_4 = var_13_2.activityId

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(var_13_4, var_13_0.sum_help_npc)[var_13_3] then
		return arg_13_0:_progress_sum_help_npc()
	end

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(var_13_4, var_13_0.help_npc)[var_13_3] then
		return var_13_1.progress
	end

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(var_13_4, var_13_0.perfect_win)[var_13_3] then
		return var_13_1.progress
	end
end

function var_0_0._getMaxProgressReadTask(arg_14_0)
	local var_14_0 = arg_14_0._mo.config
	local var_14_1 = ActivityWarmUpEnum.Activity125TaskTag
	local var_14_2 = var_14_0.id
	local var_14_3 = var_14_0.activityId

	if Activity125Config.instance:getTaskCO_ReadTask_Tag(var_14_3, var_14_1.sum_help_npc)[var_14_2] then
		return tonumber(var_14_0.clientlistenerParam) or 0
	else
		return 1
	end
end

function var_0_0._progress_sum_help_npc(arg_15_0)
	return Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
end

function var_0_0._refreshNormalUI(arg_16_0)
	local var_16_0 = arg_16_0._mo
	local var_16_1 = var_16_0.config
	local var_16_2 = var_16_0.progress
	local var_16_3 = var_16_1.maxProgress

	if arg_16_0:_isReadTask() then
		var_16_2 = arg_16_0:_getProgressReadTask()
		var_16_3 = arg_16_0:_getMaxProgressReadTask()
	end

	arg_16_0._txtnum.text = math.min(var_16_2, var_16_3)
	arg_16_0._txttaskdes.text = var_16_1.desc
	arg_16_0._txttotal.text = var_16_3

	gohelper.setActive(arg_16_0._btnnotfinishbgGo, var_16_0:isUnfinished())
	gohelper.setActive(arg_16_0._goallfinishGo, var_16_0:isClaimed())
	gohelper.setActive(arg_16_0._btnfinishbgGo, var_16_0:isClaimable())
	arg_16_0:_refreshRewardItems()
end

function var_0_0._refreshRewardItems(arg_17_0)
	local var_17_0 = arg_17_0._mo.config.bonus

	if string.nilorempty(var_17_0) then
		gohelper.setActive(arg_17_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_17_0.scrollReward.gameObject, true)

	local var_17_1 = GameUtil.splitString2(var_17_0, true, "|", "#")

	arg_17_0._gorewardsContentFilter.enabled = #var_17_1 > 2

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = iter_17_1[1]
		local var_17_3 = iter_17_1[2]
		local var_17_4 = iter_17_1[3]
		local var_17_5 = arg_17_0._rewardItemList[iter_17_0]

		if not var_17_5 then
			var_17_5 = IconMgr.instance:getCommonPropItemIcon(arg_17_0._gorewards)

			var_17_5:setMOValue(var_17_2, var_17_3, var_17_4, nil, true)
			var_17_5:setCountFontSize(26)
			var_17_5:showStackableNum2()
			var_17_5:isShowEffect(true)
			table.insert(arg_17_0._rewardItemList, var_17_5)

			local var_17_6 = var_17_5:getItemIcon()

			if var_17_6.getCountBg then
				local var_17_7 = var_17_6:getCountBg()

				transformhelper.setLocalScale(var_17_7.transform, 1, 1.5, 1)
			end

			if var_17_6.getCount then
				local var_17_8 = var_17_6:getCount()

				transformhelper.setLocalScale(var_17_8.transform, 1.5, 1.5, 1)
			end
		else
			var_17_5:setMOValue(var_17_2, var_17_3, var_17_4, nil, true)
		end

		gohelper.setActive(var_17_5.go, true)
	end

	for iter_17_2 = #var_17_1 + 1, #arg_17_0._rewardItemList do
		gohelper.setActive(arg_17_0._rewardItemList[iter_17_2].go, false)
	end

	arg_17_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0._firstAnimationDone(arg_18_0)
	arg_18_0:_viewContainer():removeByIndex(arg_18_0._index, arg_18_0._secondAnimationDone, arg_18_0)
end

function var_0_0._secondAnimationDone(arg_19_0)
	local var_19_0 = arg_19_0:_viewContainer()
	local var_19_1 = arg_19_0._mo
	local var_19_2 = var_19_1.config.id

	UIBlockMgr.instance:endBlock(var_0_1)
	arg_19_0.animatorPlayer:Play(UIAnimationName.Idle)

	if var_19_1.getAll then
		var_19_0:sendFinishAllTaskRequest()
	else
		var_19_0:sendFinishTaskRequest(var_19_2)
	end
end

function var_0_0.getAnimator(arg_20_0)
	return arg_20_0.animator
end

return var_0_0
