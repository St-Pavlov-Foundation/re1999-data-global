module("modules.logic.versionactivity2_7.lengzhou6.model.mo.RecordServerDataMO", package.seeall)

local var_0_0 = class("RecordServerDataMO")
local var_0_1 = {}

var_0_1.endLessBattleProgress = nil
var_0_1.round = nil
var_0_1.endLessLayer = nil
var_0_1.playerId = nil
var_0_1.playerHp = nil
var_0_1.playerSkillList = {}
var_0_1.enemyConfigId = nil
var_0_1.enemyHp = nil
var_0_1.curActionStepIndex = nil
var_0_1.skillRound = nil
var_0_1.chessData = {}

function var_0_0.ctor(arg_1_0)
	arg_1_0._data = var_0_1
end

function var_0_0.initFormJson(arg_2_0, arg_2_1)
	arg_2_0:_fromJson(arg_2_1)
end

function var_0_0.toJson(arg_3_0)
	return cjson.encode(arg_3_0._data)
end

function var_0_0._fromJson(arg_4_0, arg_4_1)
	arg_4_0._data = cjson.decode(arg_4_1)
end

function var_0_0.getRecordData(arg_5_0)
	return arg_5_0:toJson()
end

function var_0_0.record(arg_6_0, arg_6_1)
	tabletool.clear(arg_6_0._data)

	if arg_6_0._data ~= nil then
		arg_6_0._data.chessData = arg_6_1

		local var_6_0 = LengZhou6GameModel.instance:getEndLessBattleProgress()

		arg_6_0._data.endLessBattleProgress = var_6_0
		arg_6_0._data.round = LengZhou6GameModel.instance:getCurRound()
		arg_6_0._data.endLessLayer = LengZhou6GameModel.instance:getEndLessModelLayer()

		local var_6_1 = LengZhou6GameModel.instance:getPlayer()

		arg_6_0._data.playerId = var_6_1:getConfigId()

		local var_6_2 = LengZhou6GameModel.instance:getEnemy()

		arg_6_0._data.enemyConfigId = var_6_2:getConfigId()
		arg_6_0._data.curActionStepIndex = var_6_2:getAction() and var_6_2:getAction():getCurBehaviorId()
		arg_6_0._data.skillRound = var_6_2:getAction() and var_6_2:getAction():getCurRound()

		local var_6_3 = var_6_1:getActiveSkills()
		local var_6_4 = {}

		for iter_6_0 = 1, #var_6_3 do
			local var_6_5 = var_6_3[iter_6_0]

			table.insert(var_6_4, var_6_5:getConfig().id)
		end

		arg_6_0._data.playerSkillList = var_6_4
		arg_6_0._data.playerHp = var_6_1:getHp()
		arg_6_0._data.enemyHp = var_6_2:getHp()
	end
end

function var_0_0.getData(arg_7_0)
	return arg_7_0._data
end

return var_0_0
