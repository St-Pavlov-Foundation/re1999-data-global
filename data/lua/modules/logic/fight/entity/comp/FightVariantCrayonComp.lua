module("modules.logic.fight.entity.comp.FightVariantCrayonComp", package.seeall)

slot0 = class("FightVariantCrayonComp", LuaCompBase)
slot1 = {
	m_s62_jzsylb = true
}
slot2 = "_STYLIZATIONPLAYER_ON"
slot3 = "_NoiseMap3"
slot4 = "_ShadowMap"
slot5 = "crayonmap1_manual"
slot6 = "crayonmap2_manual"

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, slot0._onMatChange, slot0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.removeEventListeners(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, slot0._onMatChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0._onMatChange(slot0, slot1, slot2)
	if slot1 == slot0.entity.id then
		slot0:_change()
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot1 == slot0.entity.spine then
		slot0:_change()
	end
end

function slot0._onLevelLoaded(slot0)
	if slot0:_needChange() then
		slot0:_change()
	else
		if not slot0.entity.spineRenderer:getReplaceMat() then
			return
		end

		slot1:DisableKeyword(uv0)
	end
end

function slot0._needChange(slot0)
	return uv0[lua_scene_level.configDict[GameSceneMgr.instance:getCurScene():getCurLevelId()].resName] ~= nil
end

function slot0._change(slot0)
	if not slot0:_needChange() then
		return
	end

	if not slot0.entity.spineRenderer:getReplaceMat() then
		return
	end

	slot1:EnableKeyword(uv0)

	slot0._noiceMapPath = ResUrl.getRoleSpineMatTex(uv1)
	slot0._shadowMapPath = ResUrl.getRoleSpineMatTex(uv2)

	loadAbAsset(slot0._noiceMapPath, false, slot0._onLoadCallback1, slot0)
	loadAbAsset(slot0._shadowMapPath, false, slot0._onLoadCallback2, slot0)
end

function slot0._onLoadCallback1(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem1 = slot1

		slot1:Retain()
		slot0.entity.spineRenderer:getReplaceMat():SetTexture(uv0, slot1:GetResource(slot0._noiceMapPath))
	end
end

function slot0._onLoadCallback2(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem2 = slot1

		slot1:Retain()
		slot0.entity.spineRenderer:getReplaceMat():SetTexture(uv0, slot1:GetResource(slot0._shadowMapPath))
	end
end

function slot0.onDestroy(slot0)
	if slot0._assetItem1 then
		slot0._assetItem1:Release()

		slot0._assetItem1 = nil
	end

	if slot0._assetItem2 then
		slot0._assetItem2:Release()

		slot0._assetItem2 = nil
	end
end

return slot0
