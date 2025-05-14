module("modules.logic.dungeon.view.DungeonRewardView", package.seeall)

local var_0_0 = class("DungeonRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward")
	arg_1_0._goreward1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1")
	arg_1_0._gonormalstars = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_normalstars")
	arg_1_0._gohardlstars = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_hardlstars")
	arg_1_0._gocontent1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/#go_content1")
	arg_1_0._goreward2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward2")
	arg_1_0._gocontent2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward2/#go_content2")
	arg_1_0._goreward3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3")
	arg_1_0._txtspecialtitle = gohelper.findChildText(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/title/#txt_specialtitle")
	arg_1_0._gocontent3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/#go_content3")
	arg_1_0._goreward0 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward0")
	arg_1_0._gocontent0 = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_reward0/#go_content0")
	arg_1_0._goactreward = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_actreward")
	arg_1_0._goactcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_actreward/#go_actcontent")
	arg_1_0._godoubledropreward = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward")
	arg_1_0._godoubledropcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward/#go_content3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnbackOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnmainOnClick(arg_5_0)
	ViewMgr.instance:closeAllPopupViews()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simageList = arg_6_0:getUserDataTb_()

	local var_6_0 = arg_6_0._goreward0.transform:GetSiblingIndex()

	arg_6_0._additionReward = gohelper.clone(arg_6_0._goreward0, arg_6_0._goReward, "additionRward")

	arg_6_0._additionReward.transform:SetSiblingIndex(var_6_0)

	arg_6_0._additionContent = gohelper.findChild(arg_6_0._additionReward, "#go_content0")
	gohelper.findChildText(arg_6_0._additionReward, "title/text").text = formatLuaLang("turnback_addition", "")
end

function var_0_0.showReward(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, arg_7_9)
	local var_7_0 = arg_7_1.transform
	local var_7_1 = var_7_0.parent.gameObject

	if not arg_7_2 or #arg_7_2 <= 0 then
		if var_7_0.childCount <= 0 then
			gohelper.setActive(var_7_1, false)
		end

		return
	end

	gohelper.setActive(var_7_1, true)

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_2 = gohelper.clone(arg_7_0._goitem, arg_7_1)

		gohelper.setActive(var_7_2, true)

		local var_7_3 = gohelper.findChild(var_7_2, "itemicon")
		local var_7_4 = IconMgr.instance:getCommonPropItemIcon(var_7_3)
		local var_7_5 = gohelper.findChildText(var_7_2.gameObject, "countbg/txtnumber")
		local var_7_6 = gohelper.findChild(var_7_2.gameObject, "countbg")
		local var_7_7 = iter_7_1[3]
		local var_7_8 = iter_7_1[1]
		local var_7_9 = iter_7_1[2]
		local var_7_10 = iter_7_1[4] or iter_7_1[3]

		arg_7_4 = arg_7_4 or iter_7_1[4]

		if iter_7_1.tagType then
			var_7_7 = iter_7_1.tagType
			arg_7_4 = iter_7_1[3] > 0
		end

		var_7_4:setMOValue(var_7_8, var_7_9, var_7_10, nil, true)
		var_7_4:isShowEquipAndItemCount(false)
		var_7_4:setShowCountFlag(false)
		var_7_4:hideEquipLvAndBreak(true)
		var_7_4:setHideLvAndBreakFlag(true)
		gohelper.setActive(var_7_6, arg_7_4)

		if arg_7_4 then
			if var_7_4:isEquipIcon() then
				var_7_4:ShowEquipCount(var_7_6, var_7_5)
				var_7_4:hideEquipLvAndBreak(true)
				var_7_4:setHideLvAndBreakFlag(true)
			else
				var_7_4:showStackableNum2(var_7_6, var_7_5)
			end
		end

		if tonumber(var_7_8) == MaterialEnum.MaterialType.Item then
			local var_7_11 = ItemModel.instance:getItemConfig(var_7_8, var_7_9)

			if var_7_11 and (var_7_11.subType == ItemEnum.SubType.InsightItem or var_7_11.subType == ItemEnum.SubType.EquipBreak) then
				local var_7_12 = gohelper.findChildText(var_7_2.gameObject, "txt_repertory")

				gohelper.setActive(var_7_12.gameObject, true)

				local var_7_13 = ItemModel.instance:getItemQuantity(var_7_8, var_7_9)

				var_7_12.text = formatLuaLang("dungeonrewardview_repertory", GameUtil.numberDisplay(var_7_13))
			end
		end

		if arg_7_3 ~= DungeonEnum.StarType.None then
			local var_7_14 = arg_7_0._episodeInfo and arg_7_0._episodeInfo.star or 0
			local var_7_15

			if arg_7_3 <= var_7_14 then
				var_7_15 = gohelper.findChild(var_7_2.gameObject, "no_get")
			end

			if var_7_15 then
				var_7_15:SetActive(true)
			end
		end

		if arg_7_7 then
			gohelper.findChild(var_7_2.gameObject, "no_get"):SetActive(true)
		end

		if arg_7_5 then
			local var_7_16 = gohelper.findChild(var_7_2.gameObject, "get")

			if var_7_16 then
				var_7_16:SetActive(true)

				gohelper.findChildText(var_7_16, "tip").text = luaLang("dungeon_prob_flag" .. var_7_7)
			end
		end

		var_7_4:isShowAddition(arg_7_6 and true or false)

		if arg_7_8 then
			arg_7_8(arg_7_9, var_7_4, var_7_8, var_7_9)
		end

		local var_7_17 = gohelper.findButtonWithAudio(var_7_2.gameObject)

		var_7_17:AddClickListener(function(arg_8_0)
			MaterialTipController.instance:showMaterialInfo(arg_8_0[1], arg_8_0[2])
		end, iter_7_1)
		table.insert(arg_7_0._btnList, var_7_17)
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._episodeId = arg_10_0.viewParam.id
	arg_10_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_10_0._episodeId)

	if not arg_10_0._episodeInfo then
		arg_10_0._episodeInfo = UserDungeonMO.New()

		local var_10_0 = DungeonConfig.instance:getEpisodeCO(arg_10_0._episodeId)

		arg_10_0._episodeInfo:initFromManual(var_10_0.chapterId, arg_10_0._episodeId, 0, 0)
	end

	arg_10_0._btnList = arg_10_0:getUserDataTb_()

	local var_10_1 = DungeonConfig.instance:getChapterCO(arg_10_0._episodeInfo.chapterId)
	local var_10_2 = var_10_1.type == DungeonEnum.ChapterType.Gold or var_10_1.type == DungeonEnum.ChapterType.Exp
	local var_10_3 = var_10_1.type == DungeonEnum.ChapterType.Break
	local var_10_4 = var_10_1 and var_10_1.type == DungeonEnum.ChapterType.Hard

	arg_10_0:setRewardStarsColor(var_10_4)
	arg_10_0:normalRewardShow(false, var_10_2, var_10_3)

	local var_10_5 = DungeonModel.instance:getEpisodeReward(arg_10_0._episodeId)
	local var_10_6 = {}

	for iter_10_0 = 1, #var_10_5 do
		local var_10_7 = var_10_5[iter_10_0]

		if not var_10_6[var_10_7[1]] then
			var_10_6[var_10_7[1]] = {}
		end

		var_10_6[var_10_7[1]][var_10_7[2]] = true
	end

	arg_10_0:showReward(arg_10_0._gocontent0, var_10_5, DungeonEnum.StarType.None, false, true)
	arg_10_0:showReward(arg_10_0._gocontent1, DungeonModel.instance:getEpisodeFirstBonus(arg_10_0._episodeId), DungeonEnum.StarType.Normal, true, false)
	arg_10_0:showReward(arg_10_0._gocontent2, DungeonModel.instance:getEpisodeAdvancedBonus(arg_10_0._episodeId), DungeonEnum.StarType.Advanced, true, false)

	if var_10_1.enterAfterFreeLimit > 0 then
		local var_10_8 = DungeonModel.instance:getChapterRemainingNum(var_10_1.type)

		if var_10_8 > 0 then
			gohelper.setActive(arg_10_0._goreward3, true)

			local var_10_9 = DungeonConfig.instance:getDungeonEveryDayCount(var_10_1.type)

			arg_10_0._txtspecialtitle.text = formatLuaLang("dungeon_special_drop", var_10_8, var_10_9)

			arg_10_0:showReward(arg_10_0._gocontent3, DungeonModel.instance:getEpisodeFreeDisplayList(arg_10_0._episodeId), DungeonEnum.StarType.None, false, true)
		end
	end

	local var_10_10 = {}

	if var_10_2 then
		var_10_10 = DungeonModel.instance:getEpisodeBonus(arg_10_0._episodeId)

		arg_10_0:showReward(arg_10_0._gocontent0, var_10_10, DungeonEnum.StarType.None, true, false)
	else
		var_10_10 = DungeonModel.instance:getEpisodeRewardList(arg_10_0._episodeId)

		arg_10_0:showReward(arg_10_0._gocontent0, var_10_10, DungeonEnum.StarType.None, false, true)
	end

	local var_10_11 = DungeonModel.instance:getEpisodeBonus(arg_10_0._episodeId, true)

	for iter_10_1 = #var_10_11, 1, -1 do
		local var_10_12 = var_10_11[iter_10_1]

		if var_10_6[var_10_12[1]] and var_10_6[var_10_12[1]][var_10_12[2]] then
			table.remove(var_10_11, iter_10_1)
		end
	end

	arg_10_0:showReward(arg_10_0._gocontent0, var_10_11, DungeonEnum.StarType.None, false, true)
	tabletool.addValues(var_10_10, var_10_11)
	arg_10_0:showTurnBackAdditionReward(var_10_10, var_10_2)
	arg_10_0:showDoubleDropReward(var_10_10, var_10_2)
	arg_10_0:refreshActReward()
