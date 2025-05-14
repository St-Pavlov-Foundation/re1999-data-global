module("modules.logic.guide.controller.invalidcondition.GuideInvalidCondition", package.seeall)

local var_0_0 = _M

function var_0_0.checkSetEquip()
	local var_1_0 = HeroGroupModel.instance:getCustomHeroGroupMo(ModuleEnum.HeroGroupServerType.Equip)

	if not var_1_0 then
		return false
	end

	local var_1_1 = var_1_0:getAllPosEquips()

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		if iter_1_1 and iter_1_1.equipUid and iter_1_1.equipUid[1] ~= "0" then
			return true
		end
	end

	return false
end

function var_0_0.checkAllGroupSetEquip()
	local var_2_0 = HeroGroupModel.instance:getList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = iter_2_1:getAllPosEquips()

		for iter_2_2, iter_2_3 in pairs(var_2_1) do
			if iter_2_3 and iter_2_3.equipUid and iter_2_3.equipUid[1] ~= "0" then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkSummon()
	local var_3_0 = HeroModel.instance:getList()

	return var_3_0 and #var_3_0 > 1
end

function var_0_0.checkMainSceneSkin()
	return MainSceneSwitchModel.instance:getCurSceneId() ~= MainSceneSwitchConfig.instance:getDefaultSceneId()
end

function var_0_0.checkFinishElement4_6()
	return DungeonMapModel.instance:elementIsFinished(1040601)
end

function var_0_0.checkFinishGuide(arg_6_0, arg_6_1)
	return GuideModel.instance:isGuideFinish(tonumber(arg_6_1[3]))
end

function var_0_0.checkViewsIsClose(arg_7_0, arg_7_1)
	if not GuideModel.instance:getById(arg_7_0) then
		return false
	end

	local var_7_0 = {
		unpack(arg_7_1, 3)
	}
	local var_7_1 = true

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if ViewMgr.instance:isOpen(iter_7_1) then
			var_7_1 = false

			break
		end
	end

	return var_7_1
end

return var_0_0
