module("modules.spine.UnitSpine", package.seeall)

local var_0_0 = class("UnitSpine", LuaCompBase)

var_0_0.TypeSkeletonAnimtion = typeof(Spine.Unity.SkeletonAnimation)
var_0_0.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)
var_0_0.Evt_OnLoaded = 100001

function var_0_0.Create(arg_1_0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.unitSpawn = arg_2_1

	LuaEventSystem.addEventMechanism(arg_2_0)
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._gameObj = arg_3_1
	arg_3_0._gameTr = arg_3_1.transform
	arg_3_0._resLoader = nil
	arg_3_0._resPath = nil
	arg_3_0._skeletonAnim = nil
	arg_3_0._spineRenderer = nil
	arg_3_0._ppEffectMask = nil
	arg_3_0._spineGo = nil
	arg_3_0._spineTr = nil
	arg_3_0._curAnimState = nil
	arg_3_0._defaultAnimState = SpineAnimState.idle1
	arg_3_0._isLoop = false
	arg_3_0._lookDir = SpineLookDir.Left
	arg_3_0._timeScale = 1
	arg_3_0._bFreeze = false
	arg_3_0._layer = UnityLayer.Unit
	arg_3_0._actionCbList = {}
	arg_3_0._resLoadedCb = nil
	arg_3_0._resLoadedCbObj = nil
end

function var_0_0.setResPath(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		return
	end

	if arg_4_0.resPath == arg_4_1 then
		return
	end

	arg_4_0:_clear()

	arg_4_0._resPath = arg_4_1
	arg_4_0._resLoadedCb = arg_4_2
	arg_4_0._resLoadedCbObj = arg_4_3

	local var_4_0 = FightSpinePool.getSpine(arg_4_0._resPath)

	if var_4_0 then
		if gohelper.isNil(arg_4_0._gameObj) then
			logError("try move spine, but parent is nil, spine name : " .. tostring(var_4_0.name))
		end

		gohelper.addChild(arg_4_0._gameObj, var_4_0)
		transformhelper.setLocalPos(var_4_0.transform, 0, 0, 0)
		arg_4_0:_initSpine(var_4_0)
	else
		arg_4_0._resLoader = MultiAbLoader.New()

		arg_4_0._resLoader:addPath(arg_4_0._resPath)
		arg_4_0._resLoader:startLoad(arg_4_0._onResLoaded, arg_4_0)
	end
end

function var_0_0.setFreeze(arg_5_0, arg_5_1)
	arg_5_0._bFreeze = arg_5_1

	if arg_5_0._skeletonAnim then
		arg_5_0._skeletonAnim.freeze = arg_5_0._bFreeze
	end
end

function var_0_0.setTimeScale(arg_6_0, arg_6_1)
	arg_6_0._timeScale = arg_6_1

	if arg_6_0._skeletonAnim then
		arg_6_0._skeletonAnim.timeScale = arg_6_0._timeScale
	end
end

function var_0_0._clear(arg_7_0)
	if arg_7_0._resLoader then
		arg_7_0._resLoader:dispose()

		arg_7_0._resLoader = nil
	end

	if arg_7_0._csSpineEvt then
		arg_7_0._csSpineEvt:RemoveAnimEventCallback()
	end

	arg_7_0._skeletonAnim = nil
	arg_7_0._resPath = nil
	arg_7_0._spineGo = nil
	arg_7_0._spineTr = nil
	arg_7_0._bFreeze = false
	arg_7_0._isActive = true
	arg_7_0._renderOrder = nil
end

function var_0_0._onResLoaded(arg_8_0, arg_8_1)
	if gohelper.isNil(arg_8_0._gameObj) then
		return
	end

	local var_8_0 = arg_8_1:getFirstAssetItem()

	if var_8_0 then
		local var_8_1 = var_8_0:GetResource()
		local var_8_2 = gohelper.clone(var_8_1, arg_8_0._gameObj)

		arg_8_0:_initSpine(var_8_2)
	end
end

function var_0_0._initSpine(arg_9_0, arg_9_1)
	arg_9_0._spineGo = arg_9_1
	arg_9_0._spineTr = arg_9_0._spineGo.transform

	arg_9_0:setLayer(arg_9_0._layer, true)

	arg_9_0._skeletonAnim = arg_9_0._spineGo:GetComponent(var_0_0.TypeSkeletonAnimtion)

	if arg_9_0._lookDir == SpineLookDir.Right then
		arg_9_0._skeletonAnim.initialFlipX = true

		arg_9_0._skeletonAnim:Initialize(true)
	else
		arg_9_0._skeletonAnim:Initialize(false)
	end

	arg_9_0._skeletonAnim.freeze = arg_9_0._bFreeze
	arg_9_0._skeletonAnim.timeScale = arg_9_0._timeScale
	arg_9_0._spineRenderer = arg_9_0._spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_9_0._ppEffectMask = arg_9_0._spineGo:GetComponent(typeof(UrpCustom.PPEffectMask))
	arg_9_0._csSpineEvt = gohelper.onceAddComponent(arg_9_0._spineGo, var_0_0.TypeSpineAnimationEvent)

	arg_9_0._csSpineEvt:SetAnimEventCallback(arg_9_0._onAnimCallback, arg_9_0)
	arg_9_0:setActive(arg_9_0._isActive)

	if arg_9_0._curAnimState then
		local var_9_0 = arg_9_0._curAnimState

		arg_9_0._curAnimState = nil

		arg_9_0:play(var_9_0, arg_9_0._isLoop)
	elseif arg_9_0._defaultAnimState and arg_9_0._skeletonAnim:HasAnimation(arg_9_0._defaultAnimState) then
		arg_9_0._isLoop = true

		arg_9_0:play(arg_9_0._defaultAnimState, arg_9_0._isLoop, true)
	end

	arg_9_0:setRenderOrder(arg_9_0._renderOrder, true)

	if arg_9_0._resLoadedCb and arg_9_0._resLoadedCbObj then
		arg_9_0._resLoadedCb(arg_9_0._resLoadedCbObj, arg_9_0)
	end

	arg_9_0._resLoadedCb = nil
	arg_9_0._resLoadedCbObj = nil

	arg_9_0:dispatchEvent(var_0_0.Evt_OnLoaded)
end

function var_0_0.setLayer(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._layer = arg_10_1

	if not gohelper.isNil(arg_10_0._spineGo) then
		gohelper.setLayer(arg_10_0._spineGo, arg_10_0._layer, arg_10_2)
	end
end

function var_0_0.getSpineGO(arg_11_0)
	return arg_11_0._spineGo
end

function var_0_0.getSpineTr(arg_12_0)
	return arg_12_0._spineTr
end

function var_0_0.getSkeletonAnim(arg_13_0)
	return arg_13_0._skeletonAnim
end

function var_0_0.getAnimState(arg_14_0)
	return arg_14_0._curAnimState or arg_14_0._defaultAnimState
end

function var_0_0.getPPEffectMask(arg_15_0)
	return arg_15_0._ppEffectMask
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

	if not gohelper.isNil(arg_16_0._spineRenderer) then
		arg_16_0._spineRenderer.sortingOrder = arg_16_1
	end
end

function var_0_0.changeLookDir(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._lookDir then
		return
	end

	arg_17_0._lookDir = arg_17_1

	arg_17_0:_changeLookDir()
end

function var_0_0._changeLookDir(arg_18_0)
	if arg_18_0._skeletonAnim then
		arg_18_0._skeletonAnim:SetScaleX(arg_18_0._lookDir)
	end
end

function var_0_0.getLookDir(arg_19_0)
	return arg_19_0._lookDir
end

function var_0_0.setActive(arg_20_0, arg_20_1)
	if arg_20_0._spineGo then
		gohelper.setActive(arg_20_0._spineGo, arg_20_1)
	else
		arg_20_0._isActive = arg_20_1
	end
end

function var_0_0.play(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_3 or arg_21_1 ~= arg_21_0._curAnimState or arg_21_2 ~= arg_21_0._isLoop

	arg_21_0._curAnimState = arg_21_1
	arg_21_0._isLoop = arg_21_2 or false
	arg_21_3 = arg_21_3 or false

	if arg_21_0._skeletonAnim and var_21_0 then
		if arg_21_0._skeletonAnim:HasAnimation(arg_21_1) then
			arg_21_0:playAnim(arg_21_1, arg_21_0._isLoop, arg_21_3)
		else
			if isDebugBuild then
				local var_21_1 = not gohelper.isNil(arg_21_0._spineGo) and arg_21_0._spineGo.name or "spine_nil"
				local var_21_2 = string.find(var_21_1, "(Clone)", 1)
				local var_21_3 = var_21_2 and string.sub(var_21_1, 1, var_21_2 - 2) or var_21_1

				logError(string.format("%s 缺少动作: %s", var_21_3, arg_21_1))
			end

			arg_21_0:playAnim(SpineAnimState.idle1, true, true)
		end
	end
end

function var_0_0.hasAnimation(arg_22_0, arg_22_1)
	if arg_22_0._skeletonAnim then
		return arg_22_0._skeletonAnim:HasAnimation(arg_22_1)
	end

	return false
end

function var_0_0.playAnim(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._skeletonAnim:PlayAnim(arg_23_1, arg_23_2, arg_23_3)
end

function var_0_0.setAnimation(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0._skeletonAnim then
		arg_24_0._curAnimState = arg_24_1
		arg_24_0._isLoop = arg_24_2 or false

		arg_24_0._skeletonAnim:SetAnimation(0, arg_24_1, arg_24_2, arg_24_3 or 0)
	end
end

function var_0_0.addAnimEventCallback(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_1 then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._actionCbList) do
		local var_25_0 = iter_25_1[1]
		local var_25_1 = iter_25_1[2]

		if var_25_0 == arg_25_1 and var_25_1 == arg_25_2 then
			iter_25_1[3] = arg_25_3

			return
		end
	end

	table.insert(arg_25_0._actionCbList, {
		arg_25_1,
		arg_25_2,
		arg_25_3
	})
end

function var_0_0.removeAnimEventCallback(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._actionCbList) do
		local var_26_0 = iter_26_1[1]
		local var_26_1 = iter_26_1[2]

		if var_26_0 == arg_26_1 and var_26_1 == arg_26_2 then
			table.remove(arg_26_0._actionCbList, iter_26_0)

			break
		end
	end
end

function var_0_0.removeAllAnimEventCallback(arg_27_0)
	arg_27_0._actionCbList = {}
end

function var_0_0._onAnimCallback(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._actionCbList) do
		local var_28_0 = iter_28_1[1]
		local var_28_1 = iter_28_1[2]
		local var_28_2 = iter_28_1[3]

		if var_28_1 then
			var_28_0(var_28_1, arg_28_1, arg_28_2, arg_28_3, var_28_2)
		else
			var_28_0(arg_28_1, arg_28_2, arg_28_3, var_28_2)
		end
	end
end

function var_0_0.logNilGameObj(arg_29_0)
	return
end

function var_0_0.onDestroy(arg_30_0)
	arg_30_0:_clear()

	arg_30_0._resLoader = nil
	arg_30_0._csSpineEvt = nil
end

return var_0_0
