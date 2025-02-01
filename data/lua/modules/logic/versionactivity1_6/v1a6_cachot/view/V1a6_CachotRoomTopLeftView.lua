module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopLeftView", package.seeall)

slot0 = class("V1a6_CachotRoomTopLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnexit = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#btn_exit")
	slot0._btntips = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#btn_tips")
	slot0._txtroomIndex = gohelper.findChildTextMesh(slot0.viewGO, "top/#go_level/#txt_level")
	slot0._golayerTips = gohelper.findChild(slot0.viewGO, "top/#go_level/#go_layertips")
	slot0._txtlayertitle = gohelper.findChildTextMesh(slot0.viewGO, "top/#go_level/#go_layertips/#txt_title")
	slot0._golayereventitem = gohelper.findChild(slot0.viewGO, "top/#go_level/#go_layertips/events/#go_tipsitem")
	slot0._golayereventitemParent = slot0._golayereventitem.transform.parent.gameObject
	slot0._btnshowlayertips = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#go_level/#btn_showlayertips")
	slot0._eventItem = gohelper.findChild(slot0.viewGO, "top/#go_level/layout/buff1")
	slot0._eventParent = slot0._eventItem.transform.parent.gameObject
end

function slot0.addEvents(slot0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotRoomView, slot0._btnexitOnClick, slot0)
	slot0._btnexit:AddClickListener(slot0._btnexitOnClick, slot0)
	slot0._btntips:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0._btnshowlayertips:AddClickListener(slot0._btnshowlayertipsOnClick, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshRoomInfo, slot0)
end

function slot0.removeEvents(slot0)
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	slot0._btnexit:RemoveClickListener()
	slot0._btntips:RemoveClickListener()
	slot0._btnshowlayertips:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshRoomInfo, slot0)
end

function slot0._btnshowlayertipsOnClick(slot0)
	if not slot0._eventParent.activeSelf then
		return
	end

	gohelper.setActive(slot0._golayerTips, not slot0._golayerTips.activeSelf)
end

function slot0._onTouchScreen(slot0)
	if gohelper.isMouseOverGo(slot0._btnshowlayertips) then
		return
	end

	gohelper.setActive(slot0._golayerTips, false)
end

function slot0._btntipsOnClick(slot0)
	HelpController.instance:showHelp(HelpEnum.HelpId.Cachot1_6TotalHelp)
end

function slot0._btnexitOnClick(slot0)
	if slot0:isOpenView() then
		return
	end

	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statAbort()
	V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , V1a6_CachotEnum.ActivityId)
	end)
end

function slot0.isOpenView(slot0)
	slot1 = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		slot1 = true
	end

	return slot1
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._golayerTips, false)
	slot0:_refreshRoomInfo()
end

function slot0._refreshRoomInfo(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	slot0._txtroomIndex.text = slot0._rogueInfo.layer

	if #slot0._rogueInfo.nextEvents == 0 then
		gohelper.setActive(slot0._eventParent, false)
	else
		gohelper.setActive(slot0._eventParent, true)

		for slot5 = 1, #slot0._rogueInfo.nextEvents do
		end

		gohelper.CreateObjList(slot0, slot0._createEventItem, {
			1,
			[slot5 + 1] = slot0._rogueInfo.nextEvents[slot5]
		}, slot0._eventParent, slot0._eventItem, nil, 2)
		gohelper.CreateObjList(slot0, slot0._createEventItemInfo, slot0._rogueInfo.nextEvents, slot0._golayereventitemParent, slot0._golayereventitem)
	end

	slot1, slot2 = V1a6_CachotRoomConfig.instance:getLayerIndexAndTotal(slot0._rogueInfo.room)
	slot0._txtlayertitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a6_cachot_room_event_title"), {
		slot1,
		slot2
	})
end

function slot0._createEventItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setV1a6CachotSprite(slot1:GetComponent(gohelper.Type_Image), "v1a6_cachot_room_eventicon_small" .. lua_rogue_event.configDict[slot2.eventId].icon)
end

function slot0._createEventItemInfo(slot0, slot1, slot2, slot3)
	slot4 = lua_rogue_event.configDict[slot2.eventId]
	gohelper.findChildTextMesh(slot1, "desc").text = slot4.title

	UISpriteSetMgr.instance:setV1a6CachotSprite(gohelper.findChildImage(slot1, "desc/icon"), "v1a6_cachot_room_eventicon_small" .. slot4.icon)
end

return slot0
