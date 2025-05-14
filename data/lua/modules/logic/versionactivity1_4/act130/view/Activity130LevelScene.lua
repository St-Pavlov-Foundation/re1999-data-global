module("modules.logic.versionactivity1_4.act130.view.Activity130LevelScene", package.seeall)

local var_0_0 = class("Activity130LevelScene", BaseView)

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

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("ActivityRole37Map")

	gohelper.addChild(var_5_0, arg_5_0._sceneRoot)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_addEvents()

	arg_6_0._sceneGos = arg_6_0:getUserDataTb_()

	MainCameraMgr.instance:addView(ViewName.Activity130LevelView, arg_6_0._initCamera, nil, arg_6_0)

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[3]
	local var_6_1 = arg_6_0:getResInst(var_6_0, arg_6_0._sceneRoot)

	table.insert(arg_6_0._sceneGos, var_6_1)
	gohelper.setActive(var_6_1, false)

	local var_6_2 = arg_6_0.viewContainer:getSetting().otherRes[4]
	local var_6_3 = arg_6_0:getResInst(var_6_2, arg_6_0._sceneRoot)

	table.insert(arg_6_0._sceneGos, var_6_3)
	gohelper.setActive(var_6_3, false)

	local var_6_4 = Activity130Model.instance:getMaxUnlockEpisode()

	if arg_6_0.viewParam and arg_6_0.viewParam.episodeId then
		var_6_4 = arg_6_0.viewParam.episodeId
	end

	Activity130Model.instance:setCurEpisodeId(var_6_4)

	local var_6_5 = VersionActivity1_4Enum.ActivityId.Role37
	local var_6_6 = var_6_4 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(var_6_5, var_6_4).lvscene

	gohelper.setActive(arg_6_0._sceneGos[var_6_6], true)
	transformhelper.setLocalPos(arg_6_0._sceneGos[var_6_6].transform, 0, 0, 0)

	arg_6_0._scene1Animator = arg_6_0._sceneGos[1]:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._scene1Animator:Play("open", 0, 0)

	arg_6_0._scene2Animator = arg_6_0._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._scene2Animator:Play("open", 0, 0)
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
		local var_9_0 = VersionActivity1_4Enum.ActivityId.Role37
		local var_9_1 = Activity130Model.instance:getCurEpisodeId()
		local var_9_2 = Activity130Config.instance:getActivity130EpisodeCo(var_9_0, var_9_1).lvscene

		gohelper.setActive(arg_9_0._sceneGos[2], var_9_2 == Activity130Enum.lvSceneType.Moon)
		gohelper.setActive(arg_9_0._sceneRoot, arg_9_1)
	end
end

function var_0_0._onSetScenePos(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._sceneGos) do
		transformhelper.setPosXY(iter_10_1.transform, arg_10_1, 0)
	end
end

function var_0_0._onBackToLevelView(arg_11_0)
	local var_11_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_11_1 = Activity130Model.instance:getCurEpisodeId()

	if var_11_1 == 0 then
		return
	end

	local var_11_2 = Activity130Config.instance:getActivity130EpisodeCo(var_11_0, var_11_1).lvscene

	gohelper.setActive(arg_11_0._sceneGos[2], var_11_2 == Activity130Enum.lvSceneType.Moon)

	if arg_11_0._sceneRoot then
		gohelper.setActive(arg_11_0._sceneRoot, true)
		arg_11_0._scene1Animator:Play("open", 0, 0)
		arg_11_0._scene2Animator:Play("open", 0, 0)
	end
end

function var_0_0.changeLvScene(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._sceneGos[arg_12_1], true)

	local var_12_0 = arg_12_0._sceneGos[2]:GetComponent(typeof(UnityEngine.Animator))

	if arg_12_1 == Activity130Enum.lvSceneType.Light then
		var_12_0:Play("tosun", 0, 0)
	else
		var_12_0:Play("tohaunghun", 0, 0)
	end
end

function var_0_0._addEvents(arg_13_0)
	arg_13_0:addEventCb(Activity130Controller.instance, Activity130Event.ShowLevelScene, arg_13_0._onSetSceneActive, arg_13_0)
	arg_13_0:addEventCb(Activity130Controller.instance, Activity130Event.BackToLevelView, arg_13_0._onBackToLevelView, arg_13_0)
	arg_13_0:addEventCb(Activity130Controller.instance, Activity130Event.SetScenePos, arg_13_0._onSetScenePos, arg_13_0)
end

function var_0_0._removeEvents(arg_14_0)
	arg_14_0:removeEventCb(Activity130Controller.instance, Activity130Event.ShowLevelScene, arg_14_0._onSetSceneActive, arg_14_0)
	arg_14_0:removeEventCb(Activity130Controller.instance, Activity130Event.BackToLevelView, arg_14_0._onBackToLevelView, arg_14_0)
	arg_14_0:removeEventCb(Activity130Controller.instance, Activity130Event.SetScenePos, arg_14_0._onSetScenePos, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._sceneRoot then
		gohelper.destroy(arg_15_0._sceneRoot)

		arg_15_0._sceneRoot = nil
	end
end

return var_0_0
