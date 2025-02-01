module("modules.logic.versionactivity1_2.jiexika.view.Activity114ScoreReportView", package.seeall)

slot0 = class("Activity114ScoreReportView", BaseView)
slot1 = {
	Activity114Enum.ConstId.ScoreA,
	Activity114Enum.ConstId.ScoreB,
	Activity114Enum.ConstId.ScoreC,
	Activity114Enum.ConstId.ScoreE
}
slot2 = {
	1,
	0.6,
	0.32,
	0.15
}

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtactionscore = gohelper.findChildTextMesh(slot0.viewGO, "content/scoreInfo/action/#txt_actionscore")
	slot0._txtmidtermscore = gohelper.findChildTextMesh(slot0.viewGO, "content/scoreInfo/midterm/#txt_midtermscore")
	slot0._txtfinalscore = gohelper.findChildTextMesh(slot0.viewGO, "content/scoreInfo/final/#txt_finalscore")
	slot0._txttotalscore = gohelper.findChildTextMesh(slot0.viewGO, "content/scoreInfo/total/#txt_totalscore")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "content/multigradeInfo/progressbar/#image_progress")
	slot0._txtremarkdesc = gohelper.findChildTextMesh(slot0.viewGO, "#go_remarktip/#scroll_remark/Viewport/Content/#txt_remarkdesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("score/img_bg.png"))

	slot4 = "bg1"

	slot0._simagebg2:LoadImage(ResUrl.getAct114Icon(slot4))

	slot0._scoreIcons = slot0:getUserDataTb_()

	for slot4 = 1, 4 do
		slot0._scoreIcons[slot4] = gohelper.findChild(slot0.viewGO, "content/#go_scoreIcon/go_score" .. slot4)
	end

	slot0._grades = {}

	for slot4 = 1, 4 do
		slot0._grades[slot4] = slot0:getUserDataTb_()
		slot0._grades[slot4].circle = gohelper.findChild(slot0.viewGO, "content/multigradeInfo/grade/grade" .. slot4 .. "/go_circle")
		slot0._grades[slot4].txt = gohelper.findChildTextMesh(slot0.viewGO, "content/multigradeInfo/grade/grade" .. slot4 .. "/txt")
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	slot1, slot2, slot3, slot4 = Activity114Helper.getWeekEndScore()

	for slot10 = 1, #uv0 do
		slot11, slot6 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, uv0[slot10])

		if slot11 <= slot4 and not nil then
			slot5 = slot10
		end

		gohelper.setActive(slot0._grades[slot10].circle, false)

		slot0._grades[slot10].txt.text = slot11
	end

	slot0._txtremarkdesc.text = slot6

	for slot10 = 1, 4 do
		gohelper.setActive(slot0._scoreIcons[slot10], false)
	end

	slot0._txtactionscore.text = slot1
	slot0._txtmidtermscore.text = slot2
	slot0._txtfinalscore.text = slot3
	slot0._txttotalscore.text = slot4
	slot7 = 0

	if slot5 == 1 then
		slot7 = uv1[1]
	else
		slot10 = 0
		slot12 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, uv0[slot5 - 1])
		slot7 = Mathf.Lerp(uv1[slot5 - 1], uv1[slot5], (slot4 - slot12) / (Activity114Config.instance:getConstValue(Activity114Model.instance.id, uv0[slot5]) - slot12))
	end

	slot0._imageprogress.fillAmount = 0
	slot0._finalAmount = slot7
	slot0._finalLevel = slot5

	TaskDispatcher.runDelay(slot0.delayTweenSlider, slot0, 0.4)
	TaskDispatcher.runDelay(slot0.playAudio1, slot0, 0.95)
	TaskDispatcher.runDelay(slot0.playAudio2, slot0, 1.3)
end

function slot0.delayTweenSlider(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOFillAmount(slot0._imageprogress, slot0._finalAmount, 0.6, slot0.onTweenEnd, slot0)
end

function slot0.onTweenEnd(slot0)
	slot0._tweenId = nil

	for slot4 = 1, 4 do
		gohelper.setActive(slot0._grades[slot4].circle, slot4 == slot0._finalLevel)
		gohelper.setActive(slot0._scoreIcons[slot4], slot4 == slot0._finalLevel)
	end
end

function slot0.playAudio1(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function slot0.playAudio2(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0.delayTweenSlider, slot0)
	TaskDispatcher.cancelTask(slot0.playAudio1, slot0)
	TaskDispatcher.cancelTask(slot0.playAudio2, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
