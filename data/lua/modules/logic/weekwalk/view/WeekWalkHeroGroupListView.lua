module("modules.logic.weekwalk.view.WeekWalkHeroGroupListView", package.seeall)

local var_0_0 = class("WeekWalkHeroGroupListView", HeroGroupListView)

function var_0_0._getHeroItemCls(arg_1_0)
	return WeekWalkHeroGroupHeroItem
end

function var_0_0._checkRestrictHero(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._heroItemList) do
		local var_2_1 = iter_2_1:checkWeekWalkCd()

		if var_2_1 then
			table.insert(var_2_0, var_2_1)
		end
	end

	if #var_2_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	arg_2_0._heroInCdList = var_2_0

	TaskDispatcher.runDelay(arg_2_0._removeWeekWalkInCdHero, arg_2_0, 1.5)
end

function var_0_0._removeWeekWalkInCdHero(arg_3_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not arg_3_0._heroInCdList then
		return
	end

	local var_3_0 = arg_3_0._heroInCdList

	arg_3_0._heroInCdList = nil

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		HeroSingleGroupModel.instance:remove(iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0._heroItemList) do
		iter_3_3:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0.onDestroyView(arg_4_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")
	TaskDispatcher.cancelTask(arg_4_0._removeWeekWalkInCdHero, arg_4_0)
	var_0_0.super.onDestroyView(arg_4_0)
end

return var_0_0
