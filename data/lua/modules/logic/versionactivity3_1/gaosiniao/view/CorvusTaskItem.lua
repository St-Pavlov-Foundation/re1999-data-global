module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskItem", package.seeall)

local var_0_0 = class("CorvusTaskItem", ListScrollCellExtend)

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
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)

	if arg_2_0._btngetall then
		arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()

	if arg_3_0._btngetall then
		arg_3_0._btngetall:RemoveClickListener()
	end
end

local var_0_1 = 11235

function var_0_0.initInternal(arg_4_0, ...)
	var_0_0.super.initInternal(arg_4_0, ...)

	arg_4_0.scrollReward = arg_4_0._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_4_0.scrollReward.parentGameObject = arg_4_0._view._csListScroll.gameObject
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	local var_5_0 = arg_5_0._mo.config.jumpId

	if var_5_0 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(var_5_0) then
			arg_5_0:_viewContainer():closeThis()
		end
	end
end

local var_0_2 = "CorvusTaskItem:_btnfinishbgOnClick()"

function var_0_0._btnfinishbgOnClick(arg_6_0)
	arg_6_0:_startBlock()

	arg_6_0.animator.speed = 1

	arg_6_0.animatorPlayer:Play(UIAnimationName.Finish, arg_6_0._firstAnimationDone, arg_6_0)
end

function var_0_0._btngetallOnClick(arg_7_0)
	arg_7_0:_startBlock()
	arg_7_0:_viewContainer():dispatchEvent(var_0_1, arg_7_0:_actId())

	arg_7_0.animator.speed = 1

	arg_7_0.animatorPlayer:Play(UIAnimationName.Finish, arg_7_0._firstAnimationDone, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rewardItemList = {}
	arg_8_0._btnnotfinishbgGo = arg_8_0._btnnotfinishbg.gameObject
	arg_8_0._btnfinishbgGo = arg_8_0._btnfinishbg.gameObject
	arg_8_0._goallfinishGo = arg_8_0._goallfinish.gameObject
	arg_8_0._scrollrewardsGo = arg_8_0._scrollrewards.gameObject
	arg_8_0._gorewardsContentFilter = gohelper.onceAddComponent(arg_8_0._gorewards, gohelper.Type_ContentSizeFitter)
	arg_8_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_8_0.viewGO)
	arg_8_0.animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagenormalbg:UnLoadImage()
end

function var_0_0._viewContainer(arg_10_0)
	return arg_10_0._view.viewContainer
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0.animator
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	gohelper.setActive(arg_12_0._gonormal, not arg_12_1.getAll)
	gohelper.setActive(arg_12_0._gogetall, arg_12_1.getAll)

	if arg_12_1.getAll then
		arg_12_0:_refreshGetAllUI()
	else
		arg_12_0:_refreshNormalUI()
	end
end

function var_0_0._refreshGetAllUI(arg_13_0)
	return
end

function var_0_0._isReadTask(arg_14_0)
	return arg_14_0._mo.config.listenerType == "ReadTask"
end

function var_0_0._refreshNormalUI(arg_15_0)
	local var_15_0 = arg_15_0._mo
	local var_15_1 = var_15_0.config
	local var_15_2 = var_15_0.progress
	local var_15_3 = var_15_1.maxProgress

	if arg_15_0:_isReadTask() then
		var_15_2 = arg_15_0:_getProgressReadTask()
		var_15_3 = arg_15_0:_getMaxProgressReadTask()
	end

	arg_15_0._txtnum.text = math.min(var_15_2, var_15_3)
	arg_15_0._txttaskdes.text = var_15_1.desc
	arg_15_0._txttotal.text = var_15_3

	gohelper.setActive(arg_15_0._btnnotfinishbgGo, var_15_0:isUnfinished())
	gohelper.setActive(arg_15_0._goallfinishGo, var_15_0:isClaimed())
	gohelper.setActive(arg_15_0._btnfinishbgGo, var_15_0:isClaimable())
	arg_15_0:_refreshRewardItems()
end

