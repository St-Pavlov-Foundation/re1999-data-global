module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleItem", package.seeall)

local var_0_0 = class("V1a6_BossRush_ScheduleItem", ListScrollCellExtend)

function var_0_0._initScollParentGameObject(arg_1_0)
	if not arg_1_0._isSetParent then
		arg_1_0._scrollrewardLimitScollRect.parentGameObject = arg_1_0._view:getCsListScroll().gameObject
		arg_1_0._isSetParent = true
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goNormal = gohelper.findChild(arg_2_0.viewGO, "#go_Normal")
	arg_2_0._txtDescr = gohelper.findChildText(arg_2_0.viewGO, "#go_Normal/#txt_Descr")
	arg_2_0._imgIcon = gohelper.findChildImage(arg_2_0.viewGO, "#go_Normal/image_Icon")
	arg_2_0._scrollRewards = gohelper.findChildScrollRect(arg_2_0.viewGO, "#go_Normal/#scroll_Rewards")
	arg_2_0._gorewards = gohelper.findChild(arg_2_0.viewGO, "#go_Normal/#scroll_Rewards/Viewport/#go_rewards")
	arg_2_0._btnNotFinish = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_Normal/#btn_NotFinish")
	arg_2_0._btnFinished = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_Normal/#btn_Finished")
	arg_2_0._goAllFinished = gohelper.findChild(arg_2_0.viewGO, "#go_Normal/#go_AllFinished")
	arg_2_0._goGetAll = gohelper.findChild(arg_2_0.viewGO, "#go_GetAll")
	arg_2_0._btngetall = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_GetAll/#btn_getall/click")
	arg_2_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0._goNormal)
	arg_2_0.animator = arg_2_0._goNormal:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.animatorGetAll = arg_2_0._goGetAll:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.animatorPlayerGetAll = ZProj.ProjAnimatorPlayer.Get(arg_2_0._goGetAll)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnNotFinish:AddClickListener(arg_3_0._btnNotFinishOnClick, arg_3_0)
	arg_3_0._btnFinished:AddClickListener(arg_3_0._btnFinishedOnClick, arg_3_0)
	arg_3_0._btngetall:AddClickListener(arg_3_0._btngetallOnClick, arg_3_0)
	arg_3_0:addEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, arg_3_0._OnClickGetAllScheduleBouns, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnNotFinish:RemoveClickListener()
	arg_4_0._btnFinished:RemoveClickListener()
	arg_4_0._btngetall:RemoveClickListener()
	arg_4_0:removeEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, arg_4_0._OnClickGetAllScheduleBouns, arg_4_0)
end

var_0_0.UI_CLICK_BLOCK_KEY = "V1a6_BossRush_ScheduleItemClick"

function var_0_0._btngetallOnClick(arg_5_0)
	arg_5_0:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllScheduleBouns)
end

function var_0_0._btnNotFinishOnClick(arg_6_0)
	return
end

function var_0_0._btnFinishedOnClick(arg_7_0)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	arg_7_0:getAnimatorPlayer():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, arg_7_0.firstAnimationDone, arg_7_0)
end

function var_0_0._OnClickGetAllScheduleBouns(arg_8_0)
	if arg_8_0._mo and arg_8_0._mo.isCanClaim then
		arg_8_0:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._scrollrewardLimitScollRect = arg_9_0._scrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function var_0_0._editableAddEvents(arg_10_0)
	return
end

function var_0_0._editableRemoveEvents(arg_11_0)
	return
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0:_initScollParentGameObject()

	arg_12_0._mo = arg_12_1

	if not arg_12_1.getAll then
		arg_12_0:refreshNormalUI(arg_12_1)
	else
		arg_12_0:refreshGetAllUI(arg_12_1)
	end
end

function var_0_0.refreshNormalUI(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.isGot
	local var_13_1 = arg_13_1.stageRewardCO
	local var_13_2 = var_13_1.stage
	local var_13_3 = BossRushModel.instance:getLastPointInfo(var_13_2).cur >= var_13_1.rewardPointNum
	local var_13_4 = ItemModel.instance:getItemDataListByConfigStr(var_13_1.reward)
	local var_13_5 = var_13_3 and GameUtil.parseColor("#c48152") or GameUtil.parseColor("#919191")

	arg_13_0._imgIcon.color = var_13_5
	arg_13_0._mo.isCanClaim = not var_13_0 and var_13_3

	gohelper.setActive(arg_13_0._goAllFinished, var_13_0)
	gohelper.setActive(arg_13_0._btnFinished.gameObject, arg_13_0._mo.isCanClaim)
	gohelper.setActive(arg_13_0._btnNotFinish.gameObject, not var_13_0 and not var_13_3)
	gohelper.setActive(arg_13_0._goGetAll, false)
	gohelper.setActive(arg_13_0._goNormal, true)
	IconMgr.instance:getCommonPropItemIconList(arg_13_0, arg_13_0._onRewardItemShow, var_13_4, arg_13_0._gorewards)

	arg_13_0._txtDescr.text = string.format(luaLang("v1a6_bossrush_scheduleview_desc"), var_13_1.rewardPointNum)
end

function var_0_0.refreshGetAllUI(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goGetAll, true)
	gohelper.setActive(arg_14_0._goNormal, false)
end

function var_0_0._onRewardItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1:onUpdateMO(arg_15_2)
	arg_15_1:showStackableNum2()
	arg_15_1:setCountFontSize(48)
end

function var_0_0.onSelect(arg_16_0, arg_16_1)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

function var_0_0.firstAnimationDone(arg_18_0)
	local var_18_0 = V1a6_BossRush_BonusModel.instance:getTab()
	local var_18_1 = arg_18_0._view.viewContainer:getScrollAnimRemoveItem(var_18_0)

	if var_18_1 then
		var_18_1:removeByIndex(arg_18_0._index, arg_18_0.secondAnimationDone, arg_18_0)
	else
		arg_18_0:secondAnimationDone()
	end
end

function var_0_0.secondAnimationDone(arg_19_0)
	if arg_19_0._mo then
		if arg_19_0._mo.getAll then
			BossRushRpc.instance:sendAct128GetTotalRewardsRequest(arg_19_0._mo.stage)
		elseif arg_19_0._mo.stageRewardCO then
			BossRushRpc.instance:sendAct128GetTotalSingleRewardRequest(arg_19_0._mo.stage, arg_19_0._mo.stageRewardCO.id)
		end

		UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	end
end

function var_0_0.getAnimator(arg_20_0)
	return arg_20_0._mo.getAll and arg_20_0.animatorGetAll or arg_20_0.animator
end

function var_0_0.getAnimatorPlayer(arg_21_0)
	return arg_21_0._mo.getAll and arg_21_0.animatorPlayerGetAll or arg_21_0.animatorPlayer
end

return var_0_0
