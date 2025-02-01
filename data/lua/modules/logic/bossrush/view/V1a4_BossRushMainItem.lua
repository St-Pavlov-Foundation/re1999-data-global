module("modules.logic.bossrush.view.V1a4_BossRushMainItem", package.seeall)

slot0 = class("V1a4_BossRushMainItem", LuaCompBase)
slot1 = BossRushEnum.AnimMainItem

function slot0.init(slot0, slot1)
	slot0.viewGO = gohelper.findChild(slot1, "Root")
	slot0._btnItemBG = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ItemBG")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goUnlocked = gohelper.findChild(slot0.viewGO, "#go_Unlocked")
	slot0._imageIssxIcon = gohelper.findChildImage(slot0.viewGO, "#go_Unlocked/Title/#image_IssxIcon")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/Title/#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#go_Unlocked/Title/#txt_TitleEn")
	slot0._btnGo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Unlocked/#btn_Go", AudioEnum.ui_activity.play_ui_activity_open)
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_Locked")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Locked/#btn_Locked")
	slot0._goRecord = gohelper.findChild(slot0.viewGO, "#go_Record")
	slot0._txtRecordNum = gohelper.findChildText(slot0.viewGO, "#go_Record/#txt_RecordNum")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "#go_Record/#go_AssessIcon")
	slot0._goRed = gohelper.findChild(slot0.viewGO, "#go_Red")
	slot0._imgItemBG = gohelper.findChildImage(slot0.viewGO, "#btn_ItemBG")
	slot0._go3s = gohelper.findChild(slot0.viewGO, "3s")
	slot0._go4s = gohelper.findChild(slot0.viewGO, "4s")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnItemBG:AddClickListener(slot0._btnItemBGOnClick, slot0)
	slot0._btnGo:AddClickListener(slot0._btnGoOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnItemBG:RemoveClickListener()
	slot0._btnGo:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
end

function slot0._btnItemBGOnClick(slot0)
	slot0:_onClick()
end

function slot0._btnGoOnClick(slot0)
	slot0:_onClick()
end

function slot0._btnLockedOnClick(slot0)
	slot0:_onClick()
end

function slot0._editableInitView(slot0)
	slot0:_initAssessIcon()

	slot0._txtLocked.text = ""
	slot0._txtRecordNum.text = ""
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_assessIcon")

	slot0._isForcePlayUnlock = false
	slot0._openAnim = false

	slot0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenCallBack, slot0)
end

function slot0._initAssessIcon(slot0)
	slot2 = V1a4_BossRush_AssessIcon
	slot0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(ViewMgr.instance:getContainer(ViewName.V1a4_BossRushMainView):getResInst(BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon, slot0._goAssessIcon, slot2.__cname), slot2)

	slot0._assessIcon:initData(slot0, false)
end

function slot0.setData(slot0, slot1, slot2)
	slot0._mo = slot1

	slot0:_refresh()
	slot0:_setActive(false)

	if slot2 then
		slot0:_tweenOpen()
	else
		slot0:_playIdle()
	end

	if not slot0:_isOpen() then
		slot0:_onRefreshDeadline()
		TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	end

	slot0:_refreshRed()
end