function var_0_0._refreshRewardItems(arg_16_0)
	local var_16_0 = arg_16_0._mo.config.bonus

	if string.nilorempty(var_16_0) then
		gohelper.setActive(arg_16_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_16_0.scrollReward.gameObject, true)

	local var_16_1 = arg_16_0:_getRewardList()

	arg_16_0._gorewardsContentFilter.enabled = #var_16_1 > 2

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_2 = iter_16_1[1]
		local var_16_3 = iter_16_1[2]
		local var_16_4 = iter_16_1[3]
		local var_16_5 = arg_16_0._rewardItemList[iter_16_0]

		if not var_16_5 then
			var_16_5 = IconMgr.instance:getCommonPropItemIcon(arg_16_0._gorewards)

			var_16_5:setMOValue(var_16_2, var_16_3, var_16_4, nil, true)
			var_16_5:setCountFontSize(26)
			var_16_5:showStackableNum2()
			var_16_5:isShowEffect(true)
			table.insert(arg_16_0._rewardItemList, var_16_5)

			local var_16_6 = var_16_5:getItemIcon()

			if var_16_6.getCountBg then
				local var_16_7 = var_16_6:getCountBg()

				transformhelper.setLocalScale(var_16_7.transform, 1, 1.5, 1)
			end

			if var_16_6.getCount then
				local var_16_8 = var_16_6:getCount()

				transformhelper.setLocalScale(var_16_8.transform, 1.5, 1.5, 1)
			end
		else
			var_16_5:setMOValue(var_16_2, var_16_3, var_16_4, nil, true)
		end

		gohelper.setActive(var_16_5.go, true)
	end

	for iter_16_2 = #var_16_1 + 1, #arg_16_0._rewardItemList do
		gohelper.setActive(arg_16_0._rewardItemList[iter_16_2].go, false)
	end

	arg_16_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0._firstAnimationDone(arg_17_0)
	arg_17_0:_viewContainer():removeByIndex(arg_17_0._index, arg_17_0._secondAnimationDone, arg_17_0)
end

function var_0_0._secondAnimationDone(arg_18_0)
	local var_18_0 = arg_18_0:_viewContainer()
	local var_18_1 = arg_18_0._mo

	arg_18_0.animatorPlayer:Play(UIAnimationName.Idle)
	arg_18_0._endBlock()

	if var_18_1.getAll then
		var_18_0:sendFinishAllTaskRequest()
	else
		local var_18_2 = var_18_1.config.id

		var_18_0:sendFinishTaskRequest(var_18_2)
	end
end

function var_0_0._startBlock(arg_19_0)
	UIBlockMgr.instance:startBlock(var_0_2)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function var_0_0._endBlock(arg_20_0)
	UIBlockMgr.instance:endBlock(var_0_2)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.showAsGotState(arg_21_0)
	gohelper.setActive(arg_21_0._btnnotfinishbgGo, false)
	gohelper.setActive(arg_21_0._goallfinishGo, true)
	gohelper.setActive(arg_21_0._btnfinishbgGo, false)
end

function var_0_0._getRewardList(arg_22_0)
	local var_22_0 = arg_22_0._mo.config.bonus

	if string.nilorempty(var_22_0) then
		return {}
	end

	return GameUtil.splitString2(var_22_0, true, "|", "#")
end

function var_0_0._editableAddEvents(arg_23_0)
	arg_23_0:_viewContainer():registerCallback(var_0_1, arg_23_0._onOneClickClaimReward, arg_23_0)
end

function var_0_0._editableRemoveEvents(arg_24_0)
	arg_24_0:_viewContainer():unregisterCallback(var_0_1, arg_24_0._onOneClickClaimReward, arg_24_0)
end

function var_0_0._actId(arg_25_0)
	return arg_25_0:_viewContainer():actId()
end

function var_0_0._onOneClickClaimReward(arg_26_0, arg_26_1)
	if arg_26_0:_actId() ~= arg_26_1 then
		return
	end

	if arg_26_0._mo.getAll then
		return
	end

	arg_26_0.animator.speed = 1

	arg_26_0.animatorPlayer:Play(UIAnimationName.Finish, arg_26_0._onOneClickClaimRewardAnimFirstDone, arg_26_0)
end

function var_0_0._onOneClickClaimRewardAnimFirstDone(arg_27_0)
	arg_27_0:_viewContainer():removeByIndex(arg_27_0._index, arg_27_0._getAllPlayAnimDone, arg_27_0)
end

function var_0_0._getAllPlayAnimDone(arg_28_0)
	arg_28_0.animatorPlayer:Play(UIAnimationName.Idle)
	arg_28_0:showAsGotState()
end

function var_0_0._getProgressReadTask(arg_29_0)
	return 0
end

function var_0_0._getMaxProgressReadTask(arg_30_0)
	return 1
end

return var_0_0
