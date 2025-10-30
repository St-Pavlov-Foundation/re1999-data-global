module("modules.logic.dungeon.view.DungeonMapHoleView", package.seeall)

local var_0_0 = class("DungeonMapHoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0.loadSceneFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnMapPosChanged, arg_2_0.onMapPosChanged, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementAdd, arg_2_0._onAddElement, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementRemove, arg_2_0._onRemoveElement, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.initCameraParam, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_3_0.loadSceneFinish, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnMapPosChanged, arg_3_0.onMapPosChanged, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementAdd, arg_3_0._onAddElement, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnElementRemove, arg_3_0._onRemoveElement, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0.initCameraParam, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.tempVector4 = Vector4()
	arg_4_0.shaderParamList = {}
	arg_4_0._tweens = {}

	for iter_4_0 = 1, 5 do
		table.insert(arg_4_0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. iter_4_0))
	end
end

function var_0_0.onClose(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.setHoleByTween, arg_5_0)
	arg_5_0:clearTween()
end

function var_0_0.clearTween(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._tweens) do
		ZProj.TweenHelper.KillById(iter_6_1)
	end
end

function var_0_0._onAddElement(arg_7_0, arg_7_1)
	if arg_7_0._elementIndex[arg_7_1] then
		local var_7_0 = arg_7_0._elementIndex[arg_7_1]

		if arg_7_0._tweens[var_7_0] then
			ZProj.TweenHelper.KillById(arg_7_0._tweens[var_7_0], true)

			arg_7_0._tweens[var_7_0] = nil
		end
	end

	if not arg_7_0._elementIndex or arg_7_0._elementIndex[arg_7_1] or not arg_7_0.defaultSceneWorldPosX then
		return
	end

	local var_7_1 = lua_chapter_map_element.configDict[arg_7_1]

	if not var_7_1 then
		return
	end

	if string.nilorempty(var_7_1.holeSize) then
		return
	end

	local var_7_2 = 1

	while true do
		if not arg_7_0.holdCoList[var_7_2] then
			arg_7_0._elementIndex[arg_7_1] = var_7_2

			local var_7_3 = string.splitToNumber(var_7_1.pos, "#")
			local var_7_4 = var_7_3[1] or 0
			local var_7_5 = var_7_3[2] or 0
			local var_7_6 = CameraMgr.instance:getMainCameraTrs().parent
			local var_7_7, var_7_8, var_7_9 = transformhelper.getLocalPos(var_7_6)
			local var_7_10 = string.splitToNumber(var_7_1.holeSize, "#")

			arg_7_0.holdCoList[var_7_2] = {
				var_7_4 + arg_7_0.defaultSceneWorldPosX + (var_7_10[1] or 0),
				var_7_5 + arg_7_0.defaultSceneWorldPosY + var_7_8 + (var_7_10[2] or 0),
				0
			}
			arg_7_0.holdCoList[var_7_2][4] = arg_7_1
			arg_7_0._tweens[var_7_2] = ZProj.TweenHelper.DOTweenFloat(0, var_7_10[3] or 0, 0.2, arg_7_0.onTweenOpen, arg_7_0.onTweenOpenEnd, arg_7_0, var_7_2, EaseType.Linear)

			return
		end

		var_7_2 = var_7_2 + 1
	end
end

