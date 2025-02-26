module("modules.logic.gm.view.GMToolView", package.seeall)

slot0 = class("GMToolView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._btnOK1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item1/btnOK")
	slot0._btnCommand = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item1/btnCommand")
	slot0._inp1 = gohelper.findChildInputField(slot0.viewGO, "viewport/content/item1/inpText")
	slot0._inp21 = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item2/inpItem")
	slot0._inp22 = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item2/inpNum")
	slot0._btnOK2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item2/btnOK")
	slot0._txtServerTime = gohelper.findChildText(slot0.viewGO, "viewport/content/item3/txtServerTime")
	slot0._txtLocalTime = gohelper.findChildText(slot0.viewGO, "viewport/content/item3/txtLocalTime")
	slot0._scroll = gohelper.findChildScrollRect(slot0.viewGO, "viewport")
	slot0._btnOK4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item4/btnOK")
	slot0._toggleEar = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item4/earToggle")
	slot0._btnQualityLow = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnQualityLow")
	slot0._btnQualityMid = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnQualityMid")
	slot0._btnQualityHigh = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnQualityHigh")
	slot0._btnQualityNo = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnQualityNo")
	slot0._btnPP = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnPP")
	slot0._btnSetting = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item5/btnSetting")
	slot0._txtBtnPP = gohelper.findChildText(slot0.viewGO, "viewport/content/item5/btnPP/Text")
	slot0._txtAccountId = gohelper.findChildText(slot0.viewGO, "viewport/content/item40/Text")
	slot0._imgQualitys = {
		slot0._btnQualityNo.gameObject:GetComponent(gohelper.Type_Image),
		slot0._btnQualityHigh.gameObject:GetComponent(gohelper.Type_Image),
		slot0._btnQualityMid.gameObject:GetComponent(gohelper.Type_Image),
		slot0._btnQualityLow.gameObject:GetComponent(gohelper.Type_Image)
	}
	slot0._txtSpeed = gohelper.findChildText(slot0.viewGO, "viewport/content/item6/Text")
	slot0._sliderSpeed = gohelper.findChildSlider(slot0.viewGO, "viewport/content/item6/Slider")
	slot0._btnClearPlayerPrefs = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item7/btnClearPlayerPrefs")
	slot0._btnBlockLog = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item7/btnBlockLog")
	slot0._btnProtoTestView = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item8/Button")
	slot0._btnfastaddhero = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item8/#btn_addhero")
	slot0._inpTestFight = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item9/inpText")
	slot0._btnTestFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item9/btnTestFight")
	slot0._btnTestFightId = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item9/btnTestFightId")
	slot0._btnPostProcess = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item10/Button")
	slot0._btnEffectStat = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item10/btnEffectStat")
	slot0._btnIgnoreSomeMsgLog = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item11/Button")
	slot0._btnFightJoin = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item11/btnFightJoin")
	slot0._inpSpeed1 = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item11/inpSpeed1")
	slot0._inpSpeed2 = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item11/inpSpeed2")
	slot0._btnCurSpeed = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item11/btnCurSpeed")
	slot0._btnHideDebug = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item12/Button")
	slot0._btnShowError = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item12/btnError")
	slot0._inpJump = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item13/inpText")
	slot0._btnJumpOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item13/btnOK")
	slot0._inpGuide = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item14/inpText")
	slot0._btnGuideStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item14/btnStart")
	slot0._btnGuideFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item14/btnFinish")
	slot0._btnGuideForbid = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item14/btnForbid")
	slot0._btnGuideReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item14/btnReset")
	slot0._inpStory = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item15/inpstorytxt")
	slot0._btnStorySkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item15/btnstoryskip")
	slot0._btnStoryOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item15/btnstoryok")
	slot0._inpEpisode = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item18/inpText")
	slot0._btnEpisodeOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item18/btnOK")
	slot0._btnSkinOffsetAdjust = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item20/Button")
	slot0._btnFightFocusAdjust = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item20/Button1")
	slot0._toggleSkipPatFace = gohelper.findChildToggle(slot0.viewGO, "viewport/content/skipPatFace/toggleSkipPatFace")
	slot0._btnGuideEditor = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/guideEditor/Button")
	slot0._btnHelpViewBrowse = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/guideEditor/btnHelpViewBrowse")
	slot0._btnGuideStatus = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item14/btnGuideStatus")
	slot0._inpScreenWidth = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item24/inpTextWidth")
	slot0._inpScreenHeight = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item24/inpTextHeight")
	slot0._btnConfirm = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/item24/btnConfirm"))
	slot0._dropSkinGetView = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/item25/Dropdown")
	slot0._btnOpenSeasonView = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item27/ButtonSeason")
	slot0._btnOpenHuaRongView = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/item27_2/huarong"))
	slot0._inpChangeColor = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item27_2/changecolor/inpchangecolortxt")
	slot0._btnChangeColorOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item27_2/changecolor/btnchangecolorok")
	slot0._btnFightSimulate = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item333/btnOK")
	slot0._btnResetCards = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item333/btnOK2")
	slot0._btnFightEntity = gohelper.getClick(gohelper.cloneInPlace(slot0._btnFightSimulate.gameObject))
	gohelper.findChildText(slot0._btnFightEntity.gameObject, "Text").text = "战中外挂"

	recthelper.setWidth(slot0._btnFightEntity.transform, 200)
	recthelper.setWidth(slot0._btnFightSimulate.transform, 200)
	recthelper.setWidth(slot0._btnResetCards.transform, 200)
	recthelper.setAnchorX(slot0._btnFightEntity.transform, 0)
	recthelper.setAnchorX(slot0._btnFightSimulate.transform, -220)
	recthelper.setAnchorX(slot0._btnResetCards.transform, 220)

	slot0._dropHeroFaith = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/item34/Dropdown")
	slot0._btnHeroFaith = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item34/btnOK")
	slot0._dropHeroLevel = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/item36/Dropdown")
	slot0._btnHeroLevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item36/btnOK")
	slot0._inpHeroLevel = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item36/inpNum")
	slot0._dropWeather = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/item38/Dropdown")
	slot0._btnGetAllHero = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item35/Button1")
	slot0._btnDeleteAllHeroInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item35/Button2")
	slot0._btnHideGM = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item37/Button1")
	slot0._txtGM = gohelper.findChildText(slot0.viewGO, "viewport/content/item37/Button1/Text")
	slot0._btnUnLockAllEpisode = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item37/Button2")
	slot0._btnExplore = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item39/Button1")
	slot0._inpExplore = gohelper.findChildInputField(slot0.viewGO, "viewport/content/item39/inpText")
	slot0._btnshowHero = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item40/Button1")
	slot0._btnshowUI = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item40/Button2")
	slot0._btnshowId = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item42/btn_userid")
	slot0._btnwatermark = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item42/btn_watermark")
	slot0._txtshowHero = gohelper.findChildText(slot0.viewGO, "viewport/content/item40/Button1/Text")
	slot0._txtshowUI = gohelper.findChildText(slot0.viewGO, "viewport/content/item40/Button2/Text")
	slot0._txtshowId = gohelper.findChildText(slot0.viewGO, "viewport/content/item42/btn_userid/Text")
	slot0._txtwatermark = gohelper.findChildText(slot0.viewGO, "viewport/content/item42/btn_watermark/Text")
	slot0._btncopytalentdata = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item41/btn_copy_talent_data")
	slot0._btnprintallentitybuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item41/btn_print_all_entity_buff")
	slot0._btnReplaceSummonHero = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item46/Button1")
	slot0._inpHeroList = gohelper.findChildInputField(slot0.viewGO, "viewport/content/item46/inpText")

	slot0._inpHeroList:SetText("3039;3052;3017;3010;3015;3013;3031;3006;3040;3012")

	slot0._dropRoomInteraction = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/roomInteraction/Dropdown")
	slot0._btnRoomInteraction = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/roomInteraction/btnOK")
	slot0._btnCrash1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/crash/btnCrash1")
	slot0._btnCrash2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/crash/btnCrash2")
	slot0._btnCrash3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/crash/btnCrash3")
	slot0._btnEnterView = gohelper.findChildButton(slot0.viewGO, "viewport/content/item50/Button")
	slot0._inpViewName = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item50/InputField (TMP)")
	slot0._dropRoomWeather, slot0._btnRoomWeather = slot0:_cloneDropdown("小屋天气", false, "roomWeather")
