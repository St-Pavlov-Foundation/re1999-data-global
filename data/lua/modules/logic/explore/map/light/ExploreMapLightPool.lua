module("modules.logic.explore.map.light.ExploreMapLightPool", package.seeall)

slot0 = class("ExploreMapLightPool")

function slot0.getInst(slot0, slot1, slot2)
	if not slot0._pool then
		slot0._pool = ExploreMapLightItem.getPool()
	end

	if not slot0._lightGo then
		slot0._lightGo = slot0:getLightGo()
	end

	slot3 = slot0._pool:getObject()

	slot3:init(slot1, slot2, slot0._lightGo)

	return slot3
end

function slot0.getLightGo(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	return GameSceneMgr.instance:getCurScene().preloader:getResByPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))
end

function slot0.inPool(slot0, slot1)
	if not slot0._pool then
		slot1:release()

		return
	end

	slot0._pool:putObject(slot1)
end

function slot0.clear(slot0)
	if slot0._pool then
		slot0._pool:dispose()

		slot0._pool = nil
	end

	slot0._lightGo = nil
end

slot0.instance = slot0.New()

return slot0
