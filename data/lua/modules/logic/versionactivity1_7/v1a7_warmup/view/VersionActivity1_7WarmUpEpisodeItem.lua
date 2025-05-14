module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_7WarmUpEpisodeItem", UserDataDispose)

function var_0_0.onInit(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._go = arg_1_1
	arg_1_0._gopic = gohelper.findChild(arg_1_0._go, "pic")
	arg_1_0._golocked = gohelper.findChild(arg_1_0._go, "locked")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0._go, "normal")
	arg_1_0._goselect = gohelper.findChild(arg_1_0._go, "select")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0._go, "#btn_select")

	arg_1_0:addClickCb(arg_1_0._btnselect, arg_1_0.onClickSelect, arg_1_0)

	arg_1_0._animator = arg_1_0._go:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickSelect(arg_2_0)
	if arg_2_0.viewContainer:isPlayingDesc() then
		return
	end

	if not arg_2_0.episodeCo then
		return
	end

	if not Activity125Model.instance:isEpisodeReallyOpen(arg_2_0.activityId, arg_2_0.episodeId) then
		return
	end

	local var_2_0 = Activity125Model.instance:getSelectEpisodeId(arg_2_0.activityId)
	local var_2_1 = Activity125Model.instance:checkIsOldEpisode(arg_2_0.activityId, arg_2_0.episodeId)
	local var_2_2 = Activity125Model.instance:checkLocalIsPlay(arg_2_0.activityId, arg_2_0.episodeId)
	local var_2_3 = Activity125Model.instance:isEpisodeFinished(arg_2_0.activityId, arg_2_0.episodeId)

	if (var_2_1 or var_2_2 or var_2_3) and var_2_0 == arg_2_0.episodeId then
		return
	end

	Activity125Model.instance:setSelectEpisodeId(arg_2_0.activityId, arg_2_0.episodeId)

	if not var_2_1 then
		Activity125Model.instance:setOldEpisode(arg_2_0.activityId, arg_2_0.episodeId)
	end

	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function var_0_0.updateData(arg_3_0, arg_3_1)
	arg_3_0.episodeCo = arg_3_1

	arg_3_0:refreshItem()
end

function var_0_0.refreshItem(arg_4_0)
	if not arg_4_0.episodeCo then
		gohelper.setActive(arg_4_0._go, false)

		return
	end

	gohelper.setActive(arg_4_0._go, true)

	arg_4_0.activityId = arg_4_0.episodeCo.activityId
	arg_4_0.episodeId = arg_4_0.episodeCo.id

	local var_4_0 = Activity125Model.instance:isEpisodeReallyOpen(arg_4_0.activityId, arg_4_0.episodeId)

	if arg_4_0.episodeIsOpen == false and var_4_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_no_effect)
	end

	arg_4_0.episodeIsOpen = var_4_0

	if not var_4_0 then
		arg_4_0:playAnimation("locked")

		return
	end

	local var_4_1 = Activity125Model.instance:isEpisodeFinished(arg_4_0.activityId, arg_4_0.episodeId)
	local var_4_2 = Activity125Model.instance:getSelectEpisodeId(arg_4_0.activityId)
	local var_4_3 = Activity125Model.instance:checkLocalIsPlay(arg_4_0.activityId, arg_4_0.episodeId)
	local var_4_4 = Activity125Model.instance:checkIsOldEpisode(arg_4_0.activityId, arg_4_0.episodeId)

	if var_4_2 == arg_4_0.episodeId and (var_4_3 or var_4_1 or var_4_4) then
		arg_4_0:playAnimation("select")
	elseif var_4_3 then
		arg_4_0._animator:Play("finish", 0, 1)
	else
		arg_4_0:playAnimation("normal")
	end
end

function var_0_0.playAnimation(arg_5_0, arg_5_1)
	arg_5_0._animator:Play(arg_5_1)
end

function var_0_0.getPos(arg_6_0)
	return recthelper.getAnchorX(arg_6_0._go.transform)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:__onDispose()
end

return var_0_0
