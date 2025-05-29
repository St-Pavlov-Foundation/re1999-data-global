module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupListView", package.seeall)

local var_0_0 = class("WeekWalk_2HeroGroupListView", HeroGroupListView)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupFinish, arg_1_0._checkRestrictHero, arg_1_0)
end

function var_0_0._getHeroItemCls(arg_2_0)
	return WeekWalk_2HeroGroupHeroItem
end

function var_0_0._checkRestrictHero(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._heroItemList) do
		local var_3_1 = iter_3_1:checkWeekWalkCd()

		if var_3_1 then
			table.insert(var_3_0, var_3_1)
		end
	end

	if #var_3_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	arg_3_0._heroInCdList = var_3_0

	TaskDispatcher.runDelay(arg_3_0._removeWeekWalkInCdHero, arg_3_0, 1.5)
end

function var_0_0._removeWeekWalkInCdHero(arg_4_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not arg_4_0._heroInCdList then
		return
	end

	local var_4_0 = arg_4_0._heroInCdList

	arg_4_0._heroInCdList = nil

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		HeroSingleGroupModel.instance:remove(iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._heroItemList) do
		iter_4_3:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0.onDestroyView(arg_5_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")
	TaskDispatcher.cancelTask(arg_5_0._removeWeekWalkInCdHero, arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
end

return var_0_0
