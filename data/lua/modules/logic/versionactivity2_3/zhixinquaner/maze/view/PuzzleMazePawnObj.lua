module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazePawnObj", package.seeall)

local var_0_0 = class("PuzzleMazePawnObj", PuzzleMazeBasePawnObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.image = gohelper.findChildImage(arg_1_0.go, "#go_ctrl/#image_content")
	arg_1_0.imageTf = arg_1_0.image.transform
	arg_1_0.goCtrl = gohelper.findChild(arg_1_0.go, "#go_ctrl")
	arg_1_0.tf = arg_1_0.go.transform
	arg_1_0.dir = PuzzleEnum.dir.left
	arg_1_0.anim = arg_1_0.image.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animEvent = arg_1_0.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_1_0.animEvent:AddEventListener(PuzzleEnum.AnimEvent_OnJump, arg_1_0.onPawnJump, arg_1_0)
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.anim:Play("open")

	local var_2_0 = PuzzleMazeDrawModel.instance:pawnIconUrl()

	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(arg_2_0.image, var_2_0, true)
	recthelper.setAnchor(arg_2_0.goCtrl.transform, PuzzleEnum.MazeMonsterIconOffset.x, PuzzleEnum.MazeMonsterIconOffset.y)
	arg_2_0:setPos(arg_2_1, arg_2_2)
	gohelper.setAsLastSibling(arg_2_0.go)
end

function var_0_0.onBeginDrag(arg_3_0)
	arg_3_0.anim:Play("image_content_drag")
end

function var_0_0.onDraging(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.onDraging(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.onEndDrag(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.onEndDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.anim:Play("open")
end

function var_0_0.setPos(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.setPos(arg_6_0, arg_6_1, arg_6_2)
	recthelper.setAnchor(arg_6_0.tf, arg_6_1, arg_6_2)
end

function var_0_0.setDir(arg_7_0, arg_7_1)
	arg_7_0.dir = arg_7_1

	transformhelper.setLocalRotation(arg_7_0.tf, 0, arg_7_1 == PuzzleEnum.dir.right and 180 or 0, 0)
end

function var_0_0.onPawnJump(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function var_0_0.destroy(arg_9_0)
	arg_9_0.animEvent:RemoveEventListener(PuzzleEnum.AnimEvent_OnJump)
	var_0_0.super.destroy(arg_9_0)
end

return var_0_0
