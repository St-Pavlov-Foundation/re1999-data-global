module("modules.logic.character.view.CharacterDataCultureView", package.seeall)

local var_0_0 = class("CharacterDataCultureView", BaseView)

function var_0_0._getFormatStr_overseas(arg_1_0, arg_1_1)
	if string.nilorempty(arg_1_1) then
		return "", ""
	end

	local var_1_0 = LangSettings.instance:isZh() or LangSettings.instance:isTw()

	GameUtil.setActive01(arg_1_0._gofirstTran, var_1_0)

	if var_1_0 then
		return arg_1_0:_getFormatStr(arg_1_1)
	else
		local var_1_1, var_1_2 = arg_1_0:SwitchLangTab()
		local var_1_3 = string.rep(" ", var_1_1)
		local var_1_4 = "\n" .. var_1_3

		arg_1_1 = var_1_3 .. string.gsub(arg_1_1, "\n", var_1_4)

		return "", arg_1_1
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_bg")
	arg_2_0._simagecentericon = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_centericon")
	arg_2_0._simagelefticon = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_lefticon")
	arg_2_0._simagerighticon = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_righticon")
	arg_2_0._simagerighticon2 = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_righticon2")
	arg_2_0._simagemask = gohelper.findChildSingleImage(arg_2_0.viewGO, "bg/#simage_mask")
	arg_2_0._gocontent = gohelper.findChild(arg_2_0.viewGO, "content/scrollview/viewport/content/#go_content")
	arg_2_0._goconversation = gohelper.findChild(arg_2_0.viewGO, "content/scrollview/viewport/content/#go_conversation")
	arg_2_0._gofirst = gohelper.findChild(arg_2_0.viewGO, "content/scrollview/viewport/content/#go_first")
	arg_2_0._txtfirst = gohelper.findChildText(arg_2_0.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	arg_2_0._txtindenthelper = gohelper.findChildText(arg_2_0.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	arg_2_0._scrollview = gohelper.findChildScrollRect(arg_2_0.viewGO, "content/scrollview")
	arg_2_0._txttitle1 = gohelper.findChildText(arg_2_0.viewGO, "content/#txt_title1")
	arg_2_0._txttitle2 = gohelper.findChildText(arg_2_0.viewGO, "content/#txt_title2")
	arg_2_0._txttitleen1 = gohelper.findChildText(arg_2_0.viewGO, "content/#txt_titleen1")
	arg_2_0._txttitleen3 = gohelper.findChildText(arg_2_0.viewGO, "content/#txt_titleen3")
	arg_2_0._simagepic = gohelper.findChildSingleImage(arg_2_0.viewGO, "content/#simage_pic")
	arg_2_0._btnnext = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "content/pageicon/#btn_next")
	arg_2_0._btnprevious = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "content/pageicon/#btn_previous")
	arg_2_0._gomask = gohelper.findChild(arg_2_0.viewGO, "content/#go_mask")
	arg_2_0._goCustomRedIcon = gohelper.findChild(arg_2_0.viewGO, "content/scrollview/viewport/content/#go_customredicon")
	arg_2_0._txtCustomContent = gohelper.findChildText(arg_2_0.viewGO, "content/scrollview/viewport/content/#txt_customcontent")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnnext:AddClickListener(arg_3_0._btnnextOnClick, arg_3_0)
	arg_3_0._btnprevious:AddClickListener(arg_3_0._btnpreviousOnClick, arg_3_0)
	arg_3_0._scrollview:AddOnValueChanged(arg_3_0._onContentScrollValueChanged, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnnext:RemoveClickListener()
	arg_4_0._btnprevious:RemoveClickListener()
	arg_4_0._scrollview:RemoveOnValueChanged()
end

function var_0_0._btnnextOnClick(arg_5_0)
	if arg_5_0._selectIndex and arg_5_0._selectIndex ~= 0 then
		arg_5_0:_itemOnClick(math.max(1, math.min(3, arg_5_0._selectIndex + 1)))
	end
end

function var_0_0._btnpreviousOnClick(arg_6_0)
	if arg_6_0._selectIndex and arg_6_0._selectIndex ~= 0 then
		arg_6_0:_itemOnClick(math.max(1, math.min(3, arg_6_0._selectIndex - 1)))
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_7_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	arg_7_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_7_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_7_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	arg_7_0._scrollcontent = gohelper.findChild(arg_7_0._scrollview.gameObject, "viewport/content")
	arg_7_0._items = {}

	for iter_7_0 = 1, 3 do
		local var_7_0 = arg_7_0:getUserDataTb_()

		var_7_0.go = gohelper.findChild(arg_7_0.viewGO, "content/container/go_item" .. iter_7_0)
		var_7_0.index = iter_7_0
		var_7_0.gochapteron = gohelper.findChild(var_7_0.go, "go_chapteron")
		var_7_0.gochapteroff = gohelper.findChild(var_7_0.go, "go_chapteroff")
		var_7_0.gotreasurebox = gohelper.findChild(var_7_0.go, "go_treasurebox")
		var_7_0.gochapterunlock = gohelper.findChild(var_7_0.go, "go_chapterunlock")
		var_7_0.txtunlockconditine = gohelper.findChildText(var_7_0.go, "go_chapterunlock/txt_unlockconditine")
		var_7_0.btn = SLFramework.UGUI.UIClickListener.Get(var_7_0.go)

		var_7_0.btn:AddClickListener(arg_7_0._itemOnClick, arg_7_0, var_7_0.index)
		table.insert(arg_7_0._items, var_7_0)
	end

	arg_7_0._txtcontent = arg_7_0._gocontent:GetComponent(typeof(ZProj.CustomTMP))

	arg_7_0._txtcontent:SetOffset(0, -13, false, true)
	arg_7_0._txtcontent:SetSize(5)
	arg_7_0._txtcontent:SetAlignment(0, -2)

	arg_7_0._txtconversation = arg_7_0._goconversation:GetComponent(typeof(ZProj.CustomTMP))

	arg_7_0._txtconversation:SetOffset(0, -13, false, true)
	arg_7_0._txtconversation:SetSize(5)
	arg_7_0._txtconversation:SetAlignment(0, -2)

	arg_7_0._scrollHeight = recthelper.getHeight(arg_7_0._scrollview.transform)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_7_0._unlockItemCallbackFail, arg_7_0)

	arg_7_0._gofirstTran = arg_7_0._gofirst.transform
	arg_7_0._gofirstPosX, arg_7_0._gofirstPosY = recthelper.getAnchor(arg_7_0._gofirstTran)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, arg_7_0._unlockItemCallback, arg_7_0)
