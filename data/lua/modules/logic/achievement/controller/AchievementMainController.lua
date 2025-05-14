module("modules.logic.achievement.controller.AchievementMainController", package.seeall)

local var_0_0 = class("AchievementMainController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_1 = arg_1_1 or AchievementEnum.Type.Story

	AchievementMainCommonModel.instance:initDatas(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:cleanTabNew(arg_1_1)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, arg_1_0.notifyUpdateView, arg_1_0)
end

function var_0_0.updateAchievementState(arg_2_0)
	local var_2_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_2_1 = AchievementMainCommonModel.instance:getCurrentViewType()
	local var_2_2 = AchievementMainCommonModel.instance:getCurrentSortType()
	local var_2_3 = AchievementMainCommonModel.instance:getCurrentFilterType()

	AchievementMainCommonModel.instance:initDatas(var_2_0, var_2_1, var_2_2, var_2_3)
end

function var_0_0.onCloseView(arg_3_0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, arg_3_0.notifyUpdateView, arg_3_0)

	local var_3_0 = AchievementMainCommonModel.instance:getCurrentCategory()

	arg_3_0:cleanCategoryNewFlag(var_3_0)
end

function var_0_0.setCategory(arg_4_0, arg_4_1)
	AchievementMainTileModel.instance:resetScrollFocusIndex()
	AchievementMainTileModel.instance:setHasPlayOpenAnim(false)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	local var_4_0 = AchievementMainCommonModel.instance:getCurrentCategory()

	AchievementMainCommonModel.instance:switchCategory(arg_4_1)
	arg_4_0:cleanCategoryNewFlag(var_4_0)
	arg_4_0:cleanTabNew(arg_4_1)
	arg_4_0:dispatchEvent(AchievementEvent.OnSwitchCategory)
	arg_4_0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function var_0_0.switchViewType(arg_5_0, arg_5_1)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)
	AchievementMainCommonModel.instance:switchViewType(arg_5_1)
	arg_5_0:dispatchEvent(AchievementEvent.OnSwitchViewType)
	arg_5_0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function var_0_0.switchSortType(arg_6_0, arg_6_1)
	AchievementMainCommonModel.instance:switchSortType(arg_6_1)
	arg_6_0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function var_0_0.switchSearchFilterType(arg_7_0, arg_7_1)
	AchievementMainCommonModel.instance:switchSearchFilterType(arg_7_1)
	arg_7_0:dispatchEvent(AchievementEvent.AchievementMainViewUpdate)
end

function var_0_0.cleanTabNew(arg_8_0, arg_8_1)
	AchievementMainCommonModel.instance.categoryNewDict[arg_8_1] = false
end

function var_0_0.cleanCategoryNewFlag(arg_9_0, arg_9_1)
	local var_9_0 = AchievementMainCommonModel.instance:getCategoryAchievementConfigList(arg_9_1)
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = AchievementModel.instance:getAchievementTaskCoList(iter_9_1.id)

		if var_9_2 then
			for iter_9_2, iter_9_3 in ipairs(var_9_2) do
				local var_9_3 = AchievementModel.instance:getById(iter_9_3.id)

				if var_9_3 and var_9_3.isNew then
					table.insert(var_9_1, iter_9_3.id)
				end
			end
		end
	end

	if #var_9_1 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(var_9_1)
	end
end

function var_0_0.notifyUpdateView(arg_10_0)
	AchievementMainTileModel.instance:onModelUpdate()
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
