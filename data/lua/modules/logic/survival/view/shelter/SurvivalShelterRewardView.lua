module("modules.logic.survival.view.shelter.SurvivalShelterRewardView", package.seeall)

local var_0_0 = class("SurvivalShelterRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/title/#txt_score")
	arg_1_0._gonormalline = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	arg_1_0._rectnormalline = arg_1_0._gonormalline.transform
	arg_1_0.startSpace = 2
	arg_1_0.cellWidth = 268
	arg_1_0.space = 0
	arg_1_0.rewardIndex = 30

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnReward, arg_2_0.onClickReward, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnGainReward, arg_2_0.onGainReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnReward)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnGainReward, arg_3_0.onGainReward, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickReward(arg_5_0)
	arg_5_0.viewContainer:getScrollView():moveToByIndex(arg_5_0.rewardIndex - 3, 1, arg_5_0.openRewardView, arg_5_0)
end

function var_0_0.openRewardView(arg_6_0)
	local var_6_0 = SurvivalShelterRewardListModel.instance:getList()[arg_6_0.rewardIndex]

	if not var_6_0 then
		return
	end

	local var_6_1 = DungeonConfig.instance:getRewardItems(tonumber(var_6_0.reward))
	local var_6_2 = var_6_1 and var_6_1[1]

	if not var_6_2 then
		return
	end

	MaterialTipController.instance:showMaterialInfo(var_6_2[1], var_6_2[2])
end

function var_0_0.onGainReward(arg_7_0)
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0:refreshReward()
	arg_9_0:refreshProgress()
end

function var_0_0.refreshProgress(arg_10_0)
	local var_10_0 = SurvivalModel.instance:getOutSideInfo()
	local var_10_1 = var_10_0:getScore()

	arg_10_0._txtScore.text = var_10_1

	local var_10_2 = SurvivalShelterRewardListModel.instance:getList()
	local var_10_3 = #var_10_2
	local var_10_4

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		if var_10_4 == nil and not var_10_0:isGainReward(iter_10_1.id) then
			var_10_4 = iter_10_0
		end

		if var_10_1 < iter_10_1.score then
			var_10_3 = iter_10_0 - 1

			break
		end
	end

	local var_10_5 = var_10_2[var_10_3] and var_10_2[var_10_3].score or 0
	local var_10_6 = var_10_2[var_10_3 + 1] and var_10_2[var_10_3 + 1].score or var_10_5
	local var_10_7 = 0
	local var_10_8 = arg_10_0:getNodeWidth(var_10_3, var_10_7)
	local var_10_9 = arg_10_0:getNodeWidth(var_10_3 + 1, var_10_7) - var_10_8
	local var_10_10 = 0

	if var_10_5 < var_10_6 then
		var_10_10 = (var_10_1 - var_10_5) / (var_10_6 - var_10_5) * var_10_9
	end

	recthelper.setWidth(arg_10_0._rectnormalline, var_10_8 + var_10_10)

	if not arg_10_0.isPlayMove then
		arg_10_0.isPlayMove = true

		if var_10_4 ~= nil then
			arg_10_0.viewContainer:getScrollView():moveToByIndex(var_10_4, 0.2)
		end
	end
end

function var_0_0.getNodeWidth(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or 0

	local var_11_0 = arg_11_2

	if arg_11_1 > 0 then
		var_11_0 = (arg_11_1 - 1) * (arg_11_0.cellWidth + arg_11_0.space) + (arg_11_0.startSpace + arg_11_0.cellWidth * 0.5) + arg_11_2
	end

	return var_11_0
end

function var_0_0.refreshReward(arg_12_0)
	SurvivalShelterRewardListModel.instance:refreshList()
end

function var_0_0.checkGetReward(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = RoleStoryConfig.instance:getRewardList(arg_13_0.storyId)

	if var_13_1 then
		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			if RoleStoryModel.instance:getRewardState(iter_13_1.storyId, iter_13_1.id, iter_13_1.score) == 1 then
				table.insert(var_13_0, iter_13_1.id)
			end
		end
	end

	if #var_13_0 > 0 then
		HeroStoryRpc.instance:sendGetScoreBonusRequest(var_13_0)
	end
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.checkGetReward, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
