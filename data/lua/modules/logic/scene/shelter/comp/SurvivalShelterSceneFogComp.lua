module("modules.logic.scene.shelter.comp.SurvivalShelterSceneFogComp", package.seeall)

local var_0_0 = class("SurvivalShelterSceneFogComp", BaseSceneComp)

var_0_0.FogResPath = "survival/common/survialfog.prefab"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene().level:getSceneGo()
	arg_2_0._fogRoot = gohelper.create3d(arg_2_0._sceneGo, "FogRoot")

	local var_2_0 = SurvivalMapHelper.instance:getBlockRes(var_0_0.FogResPath)

	if not var_2_0 then
		return
	end

	local var_2_1 = gohelper.findChild(arg_2_0._sceneGo, "virtualCameraXZ/ocean")

	arg_2_0._rainGo = gohelper.create3d(var_2_1, "survival_rain")
	arg_2_0._rainTrans = arg_2_0._rainGo and arg_2_0._rainGo.transform
	arg_2_0._fogGo = gohelper.clone(var_2_0, arg_2_0._fogRoot)
	arg_2_0._fogComp = arg_2_0._fogGo:GetComponent(typeof(ZProj.SurvivalFog))
	arg_2_0._rainEntity = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._fogGo, SurvivalRainEntity, {
		effectRoot = arg_2_0._rainGo,
		onLoadedFunc = arg_2_0.onRainLoaded,
		callBackContext = arg_2_0
	})

	local var_2_2 = SurvivalShelterModel.instance:getWeekInfo()

	arg_2_0._rainEntity:setCurRain(var_2_2.rainType)
	arg_2_0:setFogSize()
	arg_2_0:setRainEnable(true)
end

function var_0_0.onRainLoaded(arg_3_0)
	arg_3_0:dispatchEvent(SurvivalEvent.OnSurvivalFogLoaded)
end

function var_0_0.setRainEnable(arg_4_0, arg_4_1)
	if not arg_4_0._fogComp then
		return
	end

	arg_4_0:setFogEnable(false)

	if not arg_4_1 then
		arg_4_0._nowCircle = nil

		return
	end

	local var_4_0 = SurvivalConfig.instance:getCurShelterMapId()
	local var_4_1 = lua_survival_shelter.configDict[var_4_0]
	local var_4_2 = string.splitToNumber(var_4_1.stormCenter, "#")
	local var_4_3 = SurvivalHexNode.New(var_4_2[1], var_4_2[2])

	arg_4_0:setRainDis(var_4_3, var_4_1.stormArea)
end

function var_0_0.setFogSize(arg_5_0)
	if not arg_5_0._fogComp then
		return
	end

	local var_5_0 = SurvivalConfig.instance:getShelterMapCo()

	arg_5_0._fogComp:SetCenterAndSize(var_5_0.maxX - var_5_0.minX + 1, var_5_0.maxY - var_5_0.minY + 1, (var_5_0.maxX + var_5_0.minX) / 2, (var_5_0.maxY + var_5_0.minY) / 2)
	arg_5_0._fogComp:UpdateBoudingBoxData()
end

function var_0_0.setBlockStatu(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0._fogComp then
		return
	end

	if arg_6_2 ~= nil then
		arg_6_0._fogComp:SetClearFogFlag(arg_6_1, not arg_6_2)
	end
end

function var_0_0.setFogEnable(arg_7_0, arg_7_1)
	if not arg_7_0._fogComp then
		return
	end

	arg_7_0._fogComp:SetFogToggle(arg_7_1)
end

function var_0_0.setRainDis(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._fogComp then
		return
	end

	arg_8_0.centerPos = arg_8_1

	if arg_8_0._nowCircle == arg_8_2 then
		return
	end

	if not arg_8_0._nowCircle then
		arg_8_0:frameSetCircle(arg_8_2)
	else
		arg_8_0:killCirCleTween()

		arg_8_0._circleTweenId = ZProj.TweenHelper.DOTweenFloat(arg_8_0._nowCircle, arg_8_2, SurvivalConst.PlayerMoveSpeed * math.abs(arg_8_0._nowCircle - arg_8_2), arg_8_0.frameSetCircle, nil, arg_8_0)
	end

	arg_8_0._nowCircle = arg_8_2
end

function var_0_0.killCirCleTween(arg_9_0)
	if arg_9_0._circleTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._circleTweenId)

		arg_9_0._circleTweenId = nil
	end
end

function var_0_0.frameSetCircle(arg_10_0, arg_10_1)
	arg_10_0._fogComp:SetRainHex(arg_10_0.centerPos.q, arg_10_0.centerPos.r, arg_10_0.centerPos.s, arg_10_1)
end

function var_0_0.updateTexture(arg_11_0)
	if not arg_11_0._fogComp then
		return
	end

	arg_11_0._fogComp:UpdateTexture()
end

function var_0_0.updateCenterPos(arg_12_0, arg_12_1)
	if not arg_12_0._rainTrans then
		return
	end

	local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0._rainTrans)

	transformhelper.setLocalPos(arg_12_0._rainTrans, arg_12_1.x, var_12_1, arg_12_1.z)
end

function var_0_0.onSceneClose(arg_13_0)
	arg_13_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_13_0._onPreloadFinish, arg_13_0)
	arg_13_0:killCirCleTween()

	if arg_13_0._fogGo then
		gohelper.destroy(arg_13_0._fogGo)

		arg_13_0._fogGo = nil
		arg_13_0._fogComp = nil
	end

	if arg_13_0._fogRoot then
		gohelper.destroy(arg_13_0._fogRoot)

		arg_13_0._fogRoot = nil
	end

	arg_13_0._sceneGo = nil
	arg_13_0._rainGo = nil
	arg_13_0._rainTrans = nil
	arg_13_0._nowCircle = nil

	if arg_13_0._rainEntity then
		arg_13_0._rainEntity:onDestroy()

		arg_13_0._rainEntity = nil
	end
end

return var_0_0
