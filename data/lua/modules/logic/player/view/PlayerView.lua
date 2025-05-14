module("modules.logic.player.view.PlayerView", package.seeall)

local var_0_0 = class("PlayerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bgroot")
	arg_1_0._txtentryday = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/#txt_entryday")
	arg_1_0._txtepisodeprogress = gohelper.findChildText(arg_1_0.viewGO, "leftside/txtContainer/progress/#txt_episodeprogress")
	arg_1_0._txtepisodeprogressen = gohelper.findChildText(arg_1_0.viewGO, "leftside/txtContainer/progress/#txt_episodeprogressen")
	arg_1_0._simageheadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	arg_1_0._btnheadicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "leftside/playerinfo/headframe/#simage_headicon/#go_framenode")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/lv/#txt_level")
	arg_1_0._txtexp = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/#txt_exp")
	arg_1_0._imageexp = gohelper.findChildSlider(arg_1_0.viewGO, "leftside/playerinfo/#slider_exp")
	arg_1_0._txtplayerid = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/#txt_playerid")
	arg_1_0._btnplayerid = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftside/playerinfo/#txt_playerid/#btn_playerid")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/#txt_name")
	arg_1_0._gosignature = gohelper.findChild(arg_1_0.viewGO, "leftside/playerinfo/signature")
	arg_1_0._txtsignature = gohelper.findChildText(arg_1_0.viewGO, "leftside/playerinfo/signature/scroll/viewport/#txt_signature")
	arg_1_0._btnsignature = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftside/playerinfo/signature/#btn_signature")
	arg_1_0._btnshowcharacterA1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter1/#btn_Add")
	arg_1_0._btnshowcharacterA2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter2/#btn_Add")
	arg_1_0._btnshowcharacterA3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter3/#btn_Add")
	arg_1_0._btnshowcharacterB1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter1/#btn_Character")
	arg_1_0._btnshowcharacterB2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter2/#btn_Character")
	arg_1_0._btnshowcharacterB3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "showcharacters/showcharacter3/#btn_Character")
	arg_1_0._btnmodifyname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftside/playerinfo/#txt_name/#btn_modifyname")
	arg_1_0._btncollection = gohelper.findChildButton(arg_1_0.viewGO, "collection")
	arg_1_0._btncloseCollectText = gohelper.findChildButton(arg_1_0.viewGO, "collection/#btn_closeCollectText")
	arg_1_0._btnchangebg = gohelper.findChildButton(arg_1_0.viewGO, "btn_changebg/#btn_changebg")
	arg_1_0._gochangebgreddot = gohelper.findChild(arg_1_0.viewGO, "btn_changebg/#go_reddot")
	arg_1_0._gocollectbg = gohelper.findChild(arg_1_0.viewGO, "collection/newbg")
	arg_1_0._goAssistReward = gohelper.findChild(arg_1_0.viewGO, "#go_gather")
	arg_1_0._btnGetAssistReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_gather/#btn_click")

	gohelper.setActive(arg_1_0._goAssistReward, false)

	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._loader = MultiAbLoader.New()
	arg_1_0._btnplayercard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_personalcard/#btn_changebg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplayercard:AddClickListener(arg_2_0._btnplayercardOnClick, arg_2_0)
	arg_2_0._btnplayerid:AddClickListener(arg_2_0._btnplayeridOnClick, arg_2_0)
	arg_2_0._btnsignature:AddClickListener(arg_2_0._btnsignatureOnClick, arg_2_0)
	arg_2_0._btnshowcharacterA1:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 1)
	arg_2_0._btnshowcharacterA2:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 2)
	arg_2_0._btnshowcharacterA3:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 3)
	arg_2_0._btnshowcharacterB1:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 1)
	arg_2_0._btnshowcharacterB2:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 2)
	arg_2_0._btnshowcharacterB3:AddClickListener(arg_2_0._showHeroClick, arg_2_0, 3)
	arg_2_0._btnheadicon:AddClickListener(arg_2_0._changeIcon, arg_2_0)
	arg_2_0._btncollection:AddClickListener(arg_2_0._showCollectionText, arg_2_0)
	arg_2_0._btncloseCollectText:AddClickListener(arg_2_0._hideCollectionText, arg_2_0)
	arg_2_0._btnmodifyname:AddClickListener(arg_2_0._btnmodifynameOnClick, arg_2_0)
	arg_2_0._btnchangebg:AddClickListener(arg_2_0._btnchangebgOnClick, arg_2_0)
	arg_2_0._btnGetAssistReward:AddClickListener(arg_2_0._btnGetAssistRewardOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_2_0._onCloseFullView, arg_2_0, LuaEventSystem.Low)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, arg_2_0.updateBg, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0.resetBg, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplayercard:RemoveClickListener()
	arg_3_0._btnplayerid:RemoveClickListener()
	arg_3_0._btnsignature:RemoveClickListener()
	arg_3_0._btnshowcharacterA1:RemoveClickListener()
	arg_3_0._btnshowcharacterA2:RemoveClickListener()
	arg_3_0._btnshowcharacterA3:RemoveClickListener()
	arg_3_0._btnshowcharacterB1:RemoveClickListener()
	arg_3_0._btnshowcharacterB2:RemoveClickListener()
	arg_3_0._btnshowcharacterB3:RemoveClickListener()
	arg_3_0._btnheadicon:RemoveClickListener()
	arg_3_0._btncollection:RemoveClickListener()
	arg_3_0._btncloseCollectText:RemoveClickListener()
	arg_3_0._btnmodifyname:RemoveClickListener()
	arg_3_0._btnchangebg:RemoveClickListener()
	arg_3_0._btnGetAssistReward:RemoveClickListener()

	if arg_3_0._playerSelf then
		arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_3_0._refreshIsHasAssistReward, arg_3_0)
	end

	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_3_0.updateBg, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0.resetBg, arg_3_0)
