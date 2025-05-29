module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEnterView", package.seeall)

local var_0_0 = class("DiceHeroEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtLockTxt = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/image_TryBtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._onLockClick, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._clickTrial, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a6DiceHero)

	local var_4_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.DiceHero)

	gohelper.setActive(arg_4_0._btnEnter, var_4_0)
	gohelper.setActive(arg_4_0._btnLocked, not var_4_0)

	if not var_4_0 then
		local var_4_1 = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.DiceHero).episodeId
		local var_4_2 = DungeonConfig.instance:getEpisodeDisplay(var_4_1)

		arg_4_0._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), var_4_2)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.config = ActivityConfig.instance:getActivityCo(VersionActivity2_6Enum.ActivityId.DiceHero)
	arg_5_0._txtDescr.text = arg_5_0.config.actDesc
end

function var_0_0._onEnterClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

function var_0_0._clickTrial(arg_7_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_6Enum.ActivityId.DiceHero) == ActivityEnum.ActivityStatus.Normal then
		local var_7_0 = arg_7_0.config.tryoutEpisode

		if var_7_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)

		DungeonFightController.instance:enterFight(var_7_1.chapterId, var_7_0)
	else
		arg_7_0:_onLockClick()
	end
end

function var_0_0.everySecondCall(arg_8_0)
	arg_8_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_6Enum.ActivityId.DiceHero)
end

function var_0_0._onLockClick(arg_9_0)
	local var_9_0, var_9_1 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.DiceHero)

	if var_9_0 and var_9_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_9_0, var_9_1)
	end
end

return var_0_0
