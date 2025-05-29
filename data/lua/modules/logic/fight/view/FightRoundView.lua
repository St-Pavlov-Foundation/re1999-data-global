module("modules.logic.fight.view.FightRoundView", package.seeall)

local var_0_0 = class("FightRoundView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageroundBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#image_roundBg")
	arg_1_0._txtroundText = gohelper.findChildText(arg_1_0.viewGO, "#image_roundBg/roundBg/#txt_roundText")
	arg_1_0._imagefightStartBg = gohelper.findChildImage(arg_1_0.viewGO, "#image_fightStartBg")
	arg_1_0._goalList = gohelper.findChild(arg_1_0.viewGO, "#image_roundBg/goalList")
	arg_1_0._goCondition = gohelper.findChild(arg_1_0.viewGO, "#image_roundBg/goalList/#go_goal")
	arg_1_0._txtCondition = gohelper.findChildText(arg_1_0.viewGO, "#image_roundBg/goalList/#go_goal/#txt_condition1")
	arg_1_0._goPlatCondition = gohelper.findChild(arg_1_0.viewGO, "#image_roundBg/goalList/#go_platinum")
	arg_1_0._txtPlatCondition = gohelper.findChildText(arg_1_0.viewGO, "#image_roundBg/goalList/#go_platinum/#txt_condition2")
	arg_1_0._goplatinum1 = gohelper.findChild(arg_1_0.viewGO, "#image_roundBg/goalList/#go_platinum1")
	arg_1_0._txtcondition3 = gohelper.findChildText(arg_1_0.viewGO, "#image_roundBg/goalList/#go_platinum1/#txt_condition3")

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

local var_0_1 = 1

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._imageroundBg:LoadImage(ResUrl.getFightResultcIcon("bg_tubiaoheidi"))
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = FightModel.instance:getSpeed()

	arg_5_0._showTime = var_5_0 > 0 and var_0_1 / var_5_0 or var_0_1
	arg_5_0._showTime = Mathf.Clamp(arg_5_0._showTime, 0.2, 1)

	local var_5_1 = FightModel.instance:getFightParam().episodeId

	if not var_5_1 then
		return
	end

	local var_5_2 = FightModel.instance:getCurWaveId()
	local var_5_3 = FightModel.instance.maxWave
	local var_5_4 = false

	arg_5_0._txtroundText.text = luaLang("main_fight") .. string.format(" - %d/%d", var_5_2, var_5_3)

	local var_5_5 = DungeonConfig.instance:getEpisodeCO(var_5_1)
	local var_5_6

	var_5_6 = var_5_5 and DungeonConfig.instance:getChapterCO(var_5_5.chapterId).type == DungeonEnum.ChapterType.Hard

	if var_5_2 == 1 then
		arg_5_0:_setConditionText(arg_5_0._txtCondition, DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId()), true)

		local var_5_7 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_5_1, FightModel.instance:getBattleId())

		if string.nilorempty(var_5_7) then
			gohelper.setActive(arg_5_0._goPlatCondition, false)
		else
			arg_5_0:_setConditionText(arg_5_0._txtPlatCondition, var_5_7, true)
		end

		local var_5_8 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(var_5_1, FightModel.instance:getBattleId())

		if string.nilorempty(var_5_8) then
			gohelper.setActive(arg_5_0._goplatinum1, false)
		else
			arg_5_0:_setConditionText(arg_5_0._txtcondition3, var_5_8, true)
		end
	else
		gohelper.setActive(arg_5_0._goCondition, false)
		gohelper.setActive(arg_5_0._goPlatCondition, false)
		gohelper.setActive(arg_5_0._goplatinum1, false)
	end

	gohelper.setActive(arg_5_0._imageroundBg.gameObject, not var_5_4)
	gohelper.setActive(arg_5_0._imagefightStartBg.gameObject, var_5_4)

	if var_5_4 then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Bosswarning)
		TaskDispatcher.runDelay(arg_5_0._delayShowRound, arg_5_0, arg_5_0._showTime)
	else
		TaskDispatcher.runDelay(arg_5_0._delayClose, arg_5_0, arg_5_0._showTime)
	end

	gohelper.onceAddComponent(arg_5_0.viewGO, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

	local var_5_9 = true

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2] then
		var_5_9 = false
	end

	gohelper.setActive(arg_5_0._goalList, var_5_9)
end

function var_0_0._setConditionText(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 then
		arg_6_1.text = gohelper.getRichColorText(arg_6_2, "#C4C0BD")
	else
		arg_6_1.text = gohelper.getRichColorText(arg_6_2, "#6C6C6B")
	end
end

function var_0_0._delayShowRound(arg_7_0)
	gohelper.setActive(arg_7_0._imageroundBg.gameObject, true)
	gohelper.setActive(arg_7_0._imagefightStartBg.gameObject, false)
	TaskDispatcher.runDelay(arg_7_0._delayClose, arg_7_0, arg_7_0._showTime)
end

function var_0_0.onClose(arg_8_0)
	FightController.instance:dispatchEvent(FightEvent.OnRoundViewClose)
	TaskDispatcher.cancelTask(arg_8_0._delayShowRound, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayClose, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._imageroundBg:UnLoadImage()
end

function var_0_0._delayClose(arg_10_0)
	arg_10_0:closeThis()
end

return var_0_0
