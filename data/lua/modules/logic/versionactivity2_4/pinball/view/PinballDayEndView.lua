module("modules.logic.versionactivity2_4.pinball.view.PinballDayEndView", package.seeall)

local var_0_0 = class("PinballDayEndView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtday = gohelper.findChildTextMesh(arg_1_0.viewGO, "bg/#txt_day")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtmainlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_main/#txt_lv")
	arg_1_0._slider1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_main/#go_slider/#go_slider1")
	arg_1_0._slider2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_main/#go_slider/#go_slider2")
	arg_1_0._slider3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_main/#go_slider/#go_slider3")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_main/#txt_num")
	arg_1_0._imagemoodicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_mood/#simage_icon")
	arg_1_0._imagemood1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_mood/#simage_progress1")
	arg_1_0._imagemood2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_mood/#simage_progress2")
	arg_1_0._txtmoodnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_mood/mask/#txt_mood")
	arg_1_0._goarrow1 = gohelper.findChild(arg_1_0.viewGO, "txt_dec/#go_arrow")
	arg_1_0._goarrow2 = gohelper.findChild(arg_1_0.viewGO, "txt_dec2/#go_arrow")
	arg_1_0._txtdescmood = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_mood/mask2/#txt_desc")
	arg_1_0._godescmainitem = gohelper.findChild(arg_1_0.viewGO, "#go_main/layout/tag1")
	arg_1_0._godescmood = gohelper.findChild(arg_1_0.viewGO, "#go_mood/mask2")
	arg_1_0._effectday = gohelper.findChild(arg_1_0.viewGO, "bg/vx_nextday")
	arg_1_0._effectnextlv = gohelper.findChild(arg_1_0.viewGO, "#go_main/vx_nextlevel")
end

function var_0_0.onOpen(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio9)
	gohelper.setActive(arg_2_0._gotips, false)

	arg_2_0._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), arg_2_0.viewParam.day)
	arg_2_0._canClose = false
	arg_2_0._beforeScore, arg_2_0._nextScore = arg_2_0.viewParam.preScore, arg_2_0.viewParam.nextScore
	arg_2_0._beforeComplaint, arg_2_0._nextComplaint = arg_2_0.viewParam.preComplaint, arg_2_0.viewParam.nextComplaint

	gohelper.setActive(arg_2_0._goarrow1, arg_2_0._nextScore > arg_2_0._beforeScore)
	gohelper.setActive(arg_2_0._goarrow2, arg_2_0._nextComplaint > arg_2_0._beforeComplaint)
	arg_2_0:updateTxt()
	TaskDispatcher.runDelay(arg_2_0._delayTween, arg_2_0, 1)

	if arg_2_0._beforeScore == arg_2_0._nextScore and arg_2_0._beforeComplaint == arg_2_0._nextComplaint then
		arg_2_0:_onTween(1)

		return
	end

	arg_2_0:_onTween(0)
end

function var_0_0._delayTween(arg_3_0)
	if arg_3_0._beforeScore == arg_3_0._nextScore and arg_3_0._beforeComplaint == arg_3_0._nextComplaint then
		arg_3_0:onTweenEnd()

		return
	end

	arg_3_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, arg_3_0._onTween, arg_3_0.onTweenEnd, arg_3_0)
end

function var_0_0._onTween(arg_4_0, arg_4_1)
	arg_4_0:updateScore(math.floor(arg_4_1 * (arg_4_0._nextScore - arg_4_0._beforeScore) + arg_4_0._beforeScore))
	arg_4_0:updateComplaint(math.floor(arg_4_1 * (arg_4_0._nextComplaint - arg_4_0._beforeComplaint) + arg_4_0._beforeComplaint))
end

function var_0_0.updateTxt(arg_5_0)
	local var_5_0 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, arg_5_0.viewParam.preMaxProsperity)
	local var_5_1 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, arg_5_0.viewParam.nextMaxProsperity)
	local var_5_2 = {}

	for iter_5_0 = var_5_0 + 1, var_5_1 do
		local var_5_3 = lua_activity178_score.configDict[VersionActivity2_4Enum.ActivityId.Pinball][iter_5_0]

		if not string.nilorempty(var_5_3.showTxt) then
			local var_5_4 = string.splitToNumber(var_5_3.showTxt, "#")

			for iter_5_1, iter_5_2 in pairs(var_5_4) do
				var_5_2[iter_5_2] = true
			end
		end
	end

	local var_5_5 = {}

	for iter_5_3 in pairs(var_5_2) do
		table.insert(var_5_5, iter_5_3)
	end

	table.sort(var_5_5)

	local var_5_6 = {}

	for iter_5_4, iter_5_5 in ipairs(var_5_5) do
		local var_5_7 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_score_desc_" .. iter_5_5), iter_5_4)

		table.insert(var_5_6, var_5_7)
	end

	gohelper.CreateObjList(arg_5_0, arg_5_0._createMainDescItem, var_5_6, nil, arg_5_0._godescmainitem)

	local var_5_8 = arg_5_0:getStage(arg_5_0.viewParam.preComplaint)
	local var_5_9 = arg_5_0:getStage(arg_5_0.viewParam.nextComplaint)
	local var_5_10 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)

	if var_5_9 == 3 then
		var_5_10 = var_5_10 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif var_5_9 == 2 then
		var_5_10 = var_5_10 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	if var_5_9 < var_5_8 then
		gohelper.setActive(arg_5_0._godescmood, true)

		arg_5_0._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_2"), var_5_10)
	elseif var_5_8 < var_5_9 then
		gohelper.setActive(arg_5_0._godescmood, true)

		arg_5_0._txtdescmood.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_holenum_desc_1"), var_5_10)
	else
		gohelper.setActive(arg_5_0._godescmood, false)

		arg_5_0._txtdescmood.text = ""
	end