end

function slot0._cloneDropdown(slot0, slot1, slot2, slot3)
	slot4 = gohelper.cloneInPlace(gohelper.findChild(slot0.viewGO, "viewport/content/roomInteraction"), slot3)
	slot6 = gohelper.findChildButtonWithAudio(slot4, "btnOK")
	gohelper.findChildText(slot4, "text").text = slot1

	gohelper.setActive(slot6, slot2)

	return gohelper.findChildDropdown(slot4, "Dropdown"), slot6
end

function slot0.addEvents(slot0)
	slot0._scroll:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnOK1:AddClickListener(slot0._onClickBtnOK1, slot0)
	slot0._btnCommand:AddClickListener(slot0._onClickBtnCommand, slot0)
	slot0._btnOK2:AddClickListener(slot0._onClickBtnOK2, slot0)
	slot0._btnOK4:AddClickListener(slot0._onClickBtnOK4, slot0)
	slot0._toggleEar:AddOnValueChanged(slot0._onEarToggleValueChange, slot0)
	slot0._btnQualityLow:AddClickListener(slot0._onClickBtnQualityLow, slot0)
	slot0._btnQualityMid:AddClickListener(slot0._onClickBtnQualityMid, slot0)
	slot0._btnQualityHigh:AddClickListener(slot0._onClickBtnQualityHigh, slot0)
	slot0._btnQualityNo:AddClickListener(slot0._onClickBtnQualityNo, slot0)
	slot0._btnPP:AddClickListener(slot0._onClickBtnPP, slot0)
	slot0._btnSetting:AddClickListener(slot0._onClickBtnSetting, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._txtSpeed.gameObject):AddClickListener(slot0._onClickSpeedText, slot0)
	slot0._sliderSpeed:AddOnValueChanged(slot0._onSpeedChange, slot0)
	slot0._btnClearPlayerPrefs:AddClickListener(slot0._onClickBtnClearPlayerPrefs, slot0)
	slot0._btnBlockLog:AddClickListener(slot0._onClickBtnBlockLog, slot0)
	slot0._btnProtoTestView:AddClickListener(slot0._onClickBtnProtoTestView, slot0)
	slot0._btnfastaddhero:AddClickListener(slot0._onClickBtnFastAddHero, slot0)
	slot0._btnTestFight:AddClickListener(slot0._onClickTestFight, slot0)
	slot0._btnTestFightId:AddClickListener(slot0._onClickTestFightId, slot0)
	slot0._btnPostProcess:AddClickListener(slot0._onClickPostProcess, slot0)
	slot0._btnEffectStat:AddClickListener(slot0._onClickEffectStat, slot0)
	slot0._btnIgnoreSomeMsgLog:AddClickListener(slot0._onClickIgnoreSomeMsgLog, slot0)
	slot0._btnFightJoin:AddClickListener(slot0._onClickFightJoin, slot0)
	slot0._btnHideDebug:AddClickListener(slot0._onClickHideBug, slot0)
	slot0._btnShowError:AddClickListener(slot0._onClickShowError, slot0)
	slot0._btnSkinOffsetAdjust:AddClickListener(slot0._onClickSkinOffsetAdjust, slot0)
	slot0._btnFightFocusAdjust:AddClickListener(slot0._onClickFightFocusAdjust, slot0)

	if slot0._toggleSkipPatFace then
		slot0._toggleSkipPatFace:AddOnValueChanged(slot0._onSkipPatFaceToggleValueChange, slot0, "123")
	end

	slot0._btnGuideEditor:AddClickListener(slot0._onClickGuideEditor, slot0)
	slot0._btnHelpViewBrowse:AddClickListener(slot0._onClickHelpViewBrowse, slot0)
	slot0._btnGuideStatus:AddClickListener(slot0._onClickGuideStatus, slot0)
	slot0._btnJumpOK:AddClickListener(slot0._onClickJumpOK, slot0)
	slot0._btnEpisodeOK:AddClickListener(slot0._onClickEpisodeOK, slot0)
	slot0._btnGuideStart:AddClickListener(slot0._onClickGuideStart, slot0)
	slot0._btnGuideFinish:AddClickListener(slot0._onClickGuideFinish, slot0)
	slot0._btnGuideForbid:AddClickListener(slot0._onClickGuideForbid, slot0)
	slot0._btnGuideReset:AddClickListener(slot0._onClickGuideReset, slot0)
	slot0._btnStorySkip:AddClickListener(slot0._onClickStorySkip, slot0)
	slot0._btnStoryOK:AddClickListener(slot0._onClickStoryOK, slot0)
	slot0._btnChangeColorOK:AddClickListener(slot0._onClickChangeColorOK, slot0)
	slot0._btnFightSimulate:AddClickListener(slot0._onClickFightSimulate, slot0)
	slot0._btnFightEntity:AddClickListener(slot0._onClickFightEntity, slot0)
	slot0._btnResetCards:AddClickListener(slot0._onClickResetCards, slot0)
	slot0._btnHeroFaith:AddClickListener(slot0._onClickHeroFaithOk, slot0)
	slot0._btnHeroLevel:AddClickListener(slot0._onClickHeroLevelOk, slot0)
	slot0._dropSkinGetView:AddOnValueChanged(slot0._onSkinGetValueChanged, slot0)
	slot0._dropHeroFaith:AddOnValueChanged(slot0._onHeroFaithSelectChanged, slot0)
	slot0._dropHeroLevel:AddOnValueChanged(slot0._onHeroLevelSelectChanged, slot0)
	slot0._btnGetAllHero:AddClickListener(slot0._onClickGetAllHeroBtn, slot0)
	slot0._btnDeleteAllHeroInfo:AddClickListener(slot0._onClickDeleteAllHeroInfoBtn, slot0)
	slot0._btnHideGM:AddClickListener(slot0._onClickHideGMBtn, slot0)
	slot0._btnUnLockAllEpisode:AddClickListener(slot0._onClickUnLockAllEpisode, slot0)
	slot0._btnOpenHuaRongView:AddClickListener(slot0._onClickOpenHuaRongViewBtn, slot0)
	slot0._btnOpenSeasonView:AddClickListener(slot0._onClickOpenSeasonViewBtn, slot0)

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		slot0._btnConfirm:AddClickListener(slot0._onClickScreenSize, slot0)
	end

	slot0._btnExplore:AddClickListener(slot0._onClickExplore, slot0)
	slot0._inpSpeed1:AddOnEndEdit(slot0._onEndEdit1, slot0)
	slot0._inpSpeed2:AddOnEndEdit(slot0._onEndEdit2, slot0)
	slot0._btnshowHero:AddClickListener(slot0._onClickShowHero, slot0)
	slot0._btnshowUI:AddClickListener(slot0._onClickShowUI, slot0)
	slot0._btnshowId:AddClickListener(slot0._onClickShowID, slot0)
	slot0._btnwatermark:AddClickListener(slot0._onClickWaterMark, slot0)
	slot0._btnCurSpeed:AddClickListener(slot0._onClickCurSpeed, slot0)
	slot0._btncopytalentdata:AddClickListener(slot0._onBtnCopyTalentData, slot0)
	slot0._btnReplaceSummonHero:AddClickListener(slot0._OnBtnReplaceSummonHeroClick, slot0)

	if slot0._btnprintallentitybuff then
		slot0._btnprintallentitybuff:AddClickListener(slot0._onBtnPrintAllEntityBuff, slot0)
	end

	slot0:_AddOnValueChanged(slot0._dropRoomInteraction, slot0._onRoomInteractionSelectChanged, slot0)
	slot0:_AddOnValueChanged(slot0._dropRoomWeather, slot0._onRoomWeatherSelectChanged, slot0)
	slot0:_AddClickListener(slot0._btnRoomInteraction, slot0._onClickRoomInteractionOk, slot0)
	slot0:_AddClickListener(slot0._btnCrash1, slot0._testJavaCrash, slot0)
	slot0:_AddClickListener(slot0._btnCrash2, slot0._testOcCrash, slot0)
	slot0:_AddClickListener(slot0._btnCrash3, slot0._testNativeCrash, slot0)
	slot0._btnEnterView:AddClickListener(slot0._onClickEnterView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scroll:RemoveOnValueChanged()
	slot0._btnClose:RemoveClickListener()
	slot0._btnOK1:RemoveClickListener()
	slot0._btnCommand:RemoveClickListener()
	slot0._btnOK2:RemoveClickListener()
	slot0._btnOK4:RemoveClickListener()
	slot0._toggleEar:RemoveOnValueChanged()
	slot0._btnQualityLow:RemoveClickListener()
	slot0._btnQualityMid:RemoveClickListener()
	slot0._btnQualityHigh:RemoveClickListener()
	slot0._btnQualityNo:RemoveClickListener()
	slot0._btnPP:RemoveClickListener()
	slot0._btnSetting:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._txtSpeed.gameObject):RemoveClickListener()
	slot0._sliderSpeed:RemoveOnValueChanged()
	slot0._btnClearPlayerPrefs:RemoveClickListener()
	slot0._btnBlockLog:RemoveClickListener()
	slot0._btnProtoTestView:RemoveClickListener()
	slot0._btnfastaddhero:RemoveClickListener()
	slot0._btnTestFight:RemoveClickListener()
	slot0._btnTestFightId:RemoveClickListener()
	slot0._btnPostProcess:RemoveClickListener()
	slot0._btnEffectStat:RemoveClickListener()
	slot0._btnIgnoreSomeMsgLog:RemoveClickListener()
	slot0._btnFightJoin:RemoveClickListener()
	slot0._btnHideDebug:RemoveClickListener()
	slot0._btnShowError:RemoveClickListener()
	slot0._btnSkinOffsetAdjust:RemoveClickListener()
	slot0._btnFightFocusAdjust:RemoveClickListener()

	if slot0._toggleSkipPatFace then
		slot0._toggleSkipPatFace:RemoveOnValueChanged()
	end

	slot0._btnGuideEditor:RemoveClickListener()
	slot0._btnHelpViewBrowse:RemoveClickListener()
	slot0._btnGuideStatus:RemoveClickListener()
	slot0._btnJumpOK:RemoveClickListener()
	slot0._btnGuideStart:RemoveClickListener()
	slot0._btnGuideFinish:RemoveClickListener()
	slot0._btnGuideForbid:RemoveClickListener()
	slot0._btnGuideReset:RemoveClickListener()
	slot0._btnStorySkip:RemoveClickListener()
	slot0._btnStoryOK:RemoveClickListener()
	slot0._btnChangeColorOK:RemoveClickListener()
	slot0._btnFightSimulate:RemoveClickListener()
	slot0._btnFightEntity:RemoveClickListener()
	slot0._btnResetCards:RemoveClickListener()
	slot0._btnEpisodeOK:RemoveClickListener()
	slot0._btnHeroFaith:RemoveClickListener()
	slot0._btnHeroLevel:RemoveClickListener()
	slot0._dropSkinGetView:RemoveOnValueChanged()
	slot0._dropHeroFaith:RemoveOnValueChanged()
	slot0._dropHeroLevel:RemoveOnValueChanged()
	slot0._dropWeather:RemoveOnValueChanged()
	slot0._btnGetAllHero:RemoveClickListener()
	slot0._btnDeleteAllHeroInfo:RemoveClickListener()
	slot0._btnHideGM:RemoveClickListener()
	slot0._btnUnLockAllEpisode:RemoveClickListener()
	slot0._btnOpenHuaRongView:RemoveClickListener()
	slot0._btnOpenSeasonView:RemoveClickListener()

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		slot0._btnConfirm:RemoveClickListener()
	end

	slot0._btnExplore:RemoveClickListener()
	slot0._inpSpeed1:RemoveOnEndEdit()
	slot0._inpSpeed2:RemoveOnEndEdit()
	slot0._btnshowHero:RemoveClickListener()
	slot0._btnshowUI:RemoveClickListener()
	slot0._btnshowId:RemoveClickListener()
	slot0._btnwatermark:RemoveClickListener()
	slot0._btnCurSpeed:RemoveClickListener()
	slot0._btncopytalentdata:RemoveClickListener()
	slot0._btnReplaceSummonHero:RemoveClickListener()

	if slot0._btnprintallentitybuff then
		slot0._btnprintallentitybuff:RemoveClickListener()
	end

	slot0:_RemoveOnValueChanged(slot0._dropRoomInteraction)
	slot0:_RemoveOnValueChanged(slot0._dropRoomWeather)
	slot0:_RemoveClickListener(slot0._btnRoomInteraction)
	slot0:_RemoveClickListener(slot0._btnCrash1)
	slot0:_RemoveClickListener(slot0._btnCrash2)
	slot0:_RemoveClickListener(slot0._btnCrash3)
	slot0._btnEnterView:RemoveClickListener()
