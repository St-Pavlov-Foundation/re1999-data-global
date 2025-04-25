module("modules.spine.BaseSpine", package.seeall)

slot0 = class("BaseSpine", LuaCompBase)
slot0.BodyTrackIndex = 0
slot0.FaceTrackIndex = 1
slot0.MouthTrackIndex = 2
slot0.TransitionTrackIndex = 3

function slot0.init(slot0, slot1)
	slot0._gameObj = slot1
	slot0._gameTr = slot1.transform
	slot0._resLoader = SpinePrefabInstantiate.Create(slot0._gameObj)
	slot0._resPath = nil
	slot0._skeletonComponent = nil
	slot0._spineGo = nil
	slot0._spineTr = nil
	slot0._isLoop = false
	slot0._lookDir = SpineLookDir.Left
	slot0._bFreeze = false
	slot0._actionCb = nil
	slot0._actionCbObj = nil
	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
	slot0._videoList = {}
end

function slot0.setResPath(slot0, slot1, slot2, slot3, slot4)
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

	if GameResMgr.IsFromEditorDir or slot4 then
		slot0._resLoader:startLoad(slot0._resPath, slot0._resPath, slot0._onResLoaded, slot0)
	else
		slot0._resLoader:startLoad(SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(slot0._resPath)), slot0._resPath, slot0._onResLoaded, slot0)
	end
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

	slot0._skeletonComponent = nil
	slot0._resPath = nil
	slot0._spineGo = nil
	slot0._spineTr = nil
	slot0._bFreeze = false
	slot0._effectGo = nil
	slot0._renderer = nil
	slot0._curBodyName = nil
end

function slot0.setInMainView(slot0)
	slot0._isInMainView = true
end

function slot0.isInMainView(slot0)
	return slot0._isInMainView
end

function slot0.isPlayingVoice(slot0)
	return slot0._spineVoice and slot0._spineVoice:playing()
end

function slot0.getPlayVoiceStartTime(slot0)
	return slot0._spineVoice and slot0._spineVoice:getPlayVoiceStartTime()
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._spineVoice = slot0._spineVoice or SpineVoice.New()

	slot0._spineVoice:playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.stopVoice(slot0)
	if slot0._spineVoice then
		slot0._spineVoice:stopVoice()
	end
end

function slot0.setSwitch(slot0, slot1, slot2)
	slot0._spineVoice = slot0._spineVoice or SpineVoice.New()

	slot0._spineVoice:setSwitch(slot0, slot1, slot2)
end

function slot0.getSpineVoice(slot0)
	slot0._spineVoice = slot0._spineVoice or SpineVoice.New()

	return slot0._spineVoice
end

function slot0.initSkeletonComponent(slot0)
end

function slot0.onAnimEventCallback(slot0, slot1, slot2, slot3)
	if slot0._actionCb then
		slot0._actionCb(slot0._actionCbObj, slot1, slot2, slot3)
	end

	if slot0._spineVoice then
		slot0._spineVoice:onAnimationEvent(slot1, slot2, slot3)
	end
end

function slot0.getSpineGo(slot0)
	return slot0._spineGo
end

function slot0.getRenderer(slot0)
	if gohelper.isNil(slot0._spineGo) then
		return nil
	end

	slot0._renderer = slot0._renderer or slot0._spineGo:GetComponent(typeof(UnityEngine.Renderer))

	return slot0._renderer
end

function slot0.getSpineTr(slot0)
	return slot0._spineTr
end

function slot0._onResLoaded(slot0)
	slot0._spineGo = slot0._resLoader:getInstGO()
	slot0._spineTr = slot0._spineGo.transform
	slot0._renderer = nil

	slot0:_initRoleEffect()
	slot0:_initFaceEffect()
	slot0:initSkeletonComponent()
	slot0:_changeLookDir()

	if slot0._isStory then
		slot0._spineGo:GetComponent(slot0._animationEvent):SetAnimEventCallback(slot0.onAnimEventCallback, slot0)

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

function slot0._showBodyEffect(slot0, slot1)
	if slot0._roleEffectComp then
		slot0._roleEffectComp:showBodyEffect(slot1)
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

	slot0:SetAnimation(uv0.BodyTrackIndex, slot1, slot2, slot3)
	slot0:_showBodyEffect(slot1)
end

function slot0.getCurBody(slot0)
	return slot0._curBodyName
end

function slot0.setFaceAnimation(slot0, slot1, slot2, slot3)
	slot0._curFaceName = slot1

	slot0:SetAnimation(uv0.FaceTrackIndex, slot1, slot2, slot3)
	slot0:_showFaceEffect(slot1)
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

function slot0._showFaceEffect(slot0, slot1)
	if slot0._faceEffectComp then
		slot0._faceEffectComp:showFaceEffect(slot1)
	end
end

function slot0.getCurFace(slot0)
	return slot0._curFaceName
end

function slot0.getCurMouth(slot0)
	return slot0._curMouthName
end

function slot0.setMouthAnimation(slot0, slot1, slot2, slot3)
	slot0._curMouthName = slot1

	slot0:SetAnimation(uv0.MouthTrackIndex, slot1, slot2, slot3)
end

function slot0.setTransition(slot0, slot1, slot2, slot3)
	slot0:SetAnimation(uv0.TransitionTrackIndex, slot1, slot2, slot3)
end

function slot0.SetAnimation(slot0, slot1, slot2, slot3, slot4)
	if not slot0._skeletonComponent then
		return
	end

	if slot0:hasAnimation(slot2) == false then
		return
	end

	slot0._skeletonComponent:SetAnimation(slot1, slot2, slot3, slot4)
end

function slot0.hasAnimation(slot0, slot1)
	return slot0._skeletonComponent and slot0._skeletonComponent:HasAnimation(slot1)
end

function slot0.stopMouthAnimation(slot0)
	if not slot0._skeletonComponent then
		return
	end

	slot0._skeletonComponent:SetEmptyAnimation(uv0.MouthTrackIndex, 0)
end

function slot0.stopTransition(slot0)
	if not slot0._skeletonComponent or gohelper.isNil(slot0._spineGo) then
		return
	end

	slot0._skeletonComponent:SetEmptyAnimation(uv0.TransitionTrackIndex, 0)
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
	if not gohelper.isNil(slot0._gameTr) and slot0._skeletonComponent then
		slot0._skeletonComponent:SetScaleX(slot0._lookDir)
	end
end

function slot0.getLookDir(slot0)
	return slot0._lookDir
end

function slot0.onDestroy(slot0)
	if slot0._resLoader then
		slot0._resLoader:onDestroy()

		slot0._resLoader = nil
	end

	if slot0._spineVoice then
		slot0._spineVoice:onDestroy()

		slot0._spineVoice = nil
	end

	if slot0._roleEffectComp then
		slot0._roleEffectComp:onDestroy()

		slot0._roleEffectComp = nil
	end

	slot0._gameObj = nil
	slot0._resPath = nil
	slot0._skeletonComponent = nil
	slot0._spineGo = nil
	slot0._renderer = nil
	slot0._actionCb = nil
	slot0._actionCbObj = nil
	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
end

return slot0
