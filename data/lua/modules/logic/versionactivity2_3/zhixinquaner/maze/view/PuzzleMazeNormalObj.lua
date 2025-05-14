module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeNormalObj", package.seeall)

local var_0_0 = class("PuzzleMazeNormalObj", PuzzleMazeBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._image = gohelper.findChildImage(arg_1_0.go, "#image_content")
	arg_1_0._gochecked = gohelper.findChild(arg_1_0.go, "#go_checked")

	gohelper.setActive(arg_1_0._gochecked, false)
end

function var_0_0._getIcon(arg_2_0)
	return arg_2_0._image
end

return var_0_0
