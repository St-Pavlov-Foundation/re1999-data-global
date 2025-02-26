module("modules.logic.character.view.CharacterDataCultureView", package.seeall)

slot0 = class("CharacterDataCultureView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simagecentericon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_centericon")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_mask")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_content")
	slot0._goconversation = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_conversation")
	slot0._gofirst = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_first")
	slot0._txtfirst = gohelper.findChildText(slot0.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	slot0._txtindenthelper = gohelper.findChildText(slot0.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "content/scrollview")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "content/#txt_title1")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "content/#txt_title2")
	slot0._txttitleen1 = gohelper.findChildText(slot0.viewGO, "content/#txt_titleen1")
	slot0._txttitleen3 = gohelper.findChildText(slot0.viewGO, "content/#txt_titleen3")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_pic")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/pageicon/#btn_next")
	slot0._btnprevious = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/pageicon/#btn_previous")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "content/#go_mask")
	slot0._goCustomRedIcon = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_customredicon")
	slot0._txtCustomContent = gohelper.findChildText(slot0.viewGO, "content/scrollview/viewport/content/#txt_customcontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnprevious:AddClickListener(slot0._btnpreviousOnClick, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onContentScrollValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnprevious:RemoveClickListener()
	slot0._scrollview:RemoveOnValueChanged()
end

function slot0._btnnextOnClick(slot0)
	if slot0._selectIndex and slot0._selectIndex ~= 0 then
		slot0:_itemOnClick(math.max(1, math.min(3, slot0._selectIndex + 1)))
	end
end

function slot0._btnpreviousOnClick(slot0)
	if slot0._selectIndex and slot0._selectIndex ~= 0 then
		slot0:_itemOnClick(math.max(1, math.min(3, slot0._selectIndex - 1)))
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))

	slot4 = "full/bg_noise2"

	slot0._simagemask:LoadImage(ResUrl.getCommonIcon(slot4))

	slot0._scrollcontent = gohelper.findChild(slot0._scrollview.gameObject, "viewport/content")
	slot0._items = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "content/container/go_item" .. slot4)
		slot5.index = slot4
		slot5.gochapteron = gohelper.findChild(slot5.go, "go_chapteron")
		slot5.gochapteroff = gohelper.findChild(slot5.go, "go_chapteroff")
		slot5.gotreasurebox = gohelper.findChild(slot5.go, "go_treasurebox")
		slot5.gochapterunlock = gohelper.findChild(slot5.go, "go_chapterunlock")
		slot5.txtunlockconditine = gohelper.findChildText(slot5.go, "go_chapterunlock/txt_unlockconditine")
		slot5.btn = SLFramework.UGUI.UIClickListener.Get(slot5.go)

		slot5.btn:AddClickListener(slot0._itemOnClick, slot0, slot5.index)
		table.insert(slot0._items, slot5)
	end

	slot0._txtcontent = slot0._gocontent:GetComponent(typeof(ZProj.CustomTMP))

	slot0._txtcontent:SetOffset(0, -13, false, true)
	slot0._txtcontent:SetSize(5)
	slot0._txtcontent:SetAlignment(0, -2)

	slot0._txtconversation = slot0._goconversation:GetComponent(typeof(ZProj.CustomTMP))

	slot0._txtconversation:SetOffset(0, -13, false, true)
	slot0._txtconversation:SetSize(5)
	slot0._txtconversation:SetAlignment(0, -2)

	slot0._scrollHeight = recthelper.getHeight(slot0._scrollview.transform)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, slot0._unlockItemCallbackFail, slot0)

	slot0._gofirstTran = slot0._gofirst.transform
	slot0._gofirstPosX, slot0._gofirstPosY = recthelper.getAnchor(slot0._gofirstTran)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, slot0._unlockItemCallback, slot0)
end

