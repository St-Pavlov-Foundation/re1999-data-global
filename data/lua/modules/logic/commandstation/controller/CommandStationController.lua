module("modules.logic.commandstation.controller.CommandStationController", package.seeall)

local var_0_0 = class("CommandStationController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_3_0._newFuncUnlock, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.PreSetRedDot, arg_3_0._onInsertRed, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, arg_3_0._onBeforeOpenView, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._chapterList = nil
	arg_4_0._episodeId = nil
end

function var_0_0.setRecordEpisodeId(arg_5_0, arg_5_1)
	arg_5_0._episodeId = arg_5_1
end

function var_0_0.getRecordEpisodeId(arg_6_0)
	return arg_6_0._episodeId
end

function var_0_0.chapterInCommandStation(arg_7_0, arg_7_1)
	if not arg_7_0._chapterList then
		local var_7_0 = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

		if var_7_0 then
			arg_7_0._chapterList = string.splitToNumber(var_7_0.value2, "#")
		end
	end

	if not arg_7_0._chapterList or not arg_7_1 or not tabletool.indexOf(arg_7_0._chapterList, arg_7_1) then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation)
end

function var_0_0._onBeforeOpenView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CommandStationMapView then
		CommandStationMapModel.instance:initTimeId()
	end
end

function var_0_0._newFuncUnlock(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1 == OpenEnum.UnlockFunc.CommandStation then
			CommandStationRpc.instance:sendGetCommandPostInfoRequest()

			break
		end
	end
end

function var_0_0._onInsertRed(arg_10_0, arg_10_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		return
	end

	local var_10_0 = CommandStationConfig.instance:getCurVersionId()

	arg_10_0:_initializeRedDotInfo(arg_10_1, RedDotEnum.DotNode.CommandStationTaskNormal, PlayerPrefsKey.CommandStationTaskNormalOnce .. var_10_0)

	if #CommandStationTaskListModel.instance.allCatchTaskMos > 0 then
		arg_10_0:_initializeRedDotInfo(arg_10_1, RedDotEnum.DotNode.CommandStationTaskCatch, PlayerPrefsKey.CommandStationTaskCatchOnce .. var_10_0)
	end
end

function var_0_0._initializeRedDotInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = GameUtil.playerPrefsGetNumberByUserId(arg_11_3, 1)
	local var_11_1 = arg_11_1[arg_11_2]
	local var_11_2 = RedDotRpc.instance:clientMakeRedDotGroupItem(-1, var_11_0)
	local var_11_3 = RedDotRpc.instance:clientMakeRedDotGroup(arg_11_2, {
		var_11_2
	}, false)

	if not var_11_1 then
		var_11_1 = RedDotGroupMo.New()
		arg_11_1[arg_11_2] = var_11_1

		var_11_1:init(var_11_3)
	else
		var_11_1:_resetDotInfo(var_11_3)
	end
end

function var_0_0.openCommandStationTimelineEventView(arg_12_0, arg_12_1, arg_12_2)
	ViewMgr.instance:openView(ViewName.CommandStationTimelineEventView, arg_12_1, arg_12_2)
end

function var_0_0.openCommandStationDispatchEventMainView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.CommandStationDispatchEventMainView, arg_13_1, arg_13_2)
end

function var_0_0.openCommandStationCharacterEventView(arg_14_0, arg_14_1, arg_14_2)
	ViewMgr.instance:openView(ViewName.CommandStationCharacterEventView, arg_14_1, arg_14_2)
end

function var_0_0.openCommandStationDialogueEventView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.CommandStationDialogueEventView, arg_15_1, arg_15_2)
end

function var_0_0.openCommandStationMapView(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:openView(ViewName.CommandStationMapView, arg_16_1, arg_16_2)
end

function var_0_0.openCommandStationDetailView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.CommandStationDetailView, arg_17_1, arg_17_2)
end

