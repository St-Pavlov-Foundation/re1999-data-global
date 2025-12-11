module("modules.logic.necrologiststory.view.NecrologistStoryView", package.seeall)

local var_0_0 = class("NecrologistStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goTitle = gohelper.findChild(arg_1_0.viewGO, "Title")
	arg_1_0.animTitle = arg_1_0.goTitle:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Title/#txt_time")
	arg_1_0.txtPlace = gohelper.findChildTextMesh(arg_1_0.viewGO, "Title/#txt_place")
	arg_1_0.imageWeather = gohelper.findChildImage(arg_1_0.viewGO, "Title/#image_weather")
	arg_1_0.goWeatherRoot = gohelper.findChild(arg_1_0.viewGO, "#weather")
	arg_1_0.goLeft = gohelper.findChild(arg_1_0.viewGO, "left")
	arg_1_0.animLeft = arg_1_0.goLeft:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "left/#txt_title")
	arg_1_0.txtTitleEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "left/#txt_title/#txt_sectionEn")
	arg_1_0.simageSectionpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_sectionpic")
	arg_1_0.goLeftArea = gohelper.findChild(arg_1_0.viewGO, "left/simage_leftbg")
	arg_1_0.goDragPicture = gohelper.findChild(arg_1_0.viewGO, "left/#dragpicture")
	arg_1_0.goEnd = gohelper.findChild(arg_1_0.viewGO, "right/#go_end")
	arg_1_0.goEndTxt1 = gohelper.findChild(arg_1_0.viewGO, "right/#go_end/text")
	arg_1_0.goEndTxt2 = gohelper.findChild(arg_1_0.viewGO, "right/#go_end/text2")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.viewGO, "right/#go_Talk/Scroll DecView/Viewport/arrow")
	arg_1_0.scrollRect = gohelper.findChildComponent(arg_1_0.viewGO, "right/#go_Talk/Scroll DecView", gohelper.Type_LimitedScrollRect)
	arg_1_0.goContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content")
	arg_1_0.rectContent = arg_1_0.goContent.transform
	arg_1_0.storyItemList = {}
	arg_1_0.itemCount = 0
	arg_1_0.goLine = gohelper.findChild(arg_1_0.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content/#go_Line")
	arg_1_0.lineList = {}
	arg_1_0.normalSpace = 20
	arg_1_0.paragraphSpace = 40
	arg_1_0.bottomSpace = 30

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, arg_2_0.onClickNext, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, arg_2_0.onAutoChange, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, arg_2_0.onClickSkip, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, arg_2_0.onSelectSection, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, arg_2_0.onChangeWeather, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, arg_2_0.onChangePic, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, arg_3_0.onClickNext, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, arg_3_0.onAutoChange, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, arg_3_0.onClickSkip, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, arg_3_0.onSelectSection, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, arg_3_0.onChangeWeather, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, arg_3_0.onChangePic, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onChangePic(arg_5_0, arg_5_1)
	arg_5_0:setLeftPic(arg_5_1)
end

function var_0_0.onChangeWeather(arg_6_0, arg_6_1)
	arg_6_0:setWeather(arg_6_1)
end

function var_0_0.onSelectSection(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._storyGroupMo then
		return
	end

	arg_7_0._storyGroupMo:setSection(arg_7_1)
	arg_7_0:runNextStep(arg_7_2)
end

function var_0_0.onClickNext(arg_8_0)
	if not arg_8_0._storyGroupMo then
		return
	end

	if arg_8_0:isStoryFinish() then
		return
	end

	arg_8_0._storyGroupMo:setIsAuto(false)

	local var_8_0 = arg_8_0:getLastItem()

	if var_8_0 then
		var_8_0:onClickNext()

		if not var_8_0:isDone() then
			var_8_0:justDone()

			return
		end
	end

	arg_8_0:runNextStep()
end

function var_0_0.onAutoChange(arg_9_0)
	if not arg_9_0._storyGroupMo then
		return
	end

	if arg_9_0:isStoryFinish() then
		return
	end

	if not arg_9_0._storyGroupMo:getIsAuto() then
		return
	end

	local var_9_0 = arg_9_0:getLastItem()

	if var_9_0 and var_9_0:isDone() then
		arg_9_0:runNextStep()
	end
end

function var_0_0.onClickSkip(arg_10_0)
	if not arg_10_0._storyGroupMo then
		return
	end

	if arg_10_0:isStoryFinish() then
		return
	end

	arg_10_0._storyGroupMo:setIsAuto(false)

	local var_10_0 = arg_10_0:getLastItem()

	if var_10_0 and not var_10_0:isDone() then
		var_10_0:justDone()

		if not var_10_0:isDone() then
			return
		end
	end

	arg_10_0._storyGroupMo:onSkip()

	local var_10_1 = arg_10_0._storyGroupMo:getStatParam(arg_10_0:isInReview())

	var_10_1.lastText = arg_10_0:getLastText()

	NecrologistStoryStatController.instance:statStorySkip(var_10_1)

	while not arg_10_0:isStoryFinish() do
		arg_10_0:runNextStep(true)

		local var_10_2 = arg_10_0:getLastItem()

		if not var_10_2 or not var_10_2:isDone() then
			break
		end
	end

	if arg_10_0:isStoryFinish() then
		arg_10_0:onFinishStory()
	end
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_activity_meeting_book_open)
	arg_11_0:refreshViewParam()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:refreshViewParam()
end

function var_0_0.refreshViewParam(arg_13_0)
	arg_13_0.roleStoryId = arg_13_0.viewParam and arg_13_0.viewParam.roleStoryId

	local var_13_0 = arg_13_0.viewParam and arg_13_0.viewParam.storyGroupId

	arg_13_0:startStoryGroup(var_13_0)
end

function var_0_0.startStoryGroup(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	NecrologistStoryStatController.instance:startStoryStat()

	arg_14_0._storyGroupMo = arg_14_0:getStoryMo(arg_14_1)

	arg_14_0._storyGroupMo:initData()

	if arg_14_0.roleStoryId then
		NecrologistStoryModel.instance:getGameMO(arg_14_0.roleStoryId):setStoryState(arg_14_1, NecrologistStoryEnum.StoryState.Reading)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStart)

	arg_14_0.isFinish = false

	arg_14_0:setIsEnd(false)
	arg_14_0:clearAll()
	arg_14_0:refreshUI(arg_14_1)
	TaskDispatcher.runDelay(arg_14_0.runNextStep, arg_14_0, 0.1)
end

function var_0_0.refreshUI(arg_15_0, arg_15_1)
	local var_15_0 = NecrologistStoryConfig.instance:getPlotGroupCo(arg_15_1)

	if not var_15_0 then
		return
	end

	arg_15_0.txtTitle.text = var_15_0.storyName
	arg_15_0.txtTitleEn.text = var_15_0.storyNameEn

	local var_15_1, var_15_2 = NecrologistStoryHelper.getTimeFormat2(var_15_0.time)

	arg_15_0.txtTime.text = string.format("%d:%02d", var_15_1, var_15_2)
	arg_15_0.txtPlace.text = var_15_0.place

	arg_15_0:setLeftPic(var_15_0.storyPic)
	arg_15_0:setWeather(var_15_0.weather)
end

function var_0_0.setWeather(arg_16_0, arg_16_1)
	TaskDispatcher.cancelTask(arg_16_0._refreshWeather, arg_16_0)

	arg_16_0._lastWeather = arg_16_0._curWeather

	if arg_16_0._curWeather and arg_16_0._curWeather ~= arg_16_1 then
		arg_16_0._curWeather = arg_16_1

		arg_16_0.animTitle:Play("weather", 0, 0)
		TaskDispatcher.runDelay(arg_16_0._refreshWeather, arg_16_0, 0.16)
	else
		arg_16_0._curWeather = arg_16_1

		arg_16_0:_refreshWeather()
	end
end

function var_0_0._refreshWeather(arg_17_0)
	if arg_17_0._curWeather and arg_17_0._curWeather > 0 then
		gohelper.setActive(arg_17_0.imageWeather, true)

		if arg_17_0._curWeather < NecrologistStoryEnum.WeatherType.Flow then
			UISpriteSetMgr.instance:setRoleStorySprite(arg_17_0.imageWeather, string.format("rolestory_weather%s", arg_17_0._curWeather))
		end
	else
		gohelper.setActive(arg_17_0.imageWeather, false)
	end

	arg_17_0:playWeather()
end

function var_0_0.playWeather(arg_18_0)
	if not arg_18_0.goWeather then
		local var_18_0 = arg_18_0.viewContainer:getSetting().otherRes.weatherRes

		arg_18_0.goWeather = arg_18_0.viewContainer:getResInst(var_18_0, arg_18_0.goWeatherRoot, "weather")
		arg_18_0.weatherList = {}

		for iter_18_0, iter_18_1 in pairs(NecrologistStoryEnum.WeatherType2Name) do
			local var_18_1 = arg_18_0:getUserDataTb_()

			var_18_1.go = gohelper.findChild(arg_18_0.goWeather, iter_18_1)
			var_18_1.anim = var_18_1.go:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(var_18_1.go, false)

			arg_18_0.weatherList[iter_18_0] = var_18_1
		end
	end

	if arg_18_0._lastWeather == arg_18_0._curWeather then
		return
	end

	if arg_18_0._lastWeather then
		local var_18_2 = arg_18_0.weatherList[arg_18_0._lastWeather]

		if var_18_2 then
			if var_18_2.anim then
				gohelper.setActive(var_18_2.go, true)
				var_18_2.anim:Play("close", 0, 0)
			else
				gohelper.setActive(var_18_2.go, false)
			end
		end
	end

	if arg_18_0._curWeather then
		local var_18_3 = arg_18_0.weatherList[arg_18_0._curWeather]

		if var_18_3 then
			gohelper.setActive(var_18_3.go, true)

			if var_18_3.anim then
				var_18_3.anim:Play("open", 0, 0)
			end
		end
	end
end

function var_0_0.setLeftPic(arg_19_0, arg_19_1)
	TaskDispatcher.cancelTask(arg_19_0._refreshLeftPic, arg_19_0)

	if arg_19_0._curPicRes and arg_19_0._curPicRes ~= arg_19_1 then
		arg_19_0._curPicRes = arg_19_1

		arg_19_0.animLeft:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_19_0._refreshLeftPic, arg_19_0, 0.16)
	else
		arg_19_0._curPicRes = arg_19_1

		arg_19_0:_refreshLeftPic()
	end