end

function var_0_0._itemOnClick(arg_8_0, arg_8_1)
	if arg_8_0._selectIndex == arg_8_1 then
		return
	end

	local var_8_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_8_0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, arg_8_1)

	if arg_8_0._items[arg_8_1]._lock then
		local var_8_1 = string.splitToNumber(var_8_0.unlockConditine, "#")
		local var_8_2 = ""

		if var_8_1[1] == CharacterDataConfig.unlockConditionEpisodeID then
			var_8_2 = DungeonConfig.instance:getEpisodeCO(var_8_1[2]).name
		elseif var_8_1[1] == CharacterDataConfig.unlockConditionRankID then
			var_8_2 = {
				var_8_1[2] - 1
			}
		else
			var_8_2 = var_8_1[2]
		end

		GameFacade.showToast(var_8_0.lockText, var_8_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Ui_Role_Story_Switch)
		arg_8_0:_refreshSelect(arg_8_1)
		arg_8_0:_refreshDesc(arg_8_1)

		arg_8_0._selectIndex = arg_8_1
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshUI()
end

function var_0_0.onOpen(arg_10_0)
	gohelper.setActive(arg_10_0.viewGO, true)
	arg_10_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function var_0_0._unlockItemCallback(arg_11_0, arg_11_1, arg_11_2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_11_2 >= 5 then
		arg_11_0:_refreshSelect(arg_11_0._selectIndex)
	end
end

function var_0_0._unlockItemCallbackFail(arg_12_0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0._refreshUI(arg_13_0)
	if arg_13_0._heroId and arg_13_0._heroId == CharacterDataModel.instance:getCurHeroId() then
		arg_13_0:_statEnd()
		arg_13_0:_statStart()

		return
	end

	arg_13_0._heroId = CharacterDataModel.instance:getCurHeroId()
	arg_13_0.heroMo = HeroModel.instance:getByHeroId(arg_13_0._heroId)

	arg_13_0:_initInfo()
end

function var_0_0._initInfo(arg_14_0)
	arg_14_0._selectIndex = 0

	for iter_14_0 = 1, 3 do
		local var_14_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_14_0._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, iter_14_0)
		local var_14_1 = CharacterDataConfig.instance:checkLockCondition(var_14_0)

		gohelper.setActive(arg_14_0._items[iter_14_0].golock, var_14_1)

		arg_14_0._items[iter_14_0]._lock = var_14_1

		if var_14_1 then
			local var_14_2 = string.splitToNumber(var_14_0.unlockConditine, "#")
			local var_14_3 = {}

			if var_14_2[1] == CharacterDataConfig.unlockConditionEpisodeID then
				var_14_3 = {
					DungeonConfig.instance:getEpisodeCO(var_14_2[2]).name
				}
			elseif var_14_2[1] == CharacterDataConfig.unlockConditionRankID then
				var_14_3 = {
					var_14_2[2] - 1
				}
			else
				var_14_3 = {
					var_14_2[2]
				}
			end

			local var_14_4 = ToastConfig.instance:getToastCO(var_14_0.lockText).tips
			local var_14_5 = GameUtil.getSubPlaceholderLuaLang(var_14_4, var_14_3)

			arg_14_0._items[iter_14_0].txtunlockconditine.text = var_14_5
		elseif arg_14_0._selectIndex == 0 then
			arg_14_0._selectIndex = iter_14_0
		end
	end

	gohelper.setActive(arg_14_0._btnnext.gameObject, arg_14_0._selectIndex and arg_14_0._selectIndex ~= 3)
	gohelper.setActive(arg_14_0._btnprevious.gameObject, arg_14_0._selectIndex and arg_14_0._selectIndex ~= 1)
	arg_14_0:_refreshSelect(arg_14_0._selectIndex)
	arg_14_0:_refreshDesc(arg_14_0._selectIndex)
end

function var_0_0._refreshDesc(arg_15_0, arg_15_1)
	arg_15_0:_statEnd()
	arg_15_0:_statStart()

	if arg_15_1 == 0 then
		gohelper.setActive(arg_15_0._scrollview.gameObject, false)
		gohelper.setActive(arg_15_0._txttitle1.gameObject, false)
		gohelper.setActive(arg_15_0._txttitle2.gameObject, false)
		gohelper.setActive(arg_15_0._txttitleen1.gameObject, false)
		gohelper.setActive(arg_15_0._txttitleen3.gameObject, false)
		gohelper.setActive(arg_15_0._txttitleen4.gameObject, false)
		gohelper.setActive(arg_15_0._simagepic.gameObject, false)

		return
	end

	if arg_15_0._items[arg_15_1]._lock then
		return
	end

	arg_15_0._config = CharacterDataConfig.instance:getCharacterDataCO(arg_15_0._heroId, arg_15_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, arg_15_1)

	local var_15_0 = arg_15_0._config.title
	local var_15_1 = not string.nilorempty(var_15_0) and string.split(var_15_0, "\n") or {}

	arg_15_0._txttitle1.text = var_15_1[1] or ""
	arg_15_0._txttitle2.text = var_15_1[2] or ""

	gohelper.setActive(arg_15_0._txttitleen1.gameObject, arg_15_1 ~= 3 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN)
	gohelper.setActive(arg_15_0._txttitleen3.gameObject, arg_15_1 == 3)

	if arg_15_1 == 3 then
		local var_15_2 = HeroConfig.instance:getHeroCO(arg_15_0._heroId)

		arg_15_0._txttitleen3.text = "[UTTU" .. luaLang("multiple") .. tostring(var_15_2.name) .. "]"
	else
		arg_15_0._txttitleen1.text = arg_15_0._config.titleEn
	end

	local var_15_3 = var_15_1[2] and {
		-282.6,
		-134.5
	} or {
		-320,
		-151.3
	}

	recthelper.setAnchor(arg_15_0._txttitle1.transform, var_15_3[1], var_15_3[2])
	recthelper.setAnchorY(arg_15_0._txttitleen1.transform, var_15_1[2] and -216.5 or -181.5)
	gohelper.setActive(arg_15_0._gocontent, arg_15_1 ~= 3 and arg_15_0._config.isCustom ~= 1)
	gohelper.setActive(arg_15_0._gofirst, arg_15_1 ~= 3 and arg_15_0._config.isCustom ~= 1)
	gohelper.setActive(arg_15_0._txtCustomContent.gameObject, arg_15_0._config.isCustom == 1)
	gohelper.setActive(arg_15_0._goconversation, arg_15_1 == 3 and arg_15_0._config.isCustom ~= 1)
	gohelper.setActive(arg_15_0._goCustomRedIcon, false)

	local var_15_4 = arg_15_0._config.text

	if arg_15_1 == 3 then
		local var_15_5 = arg_15_0:_getAfterContent(var_15_4)
		local var_15_6 = GameUtil.getMarkText(var_15_5)
		local var_15_7 = GameUtil.getMarkIndexList(var_15_5)

		arg_15_0._txtconversation:SetText(var_15_6, var_15_7)
	elseif arg_15_0._config.isCustom == 1 then
		arg_15_0._txtCustomContent.text = var_15_4

		TaskDispatcher.runDelay(arg_15_0._setCustomRedIconPos, arg_15_0, 0.01)
	else
		local var_15_8, var_15_9 = arg_15_0:_getFormatStr_overseas(var_15_4)
		local var_15_10 = GameUtil.getMarkText(var_15_9)
		local var_15_11 = GameUtil.getMarkIndexList(var_15_9)
		local var_15_12 = arg_15_0:_getFirstOffsetByLang()

		recthelper.setAnchor(arg_15_0._gofirstTran, arg_15_0._gofirstPosX + var_15_12.x, arg_15_0._gofirstPosY + var_15_12.y)

		arg_15_0._txtfirst.text = var_15_8

		arg_15_0._txtfirst:ForceMeshUpdate(true, true)
		arg_15_0._txtfirst:GetRenderedValues()
		arg_15_0._txtcontent:SetText(var_15_10, var_15_11)
	end

	arg_15_0._scrollview.verticalNormalizedPosition = 1

	if arg_15_1 == 1 then
		arg_15_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu1.png"))
	elseif arg_15_1 == 2 then
		arg_15_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu2.png"))
	else
		arg_15_0._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu3.png"))
	end

	gohelper.setActive(arg_15_0._scrollview.gameObject, true)
	gohelper.setActive(arg_15_0._txttitle1.gameObject, true)
	gohelper.setActive(arg_15_0._txttitle2.gameObject, true)
	gohelper.setActive(arg_15_0._simagepic.gameObject, true)
	ZProj.UGUIHelper.RebuildLayout(arg_15_0._scrollcontent.transform)

	arg_15_0._couldScroll = recthelper.getHeight(arg_15_0._scrollcontent.transform) > arg_15_0._scrollHeight and true or false

	gohelper.setActive(arg_15_0._gomask, arg_15_0._couldScroll)
end

function var_0_0._setCustomRedIconPos(arg_16_0)
	gohelper.setActive(arg_16_0._goCustomRedIcon, true)

	local var_16_0 = arg_16_0._txtCustomContent:GetTextInfo(arg_16_0._config.text)
	local var_16_1 = var_16_0.characterInfo[var_16_0.lineInfo[0].firstVisibleCharacterIndex]
	local var_16_2 = var_16_1.bottomLeft
	local var_16_3 = var_16_1.topLeft
	local var_16_4 = var_16_1.bottomRight
	local var_16_5 = var_16_1.topRight
	local var_16_6 = (var_16_2.x + var_16_4.x) * 0.5
	local var_16_7 = (var_16_2.y + var_16_3.y) * 0.5
	local var_16_8 = arg_16_0._txtCustomContent.transform:TransformPoint(var_16_6, var_16_7, 0)

	arg_16_0._goCustomRedIcon.transform.position = var_16_8
end

function var_0_0._refreshSelect(arg_17_0, arg_17_1)
	for iter_17_0 = 1, 3 do
		gohelper.setActive(arg_17_0._items[iter_17_0].gochapteron, false)
		gohelper.setActive(arg_17_0._items[iter_17_0].gochapteroff, false)
		gohelper.setActive(arg_17_0._items[iter_17_0].gotreasurebox, false)
		gohelper.setActive(arg_17_0._items[iter_17_0].gochapterunlock, false)

		local var_17_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_17_0._heroId, arg_17_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, iter_17_0)
		local var_17_1 = iter_17_0 == 3 and 4 + iter_17_0 or 5 + iter_17_0
		local var_17_2 = iter_17_0 == arg_17_1
		local var_17_3 = CharacterDataConfig.instance:checkLockCondition(var_17_0)
		local var_17_4 = HeroModel.instance:checkGetRewards(arg_17_0._heroId, var_17_1)
		local var_17_5 = HeroModel.instance:checkGetRewards(arg_17_0._heroId, 4 + iter_17_0)

		if var_17_2 then
			gohelper.setActive(arg_17_0._items[iter_17_0].gochapteron, true)
			gohelper.setActive(arg_17_0._btnnext.gameObject, arg_17_1 ~= 3 and var_17_4)
			gohelper.setActive(arg_17_0._btnprevious.gameObject, arg_17_1 ~= 1)

			if not var_17_5 and not string.nilorempty(var_17_0.unlockRewards) then
				if var_17_3 then
					local var_17_6 = string.splitToNumber(var_17_0.unlockConditine, "#")
					local var_17_7 = ""

					if var_17_6[1] == CharacterDataConfig.unlockConditionEpisodeID then
						var_17_7 = DungeonConfig.instance:getEpisodeCO(var_17_6[2]).name
					elseif var_17_6[1] == CharacterDataConfig.unlockConditionRankID then
						var_17_7 = var_17_6[2] - 1
					else
						var_17_7 = var_17_6[2]
					end

					GameFacade.showToast(var_17_0.lockText, var_17_7)
				elseif not var_17_5 then
					UIBlockMgr.instance:startBlock("playRewardsAnimtion")
					UIBlockMgrExtend.setNeedCircleMv(false)
					HeroRpc.instance:sendItemUnlockRequest(arg_17_0._heroId, var_17_0.id)
				end
			end
		elseif var_17_3 then
			gohelper.setActive(arg_17_0._items[iter_17_0].gochapterunlock, true)
		elseif var_17_5 or string.nilorempty(var_17_0.unlockRewards) then
			gohelper.setActive(arg_17_0._items[iter_17_0].gochapteroff, true)
		else
			gohelper.setActive(arg_17_0._items[iter_17_0].gotreasurebox, true)
		end
	end
