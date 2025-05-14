module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeObjAlert", package.seeall)

local var_0_0 = class("PuzzleMazeObjAlert", PuzzleMazeBaseAlert)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.image = gohelper.findChildImage(arg_1_0.go, "#image_content")
	arg_1_0.imageTf = arg_1_0.image.transform
	arg_1_0.tf = arg_1_0.go.transform

	UISpriteSetMgr.instance:setPuzzleSprite(arg_1_0.image, PuzzleEnum.MazeAlertResPath, true)
end

function var_0_0.onEnable(arg_2_0, arg_2_1, arg_2_2)
	gohelper.setActive(arg_2_0.go, true)
	gohelper.setAsLastSibling(arg_2_0.go)

	local var_2_0 = string.splitToNumber(arg_2_2, "_")

	if arg_2_1 == PuzzleEnum.MazeAlertType.VisitBlock or arg_2_1 == PuzzleEnum.MazeAlertType.DisconnectLine then
		local var_2_1, var_2_2 = PuzzleMazeDrawModel.instance:getLineAnchor(var_2_0[1], var_2_0[2], var_2_0[3], var_2_0[4])

		recthelper.setAnchor(arg_2_0.tf, var_2_1 + PuzzleEnum.MazeAlertBlockOffsetX, var_2_2 + PuzzleEnum.MazeAlertBlockOffsetY)
	elseif arg_2_1 == PuzzleEnum.MazeAlertType.VisitRepeat then
		local var_2_3, var_2_4 = PuzzleMazeDrawModel.instance:getObjectAnchor(var_2_0[1], var_2_0[2])

		recthelper.setAnchor(arg_2_0.tf, var_2_3 + PuzzleEnum.MazeAlertCrossOffsetX, var_2_4 + PuzzleEnum.MazeAlertCrossOffsetY)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act176_ForbiddenGo)
end

function var_0_0.onDisable(arg_3_0)
	gohelper.setActive(arg_3_0.go, false)
end

function var_0_0.onRecycle(arg_4_0)
	return
end

function var_0_0.getKey(arg_5_0)
	return
end

return var_0_0