end

function slot0._AddClickListener(slot0, slot1, slot2, slot3)
	if slot1 then
		slot1:AddClickListener(slot2, slot3)
	end
end

function slot0._RemoveClickListener(slot0, slot1)
	if slot1 then
		slot1:RemoveClickListener()
	end
end

function slot0._AddOnValueChanged(slot0, slot1, slot2, slot3)
	if slot1 then
		slot1:AddOnValueChanged(slot2, slot3)
	end
end

function slot0._RemoveOnValueChanged(slot0, slot1)
	if slot1 then
		slot1:RemoveOnValueChanged()
	end
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot0.initDone = false
	slot0.selectHeroLevelId = 0
	slot0.selectHeroFaithId = 0
	slot0._prePlayingAudioId = 0
	slot0.showHero = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowHeroKey, 1) == 1 and true or false
	slot0.showUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowUIKey, 1) == 1 and true or false
	slot0.showID = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowIDKey, 1) == 1 and true or false
	slot0.showWaterMark = OpenConfig.instance:isShowWaterMarkConfig()

	slot0:_showHero()
	slot0:_showUI()
	slot0:_showID()
	slot0:_showWaterMark()

	slot0._txtAccountId.text = "账号:" .. (LoginModel.instance.userName or "nil")
	slot0._scroll.verticalNormalizedPosition = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewScroll, 1)

	slot0._inp1:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGeneral, ""))
	slot0._inpViewName:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewOpenView, ""))
	slot0._inp21:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem1, ""))
	slot0._inp22:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem2, ""))
	slot0._inpTestFight:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewTestFight, ""))
	slot0._inpJump:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewJump, ""))
	slot0._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
	slot0._inpEpisode:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewEpisode, ""))
	slot0._inpStory:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewStory, ""))

	slot0._toggleEar.isOn = SDKMgr.instance:isEarphoneContact()

	if slot0._toggleSkipPatFace then
		slot0._toggleSkipPatFace.isOn = PatFaceModel.instance:getIsSkipPatFace()
	end

	TaskDispatcher.runRepeat(slot0._updateServerTime, slot0, 0.2)
	slot0:_updateQualityBtn()
	slot0:_updateSpeedText()
	slot0:_refreshPP()
	slot0:_updateHeartBeatLogText()
	slot0:_updateLogStateText()
	slot0:_initScreenSize()
	slot0:_initSkinViewSelect()
	slot0:_initHeroFaithSelect()
	slot0:_initHeroLevelSelect()
	slot0:_initWeatherSelect()
	slot0:_refreshGMBtnText()

	slot0.initDone = true

	slot0:_updateFightJoinText()
	slot0:_updateFightSpeedText()
	slot0:_initCharacterInteractionSelect()
	slot0:_initRoomWeatherSelect()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._updateServerTime, slot0, 0.2)
