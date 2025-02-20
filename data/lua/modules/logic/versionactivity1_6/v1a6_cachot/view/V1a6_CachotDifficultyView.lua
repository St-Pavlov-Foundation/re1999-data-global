module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotDifficultyView", package.seeall)

slot0 = class("V1a6_CachotDifficultyView", BaseView)
slot1 = 1
slot2 = -1

function slot0.onInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goredmask = gohelper.findChild(slot0.viewGO, "redmask")
	slot0._maskanimator = slot0._goredmask:GetComponent(typeof(UnityEngine.Animator))
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gotipswindow = gohelper.findChild(slot0.viewGO, "#go_tipswindow")
	slot0._txtlevelname = gohelper.findChildText(slot0.viewGO, "#go_tipswindow/bg/#txt_levelname")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_next")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tipswindow/#go_next/#btn_next")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_tipswindow/#scroll_view")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_level")
	slot0._scrolllevel = gohelper.findChildScrollRect(slot0.viewGO, "#go_tipswindow/#go_level/#scroll_level")
	slot0._golevelContent = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item")
	slot0._btnup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tipswindow/#go_level/#btn_up")
	slot0._btndown = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tipswindow/#go_level/#btn_down")
	slot0._gopreview = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_preview")
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#simage_left")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#simage_left/#txt_name")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._levelItemObjects = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnup:AddClickListener(slot0._btnupOnClick, slot0)
	slot0._btndown:AddClickListener(slot0._btndownOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnup:RemoveClickListener()
	slot0._btndown:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
	V1a6_CachotController.instance:openV1a6_CachotMainView()
end

function slot0._btnnextOnClick(slot0)
	if not slot0._currentSelectLevel then
		logError("V1a6_CachotDifficultyView selectlevel is nil")

		return
	end

	PlayerPrefsHelper.setNumber(slot0:_getPlayerPrefKeyDifficulty(), slot0._currentSelectLevel)
	V1a6_CachotController.instance:openV1a6_CachotTeamView({
		isInitSelect = true,
		selectLevel = slot0._currentSelectLevel
	})
end

function slot0._getPlayerPrefKeyDifficulty(slot0)
	return PlayerPrefsKey.Version1_6V1a6_CachotDifficulty .. PlayerModel.instance:getPlayinfo().userId
end

function slot0._btnupOnClick(slot0)
	if slot0:_btnClick(true) then
		slot0._animator:Update(0)
		slot0._animator:Play("down", 0, 0)
	end
end

function slot0._btndownOnClick(slot0)
	if slot0:_btnClick(false) then
		slot0._animator:Update(0)
		slot0._animator:Play("up", 0, 0)
	end
end

function slot0._btnClick(slot0, slot1)
	slot2 = nil
	slot0._lastSelectLevel = slot0._currentSelectLevel

	if slot1 then
		slot2 = slot0._currentSelectLevel - 1 <= 0 and 1 or slot0._currentSelectLevel - 1
	elseif not slot0:_checkDifficultyUnlock(slot0._levelCount <= slot0._currentSelectLevel + 1 and slot0._levelCount or slot0._currentSelectLevel + 1) then
		GameFacade.showToast(ToastEnum.V1a6CachotToast01)

		return false
	end

	if slot0._currentSelectLevel == slot2 then
		return
	end

	slot0._currentSelectLevel = slot2

	if slot1 then
		slot0._selectIndex = slot0._selectIndex == slot0._selectIndex and 1 or 2
	else
		slot0._selectIndex = slot0._selectIndex == slot0._selectIndex and 2 or 1
	end

	slot0:_refreshItem(slot1)

	slot0.currentmask = slot0:_getTargetMask(slot0._lastSelectLevel)
	slot0.nextmask = slot0:_getTargetMask(slot0._currentSelectLevel)

	slot0:_playMaskAnimation()

	return true
end

function slot0._editableInitView(slot0)
	for slot4 = 1, 2 do
		slot0:_createLevelItem(slot4)
	end

	slot0._selectIndex = 1
end

function slot0.onOpen(slot0)
	slot5 = slot0
	slot4 = 1
	slot0._currentSelectLevel = PlayerPrefsHelper.getNumber(slot0._getPlayerPrefKeyDifficulty(slot5), slot4)
	slot0._levelCount = V1a6_CachotConfig.instance:getDifficultyCount()
	slot0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	slot0.unlocklevelcount = #slot0.stateMo.passDifficulty
	slot0._unlockCoList = {}

	for slot4, slot5 in pairs(lua_rogue_difficulty.configList) do
		if slot5.preDifficulty <= slot0.unlocklevelcount then
			table.insert(slot0._unlockCoList, slot5)
		end
	end

	if slot0._currentSelectLevel > #slot0._unlockCoList then
		slot0._currentSelectLevel = #slot0._unlockCoList
	end

	slot0:_refreshItem()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotDifficultyView, slot0._btncloseOnClick, slot0)
	slot0._animator:Play("open", 0, 0)
	slot0._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open)

	slot0.currentmask = slot0:_getTargetMask(slot0._currentSelectLevel)

	slot0:_playMaskAnimation()