function slot0._refresh(slot0)
	slot2 = slot0._mo.stageCO
	slot3 = slot2.stage
	slot4 = slot0:_isOpen()
	slot5 = BossRushConfig.instance:getIssxIconName(slot3)
	slot6 = BossRushModel.instance:getHighestPoint(slot3)
	slot7 = slot2.name

	if GameConfig:GetCurLangType() == LangSettings.zh and not string.nilorempty(slot7) and string.len(slot7) >= 4 then
		slot9 = "<size=67>%s</size>"
		slot7 = string.format(slot9, slot7:sub(1, 3)) .. slot7:sub(4, slot8 - 3) .. string.format(slot9, slot7:sub(slot8 - 2, slot8))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._imageIssxIcon, slot5)
	gohelper.setActive(slot0._goRecord, slot4)

	slot0._txtRecordNum.text = slot6
	slot0._txtTitle.text = slot7
	slot0._txtTitleEn.text = slot2.name_en

	slot0._simagebg:LoadImage(BossRushConfig.instance:getBossRushMainItemBossSprite(slot3))
	slot0._assessIcon:setData(slot3, slot6, BossRushModel.instance:getLayer4HightScore(slot3) == slot6)

	if slot4 then
		gohelper.addUIClickAudio(slot0._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
	end

	slot9, slot10 = BossRushConfig.instance:getAssessMainBossBgName(slot3, slot6, slot8)

	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0._imgItemBG, slot9)
	gohelper.setActive(slot0._go3s, slot10 and slot10 == BossRushEnum.ScoreLevel.S_AA)
	gohelper.setActive(slot0._go4s, slot10 and slot10 == BossRushEnum.ScoreLevel.S_AAA)
end

function slot0._isOpen(slot0)
	return BossRushModel.instance:isBossOnline(slot0:_getStage())
end

function slot0._getStage(slot0)
	return slot0._mo.stageCO.stage
end

function slot0._onRefreshDeadline(slot0)
	if BossRushModel.instance:getStageOpenServerTime(slot0:_getStage()) - ServerTime.now() > 0 then
		slot0._txtLocked.text = BossRushConfig.instance:getRemainTimeStrWithFmt(slot3, Activity128Config.ETimeFmtStyle.UnLock)
	else
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

		if slot0:_isOpen() then
			if slot0._openAnimed then
				BossRushRedModel.instance:setIsNewUnlockStage(slot1, false)
				slot0:_playUnlocking()
			else
				slot0:_playUnlock(true)
			end
		end

		slot0:_refresh()
	end
end

function slot0._onClick(slot0)
	BossRushController.instance:openLevelDetailView(slot0._mo)
end

function slot0._delayOpenCallBack(slot0)
	slot0:_setActive(true)

	if slot0._isForcePlayUnlock and slot0:_isOpen() then
		slot0:_playUnlock(true)
	else
		slot0:_playOpen()
	end

	slot0._openAnim = false
end

function slot0._tweenOpen(slot0)
	if slot0._openAnim then
		return
	end

	slot0._openAnim = true

	if BossRushRedModel.instance:getIsNewUnlockStage(slot0:_getStage()) then
		slot0._isForcePlayUnlock = true
	end

	slot0._openAnimed = true

	TaskDispatcher.runDelay(slot0._delayOpenCallBack, slot0, slot0._index * 0.06)
end

function slot0._playOpen(slot0)
	if slot0:_isOpen() then
		slot0:_playAnim(uv0.OpeningUnlocked, 0, 0)
	else
		slot0:_playAnim(uv0.OpeningLocked, 0, 0)
	end
end

function slot0._playIdle(slot0)
	if slot0:_isOpen() then
		slot0:_playAnim(uv0.UnlockedIdle, 0, 1)
	else
		slot0:_playAnim(uv0.LockedIdle, 0, 1)
	end
end

function slot0._playUnlock(slot0, slot1)
	if slot0._openAnim and not slot0._isForcePlayUnlock then
		if slot1 then
			slot0._isForcePlayUnlock = true
		end

		return
	end

	slot0:_playAnim(uv0.Unlock, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	slot0._isForcePlayUnlock = false

	gohelper.setActive(slot0._goRecord, true)
end

function slot0._playUnlocking(slot0)
	TaskDispatcher.cancelTask(slot0._delayOpenCallBack, slot0)
	slot0:_playAnim(uv0.Unlocking, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	slot0._isForcePlayUnlock = false

	gohelper.setActive(slot0._goRecord, true)
end

function slot0._setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0._playAnim(slot0, slot1, ...)
	slot0._anim:Play(slot1, ...)
end

function slot0._refreshRed(slot0)
	RedDotController.instance:addRedDot(slot0._goRed, RedDotEnum.DotNode.BossRushBoss, slot0:_getStage())
end

return slot0
