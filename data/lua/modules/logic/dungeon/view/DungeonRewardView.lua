module("modules.logic.dungeon.view.DungeonRewardView", package.seeall)

slot0 = class("DungeonRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward")
	slot0._goreward1 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1")
	slot0._gonormalstars = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_normalstars")
	slot0._gohardlstars = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_hardlstars")
	slot0._gocontent1 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/#go_content1")
	slot0._goreward2 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward2")
	slot0._gocontent2 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward2/#go_content2")
	slot0._goreward3 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3")
	slot0._txtspecialtitle = gohelper.findChildText(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/title/#txt_specialtitle")
	slot0._gocontent3 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/#go_content3")
	slot0._goreward0 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward0")
	slot0._gocontent0 = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_reward0/#go_content0")
	slot0._goactreward = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_actreward")
	slot0._goactcontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_actreward/#go_actcontent")
	slot0._godoubledropreward = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward")
	slot0._godoubledropcontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward/#go_content3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnbackOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnmainOnClick(slot0)
	ViewMgr.instance:closeAllPopupViews()
end

function slot0._editableInitView(slot0)
	slot0._simageList = slot0:getUserDataTb_()
	slot0._additionReward = gohelper.clone(slot0._goreward0, slot0._goReward, "additionRward")

	slot0._additionReward.transform:SetSiblingIndex(slot0._goreward0.transform:GetSiblingIndex())

	slot0._additionContent = gohelper.findChild(slot0._additionReward, "#go_content0")
	gohelper.findChildText(slot0._additionReward, "title/text").text = formatLuaLang("turnback_addition", "")
end

function slot0.showReward(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot11 = slot1.transform.parent.gameObject

	if not slot2 or #slot2 <= 0 then
		if slot10.childCount <= 0 then
			gohelper.setActive(slot11, false)
		end

		return
	end

	slot15 = true

	gohelper.setActive(slot11, slot15)

	for slot15, slot16 in ipairs(slot2) do
		slot17 = gohelper.clone(slot0._goitem, slot1)

		gohelper.setActive(slot17, true)

		slot19 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot17, "itemicon"))
		slot20 = gohelper.findChildText(slot17.gameObject, "countbg/txtnumber")
		slot21 = gohelper.findChild(slot17.gameObject, "countbg")
		slot22 = slot16[3]
		slot23 = slot16[1]
		slot24 = slot16[2]
		slot25 = slot16[4] or slot16[3]
		slot4 = slot4 or slot16[4]

		if slot16.tagType then
			slot22 = slot16.tagType
			slot4 = slot16[3] > 0
		end

		slot19:setMOValue(slot23, slot24, slot25, nil, true)
		slot19:isShowEquipAndItemCount(false)
		slot19:setShowCountFlag(false)
		slot19:hideEquipLvAndBreak(true)
		slot19:setHideLvAndBreakFlag(true)
		gohelper.setActive(slot21, slot4)

		if slot4 then
			if slot19:isEquipIcon() then
				slot19:ShowEquipCount(slot21, slot20)
				slot19:hideEquipLvAndBreak(true)
				slot19:setHideLvAndBreakFlag(true)
			else
				slot19:showStackableNum2(slot21, slot20)
			end
		end

		if tonumber(slot23) == MaterialEnum.MaterialType.Item and ItemModel.instance:getItemConfig(slot23, slot24) and (slot26.subType == ItemEnum.SubType.InsightItem or slot26.subType == ItemEnum.SubType.EquipBreak) then
			slot27 = gohelper.findChildText(slot17.gameObject, "txt_repertory")

			gohelper.setActive(slot27.gameObject, true)

			slot27.text = formatLuaLang("dungeonrewardview_repertory", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(slot23, slot24)))
		end

		if slot3 ~= DungeonEnum.StarType.None then
			slot27 = nil

			if slot3 <= (slot0._episodeInfo and slot0._episodeInfo.star or 0) then
				slot27 = gohelper.findChild(slot17.gameObject, "no_get")
			end

			if slot27 then
				slot27:SetActive(true)
			end
		end

		if slot7 then
			gohelper.findChild(slot17.gameObject, "no_get"):SetActive(true)
		end

		if slot5 and gohelper.findChild(slot17.gameObject, "get") then
			slot26:SetActive(true)

			gohelper.findChildText(slot26, "tip").text = luaLang("dungeon_prob_flag" .. slot22)
		end

		slot19:isShowAddition(slot6 and true or false)

		if slot8 then
			slot8(slot9, slot19, slot23, slot24)
		end

		slot26 = gohelper.findButtonWithAudio(slot17.gameObject)

		slot26:AddClickListener(function (slot0)
			MaterialTipController.instance:showMaterialInfo(slot0[1], slot0[2])
		end, slot16)
		table.insert(slot0._btnList, slot26)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._episodeId = slot0.viewParam.id
	slot0._episodeInfo = DungeonModel.instance:getEpisodeInfo(slot0._episodeId)

	if not slot0._episodeInfo then
		slot0._episodeInfo = UserDungeonMO.New()

		slot0._episodeInfo:initFromManual(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId, slot0._episodeId, 0, 0)
	end

	slot0._btnList = slot0:getUserDataTb_()

	slot0:setRewardStarsColor(slot1 and slot1.type == DungeonEnum.ChapterType.Hard)
	slot0:normalRewardShow(false, DungeonConfig.instance:getChapterCO(slot0._episodeInfo.chapterId).type == DungeonEnum.ChapterType.Gold or slot1.type == DungeonEnum.ChapterType.Exp, slot1.type == DungeonEnum.ChapterType.Break)

	slot6 = {}

	for slot10 = 1, #DungeonModel.instance:getEpisodeReward(slot0._episodeId) do
		if not slot6[slot5[slot10][1]] then
			slot6[slot11[1]] = {}
		end

		slot6[slot11[1]][slot11[2]] = true
	end

	slot0:showReward(slot0._gocontent0, slot5, DungeonEnum.StarType.None, false, true)
	slot0:showReward(slot0._gocontent1, DungeonModel.instance:getEpisodeFirstBonus(slot0._episodeId), DungeonEnum.StarType.Normal, true, false)
	slot0:showReward(slot0._gocontent2, DungeonModel.instance:getEpisodeAdvancedBonus(slot0._episodeId), DungeonEnum.StarType.Advanced, true, false)

	if slot1.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot1.type) > 0 then
		gohelper.setActive(slot0._goreward3, true)

		slot0._txtspecialtitle.text = formatLuaLang("dungeon_special_drop", slot7, DungeonConfig.instance:getDungeonEveryDayCount(slot1.type))

		slot0:showReward(slot0._gocontent3, DungeonModel.instance:getEpisodeFreeDisplayList(slot0._episodeId), DungeonEnum.StarType.None, false, true)
	end

	slot7 = {}

	if slot2 then
		slot0:showReward(slot0._gocontent0, DungeonModel.instance:getEpisodeBonus(slot0._episodeId), DungeonEnum.StarType.None, true, false)
	else
		slot0:showReward(slot0._gocontent0, DungeonModel.instance:getEpisodeRewardList(slot0._episodeId), DungeonEnum.StarType.None, false, true)
	end

	slot12 = true

	for slot12 = #DungeonModel.instance:getEpisodeBonus(slot0._episodeId, slot12), 1, -1 do
		if slot6[slot8[slot12][1]] and slot6[slot13[1]][slot13[2]] then
			table.remove(slot8, slot12)
		end
	end

	slot0:showReward(slot0._gocontent0, slot8, DungeonEnum.StarType.None, false, true)
	tabletool.addValues(slot7, slot8)
	slot0:showTurnBackAdditionReward(slot7, slot2)
	slot0:showDoubleDropReward(slot7, slot2)
	slot0:refreshActReward()
