module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeCheckObj", package.seeall)

local var_0_0 = class("PuzzleMazeCheckObj", PuzzleMazeBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._image = gohelper.findChildImage(arg_1_0.go, "#image_content")
	arg_1_0._gochecked = gohelper.findChild(arg_1_0.go, "#go_checked")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.go, "#go_flag")
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	var_0_0.super.onInit(arg_2_0, arg_2_1)
	arg_2_0:setCheckIconVisible(false)
	gohelper.setActive(arg_2_0._goflag, arg_2_1.objType == PuzzleEnum.MazeObjType.End)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
	arg_3_0:setCheckIconVisible(true)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
	arg_4_0:setCheckIconVisible(false)
end

function var_0_0.setCheckIconVisible(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._gochecked, arg_5_1)
end

function var_0_0._setIcon(arg_6_0, arg_6_1)
	var_0_0.super._setIcon(arg_6_0, arg_6_1)
	ZProj.UGUIHelper.SetGrayscale(arg_6_0._image.gameObject, not arg_6_1)
end

function var_0_0._getIcon(arg_7_0)
	return arg_7_0._image
end

return var_0_0
