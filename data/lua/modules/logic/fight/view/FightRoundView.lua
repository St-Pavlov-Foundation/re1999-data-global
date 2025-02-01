module("modules.logic.fight.view.FightRoundView", package.seeall)

slot0 = class("FightRoundView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageroundBg = gohelper.findChildSingleImage(slot0.viewGO, "#image_roundBg")
	slot0._txtroundText = gohelper.findChildText(slot0.viewGO, "#image_roundBg/roundBg/#txt_roundText")
	slot0._imagefightStartBg = gohelper.findChildImage(slot0.viewGO, "#image_fightStartBg")
	slot0._goCondition = gohelper.findChild(slot0.viewGO, "#image_roundBg/goalList/#go_goal")
	slot0._txtCondition = gohelper.findChildText(slot0.viewGO, "#image_roundBg/goalList/#go_goal/#txt_condition1")
	slot0._goPlatCondition = gohelper.findChild(slot0.viewGO, "#image_roundBg/goalList/#go_platinum")
	slot0._txtPlatCondition = gohelper.findChildText(slot0.viewGO, "#image_roundBg/goalList/#go_platinum/#txt_condition2")
	slot0._goplatinum1 = gohelper.findChild(slot0.viewGO, "#image_roundBg/goalList/#go_platinum1")
	slot0._txtcondition3 = gohelper.findChildText(slot0.viewGO, "#image_roundBg/goalList/#go_platinum1/#txt_condition3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = 1

function slot0._editableInitView(slot0)
	slot0._imageroundBg:LoadImage(ResUrl.getFightResultcIcon("bg_tubiaoheidi"))
end

function slot0.onOpen(slot0)
	slot0._showTime = FightModel.instance:getSpeed() > 0 and uv0 / slot1 or uv0
	slot0._showTime = Mathf.Clamp(slot0._showTime, 0.2, 1)

	if not FightModel.instance:getFightParam().episodeId then
		return
	end

	slot5 = false
	slot0._txtroundText.text = luaLang("main_fight") .. string.format(" - %d/%d", FightModel.instance:getCurWaveId(), FightModel.instance.maxWave)
	slot7 = DungeonConfig.instance:getEpisodeCO(slot2) and DungeonConfig.instance:getChapterCO(slot6.chapterId).type == DungeonEnum.ChapterType.Hard

	if slot3 == 1 then
		slot0:_setConditionText(slot0._txtCondition, DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId()), true)

		if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2, FightModel.instance:getBattleId())) then
			gohelper.setActive(slot0._goPlatCondition, false)
		else
			slot0:_setConditionText(slot0._txtPlatCondition, slot8, true)
		end

		if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot2, FightModel.instance:getBattleId())) then
			gohelper.setActive(slot0._goplatinum1, false)
		else
			slot0:_setConditionText(slot0._txtcondition3, slot9, true)
		end
	else
		gohelper.setActive(slot0._goCondition, false)
		gohelper.setActive(slot0._goPlatCondition, false)
		gohelper.setActive(slot0._goplatinum1, false)
	end

	gohelper.setActive(slot0._imageroundBg.gameObject, not slot5)
	gohelper.setActive(slot0._imagefightStartBg.gameObject, slot5)

	if slot5 then
		FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Bosswarning)
		TaskDispatcher.runDelay(slot0._delayShowRound, slot0, slot0._showTime)
	else
		TaskDispatcher.runDelay(slot0._delayClose, slot0, slot0._showTime)
	end

	gohelper.onceAddComponent(slot0.viewGO, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
end

function slot0._setConditionText(slot0, slot1, slot2, slot3)
	if slot3 then
		slot1.text = gohelper.getRichColorText(slot2, "#C4C0BD")
	else
		slot1.text = gohelper.getRichColorText(slot2, "#6C6C6B")
	end
end

function slot0._delayShowRound(slot0)
	gohelper.setActive(slot0._imageroundBg.gameObject, true)
	gohelper.setActive(slot0._imagefightStartBg.gameObject, false)
	TaskDispatcher.runDelay(slot0._delayClose, slot0, slot0._showTime)
end

function slot0.onClose(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnRoundViewClose)
	TaskDispatcher.cancelTask(slot0._delayShowRound, slot0)
	TaskDispatcher.cancelTask(slot0._delayClose, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imageroundBg:UnLoadImage()
end

function slot0._delayClose(slot0)
	slot0:closeThis()
end

return slot0
