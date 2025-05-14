module("modules.logic.room.entity.comp.base.RoomBaseSpineComp", package.seeall)

local var_0_0 = class("RoomBaseSpineComp", LuaCompBase)
local var_0_1 = "_MainColor"
local var_0_2 = 0.5
local var_0_3 = 0.5

var_0_0.DefaulSpineHeight = 0.01

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._spinePrefabRes = nil
	arg_1_0._lookDir = SpineLookDir.Default
	arg_1_0._moveState = RoomCharacterEnum.CharacterMoveState.Idle
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goTrs = arg_2_1.transform
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._materialRes = RoomCharacterEnum.MaterialPath
	arg_2_0._loader = nil
	arg_2_0._spineGO = nil
	arg_2_0._material = nil
	arg_2_0._meshRenderer = nil
	arg_2_0._skeletonAnim = nil
	arg_2_0._curAnimState = nil
	arg_2_0._isLoop = nil
	arg_2_0._alpha = 1

	arg_2_0:onInit()
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.getLookDir(arg_4_0)
	return arg_4_0._lookDir
end

function var_0_0.setLookDir(arg_5_0, arg_5_1)
	if arg_5_0._lookDir == arg_5_1 then
		return
	end

	arg_5_0._lookDir = arg_5_1

	arg_5_0:refreshFlip()
end

function var_0_0.refreshFlip(arg_6_0)
	if arg_6_0._skeletonAnim then
		if arg_6_0._lookDir == SpineLookDir.Right then
			arg_6_0._skeletonAnim:SetScaleX(SpineLookDir.Right)
		else
			arg_6_0._skeletonAnim:SetScaleX(SpineLookDir.Left)
		end
	end
end

function var_0_0.refreshRotation(arg_7_0)
	if not arg_7_0._spineGO then
		return
	end

	local var_7_0 = arg_7_0._scene.camera:getCameraRotate()
	local var_7_1 = Quaternion.New()

	var_7_1:SetEuler(0, Mathf.Rad2Deg * var_7_0, 0)

	arg_7_0._spineGOTrs.rotation = var_7_1
end

function var_0_0.showSpine(arg_8_0)
	if arg_8_0._spineGO then
		local var_8_0 = arg_8_0:getAlpha()

		arg_8_0:tweenAlpha(var_8_0, 1, (1 - var_8_0) * var_0_2)
	else
		if arg_8_0._loader then
			arg_8_0._loader:dispose()

			arg_8_0._loader = nil
		end

		arg_8_0._loader = SequenceAbLoader.New()

		arg_8_0:addResToLoader(arg_8_0._loader)
		arg_8_0._loader:setConcurrentCount(10)
		arg_8_0._loader:setLoadFailCallback(arg_8_0._onLoadOneFail)
		arg_8_0._loader:startLoad(arg_8_0._onLoadFinish, arg_8_0)
	end
end

function var_0_0.hideSpine(arg_9_0)
	if arg_9_0._spineGO then
		local var_9_0 = arg_9_0:getAlpha()

		arg_9_0:tweenAlpha(var_9_0, 0, var_9_0 * var_0_3, arg_9_0._hideCallback, arg_9_0)
	else
		arg_9_0:clearSpine()
	end
end

function var_0_0._hideCallback(arg_10_0)
	arg_10_0:clearSpine()
end

function var_0_0.isShowAnimShadow(arg_11_0)
	return true
end

function var_0_0.addResToLoader(arg_12_0, arg_12_1)
	arg_12_1:addPath(arg_12_0._spinePrefabRes)
	arg_12_1:addPath(arg_12_0._materialRes)
end

function var_0_0._onLoadOneFail(arg_13_0, arg_13_1, arg_13_2)
	logError(string.format("%s:_onLoadOneFail 加载失败, url:%s", arg_13_0.__cname, arg_13_2.ResPath))
end

