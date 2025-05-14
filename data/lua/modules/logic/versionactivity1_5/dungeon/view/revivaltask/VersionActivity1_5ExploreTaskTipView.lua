module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskTipView", package.seeall)

local var_0_0 = class("VersionActivity1_5ExploreTaskTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTipContainer = gohelper.findChild(arg_1_0.viewGO, "#go_exploretipcontainer")
	arg_1_0._goclosetip = gohelper.findChild(arg_1_0.viewGO, "#go_exploretipcontainer/#go_closetip")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_exploretipcontainer/#go_exploretip")
	arg_1_0._txtTipTitle = gohelper.findChildText(arg_1_0._gotips, "#txt_title")
	arg_1_0._txtTipTitleEn = gohelper.findChildText(arg_1_0._gotips, "#txt_title/#txt_en")
	arg_1_0._txtTipDesc = gohelper.findChildText(arg_1_0._gotips, "scroll/view/#txt_dec")
	arg_1_0._goTipFinish = gohelper.findChild(arg_1_0._gotips, "layout/#go_finish")
	arg_1_0._goTipGoTo = gohelper.findChild(arg_1_0._gotips, "layout/#go_goto")
	arg_1_0._txtTipStatus = gohelper.findChildText(arg_1_0._gotips, "layout/#go_goto/#txt_status")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goTipContainer, false)

	arg_4_0.goTipRectTr = arg_4_0._gotips:GetComponent(typeof(UnityEngine.RectTransform))
	arg_4_0.goTipContainerTr = arg_4_0._goTipContainer:GetComponent(typeof(UnityEngine.RectTransform))
	arg_4_0.halfViewWidth = recthelper.getWidth(arg_4_0.goTipContainerTr) / 2
	arg_4_0.halfTipWidth = recthelper.getWidth(arg_4_0.goTipRectTr) / 2
	arg_4_0.goToClick = gohelper.getClickWithDefaultAudio(arg_4_0._goTipGoTo)

	arg_4_0.goToClick:AddClickListener(arg_4_0.onClickGoToBtn, arg_4_0)

	arg_4_0.closeClick = gohelper.getClickWithDefaultAudio(arg_4_0._goclosetip)

	arg_4_0.closeClick:AddClickListener(arg_4_0.onHideTipContainer, arg_4_0)
end

function var_0_0.onHideTipContainer(arg_5_0)
	gohelper.setActive(arg_5_0._goTipContainer, false)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.HideExploreTip, arg_5_0.taskItem)

	arg_5_0.taskItem = nil
	arg_5_0.config = nil
end

function var_0_0.onClickGoToBtn(arg_6_0)
	if arg_6_0.isGainedReward then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.config.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_6_1) then
			if not DungeonMapModel.instance:getElementById(iter_6_1) then
				logError("element not exist or not unlock, element id : " .. iter_6_1)

				return
			end

			arg_6_0:closeThis()
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, iter_6_1)

			return
		end
	end
end

function var_0_0.showTip(arg_7_0, arg_7_1, arg_7_2)
	gohelper.setActive(arg_7_0._goTipContainer, true)

	arg_7_0.taskItem = arg_7_1
	arg_7_0.config = arg_7_1.taskCo

	arg_7_0:setPos(arg_7_2)
	arg_7_0:refreshUI()
end

function var_0_0.setPos(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.x >= arg_8_0.halfViewWidth
	local var_8_1 = recthelper.screenPosToAnchorPos(arg_8_1, arg_8_0.goTipContainerTr)
	local var_8_2 = var_8_1.x
	local var_8_3 = var_8_1.y
	local var_8_4 = VersionActivity1_5DungeonEnum.ExploreTipOffsetX

	var_8_2 = var_8_0 and var_8_2 - arg_8_0.halfTipWidth - var_8_4 or var_8_2 + arg_8_0.halfTipWidth + var_8_4

	local var_8_5 = math.max(var_8_3, VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Min)
	local var_8_6 = math.min(var_8_5, VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Max)

	recthelper.setAnchor(arg_8_0.goTipRectTr, var_8_2, var_8_6)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._txtTipTitle.text = arg_9_0.config.title
	arg_9_0._txtTipTitleEn.text = arg_9_0.config.titleEn
	arg_9_0._txtTipDesc.text = arg_9_0.config.desc
	arg_9_0.status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(arg_9_0.config)
	arg_9_0.isGainedReward = arg_9_0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward

	gohelper.setActive(arg_9_0._goTipFinish, arg_9_0.isGainedReward)
	gohelper.setActive(arg_9_0._goTipGoTo, not arg_9_0.isGainedReward)

	if not arg_9_0.isGainedReward then
		if arg_9_0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished then
			arg_9_0._txtTipStatus.text = luaLang("p_v1a5_dispatch_finish")
		elseif arg_9_0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running then
			arg_9_0._txtTipStatus.text = luaLang("p_v1a5_dispatch_ing")
		else
			arg_9_0._txtTipStatus.text = ""
		end
	end
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.goToClick:RemoveClickListener()
	arg_10_0.closeClick:RemoveClickListener()
end

return var_0_0
