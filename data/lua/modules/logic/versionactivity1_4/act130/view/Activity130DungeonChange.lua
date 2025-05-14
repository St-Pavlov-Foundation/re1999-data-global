module("modules.logic.versionactivity1_4.act130.view.Activity130DungeonChange", package.seeall)

local var_0_0 = class("Activity130DungeonChange", BaseView)

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
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_addEvents()

	arg_6_0._changeRoot = gohelper.findChild(arg_6_0.viewGO, "#go_dungeonchange")

	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[2]

	arg_6_0._changeGo = arg_6_0:getResInst(var_6_0, arg_6_0._changeRoot)
	arg_6_0._changeAnimator = arg_6_0._changeGo:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._changeAnimatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0._changeGo)

	gohelper.setActive(arg_6_0._changeRoot, false)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0._onNewUnlockChangeLevelScene(arg_8_0)
	local var_8_0 = Activity130Model.instance:getNewUnlockEpisode()

	if var_8_0 > -1 then
		arg_8_0:_onChangeLevelScene(var_8_0)
	end
end

function var_0_0._onChangeLevelScene(arg_9_0, arg_9_1)
	local var_9_0 = Activity130Model.instance:getCurEpisodeId()

	if var_9_0 > 4 and arg_9_1 > 4 then
		return
	end

	if var_9_0 < 5 and arg_9_1 < 5 then
		return
	end

	local var_9_1 = VersionActivity1_4Enum.ActivityId.Role37
	local var_9_2 = var_9_0 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(var_9_1, var_9_0).lvscene

	arg_9_0._toSceneType = arg_9_1 < 1 and Activity130Enum.lvSceneType.Light or Activity130Config.instance:getActivity130EpisodeCo(var_9_1, arg_9_1).lvscene

	gohelper.setActive(arg_9_0._changeRoot, true)

	if arg_9_0._toSceneType == Activity130Enum.lvSceneType.Light then
		arg_9_0._changeAnimator:Play("to_sun", 0, 0)

		if arg_9_0._toSceneType ~= var_9_2 then
			TaskDispatcher.runDelay(arg_9_0._startChangeScene, arg_9_0, 0.17)
		end
	elseif arg_9_0._toSceneType == Activity130Enum.lvSceneType.Moon then
		arg_9_0._changeAnimator:Play("to_moon", 0, 0)

		if arg_9_0._toSceneType ~= var_9_2 then
			TaskDispatcher.runDelay(arg_9_0._startChangeScene, arg_9_0, 0.17)
		end
	end
end

function var_0_0._startChangeScene(arg_10_0)
	arg_10_0.viewContainer:changeLvScene(arg_10_0._toSceneType)
	TaskDispatcher.runDelay(arg_10_0._aniFinished, arg_10_0, 0.83)
end

function var_0_0._aniFinished(arg_11_0)
	gohelper.setActive(arg_11_0._changeRoot, false)
end

function var_0_0._addEvents(arg_12_0)
	return
end

function var_0_0._removeEvents(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:_removeEvents()
end

return var_0_0
