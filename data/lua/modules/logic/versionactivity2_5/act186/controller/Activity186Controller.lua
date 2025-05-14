module("modules.logic.versionactivity2_5.act186.controller.Activity186Controller", package.seeall)

local var_0_0 = class("Activity186Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.setPlayerPrefs(arg_4_0, arg_4_1, arg_4_2)
	if string.nilorempty(arg_4_1) or not arg_4_2 then
		return
	end

	if type(arg_4_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_4_1, arg_4_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_4_1, arg_4_2)
	end

	arg_4_0:dispatchEvent(Activity186Event.LocalKeyChange)
end

function var_0_0.getPlayerPrefs(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2 or ""

	if string.nilorempty(arg_5_1) then
		return var_5_0
	end

	if type(var_5_0) == "number" then
		var_5_0 = GameUtil.playerPrefsGetNumberByUserId(arg_5_1, var_5_0)
	else
		var_5_0 = GameUtil.playerPrefsGetStringByUserId(arg_5_1, var_5_0)
	end

	return var_5_0
end

function var_0_0.checkEnterGame(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = Activity186Model.instance:getById(arg_6_1)

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0:getOnlineGameList()

	if not var_6_1 or #var_6_1 == 0 then
		return
	end

	local var_6_2 = var_6_1[1]

	if not arg_6_2 then
		var_6_2 = nil

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			if Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, arg_6_1, iter_6_1.gameId, 0) == 0 then
				var_6_2 = iter_6_1

				break
			end
		end
	end

	if var_6_2 then
		Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.GameMark, arg_6_1, var_6_2.gameId, 1)
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = arg_6_1,
			gameId = var_6_2.gameId,
			gameStatus = Activity186Enum.GameStatus.Start,
			gameType = var_6_2.gameTypeId
		})
	end
end

function var_0_0.enterGame(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	local var_7_0 = Activity186Model.instance:getById(arg_7_1)

	if not var_7_0 then
		return
	end

	if not var_7_0:isGameOnline(arg_7_2) then
		return
	end

	local var_7_1 = var_7_0:getGameInfo(arg_7_2)

	if not var_7_1 then
		return
	end

	if var_7_1.gameTypeId == 1 then
		ViewMgr.instance:openView(ViewName.Activity186GameInviteView, {
			activityId = arg_7_1,
			gameId = arg_7_2,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	else
		ViewMgr.instance:openView(ViewName.Activity186GameDrawlotsView, {
			activityId = arg_7_1,
			gameId = arg_7_2,
			gameStatus = Activity186Enum.GameStatus.Playing
		})
	end
end

function var_0_0.openTaskView(arg_8_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, arg_8_0._onOpenTaskView, arg_8_0)
end

function var_0_0._onOpenTaskView(arg_9_0)
	local var_9_0 = Activity186Model.instance:getActId()

	ViewMgr.instance:openView(ViewName.Activity186TaskView, {
		actId = var_9_0
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
