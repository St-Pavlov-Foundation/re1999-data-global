module("modules.logic.commandstation.view.CommandStationEnterSceneView", package.seeall)

local var_0_0 = class("CommandStationEnterSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_1_1 = CameraMgr.instance:getSceneRoot()

	arg_1_0._sceneRoot = UnityEngine.GameObject.New("CommandStationEnterScene")

	local var_1_2, var_1_3, var_1_4 = transformhelper.getLocalPos(var_1_0)

	transformhelper.setLocalPos(arg_1_0._sceneRoot.transform, 0, var_1_3, 0)
	gohelper.addChild(var_1_1, arg_1_0._sceneRoot)
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:loadMap()
end

function var_0_0.loadMap(arg_3_0)
	if arg_3_0._mapLoader then
		if arg_3_0._mapLoader.isLoading then
			arg_3_0._mapLoader:dispose()
		else
			arg_3_0._oldMapLoader = arg_3_0._mapLoader
		end
	end

	local var_3_0 = 1
	local var_3_1 = var_3_0 == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2

	arg_3_0._mapCfg = lua_chapter_map.configDict[var_3_1]
	arg_3_0._mapLoader = MultiAbLoader.New()

	local var_3_2 = {}

	arg_3_0:buildLoadRes(var_3_2, arg_3_0._mapCfg, var_3_0)

	arg_3_0._sceneUrl = var_3_2[1]
	arg_3_0._mapLightUrl = var_3_2[2]
	arg_3_0._mapEffectUrl = var_3_2[3]

	arg_3_0._mapLoader:addPath(arg_3_0._sceneUrl)
	arg_3_0._mapLoader:addPath(arg_3_0._mapLightUrl)

	if arg_3_0._mapEffectUrl then
		arg_3_0._mapLoader:addPath(arg_3_0._mapEffectUrl)
	end

	arg_3_0._mapLoader:startLoad(arg_3_0._loadSceneFinish, arg_3_0)
end

function var_0_0.buildLoadRes(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	table.insert(arg_4_1, ResUrl.getDungeonMapRes(arg_4_2.res))
	table.insert(arg_4_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	if arg_4_3 == 2 then
		table.insert(arg_4_1, "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect3.prefab")
	end
end

function var_0_0._loadSceneFinish(arg_5_0)
	if arg_5_0._oldMapLoader then
		arg_5_0._oldMapLoader:dispose()

		arg_5_0._oldMapLoader = nil

		gohelper.destroy(arg_5_0._sceneGo)
	end

	local var_5_0 = arg_5_0._sceneUrl
	local var_5_1 = arg_5_0._mapLoader:getAssetItem(var_5_0):GetResource(var_5_0)

	arg_5_0._sceneGo = gohelper.clone(var_5_1, arg_5_0._sceneRoot, arg_5_0._mapCfg.id)
	arg_5_0._sceneTrans = arg_5_0._sceneGo.transform

	transformhelper.setLocalPos(arg_5_0._sceneTrans, -40.33, 20.35, 3.6)
end

function var_0_0.setSceneVisible(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._sceneRoot, arg_6_1)
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._oldMapLoader then
		arg_7_0._oldMapLoader:dispose()

		arg_7_0._oldMapLoader = nil
	end

	if arg_7_0._mapLoader then
		arg_7_0._mapLoader:dispose()

		arg_7_0._mapLoader = nil
	end

	gohelper.destroy(arg_7_0._sceneRoot)
end

return var_0_0