end

function var_0_0._btnplayercardOnClick(arg_4_0)
	if not arg_4_0._info then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		PlayerCardController.instance:openPlayerCardView({
			userId = arg_4_0._info.userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function var_0_0._btnplayeridOnClick(arg_5_0)
	arg_5_0._txtplayerid.text = arg_5_0._info.userId

	ZProj.UGUIHelper.CopyText(arg_5_0._txtplayerid.text)

	arg_5_0._txtplayerid.text = string.format("ID:%s", arg_5_0._info.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function var_0_0._btnsignatureOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.Signature)
end

function var_0_0._btnmodifynameOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function var_0_0._btnchangebgOnClick(arg_8_0)
	PostProcessingMgr.instance:setBlurWeight(0)
	arg_8_0:_closeAndDelayOpenView(ViewName.PlayerChangeBgView, {
		bgComp = arg_8_0._bgComp
	})
end

function var_0_0._closeAndDelayOpenView(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._playerSelf then
		return
	end

	ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	arg_9_0._viewAnim:Play(UIAnimationName.Close, 0, 0)

	arg_9_0._openViewData = {
		arg_9_1,
		arg_9_2
	}

	UIBlockMgr.instance:startBlock("PlayerViewDelayOpenView")
	TaskDispatcher.runDelay(arg_9_0._delayOpenView, arg_9_0, 0.12)
end

function var_0_0._delayOpenView(arg_10_0)
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	ViewMgr.instance:openView(unpack(arg_10_0._openViewData))
end

function var_0_0.resetBg(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.PlayerChangeBgView then
		arg_11_0._bgComp.go.transform:SetParent(arg_11_0.viewGO.transform, false)
		arg_11_0._bgComp.go.transform:SetSiblingIndex(0)
		arg_11_0:updateBg()
	end
end

function var_0_0._changeIcon(arg_12_0)
	if arg_12_0._playerSelf then
		ViewMgr.instance:openView(ViewName.IconTipView)
	end
end

function var_0_0._showHeroClick(arg_13_0, arg_13_1)
	arg_13_0:_closeAndDelayOpenView(ViewName.ShowCharacterView, {
		notRepeatUpdateAssistReward = true
	})
end

function var_0_0._btnGetAssistRewardOnClick(arg_14_0)
	if not arg_14_0._playerSelf then
		return
	end

	PlayerController.instance:getAssistReward()
end

function var_0_0._editableInitView(arg_15_0)
	gohelper.addUIClickAudio(arg_15_0._btnsignature.gameObject, AudioEnum.UI.play_ui_hero_sign)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterA1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterA2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterA3.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterB1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterB2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(arg_15_0._btnshowcharacterB3.gameObject, AudioEnum.UI.play_ui_hero_card_click)

	arg_15_0._collectionfulls = arg_15_0:getUserDataTb_()
	arg_15_0._collectiontxt = arg_15_0:getUserDataTb_()

	for iter_15_0 = 1, 5 do
		arg_15_0._collectionfulls[iter_15_0] = gohelper.findChildImage(arg_15_0.viewGO, "collection/collection" .. iter_15_0 .. "/#image_full")
		arg_15_0._collectiontxt[iter_15_0] = gohelper.findChildText(arg_15_0.viewGO, "collection/collection" .. iter_15_0 .. "/#txt_progress")
	end

	arg_15_0._bgComp = MonoHelper.addLuaComOnceToGo(arg_15_0._gobg, PlayerBgComp)

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:onOpen()
end

function var_0_0.onOpenFinish(arg_17_0)
	arg_17_0._viewAnim.enabled = true
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._info = arg_18_0.viewParam.playerInfo
	arg_18_0._playerSelf = arg_18_0.viewParam.playerSelf

	arg_18_0:_initPlayerCardinfo(arg_18_0._info)
	arg_18_0:_initPlayerbassinfo(arg_18_0._info)
	arg_18_0:_initPlayerOtherinfo(arg_18_0._info)
	arg_18_0:_initPlayerShowCard(arg_18_0._info.showHeros)
	arg_18_0:_hideCollectionText()

	if arg_18_0._playerSelf then
		arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, arg_18_0._initPlayerbassinfo, arg_18_0)
		arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.SetShowHero, arg_18_0._initPlayerShowCard, arg_18_0)
		arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.RenameFlagUpdate, arg_18_0._refreshRenameStatus, arg_18_0)
		arg_18_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_18_0._refreshIsHasAssistReward, arg_18_0)

		arg_18_0._btnheadicon.button.enabled = true

		arg_18_0:updateAssistReward()

		local var_18_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency)

		TaskDispatcher.cancelTask(arg_18_0.updateAssistReward, arg_18_0)
		TaskDispatcher.runRepeat(arg_18_0.updateAssistReward, arg_18_0, var_18_0)
	else
		arg_18_0:removeEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, arg_18_0._initPlayerbassinfo, arg_18_0)
		arg_18_0:removeEventCb(PlayerController.instance, PlayerEvent.SetShowHero, arg_18_0._initPlayerShowCard, arg_18_0)
		arg_18_0:removeEventCb(PlayerController.instance, PlayerEvent.RenameFlagUpdate, arg_18_0._refreshRenameStatus, arg_18_0)

		arg_18_0._btnheadicon.button.enabled = false

		gohelper.setActive(arg_18_0._goAssistReward, false)
	end

	RedDotController.instance:addRedDot(arg_18_0._gochangebgreddot, RedDotEnum.DotNode.PlayerChangeBgNew)
	gohelper.setActive(arg_18_0._gochangebgreddot, arg_18_0._playerSelf)
	gohelper.setActive(arg_18_0._btnsignature.gameObject, arg_18_0._playerSelf)

	arg_18_0._isGamePad = SDKNativeUtil.isGamePad()

	gohelper.setActive(arg_18_0._gosignature.gameObject, arg_18_0._isGamePad == false)
	arg_18_0:_refreshRenameStatus()
	arg_18_0:updateBg()
