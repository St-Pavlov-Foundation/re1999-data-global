module("modules.logic.versionactivity2_4.pinball.view.PinballDayEndView", package.seeall)

slot0 = class("PinballDayEndView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtday = gohelper.findChildTextMesh(slot0.viewGO, "bg/#txt_day")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txtmainlv = gohelper.findChildTextMesh(slot0.viewGO, "#go_main/#txt_lv")
	slot0._slider1 = gohelper.findChildImage(slot0.viewGO, "#go_main/#go_slider/#go_slider1")
	slot0._slider2 = gohelper.findChildImage(slot0.viewGO, "#go_main/#go_slider/#go_slider2")
	slot0._slider3 = gohelper.findChildImage(slot0.viewGO, "#go_main/#go_slider/#go_slider3")
	slot0._txtnum = gohelper.findChildTextMesh(slot0.viewGO, "#go_main/#txt_num")
	slot0._imagemoodicon = gohelper.findChildImage(slot0.viewGO, "#go_mood/#simage_icon")
	slot0._imagemood1 = gohelper.findChildImage(slot0.viewGO, "#go_mood/#simage_progress1")
	slot0._imagemood2 = gohelper.findChildImage(slot0.viewGO, "#go_mood/#simage_progress2")
	slot0._txtmoodnum = gohelper.findChildTextMesh(slot0.viewGO, "#go_mood/mask/#txt_mood")
	slot0._goarrow1 = gohelper.findChild(slot0.viewGO, "txt_dec/#go_arrow")
	slot0._goarrow2 = gohelper.findChild(slot0.viewGO, "txt_dec2/#go_arrow")
	slot0._txtdescmood = gohelper.findChildTextMesh(slot0.viewGO, "#go_mood/mask2/#txt_desc")
	slot0._godescmainitem = gohelper.findChild(slot0.viewGO, "#go_main/layout/tag1")
	slot0._godescmood = gohelper.findChild(slot0.viewGO, "#go_mood/mask2")
	slot0._effectday = gohelper.findChild(slot0.viewGO, "bg/vx_nextday")
	slot0._effectnextlv = gohelper.findChild(slot0.viewGO, "#go_main/vx_nextlevel")
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio9)
	gohelper.setActive(slot0._gotips, false)

	slot0._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), slot0.viewParam.day)
	slot0._canClose = false
	slot0._nextScore = slot0.viewParam.nextScore
	slot0._beforeScore = slot0.viewParam.preScore
	slot0._nextComplaint = slot0.viewParam.nextComplaint
	slot0._beforeComplaint = slot0.viewParam.preComplaint

	gohelper.setActive(slot0._goarrow1, slot0._beforeScore < slot0._nextScore)
	gohelper.setActive(slot0._goarrow2, slot0._beforeComplaint < slot0._nextComplaint)
	slot0:updateTxt()
	TaskDispatcher.runDelay(slot0._delayTween, slot0, 1)

	if slot0._beforeScore == slot0._nextScore and slot0._beforeComplaint == slot0._nextComplaint then
		slot0:_onTween(1)

		return
	end

	slot0:_onTween(0)
end

function slot0._delayTween(slot0)
	if slot0._beforeScore == slot0._nextScore and slot0._beforeComplaint == slot0._nextComplaint then
		slot0:onTweenEnd()

		return
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, slot0._onTween, slot0.onTweenEnd, slot0)
end

function slot0._onTween(slot0, slot1)
	slot0:updateScore(math.floor(slot1 * (slot0._nextScore - slot0._beforeScore) + slot0._beforeScore))
	slot0:updateComplaint(math.floor(slot1 * (slot0._nextComplaint - slot0._beforeComplaint) + slot0._beforeComplaint))
end

