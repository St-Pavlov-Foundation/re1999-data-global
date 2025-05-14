module("modules.logic.versionactivity2_3.act174.controller.Activity174Controller", package.seeall)

local var_0_0 = class("Activity174Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openMainView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.Act174MainView, arg_5_1)
end

function var_0_0.openStoreView(arg_6_0, arg_6_1)
	if not VersionActivityEnterHelper.checkCanOpen(arg_6_1) then
		return
	end

	arg_6_0.actId = arg_6_1

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_6_1, arg_6_0._openStoreViewAfterRpc, arg_6_0)
end

function var_0_0._openStoreViewAfterRpc(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == 0 then
		ViewMgr.instance:openView(ViewName.Act174StoreView, {
			actId = arg_7_0.actId
		})
	end

	arg_7_0.actId = nil
end

function var_0_0.openGameView(arg_8_0)
	ViewMgr.instance:openView(ViewName.Act174GameView)
end

function var_0_0.openForcePickView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.Act174ForcePickView, arg_9_1)
end

function var_0_0.openFightReadyView(arg_10_0)
	ViewMgr.instance:openView(ViewName.Act174FightReadyView)
end

function var_0_0.playFight(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Activity174Model.instance:getActInfo():getGameInfo()
	local var_11_1 = var_11_0:getTeamMoList()
	local var_11_2 = var_11_0:getFightInfo()
	local var_11_3 = var_11_2.matchInfo.teamInfo
	local var_11_4 = var_11_2.fightResInfo

	if not arg_11_1 then
		arg_11_1 = {}

		for iter_11_0 = 1, #var_11_4 do
			arg_11_1[#arg_11_1 + 1] = iter_11_0
		end
	end

	if #arg_11_1 == 0 then
		arg_11_0:openFightResultView()

		return
	end

	local var_11_5 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	local var_11_6 = DungeonConfig.instance:getChapterEpisodeCOList(var_11_5)
	local var_11_7 = var_11_6[math.random(1, #var_11_6)]
	local var_11_8 = {}

	for iter_11_1, iter_11_2 in ipairs(var_11_4) do
		table.insert(var_11_8, iter_11_2.win)
	end

	local var_11_9 = {
		player = var_11_1,
		enemy = var_11_3,
		win = var_11_8
	}

	FightMgr.instance:playDouQuQu(var_11_5, var_11_7.id, var_11_7.battleId, arg_11_1, arg_11_2, var_11_9)
	DungeonModel.instance:SetSendChapterEpisodeId(var_11_5, var_11_7.id)
end

function var_0_0.openFightResultView(arg_12_0)
	ViewMgr.instance:openView(ViewName.Act174FightResultView)
end

function var_0_0.openEndLessView(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.Act174EndLessView, arg_13_1)
end

function var_0_0.openSettlementView(arg_14_0)
	ViewMgr.instance:openView(ViewName.Act174SettlementView)
end

function var_0_0.openItemTipView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.Act174ItemTipView, arg_15_1)
end

function var_0_0.openRoleInfoView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	ViewMgr.instance:openView(ViewName.Act174RoleInfo, {
		roleId = arg_16_1,
		itemId = arg_16_2,
		pos = arg_16_3
	})
end

function var_0_0.openBuffTipView(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_2 = arg_17_2 or Vector2.New(0, 0)

	ViewMgr.instance:openView(ViewName.Act174BuffTipView, {
		isEnemy = arg_17_1,
		pos = arg_17_2,
		isDown = arg_17_3
	})
end

function var_0_0.checkTeamDataWrong(arg_18_0, arg_18_1)
	local var_18_0 = Activity174Model.instance:getActInfo(arg_18_1):getGameInfo()
	local var_18_1 = var_18_0:getTeamMoList()
	local var_18_2 = Activity174Config.instance:getTurnCo(arg_18_1, var_18_0.gameCount)

	for iter_18_0 = 1, var_18_2.groupNum do
		local var_18_3 = var_18_1[iter_18_0]

		if not var_18_3 or not var_18_3:notEmpty() then
			return true
		end
	end

	return false
end

function var_0_0.syncLocalTeam2Server(arg_19_0, arg_19_1)
	local var_19_0 = Activity174Model.instance:getActInfo(arg_19_1):getGameInfo():getTeamMoList()

	Activity174Rpc.instance:sendChangeAct174TeamRequest(arg_19_1, var_19_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
