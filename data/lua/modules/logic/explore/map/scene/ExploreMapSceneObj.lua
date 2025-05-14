module("modules.logic.explore.map.scene.ExploreMapSceneObj", package.seeall)

local var_0_0 = class("ExploreMapSceneObj", UserDataDispose)
local var_0_1 = typeof(UnityEngine.MeshRenderer)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._container = arg_1_1
	arg_1_0.isActive = false
	arg_1_0._go = nil
	arg_1_0.ishide = true
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.path = arg_2_1.path
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.scale = arg_2_1.scale
	arg_2_0.rotation = arg_2_1.rotation
	arg_2_0.rendererInfos = arg_2_1.rendererInfos
	arg_2_0.useLightMapIndexList = {}
	arg_2_0.effectType = arg_2_1.effectType
	arg_2_0.areaId = arg_2_1.areaId
	arg_2_0.overridderLayer = arg_2_1.overridderLayer or -1
	arg_2_0._destoryInterval = ExploreConstValue.MapSceneObjDestoryInterval[arg_2_1.effectType] or ExploreConstValue.CHECK_INTERVAL.MapSceneObjDestory

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.rendererInfos) do
		if tabletool.indexOf(arg_2_0.useLightMapIndexList, iter_2_1.lightmapIndex) == nil then
			table.insert(arg_2_0.useLightMapIndexList, iter_2_1.lightmapIndex)
		end
	end
end

function var_0_0.show(arg_3_0)
	arg_3_0.isActive = true

	if arg_3_0._go then
		-- block empty
	else
		arg_3_0._assetId = ResMgr.getAbAsset(arg_3_0.path, arg_3_0._loadedCb, arg_3_0, arg_3_0._assetId)
	end

	return arg_3_0._go == nil
end

function var_0_0.markShow(arg_4_0)
	arg_4_0.ishide = false

	TaskDispatcher.cancelTask(arg_4_0.release, arg_4_0)
end

function var_0_0.hide(arg_5_0)
	if arg_5_0._go and arg_5_0.isActive == true then
		TaskDispatcher.runDelay(arg_5_0.release, arg_5_0, arg_5_0._destoryInterval)
	end

	ResMgr.removeCallBack(arg_5_0._assetId)

	local var_5_0 = arg_5_0.ishide ~= true

	arg_5_0.isActive = false
	arg_5_0.ishide = true

	return var_5_0
end

function var_0_0.unloadnow(arg_6_0)
	if arg_6_0._go and arg_6_0.ishide == true then
		arg_6_0:release()
	end
end

local var_0_2 = UnityLayer.SceneOpaqueOcclusionClip

function var_0_0._loadedCb(arg_7_0, arg_7_1)
	if arg_7_0._go == nil and arg_7_0.isActive and arg_7_1.IsLoadSuccess then
		arg_7_0._go = arg_7_1:getInstance(nil, nil, arg_7_0._container)

		local var_7_0 = arg_7_0._go.transform

		transformhelper.setPos(var_7_0, arg_7_0.pos[1], arg_7_0.pos[2], arg_7_0.pos[3])
		transformhelper.setLocalScale(var_7_0, arg_7_0.scale[1], arg_7_0.scale[2], arg_7_0.scale[3])
		transformhelper.setLocalRotation(var_7_0, arg_7_0.rotation[1], arg_7_0.rotation[2], arg_7_0.rotation[3])

		if arg_7_0.overridderLayer ~= -1 then
			gohelper.setLayer(arg_7_0._go, arg_7_0.overridderLayer, false)

			local var_7_1 = arg_7_0.overridderLayer == var_0_2
			local var_7_2 = arg_7_0._go:GetComponentsInChildren(typeof(UnityEngine.Collider))

			for iter_7_0 = 0, var_7_2.Length - 1 do
				var_7_2[iter_7_0].enabled = var_7_1
			end
		end

		local var_7_3 = arg_7_0._go:GetComponentsInChildren(var_0_1, true)

		for iter_7_1 = 0, var_7_3.Length - 1 do
			local var_7_4 = var_7_3[iter_7_1]
			local var_7_5 = arg_7_0.rendererInfos[iter_7_1 + 1]

			if var_7_5 then
				var_7_4.lightmapIndex = var_7_5.lightmapIndex
				var_7_4.lightmapScaleOffset = Vector4.New(var_7_5.lightmapOffsetScale[1], var_7_5.lightmapOffsetScale[2], var_7_5.lightmapOffsetScale[3], var_7_5.lightmapOffsetScale[4])
			end
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjLoadedCb)
	gohelper.setActive(arg_7_0._go, arg_7_0.isActive)
end

function var_0_0.release(arg_8_0)
	arg_8_0:_clear()
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:_clear()
	arg_9_0:__onDispose()
end

function var_0_0._clear(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.release, arg_10_0)
	ResMgr.removeCallBack(arg_10_0._assetId)
	ResMgr.ReleaseObj(arg_10_0._go)

	arg_10_0._go = nil
end

return var_0_0
