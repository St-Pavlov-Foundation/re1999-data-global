module("modules.logic.explore.map.whirl.comp.ExploreWhirlEffectComp", package.seeall)

slot0 = class("ExploreWhirlEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.whirl = slot1
	slot0._effectGo = nil
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.playAnim(slot0, slot1)
	slot0:_releaseEffectGo()

	if slot1 then
		if string.nilorempty(ExploreConfig.instance:getUnitEffectConfig(slot0.whirl:getResPath(), slot1)) == false then
			slot0._effectPath = ResUrl.getExploreEffectPath(slot2)
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
		slot0._effectGo = slot1:getInstance(nil, , slot0.go)
	end
end

function slot0._releaseEffectGo(slot0)
	ResMgr.ReleaseObj(slot0._effectGo)
	ResMgr.removeCallBack(slot0._assetId)

	slot0._effectGo = nil
	slot0._effectPath = nil
end

function slot0.onDestroy(slot0)
	slot0:_releaseEffectGo()
end

return slot0