end

function var_0_0._createMainDescItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	gohelper.findChildTextMesh(arg_6_1, "#txt_desc").text = arg_6_2
end

function var_0_0.updateScore(arg_7_0, arg_7_1)
	local var_7_0, var_7_1, var_7_2 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, arg_7_1)
	local var_7_3 = arg_7_1
	local var_7_4 = arg_7_0._nextScore

	arg_7_0._txtmainlv.text = var_7_0

	if arg_7_0._cacheLv and var_7_0 > arg_7_0._cacheLv then
		gohelper.setActive(arg_7_0._effectnextlv, false)
		gohelper.setActive(arg_7_0._effectnextlv, true)
	end

	arg_7_0._cacheLv = var_7_0

	local var_7_5 = 0
	local var_7_6 = 0
	local var_7_7 = 0

	if var_7_4 == var_7_3 then
		arg_7_0._txtnum.text = string.format("%d/%d", var_7_3, var_7_2)

		if var_7_2 == var_7_1 then
			var_7_6 = 1
		else
			var_7_6 = (var_7_3 - var_7_1) / (var_7_2 - var_7_1)
		end
	else
		arg_7_0._txtnum.text = string.format("%d(%+d)/%d", var_7_3, var_7_4 - var_7_3, var_7_2)

		if var_7_3 < var_7_4 then
			if var_7_2 == var_7_1 then
				var_7_6 = 1
			else
				var_7_5 = (var_7_4 - var_7_1) / (var_7_2 - var_7_1)
				var_7_6 = (var_7_3 - var_7_1) / (var_7_2 - var_7_1)

				if var_7_2 < var_7_4 then
					local var_7_8, var_7_9, var_7_10 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_7_4)

					var_7_7 = (var_7_4 - var_7_9) / (var_7_10 - var_7_9)
				end
			end
		elseif var_7_1 <= var_7_4 then
			var_7_5 = (var_7_3 - var_7_1) / (var_7_2 - var_7_1)
			var_7_6 = (var_7_4 - var_7_1) / (var_7_2 - var_7_1)
		else
			local var_7_11, var_7_12, var_7_13 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_7_4)

			var_7_5 = 1
			var_7_6 = (var_7_4 - var_7_12) / (var_7_13 - var_7_12)
			var_7_7 = (var_7_3 - var_7_1) / (var_7_2 - var_7_1)
		end
	end

	arg_7_0._slider1.fillAmount = var_7_5
	arg_7_0._slider2.fillAmount = var_7_6
	arg_7_0._slider3.fillAmount = var_7_7
end

function var_0_0.getStage(arg_8_0, arg_8_1)
	local var_8_0 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local var_8_1 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold)
	local var_8_2 = 1

	if var_8_0 <= arg_8_1 then
		var_8_2 = 3
	elseif var_8_1 <= arg_8_1 then
		var_8_2 = 2
	end

	return var_8_2
end

function var_0_0.updateComplaint(arg_9_0, arg_9_1)
	local var_9_0 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit)
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_0._nextComplaint
	local var_9_3 = arg_9_0:getStage(var_9_1)

	UISpriteSetMgr.instance:setAct178Sprite(arg_9_0._imagemoodicon, "v2a4_tutushizi_heart_" .. var_9_3)
	UISpriteSetMgr.instance:setAct178Sprite(arg_9_0._imagemood2, "v2a4_tutushizi_heartprogress_" .. var_9_3)

	local var_9_4 = var_9_1 / var_9_0
	local var_9_5 = var_9_2 / var_9_0

	if var_9_5 < var_9_4 then
		var_9_4, var_9_5 = var_9_5, var_9_4
	end

	arg_9_0._imagemood1.fillAmount = var_9_5
	arg_9_0._imagemood2.fillAmount = var_9_4
	arg_9_0._txtmoodnum.text = string.format("%s/%s", var_9_1, var_9_0)
end

function var_0_0.onTweenEnd(arg_10_0)
	gohelper.setActive(arg_10_0._effectday, false)
	gohelper.setActive(arg_10_0._effectday, true)

	arg_10_0._txtday.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_day"), PinballModel.instance.day)
	arg_10_0._canClose = true
	arg_10_0._tweenId = nil

	gohelper.setActive(arg_10_0._gotips, true)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayTween, arg_11_0)

	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end

	PinballController.instance:dispatchEvent(PinballEvent.EndRound)
	PinballController.instance:sendGuideMainLv()
end

function var_0_0.onClickModalMask(arg_12_0)
	if not arg_12_0._canClose then
		return
	end

	arg_12_0:closeThis()
end

return var_0_0
