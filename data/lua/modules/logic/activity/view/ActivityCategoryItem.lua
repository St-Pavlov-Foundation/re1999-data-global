module("modules.logic.activity.view.ActivityCategoryItem", package.seeall)

local var_0_0 = class("ActivityCategoryItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "noselected")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_1, "beselected/activitynamecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_1, "beselected/activitynamecn/activitynameen")
	arg_1_0._txtunselectnamecn = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn")
	arg_1_0._txtunselectnameen = gohelper.findChildText(arg_1_1, "noselected/noactivitynamecn/noactivitynameen")
	arg_1_0._goreddot = gohelper.findChild(arg_1_1, "#go_reddot")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0.go)
	arg_1_0._anim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._openAnimTime = 0.43

	arg_1_0:playEnterAnim()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	if arg_4_0._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	ActivityRpc.instance:sendGetActivityInfosRequest()
	arg_4_0:setRedDotData()
	ActivityModel.instance:setTargetActivityCategoryId(arg_4_0._mo.id)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshItem()

	if Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime > arg_5_0._openAnimTime then
		arg_5_0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function var_0_0._refreshItem(arg_6_0)
	local var_6_0
	local var_6_1
	local var_6_2 = arg_6_0._mo.id
	local var_6_3 = ActivityConfig.instance:getActivityCo(var_6_2)
	local var_6_4 = var_6_3.redDotId
	local var_6_5 = var_6_3.typeId

	arg_6_0._txtnamecn.text = var_6_3.name
	arg_6_0._txtnameen.text = var_6_3.nameEn
	arg_6_0._txtunselectnamecn.text = var_6_3.name
	arg_6_0._txtunselectnameen.text = var_6_3.nameEn

	if arg_6_0._mo.type == ActivityEnum.ActivityType.Normal then
		local var_6_6 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NorSign).showCenter
		local var_6_7 = ActivityConfig.instance:getActivityCenterCo(var_6_6).reddotid

		arg_6_0._selected = var_6_2 == ActivityModel.instance:getTargetActivityCategoryId(var_6_6)

		if var_6_2 == ActivityEnum.Activity.NoviceInsight then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, RedDotEnum.DotNode.ActivityNoviceInsight)

			if arg_6_0._selected then
				RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.ActivityNoviceInsight, false)
			end
		else
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_7, var_6_2)
		end
	elseif arg_6_0._mo.type == ActivityEnum.ActivityType.Beginner then
		arg_6_0._selected = var_6_2 == ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)

		local var_6_8 = ActivityConfig.instance:getActivityCenterCo(ActivityEnum.ActivityType.Beginner).reddotid

		if var_6_2 == ActivityEnum.Activity.DreamShow then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		elseif var_6_2 == DoubleDropModel.instance:getActId() then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_8, var_6_2, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.Activity1_7WarmUp then
			if arg_6_0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(var_6_2)

				local var_6_9 = RedDotConfig.instance:getRedDotCO(var_6_8).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(var_6_9)] = true
				})
			end

			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkIsV1A7WarmupRed, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.Activity1_5WarmUp then
			if arg_6_0._selected then
				Activity146Controller.instance:saveEnterActDateInfo()

				local var_6_10 = RedDotConfig.instance:getRedDotCO(var_6_8).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(var_6_10)] = true
				})
			end

			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkIsAct146NeedReddot, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.Activity1_8WarmUp then
			if arg_6_0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(var_6_2)

				local var_6_11 = RedDotConfig.instance:getRedDotCO(var_6_8).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(var_6_11)] = true
				})
			end

			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkIsV1A8WarmupRed, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.V2a2_TurnBack_H5 then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		elseif var_6_2 == VersionActivity2_2Enum.ActivityId.LimitDecorate then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_8, var_6_2, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.Activity1_9WarmUp or var_6_2 == ActivityEnum.Activity.V2a0_WarmUp or var_6_2 == ActivityEnum.Activity.V2a1_WarmUp or var_6_2 == ActivityEnum.Activity.V2a2_WarmUp or var_6_2 == ActivityEnum.Activity.V2a3_WarmUp or var_6_2 == ActivityEnum.Activity.RoomSign or var_6_2 == ActivityEnum.Activity.V2a5_WarmUp or var_6_2 == ActivityEnum.Activity.V2a6_WarmUp then
			if arg_6_0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(var_6_2)

				local var_6_12 = RedDotConfig.instance:getRedDotCO(var_6_8).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(var_6_12)] = true
				})
			end

			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkIsV1A9WarmupRed, arg_6_0)
		elseif var_6_2 == ActivityEnum.Activity.V2a4_WarmUp then
			if arg_6_0._selected then
				Activity125Controller.instance:saveEnterActDateInfo(var_6_2)

				local var_6_13 = RedDotConfig.instance:getRedDotCO(var_6_8).parent

				RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
					[tonumber(var_6_13)] = true
				})
			end

			RedDotController.instance:addRedDot(arg_6_0._goreddot, reddotid, nil, arg_6_0._checkIsV2a4WarmupRed, arg_6_0)
		elseif var_6_5 == ActivityEnum.ActivityTypeID.Act189 then
			local var_6_14 = {
				{
					id = var_6_4,
					uid = var_6_2
				},
				{
					id = RedDotEnum.DotNode.Activity189Task,
					uid = var_6_2
				},
				{
					id = RedDotEnum.DotNode.Activity189OnceReward,
					uid = var_6_2
				}
			}

			RedDotController.instance:addMultiRedDot(arg_6_0._goreddot, var_6_14)
		elseif var_6_5 == ActivityEnum.ActivityTypeID.Act201 then
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_4, nil, arg_6_0.checkActivityShowFirstEnter, arg_6_0)
		else
			RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_8, arg_6_0._mo.id)
		end
	end

	gohelper.setActive(arg_6_0._goselect, arg_6_0._selected)
	gohelper.setActive(arg_6_0._gounselect, not arg_6_0._selected)
