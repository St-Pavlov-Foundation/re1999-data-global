module("modules.logic.scene.fight.preloadwork.FightPreloadEntityAni", package.seeall)

slot0 = class("FightPreloadEntityAni", BaseWork)

function slot0.onStart(slot0, slot1)
	if not GameResMgr.IsFromEditorDir then
		slot0._loader = MultiAbLoader.New()

		slot0._loader:addPath(ResUrl.getEntityAnimABUrl())
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onLoadFinish(slot0, slot1)
	slot0.context.callback(slot0.context.callbackObj, slot1:getFirstAssetItem())
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
