module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkView", package.seeall)

local var_0_0 = class("DiceHeroTalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_title")
	arg_1_0._goNarration = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_narration")
	arg_1_0._gotalk = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_talk")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_item")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/arrow")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._scrollRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._rewardFullBg = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_reward/#go_fullbg")
	arg_1_0._transcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content").transform
	arg_1_0.scrollContent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._transscroll = arg_1_0.scrollContent.transform
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addSpace(ViewName.DiceHeroTalkView, arg_2_0._clickSpace, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchDown, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_2_0.onTouchUp, arg_2_0)
	arg_2_0.scrollContent:AddOnValueChanged(arg_2_0.onScrollValueChanged, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._skipStory, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.scrollContent:RemoveOnValueChanged()
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam and arg_4_0.viewParam.co
	local var_4_1 = DiceHeroModel.instance:getGameInfo(var_4_0.chapter)

	if not var_4_0 then
		logError("配置不存在？？" .. tostring(var_4_1.currLevel))

		return
	end

	arg_4_0._co = var_4_0
	DiceHeroModel.instance.talkId = var_4_0.dialog
	DiceHeroModel.instance.stepId = 0

	local var_4_2 = lua_dice_dialogue.configDict[var_4_0.dialog]

	if not var_4_2 then
		logError("对话配置不存在" .. tostring(var_4_0.dialog))

		return
	end

	gohelper.setActive(arg_4_0._goNarration, false)
	gohelper.setActive(arg_4_0._gotalk, false)
	gohelper.setActive(arg_4_0._rewardFullBg, false)

	local var_4_3 = {}
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		if iter_4_1.type == DiceHeroEnum.DialogContentType.Title then
			arg_4_0._txtTitle.text = iter_4_1.desc
		elseif iter_4_1.type == DiceHeroEnum.DialogContentType.Narration then
			local var_4_5 = gohelper.cloneInPlace(arg_4_0._goNarration)

			if iter_4_1.line ~= 1 then
				local var_4_6 = gohelper.findChild(var_4_5, "line")

				gohelper.setActive(var_4_6, false)
			end

			local var_4_7 = gohelper.findChildTextMesh(var_4_5, "txt")

			var_4_7.text = ""

			local var_4_8 = IconMgr.instance:getCommonTextMarkTop(var_4_7.gameObject):GetComponent(gohelper.Type_TextMesh)
			local var_4_9 = gohelper.onceAddComponent(var_4_7.gameObject, typeof(ZProj.TMPMark))

			var_4_9:SetMarkTopGo(var_4_8.gameObject)
			var_4_9:SetTopOffset(0, -2)

			local var_4_10 = StoryTool.filterMarkTop(iter_4_1.desc)
			local var_4_11 = GameUtil.getUCharArrWithoutRichTxt(var_4_10)
			local var_4_12 = StoryTool.getMarkTopTextList(iter_4_1.desc)

			table.insert(var_4_3, var_4_5)
			table.insert(var_4_4, {
				isEnd = false,
				markTopList = var_4_12,
				conMark = var_4_9,
				txt = var_4_7,
				chars = var_4_11,
				stepId = iter_4_1.step
			})
		else
			local var_4_13 = gohelper.cloneInPlace(arg_4_0._gotalk)
			local var_4_14 = gohelper.findChildTextMesh(var_4_13, "txt")

			var_4_14.text = ""

			local var_4_15 = IconMgr.instance:getCommonTextMarkTop(var_4_14.gameObject):GetComponent(gohelper.Type_TextMesh)
			local var_4_16 = gohelper.onceAddComponent(var_4_14.gameObject, typeof(ZProj.TMPMark))

			var_4_16:SetMarkTopGo(var_4_15.gameObject)
			var_4_16:SetTopOffset(0, -2)

			local var_4_17 = iter_4_1.speaker .. iter_4_1.desc
			local var_4_18 = StoryTool.filterMarkTop(var_4_17)
			local var_4_19 = GameUtil.getUCharArrWithoutRichTxt(var_4_18)
			local var_4_20 = StoryTool.getMarkTopTextList(var_4_17)

			table.insert(var_4_3, var_4_13)
			table.insert(var_4_4, {
				isEnd = false,
				markTopList = var_4_20,
				conMark = var_4_16,
				txt = var_4_14,
				chars = var_4_19,
				stepId = iter_4_1.step
			})
		end
	end

	if var_4_1:hasReward() and var_4_1.currLevel == arg_4_0._co.id and not var_4_1.allPass then
		local var_4_21 = var_4_1.rewardItems

		if arg_4_0._co.mode == 1 then
			var_4_21 = {}

			for iter_4_2, iter_4_3 in ipairs(var_4_1.rewardItems) do
				if iter_4_3.type == DiceHeroEnum.RewardType.Hero then
					arg_4_0._noShowBg = true

					gohelper.setActive(arg_4_0._rewardFullBg, true)

					iter_4_3.index = iter_4_2

					table.insert(var_4_21, iter_4_3)

					local var_4_22 = lua_dice_character.configDict[iter_4_3.id]

					if not string.nilorempty(var_4_22.relicIds) then
						for iter_4_4, iter_4_5 in ipairs(string.splitToNumber(var_4_22.relicIds, "#")) do
							local var_4_23 = DiceHeroRewardMo.New()

							var_4_23.id = iter_4_5
							var_4_23.type = DiceHeroEnum.RewardType.Relic
							var_4_23.index = iter_4_2

							table.insert(var_4_21, var_4_23)
						end
					end

					if not string.nilorempty(var_4_22.skilllist) then
						for iter_4_6, iter_4_7 in ipairs(string.splitToNumber(var_4_22.skilllist, "#")) do
							local var_4_24 = DiceHeroRewardMo.New()

							var_4_24.id = iter_4_7
							var_4_24.type = DiceHeroEnum.RewardType.SkillCard
							var_4_24.index = iter_4_2

							table.insert(var_4_21, var_4_24)
						end
					end
				else
					iter_4_3.index = iter_4_2

					table.insert(var_4_21, iter_4_3)
				end
			end
		else
			for iter_4_8, iter_4_9 in ipairs(var_4_1.rewardItems) do
				iter_4_9.isShowAll = nil
			end
		end

		arg_4_0._rewardItem = var_4_21

		gohelper.CreateObjList(arg_4_0, arg_4_0._createRewardItem, var_4_21, arg_4_0._goreward, arg_4_0._gorewarditem, nil, nil, nil, 1)
		gohelper.setAsLastSibling(arg_4_0._goreward)
		table.insert(var_4_3, arg_4_0._goreward)
	end

	gohelper.setActive(arg_4_0._goreward, false)

	arg_4_0._contentGos = var_4_3
	arg_4_0._contentTxts = var_4_4

	gohelper.setActive(arg_4_0._goarrow, true)
	arg_4_0:nextStep()
	TaskDispatcher.runRepeat(arg_4_0._autoSpeak, arg_4_0, 0.02)

	if arg_4_0._rewardItem and var_4_0.isSkip == 1 then
		arg_4_0:_realSkipStory()
	end
end

function var_0_0.onTouchDown(arg_5_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		arg_5_0._isKeyDown = false

		return
	end

	if not arg_5_0._tweenId then
		arg_5_0._isKeyDown = true
	end
end

function var_0_0._clickSpace(arg_6_0)
	if not arg_6_0._tweenId then
		arg_6_0:nextStep()
	end
end

function var_0_0.onTouchUp(arg_7_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroTalkView) then
		return
	end

	if arg_7_0._isKeyDown then
		if arg_7_0._contentGos[1] then
			arg_7_0:nextStep()
		else
			local var_7_0 = DiceHeroModel.instance:getGameInfo(arg_7_0._co.chapter)

			if not var_7_0:hasReward() and var_7_0.currLevel == arg_7_0._co.id or var_7_0.currLevel ~= arg_7_0._co.id then
				if not arg_7_0._isSendStat then
					DiceHeroStatHelper.instance:sendStoryEnd(true, false)
				end

				arg_7_0._isSendStat = true

				arg_7_0:closeThis()
			end
		end
	end
end

function var_0_0.onScrollValueChanged(arg_8_0, arg_8_1, arg_8_2)
	if math.abs(arg_8_2) > 0.05 then
		arg_8_0._isKeyDown = false
	end
end

function var_0_0._autoSpeak(arg_9_0)
	if not arg_9_0._curTxtData or arg_9_0._curTxtData.isEnd then
		if arg_9_0._curTxtData and not arg_9_0._curTxtData.isScrollEnd then
			arg_9_0._curTxtData.isScrollEnd = true
			arg_9_0.scrollContent.verticalNormalizedPosition = 0
		end

		return
	end

	local var_9_0 = (arg_9_0._curTxtData.index or 0) + 1

	arg_9_0._curTxtData.index = var_9_0
	arg_9_0._curTxtData.txt.text = table.concat(arg_9_0._curTxtData.chars, "", 1, var_9_0)
	arg_9_0._curTxtData.isEnd = var_9_0 >= #arg_9_0._curTxtData.chars
	arg_9_0.scrollContent.verticalNormalizedPosition = 0

	if arg_9_0._curTxtData.isEnd then
		if arg_9_0._curTxtData then
			local var_9_1 = arg_9_0._curTxtData

			TaskDispatcher.runDelay(function()
				var_9_1.conMark:SetMarksTop(var_9_1.markTopList)
			end, nil, 0.01)
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
	end
end

function var_0_0.nextStep(arg_11_0)
	if arg_11_0._curTxtData and not arg_11_0._curTxtData.isEnd then
		arg_11_0._curTxtData.index = #arg_11_0._curTxtData.chars - 1

		return
	end

	if arg_11_0._curTxtData then
		local var_11_0 = arg_11_0._curTxtData

		TaskDispatcher.runDelay(function()
			var_11_0.conMark:SetMarksTop(var_11_0.markTopList)
		end, nil, 0.01)
	end

	local var_11_1 = table.remove(arg_11_0._contentGos, 1)

	arg_11_0._curTxtData = table.remove(arg_11_0._contentTxts, 1)

	if arg_11_0._curTxtData then
		DiceHeroModel.instance.stepId = arg_11_0._curTxtData.stepId or DiceHeroModel.instance.stepId

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_feichi_yure_caption)
	else
		gohelper.setActive(arg_11_0._btnSkip, false)
	end

	if not var_11_1 then
		gohelper.setActive(arg_11_0._goarrow, false)
		arg_11_0:checkSendLevelReq()

		return
	end

	if not arg_11_0._contentGos[1] then
		gohelper.setActive(arg_11_0._goarrow, false)
		arg_11_0:checkSendLevelReq()
	end

	gohelper.setActive(var_11_1, true)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0._transcontent)

	local var_11_2 = recthelper.getHeight(arg_11_0._transcontent)
	local var_11_3 = recthelper.getHeight(arg_11_0._transscroll)

	arg_11_0:killTween()

	if var_11_3 < var_11_2 and not arg_11_0._curTxtData then
		local var_11_4 = recthelper.getHeight(arg_11_0._goreward.transform)
		local var_11_5 = Mathf.Clamp(1 - (var_11_2 - var_11_4) / (var_11_2 - var_11_3), 0, 1)

		arg_11_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_11_0.scrollContent.verticalNormalizedPosition, var_11_5, 0.3, arg_11_0.tweenFrameCallback, arg_11_0.tweenFinishCallback, arg_11_0)
	end
