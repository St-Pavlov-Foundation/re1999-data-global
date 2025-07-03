module("modules.logic.tower.view.fight.TowerHeroGroupListView", package.seeall)

local var_0_0 = class("TowerHeroGroupListView", HeroGroupListView)

function var_0_0._getHeroItemCls(arg_1_0)
	return TowerHeroGroupHeroItem
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:checkReplaceHeroList()
	var_0_0.super.onOpen(arg_2_0)
end

function var_0_0.checkReplaceHeroList(arg_3_0)
	local var_3_0 = TowerModel.instance:getRecordFightParam()

	if var_3_0.isHeroGroupLock then
		local var_3_1 = var_3_0.heros or {}
		local var_3_2 = var_3_0.equipUids or {}
		local var_3_3 = var_3_0.assistBoss
		local var_3_4 = var_3_0.trialHeros or {}
		local var_3_5 = {}

		for iter_3_0 = 1, #var_3_1 do
			local var_3_6 = HeroModel.instance:getByHeroId(var_3_1[iter_3_0] or 0)

			if var_3_6 then
				local var_3_7 = var_3_4[iter_3_0]

				if var_3_7 and var_3_7 > 0 then
					local var_3_8 = lua_hero_trial.configDict[var_3_7][0]
					local var_3_9 = tostring(tonumber(var_3_8.id .. "." .. var_3_8.trialTemplate) - 1099511627776)

					table.insert(var_3_5, {
						heroUid = var_3_9,
						equipUid = {
							tostring(var_3_8.equipId)
						}
					})
				else
					table.insert(var_3_5, {
						heroUid = var_3_6.uid,
						equipUid = var_3_2[iter_3_0]
					})
				end
			else
				for iter_3_1, iter_3_2 in ipairs(var_3_4) do
					if iter_3_2 > 0 then
						local var_3_10 = lua_hero_trial.configDict[iter_3_2][0]

						if var_3_10 and var_3_10.heroId == var_3_1[iter_3_0] then
							local var_3_11 = tostring(tonumber(var_3_10.id .. "." .. var_3_10.trialTemplate) - 1099511627776)

							table.insert(var_3_5, {
								heroUid = var_3_11,
								equipUid = {
									tostring(var_3_10.equipId)
								}
							})

							break
						end
					end
				end
			end
		end

		local var_3_12 = HeroGroupModel.instance:getCurGroupMO()

		var_3_12:replaceTowerHeroList(var_3_5)
		var_3_12:setAssistBossId(var_3_3)
		HeroSingleGroupModel.instance:setSingleGroup(var_3_12, #var_3_5 > 0)
	end
end

function var_0_0._checkRestrictHero(arg_4_0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		return
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._heroItemList) do
		local var_4_1 = iter_4_1:checkTower()

		if var_4_1 then
			table.insert(var_4_0, var_4_1)
		end
	end

	if #var_4_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeTowerHero")

	arg_4_0._heroInCdList = var_4_0

	TaskDispatcher.runDelay(arg_4_0._removeTowerHero, arg_4_0, 1.5)
end

function var_0_0._removeTowerHero(arg_5_0)
	UIBlockMgr.instance:endBlock("removeTowerHero")

	if not arg_5_0._heroInCdList then
		return
	end

	local var_5_0 = arg_5_0._heroInCdList

	arg_5_0._heroInCdList = nil

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		HeroSingleGroupModel.instance:remove(iter_5_1)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0._heroItemList) do
		iter_5_3:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0.canDrag(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_0.super.canDrag(arg_6_0, arg_6_1, arg_6_2) then
		return false
	end

	return true
end

function var_0_0.onDestroyView(arg_7_0)
	UIBlockMgr.instance:endBlock("removeTowerHero")
	TaskDispatcher.cancelTask(arg_7_0._removeTowerHero, arg_7_0)
	var_0_0.super.onDestroyView(arg_7_0)
end

return var_0_0
