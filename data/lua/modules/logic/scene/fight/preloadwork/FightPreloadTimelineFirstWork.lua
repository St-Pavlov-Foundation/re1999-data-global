module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineFirstWork", package.seeall)

slot0 = class("FightPreloadTimelineFirstWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = slot0:_getTimelineUrlList()

	if not GameResMgr.IsFromEditorDir then
		slot0.context.timelineDict = {}

		for slot6, slot7 in ipairs(slot2) do
			slot0.context.timelineDict[slot7] = FightPreloadController.instance:getFightAssetItem(ResUrl.getRolesTimeline())
		end

		slot0:onDone(true)

		return
	end

	slot0._loader = SequenceAbLoader.New()

	for slot6, slot7 in ipairs(slot2) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:setConcurrentCount(10)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	slot0.context.timelineDict = {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.timelineDict[slot5] = slot6

		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("Timeline加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getTimelineUrlList(slot0)
	slot0.context.timelineUrlDict = {}
	slot0.context.timelineSkinDict = {}

	if lua_battle.configDict[slot0.context.battleId] then
		slot6 = "#"

		for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot1.monsterGroupIds, slot6)) do
			if not string.nilorempty(lua_monster_group.configDict[slot7].appearTimeline) then
				slot9 = ResUrl.getSkillTimeline(slot8.appearTimeline)
				slot0.context.timelineUrlDict[slot9] = FightEnum.EntitySide.EnemySide
				slot0.context.timelineSkinDict[slot9] = slot0.context.timelineSkinDict[slot9] or {}
				slot0.context.timelineSkinDict[slot9][0] = true
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0.context.timelineUrlDict) do
		table.insert(slot2, slot6)
	end

	return slot2
end

return slot0