function slot0.updateTxt(slot0)
	slot3 = {}

	for slot7 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot0.viewParam.preMaxProsperity) + 1, PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot0.viewParam.nextMaxProsperity) do
		if not string.nilorempty(lua_activity178_score.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot7].showTxt) then
			for slot13, slot14 in pairs(string.splitToNumber(slot8.showTxt, "#")) do
				slot3[slot14] = true
			end
		end
	end

	slot4 = {}

	for slot8 in pairs(slot3) do
		table.insert(slot4, slot8)
	end

	table.sort(slot4)

	slot5 = {}

	for slot9, slot10 in ipairs(slot4) do
		table.insert(slot5, GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_score_desc_" .. slot10), slot9))
	end

	gohelper.CreateObjList(slot0, slot0._createMainDescItem, slot5, nil, slot0._godescmainitem)

	slot6 = slot0:getStage(slot0.viewParam.preComplaint)

	if slot0:getStage(slot0.viewParam.nextComplaint) == 3 then
		slot8 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum) - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif slot7 == 2 then
		slot8 = slot8 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	if slot7 < slot6 then
		gohelper.setActive(slot0._godescmood, true)

		slot0._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_2"), slot8)
	elseif slot6 < slot7 then
		gohelper.setActive(slot0._godescmood, true)

		slot0._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_1"), slot8)
	else
		gohelper.setActive(slot0._godescmood, false)

		slot0._txtdescmood.text = ""
	end
end

function slot0._createMainDescItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "#txt_desc").text = slot2
end

function slot0.updateScore(slot0, slot1)
	slot0._txtmainlv.text, slot3, slot4 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot1)
	slot5 = slot1
	slot6 = slot0._nextScore

	if slot0._cacheLv and slot0._cacheLv < slot2 then
		gohelper.setActive(slot0._effectnextlv, false)
		gohelper.setActive(slot0._effectnextlv, true)
	end

	slot0._cacheLv = slot2
	slot7 = 0
	slot8 = 0
	slot9 = 0

	if slot6 == slot5 then
		slot0._txtnum.text = string.format("%d/%d", slot5, slot4)

		if slot4 == slot3 then
			slot8 = 1
		else
			slot8 = (slot5 - slot3) / (slot4 - slot3)
		end
	else
		slot0._txtnum.text = string.format("%d(%+d)/%d", slot5, slot6 - slot5, slot4)

		if slot5 < slot6 then
			if slot4 == slot3 then
				slot8 = 1
			else
				slot7 = (slot6 - slot3) / (slot4 - slot3)
				slot8 = (slot5 - slot3) / (slot4 - slot3)

				if slot4 < slot6 then
					slot10, slot11, slot12 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot6)
					slot9 = (slot6 - slot11) / (slot12 - slot11)
				end
			end
		elseif slot3 <= slot6 then
			slot7 = (slot5 - slot3) / (slot4 - slot3)
			slot8 = (slot6 - slot3) / (slot4 - slot3)
		else
			slot10, slot11, slot12 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot6)
			slot7 = 1
			slot8 = (slot6 - slot11) / (slot12 - slot11)
			slot9 = (slot5 - slot3) / (slot4 - slot3)
		end
	end

	slot0._slider1.fillAmount = slot7
	slot0._slider2.fillAmount = slot8
	slot0._slider3.fillAmount = slot9
end

function slot0.getStage(slot0, slot1)
	slot3 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	slot4 = 1

	if PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit) <= slot1 then
		slot4 = 3
	elseif slot3 <= slot1 then
		slot4 = 2
	end

	return slot4
end

function slot0.updateComplaint(slot0, slot1)
	slot2 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	slot3 = slot1
	slot5 = slot0:getStage(slot3)

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemoodicon, "v2a4_tutushizi_heart_" .. slot5)
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imagemood2, "v2a4_tutushizi_heartprogress_" .. slot5)

	if slot3 / slot2 > slot0._nextComplaint / slot2 then
		slot7 = slot6
		slot6 = slot7
	end

	slot0._imagemood1.fillAmount = slot7
	slot0._imagemood2.fillAmount = slot6
	slot0._txtmoodnum.text = string.format("%s/%s", slot3, slot2)
end

function slot0.onTweenEnd(slot0)
	gohelper.setActive(slot0._effectday, false)
	gohelper.setActive(slot0._effectday, true)

	slot0._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)
	slot0._canClose = true
	slot0._tweenId = nil

	gohelper.setActive(slot0._gotips, true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayTween, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	PinballController.instance:dispatchEvent(PinballEvent.EndRound)
	PinballController.instance:sendGuideMainLv()
end

function slot0.onClickModalMask(slot0)
	if not slot0._canClose then
		return
	end

	slot0:closeThis()
end

return slot0
