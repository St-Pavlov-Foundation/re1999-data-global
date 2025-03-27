module("modules.logic.player.view.PlayerView", package.seeall)

slot0 = class("PlayerView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bgroot")
	slot0._txtentryday = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/#txt_entryday")
	slot0._txtepisodeprogress = gohelper.findChildText(slot0.viewGO, "leftside/txtContainer/progress/#txt_episodeprogress")
	slot0._txtepisodeprogressen = gohelper.findChildText(slot0.viewGO, "leftside/txtContainer/progress/#txt_episodeprogressen")
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	slot0._btnheadicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "leftside/playerinfo/headframe/#simage_headicon/#go_framenode")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/lv/#txt_level")
	slot0._txtexp = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/#txt_exp")
	slot0._imageexp = gohelper.findChildSlider(slot0.viewGO, "leftside/playerinfo/#slider_exp")
	slot0._txtplayerid = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/#txt_playerid")
	slot0._btnplayerid = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftside/playerinfo/#txt_playerid/#btn_playerid")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/#txt_name")
	slot0._gosignature = gohelper.findChild(slot0.viewGO, "leftside/playerinfo/signature")
	slot0._txtsignature = gohelper.findChildText(slot0.viewGO, "leftside/playerinfo/signature/scroll/viewport/#txt_signature")
	slot0._btnsignature = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftside/playerinfo/signature/#btn_signature")
	slot0._btnshowcharacterA1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter1/#btn_Add")
	slot0._btnshowcharacterA2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter2/#btn_Add")
	slot0._btnshowcharacterA3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter3/#btn_Add")
	slot0._btnshowcharacterB1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter1/#btn_Character")
	slot0._btnshowcharacterB2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter2/#btn_Character")
	slot0._btnshowcharacterB3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "showcharacters/showcharacter3/#btn_Character")
	slot0._btnmodifyname = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftside/playerinfo/#txt_name/#btn_modifyname")
	slot0._btncollection = gohelper.findChildButton(slot0.viewGO, "collection")
	slot0._btncloseCollectText = gohelper.findChildButton(slot0.viewGO, "collection/#btn_closeCollectText")
	slot0._btnchangebg = gohelper.findChildButton(slot0.viewGO, "btn_changebg/#btn_changebg")
	slot0._gochangebgreddot = gohelper.findChild(slot0.viewGO, "btn_changebg/#go_reddot")
	slot0._gocollectbg = gohelper.findChild(slot0.viewGO, "collection/newbg")
	slot0._goAssistReward = gohelper.findChild(slot0.viewGO, "#go_gather")
	slot0._btnGetAssistReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_gather/#btn_click")

	gohelper.setActive(slot0._goAssistReward, false)

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._loader = MultiAbLoader.New()
	slot0._btnplayercard = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_personalcard/#btn_changebg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnplayercard:AddClickListener(slot0._btnplayercardOnClick, slot0)
	slot0._btnplayerid:AddClickListener(slot0._btnplayeridOnClick, slot0)
	slot0._btnsignature:AddClickListener(slot0._btnsignatureOnClick, slot0)
	slot0._btnshowcharacterA1:AddClickListener(slot0._showHeroClick, slot0, 1)
	slot0._btnshowcharacterA2:AddClickListener(slot0._showHeroClick, slot0, 2)
	slot0._btnshowcharacterA3:AddClickListener(slot0._showHeroClick, slot0, 3)
	slot0._btnshowcharacterB1:AddClickListener(slot0._showHeroClick, slot0, 1)
	slot0._btnshowcharacterB2:AddClickListener(slot0._showHeroClick, slot0, 2)
	slot0._btnshowcharacterB3:AddClickListener(slot0._showHeroClick, slot0, 3)
	slot0._btnheadicon:AddClickListener(slot0._changeIcon, slot0)
	slot0._btncollection:AddClickListener(slot0._showCollectionText, slot0)
	slot0._btncloseCollectText:AddClickListener(slot0._hideCollectionText, slot0)
	slot0._btnmodifyname:AddClickListener(slot0._btnmodifynameOnClick, slot0)
	slot0._btnchangebg:AddClickListener(slot0._btnchangebgOnClick, slot0)
	slot0._btnGetAssistReward:AddClickListener(slot0._btnGetAssistRewardOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, slot0.updateBg, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.resetBg, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplayercard:RemoveClickListener()
	slot0._btnplayerid:RemoveClickListener()
	slot0._btnsignature:RemoveClickListener()
	slot0._btnshowcharacterA1:RemoveClickListener()
	slot0._btnshowcharacterA2:RemoveClickListener()
	slot0._btnshowcharacterA3:RemoveClickListener()
	slot0._btnshowcharacterB1:RemoveClickListener()
	slot0._btnshowcharacterB2:RemoveClickListener()
	slot0._btnshowcharacterB3:RemoveClickListener()
	slot0._btnheadicon:RemoveClickListener()
	slot0._btncollection:RemoveClickListener()
	slot0._btncloseCollectText:RemoveClickListener()
	slot0._btnmodifyname:RemoveClickListener()
	slot0._btnchangebg:RemoveClickListener()
	slot0._btnGetAssistReward:RemoveClickListener()

	if slot0._playerSelf then
		slot0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0._refreshIsHasAssistReward, slot0)
	end

	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0.updateBg, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.resetBg, slot0)
