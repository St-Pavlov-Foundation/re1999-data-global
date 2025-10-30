module("modules.logic.gm.view.eliminate.GMSubViewEliminate", package.seeall)

local var_0_0 = class("GMSubViewEliminate", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "三消"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)

	arg_4_0.lineIndex = 1

	arg_4_0:addTitleSplitLine("冷周六玩法")
	arg_4_0:addLineIndex()

	arg_4_0._textLevel = arg_4_0:addInputText(arg_4_0:getLineGroup(), "1270209")

	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "进入玩法", arg_4_0.enterGame, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "打乱棋盘", arg_4_0.randomCell, arg_4_0)
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "随机石化", arg_4_0.petrifyEliminationBlock, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "随机冰冻", arg_4_0.freezeEliminationBlock, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "随机致盲", arg_4_0.contaminate, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._textBuff = arg_4_0:addInputText(arg_4_0:getLineGroup(), "1,1")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "指定冰冻", arg_4_0.addBuff, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._textChangeIndex = arg_4_0:addInputText(arg_4_0:getLineGroup(), "1,1")
	arg_4_0._typeDropDown = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "棋子类型：", EliminateEnum_2_7.AllChessType, arg_4_0._onLangDropChange, arg_4_0)

	arg_4_0:addButton(arg_4_0:getLineGroup(), "修改棋子类型", arg_4_0.changeChessType, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._textChangeStrongIndex = arg_4_0:addInputText(arg_4_0:getLineGroup(), "1,1")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "强化棋子", arg_4_0.changeToStrong, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._textChangeDieSpeed = arg_4_0:addInputText(arg_4_0:getLineGroup(), "0.3")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "修改棋子死亡步骤时间", arg_4_0.changeDieSpeed, arg_4_0)
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "测试随机棋子【100】", arg_4_0.testRound, arg_4_0)
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "完成玛丽安娜玩法", arg_4_0.finishMaLiAnNa, arg_4_0)
end

function var_0_0.initEliminate(arg_5_0)
	local var_5_0 = {
		{
			1,
			3,
			2,
			5,
			4,
			1
		},
		{
			2,
			4,
			5,
			3,
			1,
			2
		},
		{
			3,
			1,
			4,
			2,
			5,
			3
		},
		{
			4,
			2,
			5,
			1,
			3,
			4
		},
		{
			5,
			3,
			1,
			4,
			2,
			5
		},
		{
			1,
			4,
			2,
			5,
			3,
			1
		}
	}

	LocalEliminateChessModel.instance:initByData(var_5_0)
end

function var_0_0.eliminateEx(arg_6_0)
	local var_6_0 = arg_6_0._textEx:GetText()
	local var_6_1 = string.split(var_6_0, ",")

	if #var_6_1 ~= 4 then
		return
	end

	local var_6_2 = tonumber(var_6_1[1])
	local var_6_3 = tonumber(var_6_1[2])
	local var_6_4 = tonumber(var_6_1[3])
	local var_6_5 = tonumber(var_6_1[4])

	LocalEliminateChessModel.instance:exchangeCell(var_6_2, var_6_3, var_6_4, var_6_5)
end

function var_0_0.addBuff(arg_7_0)
	local var_7_0 = arg_7_0._textBuff:GetText()
	local var_7_1 = string.split(var_7_0, ",")

	if #var_7_1 ~= 2 then
		return
	end

	local var_7_2 = tonumber(var_7_1[1])
	local var_7_3 = tonumber(var_7_1[2])

	LocalEliminateChessModel.instance:changeCellState(var_7_2, var_7_3, EliminateEnum.ChessState.Frost)

	local var_7_4 = {
		x = var_7_2,
		y = var_7_3
	}
	local var_7_5 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, var_7_4)

	LengZhou6EliminateController.instance:buildSeqFlow(var_7_5)

	local var_7_6 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(var_7_6)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function var_0_0.enterGame(arg_8_0)
	LengZhou6Enum.enterGM = true
	LengZhou6Model.instance._activityId = 12702

	local var_8_0 = tonumber(arg_8_0._textLevel:GetText())

	LengZhou6Model.instance:setCurEpisodeId(var_8_0)
	LengZhou6Controller.instance:_enterGame(var_8_0)