end

function var_0_0._skipStory(arg_13_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, arg_13_0._realSkipStory, nil, nil, arg_13_0)
end

function var_0_0._realSkipStory(arg_14_0)
	if not arg_14_0._rewardItem then
		if not arg_14_0:checkSendLevelReq(true) then
			arg_14_0:closeThis()
		end

		return
	end

	if arg_14_0._curTxtData then
		arg_14_0._curTxtData.txt.text = table.concat(arg_14_0._curTxtData.chars, "")
		arg_14_0._curTxtData = nil
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._contentTxts) do
		iter_14_1.txt.text = table.concat(iter_14_1.chars, "")
	end

	tabletool.clear(arg_14_0._contentTxts)

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._contentGos) do
		gohelper.setActive(iter_14_3, true)
	end

	tabletool.clear(arg_14_0._contentGos)
	ZProj.UGUIHelper.RebuildLayout(arg_14_0._transcontent)

	local var_14_0 = recthelper.getHeight(arg_14_0._transcontent)
	local var_14_1 = recthelper.getHeight(arg_14_0._transscroll)
	local var_14_2 = recthelper.getHeight(arg_14_0._goreward.transform)

	arg_14_0.scrollContent.verticalNormalizedPosition = Mathf.Clamp(1 - (var_14_0 - var_14_2) / (var_14_0 - var_14_1), 0, 1)

	gohelper.setActive(arg_14_0._btnSkip, false)
	gohelper.setActive(arg_14_0._goarrow, false)