end

function slot0.onOpenFinish(slot0)
	if slot0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true) then
		slot2 = slot1:GetEnumerator()

		while slot2:MoveNext() do
			slot2.Current.scrollSensitivity = 0
		end
	end
end

function slot0._createLevelItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.findChild(slot0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item" .. slot1)
	slot2.go = slot3
	slot2.termitem = gohelper.findChild(slot3, "main/#go_termitem")
	slot2.levelname = gohelper.findChildText(slot3, "main/#go_termitem/#txt_levelname")
	slot2.content = gohelper.findChild(slot3, "main/#go_termitem/#scroll_term/Viewport/Content")
	slot2.termcontent = gohelper.findChild(slot3, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent")
	slot2.gotermnode = gohelper.findChild(slot3, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent/termnode")
	slot2.txtenemy = gohelper.findChildText(slot2.content, "topnode/enemy/txt")
	slot2.txtscoreadd = gohelper.findChildText(slot2.content, "topnode/scoreadd/txt")
	slot2.golevel = gohelper.findChild(slot3, "main/#go_level")
	slot2.difficulty = gohelper.findChildText(slot3, "main/#go_level/#txt_level")
	slot2._gouptitle = gohelper.findChild(slot3, "#go_uptitle")
	slot2._txtuptitle = gohelper.findChildText(slot3, "#go_uptitle/node/#txt_term")
	slot2._txtuplevel = gohelper.findChildText(slot3, "#go_uptitle/#txt_level")
	slot2._godowntitle = gohelper.findChild(slot3, "#go_downtitle")
	slot2._txtdowntitle = gohelper.findChildText(slot3, "#go_downtitle/node/#txt_term")
	slot2._txtdownlevel = gohelper.findChildText(slot3, "#go_downtitle/#txt_level")
	slot2.transform = slot3.transform

	gohelper.setActive(slot3, true)
	table.insert(slot0._levelItemObjects, slot2)
end

function slot0._refreshItem(slot0, slot1)
	slot0:_refreshItemContent(slot0._levelItemObjects[slot0._selectIndex], V1a6_CachotConfig.instance:getDifficultyConfig(slot0._currentSelectLevel))

	slot4 = slot0._currentSelectLevel == 1
	slot5 = slot0._currentSelectLevel == slot0._levelCount

	if slot0._currentSelectLevel - 1 > 0 then
		slot6 = V1a6_CachotConfig.instance:getDifficultyConfig(slot0._currentSelectLevel - 1)
		slot3._txtuptitle.text = slot6.title
		slot3._txtuplevel.text = slot6.difficulty
	end

	if slot0._currentSelectLevel + 1 <= slot0._levelCount then
		slot6 = V1a6_CachotConfig.instance:getDifficultyConfig(slot0._currentSelectLevel + 1)
		slot3._txtdowntitle.text = slot6.title
		slot3._txtdownlevel.text = slot6.difficulty
	end

	gohelper.setActive(slot3._gouptitle, not slot4)
	gohelper.setActive(slot0._btnup, not slot4)
	gohelper.setActive(slot3._godowntitle, not slot5)
	gohelper.setActive(slot0._btndown, not slot5)

	slot0._btndowncanvasGroup = gohelper.onceAddComponent(slot0._btndown.gameObject, gohelper.Type_CanvasGroup)
	slot0._godowntitlecanvasGroup = gohelper.onceAddComponent(slot3._godowntitle, gohelper.Type_CanvasGroup)
	slot0._btndowncanvasGroup.alpha = not slot5 and not slot0:_checkDifficultyUnlock(slot0._currentSelectLevel + 1) and 0.3 or 1
	slot0._godowntitlecanvasGroup.alpha = not slot5 and not slot0:_checkDifficultyUnlock(slot0._currentSelectLevel + 1) and 0.3 or 1

	if slot0._lastSelectLevel then
		slot7 = nil

		slot0:_refreshItemContent(slot0._levelItemObjects[slot1 and (slot0._selectIndex == slot0._selectIndex and 2 or 1) or slot0._selectIndex == slot0._selectIndex and 1 or 2], V1a6_CachotConfig.instance:getDifficultyConfig(slot0._lastSelectLevel))
	end
end

function slot0._refreshItemContent(slot0, slot1, slot2)
	slot1.co = slot2
	slot1.termco = {}

	table.insert(slot1.termco, slot2.initHeroCount)

	if not string.nilorempty(slot2.effectDesc1) then
		table.insert(slot1.termco, slot2.effectDesc1)
	end

	if not string.nilorempty(slot2.effectDesc2) then
		table.insert(slot1.termco, slot2.effectDesc2)
	end

	if not string.nilorempty(slot2.effectDesc3) then
		table.insert(slot1.termco, slot2.effectDesc3)
	end

	slot1.difficulty.text = slot2.difficulty
	slot1.levelname.text = slot2.title
	slot1.txtenemy.text = "Lv." .. slot2.showDifficulty
	slot1.txtscoreadd.text = formatLuaLang("cachotdifficulty_scoreadd", slot2.scoreAdd / 10) .. "%"

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1.termco, slot1.termcontent, slot1.gotermnode)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform

	if slot3 == 1 then
		slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("cachotdifficulty_originrole")
		slot4:Find("num"):GetComponent(gohelper.Type_TextMesh).text = string.split(slot2, "|")[1]
	else
		if string.nilorempty(slot7[2]) then
			gohelper.setActive(slot6.gameObject, false)
		else
			gohelper.setActive(slot6.gameObject, true)
		end

		slot5.text = slot7[1]
		slot6.text = slot7[2]
	end
end

function slot0._reallyRefreshView(slot0)
	if slot0._currentSelectLevel then
		for slot4, slot5 in ipairs(slot0._levelItemObjects) do
			slot0:_refreshItem(slot5, slot0._currentSelectLevel == slot4)
		end
	end
end

function slot0._checkDifficultyUnlock(slot0, slot1)
	if slot1 <= #slot0._unlockCoList then
		return true
	end

	return false
end

function slot0._playMaskAnimation(slot0)
	if not slot0.currentmask then
		return
	end

	slot1 = nil

	if not slot0.nextmask and slot0.currentmask then
		slot0._maskanimator:Update(0)
		slot0._maskanimator:Play("level" .. slot0.currentmask, 0, 0)
	elseif slot0.currentmask and slot0.nextmask then
		slot0._maskanimator:Update(0)
		slot0._maskanimator:Play("level" .. slot0.currentmask .. "to" .. slot0.nextmask, 0, 0)
		TaskDispatcher.runDelay(slot0._switchAnimFinish, slot0, slot0._maskanimator:GetCurrentAnimatorStateInfo(0).length)
	end
end

function slot0._switchAnimFinish(slot0)
	TaskDispatcher.cancelTask(slot0._switchAnimFinish, slot0)
	slot0._maskanimator:Update(0)
	slot0._maskanimator:Play("level" .. slot0.nextmask, 0, 0)

	slot0.currentmask = slot0.nextmask
	slot0.nextmask = nil
end

function slot0._getTargetMask(slot0, slot1)
	if slot1 == 1 then
		return 1
	elseif slot1 == 2 then
		return 2
	elseif slot1 >= 3 then
		return 3
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._switchAnimFinish, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
