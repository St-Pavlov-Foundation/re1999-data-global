module("modules.logic.summon.pool.SummonEffectWrap", package.seeall)

local var_0_0 = class("SummonEffectWrap", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.uniqueId = nil
	arg_1_0.path = nil
	arg_1_0.containerGO = nil
	arg_1_0.containerTr = nil
	arg_1_0.effectGO = nil
	arg_1_0.hangPointGO = nil
	arg_1_0._canDestroy = false
	arg_1_0._animator = nil
	arg_1_0._animationName = nil
	arg_1_0._headLoader = nil
	arg_1_0._frameLoader = nil
	arg_1_0._active = true
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.containerGO = arg_2_1
	arg_2_0.containerTr = arg_2_1.transform
end

function var_0_0.setAnimationName(arg_3_0, arg_3_1)
	arg_3_0._animationName = arg_3_1
end

function var_0_0.play(arg_4_0)
	if arg_4_0.effectGO then
		arg_4_0:setActive(true)
	end

	if arg_4_0._animator and not string.nilorempty(arg_4_0._animationName) then
		arg_4_0._animator.enabled = true

		arg_4_0._animator:Play(arg_4_0._animationName, 0, 0)
		arg_4_0._animator:Update(0)

		arg_4_0._animator.speed = 1
	end
end

function var_0_0.stop(arg_5_0)
	if arg_5_0._animator and not string.nilorempty(arg_5_0._animationName) then
		arg_5_0._animator.enabled = true

		arg_5_0._animator:Play(arg_5_0._animationName, 0, 0)
		arg_5_0._animator:Update(0)

		arg_5_0._animator.speed = 0
	end

	if arg_5_0.effectGO then
		arg_5_0:setActive(false)
	end
end

function var_0_0.setUniqueId(arg_6_0, arg_6_1)
	arg_6_0.uniqueId = arg_6_1
end

function var_0_0.setPath(arg_7_0, arg_7_1)
	arg_7_0.path = arg_7_1
end

function var_0_0.setEffectGO(arg_8_0, arg_8_1)
	arg_8_0.effectGO = arg_8_1
	arg_8_0._animator = arg_8_1:GetComponentInChildren(typeof(UnityEngine.Animator))
	arg_8_0._timeScaleComp = nil
	arg_8_0._particleList = nil
end

function var_0_0.setHangPointGO(arg_9_0, arg_9_1)
	if arg_9_0.hangPointGO ~= arg_9_1 then
		arg_9_0.hangPointGO = arg_9_1

		arg_9_0.containerGO.transform:SetParent(arg_9_0.hangPointGO.transform, true)
		transformhelper.setLocalPos(arg_9_0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalRotation(arg_9_0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(arg_9_0.containerGO.transform, 1, 1, 1)
	end
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	arg_10_0._active = arg_10_1

	if arg_10_0.containerGO then
		gohelper.setActive(arg_10_0.containerGO, arg_10_1)
	else
		logError("Effect container is nil, setActive fail: " .. arg_10_0.path)
	end
end

function var_0_0.loadHeroIcon(arg_11_0, arg_11_1)
	local var_11_0 = SummonEnum.UIMaterialPath[arg_11_0.path]

	if not var_11_0 or #var_11_0 <= 0 then
		return
	end

	local var_11_1 = HeroConfig.instance:getHeroCO(arg_11_1).skinId
	local var_11_2 = var_11_1 and SkinConfig.instance:getSkinCo(var_11_1)

	if not var_11_2 then
		return
	end

	local var_11_3 = ResUrl.getHeadIconSmall(var_11_2.headIcon)

	arg_11_0:loadHeadTex(var_11_3)
end

function var_0_0.loadEquipIcon(arg_12_0, arg_12_1)
	local var_12_0 = EquipConfig.instance:getEquipCo(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_1 = ResUrl.getEquipIconSmall(var_12_0.icon)

	arg_12_0:loadHeadTex(var_12_1)
end

function var_0_0.setEquipFrame(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and SummonEnum.EquipFloatIconFrameOpened or SummonEnum.EquipFloatIconFrameBeforeOpen

	arg_13_0:_loadFrameTex(var_13_0)
end

function var_0_0.loadEquipWaitingClick(arg_14_0)
	local var_14_0 = SummonEnum.EquipDefaultIconPath

	arg_14_0:loadHeadTex(var_14_0)
end

function var_0_0.loadHeadTex(arg_15_0, arg_15_1)
	if arg_15_0._headLoader then
		arg_15_0._headLoader:dispose()

		arg_15_0._headLoader = nil
		arg_15_0._urlHead = nil
	end

	arg_15_0._urlHead = arg_15_1
	arg_15_0._headLoader = MultiAbLoader.New()

	arg_15_0._headLoader:addPath(arg_15_1)
	arg_15_0._headLoader:startLoad(arg_15_0._onHeadIconLoaded, arg_15_0)
end

function var_0_0._onHeadIconLoaded(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._headLoader:getAssetItem(arg_16_0._urlHead)

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0:GetResource(arg_16_0._urlHead)
	local var_16_2 = SummonEnum.UIMaterialPath[arg_16_0.path]

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		local var_16_3 = gohelper.findChild(arg_16_0.effectGO, iter_16_1)

		if var_16_3 then
			local var_16_4 = var_16_3:GetComponent(typeof(UnityEngine.MeshRenderer))

			if var_16_4 then
				var_16_4.material:SetTexture("_MainTex", var_16_1)
			end
		end
	end
end

function var_0_0._loadFrameTex(arg_17_0, arg_17_1)
	if arg_17_0._frameLoader then
		arg_17_0._frameLoader:dispose()

		arg_17_0._frameLoader = nil
		arg_17_0._urlFrame = nil
	end

	arg_17_0._urlFrame = arg_17_1
	arg_17_0._frameLoader = MultiAbLoader.New()

	arg_17_0._frameLoader:addPath(arg_17_1)
	arg_17_0._frameLoader:startLoad(arg_17_0._onFrameTexLoaded, arg_17_0)
end

function var_0_0._onFrameTexLoaded(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._frameLoader:getAssetItem(arg_18_0._urlFrame)

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0:GetResource(arg_18_0._urlFrame)
	local var_18_2 = SummonEnum.EquipFloatIconFrameNode
	local var_18_3 = gohelper.findChild(arg_18_0.effectGO, var_18_2)

	if var_18_3 then
		local var_18_4 = var_18_3:GetComponent(typeof(UnityEngine.MeshRenderer))

		if var_18_4 then
			var_18_4.material:SetTexture("_MainTex", var_18_1)
		end
	end
end

function var_0_0.unloadIcon(arg_19_0)
	if arg_19_0._headLoader then
		arg_19_0._headLoader:dispose()

		arg_19_0._headLoader = nil
	end

	local var_19_0 = SummonEnum.UIMaterialPath[arg_19_0.path]

	if not var_19_0 or #var_19_0 <= 0 then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_1 = gohelper.findChild(arg_19_0.effectGO, iter_19_1)

		if var_19_1 then
			local var_19_2 = var_19_1:GetComponent(typeof(UnityEngine.MeshRenderer))

			if var_19_2 then
				var_19_2.material:SetTexture("_MainTex", nil)
			end
		end
	end
end

function var_0_0.setSpeed(arg_20_0, arg_20_1)
	arg_20_0:checkInitSpeedComponents()
	arg_20_0._timeScaleComp:SetTimeScale(arg_20_1)
end

function var_0_0.checkInitSpeedComponents(arg_21_0)
	if gohelper.isNil(arg_21_0._timeScaleComp) then
		arg_21_0._timeScaleComp = gohelper.onceAddComponent(arg_21_0.effectGO, typeof(ZProj.EffectTimeScale))
	end
end

function var_0_0.markCanDestroy(arg_22_0)
	arg_22_0._canDestroy = true
end

function var_0_0.getIsActive(arg_23_0)
	return arg_23_0._active == true
end

function var_0_0.startParticle(arg_24_0)
	arg_24_0:checkInitParticle()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._particleList) do
		iter_24_1:Play()
	end
end

function var_0_0.stopParticle(arg_25_0)
	arg_25_0:checkInitParticle()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._particleList) do
		iter_25_1:Stop()
	end
end

function var_0_0.checkInitParticle(arg_26_0)
	if not arg_26_0._particleList then
		arg_26_0._particleList = arg_26_0:getUserDataTb_()

		if not gohelper.isNil(arg_26_0.effectGO) then
			local var_26_0 = arg_26_0.effectGO:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true):GetEnumerator()

			while var_26_0:MoveNext() do
				table.insert(arg_26_0._particleList, var_26_0.Current)
			end
		end
	end
end

function var_0_0.onDestroy(arg_27_0)
	if not arg_27_0._canDestroy then
		logError("Effect destroy unexpected: " .. arg_27_0.path)
	end

	arg_27_0.containerGO = nil
	arg_27_0.effectGO = nil
	arg_27_0.hangPointGO = nil
	arg_27_0._particleList = nil

	if arg_27_0._headLoader then
		arg_27_0._headLoader:dispose()

		arg_27_0._headLoader = nil
	end

	if arg_27_0._frameLoader then
		arg_27_0._frameLoader:dispose()

		arg_27_0._frameLoader = nil
	end
end

return var_0_0
