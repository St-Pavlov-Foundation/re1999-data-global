module("modules.logic.versionactivity2_3.act174.controller.Activity174Controller", package.seeall)

slot0 = class("Activity174Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openMainView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act174MainView, slot1)
end

function slot0.openStoreView(slot0, slot1)
	if not VersionActivityEnterHelper.checkCanOpen(slot1) then
		return
	end

	slot0.actId = slot1

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot1, slot0._openStoreViewAfterRpc, slot0)
end

function slot0._openStoreViewAfterRpc(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.Act174StoreView, {
			actId = slot0.actId
		})
	end

	slot0.actId = nil
end

function slot0.openGameView(slot0)
	ViewMgr.instance:openView(ViewName.Act174GameView)
end

function slot0.openForcePickView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act174ForcePickView, slot1)
end

function slot0.openFightReadyView(slot0)
	ViewMgr.instance:openView(ViewName.Act174FightReadyView)
end

function slot0.playFight(slot0, slot1, slot2)
	slot3 = Activity174Model.instance:getActInfo():getGameInfo()
	slot4 = slot3:getTeamMoList()
	slot5 = slot3:getFightInfo()
	slot6 = slot5.matchInfo.teamInfo
	slot7 = slot5.fightResInfo

	if not slot1 then
		slot1 = {}

		for slot11 = 1, #slot7 do
			slot1[#slot1 + 1] = slot11
		end
	end

	if #slot1 == 0 then
		slot0:openFightResultView()

		return
	end

	slot9 = DungeonConfig.instance:getChapterEpisodeCOList(tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value))
	slot10 = slot9[math.random(1, #slot9)]
	slot11 = {}

	for slot15, slot16 in ipairs(slot7) do
		table.insert(slot11, slot16.win)
	end

	FightMgr.instance:playDouQuQu(slot8, slot10.id, slot10.battleId, slot1, slot2, {
		player = slot4,
		enemy = slot6,
		win = slot11
	})
	DungeonModel.instance:SetSendChapterEpisodeId(slot8, slot10.id)
end

function slot0.openFightResultView(slot0)
	ViewMgr.instance:openView(ViewName.Act174FightResultView)
end

function slot0.openEndLessView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act174EndLessView, slot1)
end

function slot0.openSettlementView(slot0)
	ViewMgr.instance:openView(ViewName.Act174SettlementView)
end

function slot0.openItemTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act174ItemTipView, slot1)
end

function slot0.openRoleInfoView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.Act174RoleInfo, {
		roleId = slot1,
		itemId = slot2,
		pos = slot3
	})
end

function slot0.openBuffTipView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.Act174BuffTipView, {
		isEnemy = slot1,
		pos = slot2 or Vector2.New(0, 0),
		isDown = slot3
	})
end

function slot0.checkTeamDataWrong(slot0, slot1)
	slot2 = Activity174Model.instance:getActInfo(slot1):getGameInfo()

	for slot8 = 1, Activity174Config.instance:getTurnCo(slot1, slot2.gameCount).groupNum do
		if not slot2:getTeamMoList()[slot8] or not slot9:notEmpty() then
			return true
		end
	end

	return false
end

function slot0.syncLocalTeam2Server(slot0, slot1)
	Activity174Rpc.instance:sendChangeAct174TeamRequest(slot1, Activity174Model.instance:getActInfo(slot1):getGameInfo():getTeamMoList())
end

slot0.instance = slot0.New()

return slot0
