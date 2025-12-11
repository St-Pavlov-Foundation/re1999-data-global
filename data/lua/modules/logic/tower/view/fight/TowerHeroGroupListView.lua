module("modules.logic.tower.view.fight.TowerHeroGroupListView", package.seeall)

local var_0_0 = class("TowerHeroGroupListView", HeroGroupListView)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_1_0._checkRestrictHero, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	var_0_0.super.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_2_0._checkRestrictHero, arg_2_0)
end

function var_0_0._getHeroItemCls(arg_3_0)
	return TowerHeroGroupHeroItem
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:checkReplaceHeroList()
	var_0_0.super.onOpen(arg_4_0)
end

function var_0_0.checkReplaceHeroList(arg_5_0)
	local var_5_0 = TowerModel.instance:getRecordFightParam()

	if var_5_0.isHeroGroupLock then
		local var_5_1 = var_5_0.heros or {}
		local var_5_2 = var_5_0.equipUids or {}
		local var_5_3 = var_5_0.assistBoss
		local var_5_4 = var_5_0.trialHeros or {}
		local var_5_5 = {}

		for iter_5_0 = 1, #var_5_1 do
			local var_5_6 = HeroModel.instance:getByHeroId(var_5_1[iter_5_0] or 0)

			if var_5_6 then
				local var_5_7 = var_5_4[iter_5_0]

				if var_5_7 and var_5_7 > 0 then
					local var_5_8 = lua_hero_trial.configDict[var_5_7][0]
					local var_5_9 = tostring(tonumber(var_5_8.id .. "." .. var_5_8.trialTemplate) - 1099511627776)

					table.insert(var_5_5, {
						heroUid = var_5_9,
						equipUid = {
							tostring(var_5_8.equipId)
						}
					})
				else
					table.insert(var_5_5, {
						heroUid = var_5_6.uid,
						equipUid = var_5_2[iter_5_0]
					})
				end
			else
				for iter_5_1, iter_5_2 in ipairs(var_5_4) do
					if iter_5_2 > 0 then
						local var_5_10 = lua_hero_trial.configDict[iter_5_2][0]

						if var_5_10 and var_5_10.heroId == var_5_1[iter_5_0] then
							local var_5_11 = tostring(tonumber(var_5_10.id .. "." .. var_5_10.trialTemplate) - 1099511627776)

							table.insert(var_5_5, {
								heroUid = var_5_11,
								equipUid = {
									tostring(var_5_10.equipId)
								}
							})

							break
						end
					end
				end
			end
		end

		local var_5_12 = HeroGroupModel.instance:getCurGroupMO()

		var_5_12:replaceTowerHeroList(var_5_5)
		var_5_12:setAssistBossId(var_5_3)
		HeroSingleGroupModel.instance:setSingleGroup(var_5_12, #var_5_5 > 0)
	end
end

function var_0_0._checkRestrictHero(arg_6_0)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		return
	end

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._heroItemList) do
		local var_6_1 = iter_6_1:checkTower()

		if var_6_1 then
			table.insert(var_6_0, var_6_1)
		end
	end

	if #var_6_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeTowerHero")

	arg_6_0._heroInCdList = var_6_0

	TaskDispatcher.runDelay(arg_6_0._removeTowerHero, arg_6_0, 1.5)
end

function var_0_0._removeTowerHero(arg_7_0)
	UIBlockMgr.instance:endBlock("removeTowerHero")

	if not arg_7_0._heroInCdList then
		return
	end

	local var_7_0 = arg_7_0._heroInCdList

	arg_7_0._heroInCdList = nil

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		HeroSingleGroupModel.instance:remove(iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0._heroItemList) do
		iter_7_3:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:replaceSingleGroup()
end

function var_0_0.canDrag(arg_8_0, arg_8_1, arg_8_2)
	if not var_0_0.super.canDrag(arg_8_0, arg_8_1, arg_8_2) then
		return false
	end

	return true
end

function var_0_0.onDestroyView(arg_9_0)
	UIBlockMgr.instance:endBlock("removeTowerHero")
	TaskDispatcher.cancelTask(arg_9_0._removeTowerHero, arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)
end

return var_0_0
