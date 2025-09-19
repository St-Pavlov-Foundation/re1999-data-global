module("modules.logic.scene.survival.comp.SurvivalSceneFogComp", package.seeall)

local var_0_0 = class("SurvivalSceneFogComp", BaseSceneComp)

var_0_0.FogResPath = "survival/common/survialfog.prefab"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._fogEnabled = true

	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene().level:getSceneGo()
	arg_2_0._fogRoot = gohelper.create3d(arg_2_0._sceneGo, "FogRoot")
	arg_2_0._rainGo = gohelper.findChild(arg_2_0._sceneGo, "virtualCameraXZ/ocean/survival_rain")
	arg_2_0._rainTrans = arg_2_0._rainGo and arg_2_0._rainGo.transform

	local var_2_0 = SurvivalMapHelper.instance:getBlockRes(var_0_0.FogResPath)

	if not var_2_0 then
		return
	end

	arg_2_0._fogGo = gohelper.clone(var_2_0, arg_2_0._fogRoot)
	arg_2_0._fogComp = arg_2_0._fogGo:GetComponent(typeof(ZProj.SurvivalFog))

	arg_2_0:setFogSize()
	arg_2_0:setRainDis()

	if not arg_2_0._fogEnabled then
		arg_2_0:setFogEnable(false)
	end
end

function var_0_0.setFogSize(arg_3_0)
	if not arg_3_0._fogComp then
		return
	end

	local var_3_0 = SurvivalMapModel.instance:getCurMapCo()

	arg_3_0._fogComp:SetCenterAndSize(var_3_0.maxX - var_3_0.minX + 1, var_3_0.maxY - var_3_0.minY + 1, (var_3_0.maxX + var_3_0.minX) / 2, (var_3_0.maxY + var_3_0.minY) / 2)
	arg_3_0._fogComp:UpdateBoudingBoxData()
end

function var_0_0.setBlockStatu(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._fogComp then
		return
	end

	if arg_4_2 ~= nil then
		arg_4_0._fogComp:SetClearFogFlag(arg_4_1, not arg_4_2)
	end
end

function var_0_0.setFogEnable(arg_5_0, arg_5_1)
	arg_5_0._fogEnabled = arg_5_1

	if not arg_5_0._fogComp then
		return
	end

	arg_5_0._fogComp:SetFogToggle(arg_5_1)
	gohelper.setActive(arg_5_0._fogComp, arg_5_1)

	if not arg_5_1 then
		arg_5_0:killCirCleTween()
	end
end

function var_0_0.setRainDis(arg_6_0)
	if not arg_6_0._fogComp then
		return
	end

	local var_6_0 = SurvivalMapModel.instance:getSceneMo()

	if arg_6_0._nowCircle == var_6_0.circle then
		return
	end

	arg_6_0:killCirCleTween()

	if not arg_6_0._nowCircle or not arg_6_0._fogEnabled then
		arg_6_0:frameSetCircle(var_6_0.circle)

		if not arg_6_0._fogEnabled then
			arg_6_0:setFogEnable(false)
		end
	else
		arg_6_0._circleTweenId = ZProj.TweenHelper.DOTweenFloat(arg_6_0._nowCircle, var_6_0.circle, SurvivalEnum.MoveSpeed * math.abs(arg_6_0._nowCircle - var_6_0.circle), arg_6_0.frameSetCircle, nil, arg_6_0)
	end

	arg_6_0._nowCircle = var_6_0.circle
end

function var_0_0.killCirCleTween(arg_7_0)
	if arg_7_0._circleTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._circleTweenId)

		arg_7_0._circleTweenId = nil
	end
end

function var_0_0.frameSetCircle(arg_8_0, arg_8_1)
	local var_8_0 = SurvivalMapModel.instance:getSceneMo()

	arg_8_0._fogComp:SetRainHex(var_8_0.exitPos.q, var_8_0.exitPos.r, var_8_0.exitPos.s, arg_8_1)
end

function var_0_0.updateTexture(arg_9_0)
	if not arg_9_0._fogComp then
		return
	end

	arg_9_0._fogComp:UpdateTexture()
end

function var_0_0.updateCenterPos(arg_10_0, arg_10_1)
	if not arg_10_0._rainTrans then
		return
	end

	local var_10_0, var_10_1, var_10_2 = transformhelper.getLocalPos(arg_10_0._rainTrans)

	transformhelper.setLocalPos(arg_10_0._rainTrans, arg_10_1.x, var_10_1, arg_10_1.z)
end

function var_0_0.onSceneClose(arg_11_0)
	arg_11_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_11_0._onPreloadFinish, arg_11_0)
	arg_11_0:killCirCleTween()

	if arg_11_0._fogGo then
		gohelper.destroy(arg_11_0._fogGo)

		arg_11_0._fogGo = nil
		arg_11_0._fogComp = nil
	end

	if arg_11_0._fogRoot then
		gohelper.destroy(arg_11_0._fogRoot)

		arg_11_0._fogRoot = nil
	end

	arg_11_0._sceneGo = nil
	arg_11_0._rainGo = nil
	arg_11_0._rainTrans = nil
	arg_11_0._nowCircle = nil
end

return var_0_0