function slot0._itemOnClick(slot0, slot1)
	if slot0._selectIndex == slot1 then
		return
	end

	slot2 = CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, slot1)

	if slot0._items[slot1]._lock then
		slot4 = ""

		GameFacade.showToast(slot2.lockText, (string.splitToNumber(slot2.unlockConditine, "#")[1] ~= CharacterDataConfig.unlockConditionEpisodeID or DungeonConfig.instance:getEpisodeCO(slot3[2]).name) and (slot3[1] ~= CharacterDataConfig.unlockConditionRankID or {
			slot3[2] - 1
		}) and slot3[2])
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Ui_Role_Story_Switch)
		slot0:_refreshSelect(slot1)
		slot0:_refreshDesc(slot1)

		slot0._selectIndex = slot1
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function slot0._unlockItemCallback(slot0, slot1, slot2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if slot2 >= 5 then
		slot0:_refreshSelect(slot0._selectIndex)
	end
end

function slot0._unlockItemCallbackFail(slot0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0._refreshUI(slot0)
	if slot0._heroId and slot0._heroId == CharacterDataModel.instance:getCurHeroId() then
		slot0:_statEnd()
		slot0:_statStart()

		return
	end

	slot0._heroId = CharacterDataModel.instance:getCurHeroId()
	slot0.heroMo = HeroModel.instance:getByHeroId(slot0._heroId)

	slot0:_initInfo()
end

function slot0._initInfo(slot0)
	slot0._selectIndex = 0

	for slot4 = 1, 3 do
		slot6 = CharacterDataConfig.instance:checkLockCondition(CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, slot4))

		gohelper.setActive(slot0._items[slot4].golock, slot6)

		slot0._items[slot4]._lock = slot6

		if slot6 then
			slot8 = {}
			slot0._items[slot4].txtunlockconditine.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot5.lockText).tips, (string.splitToNumber(slot5.unlockConditine, "#")[1] ~= CharacterDataConfig.unlockConditionEpisodeID or {
				DungeonConfig.instance:getEpisodeCO(slot7[2]).name
			}) and (slot7[1] ~= CharacterDataConfig.unlockConditionRankID or {
				slot7[2] - 1
			}) and {
				slot7[2]
			})
		elseif slot0._selectIndex == 0 then
			slot0._selectIndex = slot4
		end
	end

	gohelper.setActive(slot0._btnnext.gameObject, slot0._selectIndex and slot0._selectIndex ~= 3)
	gohelper.setActive(slot0._btnprevious.gameObject, slot0._selectIndex and slot0._selectIndex ~= 1)
	slot0:_refreshSelect(slot0._selectIndex)
	slot0:_refreshDesc(slot0._selectIndex)
end

function slot0._refreshDesc(slot0, slot1)
	slot0:_statEnd()
	slot0:_statStart()

	if slot1 == 0 then
		gohelper.setActive(slot0._scrollview.gameObject, false)
		gohelper.setActive(slot0._txttitle1.gameObject, false)
		gohelper.setActive(slot0._txttitle2.gameObject, false)
		gohelper.setActive(slot0._txttitleen1.gameObject, false)
		gohelper.setActive(slot0._txttitleen3.gameObject, false)
		gohelper.setActive(slot0._txttitleen4.gameObject, false)
		gohelper.setActive(slot0._simagepic.gameObject, false)

		return
	end

	if slot0._items[slot1]._lock then
		return
	end

	slot0._config = CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, slot0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, slot1)
	slot3 = not string.nilorempty(slot0._config.title) and string.split(slot2, "\n") or {}
	slot0._txttitle1.text = slot3[1] or ""
	slot0._txttitle2.text = slot3[2] or ""

	gohelper.setActive(slot0._txttitleen1.gameObject, slot1 ~= 3 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN)
	gohelper.setActive(slot0._txttitleen3.gameObject, slot1 == 3)

	if slot1 == 3 then
		slot0._txttitleen3.text = "[UTTU" .. luaLang("multiple") .. tostring(HeroConfig.instance:getHeroCO(slot0._heroId).name) .. "]"
	else
		slot0._txttitleen1.text = slot0._config.titleEn
	end

	slot4 = slot3[2] and {
		-282.6,
		-134.5
	} or {
		-320,
		-151.3
	}

	recthelper.setAnchor(slot0._txttitle1.transform, slot4[1], slot4[2])
	recthelper.setAnchorY(slot0._txttitleen1.transform, slot3[2] and -216.5 or -181.5)
	gohelper.setActive(slot0._gocontent, slot1 ~= 3 and slot0._config.isCustom ~= 1)
	gohelper.setActive(slot0._gofirst, slot1 ~= 3 and slot0._config.isCustom ~= 1)
	gohelper.setActive(slot0._txtCustomContent.gameObject, slot0._config.isCustom == 1)
	gohelper.setActive(slot0._goconversation, slot1 == 3 and slot0._config.isCustom ~= 1)
	gohelper.setActive(slot0._goCustomRedIcon, false)

	if slot1 == 3 then
		slot6 = slot0:_getAfterContent(slot0._config.text)

		slot0._txtconversation:SetText(GameUtil.getMarkText(slot6), GameUtil.getMarkIndexList(slot6))
	elseif slot0._config.isCustom == 1 then
		slot0._txtCustomContent.text = slot5

		TaskDispatcher.runDelay(slot0._setCustomRedIconPos, slot0, 0.01)
	else
		slot0._txtfirst.text, slot7 = slot0:_getFormatStr(slot5)
		slot10 = slot0:_getFirstOffsetByLang()

		recthelper.setAnchor(slot0._gofirstTran, slot0._gofirstPosX + slot10.x, slot0._gofirstPosY + slot10.y)
		slot0._txtcontent:SetText(GameUtil.getMarkText(slot7), GameUtil.getMarkIndexList(slot7))
	end

	slot0._scrollview.verticalNormalizedPosition = 1

	if slot1 == 1 then
		slot0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu1.png"))
	elseif slot1 == 2 then
		slot0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu2.png"))
	else
		slot0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu3.png"))
	end

	gohelper.setActive(slot0._scrollview.gameObject, true)
	gohelper.setActive(slot0._txttitle1.gameObject, true)
	gohelper.setActive(slot0._txttitle2.gameObject, true)
	gohelper.setActive(slot0._simagepic.gameObject, true)
	ZProj.UGUIHelper.RebuildLayout(slot0._scrollcontent.transform)

	slot0._couldScroll = slot0._scrollHeight < recthelper.getHeight(slot0._scrollcontent.transform) and true or false

	gohelper.setActive(slot0._gomask, slot0._couldScroll)