end

function slot0._onScrollValueChanged(slot0, slot1, slot2)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewScroll, slot2)
end

function slot0._updateServerTime(slot0)
	slot1 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())
	slot0._txtServerTime.text = string.format("%04d-%02d-%02d %02d:%02d:%02d", slot1.year, slot1.month, slot1.day, slot1.hour, slot1.min, slot1.sec)
	slot0._txtLocalTime.text = os.date("%Y-%m-%d %H:%M:%S", os.time())
end

function slot0._onClickBtnOK1(slot0)
	slot1 = slot0._inp1:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGeneral, slot1)

	slot2 = 0
	slot3 = nil

	for slot7 in slot1:gmatch("[^\r\n]+") do
		if not string.nilorempty(slot7) then
			if string.find(slot7, "set dungeon") then
				slot3 = slot7
			else
				if slot2 == 0 then
					slot0:_sendGM(slot7)
				else
					TaskDispatcher.runDelay(function ()
						uv0:_sendGM(uv1)
					end, nil, slot2)
				end

				slot2 = slot2 + 0.1
			end
		end
	end

	if slot3 then
		if slot2 == 0 then
			slot0:_sendGM(slot3)
		else
			TaskDispatcher.runDelay(function ()
				uv0:_sendGM(uv1)
			end, nil, slot2)
		end
	end
end

function slot0._sendGM(slot0, slot1)
	GameFacade.showToast(ToastEnum.IconId, slot1)

	if slot1:find("bossrush") then
		BossRushController_Test.instance:_test(slot1)

		return
	end

	if string.find(slot1, "#") == 1 then
		slot0:_clientGM(string.split(slot1, " "))

		return
	end

	GMRpc.instance:sendGMRequest(slot1)
	slot0:_onServerGM(slot1)
end

function slot0._onServerGM(slot0, slot1)
	if string.find(slot1, "delete%sexplore") then
		PlayerPrefsHelper.deleteKey(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId())
		ExploreSimpleModel.instance:reInit()
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end
end

function slot0._clientGM(slot0, slot1)
	GMCommand.processCmd(slot1[1]:sub(2), unpack(slot1, 2))
end

function slot0._onClickBtnCommand(slot0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		UnityEngine.Application.OpenURL("http://doc.sl.com/pages/viewpage.action?pageId=3342342")

		return
	end

	GMController.instance:dispatchEvent(GMCommandView.OpenCommand)
end

function slot0._onClickBtnOK2(slot0)
	slot3 = string.split(slot0._inp21:GetText(), "#")
	slot4 = slot3[1]
	slot5 = tonumber(slot3[2])
	slot6 = 1

	if not string.nilorempty(slot0._inp22:GetText()) then
		slot6 = tonumber(slot2)
	end

	if slot6 and slot6 < 0 then
		GameFacade.showToast(ToastEnum.GMTool1, slot5)
		GMRpc.instance:sendGMRequest(string.format("delete material %d#%d#%d", slot4, slot5, -slot6))

		return
	end

	if tonumber(slot4) == MaterialEnum.MaterialType.Hero then
		GameFacade.showToast(ToastEnum.GMTool2, slot5)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", MaterialEnum.MaterialType.Hero, slot5, slot6))
	elseif slot4 == GMAddItemView.LevelType then
		GameFacade.showToast(ToastEnum.GMTool3, slot6)
		GMRpc.instance:sendGMRequest(string.format("set level %d", slot6))
	elseif tonumber(slot4) == MaterialEnum.MaterialType.Exp then
		GameFacade.showToast(ToastEnum.GMTool4, slot6)
		GMRpc.instance:sendGMRequest(string.format("add material 3#0#%d", slot6))
	elseif slot3[1] == GMAddItemView.HeroAttr then
		slot8 = string.splitToNumber(slot2, "#")[1] or 1
		slot9 = slot7[2] or 100
		slot10 = slot7[3] or 100
		slot11 = slot7[4] or 2

		GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", slot8, slot9, slot10, slot11))
		GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", slot5, slot8, slot9, slot10, slot11))
	else
		GameFacade.showToast(ToastEnum.GMTool5, slot5)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", slot4, slot5, slot6))
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem1, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem2, slot2)
end

function slot0._onClickBtnOK4(slot0)
	LoginController.instance:logout()
end

function slot0._updateQualityBtn(slot0)
	for slot5, slot6 in ipairs(slot0._imgQualitys) do
		slot6.color = slot5 == PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine) + 1 and Color.green or Color.white
	end
end

function slot0._onClickBtnQualityLow(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Low)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
	FightEffectPool.dispose()
	slot0:_updateQualityBtn()
end

function slot0._onClickBtnQualityMid(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Middle)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Middle)
	FightEffectPool.dispose()
	slot0:_updateQualityBtn()
end

function slot0._onClickBtnQualityHigh(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)
	FightEffectPool.dispose()
	slot0:_updateQualityBtn()
end

function slot0._onClickBtnQualityNo(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Undefine)
	FightEffectPool.dispose()
	slot0:_updateQualityBtn()
end

function slot0._onClickBtnPP(slot0)
	GMPostProcessModel.instance.ppType = (GMPostProcessModel.instance.ppType + 1) % 4

	slot0:_refreshPP()
end

function slot0._onClickBtnSetting(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenSettingFinish, slot0)
	SettingsController.instance:openView()
end

function slot0._onOpenSettingFinish(slot0, slot1)
	if slot1 == ViewName.SettingsView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenSettingFinish, slot0)
		ViewMgr.instance:getContainer(ViewName.SettingsView):switchTab(3)
	end
end

