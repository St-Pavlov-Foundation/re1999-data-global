module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryView", package.seeall)

local var_0_0 = class("RoleStoryDispatchStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.itemList = {}
	arg_1_0.goDispatchScroll = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch")
	arg_1_0.goDispatch = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_RolestoryDispatch")
	arg_1_0.content = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	arg_1_0.dispatchType = RoleStoryEnum.DispatchType.Story
	arg_1_0.btnScore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_scorereward")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_scorereward/score/#txt_score")
	arg_1_0.goScoreRed = gohelper.findChild(arg_1_0.viewGO, "#btn_scorereward/#go_rewardredpoint")
	arg_1_0.scoreAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnScore, arg_2_0.onClickBtnScore, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_2_0._onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_2_0._onStoryChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.StoryDispatchUnlock, arg_2_0._onStoryDispatchUnlock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnScore(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function var_0_0._onDispatchStateChange(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0._onUpdateInfo(arg_7_0)
	arg_7_0:refreshScore()
	arg_7_0:refreshView()
end

function var_0_0._onScoreUpdate(arg_8_0)
	arg_8_0:refreshScore()
end

function var_0_0._onStoryChange(arg_9_0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.storyId = arg_10_0.viewParam.storyId

	if not arg_10_0.storyId then
		arg_10_0.storyId = RoleStoryModel.instance:getCurActStoryId()
	end

	arg_10_0:refreshScore()
	arg_10_0:refreshView()
	TaskDispatcher.runDelay(arg_10_0.delayShow, arg_10_0, 0.05)
end

function var_0_0.delayShow(arg_11_0)
	local var_11_0 = RoleStoryModel.instance:getById(arg_11_0.storyId)

	if not var_11_0 then
		return
	end

	if #var_11_0:getNormalDispatchList() == 0 then
		local var_11_1

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.itemList) do
			if iter_11_1.data and RoleStoryEnum.DispatchState.Canget == var_11_0:getDispatchState(iter_11_1.data.id) then
				var_11_1 = iter_11_1

				break
			end
		end

		if not var_11_1 then
			for iter_11_2, iter_11_3 in ipairs(arg_11_0.itemList) do
				if iter_11_3.data and RoleStoryEnum.DispatchState.Normal == var_11_0:getDispatchState(iter_11_3.data.id) then
					var_11_1 = iter_11_3

					break
				end
			end
		end

		if var_11_1 then
			local var_11_2 = var_11_1.viewGO.transform.parent
			local var_11_3 = arg_11_0.content.transform
			local var_11_4 = recthelper.getWidth(var_11_3.parent)
			local var_11_5 = recthelper.getWidth(var_11_3) + 92
			local var_11_6 = math.max(var_11_5 - var_11_4, 0)
			local var_11_7 = recthelper.getAnchorX(var_11_2) - 37
			local var_11_8 = math.min(var_11_7, var_11_6)

			recthelper.setAnchorX(var_11_3, -var_11_8)
		end
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0.storyId = arg_12_0.viewParam.storyId

	arg_12_0:refreshScore()
	arg_12_0:refreshView()
end

function var_0_0.refreshView(arg_13_0)
	local var_13_0 = RoleStoryConfig.instance:getDispatchList(arg_13_0.storyId, arg_13_0.dispatchType) or {}

	for iter_13_0 = 1, math.max(#var_13_0, #arg_13_0.itemList) do
		arg_13_0:refreshDispatchItem(arg_13_0.itemList[iter_13_0], var_13_0[iter_13_0], iter_13_0)
	end
end

function var_0_0.refreshDispatchItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1 = arg_14_1 or arg_14_0:createItem(arg_14_3)

	arg_14_1:onUpdateMO(arg_14_2, arg_14_3)
end

function var_0_0.createItem(arg_15_0, arg_15_1)
	local var_15_0 = gohelper.findChild(arg_15_0.goDispatch, string.format("Item/#go_item%s", arg_15_1))
	local var_15_1 = arg_15_0.viewContainer:getSetting().otherRes.storyItemRes
	local var_15_2 = arg_15_0.viewContainer:getResInst(var_15_1, var_15_0, "go")
	local var_15_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, RoleStoryDispatchStoryItem)

	var_15_3.scrollDesc.parentGameObject = arg_15_0.goDispatchScroll
	arg_15_0.itemList[arg_15_1] = var_15_3

	return var_15_3
end

function var_0_0.refreshScore(arg_16_0)
	local var_16_0 = arg_16_0.storyId
	local var_16_1 = RoleStoryModel.instance:getById(var_16_0)
	local var_16_2 = var_16_1 and var_16_1:getScore() or 0

	arg_16_0.txtScore.text = var_16_2

	local var_16_3 = var_16_1 and var_16_1:hasScoreReward()

	gohelper.setActive(arg_16_0.goScoreRed, var_16_3)

	if var_16_3 then
		arg_16_0.scoreAnim:Play("loop")
	else
		arg_16_0.scoreAnim:Play("idle")
	end
end

function var_0_0._onStoryDispatchUnlock(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.playUnlockAudio, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0.playUnlockAudio, arg_17_0, 0.05)
end

function var_0_0.playUnlockAudio(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_unlock)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0.playUnlockAudio, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delayShow, arg_20_0)
end

return var_0_0
