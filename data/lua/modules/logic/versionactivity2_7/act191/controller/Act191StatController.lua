module("modules.logic.versionactivity2_7.act191.controller.Act191StatController", package.seeall)

local var_0_0 = class("Act191StatController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.viewOpenTimeMap = {}
	arg_2_0.startTime = nil
	arg_2_0.actId = VersionActivity2_7Enum.ActivityId.Act191
end

function var_0_0.setActInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.actId = arg_3_1
	arg_3_0.actInfo = arg_3_2
end

function var_0_0.onViewOpen(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.Act191MainView then
		arg_4_0.startTime = ServerTime.now()
	end

	if not arg_4_0.viewOpenTimeMap[arg_4_1] then
		arg_4_0.viewOpenTimeMap[arg_4_1] = ServerTime.now()
	end
end

function var_0_0.statViewClose(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == ViewName.Act191MainView then
		arg_5_0:statGameTime(arg_5_1)

		if arg_5_2 then
			arg_5_0.startTime = nil
		else
			arg_5_0.startTime = ServerTime.now()
		end
	end

	if not arg_5_0.viewOpenTimeMap[arg_5_1] then
		return
	end

	arg_5_3 = arg_5_3 or ""

	local var_5_0 = ServerTime.now() - arg_5_0.viewOpenTimeMap[arg_5_1]
	local var_5_1 = {}
	local var_5_2 = {}

	if arg_5_0.actInfo then
		local var_5_3 = arg_5_0.actInfo:getGameInfo()

		var_5_1 = {
			coin = var_5_3.coin,
			stage = var_5_3.curStage,
			node = var_5_3.curNode,
			score = var_5_3.score,
			rank = var_5_3.rank
		}

		local var_5_4 = var_5_3:getNodeDetailMo(nil, true)

		if var_5_4 then
			var_5_2 = {
				shopId = var_5_4.shopId,
				eventId = var_5_4.eventId,
				type = var_5_4.type
			}
		end
	end

	local var_5_5 = Activity191Helper.getPlayerPrefs(arg_5_0.actId, "Act191GameCostTime", 1)

	StatController.instance:track(StatEnum.EventName.Act191CloseView, {
		[StatEnum.EventProperties.Act191GameUid] = tostring(var_5_5),
		[StatEnum.EventProperties.Act191BaseInfo] = var_5_1,
		[StatEnum.EventProperties.Act191NodeInfo] = var_5_2,
		[StatEnum.EventProperties.ViewName] = arg_5_1,
		[StatEnum.EventProperties.UseTime] = var_5_0,
		[StatEnum.EventProperties.CooperGarland_From] = arg_5_2 and "Manual" or "Auto",
		[StatEnum.EventProperties.ProductName] = arg_5_3
	})

	arg_5_0.viewOpenTimeMap[arg_5_1] = nil
end

function var_0_0.statButtonClick(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.actInfo:getGameInfo()
	local var_6_1 = {
		coin = var_6_0.coin,
		stage = var_6_0.curStage,
		node = var_6_0.curNode,
		score = var_6_0.score,
		rank = var_6_0.rank
	}
	local var_6_2 = var_6_0:getNodeDetailMo(nil, true)
	local var_6_3 = {}

	if var_6_2 then
		var_6_3 = {
			shopId = var_6_2.shopId,
			eventId = var_6_2.eventId,
			type = var_6_2.type
		}
	end

	local var_6_4 = Activity191Helper.getPlayerPrefs(arg_6_0.actId, "Act191GameCostTime", 1)

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.Act191GameUid] = tostring(var_6_4),
		[StatEnum.EventProperties.Act191BaseInfo] = var_6_1,
		[StatEnum.EventProperties.Act191NodeInfo] = var_6_3,
		[StatEnum.EventProperties.ViewName] = arg_6_1,
		[StatEnum.EventProperties.ButtonName] = arg_6_2
	})
end

function var_0_0.statGameTime(arg_7_0, arg_7_1)
	local var_7_0

	if arg_7_0.startTime then
		var_7_0 = ServerTime.now() - arg_7_0.startTime
	else
		var_7_0 = ServerTime.now() - FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].createTime
	end

	local var_7_1 = {}
	local var_7_2 = {}

	if arg_7_0.actInfo then
		local var_7_3 = arg_7_0.actInfo:getGameInfo()

		if var_7_3.state == Activity191Enum.GameState.Normal then
			var_7_1 = {
				coin = var_7_3.coin,
				stage = var_7_3.curStage,
				node = var_7_3.curNode,
				score = var_7_3.score,
				rank = var_7_3.rank
			}

			local var_7_4 = var_7_3:getNodeDetailMo(nil, true)

			if var_7_4 then
				var_7_2 = {
					shopId = var_7_4.shopId,
					eventId = var_7_4.eventId,
					type = var_7_4.type
				}
			end
		end
	end

	local var_7_5 = Activity191Helper.getPlayerPrefs(arg_7_0.actId, "Act191GameCostTime", 1)

	StatController.instance:track(StatEnum.EventName.Act191GameTime, {
		[StatEnum.EventProperties.Act191BaseInfo] = var_7_1,
		[StatEnum.EventProperties.Act191NodeInfo] = var_7_2,
		[StatEnum.EventProperties.ViewName] = arg_7_1,
		[StatEnum.EventProperties.UseTime] = var_7_0,
		[StatEnum.EventProperties.Act191GameUid] = tostring(var_7_5)
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
