module("modules.logic.scene.survival.comp.SurvivalSceneFogComp", package.seeall)

local var_0_0 = class("SurvivalSceneFogComp", BaseSceneComp)

var_0_0.FogResPath = "survival/common/survialfog.prefab"
var_0_0.OnLoaded = 1

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._fogEnabled = true

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

	local var_2_2 = SurvivalMapModel.instance:getSceneMo()
	local var_2_3 = var_2_2._mapInfo.rainCo and var_2_2._mapInfo.rainCo.type or 1

	arg_2_0._rainEntity:setCurRain(var_2_3)
	arg_2_0:setFogSize()
	arg_2_0:setRainDis()

	if not arg_2_0._fogEnabled then
		arg_2_0:setFogEnable(false)
	end
end

function var_0_0.onRainLoaded(arg_3_0)
	arg_3_0:dispatchEvent(SurvivalEvent.OnSurvivalFogLoaded)
end

function var_0_0.setFogSize(arg_4_0)
	if not arg_4_0._fogComp then
		return
	end

	local var_4_0 = SurvivalMapModel.instance:getCurMapCo()

	arg_4_0._fogComp:SetCenterAndSize(var_4_0.maxX - var_4_0.minX + 1, var_4_0.maxY - var_4_0.minY + 1, (var_4_0.maxX + var_4_0.minX) / 2, (var_4_0.maxY + var_4_0.minY) / 2)
	arg_4_0._fogComp:UpdateBoudingBoxData()
end

function var_0_0.setBlockStatu(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._fogComp then
		return
	end

	if arg_5_2 ~= nil then
		arg_5_0._fogComp:SetClearFogFlag(arg_5_1, not arg_5_2)
	end
end

function var_0_0.setFogEnable(arg_6_0, arg_6_1)
	arg_6_0._fogEnabled = arg_6_1

	if not arg_6_0._fogComp then
		return
	end

	arg_6_0._fogComp:SetFogToggle(arg_6_1)
	gohelper.setActive(arg_6_0._fogComp, arg_6_1)

	if not arg_6_1 then
		local var_6_0 = SurvivalMapModel.instance:getSceneMo()

		if var_6_0 then
			arg_6_0:frameSetCircle(var_6_0.circle)
		end
	end

	if not arg_6_1 then
		arg_6_0:killCirCleTween()
	end
end

function var_0_0.setRainDis(arg_7_0)
	if not arg_7_0._fogComp then
		return
	end

	local var_7_0 = SurvivalMapModel.instance:getSceneMo()

	if arg_7_0._nowCircle == var_7_0.circle then
		return
	end

	arg_7_0:killCirCleTween()

	if not arg_7_0._nowCircle or not arg_7_0._fogEnabled then
		arg_7_0:frameSetCircle(var_7_0.circle)

		if not arg_7_0._fogEnabled then
			arg_7_0:setFogEnable(false)
		end
	else
		arg_7_0._circleTweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0._nowCircle, var_7_0.circle, SurvivalConst.PlayerMoveSpeed * math.abs(arg_7_0._nowCircle - var_7_0.circle), arg_7_0.frameSetCircle, nil, arg_7_0)
	end

	arg_7_0._nowCircle = var_7_0.circle
end

function var_0_0.killCirCleTween(arg_8_0)
	if arg_8_0._circleTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._circleTweenId)

		arg_8_0._circleTweenId = nil
	end
end

function var_0_0.frameSetCircle(arg_9_0, arg_9_1)
	local var_9_0 = SurvivalMapModel.instance:getSceneMo()

	arg_9_0._fogComp:SetRainHex(var_9_0.exitPos.q, var_9_0.exitPos.r, var_9_0.exitPos.s, arg_9_1)
end

function var_0_0.updateTexture(arg_10_0)
	if not arg_10_0._fogComp then
		return
	end

	arg_10_0._fogComp:UpdateTexture()
end

function var_0_0.updateCenterPos(arg_11_0, arg_11_1)
	if not arg_11_0._rainTrans then
		return
	end

	local var_11_0, var_11_1, var_11_2 = transformhelper.getLocalPos(arg_11_0._rainTrans)

	transformhelper.setLocalPos(arg_11_0._rainTrans, arg_11_1.x, var_11_1, arg_11_1.z)
end

function var_0_0.onSceneClose(arg_12_0)
	arg_12_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_12_0._onPreloadFinish, arg_12_0)
	arg_12_0:killCirCleTween()

	if arg_12_0._fogGo then
		gohelper.destroy(arg_12_0._fogGo)

		arg_12_0._fogGo = nil
		arg_12_0._fogComp = nil
	end

	if arg_12_0._fogRoot then
		gohelper.destroy(arg_12_0._fogRoot)

		arg_12_0._fogRoot = nil
	end

	arg_12_0._sceneGo = nil
	arg_12_0._rainGo = nil
	arg_12_0._rainTrans = nil
	arg_12_0._nowCircle = nil

	if arg_12_0._rainEntity then
		arg_12_0._rainEntity:onDestroy()

		arg_12_0._rainEntity = nil
	end
end

return var_0_0
