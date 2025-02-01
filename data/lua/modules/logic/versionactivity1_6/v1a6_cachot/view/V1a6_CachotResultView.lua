module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultView", package.seeall)

slot0 = class("V1a6_CachotResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_levelbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#btn_close")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_result/left/#go_success")
	slot0._txtending = gohelper.findChildText(slot0.viewGO, "#go_result/left/#txt_ending")
	slot0._gofailed = gohelper.findChild(slot0.viewGO, "#go_result/left/#go_failed")
	slot0._txtroom = gohelper.findChildText(slot0.viewGO, "#go_result/left/#txt_room")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_result/left/#txt_level")
	slot0._txtmode = gohelper.findChildText(slot0.viewGO, "#go_result/left/#txt_mode")
	slot0._goscore = gohelper.findChild(slot0.viewGO, "#go_result/right/#go_score")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "#go_result/right/#go_score/#txt_score")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_result/right/#scroll_view")
	slot0._gomemberitem = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem")
	slot0._txtmembernum = gohelper.findChildText(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/title/titlebg/txt/#txt_membernum")
	slot0._gorolehead = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container/#go_rolehead")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem")
	slot0._txtcollectionnum = gohelper.findChildText(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/title/titlebg/txt/#txt_collectionnum")
	slot0._gocollection = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_collection")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_title")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_result/#simage_title/#txt_title")
	slot0._simagecg = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/left/#go_success/#simage_cg")
	slot0._godoubletag = gohelper.findChild(slot0.viewGO, "#go_result/right/#go_score/#go_doubletag")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_empty")
	slot0._txtmax = gohelper.findChildText(slot0.viewGO, "#go_result/right/#go_score/#txt_max")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goHeroScrollContent = gohelper.findChild(slot0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_unfold)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = V1a6_CachotModel.instance:getRogueEndingInfo() and slot1._isFinish or false

	gohelper.setActive(slot0._gosuccess, slot2)
	gohelper.setActive(slot0._gofailed, not slot2)
	slot0:refreshHeroGroup(slot1)
	slot0:refreshChallengeInfo(slot1)
	slot0:refreshCollections(slot1)
end

function slot0.refreshHeroGroup(slot0, slot1)
	slot2 = slot1 and slot1._heros or {}

	table.sort(slot2, slot0.heroListSortFunc)
	gohelper.CreateObjList(slot0, slot0._refreshSingleHero, slot2, slot0._goHeroScrollContent, slot0._gorolehead)

	slot0._txtmembernum.text = slot2 and #slot2 or 0
end

function slot0.heroListSortFunc(slot0, slot1)
	return slot1 < slot0
end

function slot0._refreshSingleHero(slot0, slot1, slot2, slot3)
	if HeroConfig.instance:getHeroCO(slot2) then
		gohelper.getSingleImage(gohelper.findChildImage(slot1, "image_icon").gameObject):LoadImage(ResUrl.roomHeadIcon(FightConfig.instance:getSkinCO(slot5.skinId).retangleIcon))
	end
end

function slot0.refreshCollections(slot0, slot1)
	if slot1 and slot1._collections then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = gohelper.cloneInPlace(slot0._gocollection, "collectionItem_" .. slot6)

			gohelper.setActive(slot8, true)

			slot9 = gohelper.findChildSingleImage(slot8, "simage_icon")

			if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot7) then
				slot9.curImageUrl = nil

				slot9:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot10.icon))
			end
		end
	end

	slot3 = slot2 and #slot2 or 0

	gohelper.setActive(slot0._goempty, slot3 <= 0)

	slot0._txtcollectionnum.text = slot3
end

function slot0.refreshChallengeInfo(slot0, slot1)
	if slot1 then
		slot0:refreshScoreInfo(slot1._score, slot1._doubleScore)
		slot0:refreshRoomInfo(slot1._roomNum, slot1._roomId)
		slot0:refreshDifficultyInfo(slot1._difficulty)
		slot0:refreshEndingInfo(slot1._ending)
	end
end

function slot0.refreshScoreInfo(slot0, slot1, slot2)
	slot1 = slot1 or 0
	slot2 = slot2 or 0
	slot3 = V1a6_CachotModel.instance:getRogueStateInfo()
	slot4 = slot0:checkScoreIsFull(slot3)
	slot6 = ""

	gohelper.setActive(slot0._godoubletag, slot2 > 0)

	slot0._txtscore.text = (slot2 <= 0 or string.format("%s(+%s)", Mathf.Clamp(slot1 - slot2, 0, slot1), slot2)) and (slot4 and slot1 <= 0 and "0(MAX)" or string.format("%s", slot1))

	slot0:refreshMaxScoreTips(slot4, slot0:checkIsUnlockAllStage(slot3))
end

function slot0.checkScoreIsFull(slot0, slot1)
	return (slot1 and slot1.scoreLimit or 0) <= (slot1 and slot1.totalScore or 0)
end

function slot0.checkIsUnlockAllStage(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = not slot1.nextStageSecond or tonumber(slot1.nextStageSecond) < 0
	end

	return slot2
end

function slot0.refreshMaxScoreTips(slot0, slot1, slot2)
	gohelper.setActive(slot0._txtmax.gameObject, slot1)

	if slot1 then
		slot0._txtmax.text = slot2 and luaLang("v1a6_cachotresultview_unlockAndMax") or luaLang("v1a6_cachotresultview_lockAndMax")
	end
end

function slot0.refreshDifficultyInfo(slot0, slot1)
	slot2 = lua_rogue_difficulty.configDict and lua_rogue_difficulty.configDict[slot1]
	slot0._txtmode.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachotresultview_selectdifficult"), {
		slot1,
		slot2 and slot2.title or ""
	})
end

function slot0.refreshRoomInfo(slot0, slot1, slot2)
	slot3 = lua_rogue_room.configDict and lua_rogue_room.configDict[slot2]
	slot0._txtlevel.text = slot3 and slot3.name or ""
	slot0._txtroom.text = formatLuaLang("v1a6_cachotresultview_roomNum", slot1 or 0)
end

function slot0.refreshEndingInfo(slot0, slot1)
	if lua_rogue_ending.configDict[slot1] then
		slot0._txtending.text = tostring(slot2.title)

		slot0._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(slot2.resultIcon))
	end

	gohelper.setActive(slot0._txtending.gameObject, slot2 ~= nil)
end

function slot0.onClose(slot0)
	V1a6_CachotModel.instance:clearRogueEndingInfo()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Cachot and GameSceneMgr.instance:getCurScene():getCurLevelId() ~= 90001 then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
		V1a6_CachotController.instance:openV1a6_CachotMainView()
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