function var_0_0.onTweenOpen(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.holdCoList[arg_8_2] then
		return
	end

	arg_8_0.holdCoList[arg_8_2][3] = arg_8_1

	arg_8_0:refreshHoles()
end

function var_0_0.onTweenOpenEnd(arg_9_0, arg_9_1)
	arg_9_0._tweens[arg_9_1] = nil
end

function var_0_0._onRemoveElement(arg_10_0, arg_10_1)
	if not arg_10_0._elementIndex then
		return
	end

	if not arg_10_0._elementIndex or not arg_10_0._elementIndex[arg_10_1] then
		return
	end

	local var_10_0 = arg_10_0._elementIndex[arg_10_1]
	local var_10_1 = arg_10_0.holdCoList[var_10_0]

	arg_10_0._tweens[var_10_0] = ZProj.TweenHelper.DOTweenFloat(var_10_1[3], 0, 0.2, arg_10_0.onTweenClose, arg_10_0.onTweenCloseEnd, arg_10_0, var_10_0, EaseType.Linear)
end

function var_0_0.onTweenClose(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.holdCoList[arg_11_2] then
		return
	end

	arg_11_0.holdCoList[arg_11_2][3] = arg_11_1

	arg_11_0:refreshHoles()
end

function var_0_0.onTweenCloseEnd(arg_12_0, arg_12_1)
	arg_12_0._tweens[arg_12_1] = nil
	arg_12_0.holdCoList[arg_12_1] = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0._elementIndex) do
		if iter_12_1 == arg_12_1 then
			arg_12_0._elementIndex[iter_12_0] = nil

			arg_12_0:refreshHoles()

			break
		end
	end
end

function var_0_0.loadSceneFinish(arg_13_0, arg_13_1)
	arg_13_0.mapCfg = arg_13_1[1]
	arg_13_0.sceneGo = arg_13_1[2]
	arg_13_0.mapScene = arg_13_1[3]

	TaskDispatcher.cancelTask(arg_13_0.setHoleByTween, arg_13_0)

	if gohelper.isNil(arg_13_0.sceneGo) then
		arg_13_0.loadSceneDone = false

		return
	end

	arg_13_0:clearTween()

	local var_13_0 = lua_chapter_map_hole.configDict[arg_13_0.mapCfg.id] or {}

	arg_13_0.holdCoList = {}
	arg_13_0._elementIndex = {}

	for iter_13_0 = 1, #var_13_0 do
		table.insert(arg_13_0.holdCoList, string.splitToNumber(var_13_0[iter_13_0].param, "#"))
	end

	arg_13_0.loadSceneDone = true
	arg_13_0.sceneTrans = arg_13_0.sceneGo.transform

	local var_13_1 = gohelper.findChild(arg_13_0.sceneGo, "Obj-Plant/FogOfWar/mask")

	if not var_13_1 then
		return
	end

	gohelper.setLayer(var_13_1, UnityLayer.Scene, true)

	arg_13_0.sceneWorldPosX, arg_13_0.sceneWorldPosY = transformhelper.getLocalPos(arg_13_0.sceneTrans)

	local var_13_2 = arg_13_0.mapCfg.initPos
	local var_13_3 = string.splitToNumber(var_13_2, "#")

	arg_13_0.defaultSceneWorldPosX, arg_13_0.defaultSceneWorldPosY = var_13_3[1] or 0, var_13_3[2] or 0
	arg_13_0.mat = var_13_1:GetComponent(typeof(UnityEngine.MeshRenderer)).material

	arg_13_0:initCameraParam()
	arg_13_0:refreshHoles()
end

function var_0_0.onMapPosChanged(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.loadSceneDone then
		return
	end

	if arg_14_2 then
		arg_14_0.targetPosX, arg_14_0.targetPosY = arg_14_1.x, arg_14_1.y

		arg_14_0:setHoleByTween()
		TaskDispatcher.runRepeat(arg_14_0.setHoleByTween, arg_14_0, 0, -1)
	else
		TaskDispatcher.cancelTask(arg_14_0.setHoleByTween, arg_14_0)

		arg_14_0.sceneWorldPosX, arg_14_0.sceneWorldPosY = arg_14_1.x, arg_14_1.y

		arg_14_0:refreshHoles()
	end
end

function var_0_0.setHoleByTween(arg_15_0)
	if not arg_15_0.sceneTrans or tolua.isnull(arg_15_0.sceneTrans) then
		TaskDispatcher.cancelTask(arg_15_0.setHoleByTween, arg_15_0)

		return
	end

	arg_15_0.sceneWorldPosX, arg_15_0.sceneWorldPosY = transformhelper.getLocalPos(arg_15_0.sceneTrans)

	if math.abs(arg_15_0.sceneWorldPosX - arg_15_0.targetPosX) < 0.01 and math.abs(arg_15_0.sceneWorldPosY - arg_15_0.targetPosY) < 0.01 then
		arg_15_0.sceneWorldPosX, arg_15_0.sceneWorldPosY = arg_15_0.targetPosX, arg_15_0.targetPosY

		TaskDispatcher.cancelTask(arg_15_0.setHoleByTween, arg_15_0)
	end

	arg_15_0:refreshHoles()
end

function var_0_0.initCameraParam(arg_16_0)
	if not arg_16_0.loadSceneDone then
		return
	end

	local var_16_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local var_16_1 = GameUtil.getAdapterScale()
	local var_16_2 = var_16_0.transform:GetWorldCorners()

	arg_16_0.mainCamera = CameraMgr.instance:getMainCamera()
	arg_16_0.mainCameraPosX, arg_16_0.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	local var_16_3 = 5 / arg_16_0.mainCamera.orthographicSize
	local var_16_4 = var_16_2[1] * var_16_1 * var_16_3
	local var_16_5 = var_16_2[3] * var_16_1 * var_16_3

	arg_16_0._mapHalfWidth = math.abs(var_16_5.x - var_16_4.x) / 2
	arg_16_0._mapHalfHeight = math.abs(var_16_5.y - var_16_4.y) / 2

	arg_16_0:refreshHoles()
end

function var_0_0.refreshHoles(arg_17_0)
	if not arg_17_0.loadSceneDone or gohelper.isNil(arg_17_0.mat) then
		return
	end

	local var_17_0 = 1

	for iter_17_0, iter_17_1 in pairs(arg_17_0.holdCoList) do
		local var_17_1 = iter_17_1[1] + arg_17_0.sceneWorldPosX - arg_17_0.defaultSceneWorldPosX
		local var_17_2 = iter_17_1[2] + arg_17_0.sceneWorldPosY - arg_17_0.defaultSceneWorldPosY
		local var_17_3 = math.abs(iter_17_1[3])
		local var_17_4 = math.sqrt((arg_17_0.mainCameraPosX - var_17_1)^2)
		local var_17_5 = math.sqrt((arg_17_0.mainCameraPosY - var_17_2)^2)

		if var_17_4 <= arg_17_0._mapHalfWidth + var_17_3 and var_17_5 <= arg_17_0._mapHalfHeight + var_17_3 then
			if var_17_0 > 5 then
				logError("元件太多无法挖孔")

				return
			end

			arg_17_0.tempVector4:Set(var_17_1, var_17_2, iter_17_1[3])
			arg_17_0.mat:SetVector(arg_17_0.shaderParamList[var_17_0], arg_17_0.tempVector4)

			var_17_0 = var_17_0 + 1
		end
	end

	for iter_17_2 = var_17_0, 5 do
		arg_17_0.tempVector4:Set(100, 100, 100)
		arg_17_0.mat:SetVector(arg_17_0.shaderParamList[iter_17_2], arg_17_0.tempVector4)
	end
end

return var_0_0
