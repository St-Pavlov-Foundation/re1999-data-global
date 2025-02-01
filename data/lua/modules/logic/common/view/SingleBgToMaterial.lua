module("modules.logic.common.view.SingleBgToMaterial", package.seeall)

slot0 = class("SingleBgToMaterial", LuaCompBase)

function slot0.loadMaterial(slot0, slot1, slot2)
	slot0.materialPath = string.format("ui/materials/dynamic/%s.mat", slot2)
	slot0.image = slot1.gameObject:GetComponent(gohelper.Type_Image)

	if string.nilorempty(slot0.materialPath) then
		logError("materialPath is not exit:" .. slot0.materialPath)

		return
	end

	if not slot1 then
		logError("image is nil:")

		return
	end

	slot0.materialLoader = MultiAbLoader.New()

	slot0.materialLoader:addPath(slot0.materialPath)
	slot0.materialLoader:startLoad(slot0.buildMaterial, slot0)
end

function slot0.buildMaterial(slot0)
	slot0.material = slot0.materialLoader:getAssetItem(slot0.materialPath):GetResource(slot0.materialPath)
	slot0.materialGO = UnityEngine.Object.Instantiate(slot0.material)
	slot0.image.material = slot0.materialGO

	slot0:loadFinish()
end

function slot0.dispose(slot0)
	if slot0.materialLoader then
		slot0.materialLoader:dispose()
	end
end

function slot0.finishLoadCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.loadFinish(slot0)
	if slot0.callback then
		slot0:callback()
	end
end

return slot0
