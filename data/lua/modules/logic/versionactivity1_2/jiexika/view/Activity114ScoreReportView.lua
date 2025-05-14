module("modules.logic.versionactivity1_2.jiexika.view.Activity114ScoreReportView", package.seeall)

local var_0_0 = class("Activity114ScoreReportView", BaseView)
local var_0_1 = {
	Activity114Enum.ConstId.ScoreA,
	Activity114Enum.ConstId.ScoreB,
	Activity114Enum.ConstId.ScoreC,
	Activity114Enum.ConstId.ScoreE
}
local var_0_2 = {
	1,
	0.6,
	0.32,
	0.15
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtactionscore = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/scoreInfo/action/#txt_actionscore")
	arg_1_0._txtmidtermscore = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/scoreInfo/midterm/#txt_midtermscore")
	arg_1_0._txtfinalscore = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/scoreInfo/final/#txt_finalscore")
	arg_1_0._txttotalscore = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/scoreInfo/total/#txt_totalscore")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "content/multigradeInfo/progressbar/#image_progress")
	arg_1_0._txtremarkdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_remarktip/#scroll_remark/Viewport/Content/#txt_remarkdesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("score/img_bg.png"))
	arg_4_0._simagebg2:LoadImage(ResUrl.getAct114Icon("bg1"))

	arg_4_0._scoreIcons = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 4 do
		arg_4_0._scoreIcons[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, "content/#go_scoreIcon/go_score" .. iter_4_0)
	end

	arg_4_0._grades = {}

	for iter_4_1 = 1, 4 do
		arg_4_0._grades[iter_4_1] = arg_4_0:getUserDataTb_()
		arg_4_0._grades[iter_4_1].circle = gohelper.findChild(arg_4_0.viewGO, "content/multigradeInfo/grade/grade" .. iter_4_1 .. "/go_circle")
		arg_4_0._grades[iter_4_1].txt = gohelper.findChildTextMesh(arg_4_0.viewGO, "content/multigradeInfo/grade/grade" .. iter_4_1 .. "/txt")
	end
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	local var_5_0, var_5_1, var_5_2, var_5_3 = Activity114Helper.getWeekEndScore()
	local var_5_4
	local var_5_5

	for iter_5_0 = 1, #var_0_1 do
		local var_5_6, var_5_7 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, var_0_1[iter_5_0])

		if var_5_6 <= var_5_3 and not var_5_4 then
			var_5_4 = iter_5_0
			var_5_5 = var_5_7
		end

		gohelper.setActive(arg_5_0._grades[iter_5_0].circle, false)

		arg_5_0._grades[iter_5_0].txt.text = var_5_6
	end

	arg_5_0._txtremarkdesc.text = var_5_5

	for iter_5_1 = 1, 4 do
		gohelper.setActive(arg_5_0._scoreIcons[iter_5_1], false)
	end

	arg_5_0._txtactionscore.text = var_5_0
	arg_5_0._txtmidtermscore.text = var_5_1
	arg_5_0._txtfinalscore.text = var_5_2
	arg_5_0._txttotalscore.text = var_5_3

	local var_5_8 = 0

	if var_5_4 == 1 then
		var_5_8 = var_0_2[1]
	else
		local var_5_9 = var_0_2[var_5_4]
		local var_5_10 = var_0_2[var_5_4 - 1]
		local var_5_11 = 0
		local var_5_12 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, var_0_1[var_5_4])
		local var_5_13 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, var_0_1[var_5_4 - 1])
		local var_5_14 = (var_5_3 - var_5_13) / (var_5_12 - var_5_13)

		var_5_8 = Mathf.Lerp(var_5_10, var_5_9, var_5_14)
	end

	arg_5_0._imageprogress.fillAmount = 0
	arg_5_0._finalAmount = var_5_8
	arg_5_0._finalLevel = var_5_4

	TaskDispatcher.runDelay(arg_5_0.delayTweenSlider, arg_5_0, 0.4)
	TaskDispatcher.runDelay(arg_5_0.playAudio1, arg_5_0, 0.95)
	TaskDispatcher.runDelay(arg_5_0.playAudio2, arg_5_0, 1.3)
end

function var_0_0.delayTweenSlider(arg_6_0)
	arg_6_0._tweenId = ZProj.TweenHelper.DOFillAmount(arg_6_0._imageprogress, arg_6_0._finalAmount, 0.6, arg_6_0.onTweenEnd, arg_6_0)
end

function var_0_0.onTweenEnd(arg_7_0)
	arg_7_0._tweenId = nil

	for iter_7_0 = 1, 4 do
		gohelper.setActive(arg_7_0._grades[iter_7_0].circle, iter_7_0 == arg_7_0._finalLevel)
		gohelper.setActive(arg_7_0._scoreIcons[iter_7_0], iter_7_0 == arg_7_0._finalLevel)
	end
end

function var_0_0.playAudio1(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function var_0_0.playAudio2(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)

	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_10_0.delayTweenSlider, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.playAudio1, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.playAudio2, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
