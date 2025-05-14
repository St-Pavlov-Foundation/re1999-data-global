module("modules.logic.explore.map.unit.ExploreIce", package.seeall)

local var_0_0 = class("ExploreIce", ExploreBaseDisplayUnit)

function var_0_0.onRoleEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, true)
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)

	if arg_1_3:isRole() and arg_1_2 and ExploreModel.instance:isHeroInControl() then
		local var_1_0 = ExploreHelper.getKey(arg_1_0.nodePos)
		local var_1_1 = ExploreMapModel.instance:getNode(var_1_0).height
		local var_1_2 = arg_1_1 - arg_1_2
		local var_1_3 = ExploreController.instance:getMap()
		local var_1_4 = arg_1_0.nodePos
		local var_1_5 = var_1_3:getUnitByPos(var_1_2 + arg_1_1)
		local var_1_6
		local var_1_7 = ExploreHelper.getKey(var_1_2 + arg_1_1)
		local var_1_8 = ExploreMapModel.instance:getNode(var_1_7)

		if var_1_8 and var_1_8:isWalkable(var_1_1) then
			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				if iter_1_1:getUnitType() == ExploreEnum.ItemType.Ice then
					var_1_6 = iter_1_1
					var_1_4 = arg_1_1 + var_1_2
				end
			end
		end

		while var_1_6 do
			local var_1_9 = var_1_2 + var_1_4
			local var_1_10 = var_1_3:getUnitByPos(var_1_9)
			local var_1_11 = ExploreHelper.getKey(var_1_9)
			local var_1_12 = ExploreMapModel.instance:getNode(var_1_11)

			var_1_6 = nil

			if var_1_12 and var_1_12:isWalkable(var_1_1) then
				for iter_1_2, iter_1_3 in ipairs(var_1_10) do
					if iter_1_3:getUnitType() == ExploreEnum.ItemType.Ice then
						var_1_6 = iter_1_3
						var_1_4 = var_1_2 + var_1_4
					end
				end
			end
		end

		local var_1_13 = var_1_2 + var_1_4
		local var_1_14 = ExploreHelper.getKey(var_1_13)
		local var_1_15 = ExploreMapModel.instance:getNode(var_1_14)

		if var_1_15 and var_1_15:isWalkable(var_1_1) then
			var_1_4 = var_1_13
		end

		if var_1_4 ~= arg_1_0.nodePos then
			ExploreController.instance:dispatchEvent(ExploreEvent.MoveHeroToPos, var_1_4, arg_1_0.onIceMoveEnd, arg_1_0)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Ice)
			arg_1_3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Glide)
			ExploreRpc.instance:sendExploreMoveRequest(var_1_4.x, var_1_4.y)
		end
	end
end

function var_0_0.canTrigger(arg_2_0)
	return false
end

function var_0_0.onRoleStay(arg_3_0)
	return
end

function var_0_0.onRoleLeave(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	end
end

function var_0_0.onIceMoveEnd(arg_5_0)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Ice)
end

return var_0_0
