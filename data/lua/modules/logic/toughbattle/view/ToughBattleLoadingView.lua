module("modules.logic.toughbattle.view.ToughBattleLoadingView", package.seeall)

local var_0_0 = class("ToughBattleLoadingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imgstage = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_stageinfo/#simage_stagepic")
	arg_1_0._imgstage2 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_start/#simage_stagepic")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "root/#go_bg")
	arg_1_0._gofightsuccess = gohelper.findChild(arg_1_0.viewGO, "root/#go_fightsuccess")
	arg_1_0._gostageinfo = gohelper.findChild(arg_1_0.viewGO, "root/#go_stageinfo")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "root/#go_start")
	arg_1_0._enemy = gohelper.findChild(arg_1_0.viewGO, "root/#go_bg/enemy")
	arg_1_0._stageen1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_stageinfo/txten1")
	arg_1_0._stageen2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_stageinfo/txten2")
	arg_1_0._txtstage = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_stageinfo/txt")
end

function var_0_0.onOpen(arg_2_0)
	gohelper.setActive(arg_2_0._gofightsuccess, false)
	gohelper.setActive(arg_2_0._gostageinfo, false)
	gohelper.setActive(arg_2_0._gostart, false)
	gohelper.setActive(arg_2_0._gobg, false)
	UISpriteSetMgr.instance:setToughBattleSprite(arg_2_0._imgstage, "toughbattle_stage_1_" .. arg_2_0.viewParam.stage)
	UISpriteSetMgr.instance:setToughBattleSprite(arg_2_0._imgstage2, "toughbattle_stage_2_" .. arg_2_0.viewParam.stage)
	gohelper.setActive(arg_2_0._enemy, arg_2_0.viewParam.stage == 2)
	gohelper.setActive(arg_2_0._stageen1, arg_2_0.viewParam.stage == 1)
	gohelper.setActive(arg_2_0._stageen2, arg_2_0.viewParam.stage == 2)

	if arg_2_0.viewParam.stage == 1 then
		arg_2_0:playStageInfo()
	else
		arg_2_0:playFightSuccess()
	end
end

function var_0_0.playFightSuccess(arg_3_0)
	gohelper.setActive(arg_3_0._gofightsuccess, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_win)
	TaskDispatcher.runDelay(arg_3_0.playStageInfo, arg_3_0, 1.667)
end

function var_0_0.playStageInfo(arg_4_0)
	gohelper.setActive(arg_4_0._gofightsuccess, false)
	gohelper.setActive(arg_4_0._gobg, true)
	gohelper.setActive(arg_4_0._gostageinfo, true)

	arg_4_0._txtstage.text = arg_4_0.viewParam.stage == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bushu)
	TaskDispatcher.runDelay(arg_4_0.playStart, arg_4_0, 1.667)
end

function var_0_0.playStart(arg_5_0)
	gohelper.setActive(arg_5_0._gostageinfo, false)
	gohelper.setActive(arg_5_0._gostart, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_kaishi)
	TaskDispatcher.runDelay(arg_5_0.closeThis, arg_5_0, 1.333)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.playFightSuccess, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.playStart, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
end

return var_0_0
