module("modules.logic.scene.fight.preloadwork.FightRoundPreloadEffectWork", package.seeall)

slot0 = class("FightRoundPreloadEffectWork", BaseWork)
slot1 = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28.0] = "FightTLEventDefEffect"
}
slot2 = {
	[1.0] = "FightTLEventTargetEffect"
}

function slot0.onStart(slot0, slot1)
	if FightEffectPool.isForbidEffect then
		slot0:onDone(true)

		return
	end

	slot0._concurrentCount = 1
	slot0._interval = 0.1
	slot0._loadingCount = 0
	slot0._effectWrapList = {}
	slot0._needPreloadList = {}
	slot2 = {}

	for slot6, slot7 in pairs(slot0.context.timelineDict) do
		if not string.nilorempty(ZProj.SkillTimelineAssetHelper.GeAssetJson(slot7, slot6)) then
			for slot13 = 1, #cjson.decode(slot8), 2 do
				slot16 = slot9[slot13 + 1][1]

				if uv0[tonumber(slot9[slot13])] and not string.nilorempty(slot16) then
					slot19 = slot2[FightHelper.getEffectUrlWithLod(slot16)]
					slot20 = slot0.context.timelineUrlDict[slot6]

					if uv1[slot14] then
						slot20 = slot18 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
					end

					slot21 = slot20

					if slot19 and slot19 ~= slot20 then
						slot21 = FightEnum.EntitySide.BothSide
					end

					slot2[slot17] = slot21
				end
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:_addPreloadEffect(slot6, slot7)
	end

	slot0:_startPreload()
end

function slot0._addPreloadEffect(slot0, slot1, slot2)
	if FightEffectPool.hasLoaded(slot1) then
		return
	end

	if slot2 == nil then
		table.insert(slot0._needPreloadList, {
			path = slot1,
			side = FightEnum.EntitySide.BothSide
		})
	end

	if slot2 == FightEnum.EntitySide.MySide or slot2 == FightEnum.EntitySide.BothSide then
		table.insert(slot0._needPreloadList, {
			path = slot1,
			side = FightEnum.EntitySide.MySide
		})
	end

	if slot2 == FightEnum.EntitySide.EnemySide or slot2 == FightEnum.EntitySide.BothSide then
		table.insert(slot0._needPreloadList, {
			path = slot1,
			side = FightEnum.EntitySide.EnemySide
		})
	end
end

function slot0._startPreload(slot0)
	slot0._loadingCount = math.min(slot0._concurrentCount, #slot0._needPreloadList)

	if slot0._loadingCount > 0 then
		for slot4 = 1, slot0._loadingCount do
			if FightEffectPool.hasLoaded(table.remove(slot0._needPreloadList, #slot0._needPreloadList).path) or FightEffectPool.isLoading(slot5.path) then
				slot0:_detectAfterLoaded()
			else
				slot6 = FightEffectPool.getEffect(slot5.path, slot5.side, slot0._onPreloadOneFinish, slot0, nil, true)

				slot6:setLocalPos(50000, 50000, 50000)
				table.insert(slot0._effectWrapList, slot6)
			end
		end
	else
		slot0:_onPreloadAllFinish()
	end
end

function slot0._onPreloadOneFinish(slot0, slot1, slot2)
	if not slot2 then
		logError("战斗特效加载失败：" .. slot1.path)
	end

	slot0:_detectAfterLoaded()
end

function slot0._detectAfterLoaded(slot0)
	slot0._loadingCount = slot0._loadingCount - 1

	if slot0._loadingCount <= 0 then
		TaskDispatcher.runDelay(slot0._startPreload, slot0, slot0._interval)
	end
end

function slot0._onPreloadAllFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._startPreload, slot0, 0.01)

	if slot0._effectWrapList then
		for slot4, slot5 in ipairs(slot0._effectWrapList) do
			FightEffectPool.returnEffect(slot5)
			slot5:setCallback(nil, )
		end
	end

	slot0._effectWrapList = nil
end

return slot0
