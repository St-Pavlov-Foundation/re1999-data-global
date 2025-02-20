module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenView", package.seeall)

slot0 = class("EliminateSelectChessMenView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._goSort = gohelper.findChild(slot0.viewGO, "Left/#go_Sort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Sort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Sort/#btn_rarerank")
	slot0._btnfaithrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Sort/#btn_faithrank")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_Sort/#btn_classify")
	slot0._scrollChessList = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_ChessList")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "Right/#go_Empty")
	slot0._goDetail = gohelper.findChild(slot0.viewGO, "Right/#go_Detail")
	slot0._imageChessQualityBG = gohelper.findChildImage(slot0.viewGO, "Right/#go_Detail/Info/#image_ChessQualityBG")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "Right/#go_Detail/Info/#image_Chess")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "Right/#go_Detail/Info/#go_Resource")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "Right/#go_Detail/Info/image_Fire/#txt_FireNum")
	slot0._goStar1 = gohelper.findChild(slot0.viewGO, "Right/#go_Detail/Info/Stars/#go_Star1")
	slot0._txtChessName = gohelper.findChildText(slot0.viewGO, "Right/#go_Detail/Info/#txt_ChessName")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#go_Detail/Scroll View/Viewport/#txt_Descr")
	slot0._btnAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Detail/#btn_Add")
	slot0._btnOut = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Detail/#btn_Out")
	slot0._goSlot = gohelper.findChild(slot0.viewGO, "Bottom/#go_Slot")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/#btn_Enter")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnfaithrank:AddClickListener(slot0._btnfaithrankOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._btnAdd:AddClickListener(slot0._btnAddOnClick, slot0)
	slot0._btnOut:AddClickListener(slot0._btnOutOnClick, slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnfaithrank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btnAdd:RemoveClickListener()
	slot0._btnOut:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
end

function slot0._btnlvrankOnClick(slot0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Rare)
	slot0:_refreshBtnStatus()
end

function slot0._btnrarerankOnClick(slot0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Power)
	slot0:_refreshBtnStatus()
end

function slot0._btnfaithrankOnClick(slot0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Resource)
	slot0:_refreshBtnStatus()
end

function slot0._btnclassifyOnClick(slot0)
	if EliminateTeamSelectionModel.instance:isPreset() then
		GameFacade.showToast(ToastEnum.EliminatePresetTip1)

		return
	end

	EliminateSelectChessMenListModel.instance:setQuickEdit(not EliminateSelectChessMenListModel.instance:getQuickEdit())
	EliminateSelectChessMenListModel.instance:setSelectedChessMen()
	slot0:_refreshQuickEditBtnStatus()
end

function slot0._btnAddOnClick(slot0)
	if EliminateSelectChessMenListModel.instance:canAddChessMen(EliminateSelectChessMenListModel.instance:getSelectedChessMen()) then
		EliminateSelectChessMenListModel.instance:addSelectedChessMen(slot1)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_add)
	else
		GameFacade.showToast(ToastEnum.EliminateAddedFull)
	end
end

function slot0._btnOutOnClick(slot0)
	EliminateSelectChessMenListModel.instance:removeSelectedChessMen(EliminateSelectChessMenListModel.instance:getSelectedChessMen())
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_receive)
end

function slot0._btnEnterOnClick(slot0)
	if #EliminateSelectChessMenListModel.instance:getAddIds() == 0 then
		GameFacade.showToast(ToastEnum.EliminateAddedEmpty)

		return
	end

	if not EliminateTeamSelectionModel.instance:isPreset() and slot2 < EliminateSelectChessMenListModel.instance:getAddMaxCount() then
		GameFacade.showMessageBox(MessageBoxIdDefine.EliminateAddedNotEnough, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:_enterEpisode()
		end)

		return
	end

	slot0:_enterEpisode()
end

function slot0._enterEpisode(slot0)
	EliminateLevelController.instance:enterLevel(EliminateTeamSelectionModel.instance:getSelectedEpisodeId(), EliminateTeamSelectionModel.instance:getSelectedCharacterId(), EliminateSelectChessMenListModel.instance:getAddIds())

	if not EliminateTeamSelectionModel.instance:isPreset() then
		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, slot3)
		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, EliminateSelectChessMenListModel.instance:serializeAddList())
	end
end

function slot0._initSortNode(slot0, slot1, slot2)
	slot6 = gohelper.findChild(slot0.viewGO, string.format("Left/#go_Sort/%s/btn2/txt/arrow", slot2))
	slot0._sortBtnNodeList[slot1] = {
		btn1 = gohelper.findChild(slot0.viewGO, string.format("Left/#go_Sort/%s/btn1", slot2)),
		btn1ArrowTrans = gohelper.findChild(slot0.viewGO, string.format("Left/#go_Sort/%s/btn1/txt/arrow", slot2)) and slot4.transform,
		btn2 = gohelper.findChild(slot0.viewGO, string.format("Left/#go_Sort/%s/btn2", slot2)),
		btn2ArrowTrans = slot6 and slot6.transform
	}
end

