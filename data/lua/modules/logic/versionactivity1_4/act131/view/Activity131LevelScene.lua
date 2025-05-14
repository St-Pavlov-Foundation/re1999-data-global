module("modules.logic.versionactivity1_4.act131.view.Activity131LevelScene", package.seeall)

local var_0_0 = class("Activity131LevelScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateParam(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = CameraMgr.instance:getSceneRoot()

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("ActivityRole6Map")

	gohelper.addChild(var_5_0, arg_5_0._sceneRoot)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_addEvents()
	MainCameraMgr.instance:addView(ViewName.Activity131LevelView, arg_6_0._initCamera, nil, arg_6_0)

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[2]

	arg_6_0._sceneGo = arg_6_0:getResInst(var_6_0, arg_6_0._sceneRoot)

	local var_6_1 = Activity131Model.instance:getMaxUnlockEpisode()

	if arg_6_0.viewParam and arg_6_0.viewParam.episodeId then
		var_6_1 = arg_6_0.viewParam.episodeId
	end

	Activity131Model.instance:setCurEpisodeId(var_6_1)
	gohelper.setActive(arg_6_0._sceneGo, true)
	transformhelper.setLocalPos(arg_6_0._sceneGo.transform, 0, 0, 0)

	arg_6_0._sceneAnimator = arg_6_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._sceneAnimator:Play("open", 0, 0)

	if arg_6_0.viewParam and arg_6_0.viewParam.exitFromBattle then
		arg_6_0:_onSetSceneActive(false)
	end
end

function var_0_0._initCamera(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCamera()
	local var_7_1 = GameUtil.getAdapterScale(true)

	var_7_0.orthographic = true
	var_7_0.orthographicSize = 7.4 * var_7_1
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:_removeEvents()
end

function var_0_0._onSetSceneActive(arg_9_0, arg_9_1)
	if arg_9_0._sceneRoot then
		gohelper.setActive(arg_9_0._sceneRoot, arg_9_1)
	end
end

function var_0_0._onSetScenePos(arg_10_0, arg_10_1)
	transformhelper.setPosXY(arg_10_0._sceneRoot.transform, arg_10_1, 0)
end

function var_0_0._onBackToLevelView(arg_11_0)
	if arg_11_0._sceneRoot then
		gohelper.setActive(arg_11_0._sceneRoot, true)
		arg_11_0._sceneAnimator:Play("open", 0, 0)
	end
end

function var_0_0._addEvents(arg_12_0)
	arg_12_0:addEventCb(Activity131Controller.instance, Activity131Event.ShowLevelScene, arg_12_0._onSetSceneActive, arg_12_0)
	arg_12_0:addEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, arg_12_0._onBackToLevelView, arg_12_0)
	arg_12_0:addEventCb(Activity131Controller.instance, Activity131Event.SetScenePos, arg_12_0._onSetScenePos, arg_12_0)
end

function var_0_0._removeEvents(arg_13_0)
	arg_13_0:removeEventCb(Activity131Controller.instance, Activity131Event.ShowLevelScene, arg_13_0._onSetSceneActive, arg_13_0)
	arg_13_0:removeEventCb(Activity131Controller.instance, Activity131Event.BackToLevelView, arg_13_0._onBackToLevelView, arg_13_0)
	arg_13_0:removeEventCb(Activity131Controller.instance, Activity131Event.SetScenePos, arg_13_0._onSetScenePos, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	if arg_14_0._sceneRoot then
		gohelper.destroy(arg_14_0._sceneRoot)

		arg_14_0._sceneRoot = nil
	end
end

return var_0_0