function slot0._refreshPP(slot0)
	if GMPostProcessModel.instance.ppType == 0 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(false)

		slot0._txtBtnPP.text = "OFF"
	elseif GMPostProcessModel.instance.ppType == 1 then
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(false)

		slot0._txtBtnPP.text = "UI"
	elseif GMPostProcessModel.instance.ppType == 2 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(true)

		slot0._txtBtnPP.text = "Unit"
	else
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(true)

		slot0._txtBtnPP.text = "ALL"
	end
end

function slot0._updateSpeedText(slot0)
	slot1 = GameTimeMgr.instance:getTimeScale(GameTimeMgr.TimeScaleType.GM)

	slot0._sliderSpeed:SetValue(slot1)

	slot0._txtSpeed.text = string.format("Speed %s%.2f", luaLang("multiple"), slot1)
end

function slot0._onClickSpeedText(slot0)
	slot0:_onSpeedChange(nil, 1)
end

function slot0._onSpeedChange(slot0, slot1, slot2)
	slot0._sliderSpeed:SetValue(slot2)

	slot0._txtSpeed.text = string.format("Speed %s%.2f", luaLang("multiple"), slot2)

	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.GM, slot2)
end

function slot0._onClickBtnClearPlayerPrefs(slot0)
	PlayerPrefsHelper.deleteAll()
	GameFacade.showToast(ToastEnum.GMToolClearPlayerPrefs)
end

function slot0._onClickBtnBlockLog(slot0)
	slot1 = not getGlobal("canLogNormal")

	setGlobal("canLogNormal", slot1)
	setGlobal("canLogWarn", slot1)
	setGlobal("canLogError", slot1)

	SLFramework.SLLogger.CanLogNormal = slot1
	SLFramework.SLLogger.CanLogWarn = slot1
	SLFramework.SLLogger.CanLogError = slot1
	GuideController.EnableLog = slot1

	slot0:_updateLogStateText()
end

function slot0._updateLogStateText(slot0)
	gohelper.findChildText(slot0._btnBlockLog.gameObject, "Text").text = getGlobal("canLogNormal") and "屏蔽所有log" or "恢复所有log"
end

function slot0._onClickBtnProtoTestView(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.ProtoTestView)
end

function slot0._onClickTestFight(slot0)
	if not string.nilorempty(slot0._inpTestFight:GetText()) and #string.splitToNumber(slot1, "#") > 0 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, slot1)
		HeroGroupModel.instance:setParam(nil, , )

		if not HeroGroupModel.instance:getCurGroupMO() then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		slot4, slot5 = slot3:getMainList()
		slot6, slot7 = slot3:getSubList()

		slot0:closeThis()

		slot9 = FightParam.New()
		slot9.monsterGroupIds = slot2
		slot9.isTestFight = true

		slot9:setSceneLevel(10601)
		slot9:setMySide(slot3.clothId, slot4, slot6, slot3:getAllHeroEquips())
		FightModel.instance:setFightParam(slot9)
		FightController.instance:sendTestFight(slot9)

		return
	end

	logError("please input monsterGroupIds, split with '#'")
end

function slot0._onClickTestFightId(slot0)
	if tonumber(slot0._inpTestFight:GetText()) and lua_battle.configDict[slot2] then
		slot4 = FightController.instance:setFightParamByBattleId(slot2)

		HeroGroupModel.instance:setParam(slot2, nil, )

		if not HeroGroupModel.instance:getCurGroupMO() then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		slot6, slot7 = slot5:getMainList()
		slot8, slot9 = slot5:getSubList()
		slot10 = slot5:getAllHeroEquips()

		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, slot1)
		slot0:closeThis()

		for slot14, slot15 in ipairs(lua_episode.configList) do
			if slot15.battleId == slot2 then
				slot4.episodeId = slot15.id
				FightResultModel.instance.episodeId = slot15.id

				DungeonModel.instance:SetSendChapterEpisodeId(slot15.chapterId, slot15.id)

				break
			end
		end

		if not slot4.episodeId then
			slot4.episodeId = 10101
		end

		slot4:setMySide(slot5.clothId, slot6, slot8, slot10)
		FightController.instance:sendTestFightId(slot4)
	end
end

function slot0._onClickPostProcess(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMPostProcessView)
end

function slot0._onClickEffectStat(slot0)
	if ViewMgr.instance:isOpen(ViewName.SkillEffectStatView) then
		ViewMgr.instance:closeView(ViewName.SkillEffectStatView)
	else
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
	end
end

function slot0._onClickIgnoreSomeMsgLog(slot0)
	if LuaSocketMgr.instance._ignoreSomeCmdLog then
		GMController.instance:resumeHeartBeatLog()
	else
		GMController.instance:ignoreHeartBeatLog()
	end

	slot0:_updateHeartBeatLogText()
end

function slot0._updateHeartBeatLogText(slot0)
	gohelper.findChildText(slot0.viewGO, "viewport/content/item11/Button/Text").text = LuaSocketMgr.instance._ignoreSomeCmdLog and "恢复心跳打印" or "屏蔽心跳打印"
end

function slot0._onClickFightJoin(slot0)
	FightModel.instance:switchGMFightJoin()
	slot0:_updateFightJoinText()
end

function slot0._updateFightJoinText(slot0)
	gohelper.findChildText(slot0.viewGO, "viewport/content/item11/btnFightJoin/Text").text = FightModel.instance:isGMFightJoin() and "关闭战斗衔接" or "启用战斗衔接"
end

function slot0._onEndEdit1(slot0, slot1)
	slot0:_setFightSpeed()
end

function slot0._onEndEdit2(slot0, slot1)
	slot0:_setFightSpeed()
end

function slot0._onClickCurSpeed(slot0)
	slot1 = FightModel.instance._normalSpeed
	slot2 = FightModel.instance._replaySpeed
	slot3 = FightModel.instance._replayUISpeed

	logError("手动战斗速度：一倍" .. slot1[1] .. " 二倍" .. slot1[2])
	logError("战斗回溯速度：一倍" .. slot2[1] .. " 二倍" .. slot2[2])
	logError("战斗回溯UI速：一倍" .. slot3[1] .. " 二倍" .. slot3[2])
	logError("玩家选择速度：" .. FightModel.instance:getUserSpeed())
	logError("当前战斗速度：" .. FightModel.instance:getSpeed())
	logError("当前战斗UI速：" .. FightModel.instance:getUISpeed())
end

function slot0._setFightSpeed(slot0)
	FightModel.instance:setGMSpeed(tonumber(slot0._inpSpeed1:GetText()) or 1, tonumber(slot0._inpSpeed2:GetText()) or 1)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function slot0._updateFightSpeedText(slot0)
	slot0._inpSpeed1:SetText(tostring(FightModel.instance:getNormalSpeed()))
	slot0._inpSpeed2:SetText(tostring(FightModel.instance:getReplaySpeed()))
end

function slot0._onClickHideBug(slot0)
	slot1 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewDebugView, slot1 and 0 or 1)
	gohelper.setActive(GMController.debugViewGO, not slot1)
end

function slot0._onClickShowError(slot0)
	GMLogController.instance:cancelBlock()
end

function slot0._onClickSkinOffsetAdjust(slot0)
	if MainSceneSwitchModel.instance:getCurSceneId() ~= 1 then
		logError("请在箱中布景把主场景切换为《浪潮之初》才能调整皮肤偏移！")

		return
	end

	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.SkinOffsetAdjustView)
end

function slot0._onClickFightFocusAdjust(slot0)
	if not ViewMgr.instance:isOpen(ViewName.FightFocusView) then
		return
	end

	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.FightFocusCameraAdjustView)
end

