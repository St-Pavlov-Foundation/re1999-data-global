module("modules.logic.scene.fight.preloadwork.FightPreloadSpineWork", package.seeall)

local var_0_0 = class("FightPreloadSpineWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getSpineUrlList()

	arg_1_0._loader = SequenceAbLoader.New()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0._loader:addPath(iter_1_1)
	end

	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("战斗Spine加载失败：" .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getSpineUrlList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.context.mySkinIds) do
		local var_5_1 = FightConfig.instance:getSkinCO(iter_5_1)

		if var_5_1 and not string.nilorempty(var_5_1.spine) then
			var_5_0[ResUrl.getSpineFightPrefabBySkin(var_5_1)] = true
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(iter_5_1, var_5_0)
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.context.enemySkinIds) do
		local var_5_2 = FightConfig.instance:getSkinCO(iter_5_3)

		if var_5_2 and not string.nilorempty(var_5_2.spine) then
			var_5_0[ResUrl.getSpineFightPrefabBySkin(var_5_2)] = true
		end
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.context.subSkinIds) do
		local var_5_3 = FightConfig.instance:getSkinCO(iter_5_5)

		if var_5_3 and not string.nilorempty(var_5_3.alternateSpine) then
			var_5_0[ResUrl.getSpineFightPrefab(var_5_3.alternateSpine)] = true
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(iter_5_5, var_5_0)
	end

	local var_5_4 = FightHelper.preloadXingTiSpecialUrl(arg_5_0.context.myModelIds, arg_5_0.context.enemyModelIds)
	local var_5_5 = {}

	for iter_5_6, iter_5_7 in pairs(var_5_0) do
		if FightHelper.XingTiSpineUrl2Special[iter_5_6] and var_5_4 then
			if var_5_4 == 1 then
				iter_5_6 = FightHelper.XingTiSpineUrl2Special[iter_5_6]
			elseif var_5_4 == 2 then
				table.insert(var_5_5, FightHelper.XingTiSpineUrl2Special[iter_5_6])
			end
		end

		table.insert(var_5_5, iter_5_6)
	end

	return var_5_5
end

return var_0_0
