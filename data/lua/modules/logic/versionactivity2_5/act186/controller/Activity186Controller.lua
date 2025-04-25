module("modules.logic.versionactivity2_5.act186.controller.Activity186Controller", package.seeall)

slot0 = class("Activity186Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setPlayerPrefs(slot0, slot1, slot2)
	if string.nilorempty(slot1) or not slot2 then
		return
	end

	if type(slot2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
	else
		GameUtil.playerPrefsSetStringByUserId(slot1, slot2)
	end

	slot0:dispatchEvent(Activity186Event.LocalKeyChange)
end

function slot0.getPlayerPrefs(slot0, slot1, slot2)
	slot3 = slot2 or ""

	if string.nilorempty(slot1) then
		return slot3
	end

	return (not (type(slot3) == "number") or GameUtil.playerPrefsGetNumberByUserId(slot1, slot3)) and GameUtil.playerPrefsGetStringByUserId(slot1, slot3)
end

function slot0.checkEnterGame(slot0, slot1, slot2)
	if not Activity186Model.instance:getById(slot1) then
		return
	end

	if not slot3:getOnlineGameList() or #slot4 == 0 then
		return
	end

	slot5 = slot4[1]

	if not slot2 then
		slot5 = nil

		for slot9, slot10 in ipairs(slot4) do
			if Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, slot1, slot10.gameId, 0) == 0 then
				slot5 = slot10

				break
			end
		end
	end

	if slot5 then
		Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, slot1, slot5.gameId, 1)
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = slot1,
			gameId = slot5.gameId,
			gameStatus = Activity186Enum.GameStatus.Start,
			gameType = slot5.gameTypeId
		})
	end
end

function slot0.enterGame(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not Activity186Model.instance:getById(slot1) then
		return
	end

	if not slot3:isGameOnline(slot2) then
		return
	end

	if not slot3:getGameInfo(slot2) then
		return
	end

	if slot4.gameTypeId == 1 then
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = slot1,
			gameId = slot2,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	else
		ViewMgr.instance:openView(ViewName.Activity186GameDrawlotsView, {
			activityId = slot1,
			gameId = slot2,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	end
end

function slot0.openTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, slot0._onOpenTaskView, slot0)
end

function slot0._onOpenTaskView(slot0)
	ViewMgr.instance:openView(ViewName.Activity186TaskView, {
		actId = Activity186Model.instance:getActId()
	})
end

slot0.instance = slot0.New()

return slot0
