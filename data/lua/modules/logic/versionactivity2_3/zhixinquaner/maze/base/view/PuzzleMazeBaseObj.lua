module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseObj", package.seeall)

local var_0_0 = class("PuzzleMazeBaseObj", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1
	arg_2_0.isEnter = false

	arg_2_0:_setVisible(true)
	arg_2_0:_setPosition()
	arg_2_0:_setIcon(arg_2_0.isEnter)
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0.isEnter = true

	arg_3_0:_setIcon(arg_3_0.isEnter)
end

function var_0_0.onExit(arg_4_0)
	arg_4_0.isEnter = false

	arg_4_0:_setIcon(arg_4_0.isEnter)
end

function var_0_0.onAlreadyEnter(arg_5_0)
	return
end

function var_0_0.getKey(arg_6_0)
	return
end

function var_0_0.HasEnter(arg_7_0)
	return arg_7_0.isEnter
end

function var_0_0._setPosition(arg_8_0)
	local var_8_0
	local var_8_1

	if arg_8_0.mo.positionType == PuzzleEnum.PositionType.Point then
		var_8_0, var_8_1 = PuzzleMazeDrawModel.instance:getObjectAnchor(arg_8_0.mo.x, arg_8_0.mo.y)
	else
		var_8_0, var_8_1 = PuzzleMazeDrawModel.instance:getLineObjectAnchor(arg_8_0.mo.x1, arg_8_0.mo.y1, arg_8_0.mo.x2, arg_8_0.mo.y2)
	end

	recthelper.setAnchor(arg_8_0.go.transform, var_8_0, var_8_1)
end

function var_0_0._setIcon(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_getIconUrl(arg_9_1)
	local var_9_1 = arg_9_0:_getIcon()

	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(var_9_1, var_9_0, true)
end

function var_0_0._getIcon(arg_10_0)
	return
end

function var_0_0._getIconUrl(arg_11_0, arg_11_1)
	if not arg_11_0.mo or not arg_11_0.mo.iconUrl then
		return
	end

	return arg_11_0.mo and arg_11_0.mo.iconUrl
end

function var_0_0._setVisible(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.go, arg_12_1)
end

function var_0_0.destroy(arg_13_0)
	gohelper.destroy(arg_13_0.go)

	arg_13_0.isEnter = false

	arg_13_0:__onDispose()
end

return var_0_0
