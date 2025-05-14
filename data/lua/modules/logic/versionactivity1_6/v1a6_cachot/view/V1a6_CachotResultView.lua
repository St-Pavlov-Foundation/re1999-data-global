module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultView", package.seeall)

local var_0_0 = class("V1a6_CachotResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_levelbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_result/left/#go_success")
	arg_1_0._txtending = gohelper.findChildText(arg_1_0.viewGO, "#go_result/left/#txt_ending")
	arg_1_0._gofailed = gohelper.findChild(arg_1_0.viewGO, "#go_result/left/#go_failed")
	arg_1_0._txtroom = gohelper.findChildText(arg_1_0.viewGO, "#go_result/left/#txt_room")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_result/left/#txt_level")
	arg_1_0._txtmode = gohelper.findChildText(arg_1_0.viewGO, "#go_result/left/#txt_mode")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#go_score")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "#go_result/right/#go_score/#txt_score")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_result/right/#scroll_view")
	arg_1_0._gomemberitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem")
	arg_1_0._txtmembernum = gohelper.findChildText(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/title/titlebg/txt/#txt_membernum")
	arg_1_0._gorolehead = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container/#go_rolehead")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._txtcollectionnum = gohelper.findChildText(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/title/titlebg/txt/#txt_collectionnum")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_collection")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_title")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_result/#simage_title/#txt_title")
	arg_1_0._simagecg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/left/#go_success/#simage_cg")
	arg_1_0._godoubletag = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#go_score/#go_doubletag")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_empty")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "#go_result/right/#go_score/#txt_max")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goHeroScrollContent = gohelper.findChild(arg_5_0.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_unfold)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = V1a6_CachotModel.instance:getRogueEndingInfo()
	local var_8_1 = var_8_0 and var_8_0._isFinish or false

	gohelper.setActive(arg_8_0._gosuccess, var_8_1)
	gohelper.setActive(arg_8_0._gofailed, not var_8_1)
	arg_8_0:refreshHeroGroup(var_8_0)
	arg_8_0:refreshChallengeInfo(var_8_0)
	arg_8_0:refreshCollections(var_8_0)
end

function var_0_0.refreshHeroGroup(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1._heros or {}

	table.sort(var_9_0, arg_9_0.heroListSortFunc)
	gohelper.CreateObjList(arg_9_0, arg_9_0._refreshSingleHero, var_9_0, arg_9_0._goHeroScrollContent, arg_9_0._gorolehead)

	arg_9_0._txtmembernum.text = var_9_0 and #var_9_0 or 0
end

function var_0_0.heroListSortFunc(arg_10_0, arg_10_1)
	return arg_10_1 < arg_10_0
end

function var_0_0._refreshSingleHero(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildImage(arg_11_1, "image_icon")
	local var_11_1 = HeroConfig.instance:getHeroCO(arg_11_2)

	if var_11_1 then
		local var_11_2 = FightConfig.instance:getSkinCO(var_11_1.skinId)

		gohelper.getSingleImage(var_11_0.gameObject):LoadImage(ResUrl.roomHeadIcon(var_11_2.retangleIcon))
	end
end

function var_0_0.refreshCollections(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 and arg_12_1._collections

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = gohelper.cloneInPlace(arg_12_0._gocollection, "collectionItem_" .. iter_12_0)

			gohelper.setActive(var_12_1, true)

			local var_12_2 = gohelper.findChildSingleImage(var_12_1, "simage_icon")
			local var_12_3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_12_1)

			if var_12_3 then
				var_12_2.curImageUrl = nil

				var_12_2:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_12_3.icon))
			end
		end
	end

	local var_12_4 = var_12_0 and #var_12_0 or 0

	gohelper.setActive(arg_12_0._goempty, var_12_4 <= 0)

	arg_12_0._txtcollectionnum.text = var_12_4
end

function var_0_0.refreshChallengeInfo(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0:refreshScoreInfo(arg_13_1._score, arg_13_1._doubleScore)
		arg_13_0:refreshRoomInfo(arg_13_1._roomNum, arg_13_1._roomId)
		arg_13_0:refreshDifficultyInfo(arg_13_1._difficulty)
		arg_13_0:refreshEndingInfo(arg_13_1._ending)
	end
end

function var_0_0.refreshScoreInfo(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or 0
	arg_14_2 = arg_14_2 or 0

	local var_14_0 = V1a6_CachotModel.instance:getRogueStateInfo()
	local var_14_1 = arg_14_0:checkScoreIsFull(var_14_0)
	local var_14_2 = arg_14_0:checkIsUnlockAllStage(var_14_0)
	local var_14_3 = ""

	if arg_14_2 > 0 then
		local var_14_4 = Mathf.Clamp(arg_14_1 - arg_14_2, 0, arg_14_1)

		var_14_3 = string.format("%s(+%s)", var_14_4, arg_14_2)
	else
		var_14_3 = var_14_1 and arg_14_1 <= 0 and "0(MAX)" or string.format("%s", arg_14_1)
	end

	gohelper.setActive(arg_14_0._godoubletag, arg_14_2 > 0)

	arg_14_0._txtscore.text = var_14_3

	arg_14_0:refreshMaxScoreTips(var_14_1, var_14_2)
end

function var_0_0.checkScoreIsFull(arg_15_0, arg_15_1)
	return (arg_15_1 and arg_15_1.scoreLimit or 0) <= (arg_15_1 and arg_15_1.totalScore or 0)
end

function var_0_0.checkIsUnlockAllStage(arg_16_0, arg_16_1)
	local var_16_0 = false

	if arg_16_1 then
		var_16_0 = not arg_16_1.nextStageSecond or tonumber(arg_16_1.nextStageSecond) < 0
	end

	return var_16_0
end

function var_0_0.refreshMaxScoreTips(arg_17_0, arg_17_1, arg_17_2)
	gohelper.setActive(arg_17_0._txtmax.gameObject, arg_17_1)

	if arg_17_1 then
		arg_17_0._txtmax.text = arg_17_2 and luaLang("v1a6_cachotresultview_unlockAndMax") or luaLang("v1a6_cachotresultview_lockAndMax")
	end
end

function var_0_0.refreshDifficultyInfo(arg_18_0, arg_18_1)
	local var_18_0 = lua_rogue_difficulty.configDict and lua_rogue_difficulty.configDict[arg_18_1]
	local var_18_1 = var_18_0 and var_18_0.title or ""
	local var_18_2 = {
		arg_18_1,
		var_18_1
	}

	arg_18_0._txtmode.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachotresultview_selectdifficult"), var_18_2)
end

function var_0_0.refreshRoomInfo(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = lua_rogue_room.configDict and lua_rogue_room.configDict[arg_19_2]

	arg_19_0._txtlevel.text = var_19_0 and var_19_0.name or ""
	arg_19_0._txtroom.text = formatLuaLang("v1a6_cachotresultview_roomNum", arg_19_1 or 0)
end

function var_0_0.refreshEndingInfo(arg_20_0, arg_20_1)
	local var_20_0 = lua_rogue_ending.configDict[arg_20_1]

	if var_20_0 then
		arg_20_0._txtending.text = tostring(var_20_0.title)

		arg_20_0._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(var_20_0.resultIcon))
	end

	gohelper.setActive(arg_20_0._txtending.gameObject, var_20_0 ~= nil)
end

function var_0_0.onClose(arg_21_0)
	V1a6_CachotModel.instance:clearRogueEndingInfo()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Cachot and GameSceneMgr.instance:getCurScene():getCurLevelId() ~= 90001 then
		ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
		V1a6_CachotController.instance:openV1a6_CachotMainView()
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
