module("modules.live2d.BaseLive2d", package.seeall)

local var_0_0 = class("BaseLive2d", LuaCompBase)

var_0_0.BodyTrackIndex = 0
var_0_0.FaceTrackIndex = 1
var_0_0.MouthTrackIndex = 2
var_0_0.TransitionTrackIndex = 3
var_0_0.enableMainInterfaceLight = false

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gameObj = arg_1_1
	arg_1_0._gameTr = arg_1_1.transform
	arg_1_0._resLoader = SpinePrefabInstantiate.Create(arg_1_0._gameObj)
	arg_1_0._resPath = nil
	arg_1_0._cubismController = nil
	arg_1_0._spineGo = nil
	arg_1_0._spineTr = nil
	arg_1_0._isLoop = false
	arg_1_0._lookDir = SpineLookDir.Left
	arg_1_0._bFreeze = false
	arg_1_0._actionCb = nil
	arg_1_0._actionCbObj = nil
	arg_1_0._resLoadedCb = nil
	arg_1_0._resLoadedCbObj = nil
end

function var_0_0.setResPath(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
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

	arg_2_0._resLoader:startLoad(arg_2_0._resPath, arg_2_0._resPath, arg_2_0._onResLoaded, arg_2_0)
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

	if arg_7_0._roleFaceComp then
		arg_7_0._roleFaceComp:onDestroy()

		arg_7_0._roleFaceComp = nil
	end

	arg_7_0._cubismController = nil
	arg_7_0._resPath = nil

	if arg_7_0._spineGo then
		Live2dMaskController.instance:removeLive2dGo(arg_7_0._spineGo)

		arg_7_0._spineGo = nil
	end

	arg_7_0._spineTr = nil
	arg_7_0._bFreeze = false
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
	return arg_10_0._live2dVoice and arg_10_0._live2dVoice:playing()
end

function var_0_0.getPlayVoiceStartTime(arg_11_0)
	return arg_11_0._live2dVoice and arg_11_0._live2dVoice:getPlayVoiceStartTime()
end

function var_0_0._initVoice(arg_12_0)
	arg_12_0._live2dVoice = arg_12_0._live2dVoice or Live2dVoice.New()
end

function var_0_0.playVoice(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_0:_initVoice()
	arg_13_0._live2dVoice:playVoice(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
end

function var_0_0.stopVoice(arg_14_0)
	if arg_14_0._live2dVoice then
		arg_14_0._live2dVoice:stopVoice()
	end
end

function var_0_0.setSwitch(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:_initVoice()
	arg_15_0._live2dVoice:setSwitch(arg_15_0, arg_15_1, arg_15_2)
end

function var_0_0.getSpineVoice(arg_16_0)
	arg_16_0:_initVoice()

	return arg_16_0._live2dVoice
end

function var_0_0.initSkeletonComponent(arg_17_0)
	arg_17_0._cubismController = arg_17_0._spineGo:GetComponent(typeof(ZProj.CubismController))
	arg_17_0._cubismMouthController = arg_17_0._spineGo:AddComponent(typeof(CubismMouthProxy))

	if arg_17_0._cubismController and var_0_0.enableMainInterfaceLight then
		arg_17_0._cubismController:SetMainColor(Color.white)
	end
end

function var_0_0.setAlwaysFade(arg_18_0, arg_18_1)
	if arg_18_0._cubismController then
		Live2dSpecialLogic.setAlwaysFade(arg_18_0._cubismController, arg_18_0._resPath, arg_18_1)
	end
end

function var_0_0.onAnimEventCallback(arg_19_0, arg_19_1)
	if arg_19_0._actionCb then
		arg_19_0._actionCb(arg_19_0._actionCbObj, arg_19_1, SpineAnimEvent.ActionComplete)
	end

	if arg_19_0._live2dVoice then
		arg_19_0._live2dVoice:onAnimationEvent(arg_19_1, SpineAnimEvent.ActionComplete)
	end
end

function var_0_0.getSpineGo(arg_20_0)
	return arg_20_0._spineGo
end

function var_0_0.getRenderer(arg_21_0)
	if gohelper.isNil(arg_21_0._spineGo) then
		return nil
	end

	arg_21_0._renderer = arg_21_0._renderer or arg_21_0._spineGo:GetComponentInChildren(typeof(UnityEngine.Renderer))

	return arg_21_0._renderer
end

function var_0_0.getSpineTr(arg_22_0)
	return arg_22_0._spineTr
end

function var_0_0._onResLoaded(arg_23_0)
	arg_23_0._spineGo = arg_23_0._resLoader:getInstGO()

	Live2dMaskController.instance:addLive2dGo(arg_23_0._spineGo)

	arg_23_0._spineTr = arg_23_0._spineGo.transform
	arg_23_0._renderer = nil

	arg_23_0:_initRoleEffect()
	arg_23_0:_initFaceEffect()
	arg_23_0:initSkeletonComponent()
	arg_23_0:_changeLookDir()

	if arg_23_0._isStory then
		arg_23_0._cubismController:SetAnimEventCallback(arg_23_0.onAnimEventCallback, arg_23_0)

		arg_23_0._curBodyName = arg_23_0._curBodyName or CharacterVoiceController.instance:getIdle(arg_23_0._heroId)
		arg_23_0._curFaceName = arg_23_0._curFaceName or StoryAnimName.E_ZhengChang

		arg_23_0:playStory(arg_23_0._curBodyName, arg_23_0._curFaceName)
	else
		arg_23_0._curBodyName = arg_23_0._curBodyName or SpineAnimState.idle1

		arg_23_0:setBodyAnimation(arg_23_0._curBodyName, true, 0.5)
	end

	if arg_23_0._resLoadedCb then
		arg_23_0._resLoadedCb(arg_23_0._resLoadedCbObj)
	end

	arg_23_0._resLoadedCb = nil
	arg_23_0._resLoadedCbObj = nil
end

function var_0_0._initRoleEffect(arg_24_0)
	local var_24_0
	local var_24_1

	arg_24_0._roleEffectComp, var_24_1 = arg_24_0:_getRoleEffectComp(arg_24_0._resPath)

	if arg_24_0._roleEffectComp then
		arg_24_0._roleEffectComp:setSpine(arg_24_0)
		arg_24_0._roleEffectComp:init(var_24_1)
	end
end

function var_0_0._getRoleEffectComp(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(lua_character_motion_effect.configList) do
		if string.find(arg_25_1, iter_25_1.heroResName) then
			local var_25_0 = iter_25_1.effectCompName

			return _G[var_25_0].New(), iter_25_1
		end
	end
end

function var_0_0._initFaceEffect(arg_26_0)
	local var_26_0
	local var_26_1

	arg_26_0._faceEffectComp, var_26_1 = arg_26_0:_getRoleFaceEffectComp(arg_26_0._resPath)

	if arg_26_0._faceEffectComp then
		arg_26_0._faceEffectComp:setSpine(arg_26_0)
		arg_26_0._faceEffectComp:init(var_26_1)
	end
end

function var_0_0._getRoleFaceEffectComp(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(lua_character_face_effect.configList) do
		if string.find(arg_27_1, iter_27_1.heroResName) then
			local var_27_0 = iter_27_1.effectCompName

			return _G[var_27_0].New(), iter_27_1
		end
	end
end

function var_0_0._showBodyEffect(arg_28_0, arg_28_1)
	if arg_28_0._roleEffectComp then
		arg_28_0._roleEffectComp:showBodyEffect(arg_28_1, arg_28_0._onBodyEffectShow, arg_28_0)
	end
end

function var_0_0._onBodyEffectShow(arg_29_0, arg_29_1)
	return
end

function var_0_0.showEverNodes(arg_30_0, arg_30_1)
	if arg_30_0._roleEffectComp and arg_30_0._roleEffectComp.showEverNodes then
		arg_30_0._roleEffectComp:showEverNodes(arg_30_1)
	end
end

function var_0_0.hasEverNodes(arg_31_0)
	return arg_31_0._roleEffectComp and arg_31_0._roleEffectComp.isShowEverEffect and arg_31_0._roleEffectComp:isShowEverEffect()
end

function var_0_0._showFaceEffect(arg_32_0, arg_32_1)
	if arg_32_0._faceEffectComp then
		arg_32_0._faceEffectComp:showFaceEffect(arg_32_1)
	end
end

function var_0_0.play(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._curBodyName = arg_33_1

	arg_33_0:setBodyAnimation(arg_33_1, arg_33_2, 0.5)
end

function var_0_0.playStory(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._curBodyName = arg_34_1
	arg_34_0._curFaceName = arg_34_2

	if arg_34_1 ~= StoryAnimName.B_IDLE or arg_34_0:hasAnimation(arg_34_1) then
		arg_34_0:setBodyAnimation(arg_34_1, true, 0.5)
	end

	if arg_34_2 ~= StoryAnimName.E_ZhengChang or arg_34_0:hasAnimation(arg_34_2) then
		arg_34_0:setFaceAnimation(arg_34_2, true, 0.5)
	end
end

function var_0_0.setBodyAnimation(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0._curBodyName = arg_35_1

	arg_35_0:_setBodyAnimation(var_0_0.BodyTrackIndex, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0:_showBodyEffect(arg_35_1)
end

function var_0_0.getCurBody(arg_36_0)
	return arg_36_0._curBodyName
end

function var_0_0.setFaceAnimation(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0._curFaceName = arg_37_1

	if gohelper.isNil(arg_37_0._cubismController) then
		return
	end

	arg_37_0._cubismController:PlayExpression(arg_37_1)
	arg_37_0:_showFaceEffect(arg_37_1)
end

function var_0_0.getCurFace(arg_38_0)
	return arg_38_0._curFaceName
end

function var_0_0.getCurMouth(arg_39_0)
	return arg_39_0._curMouthName
end

function var_0_0.setSortingOrder(arg_40_0, arg_40_1)
	if gohelper.isNil(arg_40_0._cubismController) then
		return
	end

	arg_40_0._cubismController.SortingOrder = arg_40_1
end

function var_0_0.setAlpha(arg_41_0, arg_41_1)
	if gohelper.isNil(arg_41_0._cubismController) then
		return
	end

	arg_41_0._cubismController:SetAlpha(arg_41_1)
end

function var_0_0.setSceneTexture(arg_42_0, arg_42_1)
	if gohelper.isNil(arg_42_0._cubismController) then
		return
	end

	arg_42_0._cubismController:SetSceneTexture(arg_42_1)
end

function var_0_0.setUIMaskKeyword(arg_43_0, arg_43_1)
	if gohelper.isNil(arg_43_0._cubismController) then
		return
	end

	arg_43_0._cubismController:SetUIMaskKeyword(arg_43_1)
end

function var_0_0.enableSceneAlpha(arg_44_0)
	if gohelper.isNil(arg_44_0._cubismController) then
		return
	end

	arg_44_0._cubismController:SetSceneAlphaKeyword(true)
end

function var_0_0.disableSceneAlpha(arg_45_0)
	if gohelper.isNil(arg_45_0._cubismController) then
		return
	end

	arg_45_0._cubismController:SetSceneAlphaKeyword(false)
end

function var_0_0.SetDark(arg_46_0)
	if gohelper.isNil(arg_46_0._cubismController) then
		return
	end

	arg_46_0._cubismController:SetColorFactor(0.6)
end

function var_0_0.SetBright(arg_47_0)
	if gohelper.isNil(arg_47_0._cubismController) then
		return
	end

	arg_47_0._cubismController:SetColorFactor(1)
end

function var_0_0.setMouthAnimation(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_0._curMouthName = arg_48_1

	arg_48_0:SetAnimation(var_0_0.MouthTrackIndex, arg_48_1, arg_48_2, arg_48_3)
end

function var_0_0.setTransition(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	arg_49_0:SetAnimation(var_0_0.TransitionTrackIndex, arg_49_1, arg_49_2, arg_49_3)
end

function var_0_0.SetAnimation(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	if gohelper.isNil(arg_50_0._cubismController) then
		return
	end

	if arg_50_0:hasAnimation(arg_50_2) == false then
		return
	end

	if arg_50_1 <= var_0_0.MouthTrackIndex then
		arg_50_0._cubismController:PlayAnimation(arg_50_2, arg_50_3, 1, arg_50_1)
	end
end

function var_0_0._setBodyAnimation(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if gohelper.isNil(arg_51_0._cubismController) then
		return
	end

	if arg_51_0:hasAnimation(arg_51_2) == false then
		return
	end

	if arg_51_1 <= var_0_0.MouthTrackIndex then
		arg_51_0._cubismController:PlayAnimation(arg_51_2, arg_51_3, arg_51_4 == 0 and 0 or 1, arg_51_1)
	end
end

function var_0_0.hasAnimation(arg_52_0, arg_52_1)
	return not gohelper.isNil(arg_52_0._cubismController) and arg_52_0._cubismController:HasAnimation(arg_52_1)
end

function var_0_0.hasExpression(arg_53_0, arg_53_1)
	return not gohelper.isNil(arg_53_0._cubismController) and arg_53_0._cubismController:HasExpression(arg_53_1)
end

function var_0_0.setParameterStoreEnabled(arg_54_0, arg_54_1)
	return not gohelper.isNil(arg_54_0._cubismController) and arg_54_0._cubismController:SetParameterStoreEnabled(arg_54_1)
end

function var_0_0.stopMouthAnimation(arg_55_0)
	if gohelper.isNil(arg_55_0._cubismController) then
		return
	end

	arg_55_0._cubismController:StopAnimation(var_0_0.MouthTrackIndex)
end

function var_0_0.stopTransition(arg_56_0)
	if gohelper.isNil(arg_56_0._cubismController) then
		return
	end

	arg_56_0._cubismController:StopAnimation(var_0_0.TransitionTrackIndex)
end

function var_0_0.setActionEventCb(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0._isStory then
		arg_57_0._actionCb = arg_57_1
		arg_57_0._actionCbObj = arg_57_2
	end
end

function var_0_0.changeLookDir(arg_58_0, arg_58_1)
	if arg_58_1 == arg_58_0._lookDir then
		return
	end

	arg_58_0._lookDir = arg_58_1

	arg_58_0:_changeLookDir()
end

function var_0_0._changeLookDir(arg_59_0)
	return
end

function var_0_0.getLookDir(arg_60_0)
	return arg_60_0._lookDir
end

function var_0_0.getMouthController(arg_61_0)
	return arg_61_0._cubismMouthController
end

function var_0_0.onDestroy(arg_62_0)
	if arg_62_0._resLoader then
		arg_62_0._resLoader:onDestroy()

		arg_62_0._resLoader = nil
	end

	if arg_62_0._live2dVoice then
		arg_62_0._live2dVoice:onDestroy()

		arg_62_0._live2dVoice = nil
	end

	if arg_62_0._roleEffectComp then
		arg_62_0._roleEffectComp:onDestroy()

		arg_62_0._roleEffectComp = nil
	end

	if arg_62_0._roleFaceComp then
		arg_62_0._roleFaceComp:onDestroy()

		arg_62_0._roleFaceComp = nil
	end

	arg_62_0._gameObj = nil
	arg_62_0._resPath = nil
	arg_62_0._cubismController = nil
	arg_62_0._cubismMouthController = nil

	if arg_62_0._spineGo then
		Live2dMaskController.instance:removeLive2dGo(arg_62_0._spineGo)

		arg_62_0._spineGo = nil
	end

	arg_62_0._renderer = nil
	arg_62_0._actionCb = nil
	arg_62_0._actionCbObj = nil
	arg_62_0._resLoadedCb = nil
	arg_62_0._resLoadedCbObj = nil
end

return var_0_0
