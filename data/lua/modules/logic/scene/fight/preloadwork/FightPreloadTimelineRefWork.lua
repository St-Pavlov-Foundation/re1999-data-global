module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineRefWork", package.seeall)

local var_0_0 = class("FightPreloadTimelineRefWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._urlDict = arg_1_0:_getUrlList()
	arg_1_0._loader = SequenceAbLoader.New()

	for iter_1_0, iter_1_1 in pairs(arg_1_0._urlDict) do
		arg_1_0._loader:addPath(iter_1_0)
	end

	arg_1_0._loader:setLoadFailCallback(arg_1_0._onOneLoadFail)
	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0.clearWork(arg_2_0)
	if arg_2_0._loader then
		arg_2_0._loader:dispose()

		arg_2_0._loader = nil
	end

	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
end

function var_0_0._onOneLoadFail(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.ResPath

	logError("预加载战斗Timeline引用资源失败！\nTimeline: " .. arg_3_0._urlDict[var_3_0] .. "\n引用资源: " .. var_3_0)
end

function var_0_0._onPreloadFinish(arg_4_0)
	local var_4_0 = arg_4_0._loader:getAssetItemDict()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		arg_4_0.context.callback(arg_4_0.context.callbackObj, iter_4_1)
		FightPreloadController.instance:addTimelineRefAsset(iter_4_1)
	end

	TaskDispatcher.runDelay(arg_4_0._delayDone, arg_4_0, 0.001)
end

function var_0_0._delayDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0._getUrlList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.context.timelineDict) do
		local var_6_1 = ZProj.SkillTimelineAssetHelper.GeAssetJson(iter_6_1, iter_6_0)

		if not string.nilorempty(var_6_1) then
			local var_6_2 = cjson.decode(var_6_1)

			for iter_6_2 = 1, #var_6_2, 2 do
				local var_6_3 = tonumber(var_6_2[iter_6_2])
				local var_6_4 = var_6_2[iter_6_2 + 1]

				if var_6_3 == 30 then
					-- block empty
				elseif var_6_3 == 31 then
					-- block empty
				elseif var_6_3 == 32 then
					local var_6_5 = var_6_4[2]

					if not string.nilorempty(var_6_5) then
						var_6_0[ResUrl.getRoleSpineMatTex(var_6_5)] = iter_6_0
					end
				elseif var_6_3 == 11 then
					local var_6_6 = arg_6_0.context.timelineSkinDict[iter_6_0] or {}

					for iter_6_3, iter_6_4 in pairs(var_6_6) do
						local var_6_7 = FightTLEventCreateSpine.getSkinSpineName(var_6_4[1], iter_6_3)

						if not string.nilorempty(var_6_7) then
							var_6_0[ResUrl.getSpineFightPrefab(var_6_7)] = iter_6_0
						end
					end
				end
			end
		end
	end

	return var_6_0
end

return var_0_0
