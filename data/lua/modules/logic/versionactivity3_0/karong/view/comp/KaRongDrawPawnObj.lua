module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawPawnObj", package.seeall)

local var_0_0 = class("KaRongDrawPawnObj", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.image = gohelper.findChildImage(arg_1_0.go, "#go_ctrl/#image_content")
	arg_1_0.imageTf = arg_1_0.image.transform
	arg_1_0.goCtrl = gohelper.findChild(arg_1_0.go, "#go_ctrl")
	arg_1_0.tf = arg_1_0.go.transform
	arg_1_0.anim = arg_1_0.image.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animEvent = arg_1_0.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_1_0.animEvent:AddEventListener(KaRongDrawEnum.AnimEvent_OnJump, arg_1_0.onPawnJump, arg_1_0)

	arg_1_0.isAvatar = arg_1_2
	arg_1_0.dir = arg_1_2 and KaRongDrawEnum.dir.left or KaRongDrawEnum.dir.right

	arg_1_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, arg_1_0._onUsingSkill, arg_1_0)
end

function var_0_0._onUsingSkill(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, not arg_2_1)
end

function var_0_0.onInit(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.anim:Play("open")

	local var_3_0 = KaRongDrawModel.instance:getPawnIconUrl(arg_3_0.isAvatar)

	if not string.nilorempty(var_3_0) then
		UISpriteSetMgr.instance:setV3a0KaRongSprite(arg_3_0.image, var_3_0, true)
	end

	recthelper.setAnchor(arg_3_0.goCtrl.transform, KaRongDrawEnum.MazeMonsterIconOffset.x, KaRongDrawEnum.MazeMonsterIconOffset.y)
	arg_3_0:setPos(arg_3_1, arg_3_2)
	gohelper.setAsLastSibling(arg_3_0.go)
end

function var_0_0.onBeginDrag(arg_4_0)
	arg_4_0.anim:Play("image_content_drag")
end

function var_0_0.onDraging(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:setPos(arg_5_1, arg_5_2)
end

function var_0_0.onEndDrag(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:setPos(arg_6_1, arg_6_2)
	arg_6_0.anim:Play("open")
end

function var_0_0.setPos(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.x = arg_7_1 or 0
	arg_7_0.y = arg_7_2 or 0

	recthelper.setAnchor(arg_7_0.tf, arg_7_1, arg_7_2)
end

function PuzzleMazeBasePawnObj.getPos(arg_8_0)
	return arg_8_0.x or 0, arg_8_0.y or 0
end

function var_0_0.setDir(arg_9_0, arg_9_1)
	arg_9_0.dir = arg_9_0.isAvatar and -arg_9_1 or arg_9_1

	if math.abs(arg_9_1) == 1 then
		transformhelper.setLocalRotation(arg_9_0.tf, 0, arg_9_0.dir == KaRongDrawEnum.dir.right and 180 or 0, 0)
	end
end

function PuzzleMazeBasePawnObj.getDir(arg_10_0)
	return arg_10_0.dir
end

function var_0_0.onPawnJump(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function var_0_0.destroy(arg_12_0)
	arg_12_0.animEvent:RemoveEventListener(KaRongDrawEnum.AnimEvent_OnJump)
	arg_12_0:__onDispose()
end

return var_0_0
