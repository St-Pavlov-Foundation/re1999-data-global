module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeMapLine", package.seeall)

local var_0_0 = class("PuzzleMazeMapLine", PuzzleMazeBaseLine)

var_0_0.SwitchOffIconUrl = "duandian_1"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._fillOrigin_left = arg_1_2
	arg_1_0._fillOrigin_right = arg_1_3
	arg_1_0._width, arg_1_0._height = PuzzleMazeDrawModel.instance:getUIGridSize()
	arg_1_0._gomap = gohelper.findChild(arg_1_0.go, "#go_map")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.go, "#go_path")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.go, "#go_map/#go_switch")
	arg_1_0._imageindex = gohelper.findChildImage(arg_1_0.go, "#go_map/#go_switch/#image_index")
	arg_1_0._imagecontent = gohelper.findChildImage(arg_1_0.go, "#go_map/#go_switch/#image_content")
	arg_1_0._switchAnim = gohelper.findChildComponent(arg_1_0.go, "#go_map/#go_switch", gohelper.Type_Animator)

	gohelper.setActive(arg_1_0._gomap, true)
	gohelper.setActive(arg_1_0._gopath, false)
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_0.super.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.SwitchLineState, arg_2_0.onSwitchLine, arg_2_0)

	local var_2_0, var_2_1 = PuzzleMazeDrawModel.instance:getLineAnchor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	recthelper.setAnchor(arg_2_0.go.transform, var_2_0, var_2_1)
	arg_2_0:_setIcon()
end

function var_0_0._setIcon(arg_3_0)
	local var_3_0 = PuzzleMazeDrawModel.instance:getMapLineState(arg_3_0.x1, arg_3_0.y1, arg_3_0.x2, arg_3_0.y2)
	local var_3_1 = var_3_0 == PuzzleEnum.LineState.Switch_Off
	local var_3_2 = var_3_0 == PuzzleEnum.LineState.Switch_On

	if var_3_1 then
		local var_3_3 = PuzzleMazeDrawModel.instance:getInteractLineCtrl(arg_3_0.x1, arg_3_0.y1, arg_3_0.x2, arg_3_0.y2)
		local var_3_4 = var_3_3 and var_3_3.group
		local var_3_5 = var_3_4 and PuzzleEnum.InteractIndexIcon[var_3_4]

		if var_3_5 then
			UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(arg_3_0._imageindex, var_3_5)
		end

		UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(arg_3_0._imagecontent, var_0_0.SwitchOffIconUrl)
	end

	if var_3_1 or var_3_2 then
		gohelper.setActive(arg_3_0._goswitch, true)

		local var_3_6 = var_3_1 and "none" or "disappear"

		arg_3_0._switchAnim:Play(var_3_6, 0, 0)
	else
		gohelper.setActive(arg_3_0._goswitch, false)
	end
end

function var_0_0.onSwitchLine(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 ~= arg_4_0.x1 or arg_4_2 ~= arg_4_0.y1 or arg_4_0.x2 ~= arg_4_3 or arg_4_0.y2 ~= arg_4_4 then
		return
	end

	arg_4_0:_setIcon()
end

return var_0_0