function slot0._refreshBtnStatus(slot0)
	for slot5, slot6 in ipairs(slot0._sortBtnNodeList) do
		slot7 = slot5 == EliminateSelectChessMenListModel.instance:getCurSortType()

		gohelper.setActive(slot6.btn1, not slot7)
		gohelper.setActive(slot6.btn2, slot7)

		slot8 = EliminateSelectChessMenListModel.instance:getSortState(slot5)

		transformhelper.setLocalScale(slot6.btn1ArrowTrans, 1, slot8, 1)
		transformhelper.setLocalScale(slot6.btn2ArrowTrans, 1, slot8, 1)
	end
end

function slot0._refreshQuickEditBtnStatus(slot0)
	slot1 = EliminateSelectChessMenListModel.instance:getQuickEdit()

	gohelper.setActive(slot0._quickEditBtns.btn1, not slot1)
	gohelper.setActive(slot0._quickEditBtns.btn2, slot1)
end

function slot0._editableInitView(slot0)
	slot0._goStars = gohelper.findChild(slot0.viewGO, "Right/#go_Detail/Info/Stars")
	slot0._sortBtnNodeList = slot0:getUserDataTb_()

	slot0:_initSortNode(EliminateMapEnum.SortType.Rare, "#btn_lvrank")
	slot0:_initSortNode(EliminateMapEnum.SortType.Power, "#btn_rarerank")

	slot4 = EliminateMapEnum.SortType.Resource

	slot0:_initSortNode(slot4, "#btn_faithrank")

	slot0._levelList = {}

	for slot4 = 1, 5 do
		table.insert(slot0._levelList, slot4)
	end

	slot1 = "quickEdit"

	slot0:_initSortNode(slot1, "#btn_classify")

	slot0._quickEditBtns = slot0._sortBtnNodeList[slot1]

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.QuickSelectChessMen, slot0._onQuickSelectChessMen, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, slot0._onSelectChessMen, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ChangeChessMen, slot0._onChangeChessMen, slot0)
	gohelper.setActive(slot0._goEmpty, true)
	gohelper.setActive(slot0._goDetail, false)
	EliminateSelectChessMenListModel.instance:initList()
	slot0:_initSlots()
	slot0:_updateSlots()
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function slot0._onQuickSelectChessMen(slot0)
	if EliminateSelectChessMenListModel.instance:isInAddList(EliminateSelectChessMenListModel.instance:getSelectedChessMen()) then
		slot0:_btnOutOnClick()
	else
		slot0:_btnAddOnClick()
	end
end

function slot0._onChangeChessMen(slot0)
	slot0:_updateSlots()
	slot0:_onSelectChessMen()
end

function slot0._onSelectChessMen(slot0)
	slot1 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(slot0._goEmpty, not slot1)
	gohelper.setActive(slot0._goDetail, slot1)

	if not slot1 then
		return
	end

	slot2 = slot1.config
	slot0._txtFireNum.text = slot2.defaultPower
	slot0._txtDescr.text = EliminateLevelModel.instance.formatString(slot0:_getSkillDesc(slot2.skillId), EliminateTeamChessEnum.PreBattleFormatType)
	slot0._txtChessName.text = slot2.name

	slot0:_showOperationBtns()
	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. slot2.level, false)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1.costList, slot0._goResource, slot0._goResourceItem)
	UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot2.resPic, false)
	gohelper.setActive(slot0._goStar1, false)
end

function slot0._getSkillDesc(slot0, slot1)
	slot2 = ""

	for slot7, slot8 in ipairs(string.splitToNumber(slot1, "#")) do
		slot9 = lua_soldier_skill.configDict[slot8]
		slot2 = string.nilorempty(slot2) and slot9.skillDes or slot2 .. "\n" .. slot9.skillDes
	end

	return slot2
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(gohelper.findChildImage(slot1, "#image_ResourceQuality"), EliminateTeamChessEnum.ResourceTypeToImagePath[slot2[1]], false)

	gohelper.findChildText(slot1, "#image_ResourceQuality/#txt_ResourceNum").text = slot2[2]
end

function slot0._showOperationBtns(slot0)
	slot2 = EliminateSelectChessMenListModel.instance:isInAddList(EliminateSelectChessMenListModel.instance:getSelectedChessMen())

	if EliminateSelectChessMenListModel.instance:getQuickEdit() or EliminateTeamSelectionModel.instance:isPreset() then
		gohelper.setActive(slot0._btnAdd, false)
		gohelper.setActive(slot0._btnOut, false)

		return
	end

	gohelper.setActive(slot0._btnAdd, not slot2)
	gohelper.setActive(slot0._btnOut, slot2)
end

function slot0._initSlots(slot0)
	slot0._slotList = slot0:getUserDataTb_()

	for slot5 = 1, 8 do
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goSlot), EliminateSelectChessMenSlot)
		slot0._slotList[slot5] = slot7

		slot7:setIndex(slot5)
	end
end

function slot0._updateSlots(slot0)
	for slot4, slot5 in ipairs(slot0._slotList) do
		slot5:onUpdateMO(EliminateSelectChessMenListModel.instance:getAddChessMen(slot4))
	end
end

function slot0.onOpen(slot0)
	slot0:_refreshBtnStatus()
	slot0:_refreshQuickEditBtnStatus()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	EliminateSelectChessMenListModel.instance:clearList()
end

return slot0
