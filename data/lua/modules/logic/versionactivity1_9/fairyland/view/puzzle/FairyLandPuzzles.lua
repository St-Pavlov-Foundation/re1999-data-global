module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzles", package.seeall)

local var_0_0 = class("FairyLandPuzzles", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goPuzzle = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root/#go_Puzzle")
	arg_1_0.goText = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root/#go_Text")
	arg_1_0.animText = arg_1_0.goText:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:setTextVisible(true)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.SetTextBgVisible, arg_2_0.setTextVisible, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementFinish, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.DialogFinish, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementLoadFinish, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.ResolveSuccess, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refreshView(arg_4_0)
	local var_4_0 = FairyLandModel.instance:getCurPuzzle()

	arg_4_0:changePuzzle(var_4_0)
end

function var_0_0.changePuzzle(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.puzzleId then
		return
	end

	arg_5_0.puzzleId = arg_5_1

	local var_5_0 = arg_5_0:getCompId(arg_5_1)
	local var_5_1 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(arg_5_1)

	if arg_5_0.compId == var_5_0 then
		if arg_5_0.puzzleComp then
			arg_5_0.puzzleComp:refresh(var_5_1)
		end

		return
	end

	arg_5_0.compId = var_5_0

	arg_5_0:closePuzzle()
	arg_5_0:startPuzzle(var_5_1)
end

function var_0_0.startPuzzle(arg_6_0, arg_6_1)
	if not arg_6_1 then
		if FairyLandModel.instance:isPuzzleAllStepFinish(10) then
			arg_6_0:setTextVisible(false)
		else
			arg_6_0:setTextVisible(true)
		end

		return
	end

	local var_6_0 = "FairyLandPuzzle" .. tostring(arg_6_0.compId)

	arg_6_0.puzzleComp = _G[var_6_0].New()

	local var_6_1 = {
		config = arg_6_1,
		viewGO = arg_6_0.viewGO
	}

	arg_6_0.puzzleComp:init(var_6_1)
	arg_6_0:setTextVisible(false)
end

function var_0_0.getCompId(arg_7_0, arg_7_1)
	if arg_7_1 > 3 then
		return 4
	end

	return arg_7_1
end

function var_0_0.closePuzzle(arg_8_0)
	if arg_8_0.puzzleComp then
		arg_8_0.puzzleComp:destory()

		arg_8_0.puzzleComp = nil
	end
end

function var_0_0.setTextVisible(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 and true or false

	if arg_9_0.textVisible == arg_9_1 then
		return
	end

	arg_9_0.textVisible = arg_9_1

	if arg_9_1 then
		gohelper.setActive(arg_9_0.goText, false)
		gohelper.setActive(arg_9_0.goText, true)
	else
		arg_9_0.animText:Play("close")
	end
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:closePuzzle()
end

return var_0_0
