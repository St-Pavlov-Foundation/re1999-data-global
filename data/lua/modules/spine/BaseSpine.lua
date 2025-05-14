module("modules.spine.BaseSpine", package.seeall)

local var_0_0 = class("BaseSpine", LuaCompBase)

var_0_0.BodyTrackIndex = 0
var_0_0.FaceTrackIndex = 1
var_0_0.MouthTrackIndex = 2
var_0_0.TransitionTrackIndex = 3

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gameObj = arg_1_1
	arg_1_0._gameTr = arg_1_1.transform
	arg_1_0._resLoader = SpinePrefabInstantiate.Create(arg_1_0._gameObj)
	arg_1_0._resPath = nil
	arg_1_0._skeletonComponent = nil
	arg_1_0._spineGo = nil
	arg_1_0._spineTr = nil
	arg_1_0._isLoop = false
	arg_1_0._lookDir = SpineLookDir.Left
	arg_1_0._bFreeze = false
	arg_1_0._actionCb = nil
	arg_1_0._actionCbObj = nil
	arg_1_0._resLoadedCb = nil
	arg_1_0._resLoadedCbObj = nil
	arg_1_0._videoList = {}
end

function var_0_0.setResPath(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not arg_2_1 then
		return
	end

	if arg_2_0._resPath == arg_2_1 and not gohelper.isNil(arg_2_0._spineGo) then
		if arg_2_2 then
			arg_2_2(arg_2_3)
		end

		return
	end

	arg_2_0:_clear()

	arg_2_0._resPath = arg_2_1
	arg_2_0._resLoadedCb = arg_2_2
	arg_2_0._resLoadedCbObj = arg_2_3

	if GameResMgr.IsFromEditorDir or arg_2_4 then
		arg_2_0._resLoader:startLoad(arg_2_0._resPath, arg_2_0._resPath, arg_2_0._onResLoaded, arg_2_0)
	else
		local var_2_0 = SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(arg_2_0._resPath))

		arg_2_0._resLoader:startLoad(var_2_0, arg_2_0._resPath, arg_2_0._onResLoaded, arg_2_0)
	end
end

function var_0_0.setHeroId(arg_3_0, arg_3_1)
	arg_3_0._heroId = arg_3_1
end

function var_0_0.setSkinId(arg_4_0, arg_4_1)
	arg_4_0._skinId = arg_4_1
end

function var_0_0.getResPath(arg_5_0)
	return arg_5_0._resPath
end

function var_0_0.doClear(arg_6_0)
	arg_6_0:_clear()
end

function var_0_0._clear(arg_7_0)
	if arg_7_0._resLoader then
		arg_7_0._resLoader:dispose()
	end

	if arg_7_0._roleEffectComp then
		arg_7_0._roleEffectComp:onDestroy()

		arg_7_0._roleEffectComp = nil
	end

	arg_7_0._skeletonComponent = nil
	arg_7_0._resPath = nil
	arg_7_0._spineGo = nil
	arg_7_0._spineTr = nil
	arg_7_0._bFreeze = false
	arg_7_0._effectGo = nil
	arg_7_0._renderer = nil
	arg_7_0._curBodyName = nil
end

function var_0_0.setInMainView(arg_8_0)
	arg_8_0._isInMainView = true
end

function var_0_0.isInMainView(arg_9_0)
	return arg_9_0._isInMainView
end

function var_0_0.isPlayingVoice(arg_10_0)
	return arg_10_0._spineVoice and arg_10_0._spineVoice:playing()
end

function var_0_0.getPlayVoiceStartTime(arg_11_0)
	return arg_11_0._spineVoice and arg_11_0._spineVoice:getPlayVoiceStartTime()
end

