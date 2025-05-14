module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotDifficultyView", package.seeall)

local var_0_0 = class("V1a6_CachotDifficultyView", BaseView)
local var_0_1 = 1
local var_0_2 = -1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goredmask = gohelper.findChild(arg_1_0.viewGO, "redmask")
	arg_1_0._maskanimator = arg_1_0._goredmask:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gotipswindow = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow")
	arg_1_0._txtlevelname = gohelper.findChildText(arg_1_0.viewGO, "#go_tipswindow/bg/#txt_levelname")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_next")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tipswindow/#go_next/#btn_next")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tipswindow/#scroll_view")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_level")
	arg_1_0._scrolllevel = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_tipswindow/#go_level/#scroll_level")
	arg_1_0._golevelContent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item")
	arg_1_0._btnup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tipswindow/#go_level/#btn_up")
	arg_1_0._btndown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tipswindow/#go_level/#btn_down")
	arg_1_0._gopreview = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_preview")
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_left")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#simage_left/#txt_name")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._levelItemObjects = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnup:AddClickListener(arg_2_0._btnupOnClick, arg_2_0)
	arg_2_0._btndown:AddClickListener(arg_2_0._btndownOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnup:RemoveClickListener()
	arg_3_0._btndown:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
	V1a6_CachotController.instance:openV1a6_CachotMainView()
end

function var_0_0._btnnextOnClick(arg_5_0)
	if not arg_5_0._currentSelectLevel then
		logError("V1a6_CachotDifficultyView selectlevel is nil")

		return
	end

	PlayerPrefsHelper.setNumber(arg_5_0:_getPlayerPrefKeyDifficulty(), arg_5_0._currentSelectLevel)
	V1a6_CachotController.instance:openV1a6_CachotTeamView({
		isInitSelect = true,
		selectLevel = arg_5_0._currentSelectLevel
	})
end

function var_0_0._getPlayerPrefKeyDifficulty(arg_6_0)
	return PlayerPrefsKey.Version1_6V1a6_CachotDifficulty .. PlayerModel.instance:getPlayinfo().userId
end

function var_0_0._btnupOnClick(arg_7_0)
	if arg_7_0:_btnClick(true) then
		arg_7_0._animator:Update(0)
		arg_7_0._animator:Play("down", 0, 0)
	end
end

function var_0_0._btndownOnClick(arg_8_0)
	if arg_8_0:_btnClick(false) then
		arg_8_0._animator:Update(0)
		arg_8_0._animator:Play("up", 0, 0)
	end
end

function var_0_0._btnClick(arg_9_0, arg_9_1)
	local var_9_0

	arg_9_0._lastSelectLevel = arg_9_0._currentSelectLevel

	if arg_9_1 then
		var_9_0 = arg_9_0._currentSelectLevel - 1 <= 0 and 1 or arg_9_0._currentSelectLevel - 1
	else
		var_9_0 = arg_9_0._currentSelectLevel + 1 >= arg_9_0._levelCount and arg_9_0._levelCount or arg_9_0._currentSelectLevel + 1

		if not arg_9_0:_checkDifficultyUnlock(var_9_0) then
			GameFacade.showToast(ToastEnum.V1a6CachotToast01)

			return false
		end
	end

	if arg_9_0._currentSelectLevel == var_9_0 then
		return
	end

	arg_9_0._currentSelectLevel = var_9_0

	if arg_9_1 then
		arg_9_0._selectIndex = arg_9_0._selectIndex == arg_9_0._selectIndex and 1 or 2
	else
		arg_9_0._selectIndex = arg_9_0._selectIndex == arg_9_0._selectIndex and 2 or 1
	end

	arg_9_0:_refreshItem(arg_9_1)

	arg_9_0.currentmask = arg_9_0:_getTargetMask(arg_9_0._lastSelectLevel)
	arg_9_0.nextmask = arg_9_0:_getTargetMask(arg_9_0._currentSelectLevel)

	arg_9_0:_playMaskAnimation()

	return true
end

function var_0_0._editableInitView(arg_10_0)
	for iter_10_0 = 1, 2 do
		arg_10_0:_createLevelItem(iter_10_0)
	end

	arg_10_0._selectIndex = 1
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._currentSelectLevel = PlayerPrefsHelper.getNumber(arg_11_0:_getPlayerPrefKeyDifficulty(), 1)
	arg_11_0._levelCount = V1a6_CachotConfig.instance:getDifficultyCount()
	arg_11_0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	arg_11_0.unlocklevelcount = #arg_11_0.stateMo.passDifficulty
	arg_11_0._unlockCoList = {}

	for iter_11_0, iter_11_1 in pairs(lua_rogue_difficulty.configList) do
		if arg_11_0.unlocklevelcount >= iter_11_1.preDifficulty then
			table.insert(arg_11_0._unlockCoList, iter_11_1)
		end
	end

	if arg_11_0._currentSelectLevel > #arg_11_0._unlockCoList then
		arg_11_0._currentSelectLevel = #arg_11_0._unlockCoList
	end

	arg_11_0:_refreshItem()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotDifficultyView, arg_11_0._btncloseOnClick, arg_11_0)
	arg_11_0._animator:Play("open", 0, 0)
	arg_11_0._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open)

	arg_11_0.currentmask = arg_11_0:_getTargetMask(arg_11_0._currentSelectLevel)

	arg_11_0:_playMaskAnimation()