function slot0._onSkipPatFaceToggleValueChange(slot0, slot1, slot2)
	if not slot0.initDone then
		return
	end

	PatFaceModel.instance:setIsSkipPatFace(slot2 and true or false)
end

function slot0._onClickGuideEditor(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function slot0._onClickHelpViewBrowse(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

function slot0._onClickGuideStatus(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function slot0._onClickJumpOK(slot0)
	slot1 = slot0._inpJump:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewJump, slot1)
	slot0:closeThis()

	if tonumber(slot1) then
		GameFacade.jump(slot2)
	else
		GameFacade.jumpByStr(slot1)
	end
end

function slot0._onClickEpisodeOK(slot0)
	slot1 = slot0._inpEpisode:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewEpisode, slot1)

	if DungeonConfig.instance:getEpisodeCO(tonumber(string.splitToNumber(slot1, "#")[1])) then
		slot0:closeThis()

		if DungeonModel.isBattleEpisode(slot4) then
			DungeonFightController.instance:enterFight(slot4.chapterId, slot4.id)
		else
			logError("GMToolView 不支持该类型的关卡" .. slot3)
		end
	else
		logError("GMToolView 关卡id不正确")
	end
end

function slot0._onClickGuideStart(slot0)
	slot0:closeThis()

	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	slot2 = string.splitToNumber(slot1, "#")
	slot3 = tonumber(slot2[1])
	slot4 = tonumber(slot2[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", slot3, slot4))
	GuideModel.instance:gmStartGuide(slot3, slot4)

	if GuideModel.instance:getById(slot3) then
		GuideStepController.instance:clearFlow(slot3)

		slot5.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. slot3)

		slot6 = {
			guideInfos = {
				{
					guideId = slot3,
					stepId = slot4
				}
			}
		}

		GuideRpc.instance:sendFinishGuideRequest(slot3, slot4)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", slot3, slot4))
	elseif slot3 then
		GuideController.instance:startGudie(slot3)
		logNormal("<color=#FFA500>start guide " .. slot3 .. "</color>")
	end
end

function slot0._onClickGuideFinish(slot0)
	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	if not string.nilorempty(slot1) then
		if tonumber(slot1) then
			slot3 = GuideModel.instance:getById(slot2)

			slot0:closeThis()
			logNormal("GM one key finish guide " .. slot2)

			for slot8 = #GuideConfig.instance:getStepList(slot2), 1, -1 do
				if slot4[slot8].keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(slot2, slot9.stepId)

					break
				end
			end
		else
			slot3 = string.split(slot1, "#")

			logNormal("GM one key finish guide " .. slot1)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(slot3[1]), tonumber(slot3[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function slot0._onClickGuideForbid(slot0)
	GuideController.instance:forbidGuides(not GuideController.instance:isForbidGuides())
end

function slot0._onClickGuideReset(slot0)
	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	if GuideConfig.instance:getGuideCO(tonumber(string.splitToNumber(slot1, "#")[1])) then
		print(string.format("reset guideId:%s", slot3))
		GuideStepController.instance:clearFlow(slot3)
		GMRpc.instance:sendGMRequest("delete guide " .. slot3)

		slot5 = string.split(slot4.trigger, "#")
		slot6 = slot5[1]

		slot0:_resetEpisode(slot5[1], slot5[2])

		if not GameUtil.splitString2(slot4.invalid, false, "|", "#") then
			return
		end

		for slot11, slot12 in ipairs(slot7) do
			-- Nothing
		end
	end
end

function slot0._resetEpisode(slot0, slot1, slot2)
	if slot1 == "EpisodeFinish" or slot1 == "EnterEpisode" then
		slot0:_doResetEpisode(tonumber(slot2))

		return
	end

	if lua_open.configDict[tonumber(slot2)] then
		slot0:_doResetEpisode(slot3.episodeId)
	end
end

function slot0._doResetEpisode(slot0, slot1)
	if not lua_episode.configDict[slot1] then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", slot1))

	if slot2.beforeStory > 0 then
		print(slot1 .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot2.beforeStory))
	end

	if slot2.afterStory > 0 then
		print(slot1 .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot2.afterStory))
	end
end

function slot0._onClickStoryOK(slot0)
	slot0:closeThis()

	if not string.nilorempty(slot0._inpStory:GetText()) then
		slot2 = string.splitToNumber(slot1, "#")
		slot4 = slot2[2]

		if slot2[1] then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewStory, slot3)

			if slot4 then
				StoryController.instance:playStoryByStartStep(slot3, slot4)
			else
				StoryController.instance:playStory(slot3, {
					isReplay = true,
					mark = false
				})
			end
		end
	end
end

function slot0._onClickStorySkip(slot0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		StoryController.instance:playFinished()
	end
end

function slot0._onClickChangeColorOK(slot0)
	slot0:closeThis()

	if not string.nilorempty(slot0._inpChangeColor:GetText()) and tonumber(slot1) then
		DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(slot2)
	end
end

function slot0._onClickFightSimulate(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function slot0._onClickFightEntity(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function slot0._onClickResetCards(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function slot0._initScreenSize(slot0)
	if BootNativeUtil.isWindows() then
		slot0._inpScreenWidth:SetText(SettingsModel.instance._screenWidth)
		slot0._inpScreenHeight:SetText(SettingsModel.instance._screenHeight)
	else
		gohelper.setActive(slot0._inpScreenWidth.gameObject.transform.parent.gameObject, false)
	end
end

function slot0._formatSize(slot0, slot1, slot2)
	if not tonumber(slot1) then
		return slot2
	end

	if slot3 < 1 then
		return slot2
	end

	return slot3
end

function slot0._onClickExplore(slot0)
	if not ExploreSimpleModel.instance:getMapIsUnLock(tonumber(string.match(slot0._inpExplore:GetText() or "", "(%d+)$")) or 101) then
		slot4 = nil
		slot6 = 3

		if DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Normal)[5] then
			slot4 = DungeonConfig.instance:getChapterNonSpEpisodeCOList(slot7[slot5].id) and slot8[slot6] and slot8[slot6].id
		end

		if slot4 then
			GMRpc.instance:sendGMRequest(string.format("set dungeon %d", slot4))
		end

		if not DungeonMapModel.instance:elementIsFinished(1050302) then
			DungeonRpc.instance:sendMapElementRequest(1050302)
		end

		GMRpc.instance:sendGMRequest("set explore")
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end

	ExploreController.instance:enterExploreScene(slot3)

	if ExploreConfig.instance:getMapIdConfig(slot3) then
		ExploreSimpleModel.instance:setLastSelectMap(slot4.chapterId, slot4.episodeId)
	end
end

function slot0._onClickScreenSize(slot0)
	slot1 = slot0:_formatSize(slot0._inpScreenWidth:GetText(), SettingsModel.instance._screenWidth)
	slot2 = slot0:_formatSize(slot0._inpScreenHeight:GetText(), SettingsModel.instance._screenHeight)

	slot0._inpScreenWidth:SetText(slot1)
	slot0._inpScreenHeight:SetText(slot2)
	SettingsModel.instance:_setScreenWidthAndHeight(string.format("%d * %d", slot1, slot2))
end

function slot0._initHaveHeroNameList(slot0)
	if slot0.haveHeroList then
		return
	end

	slot0.haveHeroList = {}

	table.insert(slot0.haveHeroList, "英雄选择")

	for slot4, slot5 in ipairs(HeroModel.instance:getList()) do
		table.insert(slot0.haveHeroList, slot5.config.name .. "#" .. tostring(slot5.heroId))
	end
end

function slot0._initSkinViewSelect(slot0)
	slot0:_initHaveHeroNameList()
	slot0._dropSkinGetView:ClearOptions()
	slot0._dropSkinGetView:AddOptions(slot0.haveHeroList)
end

function slot0._initHeroFaithSelect(slot0)
	slot0:_initHaveHeroNameList()
	slot0._dropHeroFaith:ClearOptions()
	slot0._dropHeroFaith:AddOptions(slot0.haveHeroList)
end

function slot0._initHeroLevelSelect(slot0)
	slot0:_initHaveHeroNameList()
	slot0._dropHeroLevel:ClearOptions()
	slot0._dropHeroLevel:AddOptions(slot0.haveHeroList)
end

function slot0._sortCharacterInteractionFunc(slot0, slot1)
	if slot0.behaviour ~= slot1.behaviour then
		return slot0.behaviour < slot1.behaviour
	end
end

function slot0._initCharacterInteractionSelect(slot0)
	if not slot0.characterInteractionList then
		slot0.characterInteractionList = {}

		for slot4, slot5 in ipairs(lua_room_character_interaction.configList) do
			if RoomCharacterModel.instance:getCharacterMOById(slot5.heroId) and slot6.characterState == RoomCharacterEnum.CharacterState.Map then
				table.insert(slot0.characterInteractionList, slot5)
			end
		end

		table.sort(slot0.characterInteractionList, uv0._sortCharacterInteractionFunc)
	end

	slot2 = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}

	table.insert({}, "英雄-交互#id选择")

	for slot6, slot7 in ipairs(slot0.characterInteractionList) do
		if slot2[slot7.behaviour] then
			table.insert(slot1, string.format("%s-%s#%s", HeroConfig.instance:getHeroCO(slot7.heroId).name or slot7.heroId, slot2[slot7.behaviour], slot7.id))
		end
	end

	if slot0._dropRoomInteraction then
		slot0._dropRoomInteraction:ClearOptions()
		slot0._dropRoomInteraction:AddOptions(slot1)
	end
end

function slot0._initRoomWeatherSelect(slot0)
	slot0.roomWeatherIdList = {}

	for slot5, slot6 in ipairs(RoomConfig.instance:getSceneAmbientConfigList()) do
		table.insert(slot0.roomWeatherIdList, slot6.id)
	end

	tabletool.addValues({
		"请选择天气"
	}, slot0.roomWeatherIdList)

	if slot0._dropRoomWeather then
		slot0._dropRoomWeather:ClearOptions()
		slot0._dropRoomWeather:AddOptions(slot2)
	end
end

function slot0._onSkinGetValueChanged(slot0, slot1)
	if not slot0.haveHeroList then
		return
	end

	if slot1 == 0 then
		return
	end

	if not string.split(slot0.haveHeroList[slot1 + 1], "#")[2] then
		logError("not found : " .. slot0.haveHeroList[slot1 + 1])
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, {
		heroId = tonumber(slot2),
		newRank = 3,
		isRank = true
	})
end

function slot0._onRoomWeatherSelectChanged(slot0, slot1)
	if not slot0.roomWeatherIdList then
		return
	end

	if slot1 == 0 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		if GameSceneMgr.instance:getCurScene() and slot2.ambient then
			slot3 = slot0.roomWeatherIdList[slot1]

			slot2.ambient:tweenToAmbientId(slot3)
			GameFacade.showToast(94, string.format("GM切换小屋天气:%s", slot3))
			slot0:closeThis()
		end
	else
		GameFacade.showToast(94, "GM需要进入小屋可使用。")
	end
end

function slot0._onRoomInteractionSelectChanged(slot0, slot1)
	if not slot0.characterInteractionList then
		return
	end

	if slot1 == 0 then
		slot0.selectCharacterInteractionCfg = nil

		return
	end

	slot0.selectCharacterInteractionCfg = slot0.characterInteractionList[slot1]
end

function slot0._onClickRoomInteractionOk(slot0)
	if #slot0.characterInteractionList < 1 then
		GameFacade.showToast(94, "GM需要进入小屋并放置可交互角色。")
	end

	if not slot0.selectCharacterInteractionCfg then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot0.selectCharacterInteractionCfg.heroId) or slot1.characterState ~= RoomCharacterEnum.CharacterState.Map then
		GameFacade.showToast(94, "GM 需要放置角色后可交互。")

		return
	end

	if slot0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		GameFacade.showToast(94, string.format("GM %s 触发交互", slot1.heroConfig.name))
		slot1:setCurrentInteractionId(slot0.selectCharacterInteractionCfg.id)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
	elseif slot0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Building then
		if not RoomMapInteractionModel.instance:getBuildingInteractionMO(slot0.selectCharacterInteractionCfg.id) then
			GameFacade.showToast(94, string.format("GM 场景无【%s】建筑，【%s】无发交互", RoomConfig.instance:getBuildingConfig(slot0.selectCharacterInteractionCfg.buildingId) and slot3.name or slot0.selectCharacterInteractionCfg.buildingId, slot1.heroConfig.name))

			return
		end

		if not RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) then
			GameFacade.showToast(94, string.format("GM 当场景状态机非[%s]", RoomEnum.FSMObState.Idle))

			return
		end

		if not RoomInteractionController.instance:showTimeByInteractionMO(slot2) then
			GameFacade.showToast(94, string.format("GM【%s】不在【%s】交互点范围内", slot1.heroConfig.name, slot4))

			return
		end

		slot0:closeThis()
		logNormal(string.format("GM【%s】【%s】触发角色建筑交互", slot1.heroConfig.name, slot4))
	end
