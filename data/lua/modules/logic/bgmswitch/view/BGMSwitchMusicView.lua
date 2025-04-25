module("modules.logic.bgmswitch.view.BGMSwitchMusicView", package.seeall)

slot0 = class("BGMSwitchMusicView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomusics = gohelper.findChild(slot0.viewGO, "#go_musics")
	slot0._musicAni = slot0._gomusics:GetComponent(typeof(UnityEngine.Animator))
	slot0._simageRightBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_musics/#simage_RightBG")
	slot0._gomusictop = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop")
	slot0._btnmusicfilter = gohelper.findChildButton(slot0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter")
	slot0._gofilterbtn1 = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn1")
	slot0._gofilterbtn2 = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn2")
	slot0._gotab = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#go_tab")
	slot0._btntaball = gohelper.findChildButton(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball")
	slot0._goallreddot = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_allreddot")
	slot0._gotaballselected = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_taballselected")
	slot0._btntablike = gohelper.findChildButton(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike")
	slot0._gotablikeselected = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike/#go_tablikeselected")
	slot0._scrollSongList = gohelper.findChildScrollRect(slot0.viewGO, "#go_musics/#scroll_SongList")
	slot0._scrollTransition = LuaScrollRectTransition.getByScrollRectGO(slot0._scrollSongList.gameObject, ScrollEnum.ScrollDirV, 2)
	slot0._gosongitem = gohelper.findChild(slot0.viewGO, "#go_musics/#scroll_SongList/Viewport/Content/#go_songitem")
	slot0._gomusicbottom = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musicbottom")
	slot0._gocurrent = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musicbottom/#go_current")
	slot0._txtcurrent = gohelper.findChildText(slot0.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current")
	slot0._txtcurrentEn = gohelper.findChildText(slot0.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current/txt_CurrentEn")
	slot0._goset = gohelper.findChild(slot0.viewGO, "#go_musics/#go_musicbottom/#go_set")
	slot0._btnset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_musics/#go_musicbottom/#go_set/#btn_set")
	slot0._tabClick = gohelper.findChildClick(slot0.viewGO, "#go_musics/#go_musictop/#go_tab/#tab_click")
	slot0._selectedItem = nil

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmusicfilter:AddClickListener(slot0._btnmusicfilterOnClick, slot0)
	slot0._btntaball:AddClickListener(slot0._btntaballOnClick, slot0)
	slot0._btntablike:AddClickListener(slot0._btntablikeOnClick, slot0)
	slot0._tabClick:AddClickListener(slot0._btntabOnClick, slot0)
	slot0._btnset:AddClickListener(slot0._btnsetOnClick, slot0)
	slot0._scrollSongList:AddOnValueChanged(slot0._onScrollRectValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmusicfilter:RemoveClickListener()
	slot0._btntaball:RemoveClickListener()
	slot0._btntablike:RemoveClickListener()
	slot0._tabClick:RemoveClickListener()
	slot0._btnset:RemoveClickListener()
	slot0._scrollSongList:RemoveOnValueChanged()
end

function slot0._onScrollRectValueChanged(slot0, slot1, slot2)
	if slot0._clickTabBlock then
		return
	end

	if not slot0._scrollY or slot2 < 0 or slot2 > 1 then
		slot0._scrollY = slot2

		return
	end

	slot0._scrollTime = slot0._scrollTime or 0
	slot0._scrollTime = slot0._scrollTime + UnityEngine.Time.deltaTime

	if slot0._scrollTime > 0.1 and (Mathf.Ceil((slot0._showItemCount or 0) * 0.5) - 5 > 0 and slot3 or 0) * math.abs(slot0._scrollY - slot2) > 0.2 then
		slot0._scrollTime = 0
		slot0._scrollY = slot2

		BGMSwitchAudioTrigger.play_ui_checkpoint_resources_cardpass()
	end
end

function slot0._btnmusicfilterOnClick(slot0)
	BGMSwitchController.instance:openBGMSwitchMusicFilterView()
	BGMSwitchAudioTrigger.play_ui_achieve_weiqicard_switch()
end

function slot0._btntaballOnClick(slot0)
	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		return
	end

	slot0._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	TaskDispatcher.runDelay(slot0._switchRefresh, slot0, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function slot0._btntablikeOnClick(slot0)
	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.Loved then
		return
	end

	if not BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted() or not next(slot2) then
		GameFacade.showToast(ToastEnum.NoSetLoveSongs)

		return
	end

	slot0._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
	TaskDispatcher.runDelay(slot0._switchRefresh, slot0, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function slot0._btntabOnClick(slot0)
	if slot0._clickTabBlock then
		return
	end

	slot0._clickTabBlock = true

	TaskDispatcher.runDelay(slot0._cancelTabBlock, slot0, 0.2)

	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		slot0:_btntablikeOnClick()
		slot0:_delayFocus()
	elseif slot1 == BGMSwitchEnum.SelectType.Loved then
		slot0:_btntaballOnClick()
		slot0:_delayFocus()
	end
end

function slot0._cancelTabBlock(slot0)
	slot0._clickTabBlock = nil
end

function slot0._switchRefresh(slot0)
	slot0:_refreshView()
end

function slot0._btnsetOnClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		ToastController.instance:showToast(ToastEnum.OnlyChannelOneCouldSwitch)

		return
	end

	slot2 = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:isRandomMode() then
		slot2 = BGMSwitchModel.RandomBgmId
	end

	BgmRpc.instance:sendSetUseBgmRequest(slot2)
	StatController.instance:track(StatEnum.EventName.SetBackgroundBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(slot2),
		[StatEnum.EventProperties.AudioName] = BGMSwitchConfig.instance:getBGMSwitchCO(slot2) and slot4.audioName or "",
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBGMSwitchCO(BGMSwitchModel.instance:getUsedBgmIdFromServer()) and slot7.audioName or "",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
	})
end

function slot0._editableInitView(slot0)
	slot0:_addSelfEvents()

	slot0._items = {}
	slot1 = BGMSwitchMusicItem.New()

	slot1:init(slot0._gosongitem)
	slot1:hide(false)
	slot1:setRandom(true)
	slot1:setItem()

	slot0._items[0] = slot1
end

function slot0._addSelfEvents(slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.SetPlayingBgm, slot0._refreshView, slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.ItemSelected, slot0._refreshView, slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.FilterClassSelect, slot0._refreshView, slot0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
end

function slot0._onBgmSwitched(slot0)
	slot0:_refreshView()

	if slot0._items[BGMSwitchModel.instance:getCurBgm()] then
		slot0._items[slot1]:showSwitchEffect()
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) then
		BGMSwitchModel.instance:setBGMSelectType(BGMSwitchModel.instance:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType))
	elseif slot1 == BGMSwitchEnum.SelectType.Loved then
		if LuaUtil.tableContains(BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted(), slot2) then
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
		else
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
		end
	else
		BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	end

	BGMSwitchModel.instance:setCurBgm(slot2)
	slot0:_refreshView()
	slot0:_delayFocus()
end

function slot0._delayFocus(slot0)
	slot0:_cancelDelayFocus()
	TaskDispatcher.runDelay(slot0._focusItem, slot0, 0.5)
end

function slot0._cancelDelayFocus(slot0)
	TaskDispatcher.cancelTask(slot0._focusItem, slot0)
end

function slot0._focusItem(slot0)
	if slot0._selectIdx then
		slot0._scrollTransition:focusCellInViewPort(slot0._selectIdx, true)
	end
end

function slot0._refreshView(slot0, slot1, slot2)
	slot0:_refreshTop()
	slot0:_refreshMusicItems()
	slot0:_refreshBottom()

	if slot2 then
		slot0:_delayFocus()
	end
end

function slot0._refreshTop(slot0)
	gohelper.setActive(slot0._gotaballselected, BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All)
	gohelper.setActive(slot0._gotablikeselected, slot1 == BGMSwitchEnum.SelectType.Loved)

	slot2 = BGMSwitchModel.instance:isFilterMode()

	gohelper.setActive(slot0._gofilterbtn1, not slot2)
	gohelper.setActive(slot0._gofilterbtn2, slot2)
	gohelper.setActive(slot0._goallreddot, BGMSwitchModel.instance:hasUnreadBgm())
end

function slot0._refreshBottom(slot0)
	if BGMSwitchModel.instance:isLocalRemoteListTypeMatched() and BGMSwitchModel.instance:isLocalRemoteBgmIdMatched() then
		slot0._txtcurrent.text = luaLang("bgmswitchview_current")
		slot0._txtcurrentEn.text = luaLang("p_bgmswitchview_current_en")

		gohelper.setActive(slot0._gocurrent, true)
		gohelper.setActive(slot0._goset, false)
	elseif slot0._selectedItem ~= nil then
		gohelper.setActive(slot0._gocurrent, false)
		gohelper.setActive(slot0._goset, true)
	else
		slot0._txtcurrent.text = luaLang("bgmswitchview_selectlisten")
		slot0._txtcurrentEn.text = luaLang("p_bgmswitchview_selectlisten_en")

		gohelper.setActive(slot0._gocurrent, true)
		gohelper.setActive(slot0._goset, false)
	end
end

function slot0._refreshMusicItems(slot0)
	slot1 = {}

	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		slot1 = BGMSwitchModel.instance:getFilteredAllBgmsSorted()
	elseif slot2 == BGMSwitchEnum.SelectType.Loved then
		slot1 = BGMSwitchModel.instance:getFilteredFavoriteBgmsSorted()
	end

	for slot6, slot7 in pairs(slot0._items) do
		if slot6 ~= 0 then
			slot7:hide(true)
		else
			slot7:setItem()
		end
	end

	slot0._selectedItem = nil
	slot0._selectIdx = nil

	if slot0._items[0]:isSelected() then
		slot0._selectedItem = slot0._items[0]
		slot0._selectIdx = 1
	end

	for slot7, slot8 in ipairs(slot1) do
		if not slot0._items[slot8] then
			slot9 = BGMSwitchMusicItem.New()

			slot9:init(gohelper.cloneInPlace(slot0._gosongitem, slot8))
			slot9:setRandom(false)

			slot0._items[slot8] = slot9
		end

		slot0._items[slot8]:hide(false)
		gohelper.setSibling(slot0._items[slot8].go, slot3)
		slot0._items[slot8]:setItem(BGMSwitchModel.instance:getBgmInfo(slot8))

		if slot0._items[slot8]:isSelected() then
			slot0._selectedItem = slot0._items[slot8]
			slot0._selectIdx = slot3 + 1
		end

		slot3 = slot3 + 1
	end

	slot0._showItemCount = #slot1 + 1
end

function slot0.onClose(slot0)
	BGMSwitchModel.instance:clearFilterTypes()
end

function slot0._removeSelfEvents(slot0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.SetPlayingBgm, slot0._refreshView, slot0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.ItemSelected, slot0._refreshView, slot0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.FilterClassSelect, slot0._refreshView, slot0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._switchRefresh, slot0)
	TaskDispatcher.cancelTask(slot0._cancelTabBlock, slot0)
	slot0:_cancelDelayFocus()
	slot0:_removeSelfEvents()

	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end
	end
end

return slot0
