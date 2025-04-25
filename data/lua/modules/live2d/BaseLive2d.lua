module("modules.live2d.BaseLive2d", package.seeall)

slot0 = class("BaseLive2d", LuaCompBase)
slot0.BodyTrackIndex = 0
slot0.FaceTrackIndex = 1
slot0.MouthTrackIndex = 2
slot0.TransitionTrackIndex = 3
slot0.enableMainInterfaceLight = false

function slot0.init(slot0, slot1)
	slot0._gameObj = slot1
	slot0._gameTr = slot1.transform
	slot0._resLoader = SpinePrefabInstantiate.Create(slot0._gameObj)
	slot0._resPath = nil
	slot0._cubismController = nil
	slot0._spineGo = nil
	slot0._spineTr = nil
	slot0._isLoop = false
	slot0._lookDir = SpineLookDir.Left
	slot0._bFreeze = false
	slot0._actionCb = nil
	slot0._actionCbObj = nil
	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
end

function slot0.setResPath(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if slot0._resPath == slot1 and not gohelper.isNil(slot0._spineGo) then
		if slot2 then
			slot2(slot3)
		end

		return
	end

	slot0:_clear()

	slot0._resPath = slot1
	slot0._resLoadedCb = slot2
	slot0._resLoadedCbObj = slot3

	slot0._resLoader:startLoad(slot0._resPath, slot0._resPath, slot0._onResLoaded, slot0)
end

function slot0.setHeroId(slot0, slot1)
	slot0._heroId = slot1
end

function slot0.setSkinId(slot0, slot1)
	slot0._skinId = slot1
end

function slot0.getResPath(slot0)
	return slot0._resPath
end

function slot0.doClear(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	if slot0._resLoader then
		slot0._resLoader:dispose()
	end

	if slot0._roleEffectComp then
		slot0._roleEffectComp:onDestroy()

		slot0._roleEffectComp = nil
	end

	if slot0._roleFaceComp then
		slot0._roleFaceComp:onDestroy()

		slot0._roleFaceComp = nil
	end

	slot0._cubismController = nil
	slot0._resPath = nil

	if slot0._spineGo then
		Live2dMaskController.instance:removeLive2dGo(slot0._spineGo)

		slot0._spineGo = nil
	end

	slot0._spineTr = nil
	slot0._bFreeze = false
	slot0._renderer = nil
	slot0._curBodyName = nil
end

function slot0.isPlayingVoice(slot0)
	return slot0._live2dVoice and slot0._live2dVoice:playing()
end

function slot0.getPlayVoiceStartTime(slot0)
	return slot0._live2dVoice and slot0._live2dVoice:getPlayVoiceStartTime()
end

function slot0._initVoice(slot0)
	slot0._live2dVoice = slot0._live2dVoice or Live2dVoice.New()
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:_initVoice()
	slot0._live2dVoice:playVoice(slot0, slot1, slot2, slot3, slot4, slot5)
end

function slot0.stopVoice(slot0)
	if slot0._live2dVoice then
		slot0._live2dVoice:stopVoice()
	end
end

function slot0.setSwitch(slot0, slot1, slot2)
	slot0:_initVoice()
	slot0._live2dVoice:setSwitch(slot0, slot1, slot2)
end

function slot0.getSpineVoice(slot0)
	slot0:_initVoice()

	return slot0._live2dVoice
end

function slot0.initSkeletonComponent(slot0)
	slot0._cubismController = slot0._spineGo:GetComponent(typeof(ZProj.CubismController))
	slot0._cubismMouthController = slot0._spineGo:AddComponent(typeof(CubismMouthProxy))

	if slot0._cubismController and uv0.enableMainInterfaceLight then
		slot0._cubismController:SetMainColor(Color.white)
	end
end

function slot0.setAlwaysFade(slot0, slot1)
	if slot0._cubismController then
		Live2dSpecialLogic.setAlwaysFade(slot0._cubismController, slot0._resPath, slot1)
	end
end

function slot0.onAnimEventCallback(slot0, slot1)
	if slot0._actionCb then
		slot0._actionCb(slot0._actionCbObj, slot1, SpineAnimEvent.ActionComplete)
	end

	if slot0._live2dVoice then
		slot0._live2dVoice:onAnimationEvent(slot1, SpineAnimEvent.ActionComplete)
	end
end

function slot0.getSpineGo(slot0)
	return slot0._spineGo
end

function slot0.getRenderer(slot0)
	if gohelper.isNil(slot0._spineGo) then
		return nil
	end

	slot0._renderer = slot0._renderer or slot0._spineGo:GetComponentInChildren(typeof(UnityEngine.Renderer))

	return slot0._renderer
end

function slot0.getSpineTr(slot0)
	return slot0._spineTr
end

function slot0._onResLoaded(slot0)
	slot0._spineGo = slot0._resLoader:getInstGO()

	Live2dMaskController.instance:addLive2dGo(slot0._spineGo)

	slot0._spineTr = slot0._spineGo.transform
	slot0._renderer = nil

	slot0:_initRoleEffect()
	slot0:_initFaceEffect()
	slot0:initSkeletonComponent()
	slot0:_changeLookDir()

	if slot0._isStory then
		slot0._cubismController:SetAnimEventCallback(slot0.onAnimEventCallback, slot0)

		slot0._curBodyName = slot0._curBodyName or CharacterVoiceController.instance:getIdle(slot0._heroId)
		slot0._curFaceName = slot0._curFaceName or StoryAnimName.E_ZhengChang

		slot0:playStory(slot0._curBodyName, slot0._curFaceName)
	else
		slot0._curBodyName = slot0._curBodyName or SpineAnimState.idle1

		slot0:setBodyAnimation(slot0._curBodyName, true, 0.5)
	end

	if slot0._resLoadedCb then
		slot0._resLoadedCb(slot0._resLoadedCbObj)
	end

	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
end

function slot0._initRoleEffect(slot0)
	slot1 = nil
	slot0._roleEffectComp, slot1 = slot0:_getRoleEffectComp(slot0._resPath)

	if slot0._roleEffectComp then
		slot0._roleEffectComp:setSpine(slot0)
		slot0._roleEffectComp:init(slot1)
	end
end

function slot0._getRoleEffectComp(slot0, slot1)
	for slot5, slot6 in ipairs(lua_character_motion_effect.configList) do
		if string.find(slot1, slot6.heroResName) then
			return _G[slot6.effectCompName].New(), slot6
		end
	end
end

function slot0._initFaceEffect(slot0)
	slot1 = nil
	slot0._faceEffectComp, slot1 = slot0:_getRoleFaceEffectComp(slot0._resPath)

	if slot0._faceEffectComp then
		slot0._faceEffectComp:setSpine(slot0)
		slot0._faceEffectComp:init(slot1)
	end
end

function slot0._getRoleFaceEffectComp(slot0, slot1)
	for slot5, slot6 in ipairs(lua_character_face_effect.configList) do
		if string.find(slot1, slot6.heroResName) then
			return _G[slot6.effectCompName].New(), slot6
		end
	end
end

function slot0._showBodyEffect(slot0, slot1)
	if slot0._roleEffectComp then
		slot0._roleEffectComp:showBodyEffect(slot1, slot0._onBodyEffectShow, slot0)
	end
end

function slot0._onBodyEffectShow(slot0, slot1)
end

function slot0.showEverNodes(slot0, slot1)
	if slot0._roleEffectComp and slot0._roleEffectComp.showEverNodes then
		slot0._roleEffectComp:showEverNodes(slot1)
	end
end

function slot0._showFaceEffect(slot0, slot1)
	if slot0._faceEffectComp then
		slot0._faceEffectComp:showFaceEffect(slot1)
	end
end

function slot0.play(slot0, slot1, slot2)
	slot0._curBodyName = slot1

	slot0:setBodyAnimation(slot1, slot2, 0.5)
end

function slot0.playStory(slot0, slot1, slot2)
	slot0._curBodyName = slot1
	slot0._curFaceName = slot2

	if slot1 ~= StoryAnimName.B_IDLE or slot0:hasAnimation(slot1) then
		slot0:setBodyAnimation(slot1, true, 0.5)
	end

	if slot2 ~= StoryAnimName.E_ZhengChang or slot0:hasAnimation(slot2) then
		slot0:setFaceAnimation(slot2, true, 0.5)
	end
end

function slot0.setBodyAnimation(slot0, slot1, slot2, slot3)
	slot0._curBodyName = slot1

	slot0:_setBodyAnimation(uv0.BodyTrackIndex, slot1, slot2, slot3)
	slot0:_showBodyEffect(slot1)
end

function slot0.getCurBody(slot0)
	return slot0._curBodyName
end

function slot0.setFaceAnimation(slot0, slot1, slot2, slot3)
	slot0._curFaceName = slot1

	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:PlayExpression(slot1)
	slot0:_showFaceEffect(slot1)
end

function slot0.getCurFace(slot0)
	return slot0._curFaceName
end

function slot0.getCurMouth(slot0)
	return slot0._curMouthName
end

function slot0.setSortingOrder(slot0, slot1)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController.SortingOrder = slot1
end

function slot0.setAlpha(slot0, slot1)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetAlpha(slot1)
end

function slot0.setSceneTexture(slot0, slot1)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetSceneTexture(slot1)
end

function slot0.setUIMaskKeyword(slot0, slot1)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetUIMaskKeyword(slot1)
end

function slot0.enableSceneAlpha(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetSceneAlphaKeyword(true)
end

function slot0.disableSceneAlpha(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetSceneAlphaKeyword(false)
end

function slot0.SetDark(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetColorFactor(0.6)
end

function slot0.SetBright(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:SetColorFactor(1)
end

function slot0.setMouthAnimation(slot0, slot1, slot2, slot3)
	slot0._curMouthName = slot1

	slot0:SetAnimation(uv0.MouthTrackIndex, slot1, slot2, slot3)
end

function slot0.setTransition(slot0, slot1, slot2, slot3)
	slot0:SetAnimation(uv0.TransitionTrackIndex, slot1, slot2, slot3)
end

function slot0.SetAnimation(slot0, slot1, slot2, slot3, slot4)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	if slot0:hasAnimation(slot2) == false then
		return
	end

	if slot1 <= uv0.MouthTrackIndex then
		slot0._cubismController:PlayAnimation(slot2, slot3, 1, slot1)
	end
end

function slot0._setBodyAnimation(slot0, slot1, slot2, slot3, slot4)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	if slot0:hasAnimation(slot2) == false then
		return
	end

	if slot1 <= uv0.MouthTrackIndex then
		slot0._cubismController:PlayAnimation(slot2, slot3, slot4 == 0 and 0 or 1, slot1)
	end
end

function slot0.hasAnimation(slot0, slot1)
	return not gohelper.isNil(slot0._cubismController) and slot0._cubismController:HasAnimation(slot1)
end

function slot0.hasExpression(slot0, slot1)
	return not gohelper.isNil(slot0._cubismController) and slot0._cubismController:HasExpression(slot1)
end

function slot0.setParameterStoreEnabled(slot0, slot1)
	return not gohelper.isNil(slot0._cubismController) and slot0._cubismController:SetParameterStoreEnabled(slot1)
end

function slot0.stopMouthAnimation(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:StopAnimation(uv0.MouthTrackIndex)
end

function slot0.stopTransition(slot0)
	if gohelper.isNil(slot0._cubismController) then
		return
	end

	slot0._cubismController:StopAnimation(uv0.TransitionTrackIndex)
end

function slot0.setActionEventCb(slot0, slot1, slot2)
	if slot0._isStory then
		slot0._actionCb = slot1
		slot0._actionCbObj = slot2
	end
end

function slot0.changeLookDir(slot0, slot1)
	if slot1 == slot0._lookDir then
		return
	end

	slot0._lookDir = slot1

	slot0:_changeLookDir()
end

function slot0._changeLookDir(slot0)
end

function slot0.getLookDir(slot0)
	return slot0._lookDir
end

function slot0.getMouthController(slot0)
	return slot0._cubismMouthController
end

function slot0.onDestroy(slot0)
	if slot0._resLoader then
		slot0._resLoader:onDestroy()

		slot0._resLoader = nil
	end

	if slot0._live2dVoice then
		slot0._live2dVoice:onDestroy()

		slot0._live2dVoice = nil
	end

	if slot0._roleEffectComp then
		slot0._roleEffectComp:onDestroy()

		slot0._roleEffectComp = nil
	end

	if slot0._roleFaceComp then
		slot0._roleFaceComp:onDestroy()

		slot0._roleFaceComp = nil
	end

	slot0._gameObj = nil
	slot0._resPath = nil
	slot0._cubismController = nil
	slot0._cubismMouthController = nil

	if slot0._spineGo then
		Live2dMaskController.instance:removeLive2dGo(slot0._spineGo)

		slot0._spineGo = nil
	end

	slot0._renderer = nil
	slot0._actionCb = nil
	slot0._actionCbObj = nil
	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
end

return slot0
