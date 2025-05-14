module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSwitchObj", package.seeall)

local var_0_0 = class("PuzzleMazeSwitchObj", PuzzleMazeBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._image = gohelper.findChildImage(arg_1_0.go, "#image_content")
	arg_1_0._imageindex = gohelper.findChildImage(arg_1_0.go, "#image_index")
	arg_1_0._gointeractEffect = gohelper.findChild(arg_1_0.go, "vx_tips")
	arg_1_0._goarriveEffect = gohelper.findChild(arg_1_0.go, "vx_smoke")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_switch")

	arg_1_0._btnswitch:AddClickListener(arg_1_0._btnswitchOnClick, arg_1_0)

	arg_1_0._isSwitched = false

	arg_1_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnBeginDragPawn, arg_1_0._onBeginDragPawn, arg_1_0)
	arg_1_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnEndDragPawn, arg_1_0._onEndDragPawn, arg_1_0)
	arg_1_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, arg_1_0._initGameDone, arg_1_0)
	arg_1_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnSimulatePlaneDone, arg_1_0._onSimulatePlaneDone, arg_1_0)
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	var_0_0.super.onInit(arg_2_0, arg_2_1)

	arg_2_0._isSwitched = false

	gohelper.setActive(arg_2_0._btnswitch.gameObject, false)
	arg_2_0:_setInteractIndex()
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
	arg_3_0:_tryRecyclePlane()
end

function var_0_0._setIcon(arg_4_0, arg_4_1)
	var_0_0.super._setIcon(arg_4_0, arg_4_0._isSwitched)
	ZProj.UGUIHelper.SetGrayscale(arg_4_0._image.gameObject, not arg_4_0._isSwitched)
	gohelper.setActive(arg_4_0._goarriveEffect, arg_4_0._isSwitched)
end

function var_0_0._getIcon(arg_5_0)
	return arg_5_0._image
end

function var_0_0._onBeginDragPawn(arg_6_0)
	gohelper.setActive(arg_6_0._btnswitch.gameObject, false)
end

function var_0_0._onEndDragPawn(arg_7_0)
	arg_7_0:_checkIfSwitchBtnVisible()
end

function var_0_0._initGameDone(arg_8_0)
	arg_8_0:_checkIfSwitchBtnVisible()
end

function var_0_0._setInteractIndex(arg_9_0)
	local var_9_0 = arg_9_0.mo and arg_9_0.mo.group
	local var_9_1 = var_9_0 and PuzzleEnum.InteractIndexIcon[var_9_0]

	if var_9_1 then
		UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(arg_9_0._imageindex, var_9_1)
	end
end

function var_0_0._checkIfSwitchBtnVisible(arg_10_0)
	if PuzzleMazeDrawController.instance:hasAlertObj() then
		return
	end

	local var_10_0 = arg_10_0:_isPawnAround()
	local var_10_1 = PuzzleMazeDrawModel.instance:isCanFlyPlane()
	local var_10_2 = var_10_0 and var_10_1

	gohelper.setActive(arg_10_0._btnswitch.gameObject, var_10_2)
	gohelper.setActive(arg_10_0._gointeractEffect, var_10_2)
end

function var_0_0._isPawnAround(arg_11_0)
	if not arg_11_0.mo or not arg_11_0.mo.x or not arg_11_0.mo.y then
		return
	end

	local var_11_0, var_11_1 = PuzzleMazeDrawController.instance:getLastPos()

	if not var_11_0 or not var_11_1 then
		return
	end

	return math.abs(arg_11_0.mo.x - var_11_0) + math.abs(arg_11_0.mo.y - var_11_1) == 1
end

function var_0_0._btnswitchOnClick(arg_12_0)
	arg_12_0._isSwitched = true

	gohelper.setActive(arg_12_0._btnswitch.gameObject, false)
	gohelper.setActive(arg_12_0._gointeractEffect, false)
	PuzzleMazeDrawController.instance:interactSwitchObj(arg_12_0.mo.x, arg_12_0.mo.y)
end

function var_0_0._tryRecyclePlane(arg_13_0)
	if PuzzleMazeDrawController.instance:hasAlertObj() or not arg_13_0._isSwitched then
		return
	end

	local var_13_0, var_13_1 = PuzzleMazeDrawModel.instance:getCurPlanePos()

	if arg_13_0.mo and arg_13_0.mo.x == var_13_0 and arg_13_0.mo.y == var_13_1 then
		arg_13_0._isSwitched = false

		arg_13_0:_setIcon()
		PuzzleMazeDrawController.instance:recyclePlane()
		AudioMgr.instance:trigger(AudioEnum.UI.Act176_RecyclePlane)
	end
end

function var_0_0._onSimulatePlaneDone(arg_14_0)
	arg_14_0:_setIcon()
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_SwitchOn)
end

function var_0_0.destroy(arg_15_0)
	arg_15_0._btnswitch:RemoveClickListener()
	var_0_0.super.destroy(arg_15_0)
end

return var_0_0
