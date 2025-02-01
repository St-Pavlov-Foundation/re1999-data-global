module("modules.logic.explore.map.unit.comp.ExploreUnitAnimEffectComp", package.seeall)

slot0 = class("ExploreUnitAnimEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0._effectGo = nil
	slot0._isOnce = false
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.playAnim(slot0, slot1, slot2)
	slot0._isOnce = false

	slot0:_releaseEffectGo()

	if slot1 then
		slot3, slot0._isOnce, slot5, slot6, slot7 = ExploreConfig.instance:getUnitEffectConfig(slot0.unit:getResPath(), slot1)

		if slot2 and slot4 then
			return
		end

		ExploreHelper.triggerAudio(slot5, slot6, slot0.unit.go, slot7 and slot0.unit.id or nil)

		if string.nilorempty(slot3) == false then
			slot0._effectPath = ResUrl.getExploreEffectPath(slot3)
			slot0._assetId = ResMgr.getAbAsset(slot0._effectPath, slot0._onResLoaded, slot0, slot0._assetId)
		end
	else
		slot0._effectPath = nil
	end
end

function slot0._onResLoaded(slot0, slot1)
	if not slot1.IsLoadSuccess then
		return
	end

	if slot0._effectPath == slot1:getUrl() then
		slot0:_releaseEffectGo()

		slot0._effectPath = slot1:getUrl()
		slot0._effectGo = slot1:getInstance(nil, , slot0.unit:getEffectRoot().gameObject)
	end
end

function slot0.destoryEffectIfOnce(slot0)
	if slot0._isOnce then
		slot0:_releaseEffectGo()
	end
end

function slot0._releaseEffectGo(slot0)
	ResMgr.removeCallBack(slot0._assetId)
	ResMgr.ReleaseObj(slot0._effectGo)

	slot0._effectGo = nil
	slot0._effectPath = nil
end

function slot0.clear(slot0)
	if not slot0.unit then
		return
	end

	GameSceneMgr.instance:getCurScene().audio:stopAudioByUnit(slot0.unit.id)
end

function slot0.onDestroy(slot0)
	slot0._isOnce = false
	slot0.unit = false

	slot0:_releaseEffectGo()
end

return slot0
