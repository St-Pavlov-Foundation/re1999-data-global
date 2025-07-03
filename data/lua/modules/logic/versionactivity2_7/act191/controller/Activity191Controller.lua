module("modules.logic.versionactivity2_7.act191.controller.Activity191Controller", package.seeall)

local var_0_0 = class("Activity191Controller", BaseController)

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

function var_0_0.enterActivity(arg_5_0, arg_5_1)
	Activity191Rpc.instance:sendGetAct191InfoRequest(arg_5_1, arg_5_0.enterReply, arg_5_0)
end

function var_0_0.enterReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 0 then
		arg_6_0:openMainView()
	end
end

function var_0_0.openMainView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.Act191MainView, arg_7_1)
end

function var_0_0.openFetterTipView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.Act191FetterTipView, arg_8_1)
end

function var_0_0.openStoreView(arg_9_0, arg_9_1)
	if not VersionActivityEnterHelper.checkCanOpen(arg_9_1) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_9_1, arg_9_0._openStoreViewAfterRpc, arg_9_0)
end

function var_0_0.openResultPanel(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.Act191FightSuccView, arg_10_1)
end

function var_0_0.openSettlementView(arg_11_0)
	ViewMgr.instance:openView(ViewName.Act191SettlementView)
end

function var_0_0.openHeroTipView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.Act191HeroTipView, arg_12_1)
end

function var_0_0.openCollectionTipView(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.Act191CollectionTipView, arg_13_1)
end

function var_0_0.openEnhanceTipView(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.Act191EnhanceTipView, arg_14_1)
end

function var_0_0.openItemView(arg_15_0, arg_15_1)
	ViewMgr.instance:openView(ViewName.Act191ItemView, arg_15_1)
end

function var_0_0._openStoreViewAfterRpc(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == 0 then
		ViewMgr.instance:openView(ViewName.Act191StoreView)
	end
end

function var_0_0.nextStep(arg_17_0)
	local var_17_0 = Activity191Model.instance:getCurActId()
	local var_17_1 = Activity191Model.instance:getActInfo():getGameInfo()

	if var_17_1.state == Activity191Enum.GameState.None then
		Activity191Rpc.instance:sendStart191GameRequest(var_17_0, arg_17_0.startReply, arg_17_0)
	elseif var_17_1.state == Activity191Enum.GameState.Normal then
		if var_17_1.curStage == 0 and var_17_1.curNode == 0 then
			ViewMgr.instance:openView(ViewName.Act191InitBuildView)
		else
			local var_17_2 = Activity191Helper.matchKeyInArray(var_17_1.nodeInfo, var_17_1.curNode, "nodeId")

			if string.nilorempty(var_17_2.nodeStr) then
				ViewMgr.instance:openView(ViewName.Act191StageView)

				if var_17_1.nodeChange then
					ViewMgr.instance:openView(ViewName.Act191SwitchView)
				end
			else
				local var_17_3 = Act191NodeDetailMO.New()

				var_17_3:init(var_17_2.nodeStr)

				if Activity191Helper.isShopNode(var_17_3.type) then
					ViewMgr.instance:openView(ViewName.Act191ShopView, var_17_3)
				elseif var_17_3.type == Activity191Enum.NodeType.Enhance then
					ViewMgr.instance:openView(ViewName.Act191EnhancePickView, var_17_3)
				elseif var_17_3.type == Activity191Enum.NodeType.RewardEvent then
					ViewMgr.instance:openView(ViewName.Act191AdventureView, var_17_3)
				elseif var_17_3.type == Activity191Enum.NodeType.BattleEvent then
					ViewMgr.instance:openView(ViewName.Act191AdventureView, var_17_3)
				elseif Activity191Helper.isPveBattle(var_17_3.type) then
					arg_17_0:enterFightScene(var_17_3)
				elseif Activity191Helper.isPvpBattle(var_17_3.type) then
					arg_17_0:enterFightScene(var_17_3)
				end
			end
		end
	elseif var_17_1.state == Activity191Enum.GameState.End then
		Activity191Rpc.instance:sendEndAct191GameRequest(var_17_0)
	end
end

function var_0_0.startReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 0 then
		arg_18_0:nextStep()
	end
end

function var_0_0.enterFightScene(arg_19_0, arg_19_1)
	local var_19_0

	if Activity191Helper.isPveBattle(arg_19_1.type) or arg_19_1.type == Activity191Enum.NodeType.BattleEvent then
		local var_19_1 = arg_19_1.fightEventId

		var_19_0 = lua_activity191_fight_event.configDict[var_19_1].episodeId
	elseif Activity191Helper.isPvpBattle(arg_19_1.type) then
		var_19_0 = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.PvpBattleEpisodeId].value)
	end

	local var_19_2 = DungeonConfig.instance:getEpisodeCO(var_19_0)
	local var_19_3 = var_19_2.chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(var_19_3, var_19_0)
	FightController.instance:setFightParamByEpisodeAndBattle(var_19_0, var_19_2.battleId):setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.checkOpenGetView(arg_20_0)
	local var_20_0 = Activity191Model.instance:getActInfo()
	local var_20_1 = false

	for iter_20_0, iter_20_1 in ipairs(var_20_0.triggerEffectPushList) do
		if not string.nilorempty(iter_20_1.param) then
			var_20_1 = true

			break
		end
	end

	if var_20_1 then
		ViewMgr.instance:openView(ViewName.Act191GetView)

		return true
	end

	var_20_0:clearTriggerEffectPush()

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