end

function var_0_0.updateAssistReward(arg_19_0)
	if not arg_19_0._playerSelf then
		return
	end

	PlayerController.instance:updateAssistRewardCount()
end

function var_0_0.updateBg(arg_20_0)
	if ViewMgr.instance:isOpen(ViewName.PlayerChangeBgView) then
		return
	end

	local var_20_0 = PlayerModel.instance:getPlayinfo()

	if not arg_20_0.viewParam.playerSelf and arg_20_0.viewParam.playerInfo then
		var_20_0 = arg_20_0.viewParam.playerInfo

		arg_20_0._bgComp:setPlayerInfo(arg_20_0.viewParam.playerInfo, arg_20_0.viewParam.heroCover)
	end

	local var_20_1 = PlayerConfig.instance:getBgCo(var_20_0.bg)

	arg_20_0._bgComp:showBg(var_20_1)
	gohelper.setActive(arg_20_0._gocollectbg, var_20_1.item ~= 0)
end

function var_0_0._initPlayerbassinfo(arg_21_0, arg_21_1)
	arg_21_0._txtname.text = arg_21_1.name
	arg_21_0._txtplayerid.text = string.format("ID:%s", arg_21_1.userId)

	local var_21_0 = arg_21_1.signature

	if string.nilorempty(var_21_0) then
		local var_21_1 = string.split(CommonConfig.instance:getConstStr(ConstEnum.RoleRandomSignature), "#")

		if var_21_1 and #var_21_1 > 0 then
			var_21_0 = var_21_1[math.random(1, #var_21_1)]
		end
	end

	arg_21_0._txtsignature.text = var_21_0

	gohelper.setActive(arg_21_0._txtsignature.gameObject, true)

	arg_21_0._txtentryday.text = TimeUtil.langTimestampToString3(ServerTime.timeInLocal(arg_21_1.registerTime / 1000))

	local var_21_2 = arg_21_1.portrait
	local var_21_3 = lua_item.configDict[var_21_2]

	if not arg_21_0._liveHeadIcon then
		arg_21_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_21_0._simageheadicon)
	end

	arg_21_0._liveHeadIcon:setLiveHead(var_21_2)

	local var_21_4 = string.split(var_21_3.effect, "#")

	if #var_21_4 > 1 then
		if var_21_3.id == tonumber(var_21_4[#var_21_4]) then
			gohelper.setActive(arg_21_0._goframenode, true)

			if not arg_21_0.frame then
				local var_21_5 = "ui/viewres/common/effect/frame.prefab"

				arg_21_0._loader:addPath(var_21_5)
				arg_21_0._loader:startLoad(arg_21_0._onLoadCallback, arg_21_0)
			end
		end
	else
		gohelper.setActive(arg_21_0._goframenode, false)
	end
end

function var_0_0._onLoadCallback(arg_22_0)
	local var_22_0 = arg_22_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_22_0, arg_22_0._goframenode, "frame")

	arg_22_0.frame = gohelper.findChild(arg_22_0._goframenode, "frame")
	arg_22_0.frame:GetComponent(gohelper.Type_Image).enabled = false

	local var_22_1 = 1.41 * (recthelper.getWidth(arg_22_0._simageheadicon.transform) / recthelper.getWidth(arg_22_0.frame.transform))

	transformhelper.setLocalScale(arg_22_0.frame.transform, var_22_1, var_22_1, 1)
end

function var_0_0._initPlayerCardinfo(arg_23_0, arg_23_1)
	local var_23_0 = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local var_23_1 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local var_23_2 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local var_23_3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local var_23_4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	local var_23_5 = math.min(var_23_0 > 0 and arg_23_1.heroRareNNCount / var_23_0 or 1, 1)
	local var_23_6 = math.min(var_23_1 > 0 and arg_23_1.heroRareNCount / var_23_1 or 1, 1)
	local var_23_7 = math.min(var_23_2 > 0 and arg_23_1.heroRareRCount / var_23_2 or 1, 1)
	local var_23_8 = math.min(var_23_3 > 0 and arg_23_1.heroRareSRCount / var_23_3 or 1, 1)
	local var_23_9 = math.min(var_23_4 > 0 and arg_23_1.heroRareSSRCount / var_23_4 or 1, 1)

	arg_23_0._collectionfulls[1].fillAmount = var_23_5
	arg_23_0._collectionfulls[2].fillAmount = var_23_6
	arg_23_0._collectionfulls[3].fillAmount = var_23_7
	arg_23_0._collectionfulls[4].fillAmount = var_23_8
	arg_23_0._collectionfulls[5].fillAmount = var_23_9
	arg_23_0._collectiontxt[1].text = string.format("%s%%", var_23_5 * 100 - var_23_5 * 100 % 0.1)
	arg_23_0._collectiontxt[2].text = string.format("%s%%", var_23_6 * 100 - var_23_6 * 100 % 0.1)
	arg_23_0._collectiontxt[3].text = string.format("%s%%", var_23_7 * 100 - var_23_7 * 100 % 0.1)
	arg_23_0._collectiontxt[4].text = string.format("%s%%", var_23_8 * 100 - var_23_8 * 100 % 0.1)
	arg_23_0._collectiontxt[5].text = string.format("%s%%", var_23_9 * 100 - var_23_9 * 100 % 0.1)
end

function var_0_0._showCollectionText(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._collectiontxt) do
		gohelper.setActive(iter_24_1.gameObject, true)
	end

	gohelper.setActive(arg_24_0._btncloseCollectText.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._hideCollectionText(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._collectiontxt) do
		gohelper.setActive(iter_25_1.gameObject, false)
	end

	gohelper.setActive(arg_25_0._btncloseCollectText.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._initPlayerOtherinfo(arg_26_0, arg_26_1)
	arg_26_0._txtepisodeprogress.text = ""
	arg_26_0._txtepisodeprogressen.text = ""

	local var_26_0 = arg_26_1.lastEpisodeId
	local var_26_1 = var_26_0 and lua_episode.configDict[var_26_0]
	local var_26_2 = GameConfig:GetCurLangType() == LangSettings.en and "%s %s" or "《%s %s》"

	if var_26_1 then
		if DungeonConfig.instance:getChapterCO(var_26_1.chapterId).type == DungeonEnum.ChapterType.Simple then
			var_26_1 = lua_episode.configDict[var_26_1.normalEpisodeId]
		end

		if var_26_1 then
			arg_26_0._txtepisodeprogress.text = string.format(var_26_2, DungeonController.getEpisodeName(var_26_1), var_26_1.name)
			arg_26_0._txtepisodeprogressen.text = var_26_1.name_En
		end
	end

	local var_26_3 = arg_26_1.level

	arg_26_0._txtlevel.text = var_26_3

	local var_26_4 = arg_26_1.exp
	local var_26_5 = 0

	if var_26_3 < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		var_26_5 = PlayerConfig.instance:getPlayerLevelCO(var_26_3 + 1).exp
	else
		var_26_5 = PlayerConfig.instance:getPlayerLevelCO(var_26_3).exp
		var_26_4 = var_26_5
	end

	arg_26_0._txtexp.text = var_26_4 .. "/" .. var_26_5

	arg_26_0._imageexp:SetValue(var_26_4 / var_26_5)
end

function var_0_0._initPlayerShowCard(arg_27_0, arg_27_1)
	for iter_27_0 = 1, 3 do
		local var_27_0 = gohelper.findChild(arg_27_0.viewGO, "showcharacters/showcharacter" .. iter_27_0)

		arg_27_0:_showcharacterinfo(arg_27_1[iter_27_0], var_27_0)
	end
end

local var_0_1 = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function var_0_0._showcharacterinfo(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = gohelper.findChild(arg_28_2, "#btn_Add")
	local var_28_1 = gohelper.findChild(arg_28_2, "#btn_Character")

	if arg_28_1 and arg_28_1 ~= 0 and arg_28_1.heroId and arg_28_1.heroId ~= "0" and arg_28_1.heroId ~= 0 then
		if arg_28_0._playerSelf then
			arg_28_1 = HeroModel.instance:getByHeroId(arg_28_1.heroId)
		end

		gohelper.setActive(var_28_0.gameObject, false)
		gohelper.setActive(var_28_1.gameObject, true)

		local var_28_2 = gohelper.findChildImage(arg_28_2, "#btn_Character/charactercarditem/#simage_cardrare")
		local var_28_3 = gohelper.findChild(arg_28_2, "#btn_Character/charactercarditem/#simage_cardrare/r")
		local var_28_4 = gohelper.findChild(arg_28_2, "#btn_Character/charactercarditem/#simage_cardrare/sr")
		local var_28_5 = gohelper.findChild(arg_28_2, "#btn_Character/charactercarditem/#simage_cardrare/ssr")
		local var_28_6 = gohelper.findChildText(arg_28_2, "#btn_Character/charactercarditem/#txt_level")
		local var_28_7 = gohelper.findChild(arg_28_2, "#btn_Character/charactercarditem/iconmask/#simage_icon")
		local var_28_8 = CommonHeroCard.create(var_28_7, arg_28_0.viewName)
		local var_28_9 = gohelper.findChildImage(arg_28_2, "#btn_Character/charactercarditem/lvProgress/#image_breakprogress")
		local var_28_10 = {}

		table.insert(var_28_10, var_28_3)
		table.insert(var_28_10, var_28_4)
		table.insert(var_28_10, var_28_5)

		local var_28_11 = HeroConfig.instance:getHeroCO(arg_28_1.heroId)
		local var_28_12 = SkinConfig.instance:getSkinCo(arg_28_1.skin)

		UISpriteSetMgr.instance:setPlayerRareBgSprite(var_28_2, "rare_" .. CharacterEnum.Color[var_28_11.rare])
		var_28_8:onUpdateMO(var_28_12)

		var_28_6.text = HeroConfig.instance:getShowLevel(arg_28_1.level)
		var_28_9.fillAmount = arg_28_1.exSkillLevel and var_0_1[arg_28_1.exSkillLevel] or 0

		for iter_28_0 = 1, 3 do
			gohelper.setActive(var_28_10[iter_28_0], iter_28_0 == var_28_11.rare - 2)
		end

		arg_28_0:_showCharacterRankInfo(arg_28_1, arg_28_2)
	else
		gohelper.setActive(var_28_0.gameObject, true)
		gohelper.setActive(var_28_1.gameObject, false)
	end

	if not arg_28_0._playerSelf then
		gohelper.setActive(var_28_0, false)
	end
end

function var_0_0._showCharacterRankInfo(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = HeroConfig.instance:getHeroCO(arg_29_1.heroId)
	local var_29_1 = gohelper.findChild(arg_29_2, "#btn_Character/charactercarditem/rankobj")
	local var_29_2 = {}

	for iter_29_0 = 1, 3 do
		local var_29_3 = gohelper.findChild(var_29_1, "rank" .. iter_29_0)

		table.insert(var_29_2, var_29_3)
	end

	for iter_29_1 = 1, 3 do
		local var_29_4 = var_29_2[iter_29_1]

		gohelper.setActive(var_29_4, iter_29_1 == arg_29_1.rank - 1)
	end
end

function var_0_0._refreshRenameStatus(arg_30_0)
	gohelper.setActive(arg_30_0._btnmodifyname.gameObject, arg_30_0._playerSelf and arg_30_0._isGamePad == false)
end

function var_0_0._refreshIsHasAssistReward(arg_31_0)
	if arg_31_0._playerSelf then
		local var_31_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)
		local var_31_1 = PlayerModel.instance:isHasAssistReward()

		gohelper.setActive(arg_31_0._goAssistReward, var_31_0 and var_31_1)
	else
		gohelper.setActive(arg_31_0._goAssistReward, false)
	end
end

function var_0_0._onCloseFullView(arg_32_0, arg_32_1)
	if arg_32_0._viewAnim then
		ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
		arg_32_0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onClose(arg_33_0)
	PostProcessingMgr.instance:setBlurWeight(1)
	TaskDispatcher.cancelTask(arg_33_0._delayOpenView, arg_33_0)
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	TaskDispatcher.cancelTask(arg_33_0.updateAssistReward, arg_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simageheadicon:UnLoadImage()

	if arg_34_0._loader then
		arg_34_0._loader:dispose()

		arg_34_0._loader = nil
	end

	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return var_0_0
