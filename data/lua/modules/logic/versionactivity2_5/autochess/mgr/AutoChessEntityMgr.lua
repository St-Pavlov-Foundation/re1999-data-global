module("modules.logic.versionactivity2_5.autochess.mgr.AutoChessEntityMgr", package.seeall)

slot0 = class("AutoChessEntityMgr")

function slot0.init(slot0, slot1)
	slot0.scene = slot1
	slot0._entityDic = {}
	slot0._cacheEntityDic = {}
	slot0._leaderEntityDic = {}
end

function slot0.addEntity(slot0, slot1, slot2, slot3)
	if not slot0.scene then
		return
	end

	if slot0._cacheEntityDic[slot2.uid] then
		slot4:setData(slot2, tonumber(slot1), tonumber(slot3))

		slot0._cacheEntityDic[slot2.uid] = nil
	else
		slot4 = slot0.scene:createEntity(slot1, slot2, slot3)
	end

	if slot0.scene.viewType == AutoChessEnum.ViewType.All then
		slot4:setScale(0.8)
		slot4:activeExpStar(false)
	end

	slot0._entityDic[slot2.uid] = slot4

	return slot4
end

function slot0.removeEntity(slot0, slot1)
	if slot0._entityDic[slot1] then
		gohelper.destroy(slot2.go)

		slot0._entityDic[slot1] = nil
	end
end

function slot0.addLeaderEntity(slot0, slot1, slot2)
	if not slot0.scene then
		return
	end

	slot0._leaderEntityDic[slot1.uid] = slot0.scene:createLeaderEntity(slot1)

	if slot2 then
		slot3:showEnergy()
	end
end

function slot0.cacheAllEntity(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		slot5:hide()

		slot0._cacheEntityDic[slot4] = slot5
		slot0._entityDic[slot4] = nil
	end

	for slot4, slot5 in pairs(slot0._leaderEntityDic) do
		gohelper.destroy(slot5.go)

		slot0._leaderEntityDic[slot4] = nil
	end
end

function slot0.clearEntity(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		gohelper.destroy(slot5.go)

		slot0._entityDic[slot4] = nil
	end

	for slot4, slot5 in pairs(slot0._cacheEntityDic) do
		gohelper.destroy(slot5.go)

		slot0._cacheEntityDic[slot4] = nil
	end

	for slot4, slot5 in pairs(slot0._leaderEntityDic) do
		gohelper.destroy(slot5.go)

		slot0._leaderEntityDic[slot4] = nil
	end
end

function slot0.getEntity(slot0, slot1)
	if not slot0._entityDic[slot1] then
		logError(string.format("异常:不存在棋子UID%s", slot1))
	end

	return slot2
end

function slot0.tryGetEntity(slot0, slot1)
	return slot0._entityDic[slot1]
end

function slot0.getLeaderEntity(slot0, slot1)
	return slot0._leaderEntityDic[slot1]
end

function slot0.dispose(slot0)
	slot0:clearEntity()

	slot0.scene = nil
end

function slot0.flyStarByTeam(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_star_collect)

	for slot5, slot6 in pairs(slot0._entityDic) do
		if slot6.teamType == slot1 and slot6.config.type == AutoChessStrEnum.ChessType.Attack then
			slot6:flyStar()
		end
	end
end

slot0.instance = slot0.New()

return slot0
