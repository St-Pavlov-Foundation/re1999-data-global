module("modules.logic.scene.fight.preloadwork.FightPreloadEffectWork", package.seeall)

local var_0_0 = class("FightPreloadEffectWork", BaseWork)

var_0_0.buff_chuchang = "buff/buff_chuchang"
var_0_0.buff_siwang = "buff/buff_siwang_role"
var_0_0.buff_siwang_monster = "buff/buff_siwang_monster"
var_0_0.buff_zhunbeigongji = "buff/buff_zhunbeigongji"
var_0_0.scene_mask_default = "buff/scene_mask_default"

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightEffectPool.isForbidEffect then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._concurrentCount = 10
	arg_1_0._loadingCount = 0
	arg_1_0._effectWrapList = {}
	arg_1_0._needPreloadList = {}

	arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(var_0_0.buff_chuchang))
	arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(var_0_0.buff_siwang))
	arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(var_0_0.buff_siwang_monster))
	arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(var_0_0.buff_zhunbeigongji))
	arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(var_0_0.scene_mask_default))

	local var_1_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = iter_1_1.skin
		local var_1_2 = var_1_1 and lua_skin_spine_action.configDict[var_1_1]

		if var_1_2 then
			local var_1_3 = var_1_2[SpineAnimState.born]

			if var_1_3 and not string.nilorempty(var_1_3.effect) then
				local var_1_4 = string.split(var_1_3.effect, "#")

				for iter_1_2, iter_1_3 in ipairs(var_1_4) do
					arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(iter_1_3))
				end
			end
		end

		local var_1_5 = lua_fight_luxi_skin_effect.configDict[var_1_1]
		local var_1_6 = var_1_5 and var_1_5[SpineAnimState.born]

		if var_1_6 then
			local var_1_7 = string.split(var_1_6.effect, "#")

			for iter_1_4, iter_1_5 in ipairs(var_1_7) do
				arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(iter_1_5))
			end
		end
	end

	local var_1_8 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_1_6, iter_1_7 in ipairs(var_1_8) do
		local var_1_9 = FightConfig.instance:getSkinCO(iter_1_7.skin)

		if var_1_9 and not string.nilorempty(var_1_9.effect) then
			local var_1_10 = string.split(var_1_9.effect, "#")

			for iter_1_8, iter_1_9 in ipairs(var_1_10) do
				local var_1_11 = FightHelper.getEffectUrlWithLod(iter_1_9)

				arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(iter_1_9))
			end
		end

		local var_1_12 = lua_monster.configDict[iter_1_7.modelId]

		if var_1_12 and not string.nilorempty(var_1_12.effect) then
			local var_1_13 = string.split(var_1_12.effect, "#")

			for iter_1_10, iter_1_11 in ipairs(var_1_13) do
				local var_1_14 = FightHelper.getEffectUrlWithLod(iter_1_11)

				arg_1_0:_addPreloadEffect(FightHelper.getEffectUrlWithLod(iter_1_11))
			end
		end
	end

	arg_1_0:_startPreload()
end

function var_0_0._addPreloadEffect(arg_2_0, arg_2_1, arg_2_2)
	if (isDebugBuild or SLFramework.FrameworkSettings.IsEditor) and not string.match(arg_2_1, "^effects/prefabs/buff/") then
		logError(arg_2_1 .. " 预加载资源需要放在 Assets/ZResourcesLib/effects/prefabs/buff 目录下。")
	end

	if FightEffectPool.hasLoaded(arg_2_1) then
		return
	end

	if arg_2_2 == nil then
		table.insert(arg_2_0._needPreloadList, {
			path = arg_2_1,
			side = FightEnum.EntitySide.BothSide
		})
	end

	if arg_2_2 == FightEnum.EntitySide.MySide or arg_2_2 == FightEnum.EntitySide.BothSide then
		table.insert(arg_2_0._needPreloadList, {
			path = arg_2_1,
			side = FightEnum.EntitySide.MySide
		})
	end

	if arg_2_2 == FightEnum.EntitySide.EnemySide or arg_2_2 == FightEnum.EntitySide.BothSide then
		table.insert(arg_2_0._needPreloadList, {
			path = arg_2_1,
			side = FightEnum.EntitySide.EnemySide
		})
	end
end

function var_0_0._startPreload(arg_3_0)
	arg_3_0._loadingCount = math.min(arg_3_0._concurrentCount, #arg_3_0._needPreloadList)

	if arg_3_0._loadingCount > 0 then
		for iter_3_0 = 1, arg_3_0._loadingCount do
			local var_3_0 = table.remove(arg_3_0._needPreloadList, #arg_3_0._needPreloadList)
			local var_3_1 = FightEffectPool.getEffect(var_3_0.path, var_3_0.side, arg_3_0._onPreloadOneFinish, arg_3_0, nil, true)

			table.insert(arg_3_0._effectWrapList, var_3_1)
		end
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._onPreloadOneFinish(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 then
		logError("战斗特效加载失败：" .. arg_4_1.path)
	end

	arg_4_0._loadingCount = arg_4_0._loadingCount - 1

	FightEffectPool.returnEffect(arg_4_1)

	if arg_4_0._loadingCount <= 0 then
		TaskDispatcher.runDelay(arg_4_0._startPreload, arg_4_0, 0.01)
	end
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._startPreload, arg_5_0, 0.01)

	if arg_5_0._effectWrapList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._effectWrapList) do
			iter_5_1:setCallback(nil, nil)
		end
	end

	arg_5_0._effectWrapList = nil
end

return var_0_0
