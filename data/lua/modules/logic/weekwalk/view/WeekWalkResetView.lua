module("modules.logic.weekwalk.view.WeekWalkResetView", package.seeall)

slot0 = class("WeekWalkResetView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "levelinfo/#simage_bg")
	slot0._txtlevelname = gohelper.findChildText(slot0.viewGO, "levelinfo/#go_selectlevel/#txt_levelname")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "levelinfo/#go_empty")
	slot0._gounselectlevel = gohelper.findChild(slot0.viewGO, "levelinfo/#go_unselectlevel")
	slot0._gounfinishlevel = gohelper.findChild(slot0.viewGO, "levelinfo/#go_unfinishlevel")
	slot0._gorevive = gohelper.findChild(slot0.viewGO, "levelinfo/#go_revive")
	slot0._goroles = gohelper.findChild(slot0.viewGO, "levelinfo/#go_roles")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "levelinfo/#go_roles/#go_heroitem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "levelinfo/#btn_reset")
	slot0._goselectlevel = gohelper.findChild(slot0.viewGO, "levelinfo/#go_selectlevel")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	if not slot0._selectedBattleItem then
		return
	end

	if slot0._selectedBattleItem:getBattleInfo().star <= 0 then
		return
	end

	slot2 = 0

	for slot6, slot7 in ipairs(slot0._battleItemList) do
		if slot7 == slot0._selectedBattleItem then
			break
		end

		slot2 = slot7:getBattleInfo().battleId
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayerBattle, MsgBoxEnum.BoxType.Yes_No, function ()
		WeekwalkRpc.instance:sendResetLayerRequest(uv0._mapId, uv1, uv0.closeThis, uv0)
	end, nil, , , , , slot0:_getBattleName())
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)

	slot0._resetBtnCanvasGroup = gohelper.onceAddComponent(slot0._btnreset.gameObject, typeof(UnityEngine.CanvasGroup))
	slot0._mapInfo = WeekWalkModel.instance:getCurMapInfo()
	slot0._mapConfig = WeekWalkModel.instance:getCurMapConfig()
	slot0._sceneConfig = lua_weekwalk_scene.configDict[slot0._mapConfig.sceneId]
	slot0._mapId = slot0._mapInfo.id
	slot0._heroItemList = nil

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("dreamrewardbg.png"))
	slot0._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	slot0._needShowHeros = slot0._mapId > 105

	gohelper.setActive(slot0._gorevive, slot0._needShowHeros)
	gohelper.setActive(slot0._goempty, not slot0._needShowHeros)

	if slot0._needShowHeros then
		slot0:_showHeros()
	end

	slot0:_showBattleList()
	slot0:_initFinishStatus()
	slot0:_showCurLevel()
end

function slot0._showCurLevel(slot0)
	slot1 = 1

	for slot6, slot7 in ipairs(slot0._mapInfo.battleInfos) do
		slot1 = slot6

		if slot7.star <= 0 then
			break
		end
	end
end

function slot0._initFinishStatus(slot0)
	gohelper.setActive(slot0._goselectlevel, false)

	slot0._resetBtnCanvasGroup.alpha = 0.3

	if slot0._mapInfo:getHasStarIndex() <= 0 then
		gohelper.setActive(slot0._gounfinishlevel, true)

		return
	end

	gohelper.setActive(slot0._gounselectlevel, true)
end

function slot0._showBattleList(slot0)
	slot0._battleItemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(slot0._mapInfo.battleInfos) do
		table.insert(slot0._battleItemList, MonoHelper.addLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goprogress), WeekWalkResetBattleItem, {
			slot0,
			slot6,
			slot5,
			slot1
		}))
	end
end

function slot0.selectBattleItem(slot0, slot1)
	if slot0._selectedBattleItem == slot1 then
		slot0._selectedBattleItem = nil
	else
		slot0._selectedBattleItem = slot1
	end

	slot2 = nil

	for slot6, slot7 in ipairs(slot0._battleItemList) do
		if slot7 == slot0._selectedBattleItem then
			slot2 = slot6

			slot0:_showSelectBattleInfo(slot1, slot6)
		end

		slot7:setSelect(slot8)
		slot7:setFakedReset(slot2, slot8)
	end

	gohelper.setActive(slot0._gounselectlevel, not slot0._selectedBattleItem)

	if slot0._needShowHeros then
		slot0:_showHeros()
	end

	if not slot0._selectedBattleItem then
		slot0._resetBtnCanvasGroup.alpha = 0.3

		gohelper.setActive(slot0._goselectlevel, false)
	end
end

function slot0._showSelectBattleInfo(slot0, slot1, slot2)
	slot0._battleIndex = slot2

	gohelper.setActive(slot0._goselectlevel, true)

	slot0._txtlevelname.text = slot0:_getBattleName()

	gohelper.setActive(slot0._gounselectlevel, false)

	slot0._resetBtnCanvasGroup.alpha = 1

	if slot0._needShowHeros then
		slot0:_showHeros()
	end
end

function slot0._showHeros(slot0)
	if not slot0._heroItemList then
		slot0._heroItemList = slot0:getUserDataTb_()

		for slot4 = 1, 4 do
			slot5 = gohelper.cloneInPlace(slot0._goheroitem)

			gohelper.setActive(slot5, true)

			slot6 = slot0:getUserDataTb_()
			slot6._goempty = gohelper.findChild(slot5, "go_empty")
			slot6._gohero = gohelper.findChild(slot5, "go_hero")
			slot6._simageheroicon = gohelper.findChildSingleImage(slot5, "go_hero/simage_heroicon")
			slot6._imagecareer = gohelper.findChildImage(slot5, "go_hero/image_career")
			slot0._heroItemList[slot4] = slot6
		end
	end

	slot1 = slot0._selectedBattleItem and slot0._selectedBattleItem:getPrevBattleInfo()
	slot2 = slot1 and slot1.heroIds

	for slot6, slot7 in ipairs(slot0._heroItemList) do
		slot8 = slot2 and slot2[slot6]
		slot9 = slot0._heroItemList[slot6]

		gohelper.setActive(slot9._goempty, not slot8)
		gohelper.setActive(slot9._gohero, slot8)

		if slot8 then
			slot10 = HeroConfig.instance:getHeroCO(slot8)

			slot9._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot10.skinId).headIcon))
			UISpriteSetMgr.instance:setCommonSprite(slot9._imagecareer, "lssx_" .. slot10.career)
		end
	end
end

function slot0._getBattleName(slot0)
	return string.format("%s-0%s", slot0._sceneConfig.battleName, slot0._battleIndex)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._heroItemList then
		for slot4, slot5 in ipairs(slot0._heroItemList) do
			slot5._simageheroicon:UnLoadImage()
		end
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

return slot0
