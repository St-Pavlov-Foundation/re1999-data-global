module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonEpisodeView", package.seeall)

slot0 = class("VersionActivity1_4DungeonEpisodeView", BaseView)

function slot0.onInitView(slot0)
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "rotate/#go_bg/#txt_info")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/right/#go_fight/#btn_fight")
	slot0._btnbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#btn_closetip")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	slot0.goRewardContent = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent")
	slot0._goactivityrewarditem = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	slot0.rewardItems = slot0:getUserDataTb_()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnbg:AddClickListener(slot0._btnbgOnClick, slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnbgOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnbg:RemoveClickListener()
	slot0._btnclosetip:RemoveClickListener()
end

function slot0._btnbgOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnyesOnClick(slot0)
	if not DungeonConfig.instance:getEpisodeCO(slot0.episodeId) then
		return
	end

	DungeonFightController.instance:enterFight(slot1.chapterId, slot1.id, 1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0.episodeId = slot0.viewParam.episodeId

	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0.episodeId = slot0.viewParam.episodeId

	slot0._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204_btn"))
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	if not DungeonConfig.instance:getEpisodeCO(slot0.episodeId) then
		return
	end

	slot0.txtName.text = slot1.name
	slot0.txtDesc.text = slot1.desc
	slot2 = 0

	if not string.nilorempty(slot1.cost) then
		slot2 = string.splitToNumber(slot1.cost, "#")[3]
	end

	slot0._txtcost.text = "-" .. slot2

	if slot2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#800015")
	end

	slot0:refreshReward(slot1)
end

function slot0.refreshReward(slot0, slot1)
	gohelper.setActive(slot0._goactivityrewarditem, false)

	slot2 = {}
	slot3 = 0
	slot4 = 0

	if DungeonModel.instance:getEpisodeInfo(slot1.id) and slot5.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(slot2, DungeonModel.instance:getEpisodeAdvancedBonus(slot1.id))

		slot4 = #slot2
	end

	if slot5 and slot5.star == DungeonEnum.StarType.None then
		tabletool.addValues(slot2, DungeonModel.instance:getEpisodeFirstBonus(slot1.id))

		slot3 = #slot2
	end

	tabletool.addValues(slot2, DungeonModel.instance:getEpisodeRewardDisplayList(slot1.id))

	if #slot2 == 0 then
		gohelper.setActive(slot0.goRewardContent, false)

		return
	end

	gohelper.setActive(slot0.goRewardContent, true)

	slot8, slot9 = nil

	for slot13 = 1, math.min(#slot2, 3) do
		if not slot0.rewardItems[slot13] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot0._goactivityrewarditem, "item" .. slot13)
			slot9.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot9.go, "itemicon"))
			slot9.gonormal = gohelper.findChild(slot9.go, "rare/#go_rare1")
			slot9.gofirst = gohelper.findChild(slot9.go, "rare/#go_rare2")
			slot9.goadvance = gohelper.findChild(slot9.go, "rare/#go_rare3")
			slot9.gofirsthard = gohelper.findChild(slot9.go, "rare/#go_rare4")
			slot9.txtnormal = gohelper.findChildText(slot9.go, "rare/#go_rare1/txt")

			table.insert(slot0.rewardItems, slot9)
		end

		gohelper.setActive(slot9.gonormal, false)
		gohelper.setActive(slot9.gofirst, false)
		gohelper.setActive(slot9.goadvance, false)
		gohelper.setActive(slot9.gofirsthard, false)

		slot14, slot15 = nil
		slot16 = slot2[slot13][4] or slot8[3]
		slot17 = true
		slot14 = slot9.gofirst

		if slot13 <= slot4 then
			gohelper.setActive(slot9.goadvance, true)
		elseif slot13 <= slot3 then
			gohelper.setActive(slot14, true)
		else
			gohelper.setActive(slot9.gonormal, true)

			slot9.txtnormal.text = luaLang("dungeon_prob_flag" .. slot8[3])
		end

		slot9.iconItem:setMOValue(slot8[1], slot8[2], slot16, nil, true)
		slot9.iconItem:setCountFontSize(42)
		slot9.iconItem:setHideLvAndBreakFlag(true)
		slot9.iconItem:hideEquipLvAndBreak(true)
		slot9.iconItem:customOnClickCallback(slot0._onRewardItemClick, slot0)
		gohelper.setActive(slot9.go, true)
	end

	for slot13 = slot7 + 1, #slot0.rewardItems do
		gohelper.setActive(slot0.rewardItems[slot13].go, false)
	end
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = IconMgr.instance:getCommonPropItemIcon(slot0.goRewardContent)
	slot0.rewardItemList[slot1] = slot2

	return slot2
end

function slot0.onClose(slot0)
	VersionActivity1_4DungeonModel.instance:setSelectEpisodeId()
end

function slot0.onDestroyView(slot0)
	slot0._simagecosticon:UnLoadImage()
end

return slot0
