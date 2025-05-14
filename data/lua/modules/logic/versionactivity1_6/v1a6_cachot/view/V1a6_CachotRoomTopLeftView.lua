module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopLeftView", package.seeall)

local var_0_0 = class("V1a6_CachotRoomTopLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnexit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#btn_exit")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#btn_tips")
	arg_1_0._txtroomIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "top/#go_level/#txt_level")
	arg_1_0._golayerTips = gohelper.findChild(arg_1_0.viewGO, "top/#go_level/#go_layertips")
	arg_1_0._txtlayertitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "top/#go_level/#go_layertips/#txt_title")
	arg_1_0._golayereventitem = gohelper.findChild(arg_1_0.viewGO, "top/#go_level/#go_layertips/events/#go_tipsitem")
	arg_1_0._golayereventitemParent = arg_1_0._golayereventitem.transform.parent.gameObject
	arg_1_0._btnshowlayertips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_level/#btn_showlayertips")
	arg_1_0._eventItem = gohelper.findChild(arg_1_0.viewGO, "top/#go_level/layout/buff1")
	arg_1_0._eventParent = arg_1_0._eventItem.transform.parent.gameObject
end

function var_0_0.addEvents(arg_2_0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotRoomView, arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btnshowlayertips:AddClickListener(arg_2_0._btnshowlayertipsOnClick, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_2_0._refreshRoomInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	arg_3_0._btnexit:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnshowlayertips:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0._refreshRoomInfo, arg_3_0)
end

function var_0_0._btnshowlayertipsOnClick(arg_4_0)
	if not arg_4_0._eventParent.activeSelf then
		return
	end

	local var_4_0 = not arg_4_0._golayerTips.activeSelf

	gohelper.setActive(arg_4_0._golayerTips, var_4_0)
end

function var_0_0._onTouchScreen(arg_5_0)
	if gohelper.isMouseOverGo(arg_5_0._btnshowlayertips) then
		return
	end

	gohelper.setActive(arg_5_0._golayerTips, false)
end

function var_0_0._btntipsOnClick(arg_6_0)
	HelpController.instance:showHelp(HelpEnum.HelpId.Cachot1_6TotalHelp)
end

function var_0_0._btnexitOnClick(arg_7_0)
	if arg_7_0:isOpenView() then
		return
	end

	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statAbort()
	V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, V1a6_CachotEnum.ActivityId)
	end)
end

function var_0_0.isOpenView(arg_9_0)
	local var_9_0 = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		var_9_0 = true
	end

	return var_9_0
end

function var_0_0.onOpen(arg_10_0)
	gohelper.setActive(arg_10_0._golayerTips, false)
	arg_10_0:_refreshRoomInfo()
end

function var_0_0._refreshRoomInfo(arg_11_0)
	arg_11_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_11_0._rogueInfo then
		return
	end

	arg_11_0._txtroomIndex.text = arg_11_0._rogueInfo.layer

	if #arg_11_0._rogueInfo.nextEvents == 0 then
		gohelper.setActive(arg_11_0._eventParent, false)
	else
		gohelper.setActive(arg_11_0._eventParent, true)

		local var_11_0 = {}

		var_11_0[1] = 1

		for iter_11_0 = 1, #arg_11_0._rogueInfo.nextEvents do
			var_11_0[iter_11_0 + 1] = arg_11_0._rogueInfo.nextEvents[iter_11_0]
		end

		gohelper.CreateObjList(arg_11_0, arg_11_0._createEventItem, var_11_0, arg_11_0._eventParent, arg_11_0._eventItem, nil, 2)
		gohelper.CreateObjList(arg_11_0, arg_11_0._createEventItemInfo, arg_11_0._rogueInfo.nextEvents, arg_11_0._golayereventitemParent, arg_11_0._golayereventitem)
	end

	local var_11_1, var_11_2 = V1a6_CachotRoomConfig.instance:getLayerIndexAndTotal(arg_11_0._rogueInfo.room)

	arg_11_0._txtlayertitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a6_cachot_room_event_title"), {
		var_11_1,
		var_11_2
	})
end

function var_0_0._createEventItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = lua_rogue_event.configDict[arg_12_2.eventId]
	local var_12_1 = arg_12_1:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setV1a6CachotSprite(var_12_1, "v1a6_cachot_room_eventicon_small" .. var_12_0.icon)
end

function var_0_0._createEventItemInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = lua_rogue_event.configDict[arg_13_2.eventId]
	local var_13_1 = gohelper.findChildTextMesh(arg_13_1, "desc")
	local var_13_2 = gohelper.findChildImage(arg_13_1, "desc/icon")

	var_13_1.text = var_13_0.title

	UISpriteSetMgr.instance:setV1a6CachotSprite(var_13_2, "v1a6_cachot_room_eventicon_small" .. var_13_0.icon)
end

return var_0_0
