module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskItem", package.seeall)

local var_0_0 = class("Activity1_3ChessTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity1_3ChessController.instance:registerCallback(Activity1_3ChessEvent.OneClickClaimReward, arg_2_0._onOneClickClaimReward, arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity1_3ChessController.instance:unregisterCallback(Activity1_3ChessEvent.OneClickClaimReward, arg_3_0._onOneClickClaimReward, arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
end

function var_0_0._btnnotfinishbgOnClick(arg_4_0)
	if not arg_4_0._taskMO then
		return
	end

	local var_4_0 = arg_4_0._taskMO.config.episodeId

	if Activity1_3ChessController.instance:isEpisodeOpen(var_4_0) then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickEpisode, var_4_0)
	else
		Activity1_3ChessController.instance:showToastByEpsodeId(var_4_0)
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, arg_5_0._taskMO)
	arg_5_0:_onOneClickClaimReward()
end

function var_0_0._btngetallOnClick(arg_6_0)
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, arg_6_0._taskMO)
	Activity1_3ChessController.instance:dispatchAllTaskItemGotReward()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._onOneClickClaimReward(arg_8_0)
	if arg_8_0._taskMO:haveRewardToGet() then
		arg_8_0._playFinishAnin = true

		arg_8_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0._animator
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._taskMO = arg_10_1
	arg_10_0.scrollReward.parentGameObject = arg_10_0._view._csListScroll.gameObject

	arg_10_0:_refreshUI()
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

local var_0_1 = -100

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = arg_12_0._taskMO

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.id ~= var_0_1

	gohelper.setActive(arg_12_0._gogetall, not var_12_1)
	gohelper.setActive(arg_12_0._gonormal, var_12_1)

	if var_12_1 then
		if arg_12_0._playFinishAnin then
			arg_12_0._playFinishAnin = false

			arg_12_0._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(arg_12_0._goallfinish, false)
		gohelper.setActive(arg_12_0._btnnotfinishbg, false)
		gohelper.setActive(arg_12_0._btnfinishbg, false)

		if var_12_0:isFinished() then
			gohelper.setActive(arg_12_0._btnfinishbg, true)
		elseif var_12_0:alreadyGotReward() then
			gohelper.setActive(arg_12_0._goallfinish, true)
		else
			gohelper.setActive(arg_12_0._btnnotfinishbg, true)
		end

		local var_12_2 = var_12_0.config and var_12_0.config.offestProgress or 0

		arg_12_0._txtnum.text = math.max(var_12_0:getProgress() + var_12_2, 0)
		arg_12_0._txttotal.text = math.max(var_12_0:getMaxProgress() + var_12_2, 0)
		arg_12_0._txttaskdes.text = var_12_0.config and var_12_0.config.desc or ""

		local var_12_3 = ItemModel.instance:getItemDataListByConfigStr(var_12_0.config.bonus)

		arg_12_0.item_list = var_12_3

		IconMgr.instance:getCommonPropItemIconList(arg_12_0, arg_12_0._onItemShow, var_12_3, arg_12_0._gorewards)
	end
end

function var_0_0._onItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:onUpdateMO(arg_13_2)
	arg_13_1:setConsume(true)
	arg_13_1:showStackableNum2()
	arg_13_1:isShowEffect(true)
	arg_13_1:setAutoPlay(true)
	arg_13_1:setCountFontSize(48)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_taskitem.prefab"

return var_0_0
