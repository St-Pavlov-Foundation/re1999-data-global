module("modules.logic.dungeon.view.map.DungeonMapElementReward", package.seeall)

local var_0_0 = class("DungeonMapElementReward", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_6_0._OnRemoveElement, arg_6_0, LuaEventSystem.High)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	arg_6_0:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeCompleted, arg_6_0._onMazeCompleted, arg_6_0)
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._lastViewName then
		if arg_7_0._rewardPoint then
			arg_7_0:_dispatchEvent()
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
	end
end

function var_0_0._onMazeCompleted(arg_8_0)
	arg_8_0._lastViewName = ViewName.CommonPropView
end

function var_0_0.setShowToastState(arg_9_0, arg_9_1)
	arg_9_0.notShowToast = arg_9_1
end

function var_0_0._OnRemoveElement(arg_10_0, arg_10_1)
	local var_10_0 = lua_chapter_map_element.configDict[arg_10_1]

	arg_10_0._lastViewName = nil
	arg_10_0._rewardPoint = nil

	local var_10_1 = DungeonModel.instance:getMapElementReward(arg_10_1)

	if not string.nilorempty(var_10_1) then
		local var_10_2 = GameUtil.splitString2(var_10_1, false, "|", "#")
		local var_10_3 = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_4 = MaterialDataMO.New()

			var_10_4:initValue(iter_10_1[1], iter_10_1[2], iter_10_1[3])
			table.insert(var_10_3, var_10_4)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_10_3)

		arg_10_0._lastViewName = ViewName.CommonPropView
	end

	if var_10_0.fragment > 0 then
		local var_10_5 = lua_chapter_map_fragment.configDict[var_10_0.fragment]

		if var_10_5 and var_10_5.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			arg_10_0._lastViewName = ViewName.VersionActivityNewsView
		elseif var_10_0.type == DungeonEnum.ElementType.SpStory then
			-- block empty
		elseif var_10_0.type == DungeonEnum.ElementType.Investigate then
			arg_10_0._lastViewName = ViewName.InvestigateTipsView
		else
			arg_10_0._lastViewName = ViewName.DungeonFragmentInfoView
		end

		if arg_10_0._lastViewName then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, arg_10_0._lastViewName, {
				elementId = var_10_0.id,
				fragmentId = var_10_0.fragment,
				notShowToast = arg_10_0.notShowToast
			})
		end
	end

	if var_10_0.type == DungeonEnum.ElementType.EnterDialogue then
		arg_10_0._lastViewName = ViewName.DialogueView
	end

	if arg_10_0._lastViewName then
		DungeonController.instance:dispatchEvent(DungeonEvent.BeginShowRewardView)
	end

	if var_10_0.rewardPoint > 0 then
		arg_10_0._rewardPoint = var_10_0.rewardPoint

		if not arg_10_0._lastViewName then
			arg_10_0:_dispatchEvent()
		end
	end
end

function var_0_0._dispatchEvent(arg_11_0)
	DungeonModel.instance:endCheckUnlockChapter()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddRewardPoint, arg_11_0._rewardPoint)

	arg_11_0._rewardPoint = nil
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
