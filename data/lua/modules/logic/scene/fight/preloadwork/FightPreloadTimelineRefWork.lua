module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineRefWork", package.seeall)

slot0 = class("FightPreloadTimelineRefWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._urlDict = slot0:_getUrlList()
	slot0._loader = SequenceAbLoader.New()

	for slot5, slot6 in pairs(slot0._urlDict) do
		slot0._loader:addPath(slot5)
	end

	slot0._loader:setLoadFailCallback(slot0._onOneLoadFail)
	slot0._loader:setConcurrentCount(10)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._onOneLoadFail(slot0, slot1, slot2)
	slot3 = slot2.ResPath

	logError("预加载战斗Timeline引用资源失败！\nTimeline: " .. slot0._urlDict[slot3] .. "\n引用资源: " .. slot3)
end

function slot0._onPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6)
		FightPreloadController.instance:addTimelineRefAsset(slot6)
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.001)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._getUrlList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.context.timelineDict) do
		if not string.nilorempty(ZProj.SkillTimelineAssetHelper.GeAssetJson(slot6, slot5)) then
			for slot12 = 1, #cjson.decode(slot7), 2 do
				slot14 = slot8[slot12 + 1]

				if tonumber(slot8[slot12]) == 30 then
					-- Nothing
				elseif slot13 == 31 then
					-- Nothing
				elseif slot13 == 32 then
					if not string.nilorempty(slot14[2]) then
						slot1[ResUrl.getRoleSpineMatTex(slot15)] = slot5
					end
				elseif slot13 == 11 then
					for slot19, slot20 in pairs(slot0.context.timelineSkinDict[slot5] or {}) do
						if not string.nilorempty(FightTLEventCreateSpine.getSkinSpineName(slot14[1], slot19)) then
							slot1[ResUrl.getSpineFightPrefab(slot21)] = slot5
						end
					end
				end
			end
		end
	end

	return slot1
end

return slot0
