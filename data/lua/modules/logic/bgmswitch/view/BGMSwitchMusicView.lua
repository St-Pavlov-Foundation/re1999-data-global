module("modules.logic.bgmswitch.view.BGMSwitchMusicView", package.seeall)

local var_0_0 = class("BGMSwitchMusicView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomusics = gohelper.findChild(arg_1_0.viewGO, "#go_musics")
	arg_1_0._musicAni = arg_1_0._gomusics:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simageRightBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_musics/#simage_RightBG")
	arg_1_0._gomusictop = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop")
	arg_1_0._btnmusicfilter = gohelper.findChildButton(arg_1_0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter")
	arg_1_0._gofilterbtn1 = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn1")
	arg_1_0._gofilterbtn2 = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#btn_musicfilter/btn2")
	arg_1_0._gotab = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab")
	arg_1_0._btntaball = gohelper.findChildButton(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball")
	arg_1_0._goallreddot = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_allreddot")
	arg_1_0._gotaballselected = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_taball/#go_taballselected")
	arg_1_0._btntablike = gohelper.findChildButton(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike")
	arg_1_0._gotablikeselected = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#btn_tablike/#go_tablikeselected")
	arg_1_0._scrollSongList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_musics/#scroll_SongList")

	local var_1_0 = arg_1_0._scrollSongList.gameObject

	arg_1_0._scrollTransition = LuaScrollRectTransition.getByScrollRectGO(var_1_0, ScrollEnum.ScrollDirV, 2)
	arg_1_0._gosongitem = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#scroll_SongList/Viewport/Content/#go_songitem")
	arg_1_0._gomusicbottom = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musicbottom")
	arg_1_0._gocurrent = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musicbottom/#go_current")
	arg_1_0._txtcurrent = gohelper.findChildText(arg_1_0.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current")
	arg_1_0._txtcurrentEn = gohelper.findChildText(arg_1_0.viewGO, "#go_musics/#go_musicbottom/#go_current/txt_Current/txt_CurrentEn")
	arg_1_0._goset = gohelper.findChild(arg_1_0.viewGO, "#go_musics/#go_musicbottom/#go_set")
	arg_1_0._btnset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_musics/#go_musicbottom/#go_set/#btn_set")
	arg_1_0._tabClick = gohelper.findChildClick(arg_1_0.viewGO, "#go_musics/#go_musictop/#go_tab/#tab_click")
	arg_1_0._selectedItem = nil

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmusicfilter:AddClickListener(arg_2_0._btnmusicfilterOnClick, arg_2_0)
	arg_2_0._btntaball:AddClickListener(arg_2_0._btntaballOnClick, arg_2_0)
	arg_2_0._btntablike:AddClickListener(arg_2_0._btntablikeOnClick, arg_2_0)
	arg_2_0._tabClick:AddClickListener(arg_2_0._btntabOnClick, arg_2_0)
	arg_2_0._btnset:AddClickListener(arg_2_0._btnsetOnClick, arg_2_0)
	arg_2_0._scrollSongList:AddOnValueChanged(arg_2_0._onScrollRectValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmusicfilter:RemoveClickListener()
	arg_3_0._btntaball:RemoveClickListener()
	arg_3_0._btntablike:RemoveClickListener()
	arg_3_0._tabClick:RemoveClickListener()
	arg_3_0._btnset:RemoveClickListener()
	arg_3_0._scrollSongList:RemoveOnValueChanged()
end

function var_0_0._onScrollRectValueChanged(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._clickTabBlock then
		return
	end

	if not arg_4_0._scrollY or arg_4_2 < 0 or arg_4_2 > 1 then
		arg_4_0._scrollY = arg_4_2

		return
	end

	arg_4_0._scrollTime = arg_4_0._scrollTime or 0
	arg_4_0._scrollTime = arg_4_0._scrollTime + UnityEngine.Time.deltaTime

	local var_4_0 = Mathf.Ceil((arg_4_0._showItemCount or 0) * 0.5) - 5

	var_4_0 = var_4_0 > 0 and var_4_0 or 0

	local var_4_1 = var_4_0 * math.abs(arg_4_0._scrollY - arg_4_2)

	if arg_4_0._scrollTime > 0.1 and var_4_1 > 0.2 then
		arg_4_0._scrollTime = 0
		arg_4_0._scrollY = arg_4_2

		BGMSwitchAudioTrigger.play_ui_checkpoint_resources_cardpass()
	end
end

function var_0_0._btnmusicfilterOnClick(arg_5_0)
	BGMSwitchController.instance:openBGMSwitchMusicFilterView()
	BGMSwitchAudioTrigger.play_ui_achieve_weiqicard_switch()
end

function var_0_0._btntaballOnClick(arg_6_0)
	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		return
	end

	arg_6_0._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	TaskDispatcher.runDelay(arg_6_0._switchRefresh, arg_6_0, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function var_0_0._btntablikeOnClick(arg_7_0)
	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.Loved then
		return
	end

	local var_7_0 = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()

	if not var_7_0 or not next(var_7_0) then
		GameFacade.showToast(ToastEnum.NoSetLoveSongs)

		return
	end

	arg_7_0._musicAni:Play("switch", 0, 0)
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
	TaskDispatcher.runDelay(arg_7_0._switchRefresh, arg_7_0, 0.16)
	BGMSwitchAudioTrigger.play_ui_rolesgo()
end

function var_0_0._btntabOnClick(arg_8_0)
	if arg_8_0._clickTabBlock then
		return
	end

	arg_8_0._clickTabBlock = true

	TaskDispatcher.runDelay(arg_8_0._cancelTabBlock, arg_8_0, 0.2)

	local var_8_0 = BGMSwitchModel.instance:getBGMSelectType()

	if var_8_0 == BGMSwitchEnum.SelectType.All then
		arg_8_0:_btntablikeOnClick()
		arg_8_0:_delayFocus()
	elseif var_8_0 == BGMSwitchEnum.SelectType.Loved then
		arg_8_0:_btntaballOnClick()
		arg_8_0:_delayFocus()
	end
end

function var_0_0._cancelTabBlock(arg_9_0)
	arg_9_0._clickTabBlock = nil
end

function var_0_0._switchRefresh(arg_10_0)
	arg_10_0:_refreshView()
end

function var_0_0._btnsetOnClick(arg_11_0)
	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		ToastController.instance:showToast(ToastEnum.OnlyChannelOneCouldSwitch)

		return
	end

	local var_11_0 = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:isRandomMode() then
		var_11_0 = BGMSwitchModel.RandomBgmId
	end

	BgmRpc.instance:sendSetUseBgmRequest(var_11_0)

	local var_11_1 = BGMSwitchConfig.instance:getBGMSwitchCO(var_11_0)
	local var_11_2 = var_11_1 and var_11_1.audioName or ""
	local var_11_3 = BGMSwitchModel.instance:getUsedBgmIdFromServer()
	local var_11_4 = BGMSwitchConfig.instance:getBGMSwitchCO(var_11_3)
	local var_11_5 = var_11_4 and var_11_4.audioName or ""
	local var_11_6 = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SetBackgroundBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(var_11_0),
		[StatEnum.EventProperties.AudioName] = var_11_2,
		[StatEnum.EventProperties.BeforeSwitchAudio] = var_11_5,
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_11_6)
	})
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0:_addSelfEvents()

	arg_12_0._items = {}

	local var_12_0 = BGMSwitchMusicItem.New()

	var_12_0:init(arg_12_0._gosongitem)
	var_12_0:hide(false)
	var_12_0:setRandom(true)
	var_12_0:setItem()

	arg_12_0._items[0] = var_12_0
end

function var_0_0._addSelfEvents(arg_13_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.SetPlayingBgm, arg_13_0._refreshView, arg_13_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.ItemSelected, arg_13_0._refreshView, arg_13_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.FilterClassSelect, arg_13_0._refreshView, arg_13_0)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmSwitched, arg_13_0._onBgmSwitched, arg_13_0)
end

function var_0_0._onBgmSwitched(arg_14_0)
	arg_14_0:_refreshView()

	local var_14_0 = BGMSwitchModel.instance:getCurBgm()

	if arg_14_0._items[var_14_0] then
		arg_14_0._items[var_14_0]:showSwitchEffect()
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	local var_16_0 = BGMSwitchModel.instance:getServerRecordInfoByType(BGMSwitchEnum.RecordInfoType.ListType)
	local var_16_1 = BGMSwitchModel.instance:getUsedBgmIdFromServer()

	if BGMSwitchModel.instance:isRandomBgmId(var_16_1) then
		BGMSwitchModel.instance:setBGMSelectType(var_16_0)
	elseif var_16_0 == BGMSwitchEnum.SelectType.Loved then
		local var_16_2 = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()

		if LuaUtil.tableContains(var_16_2, var_16_1) then
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.Loved)
		else
			BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
		end
	else
		BGMSwitchModel.instance:setBGMSelectType(BGMSwitchEnum.SelectType.All)
	end

	BGMSwitchModel.instance:setCurBgm(var_16_1)
	arg_16_0:_refreshView()
	arg_16_0:_delayFocus()
end

function var_0_0._delayFocus(arg_17_0)
	arg_17_0:_cancelDelayFocus()
	TaskDispatcher.runDelay(arg_17_0._focusItem, arg_17_0, 0.5)
end

function var_0_0._cancelDelayFocus(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._focusItem, arg_18_0)
end

function var_0_0._focusItem(arg_19_0)
	if arg_19_0._selectIdx then
		arg_19_0._scrollTransition:focusCellInViewPort(arg_19_0._selectIdx, true)
	end
end

function var_0_0._refreshView(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:_refreshTop()
	arg_20_0:_refreshMusicItems()
	arg_20_0:_refreshBottom()

	if arg_20_2 then
		arg_20_0:_delayFocus()
	end
end

function var_0_0._refreshTop(arg_21_0)
	local var_21_0 = BGMSwitchModel.instance:getBGMSelectType()

	gohelper.setActive(arg_21_0._gotaballselected, var_21_0 == BGMSwitchEnum.SelectType.All)
	gohelper.setActive(arg_21_0._gotablikeselected, var_21_0 == BGMSwitchEnum.SelectType.Loved)

	local var_21_1 = BGMSwitchModel.instance:isFilterMode()

	gohelper.setActive(arg_21_0._gofilterbtn1, not var_21_1)
	gohelper.setActive(arg_21_0._gofilterbtn2, var_21_1)

	local var_21_2 = BGMSwitchModel.instance:hasUnreadBgm()

	gohelper.setActive(arg_21_0._goallreddot, var_21_2)
end

function var_0_0._refreshBottom(arg_22_0)
	if BGMSwitchModel.instance:isLocalRemoteListTypeMatched() and BGMSwitchModel.instance:isLocalRemoteBgmIdMatched() then
		arg_22_0._txtcurrent.text = luaLang("bgmswitchview_current")
		arg_22_0._txtcurrentEn.text = luaLang("p_bgmswitchview_current_en")

		gohelper.setActive(arg_22_0._gocurrent, true)
		gohelper.setActive(arg_22_0._goset, false)
	elseif arg_22_0._selectedItem ~= nil then
		gohelper.setActive(arg_22_0._gocurrent, false)
		gohelper.setActive(arg_22_0._goset, true)
	else
		arg_22_0._txtcurrent.text = luaLang("bgmswitchview_selectlisten")
		arg_22_0._txtcurrentEn.text = luaLang("p_bgmswitchview_selectlisten_en")

		gohelper.setActive(arg_22_0._gocurrent, true)
		gohelper.setActive(arg_22_0._goset, false)
	end
end

function var_0_0._refreshMusicItems(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = BGMSwitchModel.instance:getBGMSelectType()

	if var_23_1 == BGMSwitchEnum.SelectType.All then
		var_23_0 = BGMSwitchModel.instance:getFilteredAllBgmsSorted()
	elseif var_23_1 == BGMSwitchEnum.SelectType.Loved then
		var_23_0 = BGMSwitchModel.instance:getFilteredFavoriteBgmsSorted()
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0._items) do
		if iter_23_0 ~= 0 then
			iter_23_1:hide(true)
		else
			iter_23_1:setItem()
		end
	end

	local var_23_2 = 1

	arg_23_0._selectedItem = nil
	arg_23_0._selectIdx = nil

	if arg_23_0._items[0]:isSelected() then
		arg_23_0._selectedItem = arg_23_0._items[0]
		arg_23_0._selectIdx = var_23_2
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		if not arg_23_0._items[iter_23_3] then
			local var_23_3 = BGMSwitchMusicItem.New()
			local var_23_4 = gohelper.cloneInPlace(arg_23_0._gosongitem, iter_23_3)

			var_23_3:init(var_23_4)
			var_23_3:setRandom(false)

			arg_23_0._items[iter_23_3] = var_23_3
		end

		arg_23_0._items[iter_23_3]:hide(false)
		gohelper.setSibling(arg_23_0._items[iter_23_3].go, var_23_2)

		local var_23_5 = BGMSwitchModel.instance:getBgmInfo(iter_23_3)

		arg_23_0._items[iter_23_3]:setItem(var_23_5)

		if arg_23_0._items[iter_23_3]:isSelected() then
			arg_23_0._selectedItem = arg_23_0._items[iter_23_3]
			arg_23_0._selectIdx = var_23_2 + 1
		end

		var_23_2 = var_23_2 + 1
	end

	arg_23_0._showItemCount = #var_23_0 + 1
end

function var_0_0.onClose(arg_24_0)
	BGMSwitchModel.instance:clearFilterTypes()
end

function var_0_0._removeSelfEvents(arg_25_0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.SetPlayingBgm, arg_25_0._refreshView, arg_25_0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.ItemSelected, arg_25_0._refreshView, arg_25_0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.FilterClassSelect, arg_25_0._refreshView, arg_25_0)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmSwitched, arg_25_0._onBgmSwitched, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._switchRefresh, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._cancelTabBlock, arg_26_0)
	arg_26_0:_cancelDelayFocus()
	arg_26_0:_removeSelfEvents()

	if arg_26_0._items then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._items) do
			iter_26_1:destroy()
		end
	end
end

return var_0_0