end

function var_0_0.checkActivityShowFirstEnter(arg_7_0, arg_7_1)
	arg_7_1:defaultRefreshDot()

	if not arg_7_1.show then
		arg_7_1.show = ActivityBeginnerController.instance:checkFirstEnter(arg_7_0._mo.id)

		arg_7_1:showRedDot(RedDotEnum.Style.NewTag)
	end
end

function var_0_0.checkActivityNewStage(arg_8_0, arg_8_1)
	arg_8_1:defaultRefreshDot()

	if not arg_8_1.show then
		arg_8_1.show = ActivityBeginnerController.instance:checkActivityNewStage(arg_8_0._mo.id)

		arg_8_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.checkIsAct146NeedReddot(arg_9_0, arg_9_1)
	arg_9_1:defaultRefreshDot()

	if not arg_9_1.show then
		local var_9_0 = Activity146Controller.instance:isActFirstEnterToday()
		local var_9_1 = Activity146Model.instance:isAllEpisodeFinish()
		local var_9_2 = Activity146Model.instance:isHasEpisodeCanReceiveReward()

		arg_9_1.show = var_9_0 and (not var_9_1 or var_9_2)

		arg_9_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.checkIsV1A7WarmupRed(arg_10_0, arg_10_1)
	arg_10_1.show = Activity125Controller.instance:checkActRed(ActivityEnum.Activity.Activity1_7WarmUp)

	arg_10_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0.checkIsV1A8WarmupRed(arg_11_0, arg_11_1)
	arg_11_1.show = Activity125Controller.instance:checkActRed1(ActivityEnum.Activity.Activity1_8WarmUp)

	arg_11_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0.checkIsV1A9WarmupRed(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._mo.id

	arg_12_1.show = Activity125Controller.instance:checkActRed2(var_12_0)

	arg_12_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0.setRedDotData(arg_13_0)
	ActivityBeginnerController.instance:setFirstEnter(arg_13_0._mo.id)
end

function var_0_0.playEnterAnim(arg_14_0)
	local var_14_0 = Mathf.Clamp01((Time.realtimeSinceStartup - ActivityBeginnerCategoryListModel.instance.openViewTime) / arg_14_0._openAnimTime)

	arg_14_0._anim:Play(UIAnimationName.Open, 0, var_14_0)
end

function var_0_0.onDestroy(arg_15_0)
	return
end

function var_0_0._checkIsV2a4WarmupRed(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._mo.id

	arg_16_1.show = Activity125Controller.instance:checkActRed3(var_16_0)

	arg_16_1:showRedDot(RedDotEnum.Style.Normal)
end

return var_0_0
