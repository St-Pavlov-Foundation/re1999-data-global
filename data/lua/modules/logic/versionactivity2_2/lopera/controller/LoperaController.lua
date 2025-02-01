module("modules.logic.versionactivity2_2.lopera.controller.LoperaController", package.seeall)

slot0 = class("LoperaController", BaseController)
slot1 = VersionActivity2_2Enum.ActivityId.Lopera

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.openLoperaMainView(slot0)
	if slot0:_checkCanPlayStory(ActivityModel.instance:getActMO(uv0) and slot1.config and slot1.config.storyId) then
		StoryController.instance:playStory(slot2, nil, slot0.openFirstStoryEnd, slot0)
	else
		Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot0._onReceivedActInfo, slot0)
	end
end

function slot0.openFirstStoryEnd(slot0)
	Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot0._onReceivedActInfo, slot0)
end

function slot0.openLoperaLevelView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.LoperaLevelView)
end

function slot0.openTaskView(slot0)
	ViewMgr.instance:openView(ViewName.LoperaTaskView)
end

function slot0._onReceivedActInfo(slot0)
	ViewMgr.instance:openView(ViewName.LoperaMainView)
end

function slot0.openSmeltView(slot0)
	ViewMgr.instance:openView(ViewName.LoperaSmeltView)
end

function slot0.openSmeltResultView(slot0)
	ViewMgr.instance:openView(ViewName.LoperaSmeltResultView)
end

function slot0.openGameResultView(slot0, slot1)
	if slot0._isWaitingEventResult then
		slot0._isWaitingGameResult = true

		return
	end

	slot0._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.LoperaGameResultView, slot1)
end

function slot0.enterEpisode(slot0, slot1)
	Activity168Model.instance:setCurActId(VersionActivity2_2Enum.ActivityId.Lopera)

	slot0._curEnterEpisode = slot1

	Activity168Rpc.instance:sendAct168EnterEpisodeRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot1, slot0._onEnterGameReply, slot0)
	Activity168Rpc.instance:SetGameSettlePushCallback(slot0._onGameResultPush, slot0)
	Activity168Rpc.instance:SetEpisodePushCallback(slot0._onEpisodeUpdate, slot0)
end

function slot0.finishStoryPlay(slot0)
	Activity168Rpc.instance:sendAct168StoryRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot0._onEpisodeUpdate, slot0)
end

function slot0.moveToDir(slot0, slot1)
	slot0._moveTime = slot0._moveTime + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameMoveRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot1, slot0._onMoveDirReply, slot0)
end

function slot0.selectOption(slot0, slot1)
	slot0:saveOptionChoosed(slot1)

	slot0._finishEventNum = slot0._finishEventNum + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameSelectOptionRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot1, slot0._onSelectOptionReply, slot0)
end

function slot0.startBattle(slot0)
	Activity168Rpc.instance:sendStartAct168BattleRequest(VersionActivity2_2Enum.ActivityId.Lopera)
end

function slot0.composeItem(slot0, slot1)
	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameComposeItemRequest(uv0, slot1, slot0._onComposeDone, slot0)
end

function slot0.abortEpisode(slot0)
	Activity168Rpc.instance:sendAct168GameSettleRequest(VersionActivity2_2Enum.ActivityId.Lopera, slot0._onEpisodeUpdate, slot0)
end

function slot0.gameResultOver(slot0)
	slot0:dispatchEvent(LoperaEvent.ExitGame)
end

function slot0._onEnterGameReply(slot0)
	if Activity168Config.instance:getEpisodeCfg(uv0, slot0._curEnterEpisode).mapId ~= 0 then
		Activity168Config.instance:InitMapCfg(slot2)
	end

	if slot1.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		Activity168Model.instance:setCurEpisodeId(slot0._curEnterEpisode)
		slot0:openLoperaLevelView()
	else
		slot0:dispatchEvent(LoperaEvent.EnterEpisode, slot0._curEnterEpisode)
	end

	slot3 = Activity168Model.instance:getCurGameState()
	slot4 = slot3.round
	slot0._moveTime = 0
	slot0._finishEventNum = slot3.eventId ~= 0 and slot3.option <= 0 and slot4 - 2 or slot4 - 1

	slot0:initStatData(slot0._curEnterEpisode)
end

function slot0._onMoveDirReply(slot0, slot1, slot2)
	slot0:dispatchEvent(LoperaEvent.EpisodeMove)
end

function slot0._onSelectOptionReply(slot0, slot1, slot2)
	slot0:dispatchEvent(LoperaEvent.SelectOption)
