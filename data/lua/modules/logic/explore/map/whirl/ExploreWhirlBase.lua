module("modules.logic.explore.map.whirl.ExploreWhirlBase", package.seeall)

slot0 = class("ExploreWhirlBase", BaseUnitSpawn)

function slot0.ctor(slot0, slot1, slot2)
	slot3 = gohelper.create3d(slot1, slot2)
	slot0.trans = slot3.transform

	slot0:init(slot3)

	slot0._type = slot2
	slot0._resPath = ""

	slot0:onInit()
	slot0:_loadAssets()
end

function slot0.initComponents(slot0)
	slot0:addComp("followComp", ExploreWhirlFollowComp)
	slot0:addComp("effectComp", ExploreWhirlEffectComp)
end

function slot0.onInit(slot0)
end

function slot0._loadAssets(slot0)
	if string.nilorempty(slot0._resPath) then
		return
	end

	slot0._assetId = ResMgr.getAbAsset(slot0._resPath, slot0._onResLoaded, slot0, slot0._assetId)
end

function slot0.getResPath(slot0)
	return slot0._resPath
end

function slot0.onResLoaded(slot0)
end

function slot0.getGo(slot0)
	return slot0._displayGo
end

function slot0._onResLoaded(slot0, slot1)
	if not slot1.IsLoadSuccess then
		return
	end

	slot0:_releaseDisplayGo()

	slot0._displayGo = slot1:getInstance(nil, , slot0.go)
	slot0._displayTr = slot0._displayGo.transform

	if slot0.followComp then
		slot0.followComp:setup(slot0.go)
		slot0.followComp:start()
	end

	slot0:onResLoaded()
end

function slot0._releaseDisplayGo(slot0)
	ResMgr.ReleaseObj(slot0._displayGo)
	ResMgr.removeCallBack(slot0._assetId)

	slot0._displayGo = nil
	slot0._displayTr = nil
end

function slot0.destroy(slot0)
	slot0:_releaseDisplayGo()
	gohelper.destroy(slot0.go)
	slot0:onDestroy()

	slot0.trans = nil
end

return slot0
