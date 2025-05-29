module("modules.logic.versionactivity2_2.lopera.controller.LoperaController", package.seeall)

local var_0_0 = class("LoperaController", BaseController)
local var_0_1 = VersionActivity2_2Enum.ActivityId.Lopera

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.openLoperaMainView(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(var_0_1)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	if arg_4_0:_checkCanPlayStory(var_4_1) then
		StoryController.instance:playStory(var_4_1, nil, arg_4_0.openFirstStoryEnd, arg_4_0)
	else
		Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_4_0._onReceivedActInfo, arg_4_0)
	end
end

function var_0_0.openFirstStoryEnd(arg_5_0)
	Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_5_0._onReceivedActInfo, arg_5_0)
end

function var_0_0.openLoperaLevelView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.LoperaLevelView)
end

function var_0_0.openTaskView(arg_7_0)
	ViewMgr.instance:openView(ViewName.LoperaTaskView)
end

function var_0_0._onReceivedActInfo(arg_8_0)
	ViewMgr.instance:openView(ViewName.LoperaMainView)
end

function var_0_0.openSmeltView(arg_9_0)
	ViewMgr.instance:openView(ViewName.LoperaSmeltView)
end

function var_0_0.openSmeltResultView(arg_10_0)
	ViewMgr.instance:openView(ViewName.LoperaSmeltResultView)
end

function var_0_0.openGameResultView(arg_11_0, arg_11_1)
	if arg_11_0._isWaitingEventResult then
		arg_11_0._isWaitingGameResult = true

		return
	end

	arg_11_0._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.LoperaGameResultView, arg_11_1)
end

function var_0_0.enterEpisode(arg_12_0, arg_12_1)
	Activity168Model.instance:setCurActId(VersionActivity2_2Enum.ActivityId.Lopera)

	arg_12_0._curEnterEpisode = arg_12_1

	Activity168Rpc.instance:sendAct168EnterEpisodeRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_12_1, arg_12_0._onEnterGameReply, arg_12_0)
	Activity168Rpc.instance:SetGameSettlePushCallback(arg_12_0._onGameResultPush, arg_12_0)
	Activity168Rpc.instance:SetEpisodePushCallback(arg_12_0._onEpisodeUpdate, arg_12_0)
end

function var_0_0.finishStoryPlay(arg_13_0)
	Activity168Rpc.instance:sendAct168StoryRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_13_0._onEpisodeUpdate, arg_13_0)
end

function var_0_0.moveToDir(arg_14_0, arg_14_1)
	arg_14_0._moveTime = arg_14_0._moveTime + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameMoveRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_14_1, arg_14_0._onMoveDirReply, arg_14_0)
end

function var_0_0.selectOption(arg_15_0, arg_15_1)
	arg_15_0:saveOptionChoosed(arg_15_1)

	arg_15_0._finishEventNum = arg_15_0._finishEventNum + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameSelectOptionRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_15_1, arg_15_0._onSelectOptionReply, arg_15_0)
end

function var_0_0.startBattle(arg_16_0)
	Activity168Rpc.instance:sendStartAct168BattleRequest(VersionActivity2_2Enum.ActivityId.Lopera)
end

function var_0_0.composeItem(arg_17_0, arg_17_1)
	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameComposeItemRequest(var_0_1, arg_17_1, arg_17_0._onComposeDone, arg_17_0)
end

function var_0_0.abortEpisode(arg_18_0)
	Activity168Rpc.instance:sendAct168GameSettleRequest(VersionActivity2_2Enum.ActivityId.Lopera, arg_18_0._onEpisodeUpdate, arg_18_0)
end

function var_0_0.gameResultOver(arg_19_0)
	arg_19_0:dispatchEvent(LoperaEvent.ExitGame)
end

function var_0_0._onEnterGameReply(arg_20_0)
	local var_20_0 = Activity168Config.instance:getEpisodeCfg(var_0_1, arg_20_0._curEnterEpisode)
	local var_20_1 = var_20_0.mapId

	if var_20_1 ~= 0 then
		Activity168Config.instance:InitMapCfg(var_20_1)
	end

	if var_20_0.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		Activity168Model.instance:setCurEpisodeId(arg_20_0._curEnterEpisode)
		arg_20_0:openLoperaLevelView()
	else
		arg_20_0:dispatchEvent(LoperaEvent.EnterEpisode, arg_20_0._curEnterEpisode)
	end

	local var_20_2 = Activity168Model.instance:getCurGameState()
	local var_20_3 = var_20_2.round

	arg_20_0._moveTime = 0
	arg_20_0._finishEventNum = var_20_2.eventId ~= 0 and var_20_2.option <= 0 and var_20_3 - 2 or var_20_3 - 1

	arg_20_0:initStatData(arg_20_0._curEnterEpisode)
end