end

function var_0_0.randomCell(arg_9_0)
	local var_9_0 = LocalEliminateChessModel.instance:randomCell()

	LengZhou6EliminateController.instance:updateAllItemPos(var_9_0)
end

function var_0_0.eliminateCross(arg_10_0)
	LocalEliminateChessModel.instance:eliminateCross(4, 4)

	local var_10_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(var_10_0)
end

function var_0_0.eliminateRange(arg_11_0)
	LocalEliminateChessModel.instance:eliminateRange(3, 4, 3)

	local var_11_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(var_11_0)
end

function var_0_0.petrifyEliminationBlock(arg_12_0)
	LengZhou6EffectUtils.instance._petrifyEliminationBlock({
		"PetrifyEliminationBlock",
		2
	})

	local var_12_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(var_12_0)
end

function var_0_0.freezeEliminationBlock(arg_13_0)
	LengZhou6EffectUtils.instance._freezeEliminationBlock({
		"FreezeEliminationBlock",
		2
	})

	local var_13_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(var_13_0)
end

function var_0_0.contaminate(arg_14_0)
	LengZhou6EffectUtils.instance._contaminate({
		"Contaminate",
		2
	})

	local var_14_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(var_14_0)
end

function var_0_0.generateUnsolvableBoard(arg_15_0)
	LocalEliminateChessUtils.instance.generateUnsolvableBoard(6, 6)
end

function var_0_0.testRound(arg_16_0)
	LocalEliminateChessModel.instance:testRound()
end

function var_0_0._onLangDropChange(arg_17_0)
	return
end

function var_0_0.changeChessType(arg_18_0)
	local var_18_0 = arg_18_0._textChangeIndex:GetText()
	local var_18_1 = string.split(var_18_0, ",")

	if #var_18_1 ~= 2 then
		return
	end

	local var_18_2 = tonumber(var_18_1[1])
	local var_18_3 = tonumber(var_18_1[2])
	local var_18_4 = arg_18_0._typeDropDown:GetValue()
	local var_18_5 = EliminateEnum_2_7.AllChessType[var_18_4 + 1]

	LengZhou6EliminateController.instance:changeCellType(var_18_2, var_18_3, var_18_5)
end

function var_0_0.changeToStrong(arg_19_0)
	local var_19_0 = arg_19_0._textChangeStrongIndex:GetText()
	local var_19_1 = string.split(var_19_0, ",")

	if #var_19_1 ~= 2 then
		return
	end

	local var_19_2 = tonumber(var_19_1[1])
	local var_19_3 = tonumber(var_19_1[2])

	LengZhou6EliminateController.instance:changeCellState(var_19_2, var_19_3, EliminateEnum.ChessState.SpecialSkill)
end

function var_0_0.changeDieSpeed(arg_20_0)
	local var_20_0 = arg_20_0._textChangeDieSpeed:GetText()
	local var_20_1 = tonumber(var_20_0)

	EliminateEnum_2_7.DieStepTime = var_20_1
end

function var_0_0.beginMaLiAnNa(arg_21_0)
	local var_21_0 = arg_21_0._txtMaliAnNa:GetText()

	Activity201MaLiAnNaGameController.instance:enterGame(tonumber(var_21_0))
end

function var_0_0.stopMaLiAnNa(arg_22_0)
	Activity201MaLiAnNaGameController.instance:exitGame()
end

function var_0_0.finishMaLiAnNa(arg_23_0)
	Activity201MaLiAnNaGameController.instance:finishGame()
end

return var_0_0