end

function slot0._btnplayercardOnClick(slot0)
	if not slot0._info then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		PlayerCardController.instance:openPlayerCardView({
			userId = slot0._info.userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function slot0._btnplayeridOnClick(slot0)
	slot0._txtplayerid.text = slot0._info.userId

	ZProj.UGUIHelper.CopyText(slot0._txtplayerid.text)

	slot0._txtplayerid.text = string.format("ID:%s", slot0._info.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function slot0._btnsignatureOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Signature)
end

function slot0._btnmodifynameOnClick(slot0)
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function slot0._btnchangebgOnClick(slot0)
	PostProcessingMgr.instance:setBlurWeight(0)
	slot0:_closeAndDelayOpenView(ViewName.PlayerChangeBgView, {
		bgComp = slot0._bgComp
	})
end

function slot0._closeAndDelayOpenView(slot0, slot1, slot2)
	if not slot0._playerSelf then
		return
	end

	ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	slot0._viewAnim:Play(UIAnimationName.Close, 0, 0)

	slot0._openViewData = {
		slot1,
		slot2
	}

	UIBlockMgr.instance:startBlock("PlayerViewDelayOpenView")
	TaskDispatcher.runDelay(slot0._delayOpenView, slot0, 0.12)
end

function slot0._delayOpenView(slot0)
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	ViewMgr.instance:openView(unpack(slot0._openViewData))
end

function slot0.resetBg(slot0, slot1)
	if slot1 == ViewName.PlayerChangeBgView then
		slot0._bgComp.go.transform:SetParent(slot0.viewGO.transform, false)
		slot0._bgComp.go.transform:SetSiblingIndex(0)
		slot0:updateBg()
	end
end

function slot0._changeIcon(slot0)
	if slot0._playerSelf then
		ViewMgr.instance:openView(ViewName.IconTipView)
	end
end

function slot0._showHeroClick(slot0, slot1)
	slot0:_closeAndDelayOpenView(ViewName.ShowCharacterView, {
		notRepeatUpdateAssistReward = true
	})
end

function slot0._btnGetAssistRewardOnClick(slot0)
	if not slot0._playerSelf then
		return
	end

	PlayerController.instance:getAssistReward()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnsignature.gameObject, AudioEnum.UI.play_ui_hero_sign)
	gohelper.addUIClickAudio(slot0._btnshowcharacterA1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(slot0._btnshowcharacterA2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(slot0._btnshowcharacterA3.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(slot0._btnshowcharacterB1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(slot0._btnshowcharacterB2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(slot0._btnshowcharacterB3.gameObject, AudioEnum.UI.play_ui_hero_card_click)

	slot0._collectionfulls = slot0:getUserDataTb_()
	slot0._collectiontxt = slot0:getUserDataTb_()

	for slot4 = 1, 5 do
		slot0._collectionfulls[slot4] = gohelper.findChildImage(slot0.viewGO, "collection/collection" .. slot4 .. "/#image_full")
		slot0._collectiontxt[slot4] = gohelper.findChildText(slot0.viewGO, "collection/collection" .. slot4 .. "/#txt_progress")
	end

	slot0._bgComp = MonoHelper.addLuaComOnceToGo(slot0._gobg, PlayerBgComp)

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.onOpen(slot0)
	slot0._info = slot0.viewParam.playerInfo
	slot0._playerSelf = slot0.viewParam.playerSelf

	slot0:_initPlayerCardinfo(slot0._info)
	slot0:_initPlayerbassinfo(slot0._info)
	slot0:_initPlayerOtherinfo(slot0._info)
	slot0:_initPlayerShowCard(slot0._info.showHeros)
	slot0:_hideCollectionText()

	if slot0._playerSelf then
		slot0:addEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, slot0._initPlayerbassinfo, slot0)
		slot0:addEventCb(PlayerController.instance, PlayerEvent.SetShowHero, slot0._initPlayerShowCard, slot0)
		slot0:addEventCb(PlayerController.instance, PlayerEvent.RenameFlagUpdate, slot0._refreshRenameStatus, slot0)
		slot0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0._refreshIsHasAssistReward, slot0)

		slot0._btnheadicon.button.enabled = true

		slot0:updateAssistReward()
		TaskDispatcher.cancelTask(slot0.updateAssistReward, slot0)
		TaskDispatcher.runRepeat(slot0.updateAssistReward, slot0, CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency))
	else
		slot0:removeEventCb(PlayerController.instance, PlayerEvent.PlayerbassinfoChange, slot0._initPlayerbassinfo, slot0)
		slot0:removeEventCb(PlayerController.instance, PlayerEvent.SetShowHero, slot0._initPlayerShowCard, slot0)
		slot0:removeEventCb(PlayerController.instance, PlayerEvent.RenameFlagUpdate, slot0._refreshRenameStatus, slot0)

		slot0._btnheadicon.button.enabled = false

		gohelper.setActive(slot0._goAssistReward, false)
	end

	RedDotController.instance:addRedDot(slot0._gochangebgreddot, RedDotEnum.DotNode.PlayerChangeBgNew)
	gohelper.setActive(slot0._gochangebgreddot, slot0._playerSelf)
	gohelper.setActive(slot0._btnsignature.gameObject, slot0._playerSelf)

	slot0._isGamePad = SDKNativeUtil.isGamePad()

	gohelper.setActive(slot0._gosignature.gameObject, slot0._isGamePad == false)
	slot0:_refreshRenameStatus()
	slot0:updateBg()
end

function slot0.updateAssistReward(slot0)
	if not slot0._playerSelf then
		return
	end

	PlayerController.instance:updateAssistRewardCount()
end

function slot0.updateBg(slot0)
	if ViewMgr.instance:isOpen(ViewName.PlayerChangeBgView) then
		return
	end

	slot1 = PlayerModel.instance:getPlayinfo()

	if not slot0.viewParam.playerSelf and slot0.viewParam.playerInfo then
		slot1 = slot0.viewParam.playerInfo

		slot0._bgComp:setPlayerInfo(slot0.viewParam.playerInfo, slot0.viewParam.heroCover)
	end

	slot2 = PlayerConfig.instance:getBgCo(slot1.bg)

	slot0._bgComp:showBg(slot2)
	gohelper.setActive(slot0._gocollectbg, slot2.item ~= 0)
end

function slot0._initPlayerbassinfo(slot0, slot1)
	slot0._txtname.text = slot1.name
	slot0._txtplayerid.text = string.format("ID:%s", slot1.userId)

	if string.nilorempty(slot1.signature) and string.split(CommonConfig.instance:getConstStr(ConstEnum.RoleRandomSignature), "#") and #slot3 > 0 then
		slot2 = slot3[math.random(1, #slot3)]
	end

	slot0._txtsignature.text = slot2

	gohelper.setActive(slot0._txtsignature.gameObject, true)

	slot0._txtentryday.text = TimeUtil.langTimestampToString3(ServerTime.timeInLocal(slot1.registerTime / 1000))
	slot4 = lua_item.configDict[slot1.portrait]

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadicon)
	end

	slot0._liveHeadIcon:setLiveHead(slot3)

	if #string.split(slot4.effect, "#") > 1 then
		if slot4.id == tonumber(slot5[#slot5]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame then
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simageheadicon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0._initPlayerCardinfo(slot0, slot1)
	slot3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	slot4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	slot5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	slot6 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	slot7 = math.min(HeroConfig.instance:getAnyOnlineRareCharacterCount(1) > 0 and slot1.heroRareNNCount / slot2 or 1, 1)
	slot8 = math.min(slot3 > 0 and slot1.heroRareNCount / slot3 or 1, 1)
	slot9 = math.min(slot4 > 0 and slot1.heroRareRCount / slot4 or 1, 1)
	slot10 = math.min(slot5 > 0 and slot1.heroRareSRCount / slot5 or 1, 1)
	slot11 = math.min(slot6 > 0 and slot1.heroRareSSRCount / slot6 or 1, 1)
	slot0._collectionfulls[1].fillAmount = slot7
	slot0._collectionfulls[2].fillAmount = slot8
	slot0._collectionfulls[3].fillAmount = slot9
	slot0._collectionfulls[4].fillAmount = slot10
	slot0._collectionfulls[5].fillAmount = slot11
	slot0._collectiontxt[1].text = string.format("%s%%", slot7 * 100 - slot7 * 100 % 0.1)
	slot0._collectiontxt[2].text = string.format("%s%%", slot8 * 100 - slot8 * 100 % 0.1)
	slot0._collectiontxt[3].text = string.format("%s%%", slot9 * 100 - slot9 * 100 % 0.1)
	slot0._collectiontxt[4].text = string.format("%s%%", slot10 * 100 - slot10 * 100 % 0.1)
	slot0._collectiontxt[5].text = string.format("%s%%", slot11 * 100 - slot11 * 100 % 0.1)
end

function slot0._showCollectionText(slot0)
	for slot4, slot5 in ipairs(slot0._collectiontxt) do
		gohelper.setActive(slot5.gameObject, true)
	end

	gohelper.setActive(slot0._btncloseCollectText.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function slot0._hideCollectionText(slot0)
	for slot4, slot5 in ipairs(slot0._collectiontxt) do
		gohelper.setActive(slot5.gameObject, false)
	end

	gohelper.setActive(slot0._btncloseCollectText.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function slot0._initPlayerOtherinfo(slot0, slot1)
	slot0._txtepisodeprogress.text = ""
	slot0._txtepisodeprogressen.text = ""
	slot4 = GameConfig:GetCurLangType() == LangSettings.en and "%s %s" or "《%s %s》"

	if slot1.lastEpisodeId and lua_episode.configDict[slot2] then
		if DungeonConfig.instance:getChapterCO(slot3.chapterId).type == DungeonEnum.ChapterType.Simple then
			slot3 = lua_episode.configDict[slot3.normalEpisodeId]
		end

		if slot3 then
			slot0._txtepisodeprogress.text = string.format(slot4, DungeonController.getEpisodeName(slot3), slot3.name)
			slot0._txtepisodeprogressen.text = slot3.name_En
		end
	end

	slot5 = slot1.level
	slot0._txtlevel.text = slot5
	slot6 = slot1.exp
	slot7 = 0

	if slot5 < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		slot7 = PlayerConfig.instance:getPlayerLevelCO(slot5 + 1).exp
	else
		slot6 = PlayerConfig.instance:getPlayerLevelCO(slot5).exp
	end

	slot0._txtexp.text = slot6 .. "/" .. slot7

	slot0._imageexp:SetValue(slot6 / slot7)
end

function slot0._initPlayerShowCard(slot0, slot1)
	for slot5 = 1, 3 do
		slot0:_showcharacterinfo(slot1[slot5], gohelper.findChild(slot0.viewGO, "showcharacters/showcharacter" .. slot5))
	end
end

slot1 = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function slot0._showcharacterinfo(slot0, slot1, slot2)
	slot3 = gohelper.findChild(slot2, "#btn_Add")
	slot4 = gohelper.findChild(slot2, "#btn_Character")

	if slot1 and slot1 ~= 0 and slot1.heroId and slot1.heroId ~= "0" and slot1.heroId ~= 0 then
		if slot0._playerSelf then
			slot1 = HeroModel.instance:getByHeroId(slot1.heroId)
		end

		gohelper.setActive(slot3.gameObject, false)
		gohelper.setActive(slot4.gameObject, true)

		slot13 = {}

		table.insert(slot13, gohelper.findChild(slot2, "#btn_Character/charactercarditem/#simage_cardrare/r"))
		table.insert(slot13, gohelper.findChild(slot2, "#btn_Character/charactercarditem/#simage_cardrare/sr"))
		table.insert(slot13, gohelper.findChild(slot2, "#btn_Character/charactercarditem/#simage_cardrare/ssr"))
		UISpriteSetMgr.instance:setPlayerRareBgSprite(gohelper.findChildImage(slot2, "#btn_Character/charactercarditem/#simage_cardrare"), "rare_" .. CharacterEnum.Color[HeroConfig.instance:getHeroCO(slot1.heroId).rare])
		CommonHeroCard.create(gohelper.findChild(slot2, "#btn_Character/charactercarditem/iconmask/#simage_icon"), slot0.viewName):onUpdateMO(SkinConfig.instance:getSkinCo(slot1.skin))

		gohelper.findChildText(slot2, "#btn_Character/charactercarditem/#txt_level").text = HeroConfig.instance:getShowLevel(slot1.level)
		gohelper.findChildImage(slot2, "#btn_Character/charactercarditem/lvProgress/#image_breakprogress").fillAmount = slot1.exSkillLevel and uv0[slot1.exSkillLevel] or 0

		for slot19 = 1, 3 do
			gohelper.setActive(slot13[slot19], slot19 == slot14.rare - 2)
		end

		slot0:_showCharacterRankInfo(slot1, slot2)
	else
		gohelper.setActive(slot3.gameObject, true)
		gohelper.setActive(slot4.gameObject, false)
	end

	if not slot0._playerSelf then
		gohelper.setActive(slot3, false)
	end
end

function slot0._showCharacterRankInfo(slot0, slot1, slot2)
	slot3 = HeroConfig.instance:getHeroCO(slot1.heroId)

	for slot9 = 1, 3 do
		table.insert({}, gohelper.findChild(gohelper.findChild(slot2, "#btn_Character/charactercarditem/rankobj"), "rank" .. slot9))
	end

	for slot9 = 1, 3 do
		gohelper.setActive(slot5[slot9], slot9 == slot1.rank - 1)
	end
end

function slot0._refreshRenameStatus(slot0)
	gohelper.setActive(slot0._btnmodifyname.gameObject, slot0._playerSelf and slot0._isGamePad == false)
end

function slot0._refreshIsHasAssistReward(slot0)
	if slot0._playerSelf then
		gohelper.setActive(slot0._goAssistReward, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) and PlayerModel.instance:isHasAssistReward())
	else
		gohelper.setActive(slot0._goAssistReward, false)
	end
end

function slot0._onCloseFullView(slot0, slot1)
	if slot0._viewAnim then
		ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
		slot0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.onClose(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)
	TaskDispatcher.cancelTask(slot0._delayOpenView, slot0)
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	TaskDispatcher.cancelTask(slot0.updateAssistReward, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageheadicon:UnLoadImage()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return slot0