end

function slot0.refreshActReward(slot0)
	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId).enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot2.type) > 0 then
		gohelper.setActive(slot0._goactreward, false)

		return
	end

	slot3 = 0
	slot4 = nil

	for slot9, slot10 in ipairs(lua_activity155_drop.configList) do
		if slot1.chapterId == slot10.chapterId and ActivityHelper.getActivityStatus(slot10.activityId, true) == ActivityEnum.ActivityStatus.Normal then
			slot3 = slot11
			slot4 = slot10

			break
		end
	end

	if not slot4 or slot1.type == DungeonEnum.EpisodeType.Story then
		gohelper.setActive(slot0._goactreward, false)

		return
	end

	gohelper.setActive(slot0._goactreward, true)

	if not string.nilorempty(slot4.itemId1) then
		slot7 = string.splitToNumber(slot6, "#")

		slot0:showReward(slot0._goactcontent, {
			{
				slot7[1],
				slot7[2],
				slot7[3],
				CommonConfig.instance:getAct155CurrencyRatio() * string.splitToNumber(slot1.cost, "#")[3]
			}
		}, DungeonEnum.StarType.None, true, true, nil, , slot0.refreshV1a7DungeonCurrencyCallback, slot0)
	end

	if not string.nilorempty(slot4.itemId2) then
		slot8 = string.splitToNumber(slot7, "#")

		slot0:showReward(slot0._goactcontent, {
			{
				slot8[1],
				slot8[2],
				slot8[3]
			}
		}, DungeonEnum.StarType.None, false, true, nil, , slot0.refreshV1a7PowerCallback, slot0)
	end

	if (ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle) == ActivityEnum.ActivityStatus.Normal or slot8 == ActivityEnum.ActivityStatus.NotUnlock) and ToughBattleModel.instance:isDropActItem() then
		slot0:showReward(slot0._goactcontent, {
			{
				MaterialEnum.MaterialType.Currency,
				CurrencyEnum.CurrencyType.V1a9ToughEnter,
				DungeonMapLevelRewardView.TagType.Act
			}
		}, DungeonEnum.StarType.None, false, true, nil, , slot0.refreshToughBattleCallback, slot0)
	end
