module("modules.logic.explore.map.unit.ExploreSceneAudioUnit", package.seeall)

slot0 = class("ExploreSceneAudioUnit", ExploreBaseDisplayUnit)

function slot0.onInit(slot0)
	uv0.super.onInit(slot0)
	gohelper.addAkGameObject(slot0.go)
end

function slot0.onHeroInitDone(slot0)
	uv0.super.onHeroInitDone(slot0)
	ExploreHelper.triggerAudio(tonumber(slot0.mo.specialDatas[1]), true, slot0.go, slot0.id)
end

function slot0.setInFOV(slot0)
end

function slot0.isInFOV(slot0)
	return true
end

function slot0.onDestroy(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	GameSceneMgr.instance:getCurScene().audio:stopAudioByUnit(slot0.id)
end

return slot0
