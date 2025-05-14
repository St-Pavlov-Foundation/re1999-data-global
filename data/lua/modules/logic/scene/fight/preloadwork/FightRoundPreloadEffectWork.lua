module("modules.logic.scene.fight.preloadwork.FightRoundPreloadEffectWork", package.seeall)

local var_0_0 = class("FightRoundPreloadEffectWork", BaseWork)
local var_0_1 = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28] = "FightTLEventDefEffect"
}
local var_0_2 = {
	[1] = "FightTLEventTargetEffect"
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightEffectPool.isForbidEffect then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._concurrentCount = 1
	arg_1_0._interval = 0.1
	arg_1_0._loadingCount = 0
	arg_1_0._effectWrapList = {}
	arg_1_0._needPreloadList = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.context.timelineDict) do
		local var_1_1 = ZProj.SkillTimelineAssetHelper.GeAssetJson(iter_1_1, iter_1_0)

		if not string.nilorempty(var_1_1) then
			local var_1_2 = cjson.decode(var_1_1)

			for iter_1_2 = 1, #var_1_2, 2 do
				local var_1_3 = tonumber(var_1_2[iter_1_2])
				local var_1_4 = var_1_2[iter_1_2 + 1][1]

				if var_0_1[var_1_3] and not string.nilorempty(var_1_4) then
					local var_1_5 = FightHelper.getEffectUrlWithLod(var_1_4)
					local var_1_6 = arg_1_0.context.timelineUrlDict[iter_1_0]
					local var_1_7 = var_1_0[var_1_5]
					local var_1_8 = var_1_6

					if var_0_2[var_1_3] then
						var_1_8 = var_1_6 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
					end

					local var_1_9 = var_1_8

					if var_1_7 and var_1_7 ~= var_1_8 then
						var_1_9 = FightEnum.EntitySide.BothSide
					end

					var_1_0[var_1_5] = var_1_9
				end
			end
		end
	end

	for iter_1_3, iter_1_4 in pairs(var_1_0) do
		arg_1_0:_addPreloadEffect(iter_1_3, iter_1_4)
	end

	arg_1_0:_startPreload()
end

function var_0_0._addPreloadEffect(arg_2_0, arg_2_1, arg_2_2)
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

			if FightEffectPool.hasLoaded(var_3_0.path) or FightEffectPool.isLoading(var_3_0.path) then
				arg_3_0:_detectAfterLoaded()
			else
				local var_3_1 = FightEffectPool.getEffect(var_3_0.path, var_3_0.side, arg_3_0._onPreloadOneFinish, arg_3_0, nil, true)

				var_3_1:setLocalPos(50000, 50000, 50000)
				table.insert(arg_3_0._effectWrapList, var_3_1)
			end
		end
	else
		arg_3_0:_onPreloadAllFinish()
	end
end

function var_0_0._onPreloadOneFinish(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 then
		logError("战斗特效加载失败：" .. arg_4_1.path)
	end

	arg_4_0:_detectAfterLoaded()
end

function var_0_0._detectAfterLoaded(arg_5_0)
	arg_5_0._loadingCount = arg_5_0._loadingCount - 1

	if arg_5_0._loadingCount <= 0 then
		TaskDispatcher.runDelay(arg_5_0._startPreload, arg_5_0, arg_5_0._interval)
	end
end

function var_0_0._onPreloadAllFinish(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._startPreload, arg_7_0, 0.01)

	if arg_7_0._effectWrapList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._effectWrapList) do
			FightEffectPool.returnEffect(iter_7_1)
			iter_7_1:setCallback(nil, nil)
		end
	end

	arg_7_0._effectWrapList = nil
end

return var_0_0