end

function var_0_0.onClose(arg_18_0)
	gohelper.setActive(arg_18_0.viewGO, false)
	arg_18_0:_statEnd()
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simagebg:UnLoadImage()
	arg_19_0._simagecentericon:UnLoadImage()
	arg_19_0._simagelefticon:UnLoadImage()
	arg_19_0._simagerighticon:UnLoadImage()
	arg_19_0._simagerighticon2:UnLoadImage()
	arg_19_0._simagemask:UnLoadImage()

	for iter_19_0 = 1, 3 do
		arg_19_0._items[iter_19_0].btn:RemoveClickListener()
	end

	arg_19_0._simagepic:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_19_0._unlockItemCallbackFail, arg_19_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, arg_19_0._unlockItemCallback, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._setCustomRedIconPos, arg_19_0)
end

function var_0_0._getFormatStr(arg_20_0, arg_20_1)
	if string.nilorempty(arg_20_1) then
		return "", ""
	end

	local var_20_0, var_20_1 = arg_20_0.SwitchLangTab()
	local var_20_2 = "\n" .. string.rep(" ", var_20_0)
	local var_20_3 = arg_20_1
	local var_20_4 = string.gsub(var_20_3, "<.->", "")
	local var_20_5 = string.trim(var_20_4)
	local var_20_6 = utf8.next(var_20_5, 1)
	local var_20_7 = var_20_5:sub(1, var_20_6 - 1)
	local var_20_8 = string.gsub(arg_20_1, var_20_7, "", 1)

	return var_20_7, string.format("<size=28><space=%fem></size> %s", var_20_1, var_20_8)
