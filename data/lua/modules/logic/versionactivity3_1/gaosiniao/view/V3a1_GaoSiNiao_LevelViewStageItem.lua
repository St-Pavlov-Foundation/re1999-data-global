local var_0_0 = SLFramework.AnimatorPlayer

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_LevelViewStageItem", package.seeall)

local var_0_1 = class("V3a1_GaoSiNiao_LevelViewStageItem", RougeSimpleItemBase)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._txtstageNum = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/#txt_stageNum")
	arg_1_0._goBattle = gohelper.findChild(arg_1_0.viewGO, "unlock/info/LayoutGroup/#go_Battle")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.viewGO, "unlock/info/LayoutGroup/#txt_stagename")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "unlock/info/LayoutGroup/#go_star")
	arg_1_0._goCurrent = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_Current")
	arg_1_0._goFinished = gohelper.findChild(arg_1_0.viewGO, "unlock/#go_Finished")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "unlock/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_1._btnclickOnClick(arg_4_0)
	arg_4_0:parent():onStageItemClick(arg_4_0)
end

function var_0_1.ctor(arg_5_0, arg_5_1)
	var_0_1.super.ctor(arg_5_0, arg_5_1)
end

function var_0_1.addEventListeners(arg_6_0)
	var_0_1.super.addEventListeners(arg_6_0)
end

function var_0_1.removeEventListeners(arg_7_0)
	var_0_1.super.removeEventListeners(arg_7_0)
end

function var_0_1.onDestroyView(arg_8_0)
	var_0_1.super.onDestroyView(arg_8_0)
end

function var_0_1._getUserDataTb_goMark(arg_9_0)
	local var_9_0 = arg_9_0:getUserDataTb_()
	local var_9_1 = "#go_Mark%s"
	local var_9_2 = 0

	repeat
		var_9_2 = var_9_2 + 1

		local var_9_3 = gohelper.findChild(arg_9_0._goFinished, string.format(var_9_1, var_9_2))
		local var_9_4 = gohelper.isNil(var_9_3)

		if not var_9_4 then
			table.insert(var_9_0, var_9_3)
			gohelper.setActive(var_9_3, false)
		end
	until var_9_4

	return var_9_0
end

function var_0_1._editableInitView(arg_10_0)
	arg_10_0._hasGo = gohelper.findChild(arg_10_0._gostar, "star1/has")
	arg_10_0._noGo = gohelper.findChild(arg_10_0._gostar, "star1/no")
	arg_10_0._image_FinishedGo = gohelper.findChild(arg_10_0._goFinished, "image_Finished")
	arg_10_0._goMarkList = arg_10_0:_getUserDataTb_goMark()
	arg_10_0._animatorPlayer_goMarkList = arg_10_0:getUserDataTb_()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._goMarkList) do
		table.insert(arg_10_0._animatorPlayer_goMarkList, var_0_0.Get(iter_10_1))
	end

	gohelper.setActive(arg_10_0._goBattle, false)
	arg_10_0:setActive_goCurrent(false)
	arg_10_0:_setDisactive(false)

	arg_10_0._animatorPlayer = var_0_0.Get(arg_10_0.viewGO)
end

function var_0_1._setPassed(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._hasGo, arg_11_1)
	gohelper.setActive(arg_11_0._noGo, not arg_11_1)
end

function var_0_1.episodeId(arg_12_0)
	return arg_12_0._mo.episodeId
end

function var_0_1.isEpisodeOpen(arg_13_0)
	return arg_13_0:baseViewContainer():isEpisodeOpen(arg_13_0:episodeId())
end

function var_0_1.hasPlayedUnlockedAnimPath(arg_14_0)
	return arg_14_0:baseViewContainer():hasPlayedUnlockedAnimPath(arg_14_0:episodeId())
end

function var_0_1.hasPassLevelAndStory(arg_15_0)
	return arg_15_0:baseViewContainer():hasPassLevelAndStory(arg_15_0:episodeId())
end

function var_0_1.getPreEpisodeId(arg_16_0)
	return arg_16_0:baseViewContainer():getPreEpisodeId(arg_16_0:episodeId())
end

function var_0_1.setData(arg_17_0, arg_17_1)
	var_0_1.super.setData(arg_17_0, arg_17_1)

	local var_17_0 = arg_17_1
	local var_17_1 = var_17_0.gameId > 0
	local var_17_2 = arg_17_0:hasPassLevelAndStory()

	arg_17_0._txtstageNum.text = string.format("%02d", arg_17_0:index())
	arg_17_0._txtstagename.text = var_17_0.name

	gohelper.setActive(arg_17_0._goBattle, var_17_1)
	arg_17_0:_setPassed(var_17_2)
end

function var_0_1.setActive_goCurrent(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goCurrent, arg_18_1)
end

function var_0_1._setDisactive(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0:_setPassed(false)
	end

	gohelper.setActive(arg_19_0._goFinished, arg_19_1)
end

function var_0_1.setActive_goMark(arg_20_0, arg_20_1)
	if not arg_20_1 then
		arg_20_0:_setDisactive(false)

		return
	end

	local var_20_0 = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._goMarkList) do
		gohelper.setActive(iter_20_1, iter_20_0 == arg_20_1)

		if iter_20_0 == arg_20_1 then
			var_20_0 = true
		end
	end

	arg_20_0:_setDisactive(var_20_0)
end

function var_0_1._playAnim(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._animatorPlayer:Play(arg_21_1, arg_21_2 or function()
		return
	end, arg_21_3)
end

function var_0_1._playAnim_goFinished(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._animatorPlayer_goFinished:Play(arg_23_1, arg_23_2 or function()
		return
	end, arg_23_3)
end

function var_0_1.playAnim_Open(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:setActive(true)
	arg_25_0:_playAnim(UIAnimationName.Open, arg_25_1, arg_25_2)
end

function var_0_1.playAnim_Idle(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:setActive(true)
	arg_26_0:_playAnim(UIAnimationName.Idle, arg_26_1, arg_26_2)
end

function var_0_1.playAnim_MarkFinish(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0:setActive_goMark(arg_27_1)

	local var_27_0 = arg_27_0._animatorPlayer_goMarkList[arg_27_1]

	if not var_27_0 then
		if arg_27_2 then
			arg_27_2(arg_27_3)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_lock)
	var_27_0:Play(UIAnimationName.Finish, arg_27_2 or function()
		return
	end, arg_27_3)
end

function var_0_1.playAnim_MarkIdle(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0:setActive_goMark(arg_29_1)

	local var_29_0 = arg_29_0._animatorPlayer_goMarkList[arg_29_1]

	if not var_29_0 then
		if arg_29_2 then
			arg_29_2(arg_29_3)
		end

		return
	end

	var_29_0:Play(UIAnimationName.Idle, arg_29_2 or function()
		return
	end, arg_29_3)
end

return var_0_1