function var_0_0.playVoice(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	arg_12_0._spineVoice = arg_12_0._spineVoice or SpineVoice.New()

	arg_12_0._spineVoice:playVoice(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
end

function var_0_0.stopVoice(arg_13_0)
	if arg_13_0._spineVoice then
		arg_13_0._spineVoice:stopVoice()
	end
end

function var_0_0.setSwitch(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._spineVoice = arg_14_0._spineVoice or SpineVoice.New()

	arg_14_0._spineVoice:setSwitch(arg_14_0, arg_14_1, arg_14_2)
end

function var_0_0.getSpineVoice(arg_15_0)
	arg_15_0._spineVoice = arg_15_0._spineVoice or SpineVoice.New()

	return arg_15_0._spineVoice
end

function var_0_0.initSkeletonComponent(arg_16_0)
	return
end

function var_0_0.onAnimEventCallback(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0._actionCb then
		arg_17_0._actionCb(arg_17_0._actionCbObj, arg_17_1, arg_17_2, arg_17_3)
	end

	if arg_17_0._spineVoice then
		arg_17_0._spineVoice:onAnimationEvent(arg_17_1, arg_17_2, arg_17_3)
	end
end

function var_0_0.getSpineGo(arg_18_0)
	return arg_18_0._spineGo
end

function var_0_0.getRenderer(arg_19_0)
	if gohelper.isNil(arg_19_0._spineGo) then
		return nil
	end

	arg_19_0._renderer = arg_19_0._renderer or arg_19_0._spineGo:GetComponent(typeof(UnityEngine.Renderer))

	return arg_19_0._renderer
end

function var_0_0.getSpineTr(arg_20_0)
	return arg_20_0._spineTr
end

function var_0_0._onResLoaded(arg_21_0)
	arg_21_0._spineGo = arg_21_0._resLoader:getInstGO()
	arg_21_0._spineTr = arg_21_0._spineGo.transform
	arg_21_0._renderer = nil

	arg_21_0:_initRoleEffect()
	arg_21_0:_initFaceEffect()
	arg_21_0:initSkeletonComponent()
	arg_21_0:_changeLookDir()

	if arg_21_0._isStory then
		arg_21_0._spineGo:GetComponent(arg_21_0._animationEvent):SetAnimEventCallback(arg_21_0.onAnimEventCallback, arg_21_0)

		arg_21_0._curBodyName = arg_21_0._curBodyName or CharacterVoiceController.instance:getIdle(arg_21_0._heroId)
		arg_21_0._curFaceName = arg_21_0._curFaceName or StoryAnimName.E_ZhengChang

		arg_21_0:playStory(arg_21_0._curBodyName, arg_21_0._curFaceName)
	else
		arg_21_0._curBodyName = arg_21_0._curBodyName or SpineAnimState.idle1

		arg_21_0:setBodyAnimation(arg_21_0._curBodyName, true, 0.5)
	end

	if arg_21_0._resLoadedCb then
		arg_21_0._resLoadedCb(arg_21_0._resLoadedCbObj)
	end

	arg_21_0._resLoadedCb = nil
	arg_21_0._resLoadedCbObj = nil
end

function var_0_0._initRoleEffect(arg_22_0)
	local var_22_0
	local var_22_1

	arg_22_0._roleEffectComp, var_22_1 = arg_22_0:_getRoleEffectComp(arg_22_0._resPath)

	if arg_22_0._roleEffectComp then
		arg_22_0._roleEffectComp:setSpine(arg_22_0)
		arg_22_0._roleEffectComp:init(var_22_1)
	end
end

function var_0_0._getRoleEffectComp(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(lua_character_motion_effect.configList) do
		if string.find(arg_23_1, iter_23_1.heroResName) then
			local var_23_0 = iter_23_1.effectCompName

			return _G[var_23_0].New(), iter_23_1
		end
	end
end

function var_0_0._showBodyEffect(arg_24_0, arg_24_1)
	if arg_24_0._roleEffectComp then
		arg_24_0._roleEffectComp:showBodyEffect(arg_24_1)
	end
end

function var_0_0.play(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._curBodyName = arg_25_1

	arg_25_0:setBodyAnimation(arg_25_1, arg_25_2, 0.5)
end

function var_0_0.playStory(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._curBodyName = arg_26_1
	arg_26_0._curFaceName = arg_26_2

	if arg_26_1 ~= StoryAnimName.B_IDLE or arg_26_0:hasAnimation(arg_26_1) then
		arg_26_0:setBodyAnimation(arg_26_1, true, 0.5)
	end

	if arg_26_2 ~= StoryAnimName.E_ZhengChang or arg_26_0:hasAnimation(arg_26_2) then
		arg_26_0:setFaceAnimation(arg_26_2, true, 0.5)
	end
end

function var_0_0.setBodyAnimation(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0._curBodyName = arg_27_1

	arg_27_0:SetAnimation(var_0_0.BodyTrackIndex, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0:_showBodyEffect(arg_27_1)
end

function var_0_0.getCurBody(arg_28_0)
	return arg_28_0._curBodyName
end

function var_0_0.setFaceAnimation(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._curFaceName = arg_29_1

	arg_29_0:SetAnimation(var_0_0.FaceTrackIndex, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0:_showFaceEffect(arg_29_1)
end

function var_0_0._initFaceEffect(arg_30_0)
	local var_30_0
	local var_30_1

	arg_30_0._faceEffectComp, var_30_1 = arg_30_0:_getRoleFaceEffectComp(arg_30_0._resPath)

	if arg_30_0._faceEffectComp then
		arg_30_0._faceEffectComp:setSpine(arg_30_0)
		arg_30_0._faceEffectComp:init(var_30_1)
	end
end

function var_0_0._getRoleFaceEffectComp(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(lua_character_face_effect.configList) do
		if string.find(arg_31_1, iter_31_1.heroResName) then
			local var_31_0 = iter_31_1.effectCompName

			return _G[var_31_0].New(), iter_31_1
		end
	end
end

function var_0_0._showFaceEffect(arg_32_0, arg_32_1)
	if arg_32_0._faceEffectComp then
		arg_32_0._faceEffectComp:showFaceEffect(arg_32_1)
	end
end

function var_0_0.getCurFace(arg_33_0)
	return arg_33_0._curFaceName
end

function var_0_0.getCurMouth(arg_34_0)
	return arg_34_0._curMouthName
end

function var_0_0.setMouthAnimation(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0._curMouthName = arg_35_1

	arg_35_0:SetAnimation(var_0_0.MouthTrackIndex, arg_35_1, arg_35_2, arg_35_3)
end

function var_0_0.setTransition(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0:SetAnimation(var_0_0.TransitionTrackIndex, arg_36_1, arg_36_2, arg_36_3)
end

function var_0_0.SetAnimation(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if not arg_37_0._skeletonComponent then
		return
	end

	if arg_37_0:hasAnimation(arg_37_2) == false then
		return
	end

	arg_37_0._skeletonComponent:SetAnimation(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
end

function var_0_0.hasAnimation(arg_38_0, arg_38_1)
	return arg_38_0._skeletonComponent and arg_38_0._skeletonComponent:HasAnimation(arg_38_1)
end

function var_0_0.stopMouthAnimation(arg_39_0)
	if not arg_39_0._skeletonComponent then
		return
	end

	arg_39_0._skeletonComponent:SetEmptyAnimation(var_0_0.MouthTrackIndex, 0)
end

function var_0_0.stopTransition(arg_40_0)
	if not arg_40_0._skeletonComponent or gohelper.isNil(arg_40_0._spineGo) then
		return
	end

	arg_40_0._skeletonComponent:SetEmptyAnimation(var_0_0.TransitionTrackIndex, 0)
end

function var_0_0.setActionEventCb(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0._isStory then
		arg_41_0._actionCb = arg_41_1
		arg_41_0._actionCbObj = arg_41_2
	end
end

function var_0_0.changeLookDir(arg_42_0, arg_42_1)
	if arg_42_1 == arg_42_0._lookDir then
		return
	end

	arg_42_0._lookDir = arg_42_1

	arg_42_0:_changeLookDir()
end

function var_0_0._changeLookDir(arg_43_0)
	if not gohelper.isNil(arg_43_0._gameTr) and arg_43_0._skeletonComponent then
		arg_43_0._skeletonComponent:SetScaleX(arg_43_0._lookDir)
	end
end

function var_0_0.getLookDir(arg_44_0)
	return arg_44_0._lookDir
end

function var_0_0.onDestroy(arg_45_0)
	if arg_45_0._resLoader then
		arg_45_0._resLoader:onDestroy()

		arg_45_0._resLoader = nil
	end

	if arg_45_0._spineVoice then
		arg_45_0._spineVoice:onDestroy()

		arg_45_0._spineVoice = nil
	end

	if arg_45_0._roleEffectComp then
		arg_45_0._roleEffectComp:onDestroy()

		arg_45_0._roleEffectComp = nil
	end

	arg_45_0._gameObj = nil
	arg_45_0._resPath = nil
	arg_45_0._skeletonComponent = nil
	arg_45_0._spineGo = nil
	arg_45_0._renderer = nil
	arg_45_0._actionCb = nil
	arg_45_0._actionCbObj = nil
	arg_45_0._resLoadedCb = nil
	arg_45_0._resLoadedCbObj = nil
end

return var_0_0
