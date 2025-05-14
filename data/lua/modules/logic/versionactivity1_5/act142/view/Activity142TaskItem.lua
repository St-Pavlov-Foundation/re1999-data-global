module("modules.logic.versionactivity1_5.act142.view.Activity142TaskItem", package.seeall)

local var_0_0 = class("Activity142TaskItem", ListScrollCellExtend)
local var_0_1 = 0.2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0._scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity142Controller.instance:registerCallback(Activity142Event.OneClickClaimReward, arg_2_0._onOneClickClaimReward, arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity142Controller.instance:unregisterCallback(Activity142Event.OneClickClaimReward, arg_3_0._onOneClickClaimReward, arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
end

function var_0_0._onOneClickClaimReward(arg_4_0)
	if arg_4_0._taskMO:haveRewardToGet() then
		arg_4_0._playFinishAnim = true

		arg_4_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	if not arg_5_0._taskMO then
		return
	end

	local var_5_0 = arg_5_0._taskMO.config.episodeId
	local var_5_1 = Activity142Model.instance:getActivityId()

	if Activity142Model.instance:isEpisodeOpen(var_5_1, var_5_0) then
		Activity142Controller.instance:dispatchEvent(Activity142Event.ClickEpisode, var_5_0)
	else
		Activity142Helper.showToastByEpisodeId(var_5_0)
	end
end

function var_0_0._btnfinishbgOnClick(arg_6_0)
	Activity142Controller.instance:delayRequestGetReward(var_0_1, arg_6_0._taskMO)
	arg_6_0:_onOneClickClaimReward()
end

function var_0_0._btngetallOnClick(arg_7_0)
	Activity142Controller.instance:delayRequestGetReward(var_0_1, arg_7_0._taskMO)
	Activity142Controller.instance:dispatchAllTaskItemGotReward()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0._animator
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._taskMO = arg_10_1
	arg_10_0._scrollReward.parentGameObject = arg_10_0._view._csListScroll.gameObject
	arg_10_0._scrollReward.horizontalNormalizedPosition = 0

	arg_10_0:_refreshUI()
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = arg_11_0._taskMO

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0.id ~= Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID

	gohelper.setActive(arg_11_0._gogetall, not var_11_1)
	gohelper.setActive(arg_11_0._gonormal, var_11_1)

	if not var_11_1 then
		return
	end

	if arg_11_0._playFinishAnim then
		arg_11_0._playFinishAnim = false

		arg_11_0._animator:Play("idle", 0, 1)
	end

	gohelper.setActive(arg_11_0._btnfinishbg, false)
	gohelper.setActive(arg_11_0._goallfinish, false)
	gohelper.setActive(arg_11_0._btnnotfinishbg, false)

	if var_11_0:isFinished() then
		gohelper.setActive(arg_11_0._btnfinishbg, true)
	elseif var_11_0:alreadyGotReward() then
		gohelper.setActive(arg_11_0._goallfinish, true)
	else
		gohelper.setActive(arg_11_0._btnnotfinishbg, true)
	end

	arg_11_0._txtnum.text = var_11_0:getProgress()
	arg_11_0._txttotal.text = var_11_0:getMaxProgress()
	arg_11_0._txttaskdes.text = var_11_0.config and var_11_0.config.desc or ""

	local var_11_2 = ItemModel.instance:getItemDataListByConfigStr(var_11_0.config.bonus)

	IconMgr.instance:getCommonPropItemIconList(arg_11_0, arg_11_0._onItemShow, var_11_2, arg_11_0._gorewards)
end

function var_0_0._onItemShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:onUpdateMO(arg_12_2)
	arg_12_1:setConsume(true)
	arg_12_1:showStackableNum2()
	arg_12_1:isShowEffect(true)
	arg_12_1:setAutoPlay(true)
	arg_12_1:setCountFontSize(48)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