end

function var_0_0.onOpenFinish(arg_12_0)
	local var_12_0 = arg_12_0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true)

	if var_12_0 then
		local var_12_1 = var_12_0:GetEnumerator()

		while var_12_1:MoveNext() do
			var_12_1.Current.scrollSensitivity = 0
		end
	end
end

function var_0_0._createLevelItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()
	local var_13_1 = gohelper.findChild(arg_13_0.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item" .. arg_13_1)

	var_13_0.go = var_13_1
	var_13_0.termitem = gohelper.findChild(var_13_1, "main/#go_termitem")
	var_13_0.levelname = gohelper.findChildText(var_13_1, "main/#go_termitem/#txt_levelname")
	var_13_0.content = gohelper.findChild(var_13_1, "main/#go_termitem/#scroll_term/Viewport/Content")
	var_13_0.termcontent = gohelper.findChild(var_13_1, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent")
	var_13_0.gotermnode = gohelper.findChild(var_13_1, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent/termnode")
	var_13_0.txtenemy = gohelper.findChildText(var_13_0.content, "topnode/enemy/txt")
	var_13_0.txtscoreadd = gohelper.findChildText(var_13_0.content, "topnode/scoreadd/txt")
	var_13_0.golevel = gohelper.findChild(var_13_1, "main/#go_level")
	var_13_0.difficulty = gohelper.findChildText(var_13_1, "main/#go_level/#txt_level")
	var_13_0._gouptitle = gohelper.findChild(var_13_1, "#go_uptitle")
	var_13_0._txtuptitle = gohelper.findChildText(var_13_1, "#go_uptitle/node/#txt_term")
	var_13_0._txtuplevel = gohelper.findChildText(var_13_1, "#go_uptitle/#txt_level")
	var_13_0._godowntitle = gohelper.findChild(var_13_1, "#go_downtitle")
	var_13_0._txtdowntitle = gohelper.findChildText(var_13_1, "#go_downtitle/node/#txt_term")
	var_13_0._txtdownlevel = gohelper.findChildText(var_13_1, "#go_downtitle/#txt_level")
	var_13_0.transform = var_13_1.transform

	gohelper.setActive(var_13_1, true)
	table.insert(arg_13_0._levelItemObjects, var_13_0)
end

function var_0_0._refreshItem(arg_14_0, arg_14_1)
	local var_14_0 = V1a6_CachotConfig.instance:getDifficultyConfig(arg_14_0._currentSelectLevel)
	local var_14_1 = arg_14_0._levelItemObjects[arg_14_0._selectIndex]

	arg_14_0:_refreshItemContent(var_14_1, var_14_0)

	local var_14_2 = arg_14_0._currentSelectLevel == 1
	local var_14_3 = arg_14_0._currentSelectLevel == arg_14_0._levelCount

	if arg_14_0._currentSelectLevel - 1 > 0 then
		local var_14_4 = V1a6_CachotConfig.instance:getDifficultyConfig(arg_14_0._currentSelectLevel - 1)

		var_14_1._txtuptitle.text = var_14_4.title
		var_14_1._txtuplevel.text = var_14_4.difficulty
	end

	if arg_14_0._currentSelectLevel + 1 <= arg_14_0._levelCount then
		local var_14_5 = V1a6_CachotConfig.instance:getDifficultyConfig(arg_14_0._currentSelectLevel + 1)

		var_14_1._txtdowntitle.text = var_14_5.title
		var_14_1._txtdownlevel.text = var_14_5.difficulty
	end

	gohelper.setActive(var_14_1._gouptitle, not var_14_2)
	gohelper.setActive(arg_14_0._btnup, not var_14_2)
	gohelper.setActive(var_14_1._godowntitle, not var_14_3)
	gohelper.setActive(arg_14_0._btndown, not var_14_3)

	arg_14_0._btndowncanvasGroup = gohelper.onceAddComponent(arg_14_0._btndown.gameObject, gohelper.Type_CanvasGroup)
	arg_14_0._godowntitlecanvasGroup = gohelper.onceAddComponent(var_14_1._godowntitle, gohelper.Type_CanvasGroup)
	arg_14_0._btndowncanvasGroup.alpha = not var_14_3 and not arg_14_0:_checkDifficultyUnlock(arg_14_0._currentSelectLevel + 1) and 0.3 or 1
	arg_14_0._godowntitlecanvasGroup.alpha = not var_14_3 and not arg_14_0:_checkDifficultyUnlock(arg_14_0._currentSelectLevel + 1) and 0.3 or 1

	if arg_14_0._lastSelectLevel then
		local var_14_6 = V1a6_CachotConfig.instance:getDifficultyConfig(arg_14_0._lastSelectLevel)
		local var_14_7

		if arg_14_1 then
			var_14_7 = arg_14_0._selectIndex == arg_14_0._selectIndex and 2 or 1
		else
			var_14_7 = arg_14_0._selectIndex == arg_14_0._selectIndex and 1 or 2
		end

		local var_14_8 = arg_14_0._levelItemObjects[var_14_7]

		arg_14_0:_refreshItemContent(var_14_8, var_14_6)
	end
end

function var_0_0._refreshItemContent(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1.co = arg_15_2
	arg_15_1.termco = {}

	table.insert(arg_15_1.termco, arg_15_2.initHeroCount)

	if not string.nilorempty(arg_15_2.effectDesc1) then
		table.insert(arg_15_1.termco, arg_15_2.effectDesc1)
	end

	if not string.nilorempty(arg_15_2.effectDesc2) then
		table.insert(arg_15_1.termco, arg_15_2.effectDesc2)
	end

	if not string.nilorempty(arg_15_2.effectDesc3) then
		table.insert(arg_15_1.termco, arg_15_2.effectDesc3)
	end

	arg_15_1.difficulty.text = arg_15_2.difficulty
	arg_15_1.levelname.text = arg_15_2.title
	arg_15_1.txtenemy.text = "Lv." .. arg_15_2.showDifficulty
	arg_15_1.txtscoreadd.text = formatLuaLang("cachotdifficulty_scoreadd", arg_15_2.scoreAdd / 10) .. "%"

	gohelper.CreateObjList(arg_15_0, arg_15_0._onItemShow, arg_15_1.termco, arg_15_1.termcontent, arg_15_1.gotermnode)
end

function var_0_0._onItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1.transform
	local var_16_1 = var_16_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_16_2 = var_16_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_16_3 = string.split(arg_16_2, "|")

	if arg_16_3 == 1 then
		var_16_1.text = luaLang("cachotdifficulty_originrole")
		var_16_2.text = var_16_3[1]
	else
		if string.nilorempty(var_16_3[2]) then
			gohelper.setActive(var_16_2.gameObject, false)
		else
			gohelper.setActive(var_16_2.gameObject, true)
		end

		var_16_1.text = var_16_3[1]
		var_16_2.text = var_16_3[2]
	end
end

function var_0_0._reallyRefreshView(arg_17_0)
	if arg_17_0._currentSelectLevel then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._levelItemObjects) do
			local var_17_0 = arg_17_0._currentSelectLevel == iter_17_0

			arg_17_0:_refreshItem(iter_17_1, var_17_0)
		end
	end
end

function var_0_0._checkDifficultyUnlock(arg_18_0, arg_18_1)
	if arg_18_1 <= #arg_18_0._unlockCoList then
		return true
	end

	return false
end

function var_0_0._playMaskAnimation(arg_19_0)
	if not arg_19_0.currentmask then
		return
	end

	local var_19_0

	if not arg_19_0.nextmask and arg_19_0.currentmask then
		local var_19_1 = "level" .. arg_19_0.currentmask

		arg_19_0._maskanimator:Update(0)
		arg_19_0._maskanimator:Play(var_19_1, 0, 0)
	elseif arg_19_0.currentmask and arg_19_0.nextmask then
		local var_19_2 = "level" .. arg_19_0.currentmask .. "to" .. arg_19_0.nextmask

		arg_19_0._maskanimator:Update(0)
		arg_19_0._maskanimator:Play(var_19_2, 0, 0)

		local var_19_3 = arg_19_0._maskanimator:GetCurrentAnimatorStateInfo(0).length

		TaskDispatcher.runDelay(arg_19_0._switchAnimFinish, arg_19_0, var_19_3)
	end
end

function var_0_0._switchAnimFinish(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._switchAnimFinish, arg_20_0)

	local var_20_0 = "level" .. arg_20_0.nextmask

	arg_20_0._maskanimator:Update(0)
	arg_20_0._maskanimator:Play(var_20_0, 0, 0)

	arg_20_0.currentmask = arg_20_0.nextmask
	arg_20_0.nextmask = nil
end

function var_0_0._getTargetMask(arg_21_0, arg_21_1)
	if arg_21_1 == 1 then
		return 1
	elseif arg_21_1 == 2 then
		return 2
	elseif arg_21_1 >= 3 then
		return 3
	end
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._switchAnimFinish, arg_22_0)
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0
