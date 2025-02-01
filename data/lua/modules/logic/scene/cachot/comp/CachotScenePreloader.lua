module("modules.logic.scene.cachot.comp.CachotScenePreloader", package.seeall)

slot0 = class("CachotScenePreloader", BaseSceneComp)
slot0.DoorEffectPath = "effects/prefabs_cachot/v1a6_dilao_men.prefab"
slot0.LightPath = "scenes/v1a6_m_s16_dilao_zjm/v1a6_m_s16_scene_light.prefab"
slot0.EventItem = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_roomeventitem.prefab"
slot0.RoleTransEffect = "effects/prefabs_cachot/v1a6_dilao_chuansong.prefab"
slot0.RoleBornEffect = "effects/prefabs_cachot/v1a6_fangjianchusheng.prefab"

function slot0.init(slot0, slot1, slot2)
	if not slot0._abLoader then
		slot0._abLoader = MultiAbLoader.New()

		slot0:_addLightAsset(slot0._abLoader)
		slot0:_addMainSceneEffect(slot0._abLoader)
		slot0:_addRoomSceneAsset(slot0._abLoader)
		slot0._abLoader:startLoad(slot0._onLoadedFinish, slot0)
	end
end

function slot0.onSceneStart(slot0, slot1, slot2)
end

function slot0._addMainSceneEffect(slot0, slot1)
	slot1:addPath(uv0.DoorEffectPath)
	slot1:addPath(uv0.RoleTransEffect)
	slot1:addPath(uv0.RoleBornEffect)
end

function slot0._addRoomSceneAsset(slot0, slot1)
	slot1:addPath(uv0.EventItem)
end

function slot0._addLightAsset(slot0, slot1)
	slot1:addPath(uv0.LightPath)
end

function slot0._onLoadedFinish(slot0)
	slot0:dispatchEvent(V1a6_CachotEvent.ScenePreloaded)
end

function slot0.getResByPath(slot0, slot1)
	if not slot0._abLoader:getAssetItem(slot1) or not slot2.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. slot1)

		return
	end

	return slot2:GetResource()
end

function slot0.getResInst(slot0, slot1, slot2, slot3)
	if slot0:getResByPath(slot1) then
		return gohelper.clone(slot4, slot2, slot3)
	end
end

function slot0.onSceneClose(slot0)
	if slot0._abLoader then
		slot0._abLoader:dispose()

		slot0._abLoader = nil
	end
end

return slot0
