module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelItem", package.seeall)

local var_0_0 = class("LengZhou6LevelItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#go_Normal")
	arg_1_0._goEvenLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_EvenLine")
	arg_1_0._goLockedevenLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_EvenLine/#go_Locked_evenLine")
	arg_1_0._goUnlockedevenLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_EvenLine/#go_Unlocked_evenLine")
	arg_1_0._goOddLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_OddLine")
	arg_1_0._goLockedoddLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_OddLine/#go_Locked_oddLine")
	arg_1_0._goUnlockedoddLine = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_OddLine/#go_Unlocked_oddLine")
	arg_1_0._goType1 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type1")
	arg_1_0._goLocked1 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type1/#go_Locked_1")
	arg_1_0._goNormal1 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type1/#go_Normal_1")
	arg_1_0._goCompleted1 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type1/#go_Completed_1")
	arg_1_0._goType2 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type2")
	arg_1_0._goLocked2 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type2/#go_Locked_2")
	arg_1_0._goNormal2 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type2/#go_Normal_2")
	arg_1_0._goCompleted2 = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_Type2/#go_Completed_2")
	arg_1_0._imageStageNum = gohelper.findChildImage(arg_1_0.viewGO, "#go_Normal/#image_StageNum")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "#go_Normal/#txt_StageName")
	arg_1_0._goEndless = gohelper.findChild(arg_1_0.viewGO, "#go_Endless")
	arg_1_0._txtEndless = gohelper.findChildText(arg_1_0.viewGO, "#go_Endless/#txt_Endless")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "#go_Endless/#txt_Lv")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Endless/#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessClear, MsgBoxEnum.BoxType.Yes_No, arg_4_0._endLessClear, nil, nil, arg_4_0)
end

function var_0_0._endLessClear(arg_5_0)
	UIBlockHelper.instance:startBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
	LengZhou6Controller.instance:finishLevel(arg_5_0._episodeId, "")
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._clickLister = SLFramework.UGUI.UIClickListener.Get(arg_6_0.viewGO)

	arg_6_0._clickLister:AddClickListener(arg_6_0._onClick, arg_6_0)

	arg_6_0.ani = arg_6_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0._onClick(arg_9_0)
	if arg_9_0._episodeId == nil then
		return
	end

	if not arg_9_0._episode:unLock() then
		ToastController.instance:showToast(23)

		return
	end

	LengZhou6Controller.instance:clickEpisode(arg_9_0._episodeId)
end

function var_0_0.initEpisodeId(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._index = arg_10_1
	arg_10_0._episodeId = arg_10_2
	arg_10_0._episode = LengZhou6Model.instance:getEpisodeInfoMo(arg_10_2)

	arg_10_0:initView()
end

function var_0_0.initView(arg_11_0)
	if arg_11_0._episode == nil or arg_11_0._episodeId == nil then
		return
	end

	if not arg_11_0._episode:isEndlessEpisode() then
		arg_11_0._txtStageName.text = arg_11_0._episode:getEpisodeName()

		local var_11_0 = "v2a7_hissabeth_level_stage_0" .. arg_11_0._index

		UISpriteSetMgr.instance:setHisSaBethSprite(arg_11_0._imageStageNum, var_11_0)
	else
		arg_11_0._txtEndless.text = arg_11_0._episode:getEpisodeName()
	end
end

function var_0_0.refreshState(arg_12_0)
	local var_12_0 = arg_12_0._episode:isDown()
	local var_12_1 = arg_12_0._episode:unLock()
	local var_12_2 = arg_12_0._episode.isFinish
	local var_12_3 = arg_12_0._episode:isEndlessEpisode()
	local var_12_4 = arg_12_0._episode:haveEliminate()

	arg_12_0._aniName = "open"

	if var_12_2 then
		arg_12_0._aniName = "finish"
	elseif var_12_1 then
		arg_12_0._aniName = "unlock"
	end

	gohelper.setActive(arg_12_0._goEvenLine, not var_12_0)
	gohelper.setActive(arg_12_0._goOddLine, var_12_0)
	gohelper.setActive(arg_12_0._goNormal, not var_12_3)
	gohelper.setActive(arg_12_0._goEndless, var_12_3)

	if not var_12_3 then
		gohelper.setActive(arg_12_0._goLocked1, not var_12_1)
		gohelper.setActive(arg_12_0._goLocked2, not var_12_1)
		gohelper.setActive(arg_12_0._goLockedevenLine, not var_12_1)
		gohelper.setActive(arg_12_0._goLockedoddLine, not var_12_1)
		gohelper.setActive(arg_12_0._goUnlockedevenLine, var_12_1)
		gohelper.setActive(arg_12_0._goUnlockedoddLine, var_12_1)
		gohelper.setActive(arg_12_0._goNormal1, var_12_1)
		gohelper.setActive(arg_12_0._goNormal2, var_12_1)
		gohelper.setActive(arg_12_0._goCompleted1, var_12_2)
		gohelper.setActive(arg_12_0._goCompleted2, var_12_2)
		gohelper.setActive(arg_12_0._goType1, not var_12_4)
		gohelper.setActive(arg_12_0._goType2, var_12_4)
	else
		local var_12_5 = string.nilorempty(arg_12_0._episode.progress)
		local var_12_6 = false

		if not var_12_5 then
			local var_12_7 = arg_12_0._episode:getEndLessBattleProgress()
			local var_12_8 = arg_12_0._episode:getLevel()

			if var_12_7 and var_12_7 == LengZhou6Enum.BattleProgress.selectFinish or var_12_8 ~= 1 then
				var_12_6 = true
			end
		end

		if var_12_6 then
			arg_12_0._txtLv.text = string.format("Lv.%s", arg_12_0._episode:getLevel())
		else
			arg_12_0._txtLv.text = ""
		end

		gohelper.setActive(arg_12_0._btnreset.gameObject, var_12_6)
	end
end

function var_0_0.finishStateEnd(arg_13_0)
	return arg_13_0._aniName == "finish"
end

function var_0_0.updateInfo(arg_14_0, arg_14_1)
	if arg_14_0._episode == nil or arg_14_0._episodeId == nil then
		return
	end

	arg_14_0:refreshState()

	local var_14_0 = arg_14_0._episode:canShowItem()

	gohelper.setActive(arg_14_0.viewGO, var_14_0)

	if arg_14_1 then
		arg_14_0:playAni(arg_14_0._aniName)
	end
end

function var_0_0.playAni(arg_15_0, arg_15_1)
	if arg_15_0.ani and arg_15_1 then
		arg_15_0.ani:Play(arg_15_1, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._clickLister ~= nil then
		arg_16_0._clickLister:RemoveClickListener()

		arg_16_0._clickLister = nil
	end
end

return var_0_0
