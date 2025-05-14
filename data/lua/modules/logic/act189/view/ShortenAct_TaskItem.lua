module("modules.logic.act189.view.ShortenAct_TaskItem", package.seeall)

local var_0_0 = class("ShortenAct_TaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._golimit = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_limit")
	arg_1_0._txtlimittext = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#go_limit/limitinfobg/#txt_limittext")
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

local var_0_1 = string.format

function var_0_0.initInternal(arg_4_0, ...)
	var_0_0.super.initInternal(arg_4_0, ...)

	arg_4_0.scrollReward = arg_4_0._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_4_0.scrollReward.parentGameObject = arg_4_0._view._csListScroll.gameObject
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

	local var_5_0 = arg_5_0._mo.config
	local var_5_1 = var_5_0.jumpId
	local var_5_2 = var_5_0.id

	if var_5_1 == 0 then
		return
	end

	if arg_5_0._isLimit then
		arg_5_0:_showToast()

		return
	end

	if GameFacade.jump(var_5_1) then
		if ViewMgr.instance:isOpen(ViewName.ShortenAct_PanelView) then
			ViewMgr.instance:closeView(ViewName.ShortenAct_PanelView)
		end

		Activity189Controller.instance:trySendFinishReadTaskRequest_jump(var_5_2)
	end
end

local var_0_2 = "ShortenAct_TaskItem:_btnfinishbgOnClick()"

function var_0_0._btnfinishbgOnClick(arg_6_0)
	arg_6_0:_startBlock()

	arg_6_0.animator.speed = 1

	arg_6_0.animatorPlayer:Play(UIAnimationName.Finish, arg_6_0._firstAnimationDone, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._rewardItemList = {}
	arg_7_0._btnnotfinishbgGo = arg_7_0._btnnotfinishbg.gameObject
	arg_7_0._btnfinishbgGo = arg_7_0._btnfinishbg.gameObject
	arg_7_0._goallfinishGo = arg_7_0._goallfinish.gameObject
	arg_7_0._scrollrewardsGo = arg_7_0._scrollrewards.gameObject
	arg_7_0._gorewardsContentFilter = gohelper.onceAddComponent(arg_7_0._gorewards, typeof(UnityEngine.UI.ContentSizeFitter))
	arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0.viewGO)
	arg_7_0.animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagenormalbg:UnLoadImage()
end

function var_0_0._viewContainer(arg_9_0)
	return arg_9_0._view.viewContainer
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0.animator
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1

	if arg_11_1.getAll then
		arg_11_0:_refreshGetAllUI()
	else
		arg_11_0:_refreshNormalUI()
	end
end

function var_0_0._refreshGetAllUI(arg_12_0)
	return
end

function var_0_0._isReadTask(arg_13_0)
	return arg_13_0._mo.config.listenerType == "ReadTask"
end

function var_0_0._getProgressReadTask(arg_14_0)
	local var_14_0 = Activity189Enum.TaskTag
	local var_14_1 = arg_14_0._mo.config
	local var_14_2 = var_14_1.id
	local var_14_3 = var_14_1.activityId

	return 0
end

function var_0_0._getMaxProgressReadTask(arg_15_0)
	return 1
end

function var_0_0._refreshNormalUI(arg_16_0)
	local var_16_0 = arg_16_0._mo
	local var_16_1 = var_16_0.config
	local var_16_2 = var_16_0.progress
	local var_16_3 = var_16_1.maxProgress
	local var_16_4 = var_16_1.openLimitActId
	local var_16_5 = var_16_1.jumpId
	local var_16_6 = JumpConfig.instance:getJumpConfig(var_16_5)

	if arg_16_0:_isReadTask() then
		local var_16_7 = arg_16_0:_getProgressReadTask()
		local var_16_8 = arg_16_0:_getMaxProgressReadTask()
	end

	local var_16_9 = var_16_0:isClaimable()

	arg_16_0._txttaskdes.text = var_16_1.desc

	gohelper.setActive(arg_16_0._btnnotfinishbgGo, var_16_0:isUnfinished())
	gohelper.setActive(arg_16_0._goallfinishGo, var_16_0:isClaimed())
	gohelper.setActive(arg_16_0._btnfinishbgGo, var_16_9)
	arg_16_0:_setActive_limite(false)

	local var_16_10 = false

	if var_16_4 > 0 then
		local var_16_11, var_16_12, var_16_13 = ActivityHelper.getActivityStatusAndToast(var_16_4, true)

		var_16_10 = var_16_11 ~= ActivityEnum.ActivityStatus.Normal

		arg_16_0:_setActive_limite(var_16_10)

		if var_16_11 == ActivityEnum.ActivityStatus.NotOpen then
			local var_16_14 = Activity189Model.instance:getActMO(var_16_4):getRealStartTimeStamp() - ServerTime.now()

			arg_16_0._txtlimittext.text = var_0_1(luaLang("ShortenAct_TaskItem_remain_open"), TimeUtil.getFormatTime(var_16_14))
			arg_16_0._limitDesc = arg_16_0:_getStrByToast(ToastEnum.ActivityNotOpen)
		elseif var_16_11 == ActivityEnum.ActivityStatus.Expired or var_16_11 == ActivityEnum.ActivityStatus.NotOnLine or var_16_11 == ActivityEnum.ActivityStatus.None then
			arg_16_0:_setLimitDesc(luaLang("turnback_end"))
		elseif var_16_11 == ActivityEnum.ActivityStatus.NotUnlock then
			arg_16_0:_setLimitTextByToast(var_16_12, var_16_13)
		end
	end

	if var_16_6 and not var_16_10 then
		local var_16_15, var_16_16, var_16_17 = JumpController.instance:canJumpNew(var_16_6.param)
		local var_16_18 = not var_16_15

		arg_16_0:_setActive_limite(var_16_18)
		arg_16_0:_setLimitTextByToast(var_16_16, var_16_17)
	end

	GameUtil.loadSImage(arg_16_0._simagenormalbg, ResUrl.getShortenActSingleBg(var_16_9 and "shortenact_taskitembg2" or "shortenact_taskitembg1"))
	arg_16_0:_refreshRewardItems()
