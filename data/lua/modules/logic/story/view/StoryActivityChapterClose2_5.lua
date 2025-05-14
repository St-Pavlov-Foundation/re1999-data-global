module("modules.logic.story.view.StoryActivityChapterClose2_5", package.seeall)

local var_0_0 = class("StoryActivityChapterClose2_5", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a5/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goEnd = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/end")
	arg_2_0.goContinued = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/continue")
	arg_2_0.simageBg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_FullBG/simagebg")
	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = tonumber(arg_3_0.data) == 2
	local var_3_1 = tonumber(arg_3_0.data) == 3
	local var_3_2 = tonumber(arg_3_0.data) == 4

	if var_3_0 then
		arg_3_0._anim:Play("close1", 0, 0)
	elseif var_3_1 then
		arg_3_0._anim:Play("close2", 0, 0)
	elseif var_3_2 then
		arg_3_0._anim:Play("close3", 0, 0)
	else
		arg_3_0._anim:Play("close", 0, 0)
	end

	gohelper.setActive(arg_3_0.goEnd, var_3_0 or var_3_2)
	gohelper.setActive(arg_3_0.goContinued, not var_3_0 and not var_3_1)

	arg_3_0._audioId = arg_3_0:getAudioId(tonumber(arg_3_0.data))

	arg_3_0.simageBg:LoadImage(string.format("singlebg/v2a5_opening_singlebg/.jpg", var_3_0 and "end_bg" or "continued_bg"))
	arg_3_0:_playAudio()
end

function var_0_0.getAudioId(arg_4_0, arg_4_1)
	if arg_4_1 == 3 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_special_close
	end

	if arg_4_1 == 1 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_small_close
	end
end

function var_0_0._playAudio(arg_5_0)
	if arg_5_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_5_0._audioId)
	end
end

function var_0_0.onHide(arg_6_0)
	if arg_6_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_6_0._audioId)

		arg_6_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_7_0)
	if arg_7_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_7_0._audioId)

		arg_7_0._audioId = nil
	end

	arg_7_0.simageBg:UnLoadImage()
	var_0_0.super.onDestory(arg_7_0)
end

return var_0_0
