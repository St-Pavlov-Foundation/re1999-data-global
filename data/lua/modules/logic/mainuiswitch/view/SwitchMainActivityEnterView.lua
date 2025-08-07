module("modules.logic.mainuiswitch.view.SwitchMainActivityEnterView", package.seeall)

local var_0_0 = class("SwitchMainActivityEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goGuideFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_guidefight")
	arg_1_0._goActivityFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_activityfight")
	arg_1_0._goNormalFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_normalfight")
	arg_1_0.btnGuideFight = gohelper.findButtonWithAudio(arg_1_0._goGuideFight)
	arg_1_0.btnNormalFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_fight")
	arg_1_0.btnJumpFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	arg_1_0.txtChapter = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/1/#txt_chapter")
	arg_1_0.txtChapter2 = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/2/#txt_chapter")
	arg_1_0.txtChapterName = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/1/#txt_chaptername")
	arg_1_0.txtChapterName2 = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/2/#txt_chaptername")
	arg_1_0.btnActivityFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	arg_1_0.btnEnterActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight")
	arg_1_0.simageActivityIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/icon")
	arg_1_0.imageActivityIcon = arg_1_0.simageActivityIcon:GetComponent(gohelper.Type_Image)
	arg_1_0.goActivityRedDot = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/#go_activityreddot")
	arg_1_0.pckeyNormalFight = gohelper.findChild(arg_1_0.btnNormalFight.gameObject, "#go_pcbtn")
	arg_1_0.pckeyActivityFight = gohelper.findChild(arg_1_0.btnEnterActivity.gameObject, "#go_pcbtn")
	arg_1_0.pckeyEnterFight = gohelper.findChild(arg_1_0.btnActivityFight.gameObject, "#go_pcbtn")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0:refreshShowFightGroupEnum()
	arg_6_0:refreshFightBtnGroup()
	arg_6_0:refreshFastEnterDungeonUI()
	arg_6_0:refreshActivityIcon()
end

function var_0_0.refreshActivityIcon(arg_7_0)
	if arg_7_0.showFightGroupEnum ~= MainActivityEnterView.ShowFightGroupEnum.Activity then
		return
	end

	arg_7_0.simageActivityIcon:LoadImage(ResUrl.getMainActivityIcon(ActivityEnum.MainIcon[arg_7_0.showActivityId]))

	if ActivityHelper.getActivityStatus(arg_7_0.showActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		arg_7_0.imageActivityIcon.color = MainActivityEnterView.notOpenColor

		gohelper.setAsFirstSibling(arg_7_0.btnEnterActivity.gameObject)
	else
		arg_7_0.imageActivityIcon.color = Color.white

		gohelper.setAsLastSibling(arg_7_0.btnEnterActivity.gameObject)
	end
end

function var_0_0.refreshFightBtnGroup(arg_8_0)
	gohelper.setActive(arg_8_0._goGuideFight, arg_8_0.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Guide)
	gohelper.setActive(arg_8_0._goNormalFight, arg_8_0.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Normal)
	gohelper.setActive(arg_8_0._goActivityFight, arg_8_0.showFightGroupEnum == MainActivityEnterView.ShowFightGroupEnum.Activity)
end

function var_0_0.refreshFastEnterDungeonUI(arg_9_0)
	if arg_9_0.showFightGroupEnum ~= MainActivityEnterView.ShowFightGroupEnum.Normal then
		arg_9_0._jumpParam = nil

		return
	end

	local var_9_0, var_9_1 = DungeonModel.instance:getLastEpisodeShowData()

	if var_9_0 then
		local var_9_2 = var_9_0.id

		if var_9_2 == arg_9_0._showEpisodeId then
			return
		end

		local var_9_3 = var_9_0.chapterId

		arg_9_0.txtChapter.text = DungeonController.getEpisodeName(var_9_0)
		arg_9_0.txtChapter2.text = DungeonController.getEpisodeName(var_9_0)
		arg_9_0.txtChapterName.text = var_9_0.name
		arg_9_0.txtChapterName2.text = var_9_0.name
		arg_9_0._showEpisodeId = var_9_2
	end
end

function var_0_0.refreshShowFightGroupEnum(arg_10_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		arg_10_0.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Guide

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		arg_10_0.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Normal

		return
	end

	for iter_10_0 = #ActivityEnum.VersionActivityIdList, 1, -1 do
		local var_10_0 = ActivityEnum.VersionActivityIdList[iter_10_0]
		local var_10_1 = ActivityHelper.getActivityStatus(var_10_0)

		if var_10_1 == ActivityEnum.ActivityStatus.Normal or var_10_1 == ActivityEnum.ActivityStatus.NotUnlock then
			arg_10_0.showActivityId = var_10_0
			arg_10_0.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Activity

			return
		end
	end

	arg_10_0.showFightGroupEnum = MainActivityEnterView.ShowFightGroupEnum.Normal
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0.simageActivityIcon:UnLoadImage()
end

return var_0_0