end

function slot0._onHeroFaithSelectChanged(slot0, slot1)
	if not slot0.haveHeroList then
		return
	end

	if slot1 == 0 then
		return
	end

	if not string.split(slot0.haveHeroList[slot1 + 1], "#")[2] then
		logError("not found : " .. slot0.haveHeroList[slot1 + 1])
	end

	slot0.selectHeroFaithId = tonumber(slot2)
end

function slot0._onHeroLevelSelectChanged(slot0, slot1)
	if not slot0.haveHeroList then
		return
	end

	if slot1 == 0 then
		return
	end

	if not string.split(slot0.haveHeroList[slot1 + 1], "#")[2] then
		logError("not found : " .. slot0.haveHeroList[slot1 + 1])
	end

	slot0.selectHeroLevelId = tonumber(slot2)
end

function slot0._onClickHeroFaithOk(slot0)
	if slot0.selectHeroFaithId == 0 then
		return
	end

	GameFacade.showToast(ToastEnum.GMTool5, slot0.selectHeroFaithId)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", 6, slot0.selectHeroFaithId, HeroConfig.instance.maxFaith))
end

function slot0._onClickHeroLevelOk(slot0)
	if slot0.selectHeroLevelId == 0 then
		return
	end

	slot1 = slot0._inpHeroLevel:GetText()

	GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", slot1, 100, 100, 2))
	GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", slot0.selectHeroLevelId, slot1, 100, 100, 2))
end

