module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightView", package.seeall)

slot0 = class("RoleStoryHeroGroupFightView", HeroGroupFightView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._gotarget = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")

	gohelper.setActive(slot0._gotarget, false)
end

function slot0._refreshCost(slot0, slot1)
	gohelper.setActive(slot0._gocost, slot1)
	gohelper.setActive(slot0._gopower, not slot0._enterAfterFreeLimit)
	gohelper.setActive(slot0._gocount, not slot0._enterAfterFreeLimit and slot0:_getfreeCount() > 0)
	gohelper.setActive(slot0._gonormallackpower, false)
	gohelper.setActive(slot0._goreplaylackpower, false)

	if slot0._enterAfterFreeLimit or slot2 > 0 then
		slot3 = tostring(-1 * math.min(slot0._multiplication, slot2))
		slot0._txtCostNum.text = slot3
		slot0._txtReplayCostNum.text = slot3
		slot0._txtcostcount.text = string.format("<color=#B3AFAC>%s</color><color=#B26161>%s</color>", luaLang("p_dungeonmaplevel_costcount"), slot3)

		if slot0._multiplication <= slot2 then
			slot0:_refreshBtns(false)

			return
		end
	end

	slot5 = nil

	slot0._simagepower:LoadImage((GameUtil.splitString2(slot0.episodeConfig.cost, true)[1][1] ~= MaterialEnum.MaterialType.Currency or slot4[2] ~= CurrencyEnum.CurrencyType.Power or ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).icon .. "_btn")) and ItemModel.instance:getItemSmallIcon(slot4[2]))
	recthelper.setSize(slot0._simagepower.transform, 100, 100)
	slot0:_refreshCostPower()
end

function slot0._onClickStart(slot0)
	slot4 = {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot0.episodeConfig.cost, true)) do
		table.insert(slot4, {
			type = slot9[1],
			id = slot9[2],
			quantity = slot9[3] * ((slot0._multiplication or 1) - slot0:_getfreeCount())
		})
	end

	slot5, slot6, slot7 = ItemModel.instance:hasEnoughItems(slot4)

	if not slot6 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot7, slot5)

		return
	end

	slot0:_closemultcontent()
	slot0:_enterFight()
end

function slot0._refreshCostPower(slot0)
	slot4 = (GameUtil.splitString2(slot0.episodeConfig.cost, true)[1][3] or 0) > 0

	if slot0._enterAfterFreeLimit then
		slot4 = false
	end

	gohelper.setActive(slot0._gopower, slot4)
	slot0:_refreshBtns(slot4)

	if not slot4 then
		return
	end

	slot0._txtusepower.text = string.format("-%s", slot3 * ((slot0._multiplication or 1) - slot0:_getfreeCount()))

	if slot5 <= ItemModel.instance:getItemQuantity(slot2[1], slot2[2]) then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, slot0._replayMode and "#070706" or (slot0._chapterConfig.type == DungeonEnum.ChapterType.Hard and "#FFFFFF" or "#070706"))
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, slot0._replayMode and "#800015" or (slot6 and "#C44945" or "#800015"))
		gohelper.setActive(slot0._gonormallackpower, not slot0._replayMode)
		gohelper.setActive(slot0._goreplaylackpower, slot0._replayMode)
	end
end

return slot0
