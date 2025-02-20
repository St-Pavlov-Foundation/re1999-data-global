module("modules.logic.scene.fight.preloadwork.FightPreloadRoleEffectWork", package.seeall)

slot0 = class("FightPreloadRoleEffectWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if GameResMgr.IsFromEditorDir then
		slot0:onDone(true)

		return
	end

	if FightEffectPool.isForbidEffect then
		slot0:onDone(true)

		return
	end

	slot0._startTime = Time.time
	slot2, slot0._replayAb2EffectUrlList = slot0:_analyseEffectUrlList()
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:setPathList(slot2)
	slot0._loader:setConcurrentCount(1)
	slot0._loader:setInterval(0.01)
	slot0._loader:setOneFinishCallback(slot0._onPreloadOneFinish, slot0)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail, slot0)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
	logNormal("preload 开始预加载角色特效 " .. Time.time)
end

function slot0._onPreloadOneFinish(slot0, slot1, slot2)
	slot3 = Time.time

	logNormal(string.format("preload %.2f_%.2f %s", Time.time, slot3 - slot0._startTime, slot2.ResPath))

	slot0._startTime = slot3

	if slot0._replayAb2EffectUrlList[slot2.ResPath] then
		for slot9, slot10 in ipairs(slot5) do
			FightEffectPool.returnEffect(FightEffectPool.getEffect(slot10, FightEnum.EntitySide.MySide, nil, , , true))
		end
	end
end

function slot0._onPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("战斗资源加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._analyseEffectUrlList(slot0)
	slot1 = {}
	slot2 = {}

	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot9 = slot8.id

		for slot14, slot15 in ipairs(slot8.skillList) do
			if slot8:isActiveSkill(slot15) then
				for slot21, slot22 in ipairs(FightHelper.getTimelineListByName(FightConfig.instance:getSkinSkillTimeline(slot8.skin, slot15), slot8.skin)) do
					if not string.nilorempty(slot22) then
						slot23, slot24 = slot0:_analyseSingleTimeline(slot16)
						slot1[slot15] = slot1[slot15] or {}

						tabletool.addValues(slot1[slot15], slot23)
						tabletool.addValues(slot2, slot24)
					end
				end
			end
		end
	end

	slot4 = {}

	if FightModel.instance:getFightParam().isReplay then
		slot6 = FightCardModel.instance:getHandCards()

		if FightReplayModel.instance:getList() and slot7[1] then
			for slot12, slot13 in ipairs(slot8.opers) do
				if slot13.operType == FightEnum.CardOpType.PlayCard then
					slot14 = slot6 and slot6[slot13.param1]
					slot15 = slot14 and slot14.skillId

					if slot15 and slot1[slot15] then
						tabletool.addValues(slot4, slot16)

						slot1[slot15] = nil
					end
				end

				break
			end
		end
	end

	slot7 = {}

	for slot11, slot12 in ipairs(slot4) do
		slot0:_addAbByEffectUrl({}, slot12)

		slot7[slot13] = slot7[FightHelper.getEffectAbPath(slot12)] or {}

		if not tabletool.indexOf(slot7[slot13], slot12) then
			table.insert(slot7[slot13], slot12)
		end
	end

	for slot11, slot12 in pairs(slot1) do
		for slot16, slot17 in ipairs(slot12) do
			slot0:_addAbByEffectUrl(slot6, slot17)
		end
	end

	for slot11, slot12 in ipairs(slot2) do
		slot0:_addAbByEffectUrl(slot6, slot12)
	end

	return slot6, slot7
end

function slot0._addAbByEffectUrl(slot0, slot1, slot2)
	if not tabletool.indexOf(slot1, FightHelper.getEffectAbPath(slot2)) then
		table.insert(slot1, slot3)
	end
end

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

function slot0._analyseSingleTimeline(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = nil

	if not string.nilorempty(ZProj.SkillTimelineAssetHelper.GeAssetJson((not GameResMgr.IsFromEditorDir or FightPreloadController.instance:getFightAssetItem(ResUrl.getSkillTimeline(slot1))) and FightPreloadController.instance:getFightAssetItem(ResUrl.getRolesTimeline()), ResUrl.getSkillTimeline(slot1))) then
		for slot11 = 1, #cjson.decode(slot6), 2 do
			slot14 = slot7[slot11 + 1][1]

			if uv0[tonumber(slot7[slot11])] and not string.nilorempty(slot14) then
				if not string.find(FightHelper.getEffectUrlWithLod(slot14), "/buff/") and not string.find(slot15, "/roleeffects/") then
					table.insert(slot2, slot15)
				else
					table.insert(slot3, slot15)
				end
			end
		end
	end

	return slot2, slot3
end

return slot0
