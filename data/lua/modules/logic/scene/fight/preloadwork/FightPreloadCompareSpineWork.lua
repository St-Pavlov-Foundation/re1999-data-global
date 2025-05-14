module("modules.logic.scene.fight.preloadwork.FightPreloadCompareSpineWork", package.seeall)

local var_0_0 = class("FightPreloadCompareSpineWork", BaseWork)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightPreloadController.instance.cachePreloadSpine

	if var_1_0 then
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)) do
			local var_1_2 = FightConfig.instance:getSkinCO(iter_1_1.skin)

			var_1_1[ResUrl.getSpineFightPrefabBySkin(var_1_2)] = true
		end

		for iter_1_2, iter_1_3 in ipairs(FightDataHelper.entityMgr:getMySubList()) do
			local var_1_3 = FightConfig.instance:getSkinCO(iter_1_3.skin)

			var_1_1[ResUrl.getSpineFightPrefabBySkin(var_1_3)] = true
		end

		for iter_1_4, iter_1_5 in pairs(var_1_0) do
			if not var_1_1[iter_1_4] then
				FightSpinePool.releaseUrl(iter_1_4)
				FightPreloadController.instance:releaseAsset(iter_1_4)

				var_1_0[iter_1_4] = nil
			end
		end

		FightPreloadController.instance:cacheFirstPreloadSpine()
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