function var_0_0.openCommandStationEnterView(arg_18_0, arg_18_1, arg_18_2)
	ViewMgr.instance:openView(ViewName.CommandStationEnterView, arg_18_1, arg_18_2)
end

function var_0_0.openCommandStationEnterAnimView(arg_19_0, arg_19_1, arg_19_2)
	ViewMgr.instance:openView(ViewName.CommandStationEnterAnimView, arg_19_1, arg_19_2)
end

function var_0_0.openCommandStationPaperView(arg_20_0, arg_20_1, arg_20_2)
	ViewMgr.instance:openView(ViewName.CommandStationPaperView, arg_20_1, arg_20_2)
end

function var_0_0.openCommandStationPaperGetView(arg_21_0, arg_21_1, arg_21_2)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, arg_21_1, arg_21_2)
end

function var_0_0.openCommandStationTaskView(arg_22_0, arg_22_1, arg_22_2)
	CommandStationRpc.instance:sendGetCommandPostInfoRequest(arg_22_0._onGetPostInfo, arg_22_0)
end

function var_0_0._onGetPostInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 then
		ViewMgr.instance:openView(ViewName.CommandStationTaskView)
	end
end

function var_0_0.hasOnceActionKey(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0._getKey(arg_24_0, arg_24_1)

	return PlayerPrefsHelper.hasKey(var_24_0)
end

function var_0_0.setOnceActionKey(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0._getKey(arg_25_0, arg_25_1)

	PlayerPrefsHelper.setNumber(var_25_0, 1)
end

function var_0_0.setSaveNumber(arg_26_0, arg_26_1)
	local var_26_0 = var_0_0._getKey(arg_26_0)

	PlayerPrefsHelper.setNumber(var_26_0, arg_26_1)
end

function var_0_0.getSaveNumber(arg_27_0)
	local var_27_0 = var_0_0._getKey(arg_27_0)

	return (PlayerPrefsHelper.getNumber(var_27_0, 0))
end

function var_0_0._getKey(arg_28_0, arg_28_1)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.CommandStationOnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_28_0, arg_28_1))
end

function var_0_0.CustomOutBack(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	local var_29_0 = recthelper.getAnchorX(arg_29_0)
	local var_29_1 = math.abs(arg_29_2 - var_29_0)
	local var_29_2 = arg_29_3 >= var_29_1 * 0.1 and 1 or arg_29_3 / (var_29_1 * 0.1)

	return ZProj.TweenHelper.DOTweenFloat(var_29_0, arg_29_2, arg_29_1, function(arg_30_0, arg_30_1)
		if var_29_0 < arg_29_2 then
			if arg_30_1 >= arg_29_2 then
				local var_30_0 = arg_30_1 - arg_29_2

				arg_30_1 = arg_29_2 + var_30_0 * var_29_2
			end
		elseif arg_30_1 <= arg_29_2 then
			local var_30_1 = arg_29_2 - arg_30_1

			arg_30_1 = arg_29_2 - var_30_1 * var_29_2
		end

		recthelper.setAnchorX(arg_29_0, arg_30_1)
	end, arg_29_4, arg_29_5, arg_29_6, arg_29_7 or EaseType.OutBack)
end

function var_0_0.StatCommandStationViewClose(arg_31_0, arg_31_1)
	StatController.instance:track(StatEnum.EventName.CommandStationViewClose, {
		[StatEnum.EventProperties.ViewName] = arg_31_0,
		[StatEnum.EventProperties.UseTime] = arg_31_1
	})
end

function var_0_0.StatCommandStationButtonClick(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0

	if (arg_32_2 or CommandStationMapModel.instance:getEventCategory()) == CommandStationEnum.EventCategory.Normal then
		var_32_0 = luaLang("commandstation_map_event")
	else
		var_32_0 = luaLang("commandstation_map_character")
	end

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = arg_32_0,
		[StatEnum.EventProperties.CommandStationTimelineMode] = var_32_0,
		[StatEnum.EventProperties.ButtonName] = arg_32_1
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