end

function var_0_0._refreshLeftPic(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mln_day_night)

	if string.nilorempty(arg_20_0._curPicRes) then
		arg_20_0.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg("rolestory_pic_01"))
	else
		arg_20_0.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg(arg_20_0._curPicRes))
	end
end

function var_0_0.isStoryFinish(arg_21_0)
	if not arg_21_0._storyGroupMo:isStoryFinish() then
		return false
	end

	local var_21_0 = arg_21_0:getLastItem()

	if var_21_0 and not var_21_0:isDone() then
		return false
	end

	return true
end

function var_0_0.runNextStep(arg_22_0, arg_22_1)
	if arg_22_0:isStoryFinish() then
		arg_22_0:onFinishStory()

		return
	end

	arg_22_0._isSkip = arg_22_1

	TaskDispatcher.cancelTask(arg_22_0.realPlayNextStep, arg_22_0)

	if not arg_22_1 and arg_22_0._storyGroupMo:isNextStepNeedDelay() then
		TaskDispatcher.runDelay(arg_22_0.realPlayNextStep, arg_22_0, 0.75)
	else
		arg_22_0:realPlayNextStep()
	end
end

function var_0_0.realPlayNextStep(arg_23_0)
	arg_23_0._storyGroupMo:runNextStep()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryNextStep)

	local var_23_0 = arg_23_0._storyGroupMo:getCurStoryConfig()

	if not var_23_0 then
		arg_23_0:onFinishStory()

		return
	end

	arg_23_0:playStory(var_23_0, arg_23_0._isSkip)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnPlayStory, var_23_0.id)