end

function var_0_0.refreshActReward(arg_11_0)
	local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_0._episodeId)
	local var_11_1 = DungeonConfig.instance:getChapterCO(var_11_0.chapterId)

	if var_11_1.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_11_1.type) > 0 then
		gohelper.setActive(arg_11_0._goactreward, false)

		return
	end

	local var_11_2 = 0
	local var_11_3
	local var_11_4 = var_11_0.chapterId

	for iter_11_0, iter_11_1 in ipairs(lua_activity155_drop.configList) do
		if var_11_4 == iter_11_1.chapterId then
			local var_11_5 = iter_11_1.activityId

			if ActivityHelper.getActivityStatus(var_11_5, true) == ActivityEnum.ActivityStatus.Normal then
				local var_11_6 = var_11_5

				var_11_3 = iter_11_1

				break
			end
		end
	end

	if not var_11_3 or var_11_0.type == DungeonEnum.EpisodeType.Story then
		gohelper.setActive(arg_11_0._goactreward, false)

		return
	end

	gohelper.setActive(arg_11_0._goactreward, true)

	local var_11_7 = var_11_3.itemId1

	if not string.nilorempty(var_11_7) then
		local var_11_8 = string.splitToNumber(var_11_7, "#")
		local var_11_9 = CommonConfig.instance:getAct155CurrencyRatio() * string.splitToNumber(var_11_0.cost, "#")[3]
		local var_11_10 = {
			var_11_8[1],
			var_11_8[2],
			var_11_8[3],
			var_11_9
		}

		arg_11_0:showReward(arg_11_0._goactcontent, {
			var_11_10
		}, DungeonEnum.StarType.None, true, true, nil, nil, arg_11_0.refreshV1a7DungeonCurrencyCallback, arg_11_0)
	end

	local var_11_11 = var_11_3.itemId2

	if not string.nilorempty(var_11_11) then
		local var_11_12 = string.splitToNumber(var_11_11, "#")
		local var_11_13 = {
			var_11_12[1],
			var_11_12[2],
			var_11_12[3]
		}

		arg_11_0:showReward(arg_11_0._goactcontent, {
			var_11_13
		}, DungeonEnum.StarType.None, false, true, nil, nil, arg_11_0.refreshV1a7PowerCallback, arg_11_0)
	end

	local var_11_14 = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

	if (var_11_14 == ActivityEnum.ActivityStatus.Normal or var_11_14 == ActivityEnum.ActivityStatus.NotUnlock) and ToughBattleModel.instance:isDropActItem() then
		local var_11_15 = {
			MaterialEnum.MaterialType.Currency,
			CurrencyEnum.CurrencyType.V1a9ToughEnter,
			DungeonMapLevelRewardView.TagType.Act
		}

		arg_11_0:showReward(arg_11_0._goactcontent, {
			var_11_15
		}, DungeonEnum.StarType.None, false, true, nil, nil, arg_11_0.refreshToughBattleCallback, arg_11_0)
	end