function var_0_0._onLoadFinish(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getAssetItem(arg_14_0._spinePrefabRes)

	if not var_14_0 then
		logError("can not find :" .. arg_14_0._spinePrefabRes)
	end

	local var_14_1 = var_14_0:GetResource(arg_14_0._spinePrefabRes)
	local var_14_2 = arg_14_1:getAssetItem(arg_14_0._materialRes):GetResource(arg_14_0._materialRes)

	arg_14_0._spineGO = gohelper.clone(var_14_1, arg_14_0.entity.containerGO, "spine")
	arg_14_0._spineGOTrs = arg_14_0._spineGO.transform

	gohelper.setLayer(arg_14_0._spineGO, LayerMask.NameToLayer("Scene"), true)

	arg_14_0._meshRenderer = arg_14_0._spineGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	arg_14_0._skeletonAnim = arg_14_0._spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	gohelper.onceAddComponent(arg_14_0._spineGO, UnitSpine.TypeSpineAnimationEvent)
	TaskDispatcher.cancelTask(arg_14_0._onSpineAnimEvent, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._onSpineAnimEvent, arg_14_0, 0.02)
	transformhelper.setLocalPos(arg_14_0._spineGOTrs, 0, var_0_0.DefaulSpineHeight, 0)
	transformhelper.setLocalScale(arg_14_0._spineGOTrs, 0.07, 0.07, 0.07)
	arg_14_0:_replaceMaterial(var_14_2)
	arg_14_0:refreshFlip()
	arg_14_0:refreshRotation()
	arg_14_0:tweenAlpha(0, 1, var_0_2)
end

function var_0_0._replaceMaterial(arg_15_0, arg_15_1)
	arg_15_0._material = UnityEngine.GameObject.Instantiate(arg_15_1)

	local var_15_0 = arg_15_0._meshRenderer.sharedMaterial

	arg_15_0._material:SetTexture("_MainTex", var_15_0:GetTexture("_MainTex"))
	arg_15_0._material:SetTexture("_BackLight", var_15_0:GetTexture("_NormalMap"))
	arg_15_0._material:SetTexture("_DissolveTex", var_15_0:GetTexture("_DissolveTex"))

	local var_15_1 = arg_15_0._skeletonAnim.CustomMaterialOverride

	if var_15_1 then
		var_15_1:Clear()
		var_15_1:Add(var_15_0, arg_15_0._material)
	end

	arg_15_0._meshRenderer.material = arg_15_0._material
	arg_15_0._meshRenderer.sortingLayerName = "Default"
end

function var_0_0._onSpineAnimEvent(arg_16_0)
	if not gohelper.isNil(arg_16_0._spineGO) then
		arg_16_0._csSpineEvt = gohelper.onceAddComponent(arg_16_0._spineGO, UnitSpine.TypeSpineAnimationEvent)
	end

	if arg_16_0._csSpineEvt then
		arg_16_0._csSpineEvt:SetAnimEventCallback(arg_16_0._onAnimCallback, arg_16_0)
	end
end

function var_0_0._onAnimCallback(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	return
end

function var_0_0.getAnimState(arg_18_0)
	if arg_18_0._skeletonAnim then
		return arg_18_0._skeletonAnim.AnimationName
	end
end

function var_0_0.play(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_1 then
		return
	end

	if not arg_19_0._skeletonAnim then
		return
	end

	arg_19_2 = arg_19_2 or false
	arg_19_3 = arg_19_3 or false

	if not (arg_19_3 or arg_19_1 ~= arg_19_0._curAnimState or arg_19_2 ~= arg_19_0._isLoop) then
		return
	end

	arg_19_0._curAnimState = arg_19_1
	arg_19_0._isLoop = arg_19_2

	if arg_19_0._skeletonAnim:HasAnimation(arg_19_1) then
		arg_19_0._skeletonAnim:SetAnimation(0, arg_19_1, arg_19_0._isLoop, 0)
	else
		local var_19_0 = gohelper.isNil(arg_19_0._spineGO) and "nil" or arg_19_0._spineGO.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", arg_19_1, var_19_0))
	end
end

function var_0_0.tweenAlpha(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if arg_20_0._alphaTweenId then
		arg_20_0._scene.tween:killById(arg_20_0._alphaTweenId)

		arg_20_0._alphaTweenId = nil
	end

	if arg_20_3 and arg_20_3 > 0 then
		arg_20_0:setAlpha(arg_20_1)

		arg_20_0._alphaTweenId = arg_20_0._scene.tween:tweenFloat(0, 1, arg_20_3, arg_20_0._tweenAlphaFrameCallback, arg_20_0._tweenAlphaFinishCallback, arg_20_0, {
			fromAlpha = arg_20_1,
			toAlpha = arg_20_2,
			callback = arg_20_4,
			callbackObj = arg_20_5
		})
	else
		arg_20_0:setAlpha(arg_20_2)
	end
end

function var_0_0._tweenAlphaFrameCallback(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2.fromAlpha
	local var_21_1 = arg_21_2.toAlpha
	local var_21_2 = var_21_0 * (1 - arg_21_1) + var_21_1 * arg_21_1

	arg_21_0:setAlpha(var_21_2)
end

function var_0_0._tweenAlphaFinishCallback(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.toAlpha
	local var_22_1 = arg_22_1.callback
	local var_22_2 = arg_22_1.callbackObj

	arg_22_0:setAlpha(var_22_0)

	if var_22_1 then
		var_22_1(var_22_2)
	end
end

function var_0_0.setAlpha(arg_23_0, arg_23_1)
	arg_23_0._alpha = arg_23_1

	arg_23_0:updateAlpha()
end

function var_0_0.getAlpha(arg_24_0)
	return arg_24_0._alpha
end

function var_0_0.updateAlpha(arg_25_0)
	local var_25_0 = arg_25_0.entity.isPressing and 0 or arg_25_0._alpha

	if arg_25_0._material then
		local var_25_1 = arg_25_0._material:GetColor(var_0_1)

		var_25_1.a = var_25_0

		arg_25_0._material:SetColor(var_0_1, var_25_1)
	end

	if arg_25_0:isShowAnimShadow() and arg_25_0._meshRenderer then
		if var_25_0 > 0.5 then
			arg_25_0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
		else
			arg_25_0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
		end
	end
end

function var_0_0.playVoice(arg_26_0, arg_26_1)
	if arg_26_0._spineGO then
		ZProj.AudioEmitter.Get(arg_26_0._spineGO):Emitter(arg_26_1)
	end
end

function var_0_0.playVoiceWithLang(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._spineGO then
		local var_27_0 = ZProj.AudioEmitter.Get(arg_27_0._spineGO)

		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			local var_27_1 = AudioConfig.instance:getAudioCOById(arg_27_1).bankName

			ZProj.AudioManager.Instance:LoadBank(var_27_1, arg_27_2)
			var_27_0:Emitter(arg_27_1, arg_27_2)
			ZProj.AudioManager.Instance:UnloadBank(var_27_1)
		else
			var_27_0:Emitter(arg_27_1, arg_27_2)
		end
	end
end

function var_0_0.getSpineGO(arg_28_0)
	return arg_28_0._spineGO
end

function var_0_0.clearSpine(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._onSpineAnimEvent, arg_29_0)

	if arg_29_0._loader then
		arg_29_0._loader:dispose()

		arg_29_0._loader = nil
	end

	if arg_29_0._alphaTweenId then
		arg_29_0._scene.tween:killById(arg_29_0._alphaTweenId)

		arg_29_0._alphaTweenId = nil
	end

	if arg_29_0._csSpineEvt then
		arg_29_0._csSpineEvt:RemoveAnimEventCallback()

		arg_29_0._csSpineEvt = nil
	end

	if arg_29_0._spineGO then
		gohelper.destroy(arg_29_0._spineGO)

		arg_29_0._spineGO = nil
		arg_29_0._spineGOTrs = nil
	end

	if arg_29_0._material then
		gohelper.destroy(arg_29_0._material)

		arg_29_0._material = nil
	end

	arg_29_0._meshRenderer = nil
	arg_29_0._skeletonAnim = nil
	arg_29_0._curAnimState = nil
	arg_29_0._isLoop = nil
end

function var_0_0.beforeDestroy(arg_30_0)
	arg_30_0:clearSpine()
end

return var_0_0