end

function var_0_0.playStory(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1.type

	if arg_24_1.pause == 1 then
		arg_24_2 = false
	end

	local var_24_1 = arg_24_0[string.format("playStory_%s", var_24_0)]

	if var_24_1 then
		var_24_1(arg_24_0, arg_24_1, arg_24_2)
	else
		arg_24_0:runNextStep()
	end
end

function var_0_0.onItemPlayFinish(arg_25_0)
	if not arg_25_0._storyGroupMo:getIsAuto() then
		if arg_25_0:isStoryFinish() then
			arg_25_0:onFinishStory()
		end

		return
	end

	arg_25_0:runNextStep()
end

function var_0_0.refreshContentSize(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.index - 1
	local var_26_1 = arg_26_0.storyItemList[var_26_0]
	local var_26_2 = 0

	if var_26_1 then
		var_26_2 = var_26_1:getPosY() - var_26_1:getHeight()
	end

	local var_26_3 = var_26_2 - arg_26_0:getItemSpace(arg_26_1, var_26_1)

	arg_26_1:setPosY(var_26_3)

	local var_26_4 = arg_26_0:getLastItem()
	local var_26_5 = var_26_4:getPosY()
	local var_26_6 = math.abs(var_26_5) + var_26_4:getHeight() + arg_26_0.bottomSpace

	arg_26_0:setContentHeight(var_26_6)
end

function var_0_0.setContentHeight(arg_27_0, arg_27_1)
	if recthelper.getHeight(arg_27_0.rectContent) ~= arg_27_1 then
		arg_27_0:clearTweenBottom()
		recthelper.setHeight(arg_27_0.rectContent, arg_27_1)
		arg_27_0:moveToContentBottom()
	end
end

function var_0_0.moveToContentBottom(arg_28_0)
	local var_28_0 = arg_28_0.scrollRect.verticalNormalizedPosition
	local var_28_1 = 0

	if math.abs(var_28_0 - var_28_1) < 0.001 then
		return
	end

	local var_28_2 = 0.2

	arg_28_0._tweenBottomId = ZProj.TweenHelper.DOTweenFloat(var_28_0, var_28_1, var_28_2, arg_28_0._onTweenBottomUpdate, arg_28_0._onTweenBottomFinish, arg_28_0, nil, EaseType.Linear)
end

function var_0_0._onTweenBottomUpdate(arg_29_0, arg_29_1)
	arg_29_0.scrollRect.verticalNormalizedPosition = arg_29_1
end

function var_0_0._onTweenBottomFinish(arg_30_0)
	arg_30_0.scrollRect.verticalNormalizedPosition = 0
end

function var_0_0.clearTweenBottom(arg_31_0)
	if arg_31_0._tweenBottomId then
		ZProj.TweenHelper.KillById(arg_31_0._tweenBottomId)

		arg_31_0._tweenBottomId = nil
	end
end

function var_0_0.getItemSpace(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = 0

	if not arg_32_2 then
		return var_32_0
	end

	if arg_32_0:isDifferentParagraphs(arg_32_1, arg_32_2) then
		var_32_0 = arg_32_0.paragraphSpace
	else
		var_32_0 = arg_32_0.normalSpace
	end

	return var_32_0
end

function var_0_0.isDifferentParagraphs(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:getItemType()
	local var_33_1 = arg_33_2:getItemType()

	if var_33_0 == nil or var_33_1 == nil then
		return false
	end

	if var_33_0 == var_33_1 then
		return false
	end

	return true
end

function var_0_0.onFinishStory(arg_34_0)
	if arg_34_0.isFinish then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_revelation_open)

	arg_34_0.isFinish = true

	arg_34_0:setIsEnd(true, arg_34_0._storyGroupMo.config.isEnd == "1")
	arg_34_0._storyGroupMo:saveSituation()

	if arg_34_0.roleStoryId then
		NecrologistStoryModel.instance:getGameMO(arg_34_0.roleStoryId):setStoryState(arg_34_0._storyGroupMo.id, NecrologistStoryEnum.StoryState.Finish)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryEnd)

	local var_34_0 = arg_34_0._storyGroupMo:getStatParam(arg_34_0:isInReview())

	var_34_0.lastText = arg_34_0:getLastText()

	NecrologistStoryStatController.instance:statStoryEnd(var_34_0)
end

function var_0_0.setIsEnd(arg_35_0, arg_35_1, arg_35_2)
	gohelper.setActive(arg_35_0.goEnd, arg_35_1)
	gohelper.setActive(arg_35_0.goEndTxt1, arg_35_2)
	gohelper.setActive(arg_35_0.goEndTxt2, not arg_35_2)
	gohelper.setActive(arg_35_0.goArrow, not arg_35_1)
end

function var_0_0.getStoryMo(arg_36_0, arg_36_1)
	return (NecrologistStoryModel.instance:getStoryMO(arg_36_1))
end

function var_0_0.getLastItem(arg_37_0)
	return arg_37_0.storyItemList[arg_37_0.itemCount]
end

function var_0_0.clearStoryItem(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.storyItemList) do
		iter_38_1:destory()
	end

	arg_38_0.storyItemList = {}
	arg_38_0.itemCount = 0
end

function var_0_0.clearAll(arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0.realPlayNextStep, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0.runNextStep, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._refreshWeather, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._refreshLeftPic, arg_39_0)
	arg_39_0:clearTweenBottom()
	arg_39_0:clearStoryItem()
end

function var_0_0.playStory_location(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:createStoryItem(NecrologistStoryLocationItem, arg_40_1, arg_40_2)
end

function var_0_0.playStory_dialog(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:createStoryItem(NecrologistStoryDialogItem, arg_41_1, arg_41_2)
end

function var_0_0.playStory_aside(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0:createStoryItem(NecrologistStoryAsideItem, arg_42_1, arg_42_2)
end

function var_0_0.playStory_options(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0:createStoryItem(NecrologistStoryOptionsItem, arg_43_1, arg_43_2)
end

function var_0_0.playStory_system(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0:createStoryItem(NecrologistStorySystemItem, arg_44_1, arg_44_2)
end

function var_0_0.playStory_control(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0:addControl(arg_45_1, arg_45_2)
end

function var_0_0.playStory_situationValue(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = GameUtil.splitString2(arg_46_1.param, false, "|", "#")

	if var_46_0 then
		for iter_46_0, iter_46_1 in ipairs(var_46_0) do
			arg_46_0._storyGroupMo:addSituationValue(iter_46_1[1], tonumber(iter_46_1[2]))
		end
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSituationValue)
	arg_46_0:runNextStep(arg_46_2)
end

function var_0_0.playStory_situation(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0._storyGroupMo:compareSituationValue(arg_47_1.param)

	if var_47_0 then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, var_47_0, arg_47_2)
	end
end

function var_0_0.createStoryItem(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_1.getResPath()
	local var_48_1 = arg_48_0:getResInst(var_48_0, arg_48_0.goContent, tostring(arg_48_2.id))
	local var_48_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_48_1, arg_48_1, arg_48_0)

	arg_48_0:addItem(var_48_2)
	var_48_2:playStory(arg_48_2, arg_48_3, arg_48_0.onItemPlayFinish, arg_48_0, arg_48_0.refreshContentSize, arg_48_0)
	arg_48_0:tryAddLine()

	return var_48_2
end

function var_0_0.addItem(arg_49_0, arg_49_1)
	arg_49_0.itemCount = arg_49_0.itemCount + 1
	arg_49_1.index = arg_49_0.itemCount
	arg_49_0.storyItemList[arg_49_0.itemCount] = arg_49_1
end

function var_0_0.delItem(arg_50_0, arg_50_1)
	if not arg_50_1 then
		return
	end

	local var_50_0 = arg_50_1.index

	table.remove(arg_50_0.storyItemList, var_50_0)

	arg_50_0.itemCount = arg_50_0.itemCount - 1

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.storyItemList) do
		iter_50_1.index = iter_50_0
	end

	arg_50_1:destory()
	arg_50_0:runNextStep()
end

function var_0_0.addControl(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_1.id
	local var_51_1 = arg_51_1.addControl

	if string.nilorempty(var_51_1) then
		return
	end

	if not arg_51_0.controlMgr then
		arg_51_0.controlMgr = MonoHelper.addNoUpdateLuaComOnceToGo(arg_51_0.viewGO, NecrologistStoryControlMgrComp, arg_51_0)
	end

	arg_51_0.controlMgr:playControl(arg_51_1, arg_51_2, arg_51_3)
end

function var_0_0.createControlItem(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = arg_52_1.getResPath()
	local var_52_1 = arg_52_0:getResInst(var_52_0, arg_52_0.goContent, tostring(arg_52_2))
	local var_52_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_52_1, arg_52_1, arg_52_0)

	arg_52_0:addItem(var_52_2)
	var_52_2:playControl(arg_52_3, arg_52_4, arg_52_5, arg_52_0.refreshContentSize, arg_52_0)
	arg_52_0:tryAddLine()

	return var_52_2
end

function var_0_0.tryAddLine(arg_53_0)
	local var_53_0, var_53_1 = arg_53_0:isNeedAddLine()

	if var_53_0 then
		local var_53_2 = gohelper.cloneInPlace(arg_53_0.goLine, "line")

		recthelper.setAnchorY(var_53_2.transform, var_53_1)
		gohelper.setActive(var_53_2, true)
		table.insert(arg_53_0.lineList, var_53_2)
	end
end

function var_0_0.isNeedAddLine(arg_54_0)
	local var_54_0 = arg_54_0.itemCount
	local var_54_1 = arg_54_0.storyItemList[var_54_0]
	local var_54_2 = arg_54_0.storyItemList[var_54_0 - 1]

	if not var_54_1 or not var_54_2 then
		return false
	end

	local var_54_3 = 0
	local var_54_4 = arg_54_0:isDifferentParagraphs(var_54_1, var_54_2)

	if var_54_4 then
		local var_54_5 = arg_54_0:getItemSpace(var_54_1, var_54_2)

		var_54_3 = var_54_1:getPosY() + var_54_5 * 0.5
	end

	return var_54_4, var_54_3
end

function var_0_0.isInLeftArea(arg_55_0, arg_55_1)
	if not arg_55_1 or not arg_55_0.goLeftArea then
		return false
	end

	local var_55_0 = CameraMgr.instance:getUICamera()
	local var_55_1, var_55_2 = recthelper.uiPosToScreenPos2(arg_55_1)

	return recthelper.screenPosInRect(arg_55_0.goLeftArea.transform, var_55_0, var_55_1, var_55_2)
end

function var_0_0.onDragPicEnable(arg_56_0, arg_56_1)
	gohelper.setActive(arg_56_0.goDragPicture, arg_56_1)
end

function var_0_0.onClose(arg_57_0)
	if arg_57_0.roleStoryId then
		local var_57_0 = NecrologistStoryModel.instance:getGameMO(arg_57_0.roleStoryId)
		local var_57_1 = arg_57_0._storyGroupMo.id

		if RoleStoryConfig.instance:getStoryById(arg_57_0.roleStoryId).cgUnlockStoryId == var_57_1 and var_57_0:isStoryFinish(var_57_1) then
			NecrologistStoryController.instance:openCgUnlockView(arg_57_0.roleStoryId)
		end
	end

	local var_57_2 = arg_57_0._storyGroupMo:getStatParam(arg_57_0:isInReview())

	var_57_2.lastText = arg_57_0:getLastText()

	NecrologistStoryStatController.instance:statStoryInterrupt(var_57_2)
end

function var_0_0.isInReview(arg_58_0)
	return arg_58_0.roleStoryId == nil
end

function var_0_0.getLastText(arg_59_0)
	for iter_59_0 = #arg_59_0.storyItemList, 1, -1 do
		local var_59_0 = arg_59_0.storyItemList[iter_59_0]:getTextStr()

		if not string.nilorempty(var_59_0) then
			return var_59_0
		end
	end

	return ""
end

function var_0_0.onDestroyView(arg_60_0)
	arg_60_0:clearAll()
	arg_60_0.simageSectionpic:UnLoadImage()
end

return var_0_0