end

function var_0_0.SwitchLangTab(arg_21_0)
	local var_21_0
	local var_21_1
	local var_21_2 = ({
		cn = function()
			var_21_0 = 6
			var_21_1 = 2.75
		end,
		en = function()
			var_21_0 = 6
			var_21_1 = 1.83
		end,
		jp = function()
			var_21_0 = 4
			var_21_1 = 1.63
		end,
		kr = function()
			var_21_0 = 3
			var_21_1 = 1.63
		end
	})[LangSettings.instance:getCurLangShortcut()]

	if var_21_2 then
		var_21_2()

		return var_21_0, var_21_1
	else
		return 6, 2.75
	end
end

function var_0_0._getFirstOffsetByLang(arg_26_0)
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

function var_0_0._getAfterContent(arg_27_0, arg_27_1)
	arg_27_1 = string.gsub(arg_27_1, "：", ":")

	local var_27_0 = {}
	local var_27_1

	for iter_27_0, iter_27_1 in ipairs(string.split(arg_27_1, "\n")) do
		local var_27_2 = string.split(iter_27_1, ":")

		if var_27_2 and #var_27_2 >= 2 and not tabletool.indexOf(var_27_0, var_27_2[1]) then
			local var_27_3 = var_27_2[1]
			local var_27_4 = string.gsub(var_27_3, "%-", "%%-")

			table.insert(var_27_0, var_27_4)
		end
	end

	local var_27_5 = 0
	local var_27_6

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		local var_27_7 = string.gsub(iter_27_3, "<[^<>][^<>]->", "")
		local var_27_8 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_27_0._txtindenthelper, var_27_7)

		if var_27_5 < var_27_8 then
			var_27_5 = var_27_8
		end
	end

	local var_27_9 = HeroConfig.instance:getHeroCO(arg_27_0._heroId)
	local var_27_10 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_27_0._txtindenthelper, var_27_9.name)
	local var_27_11 = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and 3.5 or 5
	local var_27_12 = math.max(var_27_5, var_27_10) / 28 * var_27_11 + 3
	local var_27_13 = {}
	local var_27_14 = {}
	local var_27_15 = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and -7 or 0
	local var_27_16 = var_27_9.name
	local var_27_17 = string.gsub(var_27_16, "%-", "%%-")

	table.insert(var_27_13, var_27_17 .. ":")
	table.insert(var_27_14, string.format("<indent=0%%%%><color=#943308><b><cspace=%d>%s</cspace></b></color>：</indent><indent=%d%%%%>", var_27_15, var_27_9.name, var_27_12))

	for iter_27_4, iter_27_5 in ipairs(var_27_0) do
		table.insert(var_27_13, iter_27_5 .. ":")
		table.insert(var_27_14, string.format("<indent=0%%%%><color=#352725><b><cspace=%d>%s</cspace></b></color>:</indent><indent=%d%%%%>", var_27_15, iter_27_5, var_27_12))
	end

	for iter_27_6 = 1, #var_27_13 do
		arg_27_1 = string.gsub(arg_27_1, var_27_13[iter_27_6], var_27_14[iter_27_6])
	end

	if GameConfig:GetCurLangType() == LangSettings.jp then
		arg_27_1 = string.gsub(arg_27_1, ":", "")
		arg_27_1 = string.gsub(arg_27_1, "：", "")
	elseif GameConfig:GetCurLangType() == LangSettings.en then
		arg_27_1 = string.gsub(arg_27_1, "：", ":")
	end

	return arg_27_1
end

function var_0_0._statStart(arg_28_0)
	arg_28_0._viewTime = ServerTime.now()
end

function var_0_0._statEnd(arg_29_0)
	if not arg_29_0._heroId then
		return
	end

	if arg_29_0._viewTime then
		local var_29_0 = ServerTime.now() - arg_29_0._viewTime
		local var_29_1 = arg_29_0.viewParam and type(arg_29_0.viewParam) == "table" and arg_29_0.viewParam.fromHandbookView

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroCulture, arg_29_0._heroId, arg_29_0._config and arg_29_0._config.id, var_29_0, var_29_1)
	end

	arg_29_0._viewTime = nil
end

function var_0_0._onContentScrollValueChanged(arg_30_0, arg_30_1)
	gohelper.setActive(arg_30_0._gomask, arg_30_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_30_0._scrollview.verticalNormalizedPosition) <= 0))
end

return var_0_0
