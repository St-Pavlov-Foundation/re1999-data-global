module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeLine", package.seeall)

local var_0_0 = class("PuzzleMazeLine", PuzzleMazeBaseLine)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._fillOrigin_left = arg_1_2
	arg_1_0._fillOrigin_right = arg_1_3
	arg_1_0._gomap = gohelper.findChild(arg_1_0.go, "#go_map")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.go, "#go_path")
	arg_1_0.image = gohelper.findChildImage(arg_1_0.go, "#go_path/image_horizon")
	arg_1_0.imageTf = arg_1_0.image.transform

	gohelper.setActive(arg_1_0._gomap, false)
	gohelper.setActive(arg_1_0._gopath, true)
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	local var_2_0, var_2_1 = PuzzleMazeDrawModel.instance:getLineAnchor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	recthelper.setAnchor(arg_2_0.go.transform, var_2_0, var_2_1)
end

function var_0_0.onAlert(arg_3_0, arg_3_1)
	return
end

function var_0_0.onCrossHalf(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.dir == nil and arg_4_1 ~= nil then
		arg_4_0:setDir(arg_4_1)
	end

	if arg_4_0.dir ~= nil then
		if arg_4_0:isReverseDir(arg_4_0.dir) then
			arg_4_2 = 1 - arg_4_2
		end

		arg_4_0:setProgress(arg_4_2)
	end
end

function var_0_0.setProgress(arg_5_0, arg_5_1)
	var_0_0.super.setProgress(arg_5_0, arg_5_1)

	arg_5_0.image.fillAmount = arg_5_0:getProgress()
end

function var_0_0.setDir(arg_6_0, arg_6_1)
	var_0_0.super.setDir(arg_6_0, arg_6_1)
	arg_6_0:refreshLineDir()
end

function var_0_0.refreshLineDir(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = PuzzleEnum.mazeUILineHorizonUIWidth

	arg_7_0.image.fillOrigin = arg_7_0._fillOrigin_left

	if arg_7_0.dir == PuzzleEnum.dir.left then
		var_7_2 = 180
	elseif arg_7_0.dir == PuzzleEnum.dir.up then
		var_7_2, var_7_3 = 90, PuzzleEnum.mazeUILineVerticalUIWidth
	elseif arg_7_0.dir == PuzzleEnum.dir.down then
		var_7_2, var_7_3 = -90, PuzzleEnum.mazeUILineVerticalUIWidth
	end

	transformhelper.setLocalRotation(arg_7_0.imageTf, var_7_0, var_7_1, var_7_2)
	recthelper.setWidth(arg_7_0.imageTf, var_7_3)
end

function var_0_0.isReverseDir(arg_8_0, arg_8_1)
	return arg_8_1 == PuzzleEnum.dir.left or arg_8_1 == PuzzleEnum.dir.down
end

return var_0_0
