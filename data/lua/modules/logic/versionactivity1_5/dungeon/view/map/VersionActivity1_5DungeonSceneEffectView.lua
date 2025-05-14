module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonSceneEffectView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonSceneEffectView", BaseView)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.dayTimeEffectGoPool = nil
	arg_4_0.nightEffectGoPool = nil

	arg_4_0:createScenePoolRoot()
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_4_0.onDisposeOldMap, arg_4_0)
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_4_0.onLoadSceneFinish, arg_4_0)
end

function var_0_0.createScenePoolRoot(arg_5_0)
	local var_5_0 = CameraMgr.instance:getSceneRoot()
	local var_5_1 = gohelper.findChild(var_5_0, VersionActivity1_5DungeonEnum.SceneRootName)

	arg_5_0.effectPoolRoot = UnityEngine.GameObject.New("effectPoolRoot")

	gohelper.addChild(var_5_1, arg_5_0.effectPoolRoot)
	gohelper.setActive(arg_5_0.effectPoolRoot, false)
	transformhelper.setLocalPos(arg_5_0.effectPoolRoot.transform, 0, 0, 0)
end

function var_0_0.onDisposeOldMap(arg_6_0)
	arg_6_0:recycleEffectGo()
end

function var_0_0.onLoadSceneFinish(arg_7_0, arg_7_1)
	arg_7_0.sceneGo = arg_7_1.mapSceneGo
	arg_7_0.mapConfig = arg_7_1.mapConfig
	arg_7_0.goEffectRoot = gohelper.findChild(arg_7_0.sceneGo, "SceneEffect")

	arg_7_0:addSceneEffect()
end

function var_0_0.addSceneEffect(arg_8_0)
	if not arg_8_0.activityDungeonMo:isHardMode() then
		gohelper.setActive(arg_8_0.goEffectRoot, false)

		return
	end

	gohelper.setActive(arg_8_0.goEffectRoot, true)

	if VersionActivity1_5DungeonEnum.MapId2Light[arg_8_0.mapConfig.id] then
		if not arg_8_0.dayTimeEffectGo then
			arg_8_0:createDayTimeGo()
		else
			arg_8_0:refreshEffect()
		end
	elseif not arg_8_0.nightEffectGo then
		arg_8_0:createNightTimeGo()
	else
		arg_8_0:refreshEffect()
	end
end

function var_0_0.getEffectLoader(arg_9_0)
	if arg_9_0.effectLoader then
		return arg_9_0.effectLoader
	end

	arg_9_0.effectLoader = MultiAbLoader.New()

	arg_9_0.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.DayTime)
	arg_9_0.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.Night)
	arg_9_0.effectLoader:startLoad(arg_9_0.onEffectLoadDone, arg_9_0)

	return arg_9_0.effectLoader
end

function var_0_0.onEffectLoadDone(arg_10_0)
	arg_10_0:createDayTimeGo()
	arg_10_0:createNightTimeGo()
end

function var_0_0.createDayTimeGo(arg_11_0)
	if not VersionActivity1_5DungeonEnum.MapId2Light[arg_11_0.mapConfig.id] then
		return
	end

	if arg_11_0.dayTimeEffectGoPool then
		arg_11_0.dayTimeEffectGo = arg_11_0.dayTimeEffectGoPool
		arg_11_0.dayTimeEffectGoPool = nil

		gohelper.addChild(arg_11_0.goEffectRoot, arg_11_0.dayTimeEffectGo)
		arg_11_0:refreshEffect()

		return
	end

	local var_11_0 = arg_11_0:getEffectLoader()

	if var_11_0.isLoading then
		return
	end

	local var_11_1 = var_11_0:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.DayTime):GetResource()

	arg_11_0.dayTimeEffectGo = gohelper.clone(var_11_1, arg_11_0.goEffectRoot)

	arg_11_0:refreshEffect()
end

function var_0_0.createNightTimeGo(arg_12_0)
	if VersionActivity1_5DungeonEnum.MapId2Light[arg_12_0.mapConfig.id] then
		return
	end

	if arg_12_0.nightEffectGoPool then
		arg_12_0.nightEffectGo = arg_12_0.nightEffectGoPool
		arg_12_0.nightEffectGoPool = nil

		gohelper.addChild(arg_12_0.goEffectRoot, arg_12_0.nightEffectGo)
		arg_12_0:refreshEffect()

		return
	end

	local var_12_0 = arg_12_0:getEffectLoader()

	if var_12_0.isLoading then
		return
	end

	local var_12_1 = var_12_0:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.Night):GetResource()

	arg_12_0.nightEffectGo = gohelper.clone(var_12_1, arg_12_0.goEffectRoot)

	arg_12_0:refreshEffect()
end

function var_0_0.refreshEffect(arg_13_0)
	if not arg_13_0.activityDungeonMo:isHardMode() then
		gohelper.setActive(arg_13_0.goEffectRoot, false)

		return
	end

	local var_13_0 = VersionActivity1_5DungeonEnum.MapId2Light[arg_13_0.mapConfig.id]

	if arg_13_0.dayTimeEffectGo then
		gohelper.setActive(arg_13_0.dayTimeEffectGo, var_13_0)
	end

	if arg_13_0.nightEffectGo then
		gohelper.setActive(arg_13_0.nightEffectGo, not var_13_0)
	end
end

function var_0_0.recycleEffectGo(arg_14_0)
	if arg_14_0.dayTimeEffectGo then
		gohelper.addChild(arg_14_0.effectPoolRoot, arg_14_0.dayTimeEffectGo)

		arg_14_0.dayTimeEffectGoPool = arg_14_0.dayTimeEffectGo
		arg_14_0.dayTimeEffectGo = nil
	end

	if arg_14_0.nightEffectGo then
		gohelper.addChild(arg_14_0.effectPoolRoot, arg_14_0.nightEffectGo)

		arg_14_0.nightEffectGoPool = arg_14_0.nightEffectGo
		arg_14_0.nightEffectGo = nil
	end
end

function var_0_0.onDestroy(arg_15_0)
	if arg_15_0.effectLoader then
		arg_15_0.effectLoader:dispose()
	end
end

return var_0_0
