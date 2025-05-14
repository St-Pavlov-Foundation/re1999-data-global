module("modules.logic.rouge.map.controller.RougeMapController", package.seeall)

local var_0_0 = class("RougeMapController")

function var_0_0.registerMap(arg_1_0, arg_1_1)
	arg_1_0.mapComp = arg_1_1
end

function var_0_0.unregisterMap(arg_2_0)
	arg_2_0.mapComp = nil
end

function var_0_0.getMapComp(arg_3_0)
	return arg_3_0.mapComp
end

function var_0_0.startMove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.mapComp:getActorComp():moveToMapItem(nil, arg_4_1, arg_4_2)
end

function var_0_0.moveToPieceItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.mapComp:getActorComp():moveToPieceItem(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.moveToLeaveItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.mapComp:getActorComp():moveToLeaveItem(arg_6_1, arg_6_2)
end

function var_0_0.getActorMap(arg_7_0)
	return arg_7_0.mapComp and arg_7_0.mapComp:getActorComp()
end

function var_0_0.openRougeFinishView(arg_8_0)
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Finish)
end

function var_0_0.openRougeFailView(arg_9_0)
	ViewMgr.instance:openView(ViewName.RougeFinishView, RougeMapEnum.FinishEnum.Fail)
end

function var_0_0.checkEventChoicePlayedUnlockAnim(arg_10_0, arg_10_1)
	arg_10_0:_initPlayedChoiceList()

	return tabletool.indexOf(arg_10_0.playedChoiceIdList, arg_10_1)
end

function var_0_0.playedEventChoiceEvent(arg_11_0, arg_11_1)
	arg_11_0:_initPlayedChoiceList()

	if tabletool.indexOf(arg_11_0.playedChoiceIdList, arg_11_1) then
		return
	end

	table.insert(arg_11_0.playedChoiceIdList, arg_11_1)

	local var_11_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId)

	PlayerPrefsHelper.setString(var_11_0, table.concat(arg_11_0.playedChoiceIdList, "#"))
end

function var_0_0._initPlayedChoiceList(arg_12_0)
	if not arg_12_0.playedChoiceIdList then
		local var_12_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimEventId)
		local var_12_1 = PlayerPrefsHelper.getString(var_12_0, "")

		arg_12_0.playedChoiceIdList = string.splitToNumber(var_12_1, "#")
	end
end

function var_0_0.checkPieceChoicePlayedUnlockAnim(arg_13_0, arg_13_1)
	arg_13_0:_initPlayedPieceChoiceList()

	return tabletool.indexOf(arg_13_0.playedPieceChoiceIdList, arg_13_1)
end

function var_0_0.playedPieceChoiceEvent(arg_14_0, arg_14_1)
	arg_14_0:_initPlayedPieceChoiceList()

	if tabletool.indexOf(arg_14_0.playedPieceChoiceIdList, arg_14_1) then
		return
	end

	table.insert(arg_14_0.playedPieceChoiceIdList, arg_14_1)

	local var_14_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId)

	PlayerPrefsHelper.setString(var_14_0, table.concat(arg_14_0.playedPieceChoiceIdList, "#"))
end

function var_0_0._initPlayedPieceChoiceList(arg_15_0)
	if not arg_15_0.playedPieceChoiceIdList then
		local var_15_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.RougePlayedUnlockAnimPieceChoiceId)
		local var_15_1 = PlayerPrefsHelper.getString(var_15_0, "")

		arg_15_0.playedPieceChoiceIdList = string.splitToNumber(var_15_1, "#")
	end
end

function var_0_0.clear(arg_16_0)
	arg_16_0.playedChoiceIdList = nil
	arg_16_0.playedPieceChoiceIdList = nil
	arg_16_0.mapComp = nil
end

function var_0_0.onExistFight(arg_17_0)
	DungeonModel.instance.curSendEpisodeId = nil

	if RougeModel.instance:isFinish() then
		RougeMapHelper.backToMainScene()
	else
		RougeController.instance:enterRouge()
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
