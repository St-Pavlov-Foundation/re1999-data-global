module("modules.logic.versionactivity2_5.autochess.mgr.AutoChessEntityMgr", package.seeall)

local var_0_0 = class("AutoChessEntityMgr")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.scene = arg_1_1
	arg_1_0._entityDic = {}
	arg_1_0._cacheEntityDic = {}
	arg_1_0._leaderEntityDic = {}
end

function var_0_0.addEntity(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0.scene then
		return
	end

	arg_2_1 = tonumber(arg_2_1)
	arg_2_3 = tonumber(arg_2_3)

	local var_2_0 = arg_2_0._cacheEntityDic[arg_2_2.uid]

	if var_2_0 then
		var_2_0:setData(arg_2_2, arg_2_1, arg_2_3)

		arg_2_0._cacheEntityDic[arg_2_2.uid] = nil
	else
		var_2_0 = arg_2_0.scene:createEntity(arg_2_1, arg_2_2, arg_2_3)
	end

	if arg_2_0.scene.viewType == AutoChessEnum.ViewType.All then
		var_2_0:setScale(0.8)
		var_2_0:activeExpStar(false)
	end

	arg_2_0._entityDic[arg_2_2.uid] = var_2_0

	return var_2_0
end

function var_0_0.removeEntity(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._entityDic[arg_3_1]

	if var_3_0 then
		gohelper.destroy(var_3_0.go)

		arg_3_0._entityDic[arg_3_1] = nil
	end
end

function var_0_0.addLeaderEntity(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.scene then
		return
	end

	local var_4_0 = arg_4_0.scene:createLeaderEntity(arg_4_1)

	arg_4_0._leaderEntityDic[arg_4_1.uid] = var_4_0

	if arg_4_2 then
		var_4_0:showEnergy()
	end
end

function var_0_0.cacheAllEntity(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._entityDic) do
		iter_5_1:hide()

		arg_5_0._cacheEntityDic[iter_5_0] = iter_5_1
		arg_5_0._entityDic[iter_5_0] = nil
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._leaderEntityDic) do
		gohelper.destroy(iter_5_3.go)

		arg_5_0._leaderEntityDic[iter_5_2] = nil
	end
end

function var_0_0.clearEntity(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._entityDic) do
		gohelper.destroy(iter_6_1.go)

		arg_6_0._entityDic[iter_6_0] = nil
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0._cacheEntityDic) do
		gohelper.destroy(iter_6_3.go)

		arg_6_0._cacheEntityDic[iter_6_2] = nil
	end

	for iter_6_4, iter_6_5 in pairs(arg_6_0._leaderEntityDic) do
		gohelper.destroy(iter_6_5.go)

		arg_6_0._leaderEntityDic[iter_6_4] = nil
	end
end

function var_0_0.getEntity(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._entityDic[arg_7_1]

	if not var_7_0 then
		logError(string.format("异常:不存在棋子UID%s", arg_7_1))
	end

	return var_7_0
end

function var_0_0.tryGetEntity(arg_8_0, arg_8_1)
	return arg_8_0._entityDic[arg_8_1]
end

function var_0_0.getLeaderEntity(arg_9_0, arg_9_1)
	return arg_9_0._leaderEntityDic[arg_9_1]
end

function var_0_0.dispose(arg_10_0)
	arg_10_0:clearEntity()

	arg_10_0.scene = nil
end

function var_0_0.flyStarByTeam(arg_11_0, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_star_collect)

	for iter_11_0, iter_11_1 in pairs(arg_11_0._entityDic) do
		if iter_11_1.teamType == arg_11_1 and iter_11_1.config.type == AutoChessStrEnum.ChessType.Attack then
			iter_11_1:flyStar()
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
