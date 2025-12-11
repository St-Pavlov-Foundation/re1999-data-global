module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyTail", package.seeall)

local var_0_0 = class("FightBuffJuDaBenYePuDormancyTail", FightBaseClass)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._entity = arg_1_1
	arg_1_0._buffUid = arg_1_3
	arg_1_0._entityMat = arg_1_0._entity.spineRenderer:getCloneOriginMat()

	if not arg_1_0._entityMat then
		arg_1_0._entityMat = arg_1_0._entity.spineRenderer:getSpineRenderMat()
	end

	if not arg_1_0._entityMat then
		return
	end

	arg_1_0._entityMat:EnableKeyword("_STONE_ON")

	arg_1_0._path = ResUrl.getRoleSpineMatTex("textures/stone_manual")

	arg_1_0:com_loadAsset(arg_1_0._path, arg_1_0._onLoaded)
	arg_1_0:com_registFightEvent(FightEvent.RemoveEntityBuff, arg_1_0._onRemoveEntityBuff)
end

function var_0_0._onRemoveEntityBuff(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= arg_2_0._entity.id then
		return
	end

	if arg_2_2.uid ~= arg_2_0._buffUid then
		return
	end

	arg_2_0:onBuffEnd()
end

function var_0_0._onLoaded(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_2:GetResource(arg_3_0._path)

	arg_3_0._entityMat:SetTexture("_NoiseMap4", var_3_0)
	arg_3_0:_playOpenTween()
end

function var_0_0._playOpenTween(arg_4_0)
	arg_4_0:_releaseTween()

	local var_4_0
	local var_4_1 = UnityEngine.Shader.PropertyToID("_TempOffset3")

	arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function(arg_5_0)
		local var_5_0, var_5_1 = arg_4_0:getPlayValue()

		var_4_0 = MaterialUtil.getLerpValue("Vector4", var_5_0, var_5_1, arg_5_0, var_4_0)

		MaterialUtil.setPropValue(arg_4_0._entityMat, var_4_1, "Vector4", var_4_0)
	end)
end

function var_0_0._playCloseTween(arg_6_0)
	arg_6_0:_releaseTween()

	local var_6_0
	local var_6_1 = UnityEngine.Shader.PropertyToID("_TempOffset3")

	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function(arg_7_0)
		local var_7_0, var_7_1 = arg_6_0:getCloseValue()

		var_6_0 = MaterialUtil.getLerpValue("Vector4", var_7_0, var_7_1, arg_7_0, var_6_0)

		MaterialUtil.setPropValue(arg_6_0._entityMat, var_6_1, "Vector4", var_6_0)
	end)
end

function var_0_0.getPlayValue(arg_8_0)
	local var_8_0 = MaterialUtil.getPropValueFromMat(arg_8_0._entityMat, "_TempOffset3", "Vector4")
	local var_8_1 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", var_8_0.y))
	local var_8_2 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", var_8_0.y))

	return var_8_1, var_8_2
end

function var_0_0.getCloseValue(arg_9_0)
	local var_9_0 = MaterialUtil.getPropValueFromMat(arg_9_0._entityMat, "_TempOffset3", "Vector4")
	local var_9_1 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", var_9_0.y))
	local var_9_2 = MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", var_9_0.y))

	return var_9_1, var_9_2
end

function var_0_0.onBuffEnd(arg_10_0)
	if not arg_10_0._entityMat then
		return
	end

	arg_10_0:_playCloseTween()
	TaskDispatcher.runDelay(arg_10_0._delayDone, arg_10_0, 0.6)
end

function var_0_0._delayDone(arg_11_0)
	local var_11_0 = arg_11_0._entity:getMO()

	if var_11_0 and arg_11_0._entity.spineRenderer then
		local var_11_1 = var_11_0:getBuffDic()
		local var_11_2 = false

		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			if iter_11_1.buffId == 4150022 or iter_11_1.buffId == 4150023 then
				var_11_2 = true
			end
		end

		if not var_11_2 and arg_11_0._entityMat then
			arg_11_0._entityMat:DisableKeyword("_STONE_ON")
		end
	end

	arg_11_0:disposeSelf()
end

function var_0_0.onLogicExit(arg_12_0)
	arg_12_0:_releaseTween()
	TaskDispatcher.cancelTask(arg_12_0._delayDone, arg_12_0)
end

function var_0_0._releaseTween(arg_13_0)
	if arg_13_0._tweenId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenId)

		arg_13_0._tweenId = nil
	end
end

return var_0_0