end

function slot0._setCustomRedIconPos(slot0)
	gohelper.setActive(slot0._goCustomRedIcon, true)

	slot1 = slot0._txtCustomContent:GetTextInfo(slot0._config.text)
	slot4 = slot1.characterInfo[slot1.lineInfo[0].firstVisibleCharacterIndex]
	slot5 = slot4.bottomLeft
	slot8 = slot4.topRight
	slot0._goCustomRedIcon.transform.position = slot0._txtCustomContent.transform:TransformPoint((slot5.x + slot4.bottomRight.x) * 0.5, (slot5.y + slot4.topLeft.y) * 0.5, 0)
end

function slot0._refreshSelect(slot0, slot1)
	for slot5 = 1, 3 do
		gohelper.setActive(slot0._items[slot5].gochapteron, false)
		gohelper.setActive(slot0._items[slot5].gochapteroff, false)
		gohelper.setActive(slot0._items[slot5].gotreasurebox, false)
		gohelper.setActive(slot0._items[slot5].gochapterunlock, false)

		if slot5 == slot1 then
			gohelper.setActive(slot0._items[slot5].gochapteron, true)
			gohelper.setActive(slot0._btnnext.gameObject, slot1 ~= 3 and HeroModel.instance:checkGetRewards(slot0._heroId, slot5 == 3 and 4 + slot5 or 5 + slot5))
			gohelper.setActive(slot0._btnprevious.gameObject, slot1 ~= 1)

			if not HeroModel.instance:checkGetRewards(slot0._heroId, 4 + slot5) and not string.nilorempty(slot6.unlockRewards) then
				if CharacterDataConfig.instance:checkLockCondition(CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, slot0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, slot5)) then
					slot13 = ""

					GameFacade.showToast(slot6.lockText, (string.splitToNumber(slot6.unlockConditine, "#")[1] ~= CharacterDataConfig.unlockConditionEpisodeID or DungeonConfig.instance:getEpisodeCO(slot12[2]).name) and (slot12[1] == CharacterDataConfig.unlockConditionRankID and slot12[2] - 1 or slot12[2]))
				elseif not slot11 then
					UIBlockMgr.instance:startBlock("playRewardsAnimtion")
					UIBlockMgrExtend.setNeedCircleMv(false)
					HeroRpc.instance:sendItemUnlockRequest(slot0._heroId, slot6.id)
				end
			end
		elseif slot9 then
			gohelper.setActive(slot0._items[slot5].gochapterunlock, true)
		elseif slot11 or string.nilorempty(slot6.unlockRewards) then
			gohelper.setActive(slot0._items[slot5].gochapteroff, true)
		else
			gohelper.setActive(slot0._items[slot5].gotreasurebox, true)
		end
	end
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0.viewGO, false)
	slot0:_statEnd()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagecentericon:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()

	for slot4 = 1, 3 do
		slot0._items[slot4].btn:RemoveClickListener()
	end

	slot0._simagepic:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, slot0._unlockItemCallbackFail, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, slot0._unlockItemCallback, slot0)
	TaskDispatcher.cancelTask(slot0._setCustomRedIconPos, slot0)
end

