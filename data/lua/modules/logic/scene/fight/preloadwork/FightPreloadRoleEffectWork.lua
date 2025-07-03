module("modules.logic.scene.fight.preloadwork.FightPreloadRoleEffectWork", package.seeall)

local var_0_0 = class("FightPreloadRoleEffectWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GameResMgr.IsFromEditorDir then
		arg_1_0:onDone(true)

		return
	end

	if FightEffectPool.isForbidEffect then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._startTime = Time.time

	local var_1_0, var_1_1 = arg_1_0:_analyseEffectUrlList()

	arg_1_0._replayAb2EffectUrlList = var_1_1
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:setPathList(var_1_0)
	arg_1_0._loader:setConcurrentCount(1)
	arg_1_0._loader:setInterval(0.01)
	arg_1_0._loader:setOneFinishCallback(arg_1_0._onPreloadOneFinish, arg_1_0)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail, arg_1_0)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
	logNormal("preload 开始预加载角色特效 " .. Time.time)
end

function var_0_0._onPreloadOneFinish(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = Time.time
	local var_2_1 = var_2_0 - arg_2_0._startTime

	logNormal(string.format("preload %.2f_%.2f %s", Time.time, var_2_1, arg_2_2.ResPath))

	arg_2_0._startTime = var_2_0

	local var_2_2 = arg_2_0._replayAb2EffectUrlList[arg_2_2.ResPath]

	if var_2_2 then
		for iter_2_0, iter_2_1 in ipairs(var_2_2) do
			local var_2_3 = FightEffectPool.getEffect(iter_2_1, FightEnum.EntitySide.MySide, nil, nil, nil, true)

			FightEffectPool.returnEffect(var_2_3)
		end
	end
end

function var_0_0._onPreloadFinish(arg_3_0)
	local var_3_0 = arg_3_0._loader:getAssetItemDict()

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		arg_3_0.context.callback(arg_3_0.context.callbackObj, iter_3_1)
	end

	arg_3_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_4_0, arg_4_1, arg_4_2)
	logError("战斗资源加载失败：" .. arg_4_2.ResPath)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end
end

function var_0_0._analyseEffectUrlList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		local var_6_3 = iter_6_1.id
		local var_6_4 = iter_6_1.skillList

		for iter_6_2, iter_6_3 in ipairs(var_6_4) do
			if iter_6_1:isActiveSkill(iter_6_3) then
				local var_6_5 = FightConfig.instance:getSkinSkillTimeline(iter_6_1.skin, iter_6_3)
				local var_6_6 = FightHelper.getTimelineListByName(var_6_5, iter_6_1.skin)

				for iter_6_4, iter_6_5 in ipairs(var_6_6) do
					local var_6_7 = iter_6_5

					if not string.nilorempty(var_6_7) then
						local var_6_8, var_6_9 = arg_6_0:_analyseSingleTimeline(var_6_7)

						var_6_0[iter_6_3] = var_6_0[iter_6_3] or {}

						tabletool.addValues(var_6_0[iter_6_3], var_6_8)
						tabletool.addValues(var_6_1, var_6_9)
					end
				end
			end
		end
	end

	local var_6_10 = {}

	if FightModel.instance:getFightParam().isReplay then
		local var_6_11 = FightDataHelper.handCardMgr.handCard
		local var_6_12 = FightReplayModel.instance:getList()
		local var_6_13 = var_6_12 and var_6_12[1]

		if var_6_13 then
			for iter_6_6, iter_6_7 in ipairs(var_6_13.opers) do
				if iter_6_7.operType == FightEnum.CardOpType.PlayCard then
					local var_6_14 = var_6_11 and var_6_11[iter_6_7.param1]
					local var_6_15 = var_6_14 and var_6_14.skillId
					local var_6_16 = var_6_15 and var_6_0[var_6_15]

					if var_6_16 then
						tabletool.addValues(var_6_10, var_6_16)

						var_6_0[var_6_15] = nil
					end
				end

				break
			end
		end
	end

	local var_6_17 = {}
	local var_6_18 = {}

	for iter_6_8, iter_6_9 in ipairs(var_6_10) do
		arg_6_0:_addAbByEffectUrl(var_6_17, iter_6_9)

		local var_6_19 = FightHelper.getEffectAbPath(iter_6_9)

		var_6_18[var_6_19] = var_6_18[var_6_19] or {}

		if not tabletool.indexOf(var_6_18[var_6_19], iter_6_9) then
			table.insert(var_6_18[var_6_19], iter_6_9)
		end
	end

	for iter_6_10, iter_6_11 in pairs(var_6_0) do
		for iter_6_12, iter_6_13 in ipairs(iter_6_11) do
			arg_6_0:_addAbByEffectUrl(var_6_17, iter_6_13)
		end
	end

	for iter_6_14, iter_6_15 in ipairs(var_6_1) do
		arg_6_0:_addAbByEffectUrl(var_6_17, iter_6_15)
	end

	return var_6_17, var_6_18
end

function var_0_0._addAbByEffectUrl(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = FightHelper.getEffectAbPath(arg_7_2)

	if not tabletool.indexOf(arg_7_1, var_7_0) then
		table.insert(arg_7_1, var_7_0)
	end
end

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

function var_0_0._analyseSingleTimeline(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2
	local var_8_3 = ResUrl.getSkillTimeline(arg_8_1)

	if GameResMgr.IsFromEditorDir then
		var_8_2 = FightPreloadController.instance:getFightAssetItem(ResUrl.getSkillTimeline(arg_8_1))
	else
		var_8_2 = FightPreloadController.instance:getFightAssetItem(ResUrl.getRolesTimeline())
	end

	local var_8_4 = ZProj.SkillTimelineAssetHelper.GeAssetJson(var_8_2, var_8_3)

	if not string.nilorempty(var_8_4) then
		local var_8_5 = cjson.decode(var_8_4)

		for iter_8_0 = 1, #var_8_5, 2 do
			local var_8_6 = tonumber(var_8_5[iter_8_0])
			local var_8_7 = var_8_5[iter_8_0 + 1][1]

			if var_0_1[var_8_6] and not string.nilorempty(var_8_7) then
				local var_8_8 = FightHelper.getEffectUrlWithLod(var_8_7)

				if not string.find(var_8_8, "/buff/") and not string.find(var_8_8, "/roleeffects/") then
					table.insert(var_8_0, var_8_8)
				else
					table.insert(var_8_1, var_8_8)
				end
			end
		end
	end

	return var_8_0, var_8_1
end

return var_0_0