function var_0_0._onMoveDirReply(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:dispatchEvent(LoperaEvent.EpisodeMove)
end

function var_0_0._onSelectOptionReply(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:dispatchEvent(LoperaEvent.SelectOption)
end

function var_0_0._onEpisodeUpdate(arg_23_0)
	arg_23_0:dispatchEvent(LoperaEvent.EpisodeUpdate)
end

function var_0_0._onComposeDone(arg_24_0)
	arg_24_0:dispatchEvent(LoperaEvent.ComposeDone)
end

function var_0_0._checkCanPlayStory(arg_25_0, arg_25_1)
	if arg_25_1 and arg_25_1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(arg_25_1) then
		return true
	end

	return false
end

function var_0_0._onGameResultPush(arg_26_0, arg_26_1)
	arg_26_0:dispatchEvent(LoperaEvent.EpisodeFinish, arg_26_1)

	local var_26_0 = arg_26_1.episodeId
	local var_26_1 = arg_26_1.power
	local var_26_2 = arg_26_1.cellCount
	local var_26_3 = arg_26_1.settleReason
	local var_26_4 = arg_26_1.totalItems
	local var_26_5 = {}
	local var_26_6 = {}

	for iter_26_0, iter_26_1 in ipairs(var_26_4) do
		local var_26_7 = Activity168Config.instance:getGameItemCfg(var_0_1, iter_26_1.itemId)

		if var_26_7.type == LoperaEnum.ItemType.Material then
			local var_26_8 = {
				alchemy_stuff = var_26_7.name,
				alchemy_stuff_num = iter_26_1.count
			}

			var_26_5[#var_26_5 + 1] = var_26_8
		else
			local var_26_9 = {
				alchemy_prop = var_26_7.name,
				alchemy_prop_num = iter_26_1.count
			}

			var_26_6[#var_26_6 + 1] = var_26_9
		end
	end

	arg_26_0:fillStatInfo(arg_26_0._curEnterEpisode)
	arg_26_0:sendStat()
end

function var_0_0.sendStatOnHomeClick(arg_27_0)
	local var_27_0 = Activity168Model.instance:getCurGameState()
	local var_27_1 = arg_27_0._curEnterEpisode
	local var_27_2 = var_27_0.power
	local var_27_3 = var_27_0.round
	local var_27_4 = 3
	local var_27_5 = var_27_0.totalAct168Items
	local var_27_6 = {}
	local var_27_7 = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_5) do
		local var_27_8 = Activity168Config.instance:getGameItemCfg(var_0_1, iter_27_1.itemId)

		if var_27_8.type == LoperaEnum.ItemType.Material then
			local var_27_9 = {
				alchemy_stuff = var_27_8.name,
				alchemy_stuff_num = iter_27_1.count
			}

			var_27_6[#var_27_6 + 1] = var_27_9
		else
			local var_27_10 = {
				alchemy_prop = var_27_8.name,
				alchemy_prop_num = iter_27_1.count
			}

			var_27_7[#var_27_7 + 1] = var_27_10
		end
	end

	arg_27_0:fillStatInfo(var_27_1, var_27_4, arg_27_0._moveTime, arg_27_0._finishEventNum, var_27_2, var_27_3, var_27_6, var_27_7)
	arg_27_0:sendStat()
end

function var_0_0.checkCanCompose(arg_28_0, arg_28_1)
	local var_28_0
	local var_28_1 = Activity168Config.instance:getComposeTypeList(var_0_1)

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		if iter_28_1.composeType == arg_28_1 then
			var_28_0 = iter_28_1

			break
		end
	end

	local var_28_2 = string.split(var_28_0.costItems, "|")

	for iter_28_2, iter_28_3 in ipairs(var_28_2) do
		local var_28_3 = string.splitToNumber(iter_28_3, "#")
		local var_28_4 = var_28_3[1]

		if var_28_3[2] > Activity168Model.instance:getItemCount(var_28_4) then
			return false
		end
	end

	return true
end

function var_0_0.checkAnyComposable(arg_29_0)
	local var_29_0 = Activity168Config.instance:getComposeTypeList(var_0_1)

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_1 = true
		local var_29_2 = string.split(iter_29_1.costItems, "|")

		for iter_29_2, iter_29_3 in ipairs(var_29_2) do
			local var_29_3 = string.splitToNumber(iter_29_3, "#")
			local var_29_4 = var_29_3[1]

			if var_29_3[2] > Activity168Model.instance:getItemCount(var_29_4) then
				var_29_1 = false

				break
			end
		end

		if var_29_1 then
			return true
		end
	end
end

function var_0_0.checkOptionChoosed(arg_30_0, arg_30_1)
	if not arg_30_0._optionDescRecord then
		arg_30_0._optionDescRecord = {}
		arg_30_0._optionDescRecordStr = ""
		arg_30_0._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		local var_30_0 = string.splitToNumber(arg_30_0._optionDescRecordStr, ",")

		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			arg_30_0._optionDescRecord[iter_30_1] = true
		end
	end

	return arg_30_0._optionDescRecord[arg_30_1]
end

function var_0_0.saveOptionChoosed(arg_31_0, arg_31_1)
	arg_31_0._optionDescRecord[arg_31_1] = true

	if string.nilorempty(arg_31_0._optionDescRecordStr) then
		arg_31_0._optionDescRecordStr = arg_31_1
	else
		arg_31_0._optionDescRecordStr = arg_31_0._optionDescRecordStr .. "," .. arg_31_1
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, arg_31_0._optionDescRecordStr)
end

function var_0_0.initStatData(arg_32_0, arg_32_1)
	arg_32_0.statMo = LoperaStatMo.New()

	arg_32_0.statMo:setEpisodeId(arg_32_1)
end

function var_0_0.fillStatInfo(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8)
	arg_33_0.statMo:fillInfo(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8)
end

function var_0_0.sendStat(arg_34_0)
	arg_34_0.statMo:sendStatData()
end

var_0_0.instance = var_0_0.New()

return var_0_0
