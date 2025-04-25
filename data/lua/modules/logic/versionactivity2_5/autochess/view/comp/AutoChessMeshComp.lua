module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessMeshComp", package.seeall)

slot0 = class("AutoChessMeshComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.uiMesh = gohelper.findChildUIMesh(slot1, "")
	slot0.simageRole = gohelper.findChildSingleImage(slot1, "role")
	slot0.imageRole = gohelper.findChildImage(slot1, "role")
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.simageRole:LoadImage(ResUrl.getAutoChessIcon(slot1), slot0.loadImageCallback, slot0)

	slot0.materialUrl = AutoChessHelper.getMaterialUrl(slot2, slot3)
	slot0.meshUrl = AutoChessHelper.getMeshUrl(slot1)

	slot0:loadMesh()
end

function slot0.loadImageCallback(slot0)
	if slot0.imageRole then
		slot0.imageRole:SetNativeSize()
	end
end

function slot0.loadMesh(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end

	slot0.loader = MultiAbLoader.New()

	slot0.loader:addPath(slot0.materialUrl)
	slot0.loader:addPath(slot0.meshUrl)
	slot0.loader:startLoad(slot0.loadResFinish, slot0)
end

function slot0.loadResFinish(slot0)
	slot0.uiMesh.mesh = slot0.loader:getAssetItem(slot0.meshUrl):GetResource(slot0.meshUrl)

	slot0.uiMesh:SetVerticesDirty()

	slot0.uiMesh.material = slot0.loader:getAssetItem(slot0.materialUrl):GetResource(slot0.materialUrl)

	slot0.uiMesh:SetMaterialDirty()
	gohelper.setActive(slot0.uiMesh, true)
end

function slot0.onDestroy(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

return slot0
