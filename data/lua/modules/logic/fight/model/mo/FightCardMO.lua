module("modules.logic.fight.model.mo.FightCardMO", package.seeall)

local var_0_0 = pureTable("FightCardMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.cardGroup = {}
	arg_1_0.actPoint = 0
	arg_1_0.moveNum = 0
	arg_1_0.dealCardGroup = {}
	arg_1_0.beforeCards = {}
	arg_1_0.extraMoveAct = 0
	arg_1_0.playCanAddExpoint = nil
	arg_1_0.combineCanAddExpoint = nil
	arg_1_0.moveCanAddExpoint = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.cardGroup = arg_2_0:_buildCards(arg_2_1.cardGroup)
	arg_2_0.actPoint = arg_2_1.actPoint
	arg_2_0.moveNum = arg_2_1.moveNum
	arg_2_0.dealCardGroup = arg_2_0:_buildCards(arg_2_1.dealCardGroup)
	arg_2_0.beforeCards = arg_2_0:_buildCards(arg_2_1.beforeCards)
	arg_2_0.extraMoveAct = arg_2_1.extraMoveAct
end

function var_0_0.setExtraMoveAct(arg_3_0, arg_3_1)
	arg_3_0.extraMoveAct = arg_3_1
end

function var_0_0.setCards(arg_4_0, arg_4_1)
	arg_4_0.cardGroup = arg_4_1
end

function var_0_0.reset(arg_5_0)
	arg_5_0.cardGroup = {}
	arg_5_0.actPoint = 0
	arg_5_0.moveNum = 0
end

function var_0_0._buildCards(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_1 = FightCardInfoMO.New()

		var_6_1:init(iter_6_1)
		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0.isUnlimitMoveCard(arg_7_0)
	return arg_7_0.extraMoveAct == -1
end

return var_0_0
