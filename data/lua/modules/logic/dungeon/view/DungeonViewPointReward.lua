module("modules.logic.dungeon.view.DungeonViewPointReward", package.seeall)

local var_0_0 = class("DungeonViewPointReward", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntipreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#btn_tipreward")
	arg_1_0._txtrewardprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_story/#btn_tipreward/#txt_rewardprogress")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "#go_story/#btn_tipreward/#go_rewardredpoint")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntipreward:AddClickListener(arg_2_0._btntiprewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntipreward:RemoveClickListener()
end

function var_0_0._btntiprewardOnClick(arg_4_0)
	DungeonController.instance:openDungeonCumulativeRewardsView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animTipsReward = arg_5_0._btntipreward.gameObject:GetComponent(typeof(UnityEngine.Animation))

	arg_5_0:_updateMapTip()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnGetPointReward, arg_7_0._updateMapTip, arg_7_0)
end

function var_0_0.onOpenFinish(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_9_0._onCloseViewFinish, arg_9_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnGetPointReward, arg_9_0._updateMapTip, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshProgress, arg_9_0)
end

function var_0_0._onCloseViewFinish(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == ViewName.DungeonMapView then
		arg_10_0:_updateMapTip()
	end
end

function var_0_0._isShowBtnGift(arg_11_0)
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ChapterReward)
end

function var_0_0._updateMapTip(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._refreshProgress, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._refreshProgress, arg_12_0, 0)
end

function var_0_0._refreshProgress(arg_13_0)
	local var_13_0 = arg_13_0:_isShowBtnGift()

	gohelper.setActive(arg_13_0._btntipreward.gameObject, var_13_0)

	if not var_13_0 then
		return
	end

	arg_13_0._maxChapterId = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId

	local var_13_1 = DungeonMapModel.instance:canGetRewardsList(arg_13_0._maxChapterId)

	if var_13_1 and #var_13_1 > 0 then
		arg_13_0._animTipsReward:Play("btn_tipreward_loop")
		gohelper.setActive(arg_13_0._gorewardredpoint, true)
	else
		arg_13_0._animTipsReward:Play("btn_tipreward")
		gohelper.setActive(arg_13_0._gorewardredpoint, false)
	end

	local var_13_2 = DungeonMapModel.instance:getRewardPointInfo()
	local var_13_3 = DungeonMapModel.instance:getUnfinishedTargetReward()

	arg_13_0._txtrewardprogress.text = string.format("%s/%s", var_13_2.rewardPoint, var_13_3.rewardPointNum)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
