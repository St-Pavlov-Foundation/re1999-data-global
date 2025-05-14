module("modules.logic.character.view.CharacterDataItemView", package.seeall)

local var_0_0 = class("CharacterDataItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_mask")
	arg_1_0._gopointercontainer = gohelper.findChild(arg_1_0.viewGO, "content/bottom/#go_pointcontainer")
	arg_1_0._gopointeritem = gohelper.findChild(arg_1_0.viewGO, "content/bottom/#go_pointcontainer/#go_pointitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onLeftPageClick(arg_4_0)
	if not arg_4_0.needShowPageBtn then
		return
	end

	if arg_4_0.skinIndex <= 1 then
		return
	end

	arg_4_0.skinIndex = arg_4_0.skinIndex - 1
	arg_4_0.skinId = arg_4_0.skinList[arg_4_0.skinIndex]

	arg_4_0.contentAnimator:Play("switch_left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function var_0_0.onRightPageClick(arg_5_0)
	if not arg_5_0.needShowPageBtn then
		return
	end

	if arg_5_0.skinIndex >= arg_5_0.skinLen then
		return
	end

	arg_5_0.skinIndex = arg_5_0.skinIndex + 1
	arg_5_0.skinId = arg_5_0.skinList[arg_5_0.skinIndex]

	arg_5_0.contentAnimator:Play("switch_right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function var_0_0.initItem(arg_6_0)
	arg_6_0.itemList = arg_6_0:getUserDataTb_()

	local var_6_0

	for iter_6_0 = 1, 3 do
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.itemGo = gohelper.findChild(arg_6_0.viewGO, "content/itembg" .. iter_6_0)
		var_6_1.animator = var_6_1.itemGo:GetComponent(typeof(UnityEngine.Animator))
		var_6_1.itemshow = gohelper.findChild(var_6_1.itemGo, "go_itemshow")
		var_6_1.itemlock = gohelper.findChild(var_6_1.itemGo, "go_itemlock")
		var_6_1.lockicon = gohelper.findChild(var_6_1.itemlock, "go_lockicon")
		var_6_1.unlocktxt = gohelper.findChildText(var_6_1.lockicon, "unlocktext")
		var_6_1.treasurego = gohelper.findChild(var_6_1.itemGo, "go_itemlock/go_treasure")
		var_6_1.goitemshow = gohelper.findChild(var_6_1.itemGo, "go_itemshow")
		var_6_1.title1 = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname1")
		var_6_1.title2 = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname2")
		var_6_1.titleen = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemnameen")
		var_6_1.text = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/descScroll/Viewport/descContent/itemtext")
		var_6_1.icon = gohelper.findChildSingleImage(var_6_1.itemGo, "go_itemshow/itemicon")
		var_6_1.goimageestimate = gohelper.findChild(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate")
		var_6_1.imageestimate = gohelper.findChildImage(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate/image_estimate")
		var_6_1.txtestimate = gohelper.findChildText(var_6_1.itemGo, "go_itemshow/itemtxtbg/estimate/txt_estimate")
		var_6_1.treasurebtn = gohelper.findChildButtonWithAudio(var_6_1.itemlock, "clickarea")

		var_6_1.treasurebtn:AddClickListener(arg_6_0._onTreasureBtnClick, arg_6_0, iter_6_0)
		table.insert(arg_6_0.itemList, var_6_1)
	end
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gopointeritem, false)

	arg_7_0.goContent = gohelper.findChild(arg_7_0.viewGO, "content")

	arg_7_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_7_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	arg_7_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_7_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_7_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_7_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_7_0:initItem()

	arg_7_0._effectsList = arg_7_0:getUserDataTb_()
	arg_7_0._dataList = {}

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_7_0._unlockItemCallbackFail, arg_7_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, arg_7_0._unlockItemCallback, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	gohelper.setActive(arg_9_0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)

	arg_9_0._heroId = CharacterDataModel.instance:getCurHeroId()
	arg_9_0.heroMo = HeroModel.instance:getByHeroId(arg_9_0._heroId)

	arg_9_0:initSkinInfo()
	arg_9_0:_statStart()
	arg_9_0:_refreshUI()
end

function var_0_0.sortSkin(arg_10_0, arg_10_1)
	return arg_10_0 < arg_10_1
end

function var_0_0.initSkinInfo(arg_11_0)
	local var_11_0 = arg_11_0.heroMo.skinInfoList
	local var_11_1 = CharacterDataConfig.instance:geCharacterSkinIdList(arg_11_0._heroId)

	arg_11_0.skinList = {
		CharacterDataConfig.DefaultSkinDataKey
	}

	local var_11_2 = CharacterDataConfig.instance:getDataConfig()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if tabletool.indexOf(var_11_1, iter_11_1.skin) then
			local var_11_3 = var_11_2[arg_11_0._heroId][iter_11_1.skin]

			if var_11_3 and var_11_3[CharacterEnum.CharacterDataItemType.Item] then
				table.insert(arg_11_0.skinList, iter_11_1.skin)
			end
		end
	end

	arg_11_0.skinId = arg_11_0.skinList[1]

	table.sort(arg_11_0.skinList, var_0_0.sortSkin)

	arg_11_0.skinIndex = 1
	arg_11_0.skinLen = #arg_11_0.skinList
	arg_11_0.needShowPageBtn = arg_11_0.skinLen > 1

	if arg_11_0.needShowPageBtn then
		arg_11_0.contentAnimator = arg_11_0.goContent:GetComponent(typeof(UnityEngine.Animator))
		arg_11_0.contentAnimatorEvent = arg_11_0.goContent:GetComponent(typeof(ZProj.AnimationEventWrap))

		arg_11_0.contentAnimatorEvent:AddEventListener("refresh", arg_11_0._refreshUI, arg_11_0)
	end

	arg_11_0:initPointItem()
	arg_11_0:initPageBtnItem()
end

function var_0_0.initPointItem(arg_12_0)
	if not arg_12_0.needShowPageBtn then
		return
	end

	arg_12_0.pointItemList = arg_12_0.pointItemList or arg_12_0:getUserDataTb_()

	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.skinList) do
		local var_12_1 = arg_12_0.pointItemList[iter_12_0]

		if not var_12_1 then
			var_12_1 = {
				go = gohelper.cloneInPlace(arg_12_0._gopointeritem, "point_" .. iter_12_0)
			}
			var_12_1.gonormalstar = gohelper.findChild(var_12_1.go, "#go_nomalstar")
			var_12_1.golightstar = gohelper.findChild(var_12_1.go, "#go_lightstar")
			var_12_1.click = gohelper.getClick(var_12_1.go)

			var_12_1.click:AddClickListener(arg_12_0.pointOnClick, arg_12_0, iter_12_0)
			table.insert(arg_12_0.pointItemList, var_12_1)
		end

		gohelper.setActive(var_12_1.go, true)
	end

	for iter_12_2 = #arg_12_0.skinList + 1, #arg_12_0.pointItemList do
		gohelper.setActive(arg_12_0.pointItemList[iter_12_2].go, false)
	end
end

function var_0_0.initPageBtnItem(arg_13_0)
	arg_13_0.btnLeftPage = gohelper.findChildClick(arg_13_0.viewGO, "content/#btn_leftpage")
	arg_13_0.btnRightPage = gohelper.findChildClick(arg_13_0.viewGO, "content/#btn_rightpage")

	if not arg_13_0.needShowPageBtn then
		return
	end

	arg_13_0.btnLeftPage:AddClickListener(arg_13_0.onLeftPageClick, arg_13_0)
	arg_13_0.btnRightPage:AddClickListener(arg_13_0.onRightPageClick, arg_13_0)
end

function var_0_0.pointOnClick(arg_14_0, arg_14_1)
	arg_14_0.skinIndex = arg_14_1
	arg_14_0.skinId = arg_14_0.skinList[arg_14_0.skinIndex]

	arg_14_0:_refreshUI()
end

function var_0_0.initDrag(arg_15_0)
	if #arg_15_0.skinList <= 1 then
		return
	end

	arg_15_0._itemDrag = SLFramework.UGUI.UIDragListener.Get(arg_15_0.goContent)

	arg_15_0._itemDrag:AddDragBeginListener(arg_15_0._onDragBegin, arg_15_0)
	arg_15_0._itemDrag:AddDragEndListener(arg_15_0._onDragEnd, arg_15_0)
end

function var_0_0._onDragBegin(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.startDragPosX = arg_16_2.position.x
end

function var_0_0._onDragEnd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.position.x

	if math.abs(var_17_0 - arg_17_0.startDragPosX) > 30 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

		if var_17_0 > arg_17_0.startDragPosX then
			arg_17_0.skinIndex = arg_17_0.skinIndex - 1

			if arg_17_0.skinIndex < 1 then
				arg_17_0.skinIndex = #arg_17_0.skinList
			end
		else
			arg_17_0.skinIndex = arg_17_0.skinIndex + 1

			if arg_17_0.skinIndex > #arg_17_0.skinList then
				arg_17_0.skinIndex = 1
			end
		end

		arg_17_0.skinId = arg_17_0.skinList[arg_17_0.skinIndex]

		arg_17_0:_refreshUI()
	end
end

function var_0_0._refreshUI(arg_18_0)
	arg_18_0:refreshItem()
	arg_18_0:refreshPointItem()
	arg_18_0:refreshPageBtn()
end

function var_0_0._unlockItemCallback(arg_19_0, arg_19_1, arg_19_2)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if arg_19_2 >= 2 and arg_19_2 <= 4 then
		arg_19_0.itemList[arg_19_2 - 1].treasurebtn:RemoveClickListener()

		arg_19_0._dataList[arg_19_2 - 1].isGetRewards = true
	end
end

function var_0_0._unlockItemCallbackFail(arg_20_0)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.updateTMPRectHeight_LayoutElement(arg_21_0)
	for iter_21_0 = 1, 3 do
		local var_21_0 = arg_21_0.itemList[iter_21_0]

		LuaUtil.updateTMPRectHeight_LayoutElement(var_21_0.text)
	end
end

function var_0_0.refreshItem(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.updateTMPRectHeight_LayoutElement, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0.updateTMPRectHeight_LayoutElement, arg_22_0, 2)

	local var_22_0
	local var_22_1
	local var_22_2
	local var_22_3
	local var_22_4
	local var_22_5
	local var_22_6
	local var_22_7

	for iter_22_0 = 1, 3 do
		local var_22_8 = arg_22_0.itemList[iter_22_0]
		local var_22_9 = arg_22_0._dataList[iter_22_0]

		if not var_22_9 then
			var_22_9 = {}
			arg_22_0._dataList[iter_22_0] = var_22_9
		end

		var_22_9.itemId = iter_22_0 + 1

		local var_22_10 = CharacterDataConfig.instance:getCharacterDataCO(arg_22_0._heroId, arg_22_0.skinId, CharacterEnum.CharacterDataItemType.Item, iter_22_0)
		local var_22_11 = CharacterDataConfig.instance:checkLockCondition(var_22_10)
		local var_22_12 = HeroModel.instance:checkGetRewards(arg_22_0._heroId, var_22_9.itemId)

		var_22_9.islock = var_22_11
		var_22_9.isGetRewards = var_22_12

		if var_22_11 then
			gohelper.setActive(var_22_8.itemshow, false)
			gohelper.setActive(var_22_8.itemlock, true)
			gohelper.setActive(var_22_8.lockicon, true)
			gohelper.setActive(var_22_8.treasurego, false)

			local var_22_13 = string.splitToNumber(var_22_10.unlockConditine, "#")
			local var_22_14 = {}

			if var_22_13[1] == CharacterDataConfig.unlockConditionEpisodeID then
				var_22_14 = {
					DungeonConfig.instance:getEpisodeCO(var_22_13[2]).name
				}
			elseif var_22_13[1] == CharacterDataConfig.unlockConditionRankID then
				var_22_14 = {
					var_22_13[2] - 1
				}
			else
				var_22_14 = {
					var_22_13[2]
				}
			end

			local var_22_15 = ToastConfig.instance:getToastCO(var_22_10.lockText).tips
			local var_22_16 = GameUtil.getSubPlaceholderLuaLang(var_22_15, var_22_14)

			var_22_8.unlocktxt.text = var_22_16
		else
			arg_22_0:_setItemTitlePos(var_22_8.title1, var_22_8.title2, var_22_8.titleen, var_22_10.title)

			var_22_8.titleen.text = var_22_10.titleEn
			var_22_8.text.text = LuaUtil.replaceSpace(var_22_10.text)

			arg_22_0:_refreshEstimate(var_22_8, var_22_10)
			var_22_8.icon:LoadImage(ResUrl.getCharacterDataPic(var_22_10.icon))

			if string.nilorempty(var_22_10.unlockRewards) then
				gohelper.setActive(var_22_8.itemshow, true)
				gohelper.setActive(var_22_8.itemlock, false)
			elseif var_22_12 then
				gohelper.setActive(var_22_8.itemshow, true)
				gohelper.setActive(var_22_8.itemlock, false)
			else
				arg_22_0:addAniEffect(var_22_8.goitemshow, var_22_9.itemId, arg_22_0._heroId)
				gohelper.setActive(var_22_8.itemshow, false)
				gohelper.setActive(var_22_8.itemlock, true)
				gohelper.setActive(var_22_8.lockicon, false)
				gohelper.setActive(var_22_8.treasurego, true)
				arg_22_0:checkAndCloneMaterialIfNeed(var_22_8.treasurego, iter_22_0)
			end
		end
	end
end

function var_0_0.checkAndCloneMaterialIfNeed(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._cloneMaterialMap and arg_23_0._cloneMaterialMap[arg_23_2] then
		return
	end

	arg_23_0._cloneMaterialMap = arg_23_0._cloneMaterialMap or {}
	arg_23_0._cloneMaterialMap[arg_23_2] = true

	local var_23_0 = gohelper.findChildImage(arg_23_1, "image")
	local var_23_1 = var_23_0.material

	var_23_0.material = UnityEngine.Object.Instantiate(var_23_1)

	local var_23_2 = var_23_0.gameObject:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	var_23_2.mas:Clear()
	var_23_2.mas:Add(var_23_0.material)
end

function var_0_0.refreshPointItem(arg_24_0)
	if not arg_24_0.pointItemList then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.pointItemList) do
		gohelper.setActive(iter_24_1.gonormalstar, iter_24_0 ~= arg_24_0.skinIndex)
		gohelper.setActive(iter_24_1.golightstar, iter_24_0 == arg_24_0.skinIndex)
	end
end

function var_0_0.refreshPageBtn(arg_25_0)
	if not arg_25_0.needShowPageBtn then
		gohelper.setActive(arg_25_0.btnLeftPage.gameObject, false)
		gohelper.setActive(arg_25_0.btnRightPage.gameObject, false)

		return
	end

	gohelper.setActive(arg_25_0.btnLeftPage.gameObject, arg_25_0.skinIndex ~= 1)
	gohelper.setActive(arg_25_0.btnRightPage.gameObject, arg_25_0.skinIndex ~= arg_25_0.skinLen)
end

function var_0_0._onTreasureBtnClick(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._dataList[arg_26_1]

	if var_26_0.islock then
		local var_26_1 = CharacterDataConfig.instance:getCharacterDataCO(arg_26_0._heroId, arg_26_0.heroMo.skin, CharacterEnum.CharacterDataItemType.Item, arg_26_1)
		local var_26_2 = string.splitToNumber(var_26_1.unlockConditine, "#")
		local var_26_3 = ""

		if var_26_2[1] == CharacterDataConfig.unlockConditionEpisodeID then
			var_26_3 = DungeonConfig.instance:getEpisodeCO(var_26_2[2]).name
		elseif var_26_2[1] == CharacterDataConfig.unlockConditionRankID then
			var_26_3 = var_26_2[2] - 1
		else
			var_26_3 = var_26_2[2]
		end

		GameFacade.showToast(var_26_1.lockText, var_26_3)
	elseif not var_26_0.isGetRewards then
		local var_26_4 = arg_26_0.itemList[arg_26_1]

		gohelper.setActive(var_26_4.itemshow, true)
		gohelper.setActive(var_26_4.itemlock, false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playRewardsAnimtion")
		arg_26_0:playAniEffect(var_26_0.itemId)
		var_26_4.animator:Play(UIAnimationName.Unlock)
		TaskDispatcher.runDelay(function()
			HeroRpc.instance:sendItemUnlockRequest(arg_26_0._heroId, var_26_0.itemId)
		end, nil, 2)
	end
end

function var_0_0._refreshEstimate(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.estimate

	if string.nilorempty(var_28_0) then
		gohelper.setActive(arg_28_1.goimageestimate.gameObject, false)

		arg_28_1.txtestimate.text = luaLang("notestimate")
	else
		gohelper.setActive(arg_28_1.goimageestimate.gameObject, true)

		local var_28_1 = string.split(var_28_0, "#")
		local var_28_2 = var_28_1[1]
		local var_28_3 = var_28_1[2]

		UISpriteSetMgr.instance:setUiCharacterSprite(arg_28_1.imageestimate, "fh" .. tostring(var_28_2))

		arg_28_1.txtestimate.text = string.format("%s", tostring(var_28_3))
	end
end

function var_0_0.addAniEffect(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = HeroModel.instance:getByHeroId(arg_29_3).itemUnlock

	if arg_29_0:checkItemIsLock(var_29_0, arg_29_2) and not arg_29_0._effectsList[arg_29_2] then
		arg_29_0._effectsList[arg_29_2] = arg_29_0:getUserDataTb_()

		local var_29_1 = arg_29_1:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

		if var_29_1 then
			local var_29_2 = var_29_1:GetEnumerator()

			while var_29_2:MoveNext() do
				if not gohelper.findChildTextMesh(var_29_2.Current.gameObject, "") then
					local var_29_3 = UIEffectManager.instance:getUIEffect(var_29_2.Current.gameObject, typeof(Coffee.UIEffects.UIDissolve))

					table.insert(arg_29_0._effectsList[arg_29_2], var_29_3)
				end
			end
		end

		for iter_29_0, iter_29_1 in ipairs(arg_29_0._effectsList[arg_29_2]) do
			iter_29_1.width = 0.2
			iter_29_1.softness = 1
			iter_29_1.color = "#956C4B"
			iter_29_1.effectFactor = 0
		end
	end
end

function var_0_0.playAniEffect(arg_30_0, arg_30_1)
	if not arg_30_0._effectsList[arg_30_1] then
		return
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._effectsList[arg_30_1]) do
		iter_30_1.effectFactor = 1
	end

	arg_30_0._tweenIds = arg_30_0._tweenIds or {}

	if arg_30_0._tweenIds[arg_30_1] then
		ZProj.TweenHelper.KillById(arg_30_0._tweenIds[arg_30_1])

		arg_30_0._tweenIds[arg_30_1] = nil
	end

	local var_30_0 = ZProj.TweenHelper.DOTweenFloat(0, 2.85, 2.85, function(arg_31_0)
		if arg_31_0 >= 0.35 then
			local var_31_0 = arg_30_0._effectsList[arg_30_1]

			if not var_31_0 then
				return
			end

			for iter_31_0, iter_31_1 in ipairs(var_31_0) do
				iter_31_1.effectFactor = 1 - (arg_31_0 - 0.35) / 2.5
			end
		end
	end)

	arg_30_0._tweenIds[arg_30_1] = var_30_0
end

function var_0_0.checkItemIsLock(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1 == arg_32_2 then
			return false
		end
	end

	return true
end

function var_0_0._statStart(arg_33_0)
	arg_33_0._viewTime = ServerTime.now()
end

function var_0_0._statEnd(arg_34_0)
	if not arg_34_0._heroId then
		return
	end

	if arg_34_0._viewTime then
		local var_34_0 = ServerTime.now() - arg_34_0._viewTime
		local var_34_1 = arg_34_0.viewParam and type(arg_34_0.viewParam) == "table" and arg_34_0.viewParam.fromHandbookView

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroItem, arg_34_0._heroId, nil, var_34_0, var_34_1)
	end

	arg_34_0._viewTime = nil
end

function var_0_0._setItemTitlePos(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = not string.nilorempty(arg_35_4) and string.split(arg_35_4, "\n") or {}
	local var_35_1 = -1.18
	local var_35_2 = 0
	local var_35_3 = -23.2
	local var_35_4 = 13.2
	local var_35_5 = -35
	local var_35_6 = -8

	if LangSettings.instance:getCurLangShortcut() == "zh" then
		if GameUtil.getTabLen(var_35_0) > 1 then
			local var_35_7 = {
				-21.7,
				-21.7,
				-24.8,
				-24.8
			}
			local var_35_8 = {
				62.1,
				52.221,
				60.6,
				46.9
			}
			local var_35_9 = {
				-52.32,
				-81.1,
				-73.4,
				-73.4
			}
			local var_35_10 = GameUtil.utf8len(GameUtil.trimInput(arg_35_4))
			local var_35_11 = var_35_10 - 6 <= 4 and var_35_10 - 6 or 4

			var_35_1 = var_35_7[var_35_11]
			var_35_3 = var_35_9[var_35_11]
			var_35_4 = 35
			var_35_5 = -47.03
			var_35_2 = var_35_8[var_35_11]
			arg_35_2.text = var_35_0[2]
		else
			arg_35_2.text = ""
		end
	elseif GameUtil.getTabLen(var_35_0) > 1 then
		var_35_1 = 0
		var_35_2 = 0
		var_35_3 = 0
		var_35_4 = 10
		var_35_6 = -30
		var_35_5 = -47.03
		arg_35_2.text = var_35_0[2]
	else
		var_35_1 = 0
		var_35_4 = -10
		arg_35_2.text = ""
	end

	arg_35_1.text = var_35_0[1]

	recthelper.setAnchor(arg_35_1.transform, var_35_1, var_35_4)
	recthelper.setAnchor(arg_35_2.transform, var_35_2, var_35_6)
	recthelper.setAnchor(arg_35_3.transform, var_35_3, var_35_5)
end

function var_0_0.onClose(arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.updateTMPRectHeight_LayoutElement, arg_36_0)
	gohelper.setActive(arg_36_0.viewGO, false)
	arg_36_0:_statEnd()
end

function var_0_0.onDestroyView(arg_37_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, arg_37_0._unlockItemCallbackFail, arg_37_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, arg_37_0._unlockItemCallback, arg_37_0)

	if arg_37_0._itemDrag then
		arg_37_0._itemDrag:RemoveDragBeginListener()
		arg_37_0._itemDrag:RemoveDragEndListener()
	end

	arg_37_0._simagebg:UnLoadImage()
	arg_37_0._simagecentericon:UnLoadImage()
	arg_37_0._simagelefticon:UnLoadImage()
	arg_37_0._simagerighticon:UnLoadImage()
	arg_37_0._simagerighticon2:UnLoadImage()
	arg_37_0._simagemask:UnLoadImage()

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.itemList) do
		iter_37_1.icon:UnLoadImage()
		iter_37_1.treasurebtn:RemoveClickListener()
	end

	if arg_37_0.pointItemList then
		for iter_37_2, iter_37_3 in ipairs(arg_37_0.pointItemList) do
			iter_37_3.click:RemoveClickListener()
		end
	end

	if arg_37_0._tweenIds then
		for iter_37_4, iter_37_5 in pairs(arg_37_0._tweenIds) do
			ZProj.TweenHelper.KillById(iter_37_5)
		end

		arg_37_0._tweenIds = nil
	end

	if arg_37_0.needShowPageBtn then
		arg_37_0.btnLeftPage:RemoveClickListener()
		arg_37_0.btnRightPage:RemoveClickListener()
		arg_37_0.contentAnimatorEvent:RemoveAllEventListener()
	end
end

return var_0_0
