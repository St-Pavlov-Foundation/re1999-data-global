module("modules.logic.story.view.StoryActivityChapterClose2_0", package.seeall)

local var_0_0 = class("StoryActivityChapterClose2_0", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a0/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simageIcon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_FullBG/title")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = tonumber(arg_3_0.data) == 2

	arg_3_0._audioId = AudioEnum.Story.play_ui_feichi_closing

	if not var_3_0 then
		arg_3_0._simageIcon:LoadImage("singlebg_lang/txt_v2a0_opening_singlebg/continued.png")
	else
		arg_3_0._simageIcon:LoadImage("singlebg_lang/txt_v2a0_opening_singlebg/end.png")
	end

	arg_3_0:_playAudio()
end

function var_0_0._playAudio(arg_4_0)
	if arg_4_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_4_0._audioId)
	end
end

function var_0_0.onHide(arg_5_0)
	if arg_5_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_5_0._audioId)

		arg_5_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_6_0)
	if arg_6_0._simageIcon then
		arg_6_0._simageIcon:UnLoadImage()
	end

	if arg_6_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_6_0._audioId)

		arg_6_0._audioId = nil
	end

	var_0_0.super.onDestory(arg_6_0)
end

return var_0_0