end

function var_0_0._showToast(arg_17_0)
	ToastController.instance:showToastWithString(arg_17_0._limitDesc)
end

function var_0_0._setLimitDesc(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or ""
	arg_18_0._txtlimittext.text = arg_18_1
	arg_18_0._limitDesc = arg_18_1
end

function var_0_0._getStrByToast(arg_19_0, arg_19_1, arg_19_2)
	return ToastController.instance:getToastMsgWithTableParam(arg_19_1, arg_19_2)
end

function var_0_0._setLimitTextByToast(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:_setLimitDesc(arg_20_0:_getStrByToast(arg_20_1, arg_20_2))
end

function var_0_0._refreshRewardItems(arg_21_0)
	local var_21_0 = arg_21_0._mo.config.bonus

	if string.nilorempty(var_21_0) then
		gohelper.setActive(arg_21_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_21_0.scrollReward.gameObject, true)

	local var_21_1 = GameUtil.splitString2(var_21_0, true, "|", "#")

	arg_21_0._gorewardsContentFilter.enabled = #var_21_1 > 2

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_2 = iter_21_1[1]
		local var_21_3 = iter_21_1[2]
		local var_21_4 = iter_21_1[3]
		local var_21_5 = arg_21_0._rewardItemList[iter_21_0]

		if not var_21_5 then
			var_21_5 = IconMgr.instance:getCommonPropItemIcon(arg_21_0._gorewards)

			var_21_5:setMOValue(var_21_2, var_21_3, var_21_4, nil, true)
			var_21_5:setCountFontSize(26)
			var_21_5:showStackableNum2()
			var_21_5:isShowEffect(true)
			table.insert(arg_21_0._rewardItemList, var_21_5)

			local var_21_6 = var_21_5:getItemIcon()

			if var_21_6.getCountBg then
				local var_21_7 = var_21_6:getCountBg()

				transformhelper.setLocalScale(var_21_7.transform, 1, 1.5, 1)
			end

			if var_21_6.getCount then
				local var_21_8 = var_21_6:getCount()

				transformhelper.setLocalScale(var_21_8.transform, 1.5, 1.5, 1)
			end
		else
			var_21_5:setMOValue(var_21_2, var_21_3, var_21_4, nil, true)
		end

		gohelper.setActive(var_21_5.go, true)
	end

	for iter_21_2 = #var_21_1 + 1, #arg_21_0._rewardItemList do
		gohelper.setActive(arg_21_0._rewardItemList[iter_21_2].go, false)
	end

	arg_21_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0._firstAnimationDone(arg_22_0)
	arg_22_0:_viewContainer():removeByIndex(arg_22_0._index, arg_22_0._secondAnimationDone, arg_22_0)
end

function var_0_0._secondAnimationDone(arg_23_0)
	local var_23_0 = arg_23_0:_viewContainer()
	local var_23_1 = arg_23_0._mo
	local var_23_2 = var_23_1.config.id

	arg_23_0.animatorPlayer:Play(UIAnimationName.Idle)
	arg_23_0:_endBlock()

	if var_23_1.getAll then
		var_23_0:sendFinishAllTaskRequest()
	else
		var_23_0:sendFinishTaskRequest(var_23_2)
	end
end

function var_0_0._setActive_limite(arg_24_0, arg_24_1)
	arg_24_0._isLimit = arg_24_1

	gohelper.setActive(arg_24_0._golimit, arg_24_1)
end

function var_0_0._startBlock(arg_25_0)
	UIBlockMgr.instance:startBlock(var_0_2)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function var_0_0._endBlock(arg_26_0)
	UIBlockMgr.instance:endBlock(var_0_2)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

return var_0_0
