module("modules.logic.rouge.map.controller.RougeMapController", package.seeall)

slot0 = class("RougeMapController")

function slot0.registerMap(slot0, slot1)
	slot0.mapComp = slot1
end

function slot0.unregisterMap(slot0)
	slot0.mapComp = nil
end

function slot0.getMapComp(slot0)
	return slot0.mapComp
end

function slot0.startMove(slot0, slot1, slot2)
	slot0.mapComp:getActorComp():moveToMapItem(nil, slot1, slot2)
end

function slot0.moveToPieceItem(slot0, slot1, slot2, slot3)
	slot0.mapComp:getActorComp():moveToPieceItem(slot1, slot2, slot3)
end

function slot0.moveToLeaveItem(slot0, slot1, slot2)
	slot0.mapComp:getActorComp():moveToLeaveItem(slot1, slot2)
end

function slot0.getActorMap(slot0)
	return slot0.mapComp and slot0.mapComp:getActorComp()
end

function slot0.openRougeFinishView(slot0)
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Finish)
end

function slot0.openRougeFailView(slot0)
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Fail)
end

function slot0.checkEventChoicePlayedUnlockAnim(slot0, slot1)
	slot0:_initPlayedChoiceList()

	return tabletool.indexOf(slot0.playedChoiceIdList, slot1)
end

function slot0.playedEventChoiceEvent(slot0, slot1)
	slot0:_initPlayedChoiceList()

	if tabletool.indexOf(slot0.playedChoiceIdList, slot1) then
		return
	end

	table.insert(slot0.playedChoiceIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId), table.concat(slot0.playedChoiceIdList, "#"))
end

function slot0._initPlayedChoiceList(slot0)
	if not slot0.playedChoiceIdList then
		slot0.playedChoiceIdList = string.splitToNumber(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId), ""), "#")
	end
end

function slot0.checkPieceChoicePlayedUnlockAnim(slot0, slot1)
	slot0:_initPlayedPieceChoiceList()

	return tabletool.indexOf(slot0.playedPieceChoiceIdList, slot1)
end

function slot0.playedPieceChoiceEvent(slot0, slot1)
	slot0:_initPlayedPieceChoiceList()

	if tabletool.indexOf(slot0.playedPieceChoiceIdList, slot1) then
		return
	end

	table.insert(slot0.playedPieceChoiceIdList, slot1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId), table.concat(slot0.playedPieceChoiceIdList, "#"))
end

function slot0._initPlayedPieceChoiceList(slot0)
	if not slot0.playedPieceChoiceIdList then
		slot0.playedPieceChoiceIdList = string.splitToNumber(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId), ""), "#")
	end
end

function slot0.clear(slot0)
	slot0.playedChoiceIdList = nil
	slot0.playedPieceChoiceIdList = nil
	slot0.mapComp = nil
end

function slot0.onExistFight(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	if RougeModel.instance:isFinish() then
		RougeMapHelper.backToMainScene()
	else
		RougeController.instance:enterRouge()
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
