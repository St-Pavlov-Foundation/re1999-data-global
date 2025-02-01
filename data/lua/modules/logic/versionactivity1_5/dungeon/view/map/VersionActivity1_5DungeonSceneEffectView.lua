module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonSceneEffectView", package.seeall)

slot0 = class("VersionActivity1_5DungeonSceneEffectView", BaseView)

function slot0.onInitView(slot0, slot1)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.dayTimeEffectGoPool = nil
	slot0.nightEffectGoPool = nil

	slot0:createScenePoolRoot()
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, slot0.onLoadSceneFinish, slot0)
end

function slot0.createScenePoolRoot(slot0)
	slot0.effectPoolRoot = UnityEngine.GameObject.New("effectPoolRoot")

	gohelper.addChild(gohelper.findChild(CameraMgr.instance:getSceneRoot(), VersionActivity1_5DungeonEnum.SceneRootName), slot0.effectPoolRoot)
	gohelper.setActive(slot0.effectPoolRoot, false)
	transformhelper.setLocalPos(slot0.effectPoolRoot.transform, 0, 0, 0)
end

function slot0.onDisposeOldMap(slot0)
	slot0:recycleEffectGo()
end

function slot0.onLoadSceneFinish(slot0, slot1)
	slot0.sceneGo = slot1.mapSceneGo
	slot0.mapConfig = slot1.mapConfig
	slot0.goEffectRoot = gohelper.findChild(slot0.sceneGo, "SceneEffect")

	slot0:addSceneEffect()
end

function slot0.addSceneEffect(slot0)
	if not slot0.activityDungeonMo:isHardMode() then
		gohelper.setActive(slot0.goEffectRoot, false)

		return
	end

	gohelper.setActive(slot0.goEffectRoot, true)

	if VersionActivity1_5DungeonEnum.MapId2Light[slot0.mapConfig.id] then
		if not slot0.dayTimeEffectGo then
			slot0:createDayTimeGo()
		else
			slot0:refreshEffect()
		end
	elseif not slot0.nightEffectGo then
		slot0:createNightTimeGo()
	else
		slot0:refreshEffect()
	end
end

function slot0.getEffectLoader(slot0)
	if slot0.effectLoader then
		return slot0.effectLoader
	end

	slot0.effectLoader = MultiAbLoader.New()

	slot0.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.DayTime)
	slot0.effectLoader:addPath(VersionActivity1_5DungeonEnum.SceneEffect.Night)
	slot0.effectLoader:startLoad(slot0.onEffectLoadDone, slot0)

	return slot0.effectLoader
end

function slot0.onEffectLoadDone(slot0)
	slot0:createDayTimeGo()
	slot0:createNightTimeGo()
end

function slot0.createDayTimeGo(slot0)
	if not VersionActivity1_5DungeonEnum.MapId2Light[slot0.mapConfig.id] then
		return
	end

	if slot0.dayTimeEffectGoPool then
		slot0.dayTimeEffectGo = slot0.dayTimeEffectGoPool
		slot0.dayTimeEffectGoPool = nil

		gohelper.addChild(slot0.goEffectRoot, slot0.dayTimeEffectGo)
		slot0:refreshEffect()

		return
	end

	if slot0:getEffectLoader().isLoading then
		return
	end

	slot0.dayTimeEffectGo = gohelper.clone(slot1:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.DayTime):GetResource(), slot0.goEffectRoot)

	slot0:refreshEffect()
end

function slot0.createNightTimeGo(slot0)
	if VersionActivity1_5DungeonEnum.MapId2Light[slot0.mapConfig.id] then
		return
	end

	if slot0.nightEffectGoPool then
		slot0.nightEffectGo = slot0.nightEffectGoPool
		slot0.nightEffectGoPool = nil

		gohelper.addChild(slot0.goEffectRoot, slot0.nightEffectGo)
		slot0:refreshEffect()

		return
	end

	if slot0:getEffectLoader().isLoading then
		return
	end

	slot0.nightEffectGo = gohelper.clone(slot1:getAssetItem(VersionActivity1_5DungeonEnum.SceneEffect.Night):GetResource(), slot0.goEffectRoot)

	slot0:refreshEffect()
end

function slot0.refreshEffect(slot0)
	if not slot0.activityDungeonMo:isHardMode() then
		gohelper.setActive(slot0.goEffectRoot, false)

		return
	end

	if slot0.dayTimeEffectGo then
		gohelper.setActive(slot0.dayTimeEffectGo, VersionActivity1_5DungeonEnum.MapId2Light[slot0.mapConfig.id])
	end

	if slot0.nightEffectGo then
		gohelper.setActive(slot0.nightEffectGo, not slot1)
	end
end

function slot0.recycleEffectGo(slot0)
	if slot0.dayTimeEffectGo then
		gohelper.addChild(slot0.effectPoolRoot, slot0.dayTimeEffectGo)

		slot0.dayTimeEffectGoPool = slot0.dayTimeEffectGo
		slot0.dayTimeEffectGo = nil
	end

	if slot0.nightEffectGo then
		gohelper.addChild(slot0.effectPoolRoot, slot0.nightEffectGo)

		slot0.nightEffectGoPool = slot0.nightEffectGo
		slot0.nightEffectGo = nil
	end
end

function slot0.onDestroy(slot0)
	if slot0.effectLoader then
		slot0.effectLoader:dispose()
	end
end

return slot0
