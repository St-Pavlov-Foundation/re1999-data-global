module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelViewContainer", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_LevelViewContainer", Activity210CorvusViewBaseContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mainView = V3a1_GaoSiNiao_LevelView.New()

	table.insert(var_1_0, arg_1_0._mainView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.mainView(arg_2_0)
	return arg_2_0._mainView
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

function var_0_0.onContainerInit(arg_4_0)
	arg_4_0:_recoverBadPrefsData()
	ActivityEnterMgr.instance:enterActivity(arg_4_0:actId())
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_4_0:actId()
	})
end

function var_0_0._recoverBadPrefsData(arg_5_0)
	local var_5_0, var_5_1 = arg_5_0:getEpisodeCOList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = iter_5_1.episodeId

		if arg_5_0:hasPlayedUnlockedAnimPath(var_5_2) then
			local var_5_3 = arg_5_0:hasPassLevelAndStory(var_5_2)
			local var_5_4 = arg_5_0:isEpisodeOpen(var_5_2)

			if not var_5_3 then
				arg_5_0:unsaveHasPlayedDisactiveAnimPath(var_5_2)
			end

			if not var_5_4 then
				arg_5_0:unsaveHasPlayedUnlockedAnimPath(var_5_2)
			end
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		local var_5_5 = iter_5_3.episodeId

		if not arg_5_0:isEpisodeOpen(var_5_5) then
			arg_5_0:unsaveHasPlayedUnlockedEndless()
		end
	end
end

function var_0_0.getEpisodeCO_disactiveEpisodeInfoDict(arg_6_0, arg_6_1)
	local var_6_0 = GaoSiNiaoConfig.instance:getEpisodeCO_disactiveEpisodeInfoList(arg_6_1)
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		var_6_1[iter_6_1[1]] = iter_6_1[2] or 1
	end

	return var_6_1
end

function var_0_0.isCurPassedEpisodeHasPlayedUnlockedAnimPath(arg_7_0)
	local var_7_0 = arg_7_0:currentPassedEpisodeId()

	if not var_7_0 or var_7_0 <= 0 then
		return true
	end

	return arg_7_0:hasPlayedUnlockedAnimPath(var_7_0)
end

function var_0_0._prefKey_HasPlayedUnlockedAnimPath(arg_8_0, arg_8_1)
	return arg_8_0:getPrefsKeyPrefix_episodeId(arg_8_1) .. "UnlockedAnimPath"
end

function var_0_0.saveHasPlayedUnlockedAnimPath(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_prefKey_HasPlayedUnlockedAnimPath(arg_9_1)

	arg_9_0:saveInt(var_9_0, 1)
end

function var_0_0.unsaveHasPlayedUnlockedAnimPath(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:_prefKey_HasPlayedUnlockedAnimPath(arg_10_1)

	arg_10_0:saveInt(var_10_0, 0)
end

function var_0_0.hasPlayedUnlockedAnimPath(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:_prefKey_HasPlayedUnlockedAnimPath(arg_11_1)

	return arg_11_0:getInt(var_11_0, 0) == 1
end

function var_0_0._prefKey_HasPlayedDisactiveAnimPath(arg_12_0, arg_12_1)
	return arg_12_0:getPrefsKeyPrefix_episodeId(arg_12_1) .. "HasPlayedDisactiveAnimPath"
end

function var_0_0.saveHasPlayedDisactiveAnimPath(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_prefKey_HasPlayedDisactiveAnimPath(arg_13_1)

	arg_13_0:saveInt(var_13_0, 1)
end

function var_0_0.unsaveHasPlayedDisactiveAnimPath(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:_prefKey_HasPlayedDisactiveAnimPath(arg_14_1)

	arg_14_0:saveInt(var_14_0, 0)
end

function var_0_0.hasPlayedDisactiveAnimPath(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:_prefKey_HasPlayedDisactiveAnimPath(arg_15_1)

	return arg_15_0:getInt(var_15_0, 0) == 1
end

function var_0_0._prefKey_HasPlayedUnlockedEndless(arg_16_0)
	return arg_16_0:getPrefsKeyPrefix() .. "HasPlayedUnlockedEndless"
end

function var_0_0.saveHasPlayedUnlockedEndless(arg_17_0)
	local var_17_0 = arg_17_0:_prefKey_HasPlayedUnlockedEndless()

	arg_17_0:saveInt(var_17_0, 1)
end

function var_0_0.unsaveHasPlayedUnlockedEndless(arg_18_0)
	local var_18_0 = arg_18_0:_prefKey_HasPlayedUnlockedEndless()

	arg_18_0:saveInt(var_18_0, 0)
end

function var_0_0.hasPlayedUnlockedEndless(arg_19_0)
	local var_19_0 = arg_19_0:_prefKey_HasPlayedUnlockedEndless()

	return arg_19_0:getInt(var_19_0, 0) == 1
end

return var_0_0
