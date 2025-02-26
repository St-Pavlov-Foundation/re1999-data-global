module("modules.logic.scene.fight.preloadwork.FightPreloadEffectWork", package.seeall)

slot0 = class("FightPreloadEffectWork", BaseWork)
slot0.buff_chuchang = "buff/buff_chuchang"
slot0.buff_siwang = "buff/buff_siwang_role"
slot0.buff_siwang_monster = "buff/buff_siwang_monster"
slot0.buff_zhunbeigongji = "buff/buff_zhunbeigongji"
slot0.scene_mask_default = "buff/scene_mask_default"

function slot0.onStart(slot0, slot1)
	if FightEffectPool.isForbidEffect then
		slot0:onDone(true)

		return
	end

	slot0._concurrentCount = 10
	slot0._loadingCount = 0
	slot0._effectWrapList = {}
	slot0._needPreloadList = {}

	slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(uv0.buff_chuchang))
	slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(uv0.buff_siwang))
	slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(uv0.buff_siwang_monster))
	slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(uv0.buff_zhunbeigongji))
	slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(uv0.scene_mask_default))

	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		if slot7.skin and lua_skin_spine_action.configDict[slot8] and slot9[SpineAnimState.born] and not string.nilorempty(slot10.effect) then
			for slot15, slot16 in ipairs(string.split(slot10.effect, "#")) do
				slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(slot16))
			end
		end
	end

	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if FightConfig.instance:getSkinCO(slot8.skin) and not string.nilorempty(slot9.effect) then
			for slot14, slot15 in ipairs(string.split(slot9.effect, "#")) do
				slot16 = FightHelper.getEffectUrlWithLod(slot15)

				slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(slot15))
			end
		end

		if lua_monster.configDict[slot8.modelId] and not string.nilorempty(slot10.effect) then
			for slot15, slot16 in ipairs(string.split(slot10.effect, "#")) do
				slot17 = FightHelper.getEffectUrlWithLod(slot16)

				slot0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(slot16))
			end
		end
	end

	slot0:_startPreload()
end

function slot0._addPreloadEffect(slot0, slot1, slot2)
	if (isDebugBuild or SLFramework.FrameworkSettings.IsEditor) and not string.match(slot1, "^effects/prefabs/buff/") then
		logError(slot1 .. " 预加载资源需要放在 Assets/ZResourcesLib/effects/prefabs/buff 目录下。")
	end

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
			slot5 = table.remove(slot0._needPreloadList, #slot0._needPreloadList)

			table.insert(slot0._effectWrapList, FightEffectPool.getEffect(slot5.path, slot5.side, slot0._onPreloadOneFinish, slot0, nil, true))
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onPreloadOneFinish(slot0, slot1, slot2)
	if not slot2 then
		logError("战斗特效加载失败：" .. slot1.path)
	end

	slot0._loadingCount = slot0._loadingCount - 1

	FightEffectPool.returnEffect(slot1)

	if slot0._loadingCount <= 0 then
		TaskDispatcher.runDelay(slot0._startPreload, slot0, 0.01)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._startPreload, slot0, 0.01)

	if slot0._effectWrapList then
		for slot4, slot5 in ipairs(slot0._effectWrapList) do
			slot5:setCallback(nil, )
		end
	end

	slot0._effectWrapList = nil
end

return slot0
