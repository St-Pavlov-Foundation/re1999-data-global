module("modules.logic.sp01.assassinChase.view.AssassinChaseSpineItem", package.seeall)

local var_0_0 = class("AssassinChaseSpineItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._spineGO = gohelper.findChild(arg_1_0.go, "spine")
	arg_1_0._skeletonComponent = arg_1_0._spineGO:GetComponent(typeof(Spine.Unity.SkeletonGraphic))

	gohelper.onceAddComponent(arg_1_0._spineGO, UnitSpine.TypeSpineAnimationEvent)

	if arg_1_0._skeletonComponent then
		arg_1_0._skeletonComponent:SetScaleX(SpineLookDir.Right)
	end

	transformhelper.setLocalPos(arg_1_0._spineGO.transform, 0, AssassinChaseEnum.SpineDefaultHeight, 0)

	arg_1_0._goBubble = gohelper.findChild(arg_1_0.go, "image_Bubble")
end

function var_0_0.replaceMaterial(arg_2_0, arg_2_1)
	arg_2_0._material = UnityEngine.GameObject.Instantiate(arg_2_1)
	arg_2_0._skeletonComponent.material = arg_2_0._material
end

function var_0_0.setBubbleActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._goBubble, arg_3_1)
end

function var_0_0.play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		return
	end

	if not arg_4_0._skeletonComponent then
		return
	end

	arg_4_2 = arg_4_2 or false
	arg_4_3 = arg_4_3 or false

	if not (arg_4_3 or arg_4_1 ~= arg_4_0._curAnimState or arg_4_2 ~= arg_4_0._isLoop) then
		return
	end

	arg_4_0._curAnimState = arg_4_1
	arg_4_0._isLoop = arg_4_2

	if arg_4_0._skeletonComponent:HasAnimation(arg_4_1) then
		arg_4_0._skeletonComponent:SetAnimation(0, arg_4_1, arg_4_0._isLoop, 0.2)
	else
		local var_4_0 = gohelper.isNil(arg_4_0._spineGO) and "nil" or arg_4_0._spineGO.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", arg_4_1, var_4_0))
	end
end

function var_0_0.setRolePosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:_releaseTween()

	if not arg_5_2 then
		transformhelper.setLocalPos(arg_5_0._spineGO.transform, arg_5_1, AssassinChaseEnum.SpineDefaultHeight, 0)
	else
		arg_5_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_5_0._spineGO.transform, arg_5_1, arg_5_3, nil, nil, EaseType.InCubic)
	end
end

function var_0_0._releaseTween(arg_6_0)
	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._spineGO then
		gohelper.destroy(arg_7_0._spineGO)

		arg_7_0._spineGO = nil
		arg_7_0._spineGOTrs = nil
	end

	if arg_7_0._material then
		gohelper.destroy(arg_7_0._material)

		arg_7_0._material = nil
	end

	arg_7_0._skeletonComponent = nil
	arg_7_0._skeletonAnim = nil
	arg_7_0._curAnimState = nil

	arg_7_0:_releaseTween()
end

return var_0_0
