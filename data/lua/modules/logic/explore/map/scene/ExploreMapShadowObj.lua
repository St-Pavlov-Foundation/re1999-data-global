module("modules.logic.explore.map.scene.ExploreMapShadowObj", package.seeall)

local var_0_0 = class("ExploreMapShadowObj", UserDataDispose)
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
	arg_2_0.areaId = arg_2_1.areaId
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.scale = arg_2_1.scale
	arg_2_0.rotation = arg_2_1.rotation
	arg_2_0.bounds = Bounds.New(Vector3.New(arg_2_1.bounds.center[1], arg_2_1.bounds.center[2], arg_2_1.bounds.center[3]), Vector3.New(arg_2_1.bounds.size[1], arg_2_1.bounds.size[2], arg_2_1.bounds.size[3]))
end

function var_0_0.show(arg_3_0)
	arg_3_0.isActive = true
	arg_3_0.ishide = false

	if arg_3_0._go then
		-- block empty
	else
		arg_3_0._assetId = ResMgr.getAbAsset(arg_3_0.path, arg_3_0._loadedCb, arg_3_0, arg_3_0._assetId)
	end

	TaskDispatcher.cancelTask(arg_3_0.release, arg_3_0)
end

function var_0_0.markShow(arg_4_0)
	arg_4_0.ishide = false
end

function var_0_0.hide(arg_5_0)
	if arg_5_0._go and arg_5_0.isActive == true then
		TaskDispatcher.runDelay(arg_5_0.release, arg_5_0, ExploreConstValue.CHECK_INTERVAL.MapShadowObjDestory)
	end

	ResMgr.removeCallBack(arg_5_0._assetId)

	local var_5_0 = arg_5_0.ishide ~= true

	arg_5_0.isActive = false
	arg_5_0.ishide = true

	return var_5_0
end

function var_0_0._loadedCb(arg_6_0, arg_6_1)
	if arg_6_0._go == nil and arg_6_0.isActive then
		arg_6_0._go = arg_6_1:getInstance(nil, nil, arg_6_0._container)

		local var_6_0 = arg_6_0._go.transform

		transformhelper.setPos(var_6_0, arg_6_0.pos[1], arg_6_0.pos[2], arg_6_0.pos[3])
		transformhelper.setLocalScale(var_6_0, arg_6_0.scale[1], arg_6_0.scale[2], arg_6_0.scale[3])
		transformhelper.setLocalRotation(var_6_0, arg_6_0.rotation[1], arg_6_0.rotation[2], arg_6_0.rotation[3])
	end

	gohelper.setActive(arg_6_0._go, arg_6_0.isActive)
end

function var_0_0.release(arg_7_0)
	arg_7_0:_clear()
end

function var_0_0.dispose(arg_8_0)
	arg_8_0:_clear()
	arg_8_0:__onDispose()
end

function var_0_0._clear(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.release, arg_9_0)
	ResMgr.removeCallBack(arg_9_0._assetId)
	ResMgr.ReleaseObj(arg_9_0._go)

	arg_9_0._go = nil
end

return var_0_0
