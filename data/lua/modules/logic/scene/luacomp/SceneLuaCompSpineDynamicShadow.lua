module("modules.logic.scene.luacomp.SceneLuaCompSpineDynamicShadow", package.seeall)

slot0 = class("SceneLuaCompSpineDynamicShadow", LuaCompBase)

function slot0.ctor(slot0, slot1)
	if string.nilorempty(slot1[1]) then
		logError("场景阴影贴图未配置，请检查 C场景表.xlsx-export_场景表现")

		return
	end

	slot0._texturePath = ResUrl.getRoleSpineMatTex(slot1[1])

	if slot1[2] then
		slot2 = string.splitToNumber(slot1[2], "#")
		slot0._vec_ShadowMap_ST = Vector4.New(slot2[1], slot2[2], slot2[3], slot2[4])
	end

	if slot1[3] then
		slot2 = string.splitToNumber(slot1[3], "#")
		slot0._vec_ShadowMapOffset = Vector4.New(slot2[1], slot2[2], slot2[3], slot2[4])
	end
end

function slot0.init(slot0, slot1)
	slot0._loader = MultiAbLoader.New()
	slot0._needSetMatDict = nil
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSpineMaterialChange, slot0._onSpineMatChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSpineMaterialChange, slot0._onSpineMatChange, slot0)
end

function slot0.onStart(slot0)
	if not slot0._texturePath then
		return
	end

	slot0._loader:addPath(slot0._texturePath)
	slot0._loader:startLoad(slot0._onLoadCallback, slot0)

	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		if slot6.spine and slot6.spine:getSpineGO() then
			slot0:_setSpineMat(slot6.spineRenderer:getReplaceMat())
		end
	end
end

function slot0._onLoadCallback(slot0)
	if slot0._needSetMatDict then
		for slot4, slot5 in pairs(slot0._needSetMatDict) do
			slot0:_setSpineMat(slot4)
		end

		slot0._needSetMatDict = nil
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	slot0:_setSpineMat(slot1.unitSpawn.spineRenderer:getReplaceMat())
end

function slot0._onSpineMatChange(slot0, slot1, slot2)
	slot0:_setSpineMat(slot2)
end

function slot0._setSpineMat(slot0, slot1)
	if slot0._loader and slot0._loader:getFirstAssetItem() then
		slot3 = slot2:GetResource(slot0._texturePath)

		slot1:EnableKeyword("_SHADOW_DYNAMIC_ON")

		if slot0._vec_ShadowMap_ST then
			slot1:SetVector("_ShadowMap_ST", slot0._vec_ShadowMap_ST)
		end

		if slot0._vec_ShadowMapOffset then
			slot1:SetVector("_ShadowMapOffset", slot0._vec_ShadowMapOffset)
		end

		slot1:SetTexture("_ShadowMap", slot3)
	else
		if not slot0._needSetMatDict then
			slot0._needSetMatDict = {}
		end

		slot0._needSetMatDict[slot1] = true
	end
end

function slot0.onDestroy(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._needSetMatDict = nil
end

return slot0