end

function slot0._onEpisodeUpdate(slot0)
	slot0:dispatchEvent(LoperaEvent.EpisodeUpdate)
end

function slot0._onComposeDone(slot0)
	slot0:dispatchEvent(LoperaEvent.ComposeDone)
end

function slot0._checkCanPlayStory(slot0, slot1)
	if slot1 and slot1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(slot1) then
		return true
	end

	return false
end

function slot0._onGameResultPush(slot0, slot1)
	slot0:dispatchEvent(LoperaEvent.EpisodeFinish, slot1)

	slot2 = slot1.episodeId
	slot3 = slot1.power
	slot4 = slot1.cellCount
	slot5 = slot1.settleReason
	slot7 = {}
	slot8 = {}

	for slot12, slot13 in ipairs(slot1.totalItems) do
		if Activity168Config.instance:getGameItemCfg(uv0, slot13.itemId).type == LoperaEnum.ItemType.Material then
			slot7[#slot7 + 1] = {
				alchemy_stuff = slot14.name,
				alchemy_stuff_num = slot13.count
			}
		else
			slot8[#slot8 + 1] = {
				alchemy_prop = slot14.name,
				alchemy_prop_num = slot13.count
			}
		end
	end

	slot0:fillStatInfo(slot2, slot5, slot0._moveTime, slot0._finishEventNum, slot3, slot4, slot7, slot8)
	slot0:sendStat()
end

function slot0.sendStatOnHomeClick(slot0)
	slot1 = Activity168Model.instance:getCurGameState()
	slot2 = slot0._curEnterEpisode
	slot3 = slot1.power
	slot4 = slot1.round
	slot5 = 3
	slot7 = {}
	slot8 = {}

	for slot12, slot13 in ipairs(slot1.totalAct168Items) do
		if Activity168Config.instance:getGameItemCfg(uv0, slot13.itemId).type == LoperaEnum.ItemType.Material then
			slot7[#slot7 + 1] = {
				alchemy_stuff = slot14.name,
				alchemy_stuff_num = slot13.count
			}
		else
			slot8[#slot8 + 1] = {
				alchemy_prop = slot14.name,
				alchemy_prop_num = slot13.count
			}
		end
	end

	slot0:fillStatInfo(slot2, slot5, slot0._moveTime, slot0._finishEventNum, slot3, slot4, slot7, slot8)
	slot0:sendStat()
end

function slot0.checkCanCompose(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(Activity168Config.instance:getComposeTypeList(uv0)) do
		if slot8.composeType == slot1 then
			slot2 = slot8

			break
		end
	end

	for slot8, slot9 in ipairs(string.split(slot2.costItems, "|")) do
		slot10 = string.splitToNumber(slot9, "#")

		if Activity168Model.instance:getItemCount(slot10[1]) < slot10[2] then
			return false
		end
	end

	return true
end

function slot0.checkAnyComposable(slot0)
	for slot5, slot6 in ipairs(Activity168Config.instance:getComposeTypeList(uv0)) do
		slot7 = true

		for slot12, slot13 in ipairs(string.split(slot6.costItems, "|")) do
			slot14 = string.splitToNumber(slot13, "#")

			if Activity168Model.instance:getItemCount(slot14[1]) < slot14[2] then
				slot7 = false

				break
			end
		end

		if slot7 then
			return true
		end
	end
end

function slot0.checkOptionChoosed(slot0, slot1)
	if not slot0._optionDescRecord then
		slot0._optionDescRecord = {}
		slot0._optionDescRecordStr = ""
		slot0._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		for slot6, slot7 in pairs(string.splitToNumber(slot0._optionDescRecordStr, ",")) do
			slot0._optionDescRecord[slot7] = true
		end
	end

	return slot0._optionDescRecord[slot1]
end

function slot0.saveOptionChoosed(slot0, slot1)
	slot0._optionDescRecord[slot1] = true

	if string.nilorempty(slot0._optionDescRecordStr) then
		slot0._optionDescRecordStr = slot1
	else
		slot0._optionDescRecordStr = slot0._optionDescRecordStr .. "," .. slot1
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, slot0._optionDescRecordStr)
end

function slot0.initStatData(slot0, slot1)
	slot0.statMo = LoperaStatMo.New()

	slot0.statMo:setEpisodeId(slot1)
end

function slot0.fillStatInfo(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.statMo:fillInfo(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
end

function slot0.sendStat(slot0)
	slot0.statMo:sendStatData()
end

slot0.instance = slot0.New()

return slot0