end

function var_0_0.refreshV1a7DungeonCurrencyCallback(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1._itemIcon

	var_12_0._gov1a7act = var_12_0._gov1a7act or gohelper.findChild(var_12_0.go, "act")

	gohelper.setActive(var_12_0._gov1a7act, true)
end

function var_0_0.refreshV1a7PowerCallback(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:setCanShowDeadLine(false)

	local var_13_0 = arg_13_1._itemIcon

	var_13_0._gov1a7act = var_13_0._gov1a7act or gohelper.findChild(var_13_0.go, "act")

	gohelper.setActive(var_13_0._gov1a7act, true)
end

function var_0_0.refreshToughBattleCallback(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:setCanShowDeadLine(false)

	local var_14_0 = arg_14_1._itemIcon

	var_14_0._gov1a7act = var_14_0._gov1a7act or gohelper.findChild(var_14_0.go, "act")

	gohelper.setActive(var_14_0._gov1a7act, true)
end

function var_0_0.normalRewardShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.setActive(arg_15_0._gonormalstars, not arg_15_1 or arg_15_2)
	gohelper.setActive(arg_15_0._gohardstars, arg_15_1 and not arg_15_2)
	gohelper.setActive(arg_15_0._goreward0, not arg_15_1)
	gohelper.setActive(arg_15_0._goreward2, not arg_15_1 and not arg_15_2 and not arg_15_3)
	gohelper.setActive(arg_15_0._goreward3, false)
end

function var_0_0.setRewardStarsColor(arg_16_0, arg_16_1)
	local var_16_0 = "#C66030"
	local var_16_1 = "#FF4343"
	local var_16_2 = gohelper.findChildImage(arg_16_0._gonormalstars, "star")

	SLFramework.UGUI.GuiHelper.SetColor(var_16_2, arg_16_1 and var_16_1 or var_16_0)
end

function var_0_0.showTurnBackAdditionReward(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = TurnbackModel.instance:isShowTurnBackAddition(arg_17_0._episodeInfo.chapterId)

	if var_17_0 then
		local var_17_1 = TurnbackModel.instance:getAdditionRewardList(arg_17_1)

		if arg_17_2 then
			arg_17_0:showReward(arg_17_0._additionContent, var_17_1, DungeonEnum.StarType.None, true, false, true)
		else
			arg_17_0:showReward(arg_17_0._additionContent, var_17_1, DungeonEnum.StarType.None, false, false, true)
		end
	end

	if arg_17_0._additionReward then
		gohelper.setActive(arg_17_0._additionReward, var_17_0)
	end
end

function var_0_0.showDoubleDropReward(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_18_0._episodeId, true)

	gohelper.setActive(arg_18_0._godoubledropreward, var_18_0)

	if not var_18_0 then
		return
	end

	local var_18_1 = {}

	tabletool.addValues(var_18_1, arg_18_1)

	local var_18_2 = DoubleDropModel.instance:getActId()
	local var_18_3 = DoubleDropConfig.instance:getAct153ExtraBonus(var_18_2, arg_18_0._episodeId)
	local var_18_4 = GameUtil.splitString2(var_18_3, true)

	tabletool.addValues(var_18_1, var_18_4)
	arg_18_0:showReward(arg_18_0._godoubledropcontent, var_18_1, DungeonEnum.StarType.None, true, false, true)
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._btnList) do
		iter_19_1:RemoveClickListener()
	end

	arg_19_0._btnList = nil

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
end

function var_0_0.onDestroyView(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._simageList) do
		iter_20_0:UnLoadImage()
	end
end

return var_0_0
