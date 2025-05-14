module("modules.logic.scene.cachot.comp.CachotScenePreloader", package.seeall)

local var_0_0 = class("CachotScenePreloader", BaseSceneComp)

var_0_0.DoorEffectPath = "effects/prefabs_cachot/v1a6_dilao_men.prefab"
var_0_0.LightPath = "scenes/v1a6_m_s16_dilao_zjm/v1a6_m_s16_scene_light.prefab"
var_0_0.EventItem = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_roomeventitem.prefab"
var_0_0.RoleTransEffect = "effects/prefabs_cachot/v1a6_dilao_chuansong.prefab"
var_0_0.RoleBornEffect = "effects/prefabs_cachot/v1a6_fangjianchusheng.prefab"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0._abLoader then
		arg_1_0._abLoader = MultiAbLoader.New()

		arg_1_0:_addLightAsset(arg_1_0._abLoader)
		arg_1_0:_addMainSceneEffect(arg_1_0._abLoader)
		arg_1_0:_addRoomSceneAsset(arg_1_0._abLoader)
		arg_1_0._abLoader:startLoad(arg_1_0._onLoadedFinish, arg_1_0)
	end
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0._addMainSceneEffect(arg_3_0, arg_3_1)
	arg_3_1:addPath(var_0_0.DoorEffectPath)
	arg_3_1:addPath(var_0_0.RoleTransEffect)
	arg_3_1:addPath(var_0_0.RoleBornEffect)
end

function var_0_0._addRoomSceneAsset(arg_4_0, arg_4_1)
	arg_4_1:addPath(var_0_0.EventItem)
end

function var_0_0._addLightAsset(arg_5_0, arg_5_1)
	arg_5_1:addPath(var_0_0.LightPath)
end

function var_0_0._onLoadedFinish(arg_6_0)
	arg_6_0:dispatchEvent(V1a6_CachotEvent.ScenePreloaded)
end

function var_0_0.getResByPath(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._abLoader:getAssetItem(arg_7_1)

	if not var_7_0 or not var_7_0.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. arg_7_1)

		return
	end

	return var_7_0:GetResource()
end

function var_0_0.getResInst(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getResByPath(arg_8_1)

	if var_8_0 then
		return gohelper.clone(var_8_0, arg_8_2, arg_8_3)
	end
end

function var_0_0.onSceneClose(arg_9_0)
	if arg_9_0._abLoader then
		arg_9_0._abLoader:dispose()

		arg_9_0._abLoader = nil
	end
end

return var_0_0
