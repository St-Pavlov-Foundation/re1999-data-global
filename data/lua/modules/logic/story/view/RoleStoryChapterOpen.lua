module("modules.logic.story.view.RoleStoryChapterOpen", package.seeall)

local var_0_0 = class("RoleStoryChapterOpen", StoryActivityChapterBase)

function var_0_0._playTextAnim(arg_1_0)
	FrameTimerController.onDestroyViewMember(arg_1_0, "_txtFrameTimer")
	arg_1_0._txtTitleAnim:Stop()
	arg_1_0._txtTitleEnAnimClip:Stop()

	arg_1_0._txtFrameTimer = FrameTimerController.instance:register(arg_1_0._onPlayTextAnim, arg_1_0, 1, 1)

	arg_1_0._txtFrameTimer:Start()
end

function var_0_0._onPlayTextAnim(arg_2_0)
	arg_2_0._txtTitleAnim:Play()
	arg_2_0._txtTitleEnAnimClip:Play()
end

function var_0_0.onCtor(arg_3_0)
	arg_3_0.assetPath = "ui/viewres/story/rolestorychapteropen.prefab"
end

function var_0_0.onInitView(arg_4_0)
	arg_4_0._goBg = gohelper.findChild(arg_4_0.viewGO, "#go_bg")
	arg_4_0._txtTitle = gohelper.findChildTextMesh(arg_4_0._goBg, "#txt_Title")
	arg_4_0._txtTitleEn = gohelper.findChildTextMesh(arg_4_0._goBg, "#txt_TitleEn")
	arg_4_0._txtEpisode = gohelper.findChildTextMesh(arg_4_0._goBg, "#txt_Episode")
	arg_4_0._txtTitleGo = arg_4_0._txtTitle.gameObject
	arg_4_0._txtTitleEnGo = arg_4_0._txtTitleEn.gameObject
	arg_4_0._txtTitleAnim = arg_4_0._txtTitleGo:GetComponent(gohelper.Type_Animation)
	arg_4_0._txtTitleEnAnimClip = arg_4_0._txtTitleEnGo:GetComponent(gohelper.Type_Animation)
end

function var_0_0.onUpdateView(arg_5_0)
	local var_5_0 = arg_5_0.data

	arg_5_0._txtTitle.text = var_5_0.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	arg_5_0._txtTitleEn.text = var_5_0.navigateTxts[LanguageEnum.LanguageStoryType.EN]

	arg_5_0:_playTextAnim()

	arg_5_0._txtEpisode.text = var_5_0.navigateChapterEn
end

function var_0_0.onHide(arg_6_0)
	FrameTimerController.onDestroyViewMember(arg_6_0, "_txtFrameTimer")
end

function var_0_0.onDestory(arg_7_0)
	FrameTimerController.onDestroyViewMember(arg_7_0, "_txtFrameTimer")
	var_0_0.super.onDestory(arg_7_0)
end

return var_0_0
