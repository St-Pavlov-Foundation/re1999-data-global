module("modules.logic.toughbattle.view.ToughBattleLoadingView", package.seeall)

slot0 = class("ToughBattleLoadingView", BaseView)

function slot0.onInitView(slot0)
	slot0._imgstage = gohelper.findChildImage(slot0.viewGO, "root/#go_stageinfo/#simage_stagepic")
	slot0._imgstage2 = gohelper.findChildImage(slot0.viewGO, "root/#go_start/#simage_stagepic")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "root/#go_bg")
	slot0._gofightsuccess = gohelper.findChild(slot0.viewGO, "root/#go_fightsuccess")
	slot0._gostageinfo = gohelper.findChild(slot0.viewGO, "root/#go_stageinfo")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "root/#go_start")
	slot0._enemy = gohelper.findChild(slot0.viewGO, "root/#go_bg/enemy")
	slot0._stageen1 = gohelper.findChild(slot0.viewGO, "root/#go_stageinfo/txten1")
	slot0._stageen2 = gohelper.findChild(slot0.viewGO, "root/#go_stageinfo/txten2")
	slot0._txtstage = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_stageinfo/txt")
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gofightsuccess, false)
	gohelper.setActive(slot0._gostageinfo, false)
	gohelper.setActive(slot0._gostart, false)
	gohelper.setActive(slot0._gobg, false)
	UISpriteSetMgr.instance:setToughBattleSprite(slot0._imgstage, "toughbattle_stage_1_" .. slot0.viewParam.stage)
	UISpriteSetMgr.instance:setToughBattleSprite(slot0._imgstage2, "toughbattle_stage_2_" .. slot0.viewParam.stage)
	gohelper.setActive(slot0._enemy, slot0.viewParam.stage == 2)
	gohelper.setActive(slot0._stageen1, slot0.viewParam.stage == 1)
	gohelper.setActive(slot0._stageen2, slot0.viewParam.stage == 2)

	if slot0.viewParam.stage == 1 then
		slot0:playStageInfo()
	else
		slot0:playFightSuccess()
	end
end

function slot0.playFightSuccess(slot0)
	gohelper.setActive(slot0._gofightsuccess, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_win)
	TaskDispatcher.runDelay(slot0.playStageInfo, slot0, 1.667)
end

function slot0.playStageInfo(slot0)
	gohelper.setActive(slot0._gofightsuccess, false)
	gohelper.setActive(slot0._gobg, true)
	gohelper.setActive(slot0._gostageinfo, true)

	slot0._txtstage.text = slot0.viewParam.stage == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bushu)
	TaskDispatcher.runDelay(slot0.playStart, slot0, 1.667)
end

function slot0.playStart(slot0)
	gohelper.setActive(slot0._gostageinfo, false)
	gohelper.setActive(slot0._gostart, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_kaishi)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 1.333)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playFightSuccess, slot0)
	TaskDispatcher.cancelTask(slot0.playStart, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
