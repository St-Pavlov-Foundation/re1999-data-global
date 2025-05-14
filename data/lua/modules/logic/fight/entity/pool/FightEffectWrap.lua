module("modules.logic.fight.entity.pool.FightEffectWrap", package.seeall)

local var_0_0 = class("FightEffectWrap", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.uniqueId = nil
	arg_1_0.path = nil
	arg_1_0.abPath = nil
	arg_1_0.side = nil
	arg_1_0.containerGO = nil
	arg_1_0.containerTr = nil
	arg_1_0.effectGO = nil
	arg_1_0.hangPointGO = nil
	arg_1_0._canDestroy = false
	arg_1_0._layer = nil
	arg_1_0._renderOrder = nil
	arg_1_0._nonActiveKeyList = {}
	arg_1_0._nonPosActiveKeyList = {}
	arg_1_0.callback = nil
	arg_1_0.callbackObj = nil
	arg_1_0.dontPlay = nil
	arg_1_0.cus_localPosX = nil
	arg_1_0.cus_localPosY = nil
	arg_1_0.cus_localPosZ = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.containerGO = arg_2_1
	arg_2_0.containerTr = arg_2_1.transform
end

function var_0_0.play(arg_3_0)
	if arg_3_0.effectGO and not arg_3_0.dontPlay then
		arg_3_0:setActive(true)

		local var_3_0 = arg_3_0.effectGO:GetComponent(typeof(ZProj.EffectShakeComponent))

		if var_3_0 then
			local var_3_1 = FightModel.instance:getSpeed()
			local var_3_2 = 1

			if var_3_1 > 1.4 then
				var_3_2 = 1 - 0.3 * (var_3_1 - 1.4) / 1.4
			end

			var_3_0:Play(CameraMgr.instance:getCameraShake(), var_3_1, var_3_2)
		end
	end
end

function var_0_0.setUniqueId(arg_4_0, arg_4_1)
	arg_4_0.uniqueId = arg_4_1
end

function var_0_0.setPath(arg_5_0, arg_5_1)
	arg_5_0.path = arg_5_1
	arg_5_0.abPath = FightHelper.getEffectAbPath(arg_5_1)
end

function var_0_0.setEffectGO(arg_6_0, arg_6_1)
	arg_6_0.effectGO = arg_6_1

	if arg_6_0._effectScale then
		transformhelper.setLocalScale(arg_6_0.effectGO.transform, arg_6_0._effectScale, arg_6_0._effectScale, arg_6_0._effectScale)
	end

	if arg_6_0._renderOrder then
		arg_6_0:setRenderOrder(arg_6_0._renderOrder, true)
	end

	arg_6_0.cus_localPosX, arg_6_0.cus_localPosY, arg_6_0.cus_localPosZ = transformhelper.getLocalPos(arg_6_0.effectGO.transform)

	if arg_6_0._nonPosActiveKeyList and #arg_6_0._nonPosActiveKeyList > 0 then
		arg_6_0:playActiveByPos(false)
	end
end

function var_0_0.setLayer(arg_7_0, arg_7_1)
	arg_7_0._layer = arg_7_1

	gohelper.setLayer(arg_7_0.effectGO, arg_7_0._layer, true)
end

function var_0_0.setHangPointGO(arg_8_0, arg_8_1)
	if not gohelper.isNil(arg_8_1) and not gohelper.isNil(arg_8_0.containerGO) and arg_8_0.hangPointGO ~= arg_8_1 then
		arg_8_0.hangPointGO = arg_8_1

		arg_8_0.containerGO.transform:SetParent(arg_8_0.hangPointGO.transform, true)
		transformhelper.setLocalRotation(arg_8_0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(arg_8_0.containerGO.transform, 1, 1, 1)
	end
end

function var_0_0.setLocalPos(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0.containerTr then
		transformhelper.setLocalPos(arg_9_0.containerTr, arg_9_1, arg_9_2, arg_9_3)
		arg_9_0:clearTrail()
	end
end

function var_0_0.setWorldPos(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_0.containerTr then
		transformhelper.setPos(arg_10_0.containerTr, arg_10_1, arg_10_2, arg_10_3)
		arg_10_0:clearTrail()
	end
end

function var_0_0.setCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.callback = arg_11_1
	arg_11_0.callbackObj = arg_11_2
end

function var_0_0.setActive(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or "default"

	if arg_12_0.containerGO then
		if arg_12_1 then
			tabletool.removeValue(arg_12_0._nonActiveKeyList, arg_12_2)
			gohelper.setActive(arg_12_0.containerGO, #arg_12_0._nonActiveKeyList == 0)
		else
			if not tabletool.indexOf(arg_12_0._nonActiveKeyList, arg_12_2) then
				table.insert(arg_12_0._nonActiveKeyList, arg_12_2)
			end

			gohelper.setActive(arg_12_0.containerGO, false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. arg_12_0.path)
	end
end

function var_0_0.setActiveByPos(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or "default"

	if arg_13_0.containerGO then
		if arg_13_1 then
			tabletool.removeValue(arg_13_0._nonPosActiveKeyList, arg_13_2)
			arg_13_0:playActiveByPos(#arg_13_0._nonPosActiveKeyList == 0)
		else
			if not tabletool.indexOf(arg_13_0._nonPosActiveKeyList, arg_13_2) then
				table.insert(arg_13_0._nonPosActiveKeyList, arg_13_2)
			end

			arg_13_0:playActiveByPos(false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. arg_13_0.path)
	end
end

function var_0_0.playActiveByPos(arg_14_0, arg_14_1)
	if arg_14_0.effectGO and arg_14_0.cus_localPosX then
		if arg_14_1 then
			transformhelper.setLocalPos(arg_14_0.effectGO.transform, arg_14_0.cus_localPosX, arg_14_0.cus_localPosY, arg_14_0.cus_localPosZ)
		else
			transformhelper.setLocalPos(arg_14_0.effectGO.transform, arg_14_0.cus_localPosX + 20000, arg_14_0.cus_localPosY + 20000, arg_14_0.cus_localPosZ + 20000)
		end
	end
end

function var_0_0.onReturnPool(arg_15_0)
	arg_15_0._nonActiveKeyList = {}
	arg_15_0._nonPosActiveKeyList = {}

	arg_15_0:playActiveByPos(true)
end

function var_0_0.setRenderOrder(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_0._renderOrder

	arg_16_0._renderOrder = arg_16_1

	if not arg_16_2 and arg_16_1 == var_16_0 then
		return
	end

	if not gohelper.isNil(arg_16_0.effectGO) then
		local var_16_1 = arg_16_0.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer))

		if var_16_1 then
			var_16_1:SetBaseOrder(arg_16_1)
		end
	end
end

function var_0_0.setTimeScale(arg_17_0, arg_17_1)
	if arg_17_0.effectGO then
		gohelper.onceAddComponent(arg_17_0.effectGO, typeof(ZProj.EffectTimeScale)):SetTimeScale(arg_17_1)
	end
end

function var_0_0.clearTrail(arg_18_0)
	if arg_18_0.effectGO then
		gohelper.onceAddComponent(arg_18_0.effectGO, typeof(ZProj.EffectTimeScale)):ClearTrail()
	end
end

function var_0_0.doCallback(arg_19_0, arg_19_1)
	if arg_19_0.callback then
		if arg_19_0.callbackObj then
			arg_19_0.callback(arg_19_0.callbackObj, arg_19_0, arg_19_1)
		else
			arg_19_0.callback(arg_19_0, arg_19_1)
		end

		arg_19_0.callback = nil
		arg_19_0.callbackObj = nil
	end
end

function var_0_0.setEffectScale(arg_20_0, arg_20_1)
	arg_20_0._effectScale = arg_20_1

	if arg_20_0.effectGO then
		transformhelper.setLocalScale(arg_20_0.effectGO.transform, arg_20_0._effectScale, arg_20_0._effectScale, arg_20_0._effectScale)
	end
end

function var_0_0.markCanDestroy(arg_21_0)
	arg_21_0._canDestroy = true
end

function var_0_0.onDestroy(arg_22_0)
	if not arg_22_0._canDestroy then
		logError("Effect destroy unexpected: " .. arg_22_0.path)
	end

	arg_22_0.containerGO = nil
	arg_22_0.effectGO = nil
	arg_22_0.hangPointGO = nil
	arg_22_0.callback = nil
	arg_22_0.callbackObj = nil
end

return var_0_0