function slot0._initWeatherSelect(slot0)
	slot0.weatherReportIdList = {}

	for slot4, slot5 in ipairs(lua_weather_report.configList) do
		table.insert(slot0.weatherReportIdList, string.format("%d %s-%s", slot5.id, BGMSwitchProgress.WeatherLight[slot5.lightMode], BGMSwitchProgress.WeatherEffect[slot5.effect]))
	end

	slot0._dropWeather:ClearOptions()
	slot0._dropWeather:AddOptions(slot0.weatherReportIdList)

	if WeatherController.instance._curReport then
		slot0._dropWeather:SetValue(WeatherController.instance._curReport.id - 1)
	end

	slot0._dropWeather:AddOnValueChanged(slot0._onWeatherChange, slot0)
end

function slot0._onWeatherChange(slot0, slot1)
	WeatherController.instance:setReportId(slot1 + 1)
end

function slot0._onClickGetAllHeroBtn(slot0)
	HeroRpc.instance.preventGainView = true

	GMRpc.instance:sendGMRequest("add hero all 1")
	GameFacade.showToast(ToastEnum.IconId, "获取所有上线角色")
	TaskDispatcher.runDelay(function ()
		HeroRpc.instance.preventGainView = nil
	end, nil, 5)
end

function slot0._onClickDeleteAllHeroInfoBtn(slot0)
	MessageBoxController.instance:showMsgBoxByStr("确定要删除账号吗？", MsgBoxEnum.BoxType.Yes_No, function ()
		GMRpc.instance:sendGMRequest("delete account", function ()
			LoginController.instance:logout()
		end)
	end)
end

function slot0._refreshGMBtnText(slot0)
	if not slot0.showGMBtn then
		slot0.showGMBtn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
	end

	if slot0.showGMBtn == 1 then
		slot0._txtGM.text = "隐藏GM按钮"
	else
		slot0._txtGM.text = "显示GM按钮"
	end
end

function slot0._onClickHideGMBtn(slot0)
	slot0.showGMBtn = slot0.showGMBtn == 1 and 0 or 1

	slot0:_refreshGMBtnText()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, slot0.showGMBtn)
	MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)
end

function slot0._onClickUnLockAllEpisode(slot0)
	GMRpc.instance:sendGMRequest("set dungeon all")
end

function slot0._onClickOpenHuaRongViewBtn(slot0)
	ViewMgr.instance:openView(ViewName.DungeonHuaRongView)
end

function slot0._onClickOpenSeasonViewBtn(slot0)
	ViewMgr.instance:openView(ViewName.TowerPermanentView)
end

function slot0._onEarToggleValueChange(slot0)
	if not slot0.initDone then
		return
	end

	slot0._toggleEar.isOn = SDKMgr.instance:isEarphoneContact()
end

function slot0._onClickShowHero(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	slot0.showHero = not slot0.showHero

	slot0:_showHero()
end

function slot0._showHero(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not slot0.heroNodes then
		slot1 = ViewMgr.instance:getContainer(ViewName.MainView)
		slot0.heroNodes = {}

		table.insert(slot0.heroNodes, gohelper.findChild(slot1.viewGO, "#go_spine_scale"))
		table.insert(slot0.heroNodes, gohelper.findChild(slot1.viewGO, "#go_lightspinecontrol"))
	end

	for slot4, slot5 in pairs(slot0.heroNodes) do
		gohelper.setActive(slot5, slot0.showHero)
	end

	slot0._txtshowHero.text = slot0.showHero and "隐藏主界面角色" or "显示主界面角色"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowHeroKey, slot0.showHero and 1 or 0)
end

function slot0._onClickShowUI(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	slot0.showUI = not slot0.showUI

	slot0:_showUI()
end

function slot0._showUI(slot0)
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not slot0.uiNodes then
		slot0.uiNodes = {}

		table.insert(slot0.uiNodes, slot0:getIDCanvasNode())

		slot1 = ViewMgr.instance:getContainer(ViewName.MainView)

		table.insert(slot0.uiNodes, gohelper.findChild(slot1.viewGO, "left"))
		table.insert(slot0.uiNodes, gohelper.findChild(slot1.viewGO, "left_top"))
		table.insert(slot0.uiNodes, gohelper.findChild(slot1.viewGO, "#go_righttop"))
		table.insert(slot0.uiNodes, gohelper.findChild(slot1.viewGO, "right"))
		table.insert(slot0.uiNodes, gohelper.findChild(slot1.viewGO, "bottom"))
	end

	for slot4, slot5 in pairs(slot0.uiNodes) do
		gohelper.setActive(slot5, slot0.showUI)
	end

	slot0._txtshowUI.text = slot0.showUI and "隐藏主界面UI" or "显示主界面UI"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowUIKey, slot0.showUI and 1 or 0)

	slot0.showID = slot0.showUI

	slot0:_showID()
end

function slot0._onClickShowID(slot0)
	slot0.showID = not slot0.showID

	slot0:_showID()
end

function slot0._showID(slot0)
	gohelper.setActive(slot0:getIDCanvasNode(), slot0.showID)

	slot0._txtshowId.text = slot0.showID and "隐藏左下角ID" or "显示左下角ID"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowIDKey, slot0.showID and 1 or 0)
end

function slot0._onClickWaterMark(slot0)
	slot0.showWaterMark = not slot0.showWaterMark

	slot0:_showWaterMark()
end

function slot0._showWaterMark(slot0)
	if ViewMgr.instance:getContainer(ViewName.WaterMarkView) then
		if slot0.showWaterMark then
			slot1.waterMarkView:showWaterMark()
		else
			slot1.waterMarkView:hideWaterMark()
		end

		slot0._txtwatermark.text = slot0.showWaterMark and "隐藏水印" or "显示水印"
	end
end

function slot0.getIDCanvasNode(slot0)
	if not slot0.goIDRoot then
		slot0.goIDRoot = gohelper.find("IDCanvas")
	end

	if not slot0.goIDPopup then
		slot0.goIDPopup = gohelper.findChild(slot0.goIDRoot, "POPUP")
	end

	return slot0.goIDPopup
end

function slot0._onBtnCopyTalentData(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.CopyTalentData)
end

function slot0._onBtnPrintAllEntityBuff(slot0)
	logError("打印角色的当前buffid~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot7 = slot6:getMO()

		logError("角色id或者怪物id: " .. slot7.modelId)

		for slot12, slot13 in ipairs(slot7:getBuffList()) do
			logError("携带buffid: " .. slot13.buffId)
		end
	end
end

function slot0._onClickBtnFastAddHero(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMToolFastAddHeroView)
end

function slot0._OnBtnReplaceSummonHeroClick(slot0)
	if string.nilorempty(slot0._inpHeroList:GetText()) then
		return
	end

	slot4 = nil

	for slot8, slot9 in ipairs(string.splitToNumber(slot1, ";")) do
		table.insert({}, {
			isNew = true,
			duplicateCount = 1,
			heroId = slot9
		})
	end

	slot5 = SummonController.summonSuccess

	function SummonController.summonSuccess(slot0, slot1)
		uv0(slot0, uv1)
	end
end

function slot0._testJavaCrash(slot0)
	CrashSightAgent.TestJavaCrash()
end

function slot0._testOcCrash(slot0)
	CrashSightAgent.TestOcCrash()
end

function slot0._testNativeCrash(slot0)
	CrashSightAgent.TestNativeCrash()
end

function slot0._onClickEnterView(slot0)
	if string.nilorempty(slot0._inpViewName:GetText()) then
		GameFacade.showToastString("请输入界面名字")
	elseif ViewName[slot1] then
		slot0:closeThis()
		ViewMgr.instance:openView(ViewName[slot1])
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewOpenView, slot1)
	else
		GameFacade.showToastString(string.format("界面%s不存在", slot1))
	end
end

return slot0