end

function var_0_0.checkSendLevelReq(arg_15_0, arg_15_1)
	local var_15_0 = DiceHeroModel.instance:getGameInfo(arg_15_0._co.chapter)

	if var_15_0.currLevel == arg_15_0._co.id and not var_15_0.allPass and arg_15_0._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
		if arg_15_1 then
			DiceHeroRpc.instance:sendDiceHeroEnterStory(arg_15_0._co.id, arg_15_0._co.chapter, arg_15_0.closeThis, arg_15_0)
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(arg_15_0._co.id, arg_15_0._co.chapter)
		end

		DiceHeroStatHelper.instance:sendStoryEnd(true, true)

		arg_15_0._isSendStat = true

		return true
	end
end

function var_0_0.tweenFrameCallback(arg_16_0, arg_16_1)
	arg_16_0.scrollContent.verticalNormalizedPosition = arg_16_1
end

function var_0_0.tweenFinishCallback(arg_17_0)
	arg_17_0._tweenId = nil
end

function var_0_0.killTween(arg_18_0)
	if arg_18_0._tweenId then
		ZProj.TweenHelper.KillById(arg_18_0._tweenId)

		arg_18_0._tweenId = nil
	end
end

function var_0_0._createRewardItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChildTextMesh(arg_19_1, "#txt_title")
	local var_19_1 = gohelper.findChildTextMesh(arg_19_1, "scroll_desc/viewport/#txt_desc")
	local var_19_2 = gohelper.findChild(arg_19_1, "scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	local var_19_3 = gohelper.findChildButtonWithAudio(arg_19_1, "#btn_choose")
	local var_19_4 = gohelper.findChild(arg_19_1, "#btn_choose/line")
	local var_19_5 = gohelper.findChildSingleImage(arg_19_1, "headbg/#simage_icon")
	local var_19_6 = gohelper.findChildImage(arg_19_1, "headbg/#go_cardicon")
	local var_19_7 = gohelper.findChild(arg_19_1, "bg")
	local var_19_8 = gohelper.findChildAnim(arg_19_1, "")

	var_19_2.parentGameObject = arg_19_0._scrollRoot

	if arg_19_0._noShowBg then
		gohelper.setActive(var_19_7, false)
		gohelper.setActive(var_19_4, false)

		if arg_19_2.type ~= DiceHeroEnum.RewardType.Hero then
			gohelper.setActive(var_19_3, false)
		end
	end

	arg_19_2.anim = var_19_8

	arg_19_0:removeClickCb(var_19_3)
	arg_19_0:addClickCb(var_19_3, arg_19_0._onClickSelect, arg_19_0, {
		index = arg_19_2.index or arg_19_3,
		data = arg_19_2
	})
	gohelper.setActive(var_19_6, false)
	gohelper.setActive(var_19_5, true)

	if arg_19_2.type == DiceHeroEnum.RewardType.Hero then
		local var_19_9 = lua_dice_character.configDict[arg_19_2.id]

		var_19_0.text = var_19_9 and var_19_9.name or ""
		var_19_1.text = var_19_9 and var_19_9.desc or ""

		var_19_5:LoadImage(ResUrl.getHeadIconSmall(var_19_9.icon))
	elseif arg_19_2.type == DiceHeroEnum.RewardType.SkillCard then
		local var_19_10 = lua_dice_card.configDict[arg_19_2.id]

		var_19_0.text = var_19_10 and var_19_10.name or ""
		var_19_1.text = var_19_10 and var_19_10.desc or ""

		UISpriteSetMgr.instance:setDiceHeroSprite(var_19_6, "dicehero_cardicon_" .. var_19_10.quality)
		gohelper.setActive(var_19_6, true)
		gohelper.setActive(var_19_5, false)
	elseif arg_19_2.type == DiceHeroEnum.RewardType.Relic then
		local var_19_11 = lua_dice_relic.configDict[arg_19_2.id]

		var_19_0.text = var_19_11 and var_19_11.name or ""
		var_19_1.text = var_19_11 and var_19_11.desc or ""

		var_19_5:LoadImage("singlebg/v2a6_dicehero_singlebg/collection/" .. var_19_11.icon .. ".png")
	end

	var_19_8:Play("open", 0, 0)
end

function var_0_0._onClickSelect(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.data

	if var_20_0.type == DiceHeroEnum.RewardType.Hero and arg_20_0._co.mode == 2 and not var_20_0.isShowAll then
		var_20_0.isShowAll = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)

		local var_20_1 = {}

		var_20_0.index = arg_20_1.index

		table.insert(var_20_1, var_20_0)

		local var_20_2 = lua_dice_character.configDict[var_20_0.id]

		if not string.nilorempty(var_20_2.relicIds) then
			for iter_20_0, iter_20_1 in ipairs(string.splitToNumber(var_20_2.relicIds, "#")) do
				local var_20_3 = DiceHeroRewardMo.New()

				var_20_3.id = iter_20_1
				var_20_3.type = DiceHeroEnum.RewardType.Relic
				var_20_3.index = arg_20_1.index

				table.insert(var_20_1, var_20_3)
			end
		end

		if not string.nilorempty(var_20_2.skilllist) then
			for iter_20_2, iter_20_3 in ipairs(string.splitToNumber(var_20_2.skilllist, "#")) do
				local var_20_4 = DiceHeroRewardMo.New()

				var_20_4.id = iter_20_3
				var_20_4.type = DiceHeroEnum.RewardType.SkillCard
				var_20_4.index = arg_20_1.index

				table.insert(var_20_1, var_20_4)
			end
		end

		arg_20_0._rewardItem = var_20_1

		var_20_0.anim:Play("finish", 0, 0)
		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(arg_20_0._delayRefrshReward, arg_20_0, 0.5)

		return
	end

	local var_20_5 = DiceHeroModel.instance:getGameInfo(arg_20_0._co.chapter)
	local var_20_6 = {}

	arg_20_0._allGetIndexes = {}

	if arg_20_0._co.rewardSelectType == DiceHeroEnum.GetRewardType.One then
		table.insert(var_20_6, arg_20_1.index - 1)

		arg_20_0._allGetIndexes[arg_20_1.index] = true

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
	else
		for iter_20_4, iter_20_5 in ipairs(var_20_5.rewardItems) do
			table.insert(var_20_6, iter_20_4 - 1)

			arg_20_0._allGetIndexes[iter_20_4] = true
		end

		if #var_20_6 > 1 then
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards_rare)
		else
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_rewards)
		end
	end

	DiceHeroRpc.instance:sendDiceHeroGetReward(var_20_6, arg_20_0._co.chapter, arg_20_0._getReward, arg_20_0)
