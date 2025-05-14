module("modules.logic.explore.map.unit.ExploreSceneAudioUnit", package.seeall)

local var_0_0 = class("ExploreSceneAudioUnit", ExploreBaseDisplayUnit)

function var_0_0.onInit(arg_1_0)
	var_0_0.super.onInit(arg_1_0)
	gohelper.addAkGameObject(arg_1_0.go)
end

function var_0_0.onHeroInitDone(arg_2_0)
	var_0_0.super.onHeroInitDone(arg_2_0)

	local var_2_0 = tonumber(arg_2_0.mo.specialDatas[1])

	ExploreHelper.triggerAudio(var_2_0, true, arg_2_0.go, arg_2_0.id)
end

function var_0_0.setInFOV(arg_3_0)
	return
end

function var_0_0.isInFOV(arg_4_0)
	return true
end

function var_0_0.onDestroy(arg_5_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	GameSceneMgr.instance:getCurScene().audio:stopAudioByUnit(arg_5_0.id)
end

return var_0_0
