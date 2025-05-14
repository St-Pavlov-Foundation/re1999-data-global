module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessSleepMonsterEffect", package.seeall)

local var_0_0 = class("Va3ChessSleepMonsterEffect", Va3ChessEffectBase)

function var_0_0.refreshEffect(arg_1_0)
	return
end

function var_0_0.onDispose(arg_2_0)
	return
end

function var_0_0.setSleep(arg_3_0, arg_3_1)
	arg_3_0:_setSleepAnim(arg_3_1, true)
end

function var_0_0._setSleepAnim(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.isLoadFinish and arg_4_0._target.avatar then
		local var_4_0 = arg_4_0._target.avatar
		local var_4_1 = arg_4_1 <= 0

		if arg_4_0._lastIsZreo ~= var_4_1 then
			arg_4_0._lastIsZreo = var_4_1

			gohelper.setActive(var_4_0.goNumber, not var_4_1)
			gohelper.setActive(var_4_0.goSleepB, not var_4_1)
			gohelper.setActive(var_4_0.goSleepA, var_4_1)
			gohelper.setActive(var_4_0.goTanhao, var_4_1)

			if arg_4_2 then
				var_4_0.animatorSleep:Play(var_4_1 and "big" or "little")
			end

			if arg_4_2 and var_4_1 then
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_monster_awake)
			end
		end

		if not var_4_1 then
			local var_4_2 = Mathf.Floor(arg_4_1 / 10) % 10
			local var_4_3 = arg_4_1 % 10

			if arg_4_1 < 10 then
				var_4_2 = var_4_3
				var_4_3 = 0
			end

			gohelper.setActive(var_4_0.meshEffNum2, arg_4_1 >= 10)

			if arg_4_0._lastNum1 ~= var_4_2 then
				arg_4_0._lastNum1 = var_4_2

				arg_4_0:_setMeshNum(var_4_0.meshEffNum1, var_4_0.numPropertyBlock, var_4_2)
			end

			if arg_4_0._lastNum2 ~= var_4_3 then
				arg_4_0._lastNum2 = var_4_3

				arg_4_0:_setMeshNum(var_4_0.meshEffNum2, var_4_0.numPropertyBlock, var_4_3)
			end
		end

		arg_4_0._target:getHandler():setAlertActive(var_4_1)
	end
end

function var_0_0._getOffsetByNum(arg_5_0, arg_5_1)
	if arg_5_1 >= 0 and arg_5_1 <= 9 then
		return arg_5_1 * 0.1
	end

	return 1
end

function var_0_0._setMeshNum(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:_getOffsetByNum(arg_6_3 - 1)

	arg_6_2:Clear()
	arg_6_2:SetVector("_MainTex_ST", Vector4.New(0.1, 1, var_6_0, 0))
	arg_6_1:SetPropertyBlock(arg_6_2)
end

function var_0_0.onAvatarLoaded(arg_7_0)
	local var_7_0 = arg_7_0._loader

	if not arg_7_0._loader then
		return
	end

	local var_7_1 = var_7_0:getInstGO()

	if not gohelper.isNil(var_7_1) then
		local var_7_2 = arg_7_0._target.avatar
		local var_7_3 = gohelper.findChild(var_7_1, "vx_tracked")
		local var_7_4 = gohelper.findChild(var_7_1, "vx_number")
		local var_7_5 = gohelper.findChild(var_7_1, "icon_tanhao")

		var_7_2.meshEffNum1 = gohelper.findChild(var_7_1, "vx_number/1"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		var_7_2.meshEffNum2 = gohelper.findChild(var_7_1, "vx_number/2"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		var_7_2.meshEffNum1.material = UnityEngine.Material.New(var_7_2.meshEffNum1.material)
		var_7_2.meshEffNum2.material = UnityEngine.Material.New(var_7_2.meshEffNum2.material)

		gohelper.setActive(var_7_2.goTrack, false)
		gohelper.setActive(var_7_3, false)
		gohelper.setActive(var_7_4, false)

		var_7_2.goTrack = var_7_3
		var_7_2.goNumber = var_7_4
		var_7_2.goTanhao = var_7_5
		var_7_2.numPropertyBlock = UnityEngine.MaterialPropertyBlock.New()

		local var_7_6 = var_7_2.loader:getInstGO()

		var_7_2.goSleepA = gohelper.findChild(var_7_6, "a")
		var_7_2.goSleepB = gohelper.findChild(var_7_6, "b")
		var_7_2.animatorSleep = var_7_6:GetComponent(Va3ChessEnum.ComponentType.Animator)

		gohelper.setActive(var_7_2.goSleepA, false)

		local var_7_7 = Va3ChessGameModel.instance:getObjectDataById(arg_7_0._target.id)
		local var_7_8 = var_7_7 and var_7_7.data

		if var_7_8 and var_7_8.attributes and var_7_8.attributes.sleep then
			arg_7_0:_setSleepAnim(var_7_8.attributes.sleep)
		end
	end
end

return var_0_0