function slot0._getFormatStr(slot0, slot1)
	if string.nilorempty(slot1) then
		return "", ""
	end

	slot2, slot3 = slot0.SwitchLangTab()

	if not string.nilorempty(string.match(string.gsub(slot1, "\n", "\n" .. string.rep(" ", slot2)), "^<.->.-<.->")) then
		slot6, slot7, slot8, slot9, slot10 = string.find(slot5, "(<.->)(.-)(<.->)")
		slot11 = string.format("%s%s%s", slot8, string.nilorempty(slot9) and "" or GameUtil.utf8sub(slot9, 1, 1), slot10)
		slot12 = ""

		if GameUtil.utf8len(slot9) >= 2 then
			slot12 = string.format("%s%s%s", slot8, GameUtil.utf8sub(slot9, 2, GameUtil.utf8len(slot9) - 1), slot10)
		end

		return slot11, string.format("<size=28><space=2.82em></size> %s", slot12 .. string.gsub(slot1, "^<.->.-<.->", ""))
	else
		slot6 = GameUtil.utf8sub(slot1, 1, 1)
		slot7 = ""

		if GameUtil.utf8len(slot1) >= 2 then
			slot7 = string.format("<size=28><space=%fem></size> %s", slot3, GameUtil.utf8sub(slot1, 2, GameUtil.utf8len(slot1) - 1))
		end

		return slot6, slot7
	end
end

function slot0.SwitchLangTab(slot0)
	if ({
		cn = function ()
			uv0 = 6
			uv1 = 2.75
		end,
		en = function ()
			uv0 = 6
			uv1 = 1.83
		end,
		jp = function ()
			uv0 = 4
			uv1 = 1.63
		end,
		kr = function ()
			uv0 = 3
			uv1 = 1.63
		end
	})[LangSettings.instance:getCurLangShortcut()] then
		slot4()

		return nil, 
	else
		return 6, 2.75
	end
end

function slot0._getFirstOffsetByLang(slot0)
	return ({
		kr = {
			x = -31,
			y = 0
		}
	})[LangSettings.instance:getCurLangShortcut()] or {
		x = 0,
		y = 0
	}
end

function slot0._getAfterContent(slot0, slot1)
	slot2 = {}
	slot3 = nil
	slot7 = "\n"

	for slot7, slot8 in ipairs(string.split(string.gsub(slot1, "：", ":"), slot7)) do
		if string.split(slot8, ":") and #slot3 >= 2 and not tabletool.indexOf(slot2, slot3[1]) then
			table.insert(slot2, string.gsub(slot3[1], "%-", "%%-"))
		end
	end

	slot5 = nil

	for slot9, slot10 in ipairs(slot2) do
		if 0 < SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtindenthelper, string.gsub(slot10, "<[^<>][^<>]->", "")) then
			slot4 = slot5
		end
	end

	table.insert({}, string.gsub(slot6.name, "%-", "%%-") .. ":")
	table.insert({}, string.format("<indent=0%%%%><color=#943308><b><cspace=%d>%s</cspace></b></color>：</indent><indent=%d%%%%>", GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and -7 or 0, slot6.name, math.max(slot4, SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtindenthelper, HeroConfig.instance:getHeroCO(slot0._heroId).name)) / 28 * (GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and 3.5 or 5) + 3))

	for slot16, slot17 in ipairs(slot2) do
		table.insert(slot9, slot17 .. ":")
		table.insert(slot10, string.format("<indent=0%%%%><color=#352725><b><cspace=%d>%s</cspace></b></color>:</indent><indent=%d%%%%>", slot11, slot17, slot5))
	end

	for slot16 = 1, #slot9 do
		slot1 = string.gsub(slot1, slot9[slot16], slot10[slot16])
	end

	if GameConfig:GetCurLangType() == LangSettings.jp then
		slot1 = string.gsub(string.gsub(slot1, ":", ""), "：", "")
	elseif GameConfig:GetCurLangType() == LangSettings.en then
		slot1 = string.gsub(slot1, "：", ":")
	end

	return slot1
end

function slot0._statStart(slot0)
	slot0._viewTime = ServerTime.now()
end

function slot0._statEnd(slot0)
	if not slot0._heroId then
		return
	end

	if slot0._viewTime then
		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroCulture, slot0._heroId, slot0._config and slot0._config.id, ServerTime.now() - slot0._viewTime, slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.fromHandbookView)
	end

	slot0._viewTime = nil
end

function slot0._onContentScrollValueChanged(slot0, slot1)
	gohelper.setActive(slot0._gomask, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) > 0)
end

return slot0
