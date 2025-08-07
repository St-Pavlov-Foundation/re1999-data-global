module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapElementReward", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapElementReward", BaseView)

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
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._lastViewName then
		if arg_7_0._rewardPoint then
			arg_7_0:_dispatchEvent()
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
	end
end

function var_0_0.setShowToastState(arg_8_0, arg_8_1)
	arg_8_0.notShowToast = arg_8_1
end

function var_0_0._OnRemoveElement(arg_9_0, arg_9_1)
	local var_9_0 = lua_chapter_map_element.configDict[arg_9_1]

	arg_9_0._lastViewName = nil
	arg_9_0._rewardPoint = nil

	local var_9_1 = DungeonModel.instance:getMapElementReward(arg_9_1)

	if not string.nilorempty(var_9_1) then
		local var_9_2 = GameUtil.splitString2(var_9_1, false, "|", "#")
		local var_9_3 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			local var_9_4 = MaterialDataMO.New()

			var_9_4:initValue(iter_9_1[1], iter_9_1[2], iter_9_1[3])
			table.insert(var_9_3, var_9_4)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_9_3)

		arg_9_0._lastViewName = ViewName.CommonPropView
	end

	if var_9_0.fragment > 0 then
		local var_9_5 = lua_chapter_map_fragment.configDict[var_9_0.fragment]

		if var_9_5 and var_9_5.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			arg_9_0._lastViewName = ViewName.VersionActivityNewsView
		elseif var_9_0.type == DungeonEnum.ElementType.SpStory then
			if var_9_5 and var_9_5.type == DungeonEnum.FragmentType.AvgStory then
				arg_9_0._lastViewName = ViewName.StoryView
			end
		elseif var_9_0.type == DungeonEnum.ElementType.Investigate then
			arg_9_0._lastViewName = ViewName.InvestigateTipsView
		else
			arg_9_0._lastViewName = ViewName.VersionActivity2_9DungeonFragmentInfoView
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, arg_9_0._lastViewName, {
			elementId = var_9_0.id,
			fragmentId = var_9_0.fragment,
			notShowToast = arg_9_0.notShowToast
		})
	end

	if arg_9_0._lastViewName then
		DungeonController.instance:dispatchEvent(DungeonEvent.BeginShowRewardView)
	end

	if var_9_0.rewardPoint > 0 then
		arg_9_0._rewardPoint = var_9_0.rewardPoint

		if not arg_9_0._lastViewName then
			arg_9_0:_dispatchEvent()
		end
	end
end

function var_0_0._dispatchEvent(arg_10_0)
	DungeonModel.instance:endCheckUnlockChapter()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddRewardPoint, arg_10_0._rewardPoint)

	arg_10_0._rewardPoint = nil
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
