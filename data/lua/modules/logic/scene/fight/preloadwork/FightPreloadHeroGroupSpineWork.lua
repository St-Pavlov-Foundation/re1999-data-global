module("modules.logic.scene.fight.preloadwork.FightPreloadHeroGroupSpineWork", package.seeall)

local var_0_0 = class("FightPreloadHeroGroupSpineWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getSpineUrlList()

	if var_1_0 and #var_1_0 > 0 then
		arg_1_0._loader = SequenceAbLoader.New()

		arg_1_0._loader:setPathList(var_1_0)
		arg_1_0._loader:setConcurrentCount(10)
		arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
		arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	arg_2_0._needCreateList = {}
	arg_2_0._hasCreateList = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		FightSpinePool.setAssetItem(iter_2_0, iter_2_1)
		table.insert(arg_2_0._needCreateList, iter_2_0)
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	local var_2_1 = #arg_2_0._needCreateList

	if var_2_1 > 0 then
		TaskDispatcher.runRepeat(arg_2_0._createSpineGO, arg_2_0, 0.1, var_2_1)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._createSpineGO(arg_3_0)
	local var_3_0 = table.remove(arg_3_0._needCreateList)
	local var_3_1 = FightSpinePool.getSpine(var_3_0)

	gohelper.setActive(var_3_1, false)

	local var_3_2 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer()

	gohelper.addChild(var_3_2, var_3_1)
	table.insert(arg_3_0._hasCreateList, {
		var_3_0,
		var_3_1
	})

	if #arg_3_0._needCreateList == 0 then
		FightPreloadController.instance:cacheFirstPreloadSpine(arg_3_0._hasCreateList)
		TaskDispatcher.cancelTask(arg_3_0._createSpineGO, arg_3_0)
		arg_3_0:_returnSpineToPool()
		arg_3_0:onDone(true)
	end
end

function var_0_0._returnSpineToPool(arg_4_0)
	if arg_4_0._hasCreateList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._hasCreateList) do
			local var_4_0 = iter_4_1[1]
			local var_4_1 = iter_4_1[2]

			iter_4_1[1] = nil
			iter_4_1[2] = nil

			FightSpinePool.putSpine(var_4_0, var_4_1)
		end
	end

	arg_4_0._needCreateList = nil
	arg_4_0._hasCreateList = nil
end

function var_0_0._onPreloadOneFail(arg_5_0, arg_5_1, arg_5_2)
	logError("战斗Spine加载失败：" .. arg_5_2.ResPath)
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0:_returnSpineToPool()
	TaskDispatcher.cancelTask(arg_6_0._createSpineGO, arg_6_0)

	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end
end

function var_0_0._getSpineUrlList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, 3 do
		local var_7_1 = HeroSingleGroupModel.instance:getById(iter_7_0)
		local var_7_2 = var_7_1:getHeroMO()
		local var_7_3 = var_7_1:getMonsterCO()
		local var_7_4

		if var_7_2 then
			var_7_4 = var_7_2.skin
		elseif var_7_3 then
			var_7_4 = var_7_3.skinId
		end

		if var_7_4 then
			local var_7_5 = true

			if FightHelper.getZongMaoShaLiMianJuPath(var_7_4) then
				var_7_5 = false
			end

			if var_7_5 then
				local var_7_6 = FightConfig.instance:getSkinCO(var_7_4)
				local var_7_7 = ResUrl.getSpineFightPrefabBySkin(var_7_6)

				table.insert(var_7_0, var_7_7)
			end
		end
	end

	return var_7_0
end

return var_0_0