end

function slot0.refreshV1a7DungeonCurrencyCallback(slot0, slot1, slot2, slot3)
	slot4._gov1a7act = slot1._itemIcon._gov1a7act or gohelper.findChild(slot4.go, "act")

	gohelper.setActive(slot4._gov1a7act, true)
end

function slot0.refreshV1a7PowerCallback(slot0, slot1, slot2, slot3)
	slot1:setCanShowDeadLine(false)

	slot4._gov1a7act = slot1._itemIcon._gov1a7act or gohelper.findChild(slot4.go, "act")

	gohelper.setActive(slot4._gov1a7act, true)
end

function slot0.refreshToughBattleCallback(slot0, slot1, slot2, slot3)
	slot1:setCanShowDeadLine(false)

	slot4._gov1a7act = slot1._itemIcon._gov1a7act or gohelper.findChild(slot4.go, "act")

	gohelper.setActive(slot4._gov1a7act, true)
end

function slot0.normalRewardShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._gonormalstars, not slot1 or slot2)
	gohelper.setActive(slot0._gohardstars, slot1 and not slot2)
	gohelper.setActive(slot0._goreward0, not slot1)
	gohelper.setActive(slot0._goreward2, not slot1 and not slot2 and not slot3)
	gohelper.setActive(slot0._goreward3, false)
end

function slot0.setRewardStarsColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(slot0._gonormalstars, "star"), slot1 and "#FF4343" or "#C66030")
end

function slot0.showTurnBackAdditionReward(slot0, slot1, slot2)
	if TurnbackModel.instance:isShowTurnBackAddition(slot0._episodeInfo.chapterId) then
		if slot2 then
			slot0:showReward(slot0._additionContent, TurnbackModel.instance:getAdditionRewardList(slot1), DungeonEnum.StarType.None, true, false, true)
		else
			slot0:showReward(slot0._additionContent, slot4, DungeonEnum.StarType.None, false, false, true)
		end
	end

	if slot0._additionReward then
		gohelper.setActive(slot0._additionReward, slot3)
	end
end

function slot0.showDoubleDropReward(slot0, slot1, slot2)
	slot3 = DoubleDropModel.instance:isShowDoubleByEpisode(slot0._episodeId, true)

	gohelper.setActive(slot0._godoubledropreward, slot3)

	if not slot3 then
		return
	end

	slot4 = {}

	tabletool.addValues(slot4, slot1)
	tabletool.addValues(slot4, GameUtil.splitString2(DoubleDropConfig.instance:getAct153ExtraBonus(DoubleDropModel.instance:getActId(), slot0._episodeId), true))
	slot0:showReward(slot0._godoubledropcontent, slot4, DungeonEnum.StarType.None, true, false, true)
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._btnList) do
		slot5:RemoveClickListener()
	end

	slot0._btnList = nil

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._simageList) do
		slot4:UnLoadImage()
	end
end

return slot0