end

function var_0_0._delayRefrshReward(arg_21_0)
	gohelper.setActive(arg_21_0._rewardFullBg, true)

	arg_21_0._noShowBg = true

	gohelper.CreateObjList(arg_21_0, arg_21_0._createRewardItem, arg_21_0._rewardItem, arg_21_0._goreward, arg_21_0._gorewarditem, nil, nil, nil, 1)
end

function var_0_0._getReward(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 == 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._rewardItem) do
			local var_22_0 = iter_22_1.index or iter_22_0

			if arg_22_0._allGetIndexes[var_22_0] then
				iter_22_1.anim:Play("finish", 0, 0)
			end
		end

		UIBlockHelper.instance:startBlock("DiceHeroTalkView_GetReward", 0.5)
		TaskDispatcher.runDelay(arg_22_0.closeThis, arg_22_0, 0.5)

		if arg_22_0._co.type == 1 then
			DiceHeroStatHelper.instance:sendStoryEnd(true, true)

			arg_22_0._isSendStat = true
		end
	end
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayRefrshReward, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._autoSpeak, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.closeThis, arg_23_0)
	arg_23_0:killTween()

	arg_23_0._contentGos = {}

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.stop_ui_feichi_yure_caption)
end

function var_0_0.onClose(arg_24_0)
	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return var_0_0
